DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id = 86924;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 86653
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id = 86692
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 86660
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id = 87265
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 86670
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id = 86697

;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 86658
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id = 86894
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 86627
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id = 87073
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 87072
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id = 87080
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 87076
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id = 86696
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 86652
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id = 86673
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 86650
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id = 86827
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 86634
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id = 86886
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 86631
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id = 86678
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 86640
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/


DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id = 86679
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 86642
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id IN(86636,87353)
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 86635
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id IN(86687,87263)
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 86625
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id IN(86644,87363)
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 86643
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select client_enroll_status_id from emrs_d_client_plan_enrl_status
   where plan_type_id in(select plan_type_id from emrs_d_plan_type where managed_care_program = 'MEDICAID')
   and enrollment_status_id = 86695
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update emrs_d_client_plan_enrl_status
           set enrollment_status_id = 86648
		     where client_enroll_status_id = temp_tab(indx).client_enroll_status_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

update emrs_d_client_plan_enrl_status
set enrollment_status_id = 86687
where enrollment_status_id = 87263;

update emrs_d_client_plan_enrl_status
set enrollment_status_id = 86636
where enrollment_status_id = 87353;

update emrs_d_client_plan_enrl_status
set enrollment_status_id = 86644
where enrollment_status_id = 87363;

update emrs_d_client_plan_enrl_status
set enrollment_status_id = 86646
where enrollment_status_id = 87337;

commit;