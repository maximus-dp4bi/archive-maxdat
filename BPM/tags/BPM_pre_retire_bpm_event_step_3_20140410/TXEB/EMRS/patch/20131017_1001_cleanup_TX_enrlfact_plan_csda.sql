 
UPDATE emrs_f_enrollment f
SET plan_id = 4931
    ,csda_id = 757
WHERE csda_id = 749 --MW
AND plan_id = 4450  --59
;

UPDATE emrs_f_enrollment f
SET plan_id = 4932
    ,csda_id = 757
WHERE csda_id = 749 --MW
AND plan_id = 4451  --1F
 ;

UPDATE emrs_f_enrollment f
SET plan_id = 4929
    ,csda_id = 755
WHERE csda_id = 748 --MN
AND plan_id = 4444  --1F
;

UPDATE emrs_f_enrollment f
SET plan_id = 4928
    ,csda_id = 755
WHERE csda_id = 748 --MN
AND plan_id = 4443  --59
 ;
  

UPDATE emrs_f_enrollment f
SET plan_id = 4931
    ,csda_id = 757
WHERE csda_id = 744 --HI
AND plan_id = 4412  --59
;

UPDATE emrs_f_enrollment f
SET plan_id = 4932
    ,csda_id = 757
WHERE csda_id = 744 --HI
AND plan_id = 4413  --1F
;

UPDATE emrs_f_enrollment f
SET plan_id = 4925
    ,csda_id = 754
WHERE csda_id = 747 --MC
AND plan_id = 4436  --59
 ;
 
UPDATE emrs_f_enrollment f
SET plan_id = 4926
    ,csda_id = 754
WHERE csda_id = 747 --MC
AND plan_id = 4437  --1F
 ;

UPDATE emrs_f_enrollment
SET plan_id = 4922
   ,csda_id = 740
WHERE plan_id IN(SELECT plan_id FROM emrs_d_plan WHERE plan_code = '1H' and managed_care_program = 'CHIP')
and program_id = 604;

UPDATE emrs_f_enrollment
SET plan_id = 4921
   ,csda_id = 740
WHERE plan_id IN(SELECT plan_id FROM emrs_d_plan WHERE plan_code = '1D' and managed_care_program = 'CHIP')
and program_id = 604;

UPDATE emrs_f_enrollment
SET plan_id = 4923
   ,csda_id = 740
WHERE plan_id IN(SELECT plan_id FROM emrs_d_plan WHERE plan_code = '1K' and managed_care_program = 'CHIP')
and program_id = 604;

UPDATE emrs_f_enrollment f
SET csda_id = 757
WHERE csda_id = 749 --MW
;

UPDATE emrs_f_enrollment f
SET csda_id = 755
WHERE csda_id = 748 --MN
;

UPDATE emrs_f_enrollment f
SET csda_id = 757
WHERE csda_id = 744 --HI
;

UPDATE emrs_f_enrollment f
SET csda_id = 754
WHERE csda_id = 747 --MC
 ;

UPDATE emrs_f_enrollment f
SET sub_program_id = 329
WHERE EXISTS(SELECT 1 FROM emrs_d_client_plan_eligibility p WHERE f.client_number = p.client_number and p.current_flag = 'Y' and sub_program_id = 329)
AND f.sub_program_id != 329
AND program_id = 606
and plan_type_id = 155
and managed_care_end_date is null;

UPDATE emrs_f_enrollment
SET sub_program_id = 312
WHERE enrollment_id in(45050694,45048803);

UPDATE emrs_f_enrollment
SET sub_program_id = 313
WHERE enrollment_id in(45065151,45137233);

UPDATE emrs_f_enrollment
SET sub_program_id = 313
WHERE sub_program_id = 0
AND csda_id = 740;

UPDATE emrs_f_enrollment
SET sub_program_id = 312
WHERE sub_program_id = 0
AND csda_id not in(740,0)
and program_id = 604;

DECLARE
 CURSOR client_cur IS
 select *
 from emrs_f_enrollment
 where plan_id IN(SELECT plan_id FROM emrs_d_plan WHERE plan_code = '1G' and managed_care_program = 'MEDICAID')
 and program_id = 606;
   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;  
BEGIN
  OPEN client_cur;
  LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows
    
     FOR indx IN 1 .. clnt_tab.COUNT LOOP  
      UPDATE emrs_f_enrollment
      SET plan_id = 4935
          ,csda_id = 765
       WHERE enrollment_id = clnt_tab(indx).enrollment_id;
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
END;
/

DECLARE
 CURSOR client_cur IS
 select *
 from emrs_f_enrollment
 where plan_id IN(SELECT plan_id FROM emrs_d_plan WHERE plan_code = '1J' and managed_care_program = 'MEDICAID')
 and program_id = 606;
   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;  
BEGIN
  OPEN client_cur;
  LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows
    
     FOR indx IN 1 .. clnt_tab.COUNT LOOP  
      UPDATE emrs_f_enrollment
      SET plan_id = 4936
          ,csda_id = 765
       WHERE enrollment_id = clnt_tab(indx).enrollment_id;
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
END;
/

DECLARE
 CURSOR client_cur IS
 select *
 from emrs_f_enrollment
 where plan_id IN(SELECT plan_id FROM emrs_d_plan WHERE plan_code = '1M' and managed_care_program = 'MEDICAID')
 and program_id = 606;
   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;  
BEGIN
  OPEN client_cur;
  LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows
    
     FOR indx IN 1 .. clnt_tab.COUNT LOOP  
      UPDATE emrs_f_enrollment
      SET plan_id = 4937
         ,csda_id = 765
       WHERE enrollment_id = clnt_tab(indx).enrollment_id;
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
END;
/
DECLARE
 CURSOR client_cur IS
 SELECT dc.county, tmp.plan_service_type, tmp.enrollment_id, tmp.client_number,tmp.county_id, tmp.csda_id, ct.county_id new_county_id, da.csda_id new_csda_id
,ct.csdaid
FROM emrs_d_client dc,
(SELECT CASE WHEN INSTR(s.sub_program_code,'DUAL') > 0 THEN SUBSTR(s.sub_program_code, 1,INSTR(s.sub_program_code,'DUAL')) 
        WHEN s.sub_program_code IN('CHIP','CHIP-PER') THEN 'CHIP'
        WHEN s.sub_program_code IN('CHIP-DEN','PER-DEN') THEN 'CHIP-DEN'
       ELSE sub_program_code END plan_service_type,s.parent_program_name,f.*
FROM emrs_f_enrollment f, emrs_d_sub_program s
WHERE f.sub_program_id = s.sub_program_id
AND county_id = 0
and program_id = 604) tmp
,emrs_d_county ct
,emrs_d_care_serv_deliv_area da
WHERE dc.client_number = tmp.client_number
and dc.current_flag = 'Y'
AND ct.county_code = dc.county
AND ct.plan_service_type = tmp.plan_service_type
and ct.csdaid = da.csda_code
and da.managed_care_program = tmp.parent_program_name
and county != '255';
   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;  
BEGIN
  OPEN client_cur;
  LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows
    
     FOR indx IN 1 .. clnt_tab.COUNT LOOP  
      UPDATE emrs_f_enrollment
      SET county_id = clnt_tab(indx).new_county_id
          ,csda_id = clnt_tab(indx).new_csda_id
       WHERE enrollment_id = clnt_tab(indx).enrollment_id;
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
END;
/

DECLARE
 CURSOR client_cur IS
 SELECT dc.county, tmp.plan_service_type, tmp.enrollment_id, tmp.client_number,tmp.county_id, tmp.csda_id, ct.county_id new_county_id, da.csda_id new_csda_id
,ct.csdaid
FROM emrs_d_client dc,
(SELECT CASE WHEN INSTR(s.sub_program_code,'DUAL') > 0 THEN SUBSTR(s.sub_program_code, 1,INSTR(s.sub_program_code,'DUAL')) 
        WHEN s.sub_program_code IN('CHIP','CHIP-PER') THEN 'CHIP'
        WHEN s.sub_program_code IN('CHIP-DEN','PER-DEN') THEN 'CHIP-DEN'
       ELSE sub_program_code END plan_service_type,s.parent_program_name,f.*
FROM emrs_f_enrollment f, emrs_d_sub_program s
WHERE f.sub_program_id = s.sub_program_id
AND county_id = 0
and program_id = 606) tmp
,emrs_d_county ct
,emrs_d_care_serv_deliv_area da
WHERE dc.client_number = tmp.client_number
and dc.current_flag = 'Y'
AND ct.county_code = dc.county
AND ct.plan_service_type = tmp.plan_service_type
and ct.csdaid = da.csda_code
and da.managed_care_program = tmp.parent_program_name
and county != '255';
   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;  
BEGIN
  OPEN client_cur;
  LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows
    
     FOR indx IN 1 .. clnt_tab.COUNT LOOP  
      UPDATE emrs_f_enrollment
      SET county_id = clnt_tab(indx).new_county_id
          ,csda_id = clnt_tab(indx).new_csda_id
       WHERE enrollment_id = clnt_tab(indx).enrollment_id;
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
END;
/

DECLARE
 CURSOR client_cur IS
SELECT dc.county, tmp.plan_service_type, tmp.enrollment_id, tmp.client_number,tmp.county_id, tmp.csda_id, ct.county_id new_county_id, da.csda_id new_csda_id
,ct.csdaid
FROM emrs_d_client dc,
(SELECT CASE WHEN INSTR(s.sub_program_code,'DUAL') > 0 THEN SUBSTR(s.sub_program_code, 1,INSTR(s.sub_program_code,'DUAL')) 
        WHEN s.sub_program_code IN('CHIP','CHIP-PER') THEN 'CHIP'
        WHEN s.sub_program_code IN('CHIP-DEN','PER-DEN') THEN 'CHIP-DEN'
       ELSE sub_program_code END plan_service_type,s.parent_program_name,f.*
FROM emrs_f_enrollment f, emrs_d_sub_program s
WHERE f.sub_program_id = s.sub_program_id
--AND county_id = 0
and program_id = 604) tmp
,emrs_d_county ct
,emrs_d_care_serv_deliv_area da
WHERE dc.client_number = tmp.client_number
and dc.current_flag = 'Y'
AND ct.county_code = dc.county
AND ct.plan_service_type = tmp.plan_service_type
and ct.csdaid = da.csda_code
and da.managed_care_program = tmp.parent_program_name
and da.csda_id != tmp.csda_id
and tmp.plan_service_type != 'CHIP-DEN';
   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;  
BEGIN
  OPEN client_cur;
  LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows
    
     FOR indx IN 1 .. clnt_tab.COUNT LOOP  
      UPDATE emrs_f_enrollment
      SET csda_id = clnt_tab(indx).new_csda_id
          ,county_id = clnt_tab(indx).new_county_id
       WHERE enrollment_id = clnt_tab(indx).enrollment_id;
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
END;
/

DECLARE
 CURSOR client_cur IS
select f.enrollment_id, f.csda_id, da.csda_code, dp.plan_id, dp.plan_code, dp.csda,f.date_updated,
  (select plan_id from emrs_d_plan p1 where p1.plan_code = dp.plan_code and p1.csda = da.csda_code) new_plan_id
from emrs_f_enrollment f, emrs_d_care_serv_deliv_area da, emrs_d_plan dp
where f.csda_id = da.csda_id
and f.plan_id = dp.plan_id
and f.program_id = 604
and dp.csda != da.csda_code
and da.csda_code IN('RSAE','RSAS','RSAC')
and dp.csda != '0';
   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;  
BEGIN
  OPEN client_cur;
  LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows
    
     FOR indx IN 1 .. clnt_tab.COUNT LOOP  
      UPDATE emrs_f_enrollment
      SET plan_id = CASE WHEN clnt_tab(indx).new_plan_id IS NULL THEN plan_id ELSE clnt_tab(indx).new_plan_id END
       WHERE enrollment_id = clnt_tab(indx).enrollment_id;
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
END;
/

DECLARE
 CURSOR client_cur IS
select f.enrollment_id, f.csda_id, da.csda_code, dp.plan_id, dp.plan_code, dp.csda,f.date_updated,
  (select csda_id from emrs_d_care_serv_deliv_area sa where sa.csda_code = dp.csda and sa.managed_care_program = dp.managed_care_program) new_csda_id
from emrs_f_enrollment f, emrs_d_care_serv_deliv_area da, emrs_d_plan dp
where f.csda_id = da.csda_id
and f.plan_id = dp.plan_id
and f.program_id = 604
and dp.csda != da.csda_code
--and da.csda_code IN('RSAE','RSAS','RSAC')
and dp.csda != '0';
   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;  
BEGIN
  OPEN client_cur;
  LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows
    
     FOR indx IN 1 .. clnt_tab.COUNT LOOP  
      UPDATE emrs_f_enrollment
      SET csda_id = clnt_tab(indx).new_csda_id
       WHERE enrollment_id = clnt_tab(indx).enrollment_id;
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
END;
/

DELETE FROM emrs_d_plan
WHERE INSTR(LOWER(plan_abbreviation),'den') > 0
AND csda NOT IN('0','DENTAL');

DELETE FROM emrs_d_plan
WHERE managed_care_program = 'CHIP'
AND csda IN('MC','MW','MN','HI');

DELETE FROM emrs_d_care_serv_deliv_area
WHERE csda_code in ('MC','MW','MN','HI')
and managed_care_program = 'CHIP';

COMMIT;