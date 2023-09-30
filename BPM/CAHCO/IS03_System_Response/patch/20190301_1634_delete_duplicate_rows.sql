delete from TS_SYSTEM_RESPONSE s
where trunc(test_datetime) between to_date('02/07/2019','mm/dd/yyyy') and to_date('02/15/2019','mm/dd/yyyy')
and last_update_date = (select max(last_update_date)
                        from TS_SYSTEM_RESPONSE t
                        where s.cube_location = t.cube_location
                        and s.trans_num = t.trans_num
                        and s.system_response_time = t.system_response_time
                        and s.test_datetime = t.test_datetime); 
                        
commit;