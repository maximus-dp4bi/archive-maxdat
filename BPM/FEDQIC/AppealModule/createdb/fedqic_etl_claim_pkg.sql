alter session set plsql_code_type = native;

CREATE OR REPLACE PACKAGE fedqic_etl_claim_pkg IS
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

   PROCEDURE Insert_New_Claims;         --<< Inserts new records into corp_etl_appeal_wip

   PROCEDURE Update_Claims;         --<< updates records in corp_etl_appeal_wip

   PROCEDURE CLAIM_UPDATE_MAIN_TABLE;   --<< updates corp_etl_appeal from corp_etl_appeal_wip records	

/*
|| Functions
*/

   FUNCTION Get_Person_ID
            (p_user_id in number)
     RETURN number parallel_enable;


END fedqic_etl_claim_pkg;
/

CREATE OR REPLACE PACKAGE BODY fedqic_etl_claim_pkg IS
   g_Error   VARCHAR2(4000);
   g_Limit   NUMBER;
   gPKG VARCHAR2(30) := 'fedqic_ETL_APPEAL_PKG';


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


update fedqic_claim_stg
    set c_claim_number = TRIM(replace(c_claim_number, ']]>','') ),
    c_provider = TRIM(replace(c_provider, ']]>','') );

COMMIT;

update fedqic_claim_stg
    set c_claim_number = regexp_replace(c_claim_number,'[^[:print:]]'),
    c_provider = regexp_replace(c_provider,'[^[:print:]]');

      COMMIT;


   -- Remove any old records from tmp table
   DELETE FROM corp_etl_claim_wip;
   COMMIT;

   --populate tmp table with records from corp_etl_appeal

INSERT INTO corp_etl_claim_wip 
SELECT 
CECLM_ID
, APPEAL_ID
, CLAIM_ID 
, CLAIM_NUMBER  
, HCPCS_CODE 
, ACTION_CODE   
, APPELLANT_ARGUMENT  
, DISPOSITION 
, DISPOSITION_EXPLANATION     
, REVERSAL_REASON 
, PROCEDURAL_DECISION_REASON   
, SUBSTANTIVE_REASON  
, CITATION_SOURCE  
, PROVIDER
, PROVIDER_NAME
, CLAIM_DIAGNOSIS_CODES
, CLAIM_PROCEDURE_CODES
, CLAIM_STATUS_CODE
, CLAIM_ADJUSTMENT_CODE
, NATIONAL_DRUG_CODE
, TYPE_OF_COVERAGE
, STG_EXTRACT_DATE
, STG_LAST_UPDATE_DATE
, 'N' as change_flag
FROM corp_etl_claim;
            
commit;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('INIT', 'fedqic Claim', g_Error);
      COMMIT;
      RAISE;

END InitProcess;

/*
|| Procedure to insert into/update corp_etl_appeal
||   
*/

PROCEDURE Insert_New_Claims
IS

BEGIN

--insert new record into appeal_wip

INSERT INTO corp_etl_claim_wip (
APPEAL_ID
, CLAIM_ID 
, CLAIM_NUMBER  
, HCPCS_CODE 
, ACTION_CODE   
, APPELLANT_ARGUMENT  
, DISPOSITION 
, DISPOSITION_EXPLANATION     
, REVERSAL_REASON 
, PROCEDURAL_DECISION_REASON   
, SUBSTANTIVE_REASON  
, CITATION_SOURCE  
, PROVIDER
, PROVIDER_NAME
, CLAIM_DIAGNOSIS_CODES
, CLAIM_PROCEDURE_CODES
, CLAIM_STATUS_CODE
, CLAIM_ADJUSTMENT_CODE
, NATIONAL_DRUG_CODE
, TYPE_OF_COVERAGE
, STG_EXTRACT_DATE
, STG_LAST_UPDATE_DATE
, change_flag
)
SELECT 
ID_PARENT
, ID 
, C_CLAIM_NUMBER 
, C_HCPCS_CPT_CODE 
, C_VMS_REASON_CODE  
, C_APPELLANT_ARGUMENT
, C_DISPOSITION
, C_DISPOSITION_EXPLANATION     
, C_REVERSAL_REASON 
, C_PROCEDURAL_DECISION_REASON 
, C_SUBSTANTIVE_REASON 
, C_CITATION_SOURCE  
, C_PROVIDER
, C_PROVIDER_NAME
, C_DIAGNOSIS_CODE
, C_PROCEDURE_CODE
, C_CLAIM_STATUS_CODE
, C_CLAIM_ADJUSTMENT_CODE
, C_NATIONAL_DRUG_CODE
, C_TYPE_OF_COVERAGE
, sysdate
, sysdate 
, 'I'
from fedqic_claim_stg cstg      
where not exists (select 1 from corp_etl_claim clm where clm.claim_id = cstg.id)
and exists (select 1 from corp_etl_appeal app where app.appeal_id = cstg.id_parent);


--insert record from wip into etl_appeal table	
INSERT INTO corp_etl_claim
SELECT
  CECLM_ID
, APPEAL_ID
, CLAIM_ID 
, CLAIM_NUMBER  
, HCPCS_CODE 
, ACTION_CODE   
, APPELLANT_ARGUMENT  
, DISPOSITION 
, DISPOSITION_EXPLANATION     
, REVERSAL_REASON 
, PROCEDURAL_DECISION_REASON   
, SUBSTANTIVE_REASON  
, CITATION_SOURCE  
, PROVIDER
, PROVIDER_NAME
, CLAIM_DIAGNOSIS_CODES
, CLAIM_PROCEDURE_CODES
, CLAIM_STATUS_CODE
, CLAIM_ADJUSTMENT_CODE
, NATIONAL_DRUG_CODE
, TYPE_OF_COVERAGE
, STG_EXTRACT_DATE
, STG_LAST_UPDATE_DATE
FROM corp_etl_claim_wip cwip WHERE cwip.change_flag = 'I';

COMMIT;      

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Insert_New_Claim', 'ETL COMMIT', g_Error);
      COMMIT;
      RAISE;

END Insert_New_Claims;

PROCEDURE Update_Claims
IS

BEGIN
       

UPDATE 
(SELECT 
fac.ID_PARENT as FAC_APPEAL_ID
, fac.C_CLAIM_NUMBER as FAC_CLAIM_NUMBER 
, fac.C_HCPCS_CPT_CODE as FAC_HCPCS_CODE 
, fac.C_VMS_REASON_CODE as FAC_ACTION_CODE
, fac.C_APPELLANT_ARGUMENT as FAC_APPELLANT_ARGUMENT
, fac.C_DISPOSITION as FAC_DISPOSITION
, fac.C_DISPOSITION_EXPLANATION as FAC_DISPOSITION_EXPLANATION     
, fac.C_REVERSAL_REASON as FAC_REVERSAL_REASON
, fac.C_PROCEDURAL_DECISION_REASON as FAC_PROCEDURAL_DECISION_REASON 
, fac.C_SUBSTANTIVE_REASON as FAC_SUBSTANTIVE_REASON
, fac.C_CITATION_SOURCE  as FAC_CITATION_SOURCE
, fac.C_PROVIDER as FAC_PROVIDER
, fac.C_PROVIDER_NAME as FAC_PROVIDER_NAME
, fac.C_DIAGNOSIS_CODE as FAC_DIAGNOSIS_CODE
, fac.C_PROCEDURE_CODE as FAC_PROCEDURE_CODE
, fac.C_CLAIM_STATUS_CODE as FAC_CLAIM_STATUS_CODE
, fac.C_CLAIM_ADJUSTMENT_CODE as FAC_CLAIM_ADJUSTMENT_CODE
, fac.C_NATIONAL_DRUG_CODE as FAC_NATIONAL_DRUG_CODE
, fac.C_TYPE_OF_COVERAGE as FAC_TYPE_OF_COVERAGE
, cwip.APPEAL_ID as CWIP_APPEAL_ID
, cwip.CLAIM_NUMBER as CWIP_CLAIM_NUMBER
, cwip.HCPCS_CODE as CWIP_HCPCS_CODE
, cwip.ACTION_CODE as CWIP_ACTION_CODE   
, cwip.APPELLANT_ARGUMENT as CWIP_APPELLANT_ARGUMENT 
, cwip.DISPOSITION as CWIP_DISPOSITION
, cwip.DISPOSITION_EXPLANATION as CWIP_DISPOSITION_EXPLANATION    
, cwip.REVERSAL_REASON as CWIP_REVERSAL_REASON
, cwip.PROCEDURAL_DECISION_REASON as CWIP_PROCEDURAL_DECISION_REASON  
, cwip.SUBSTANTIVE_REASON as CWIP_SUBSTANTIVE_REASON 
, cwip.CITATION_SOURCE as CWIP_CITATION_SOURCE 
, cwip.PROVIDER as CWIP_PROVIDER
, cwip.PROVIDER_NAME as CWIP_PROVIDER_NAME
, cwip.CLAIM_DIAGNOSIS_CODES as CWIP_CLAIM_DIAGNOSIS_CODES
, cwip.CLAIM_PROCEDURE_CODES as CWIP_CLAIM_PROCEDURE_CODES
, cwip.CLAIM_STATUS_CODE as CWIP_CLAIM_STATUS_CODE
, cwip.CLAIM_ADJUSTMENT_CODE as CWIP_CLAIM_ADJUSTMENT_CODE
, cwip.NATIONAL_DRUG_CODE as CWIP_NATIONAL_DRUG_CODE
, cwip.TYPE_OF_COVERAGE as CWIP_TYPE_OF_COVERAGE
, cwip.STG_LAST_UPDATE_DATE as CWIP_STG_LAST_UPDATE_DATE
, cwip.change_flag as CWIP_CHANGE_FLAG
FROM fedqic_claim_stg fac
,corp_etl_claim_wip cwip
WHERE  fac.id = cwip.claim_id )
set cwip_APPEAL_ID = FAC_APPEAL_ID,
CWIP_CLAIM_NUMBER = FAC_CLAIM_NUMBER,
CWIP_HCPCS_CODE = FAC_HCPCS_CODE,
CWIP_ACTION_CODE = FAC_ACTION_CODE,  
CWIP_APPELLANT_ARGUMENT = FAC_APPELLANT_ARGUMENT,
CWIP_DISPOSITION = FAC_DISPOSITION,
CWIP_DISPOSITION_EXPLANATION = FAC_DISPOSITION_EXPLANATION,   
CWIP_REVERSAL_REASON = FAC_REVERSAL_REASON,
CWIP_PROCEDURAL_DECISION_REASON = FAC_PROCEDURAL_DECISION_REASON, 
CWIP_SUBSTANTIVE_REASON = FAC_SUBSTANTIVE_REASON,
CWIP_CITATION_SOURCE = FAC_CITATION_SOURCE,
CWIP_PROVIDER = FAC_PROVIDER,
CWIP_PROVIDER_NAME = FAC_PROVIDER_NAME,
CWIP_CLAIM_DIAGNOSIS_CODES = FAC_DIAGNOSIS_CODE,
CWIP_CLAIM_PROCEDURE_CODES = FAC_PROCEDURE_CODE,
CWIP_CLAIM_STATUS_CODE = FAC_CLAIM_STATUS_CODE,
CWIP_CLAIM_ADJUSTMENT_CODE = FAC_CLAIM_ADJUSTMENT_CODE,
CWIP_NATIONAL_DRUG_CODE = FAC_NATIONAL_DRUG_CODE,
CWIP_TYPE_OF_COVERAGE = FAC_TYPE_OF_COVERAGE,
cwip_STG_LAST_UPDATE_DATE = sysdate,
cwip_change_flag = 'Y'
where cwip_change_flag = 'N'
AND (decode(CWIP_APPEAL_ID,FAC_APPEAL_ID,1,0) = 0
OR decode(CWIP_CLAIM_NUMBER,FAC_CLAIM_NUMBER,1,0) = 0
OR decode (CWIP_HCPCS_CODE,FAC_HCPCS_CODE,1,0)=0
OR decode (CWIP_ACTION_CODE,FAC_ACTION_CODE,1,0)=0  
OR decode (CWIP_APPELLANT_ARGUMENT,FAC_APPELLANT_ARGUMENT,1,0)=0
OR decode (CWIP_DISPOSITION,FAC_DISPOSITION,1,0)=0
OR decode (CWIP_DISPOSITION_EXPLANATION,FAC_DISPOSITION_EXPLANATION,1,0)=0   
OR decode (CWIP_REVERSAL_REASON,FAC_REVERSAL_REASON,1,0)=0
OR decode (CWIP_PROCEDURAL_DECISION_REASON,FAC_PROCEDURAL_DECISION_REASON,1,0)=0 
OR decode (CWIP_SUBSTANTIVE_REASON,FAC_SUBSTANTIVE_REASON,1,0)=0
OR decode (CWIP_CITATION_SOURCE,FAC_CITATION_SOURCE,1,0)=0
OR decode (CWIP_PROVIDER,FAC_PROVIDER,1,0)=0
OR decode (CWIP_PROVIDER_NAME,FAC_PROVIDER_NAME,1,0)=0
OR decode (CWIP_CLAIM_DIAGNOSIS_CODES,FAC_DIAGNOSIS_CODE,1,0)=0
OR decode (CWIP_CLAIM_PROCEDURE_CODES,FAC_PROCEDURE_CODE,1,0)=0
OR decode (CWIP_CLAIM_STATUS_CODE,FAC_CLAIM_STATUS_CODE,1,0)=0
OR decode (CWIP_CLAIM_ADJUSTMENT_CODE,FAC_CLAIM_ADJUSTMENT_CODE,1,0)=0
OR decode (CWIP_NATIONAL_DRUG_CODE,FAC_NATIONAL_DRUG_CODE,1,0)=0
OR decode (CWIP_TYPE_OF_COVERAGE,FAC_TYPE_OF_COVERAGE,1,0)=0
);

COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Insert_Update_Claim', 'fedqic Claims', g_Error);
      COMMIT;
      RAISE;

END Update_Claims;

PROCEDURE CLAIM_UPDATE_MAIN_TABLE AS

 CURSOR wip_cur IS
   SELECT * FROM corp_etl_claim_wip
   WHERE CHANGE_FLAG = 'Y';

   TYPE t_wip_tab IS TABLE OF wip_cur%ROWTYPE INDEX BY PLS_INTEGER;
    wip_tab t_wip_tab;
    v_bulk_limit NUMBER := 1000;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    --v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
    vPROC VARCHAR2(30) := 'CLAIM_UPDATE_MAIN_TABLE';
BEGIN
   v_step :=  gPKG||'.'||vPROC||' - Updateing Main table';
   OPEN wip_cur;
   LOOP
     FETCH wip_cur BULK COLLECT INTO wip_tab LIMIT v_bulk_limit;
     EXIT WHEN wip_tab.COUNT = 0; -- Exit when missing rows

BEGIN
FORALL indx IN 1 .. wip_tab.COUNT SAVE EXCEPTIONS
UPDATE corp_etl_claim
SET 
APPEAL_ID = wip_tab(indx).APPEAL_ID     
,  CLAIM_NUMBER = wip_tab(indx).CLAIM_NUMBER
,  HCPCS_CODE = wip_tab(indx).HCPCS_CODE
,  ACTION_CODE = wip_tab(indx).ACTION_CODE
,  APPELLANT_ARGUMENT = wip_tab(indx).APPELLANT_ARGUMENT
,  DISPOSITION = wip_tab(indx).DISPOSITION  
,  DISPOSITION_EXPLANATION = wip_tab(indx).DISPOSITION_EXPLANATION 
,  REVERSAL_REASON = wip_tab(indx).REVERSAL_REASON 
,  PROCEDURAL_DECISION_REASON = wip_tab(indx).PROCEDURAL_DECISION_REASON 
,  SUBSTANTIVE_REASON = wip_tab(indx).SUBSTANTIVE_REASON  
,  CITATION_SOURCE = wip_tab(indx).CITATION_SOURCE 
,  PROVIDER = wip_tab(indx).PROVIDER
,  PROVIDER_NAME = wip_tab(indx).PROVIDER_NAME
,  CLAIM_DIAGNOSIS_CODES = wip_tab(indx).CLAIM_DIAGNOSIS_CODES
,  CLAIM_PROCEDURE_CODES = wip_tab(indx).CLAIM_PROCEDURE_CODES
,  CLAIM_STATUS_CODE = wip_tab(indx).CLAIM_STATUS_CODE         
,  CLAIM_ADJUSTMENT_CODE = wip_tab(indx).CLAIM_ADJUSTMENT_CODE
,  NATIONAL_DRUG_CODE = wip_tab(indx).NATIONAL_DRUG_CODE
,  TYPE_OF_COVERAGE = wip_tab(indx).TYPE_OF_COVERAGE
, STG_EXTRACT_DATE = wip_tab(indx).STG_EXTRACT_DATE
, STG_LAST_UPDATE_DATE = wip_tab(indx).STG_LAST_UPDATE_DATE
WHERE CECLM_ID  =  wip_tab(indx).CECLM_ID;

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
                     'ETL APPEAL',--PROCESS_NAME
                     'CLAIM_UPDATE_MAIN_TABLE',--JOB_NAME
                     '1',--NR_OF_ERROR
                     v_step, --||' '||v_err_msg,--ERROR_DESC
                     null,--ERROR_FIELD
                     v_err_code,--ERROR_CODES
                     sysdate,--CREATE_TS
                     sysdate,--UPDATE_TS
                     'CORP_ETL_CLAIM',--DRIVER_TABLE_NAME
                     v_err_index);--DRIVER_KEY_NUMBER
            END LOOP;
          END IF;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE wip_cur;
END CLAIM_UPDATE_MAIN_TABLE;

END fedqic_etl_claim_pkg;

/

alter session set plsql_code_type = interpreted;