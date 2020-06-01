create or replace procedure start_camunda_process(proposalId IN number, budget IN number, category IN VARCHAR2, username IN VARCHAR2 ) is

  l_body clob := '';
  l_clob clob := '';
  l_email VARCHAR2(240);
  
begin

  l_email := APEX_UTIL.GET_EMAIL(p_username => username);


  apex_web_service.g_request_headers.delete();
  apex_web_service.g_request_headers(1).name := 'Content-Type';  
  apex_web_service.g_request_headers(1).value := 'application/json';
      
  APEX_JSON.initialize_clob_output;


  apex_json.open_object; -- {
  apex_json.write('businessKey', 'proposalProcessAPEX'); 
  apex_json.open_object('variables'); -- "variables": {
  apex_json.open_object('requester'); -- "requester" : {
  apex_json.write('value', l_email);   
  apex_json.write('type', 'String'); 
  APEX_JSON.CLOSE_OBJECT ();
  apex_json.open_object('budget'); -- "budget" : {
  apex_json.write('value', budget);   
  apex_json.write('type', 'Integer'); 
  APEX_JSON.CLOSE_OBJECT ();
  apex_json.open_object('category'); -- "category" : {
  apex_json.write('value', category);   
  apex_json.write('type', 'String'); 
  APEX_JSON.CLOSE_OBJECT ();
  apex_json.open_object('proposalId'); -- "proposalId" : {
  apex_json.write('value', proposalId);   
  apex_json.write('type', 'Integer'); 
  apex_json.close_all; -- }}

  l_body := APEX_JSON.get_clob_output;
  APEX_JSON.free_output;
      
 
  l_clob := apex_web_service.make_rest_request(
              p_url => 'https://emmentaler.herokuapp.com/rest/process-definition/digibp-tobe:1:5fd1940f-a40a-11ea-b8c5-3262e10564e6/start',
              p_http_method => 'POST',
              p_body => l_body
  );
  print_clob_to_output (l_clob); 
  
    
  -- {"links":[{"method":"GET","href":"https://emmentaler.herokuapp.com/rest/process-instance/23c47805-9e4d-11ea-9fe5-3e17a72f504f","rel":"self"}],"id":"23c47805-9e4d-11ea-9fe5-3e17a72f504f","definitionId":"digibp-tobe:2:dfaedcba-9de2-11ea-9c51-da029e11a7df","
  -- businessKey":"proposalProcessAPEX","caseInstanceId":null,"ended":false,"suspended":false,"tenantId":null}

  
  insert into antrag_camunda (CAMUNDA_BODY,ANTRAG_ID) values (l_clob, proposalId );
  
  update antrag_camunda set  INSTANCE_INFORMATION = json_value(instance_information, '$.id' returning VARCHAR2) where antrag_id = proposalId;
 
  
end start_camunda_process;
