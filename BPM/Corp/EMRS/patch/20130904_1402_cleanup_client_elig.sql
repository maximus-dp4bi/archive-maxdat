UPDATE emrs_d_client_plan_eligibility
SET date_of_validity_end = TO_DATE('08/29/2013','mm/dd/yyyy')
WHERE client_plan_eligibility_id IN(61199057,61199051);

UPDATE emrs_d_client_plan_eligibility
SET date_of_validity_end = TO_DATE('08/31/2013','mm/dd/yyyy'), current_flag = 'N'
WHERE client_plan_eligibility_id IN(61527765,61527762);

BEGIN
  FOR s IN(SELECT upd_client_enroll_status_id
	            ,MIN(date_of_validity_start) date_of_validity_end              
            FROM emrs_s_client_status_stg s
            WHERE upd_client_enroll_status_id IN(23911058,
            23910638,
            24274612,
            23907978,
            24275374,
            24274648,
            24275177,
            23911034,
            23910888,
            24275191,
            23907492,
            24274271,
            23910731,
            24274394,
            24274915,
            23910816,
            23911311,
            24274458,
            23907499,
            23907196,
            23911480,
            23908001,
            23911301, 
            23907355,
            24274897)
        AND client_enroll_status_id IS NULL
        GROUP BY upd_client_enroll_status_id)
   LOOP
      UPDATE emrs_d_client_plan_enrl_status
      SET current_flag = 'N', date_of_validity_end = s.date_of_validity_end
      WHERE client_enroll_status_id = s.upd_client_enroll_status_id;
   END LOOP;
END;
/
COMMIT;

DECLARE
 CURSOR client_cur IS
   select distinct client_number, sub_program_id
   from emrs_d_client_plan_eligibility
   where trunc(date_updated) = to_date('08/30/2013','mm/dd/yyyy');
   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;     
BEGIN
   OPEN client_cur;
   LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows

     FOR indx IN 1 .. clnt_tab.COUNT LOOP     
       FOR s IN(SELECT sub_program_id
                FROM emrs_d_sub_program
                WHERE sub_program_id != 0
                ORDER BY sub_program_id)
       LOOP          
        FOR e IN(SELECT client_plan_eligibility_id, rownum row_num
               FROM(
               SELECT client_plan_eligibility_id       
               FROM emrs_d_client_plan_eligibility
               WHERE client_number = clnt_tab(indx).client_number
               AND sub_program_id = s.sub_program_id
               ORDER BY date_of_validity_start,source_record_id))
        LOOP
          UPDATE emrs_d_client_plan_eligibility
          SET version = e.row_num
          WHERE client_plan_eligibility_id = e.client_plan_eligibility_id;         
        END LOOP;       
       END LOOP;      
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
END;
/

DECLARE
 CURSOR client_cur IS
  select client_number,plan_type_id,sub_program_id,max(version) max_version 
  from emrs_d_client_plan_eligibility s1
  where TRUNC(s1.date_of_validity_end) <= TRUNC(sysdate)
  and not exists(select 1 from emrs_d_client_plan_eligibility s2 
               where s1.client_number = s2.client_number 
               and s1.plan_type_id = s2.plan_type_id 
               and s1.sub_program_id = s2.sub_program_id
               and TRUNC(s2.date_of_validity_end) = to_date('12/31/2050','mm/dd/yyyy'))
  group by client_number,plan_type_id,sub_program_id;
   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;     
BEGIN
   OPEN client_cur;
   LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows

     FOR indx IN 1 .. clnt_tab.COUNT LOOP     
       UPDATE emrs_d_client_plan_eligibility
       SET current_flag = 'Y', date_of_validity_end = TO_DATE('12/31/2050','mm/dd/yyyy')
       WHERE client_number = clnt_tab(indx).client_number
       AND sub_program_id = clnt_tab(indx).sub_program_id
       AND version = clnt_tab(indx).max_version;
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
END;
/
COMMIT;