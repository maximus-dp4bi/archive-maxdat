declare
v_message varchar2(200);
v_error_date date := sysdate;
v_name varchar2(25) := 'UPD_DestinationTransfer';

begin
  for cpss_cur in (select ivr_response_id, destination_transfer, skillset, application_name, call_date
from CISCO_ENTERPRISE_CC.cc_s_ivr_response
WHERE SKILLSET is not null
AND application_name = 'MAXMIPSS'
and call_date >= to_date('04-01-2020','mm-dd-yyyy') 
and call_date < to_date('07-08-2020', 'mm-dd-yyyy')
)
loop
  v_message := 'Updated DestinationTransfer MAXMIPSS: '|| to_char(cpss_cur.ivr_response_id) || ';' || to_char(cpss_cur.skillset) || ';' || nvl(to_char(cpss_cur.destination_transfer),' ');
  
  insert into cc_l_error(message, job_name, error_date, transform_name) values (v_message, v_name, v_error_date,to_char(cpss_cur.ivr_response_id));

  UPDATE CISCO_ENTERPRISE_CC.cc_s_ivr_response
  SET DESTINATION_TRANSFER = cpss_cur.skillset, skillset = null
  where ivr_response_id = cpss_cur.ivr_response_id;
  

/*
SQL to validate
select * from cc_s_ivr_response where ivr_response_id in (
select transform_name from cc_l_error where job_name = 'UPD_DestinationTransfer'
)

select ivr_response_id, destination_transfer, skillset, application_name, call_date
from CISCO_ENTERPRISE_CC.cc_s_ivr_response
WHERE SKILLSET is not null
AND application_name = 'MAXMIPSS'
and call_date >= to_date('04-01-2020','mm-dd-yyyy') 
and call_date < to_date('07-08-2020', 'mm-dd-yyyy')

*/

commit;
end loop;
end;

