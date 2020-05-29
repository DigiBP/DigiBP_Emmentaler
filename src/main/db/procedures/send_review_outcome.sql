create or replace procedure send_review_outcome(proposalId IN number, review_status IN varchar2) is

  l_body clob := '';
  l_clob clob := '';

begin

  apex_web_service.g_request_headers.delete();
  apex_web_service.g_request_headers(1).name := 'Content-Type';  
  apex_web_service.g_request_headers(1).value := 'application/json';
      
  APEX_JSON.initialize_clob_output;


  apex_json.open_object; -- {
  apex_json.write('resultEnabled', true);     
  apex_json.write('messageName', 'ReceiveReviewOutcome');   
  apex_json.write('businessKey', 'proposalProcessAPEX'); 
  apex_json.open_object('processVariables'); -- "processVariables": {
  apex_json.open_object('complete'); -- "complete": {
  apex_json.write('value', review_status);   
  apex_json.write('type', 'String');   
  apex_json.close_all; -- }}

  l_body := APEX_JSON.get_clob_output;
  APEX_JSON.free_output;
      
 
  l_clob := apex_web_service.make_rest_request(
              p_url => 'https://emmentaler.herokuapp.com/rest/message',
              p_http_method => 'POST',
              p_body => l_body
  );
  print_clob_to_output (l_clob); 
  
      
    
end send_review_outcome;
