delete from emrs_d_provider p
where provider_id > (select min(provider_id)
                     from emrs_d_provider p1
                     where p.provider_number = p1.provider_number
                     and p.version= p1.version
                     and p.date_of_validity_start = p1.date_of_validity_start
                     and trunc(p.date_of_validity_end) = trunc(p1.date_of_validity_end)
                     and p.current_flag = p1.current_flag);
                     
update emrs_d_provider
set date_of_validity_start = TRUNC(date_created)
WHERE date_of_validity_start > TRUNC(sysdate);

UPDATE emrs_d_client_plan_enrl_status
SET version = 4
WHERE client_enroll_status_id = 23855754;

UPDATE emrs_d_client_plan_enrl_status
SET version = 5
WHERE client_enroll_status_id = 23911725;

UPDATE emrs_d_client_plan_enrl_status
SET version = 6
WHERE client_enroll_status_id = 23911864;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = date_of_validity_start, current_flag = 'N'
WHERE client_enroll_status_id = 23912432;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = TO_DATE('12/31/2050','mm/dd/yyyy'), current_flag = 'Y',version = 10
WHERE client_enroll_status_id = 23912476;

COMMIT;