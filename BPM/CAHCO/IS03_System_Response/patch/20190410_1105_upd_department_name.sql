
update TS_SYSTEM_RESPONSE
set department_name = 'Forms'
where cube_location = 142
and test_datetime = to_date('03/14/2019 09:01:00','mm/dd/yyyy hh24:mi:ss')
and trim(department_name) = 'Call Center';

update TS_SYSTEM_RESPONSE
set department_name = 'Forms'
where cube_location = 138
and test_datetime = to_date('03/22/2019 11:01:00','mm/dd/yyyy hh24:mi:ss')
and trim(department_name) = 'Call Center'; 

update TS_SYSTEM_RESPONSE
set department_name = 'Research'
where cube_location = 121
and test_datetime = to_date('03/29/2019 11:29:00','mm/dd/yyyy hh24:mi:ss')
and trim(department_name) = 'Call Center'; 

update TS_SYSTEM_RESPONSE
set department_name = 'Call Center'
where cube_location = 279
and test_datetime = to_date('03/29/2019 09:03:00','mm/dd/yyyy hh24:mi:ss')
and trim(department_name) = 'Research'; 

commit;