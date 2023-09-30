DECLARE  
  CURSOR temp_cur IS
select selection_transaction_id,current_selection_status_id, st.selection_status_code, st.managed_care_program
    ,(select selection_status_id from emrs_d_selection_status st_med where st_med.selection_status_code = st.selection_status_code and st_med.managed_care_program = 'MEDICAID') med_sel_status_id   
from emrs_d_selection_transaction s, emrs_d_selection_status st
where s.current_selection_status_id = st.selection_status_id
and program_type_cd = 'MEDICAID'
and st.managed_care_program = 'CHIP';
   
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
         update emrs_d_selection_transaction
           set current_selection_status_id = temp_tab(indx).med_sel_status_id
		     where selection_transaction_id = temp_tab(indx).selection_transaction_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
select selection_transaction_id,current_selection_status_id, st.selection_status_code, st.managed_care_program
     ,CASE WHEN st.selection_status_code = 'acceptedByState' THEN 86756
          WHEN st.selection_status_code = 'void' THEN 86677
          WHEN st.selection_status_code = 'pendToRecycle' THEN 86746
          WHEN st.selection_status_code = 'invalid' THEN 86770
          WHEN st.selection_status_code = 'readyToUpload' THEN 86811
      ELSE null END chip_sel_status_id
from emrs_d_selection_transaction s, emrs_d_selection_status st
where s.current_selection_status_id = st.selection_status_id
and program_type_cd = 'CHIP'
and st.managed_care_program = 'MEDICAID';
   
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
         update emrs_d_selection_transaction
           set current_selection_status_id = temp_tab(indx).chip_sel_status_id
		     where selection_transaction_id = temp_tab(indx).selection_transaction_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

UPDATE emrs_d_selection_transaction
SET current_selection_status_id = 86643
WHERE current_selection_status_id IN(86787,86747,86757);

UPDATE emrs_d_selection_transaction
SET current_selection_status_id = 86786
WHERE current_selection_status_id = 86725;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86770
WHERE current_selection_status_id = 86758;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86777
WHERE current_selection_status_id = 86741;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86773
WHERE current_selection_status_id = 86739;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86675
WHERE current_selection_status_id IN(86811,86807);

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86677  
WHERE current_selection_status_id = 86780;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86769
WHERE current_selection_status_id IN(86667,86751,86761);

DECLARE  
  CURSOR temp_cur IS
   select s.selection_transaction_id
   from emrs_d_selection_transaction s
   where current_selection_status_id IN(86735,86745)
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
         update emrs_d_selection_transaction
           set current_selection_status_id = 86756
		     where selection_transaction_id = temp_tab(indx).selection_transaction_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

--Fix Medicaid sel transactions

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86792
WHERE current_selection_status_id = 86868;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86633
WHERE current_selection_status_id = 86870;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86634
WHERE current_selection_status_id = 86871;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86642
WHERE current_selection_status_id = 86875;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86645
WHERE current_selection_status_id = 86876;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86652
WHERE current_selection_status_id = 86880;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86647
WHERE current_selection_status_id = 86877;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86649
WHERE current_selection_status_id = 86878;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86657
WHERE current_selection_status_id = 86884;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86799
WHERE current_selection_status_id = 86974;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86803
WHERE current_selection_status_id IN(86889,86976);

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86805
WHERE current_selection_status_id = 86979;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86662
WHERE current_selection_status_id = 86980;

UPDATE emrs_d_selection_transaction
SET current_selection_status_id =86665
WHERE current_selection_status_id IN(86981,86894);

UPDATE emrs_d_selection_transaction
SET current_selection_status_id = 86796
WHERE current_selection_status_id = 86885
;

COMMIT;

-- Fix sel transaction history

DECLARE  
  CURSOR temp_cur IS
select  h.selection_status_id, st.selection_status_code, st.managed_care_program, selection_trans_history_id
       ,CASE WHEN st.selection_status_code = 'acceptedByState' THEN 86756
          WHEN st.selection_status_code = 'void' THEN 86677
          WHEN st.selection_status_code = 'pendToRecycle' THEN 86746
          WHEN st.selection_status_code = 'invalid' THEN 86770
          WHEN st.selection_status_code = 'readyToUpload' THEN 86675
      ELSE null END chip_sel_status_id
from emrs_d_selection_transaction s, emrs_d_selection_trans_history h, emrs_d_selection_status st
where s.selection_Transaction_id = h.selection_transaction_id
and h.selection_status_id = st.selection_status_id
and program_type_cd = 'CHIP'
and st.managed_care_program = 'MEDICAID'
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
         update emrs_d_selection_trans_history
         set selection_status_id = temp_tab(indx).chip_sel_status_id
		     where selection_trans_history_id = temp_tab(indx).selection_trans_history_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
select  st.selection_status_code, st.managed_care_program, selection_trans_history_id
       ,CASE WHEN st.selection_status_code = 'acceptedByBEQ' THEN 86823
          WHEN st.selection_status_code = 'acceptedByCMS' THEN 86792
          WHEN st.selection_status_code = 'acceptedByState' THEN 86633
          WHEN st.selection_status_code = 'denied' THEN 86634
          WHEN st.selection_status_code = 'disregarded' THEN 86642
          WHEN st.selection_status_code = 'invalid' THEN 86645
          WHEN st.selection_status_code = 'pendingEligibility' THEN 86652
          WHEN st.selection_status_code = 'pendingExpansion' THEN 86749
          WHEN st.selection_status_code = 'pendingStarHClose' THEN 86674
          WHEN st.selection_status_code = 'pendToRecycle' THEN 86647
          WHEN st.selection_status_code = 'pendToRecycleVoid' THEN 86649
          WHEN st.selection_status_code = 'readyToUpload' THEN 86657
          WHEN st.selection_status_code = 'readyToUploadToCMS' THEN 86796
          WHEN st.selection_status_code = 'rejected' THEN 86658
          WHEN st.selection_status_code = 'rejectedByCMS' THEN 86799
          WHEN st.selection_status_code = 'terminated' THEN 86803
          WHEN st.selection_status_code = 'uploadAttemptFailed' THEN 86661
          WHEN st.selection_status_code = 'uploadedToCMS' THEN 86805
          WHEN st.selection_status_code = 'uploadedToBEQ' THEN 86827
          WHEN st.selection_status_code = 'uploadedToState' THEN 86662
          WHEN st.selection_status_code = 'void' THEN 86665
          WHEN st.selection_status_code = 'voidLostEligibility' THEN 86666
      ELSE null END med_sel_status_id
from emrs_d_selection_transaction s, emrs_d_selection_trans_history h, emrs_d_selection_status st
where s.selection_Transaction_id = h.selection_transaction_id
and h.selection_status_id = st.selection_status_id
and program_type_cd = 'MEDICAID'
and st.managed_care_program = 'CHIP'
--and st.selection_status_code = 'acceptedByBEQ'
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
         update emrs_d_selection_trans_history
         set selection_status_id = temp_tab(indx).med_sel_status_id
		     where selection_trans_history_id = temp_tab(indx).selection_trans_history_id;				   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

UPDATE emrs_d_selection_trans_history
SET selection_status_id =86677
WHERE selection_status_id = 86780;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86770
WHERE selection_status_id = 86758;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86773
WHERE selection_status_id = 86739;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86663
WHERE selection_status_id = 86779;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86777
WHERE selection_status_id IN(86727,86741,86653);

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86769
WHERE selection_status_id IN(86667,86751,86761);

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86792
WHERE selection_status_id = 86868;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86633
WHERE selection_status_id = 86870;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86642
WHERE selection_status_id = 86875;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86634
WHERE selection_status_id = 86871;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86645
WHERE selection_status_id = 86876;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86652
WHERE selection_status_id = 86880;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86647
WHERE selection_status_id = 86877;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86649
WHERE selection_status_id = 86878;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86657
WHERE selection_status_id = 86884;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86796
WHERE selection_status_id = 86885;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86799
WHERE selection_status_id = 86887;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86803
WHERE selection_status_id IN(86976,86889);

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86805
WHERE selection_status_id IN(86979,86892);

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86662
WHERE selection_status_id =86980;

UPDATE emrs_d_selection_trans_history
SET selection_status_id = 86665
WHERE selection_status_id IN(86981,86894);



DECLARE  
  CURSOR temp_cur IS
   select s.selection_trans_history_id
   from emrs_d_selection_trans_history s
   where selection_status_id IN(86735,86745)
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
        update emrs_d_selection_trans_history
         set selection_status_id = 86756
		     where selection_trans_history_id = temp_tab(indx).selection_trans_history_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select s.selection_trans_history_id
   from emrs_d_selection_trans_history s
   where selection_status_id IN(86811,86807)
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
        update emrs_d_selection_trans_history
         set selection_status_id = 86675
		     where selection_trans_history_id = temp_tab(indx).selection_trans_history_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select s.selection_trans_history_id
   from emrs_d_selection_trans_history s
   where selection_status_id IN(86747,86787,86757)
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
        update emrs_d_selection_trans_history
         set selection_status_id = 86643
		     where selection_trans_history_id = temp_tab(indx).selection_trans_history_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
select selection_missing_info_id, program_type_cd, i.enrollment_error_code_id wrong_enr_error_code_id,
     (select enrollment_error_code_id
      from emrs_d_enrollment_error_code ec
      where ec.managed_care_program = t.program_type_cd
      and ec.enrollment_error_code = e.enrollment_error_code
      and enrollment_error_code_id = (select min(enrollment_error_code_id)
                                        from emrs_d_enrollment_error_code ec1
                                        where ec.enrollment_error_code = ec1.enrollment_error_code
                                        and ec.managed_care_program = ec1.managed_care_program)) correct_enr_error_code_id
from emrs_d_selection_missing_info i, emrs_d_selection_transaction t, emrs_d_enrollment_error_code e
where i.selection_transaction_id = t.selection_transaction_id
and i.enrollment_error_code_id = e.enrollment_error_code_id;
   
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
         update emrs_d_selection_missing_info
           set enrollment_error_code_id = temp_tab(indx).correct_enr_error_code_id
		     where selection_missing_info_id = temp_tab(indx).selection_missing_info_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

delete from emrs_d_enrollment_error_code ec
where not exists(select 1 from emrs_d_selection_missing_info i where ec.enrollment_error_code_id = i.enrollment_error_code_id);

delete from emrs_d_zipcode
where zipcode_id IN(103156,103162,103163);

commit;