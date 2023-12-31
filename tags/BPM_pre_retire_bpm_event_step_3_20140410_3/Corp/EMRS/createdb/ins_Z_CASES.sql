
INSERT INTO emrs_d_case_ref(case_number)
SELECT 0
FROM emrs_d_case_ref
WHERE case_number = 0
HAVING COUNT(*) = 0;


INSERT INTO emrs_d_case(CASE_ID
,SOURCE_RECORD_ID
,CASE_NUMBER
,CASE_SEARCH_ELEMENT
,CREATED_BY
,CSDA_CODE
,DATE_CREATED
,DATE_OF_VALIDITY_START
,DATE_OF_VALIDITY_END
,FIRST_NAME
,FULL_NAME
,GUARDIAN_FULL_NAME
,LAST_NAME
,MANAGED_CARE_PROGRAM
,VERSION
,CURRENT_FLAG
,CURRENT_CASE_ID)
SELECT
  0
 ,0
 ,0
 ,'Unknown'
 ,user
 ,'0'
 ,SYSDATE
 ,TO_DATE('01/01/1995','MM/DD/YYYY')
 ,TO_DATE('12/31/2050','MM/DD/YYYY')
 ,'Unknown'
 ,'Unknown'
 ,'Unknown'
 ,'Unknown'
 ,'Unknown'
 ,0
 ,'Y'
 ,0
 FROM emrs_d_case
 WHERE case_number = 0
 HAVING COUNT(*) = 0;
