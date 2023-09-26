alter session set plsql_code_type = native;

CREATE OR REPLACE PACKAGE fedqic_etl_claim_li_pkg IS
/*
|| CA DIR Project
||    This source code is the intellectual property of MAXIMUS.
||    Copyright(c) 2007 MAXIMUS, Inc. All rights reserved.
|| Scope   : This package contains procedures to populate the new appeal instance table
||             It will build a tmp table to do bulk updates/inserts to the appeal instancetable.
|| Written : Eric Burke
|| Date    : July 5, 2019
|| Revisions ---------------------------------------------------------------------

*/

-- Do not edit these four SVN_* variable values.  They are populated when you commit code
--    to SVN and used later to identify deployed code.
   SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/FEDQIC/createdb/fedqic_etl_appeal_pkg.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 23262 $';
   SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-10 17:55:01 -0400 (Thu, 10 May 2018) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: fm18957 $';

/*
||  Procedures
*/
   PROCEDURE InitProcess;   --<< Resets from last run

   PROCEDURE Insert_New_Claim_LIs;         --<< Inserts new records into corp_etl_appeal_wip

   PROCEDURE Update_Claim_LIs;         --<< updates records in corp_etl_appeal_wip

   PROCEDURE CLAIM_LI_UPDATE_MAIN_TABLE;   --<< updates corp_etl_appeal from corp_etl_appeal_wip records	

/*
|| Functions
*/

   FUNCTION Get_Person_ID
            (p_user_id in number)
     RETURN number parallel_enable;


END fedqic_etl_claim_li_pkg;
/

CREATE OR REPLACE PACKAGE BODY fedqic_etl_claim_li_pkg IS
   g_Error   VARCHAR2(4000);
   g_Limit   NUMBER;
   gPKG VARCHAR2(30) := 'fedqic_ETL_CLAIM_LI_PKG';


FUNCTION Get_Person_ID
         (p_user_id in number)
RETURN Number parallel_enable
AS
     v_parameter_value number := null;
BEGIN

    IF p_user_id IS NULL OR p_user_id = 0 THEN
       v_parameter_value := 0;
    ELSE

         Select P.Person_ID
           Into v_parameter_value
           From fedqic_user_stg U
           Left Outer Join fedqic_person_stg P ON U.person_id = P.person_id
          Where U.user_id = p_user_id ;

    END IF;

    if v_parameter_value is null then
	v_parameter_value := -1;
    END IF;
    

    RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN -1;
END;



PROCEDURE InitProcess
IS
v_role_id number;
BEGIN
   -- Remove any old records from tmp table
   DELETE FROM corp_etl_claim_line_item_wip;
   COMMIT;

   --populate tmp table with records from corp_etl_appeal

INSERT INTO corp_etl_claim_line_item_wip 
SELECT 
CECLI_ID
, CLAIM_ID
, CLAIM_LINE_ITEM_ID 
, CLAIM_LINE_ITEM_NUMBER
, MSG_ACTION_CODE
, CLAIM_LINE_ADJUSTMENT_CODE
, CLAIM_LINE_PROCEDURE_CODES
, CLAIM_LINE_DRUG_CODES
, HIPPS_CODE
, DIAGNOSIS_CODE
, MISC_CODES
, CLAIM_LINE_DISPOSITION
, CLAIM_LINE_DISPOSITION_EXPLANATION
, CLAIM_LINE_PROCEDURAL_DECISION_REASON
, CLAIM_LINE_SUBSTANTIVE_REASON
, STG_EXTRACT_DATE
, STG_LAST_UPDATE_DATE
, 'N' as change_flag
FROM corp_etl_claim_line_item;
            
commit;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('INIT', 'fedqic Claim LI', g_Error);
      COMMIT;
      RAISE;
END InitProcess;

/*
|| Procedure to insert into/update corp_etl_appeal
||   
*/

PROCEDURE Insert_New_Claim_LIs
IS

BEGIN

--insert new record into appeal_wip

INSERT INTO corp_etl_claim_line_item_wip (
CLAIM_ID
, CLAIM_LINE_ITEM_ID 
, CLAIM_LINE_ITEM_NUMBER
, MSG_ACTION_CODE
, CLAIM_LINE_ADJUSTMENT_CODE
, CLAIM_LINE_PROCEDURE_CODES
, CLAIM_LINE_DRUG_CODES
, HIPPS_CODE
, DIAGNOSIS_CODE
, MISC_CODES
, CLAIM_LINE_DISPOSITION
, CLAIM_LINE_DISPOSITION_EXPLANATION
, CLAIM_LINE_PROCEDURAL_DECISION_REASON
, CLAIM_LINE_SUBSTANTIVE_REASON
, STG_EXTRACT_DATE
, STG_LAST_UPDATE_DATE
, change_flag
)
SELECT 
ID_PARENT
, ID 
, LI_C_CLAIM_LINE_ITEM_NUMBER
, LI_C_MSG_ACTION_CODE
, LI_C_CLAIM_ADJUSTMENT_CODE
, LI_C_PROCEDURE_CODE
, LI_C_DRG_CODE
, LI_C_HIPPS_CODE
, LI_C_DIAGNOSIS_CODE
, LI_C_MISC_CODES
, LI_C_DISPOSITION
, LI_C_DISPOSITION_EXPLANATION
, LI_C_PROCEDURAL_DECISION_REASON
, LI_C_SUBSTANTIVE_REASON
, sysdate 
, sysdate  
, 'I' 
from FEDQIC_CLAIM_LINE_ITEM_STG cstg      
where not exists (select 1 from corp_etl_claim_line_item cli where cli.CLAIM_LINE_ITEM_ID = cstg.id)
and exists (select 1 from corp_etl_claim clm where clm.claim_id = cstg.id_parent);


--insert record from wip into etl_appeal table	
INSERT INTO corp_etl_claim_line_item
SELECT
CECLI_ID
, CLAIM_ID
, CLAIM_LINE_ITEM_ID 
, CLAIM_LINE_ITEM_NUMBER
, MSG_ACTION_CODE
, CLAIM_LINE_ADJUSTMENT_CODE
, CLAIM_LINE_PROCEDURE_CODES
, CLAIM_LINE_DRUG_CODES
, HIPPS_CODE
, DIAGNOSIS_CODE
, MISC_CODES
, CLAIM_LINE_DISPOSITION
, CLAIM_LINE_DISPOSITION_EXPLANATION
, CLAIM_LINE_PROCEDURAL_DECISION_REASON
, CLAIM_LINE_SUBSTANTIVE_REASON
, STG_EXTRACT_DATE
, STG_LAST_UPDATE_DATE
FROM corp_etl_claim_line_item_wip cwip WHERE cwip.change_flag = 'I';

COMMIT;      

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Insert_New_Claim_LI', 'ETL COMMIT', g_Error);
      COMMIT;
      RAISE;

END Insert_New_Claim_LIs;

PROCEDURE Update_Claim_LIs
IS

BEGIN
       

UPDATE 
(SELECT 
fac.ID_PARENT as FAC_ID_PARENT
, fac.LI_C_CLAIM_LINE_ITEM_NUMBER as FAC_LI_C_CLAIM_LINE_ITEM_NUMBER
, fac.LI_C_MSG_ACTION_CODE as FAC_LI_C_MSG_ACTION_CODE
, fac.LI_C_CLAIM_ADJUSTMENT_CODE as FAC_LI_C_CLAIM_ADJUSTMENT_CODE
, fac.LI_C_PROCEDURE_CODE as FAC_LI_C_PROCEDURE_CODE
, fac.LI_C_DRG_CODE as FAC_LI_C_DRG_CODE
, fac.LI_C_HIPPS_CODE as FAC_LI_C_HIPPS_CODE
, fac.LI_C_DIAGNOSIS_CODE as FAC_LI_C_DIAGNOSIS_CODE
, fac.LI_C_MISC_CODES as FAC_LI_C_MISC_CODES
, fac.LI_C_DISPOSITION as FAC_LI_C_DISPOSITION
, fac.LI_C_DISPOSITION_EXPLANATION as FAC_LI_C_DISPOSITION_EXPLANATION
, fac.LI_C_PROCEDURAL_DECISION_REASON as FAC_LI_C_PROCEDURAL_DECISION_REASON
, fac.LI_C_SUBSTANTIVE_REASON as FAC_LI_C_SUBSTANTIVE_REASON
, cwip.CLAIM_ID as CWIP_CLAIM_ID
, cwip.CLAIM_LINE_ITEM_NUMBER  as CWIP_CLAIM_LINE_ITEM_NUMBER
, cwip.MSG_ACTION_CODE  as CWIP_MSG_ACTION_CODE
, cwip.CLAIM_LINE_ADJUSTMENT_CODE as CWIP_CLAIM_LINE_ADJUSTMENT_CODE
, cwip.CLAIM_LINE_PROCEDURE_CODES as CWIP_CLAIM_LINE_PROCEDURE_CODES
, cwip.CLAIM_LINE_DRUG_CODES as CWIP_CLAIM_LINE_DRUG_CODES
, cwip.HIPPS_CODE as CWIP_HIPPS_CODE
, cwip.DIAGNOSIS_CODE as CWIP_DIAGNOSIS_CODE 
, cwip.MISC_CODES as CWIP_MISC_CODES
, cwip.CLAIM_LINE_DISPOSITION as CWIP_CLAIM_LINE_DISPOSITION
, cwip.CLAIM_LINE_DISPOSITION_EXPLANATION as CWIP_CLAIM_LINE_DISPOSITION_EXPLANATION
, cwip.CLAIM_LINE_PROCEDURAL_DECISION_REASON as CWIP_CLAIM_LINE_PROCEDURAL_DECISION_REASON
, cwip.CLAIM_LINE_SUBSTANTIVE_REASON as CWIP_CLAIM_LINE_SUBSTANTIVE_REASON
, cwip.STG_LAST_UPDATE_DATE as CWIP_STG_LAST_UPDATE_DATE
, cwip.change_flag as CWIP_CHANGE_FLAG
FROM fedqic_claim_line_item_stg fac
,corp_etl_claim_line_item_wip cwip
WHERE  fac.id = cwip.claim_line_item_id )
set CWIP_CLAIM_ID = FAC_ID_PARENT,
CWIP_CLAIM_LINE_ITEM_NUMBER = FAC_LI_C_CLAIM_LINE_ITEM_NUMBER,
CWIP_MSG_ACTION_CODE = FAC_LI_C_MSG_ACTION_CODE,
CWIP_CLAIM_LINE_ADJUSTMENT_CODE = FAC_LI_C_CLAIM_ADJUSTMENT_CODE,
CWIP_CLAIM_LINE_PROCEDURE_CODES = FAC_LI_C_PROCEDURE_CODE,
CWIP_CLAIM_LINE_DRUG_CODES = FAC_LI_C_DRG_CODE,
CWIP_HIPPS_CODE = FAC_LI_C_HIPPS_CODE,
CWIP_DIAGNOSIS_CODE = FAC_LI_C_DIAGNOSIS_CODE,
CWIP_MISC_CODES = FAC_LI_C_MISC_CODES,
CWIP_CLAIM_LINE_DISPOSITION = FAC_LI_C_DISPOSITION,
CWIP_CLAIM_LINE_DISPOSITION_EXPLANATION = FAC_LI_C_DISPOSITION_EXPLANATION,
CWIP_CLAIM_LINE_PROCEDURAL_DECISION_REASON = FAC_LI_C_PROCEDURAL_DECISION_REASON,
CWIP_CLAIM_LINE_SUBSTANTIVE_REASON = FAC_LI_C_SUBSTANTIVE_REASON,
cwip_STG_LAST_UPDATE_DATE = sysdate,
cwip_change_flag = 'Y'
where cwip_change_flag = 'N'
AND (decode(CWIP_CLAIM_ID,FAC_ID_PARENT,1,0) = 0
OR decode(CWIP_CLAIM_LINE_ITEM_NUMBER,FAC_LI_C_CLAIM_LINE_ITEM_NUMBER,1,0) = 0
OR decode(CWIP_MSG_ACTION_CODE,FAC_LI_C_MSG_ACTION_CODE,1,0) = 0
OR decode(CWIP_CLAIM_LINE_ADJUSTMENT_CODE,FAC_LI_C_CLAIM_ADJUSTMENT_CODE,1,0) = 0
OR decode(CWIP_CLAIM_LINE_PROCEDURE_CODES,FAC_LI_C_PROCEDURE_CODE,1,0) = 0
OR decode(CWIP_CLAIM_LINE_DRUG_CODES,FAC_LI_C_DRG_CODE,1,0) = 0
OR decode(CWIP_HIPPS_CODE,FAC_LI_C_HIPPS_CODE,1,0) = 0
OR decode(CWIP_DIAGNOSIS_CODE,FAC_LI_C_DIAGNOSIS_CODE,1,0) = 0
OR decode(CWIP_MISC_CODES,FAC_LI_C_MISC_CODES,1,0) = 0
OR decode(CWIP_CLAIM_LINE_DISPOSITION,FAC_LI_C_DISPOSITION,1,0) = 0
OR decode(CWIP_CLAIM_LINE_DISPOSITION_EXPLANATION,FAC_LI_C_DISPOSITION_EXPLANATION,1,0) = 0
OR decode(CWIP_CLAIM_LINE_PROCEDURAL_DECISION_REASON,FAC_LI_C_PROCEDURAL_DECISION_REASON,1,0) = 0
OR decode(CWIP_CLAIM_LINE_SUBSTANTIVE_REASON,FAC_LI_C_SUBSTANTIVE_REASON,1,0) = 0
);

COMMIT;


EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Insert_Update_Claim_LI', 'fedqic Claim Lis', g_Error);
      COMMIT;
      RAISE;

END Update_Claim_LIs;

PROCEDURE CLAIM_LI_UPDATE_MAIN_TABLE AS

 CURSOR wip_cur IS
   SELECT * FROM corp_etl_claim_line_item_wip
   WHERE CHANGE_FLAG = 'Y';

   TYPE t_wip_tab IS TABLE OF wip_cur%ROWTYPE INDEX BY PLS_INTEGER;
    wip_tab t_wip_tab;
    v_bulk_limit NUMBER := 1000;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    --v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
    vPROC VARCHAR2(30) := 'CLAIM_LI_UPDATE_MAIN_TABLE';
BEGIN
   v_step :=  gPKG||'.'||vPROC||' - Updateing Main table';
   OPEN wip_cur;
   LOOP
     FETCH wip_cur BULK COLLECT INTO wip_tab LIMIT v_bulk_limit;
     EXIT WHEN wip_tab.COUNT = 0; -- Exit when missing rows

BEGIN
FORALL indx IN 1 .. wip_tab.COUNT SAVE EXCEPTIONS
UPDATE corp_etl_claim_line_item
SET 
CLAIM_ID = wip_tab(indx).CLAIM_ID     
,  CLAIM_LINE_ITEM_NUMBER = wip_tab(indx).CLAIM_LINE_ITEM_NUMBER
,  MSG_ACTION_CODE = wip_tab(indx).MSG_ACTION_CODE
,  CLAIM_LINE_ADJUSTMENT_CODE = wip_tab(indx).CLAIM_LINE_ADJUSTMENT_CODE
,  CLAIM_LINE_PROCEDURE_CODES = wip_tab(indx).CLAIM_LINE_PROCEDURE_CODES
,  CLAIM_LINE_DRUG_CODES = wip_tab(indx).CLAIM_LINE_DRUG_CODES  
,  HIPPS_CODE = wip_tab(indx).HIPPS_CODE 
,  DIAGNOSIS_CODE = wip_tab(indx).DIAGNOSIS_CODE 
,  MISC_CODES = wip_tab(indx).MISC_CODES 
,  CLAIM_LINE_DISPOSITION = wip_tab(indx).CLAIM_LINE_DISPOSITION  
,  CLAIM_LINE_DISPOSITION_EXPLANATION = wip_tab(indx).CLAIM_LINE_DISPOSITION_EXPLANATION 
,  CLAIM_LINE_PROCEDURAL_DECISION_REASON = wip_tab(indx).CLAIM_LINE_PROCEDURAL_DECISION_REASON
,  CLAIM_LINE_SUBSTANTIVE_REASON = wip_tab(indx).CLAIM_LINE_SUBSTANTIVE_REASON
, STG_EXTRACT_DATE = wip_tab(indx).STG_EXTRACT_DATE
, STG_LAST_UPDATE_DATE = wip_tab(indx).STG_LAST_UPDATE_DATE
          WHERE CECLI_ID  =  wip_tab(indx).CECLI_ID;

     EXCEPTION
        WHEN OTHERS THEN
          IF SQLCODE = -24381 THEN
            FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
              v_err_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE; --SQLCODE;
              v_err_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
              --v_err_msg := SUBSTR(SQLERRM, 1, 200);
              INSERT INTO corp_etl_error_log
              VALUES(SEQ_CEEL_ID.nextval,--CEEL_ID
                     sysdate,--ERR_DATE
                     'CRITICAL',--ERR_LEVEL
                     'ETL CLAIM LI',--PROCESS_NAME
                     'CLAIM_LI_UPDATE_MAIN_TABLE',--JOB_NAME
                     '1',--NR_OF_ERROR
                     v_step, --||' '||v_err_msg,--ERROR_DESC
                     null,--ERROR_FIELD
                     v_err_code,--ERROR_CODES
                     sysdate,--CREATE_TS
                     sysdate,--UPDATE_TS
                     'CORP_ETL_CLAIM_LINE_ITEM',--DRIVER_TABLE_NAME
                     v_err_index);--DRIVER_KEY_NUMBER
            END LOOP;
          END IF;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE wip_cur;
END CLAIM_LI_UPDATE_MAIN_TABLE;

END fedqic_etl_claim_li_pkg;

/

alter session set plsql_code_type = interpreted;