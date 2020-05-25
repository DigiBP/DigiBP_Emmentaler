create or replace procedure start_camunda_process is

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
  
end start_camunda_process;
