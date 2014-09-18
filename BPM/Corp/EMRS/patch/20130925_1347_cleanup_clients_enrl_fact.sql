DECLARE
 CURSOR enrl_cur IS
   SELECT *
   FROM emrs_f_enrollment
   WHERE plan_id = 0;
   
   TYPE t_enrl_tab IS TABLE OF enrl_cur%ROWTYPE INDEX BY PLS_INTEGER;
    enrl_tab t_enrl_tab;
    v_bulk_limit NUMBER := 5000; 
    v_plan_id NUMBER;
BEGIN
   OPEN enrl_cur;
   LOOP
     FETCH enrl_cur BULK COLLECT INTO enrl_tab LIMIT v_bulk_limit;
     EXIT WHEN enrl_tab.COUNT = 0; -- Exit when missing rows

     FOR indx IN 1 .. enrl_tab.COUNT LOOP
       v_plan_id := enrl_tab(indx).plan_id;
       
       FOR pl IN(SELECT plan_id
                 FROM emrs_d_plan p, emrs_s_enrollment_stg_backup b
                 WHERE p.plan_code = b.source_plan_code
                 and p.csda = '0'
                 AND b.source_selection_record_id = enrl_tab(indx).source_record_id)
       LOOP
         v_plan_id := pl.plan_id;
       END LOOP;
      
       UPDATE emrs_f_enrollment
       SET plan_id = v_plan_id
       WHERE enrollment_id = enrl_tab(indx).enrollment_id;
      
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
END;
/

DELETE FROM emrs_f_enrollment
WHERE source_record_id IN (14600953,14600958)
AND enrollment_action_status_id = 653;

DELETE FROM emrs_f_enrollment
WHERE enrollment_id IN(45097474,45114165,45050146,45113054);


begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'ENABLED' AND constraint_name LIKE '%CLIENT%') LOOP
execute immediate 'alter table '||i.table_name||' disable constraint '||i.constraint_name||'';
end loop;
end;
/
truncate table emrs_d_client;

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'DISABLED' AND constraint_name LIKE '%CLIENT%') LOOP
execute immediate 'alter table '||i.table_name||' enable constraint '||i.constraint_name||'';
end loop;
end;
/

UPDATE emrs_d_client
SET date_of_validity_start = TRUNC(record_date)    
    ,date_of_validity_end =  TRUNC(record_date)
WHERE date_of_validity_start > sysdate
AND current_flag = 'N';

UPDATE emrs_d_client
SET date_of_validity_start = TRUNC(record_date)        
WHERE date_of_validity_start > sysdate
AND current_flag = 'Y';

UPDATE emrs_d_client c1
SET date_of_validity_end = to_date('12/31/2050','mm/dd/yyyy')
    ,current_flag = 'Y'
    ,current_client_id = client_id
WHERE date_of_validity_end < to_date('12/31/2050','mm/dd/yyyy')
AND NOT EXISTS(SELECT 1 
	       FROM emrs_d_client c2 
               WHERE c1.client_number = c2.client_number
               AND trunc(c2.date_of_validity_end) = to_date('12/31/2050','mm/dd/yyyy'));

COMMIT;