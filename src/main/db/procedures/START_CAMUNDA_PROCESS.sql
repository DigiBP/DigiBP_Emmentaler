create or replace procedure start_camunda_process(proposalId IN number) is

  l_body clob := '';
  l_clob clob := '';

begin

  apex_web_service.g_request_headers.delete();
  apex_web_service.g_request_headers(1).name := 'Content-Type';  
  apex_web_service.g_request_headers(1).value := 'application/json';
      
  APEX_JSON.initialize_clob_output;

  apex_json.open_object; -- {
  apex_json.write('businessKey', 'proposalProcessAPEX'); 
  apex_json.close_all; -- }}

  l_body := APEX_JSON.get_clob_output;
  APEX_JSON.free_output;
      
 
  l_clob := apex_web_service.make_rest_request(
              p_url => 'https://emmentaler.herokuapp.com/rest/process-definition/digibp-tobe:2:dfaedcba-9de2-11ea-9c51-da029e11a7df/start',
              p_http_method => 'POST',
              p_body => l_body
  );
  print_clob_to_output (l_clob); 
  
  
  -- {"links":[{"method":"GET","href":"https://emmentaler.herokuapp.com/rest/process-instance/23c47805-9e4d-11ea-9fe5-3e17a72f504f","rel":"self"}],"id":"23c47805-9e4d-11ea-9fe5-3e17a72f504f","definitionId":"digibp-tobe:2:dfaedcba-9de2-11ea-9c51-da029e11a7df","
  -- businessKey":"proposalProcessAPEX","caseInstanceId":null,"ended":false,"suspended":false,"tenantId":null}

  

  update antrag set instance_information = l_clob where id = proposalId;
  commit;
  
  update antrag set   camunda_instance = json_value(instance_information, '$.id' returning VARCHAR2) where id = proposalId;
  commit;
  
   
  
end start_camunda_process;
