alter session set plsql_code_type = native;

CREATE OR REPLACE PACKAGE fedqic_etl_document_pkg IS
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

   PROCEDURE Insert_New_Documents;         --<< Inserts new records into corp_etl_appeal_wip

   PROCEDURE Update_Documents;         --<< updates records in corp_etl_appeal_wip

   PROCEDURE DOCUMENT_UPDATE_MAIN_TABLE;   --<< updates corp_etl_appeal from corp_etl_appeal_wip records	

/*
|| Functions
*/

   FUNCTION Get_Person_ID
            (p_user_id in number)
     RETURN number parallel_enable;


END fedqic_etl_document_pkg;
/

CREATE OR REPLACE PACKAGE BODY fedqic_etl_document_pkg IS
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
   -- Remove any old records from tmp table
   DELETE FROM corp_etl_document_wip;
   COMMIT;

   --populate tmp table with records from corp_etl_appeal

INSERT INTO corp_etl_document_wip 
SELECT 
CEDOC_ID,
APPEAL_ID,
DOCUMENT_ID,
DOCUMENT_TYPE,
ICN,
SOURCE,  
MAILED_DATE, 
DUE_DATE,
UPLOADED_DATE,  
DOCUMENT_CLAIMED_DATE, 
SCANNED_DATE,
CLASSIFIED_DATE, 
ASSOCIATED_DATE,  
DATE_RECEIVED, 
REQUEST_INFORMATION,
REQUEST_SENT_TO,
REQUESTOR,
DATE_OF_REQUEST,
STG_EXTRACT_DATE,
STG_LAST_UPDATE_DATE
, 'N' as change_flag
FROM corp_etl_document;
      
commit;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('INIT', 'fedqic Document', g_Error);
      COMMIT;
      RAISE;
END InitProcess;

/*
|| Procedure to insert into/update corp_etl_appeal
||   
*/

PROCEDURE Insert_New_Documents
IS

BEGIN

--insert new record into appeal_wip

INSERT INTO corp_etl_document_wip (
APPEAL_ID,
DOCUMENT_ID,
DOCUMENT_TYPE,
ICN,
SOURCE,  
MAILED_DATE, 
DUE_DATE,
UPLOADED_DATE,  
DOCUMENT_CLAIMED_DATE, 
SCANNED_DATE,
CLASSIFIED_DATE, 
ASSOCIATED_DATE,  
DATE_RECEIVED, 
REQUEST_INFORMATION,
REQUEST_SENT_TO,
REQUESTOR,
DATE_OF_REQUEST,
STG_EXTRACT_DATE,
STG_LAST_UPDATE_DATE,
change_flag
)
SELECT 
ID_PARENT
, ID
, C_DOCUMENT_TYPE 
, C_ICN 
, C_SOURCE  
, C_MAILED_DATE 
, C_DUE_DATE
, C_UPLOADED_DATE  
, C_DOCUMENT_CLAIMED_DATE
, C_DATE_SCANNED 
, C_CLASSIFIED_DATE 
, C_ASSOCIATED_DATE  
, C_DATE_RECEIVED 
, C_REQUESTED_INFORMATION  
, C_REQUEST_SENT_TO 
, Get_Person_ID(C_REQUESTOR)   
, C_DATE_OF_REQUEST 
, sysdate 
, sysdate 
, 'I' 
from fedqic_document_stg dstg      
where not exists (select 1 from corp_etl_document doc where doc.document_id = dstg.id);


--insert record from wip into etl_appeal table	
INSERT INTO corp_etl_document
SELECT
CEDOC_ID,
APPEAL_ID,
DOCUMENT_ID,
DOCUMENT_TYPE,
ICN,
SOURCE,  
MAILED_DATE, 
DUE_DATE,
UPLOADED_DATE,  
DOCUMENT_CLAIMED_DATE, 
SCANNED_DATE,
CLASSIFIED_DATE, 
ASSOCIATED_DATE,  
DATE_RECEIVED, 
REQUEST_INFORMATION,
REQUEST_SENT_TO,
REQUESTOR,
DATE_OF_REQUEST,
STG_EXTRACT_DATE,
STG_LAST_UPDATE_DATE
FROM corp_etl_document_wip dwip WHERE dwip.change_flag = 'I';

COMMIT;      

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Insert_New_Task', 'ETL COMMIT', g_Error);
      COMMIT;
      RAISE;

END Insert_New_Documents;

PROCEDURE Update_Documents
IS

BEGIN
       

UPDATE 
(SELECT 
fad.ID_PARENT as FAD_APPEAL_ID
, fad.C_DOCUMENT_TYPE as FAD_DOCUMENT_TYPE
, fad.C_ICN as FAD_ICN
, fad.C_SOURCE as FAD_SOURCE 
, fad.C_MAILED_DATE as FAD_MAILED_DATE 
, fad.C_DUE_DATE as FAD_DUE_DATE 
, fad.C_UPLOADED_DATE as FAD_UPLOADED_DATE 
, fad.C_DOCUMENT_CLAIMED_DATE as FAD_DOCUMENT_CLAIMED_DATE
, fad.C_DATE_SCANNED as FAD_DATE_SCANNED 
, fad.C_CLASSIFIED_DATE as FAD_CLASSIFIED_DATE  
, fad.C_ASSOCIATED_DATE as FAD_ASSOCIATED_DATE   
, fad.C_DATE_RECEIVED as FAD_DATE_RECEIVED  
, fad.C_REQUESTED_INFORMATION as FAD_REQUESTED_INFORMATION   
, fad.C_REQUEST_SENT_TO as FAD_REQUEST_SENT_TO  
, Get_Person_ID(fad.C_REQUESTOR) as FAD_REQUESTOR 
, fad.C_DATE_OF_REQUEST as FAD_DATE_OF_REQUEST   
,dwip.APPEAL_ID as DWIP_APPEAL_ID,
dwip.DOCUMENT_TYPE as DWIP_DOCUMENT_TYPE,
dwip.ICN as DWIP_ICN,
dwip.SOURCE as DWIP_SOURCE,  
dwip.MAILED_DATE as DWIP_MAILED_DATE, 
dwip.DUE_DATE as DWIP_DUE_DATE,
dwip.UPLOADED_DATE as DWIP_UPLOADED_DATE,  
dwip.DOCUMENT_CLAIMED_DATE as DWIP_DOCUMENT_CLAIMED_DATE, 
dwip.SCANNED_DATE as DWIP_SCANNED_DATE,
dwip.CLASSIFIED_DATE as DWIP_CLASSIFIED_DATE, 
dwip.ASSOCIATED_DATE as DWIP_ASSOCIATED_DATE,  
dwip.DATE_RECEIVED as DWIP_DATE_RECEIVED, 
dwip.REQUEST_INFORMATION as DWIP_REQUEST_INFORMATION,
dwip.REQUEST_SENT_TO as DWIP_REQUEST_SENT_TO,
dwip.REQUESTOR as DWIP_REQUESTOR,
dwip.DATE_OF_REQUEST as DWIP_DATE_OF_REQUEST,
dwip.STG_LAST_UPDATE_DATE as DWIP_STG_LAST_UPDATE_DATE,
dwip.change_flag as dwip_change_flag
FROM fedqic_document_stg fad
,corp_etl_document_wip dwip
WHERE  fad.id = dwip.document_id )
set dwip_APPEAL_ID = FAD_APPEAL_ID,
dwip_DOCUMENT_TYPE = FAD_DOCUMENT_TYPE,
dwip_ICN = FAD_ICN,
dwip_SOURCE = FAD_SOURCE,  
dwip_MAILED_DATE = FAD_MAILED_DATE, 
dwip_DUE_DATE = FAD_DUE_DATE,
dwip_UPLOADED_DATE = FAD_UPLOADED_DATE,  
dwip_DOCUMENT_CLAIMED_DATE = FAD_DOCUMENT_CLAIMED_DATE, 
dwip_SCANNED_DATE = FAD_DATE_SCANNED,
dwip_CLASSIFIED_DATE = FAD_CLASSIFIED_DATE, 
dwip_ASSOCIATED_DATE = FAD_ASSOCIATED_DATE,  
dwip_DATE_RECEIVED = FAD_DATE_RECEIVED, 
dwip_REQUEST_INFORMATION = FAD_REQUESTED_INFORMATION,
dwip_REQUEST_SENT_TO = FAD_REQUEST_SENT_TO,
dwip_REQUESTOR = FAD_REQUESTOR,
dwip_DATE_OF_REQUEST = FAD_DATE_OF_REQUEST,
dwip_STG_LAST_UPDATE_DATE = sysdate,
dwip_change_flag = 'Y'
where dwip_change_flag = 'N'
AND (decode(DWIP_APPEAL_ID,FAD_APPEAL_ID,1,0) = 0
OR decode(DWIP_DOCUMENT_TYPE,FAD_DOCUMENT_TYPE,1,0) = 0
OR decode(DWIP_ICN,FAD_ICN,1,0) = 0
OR decode(DWIP_SOURCE,FAD_SOURCE,1,0) = 0
OR decode(DWIP_MAILED_DATE,FAD_MAILED_DATE,1,0) = 0
OR decode(DWIP_DUE_DATE,FAD_DUE_DATE,1,0) = 0
OR decode(DWIP_UPLOADED_DATE,FAD_UPLOADED_DATE,1,0) = 0
OR decode(DWIP_DOCUMENT_CLAIMED_DATE,FAD_DOCUMENT_CLAIMED_DATE,1,0) = 0
OR decode(DWIP_SCANNED_DATE,FAD_DATE_SCANNED,1,0) = 0
OR decode(DWIP_CLASSIFIED_DATE,FAD_CLASSIFIED_DATE,1,0) = 0
OR decode(DWIP_ASSOCIATED_DATE,FAD_ASSOCIATED_DATE,1,0) = 0
OR decode(DWIP_DATE_RECEIVED,FAD_DATE_RECEIVED,1,0) = 0
OR decode(DWIP_REQUEST_INFORMATION,FAD_REQUESTED_INFORMATION,1,0) = 0
OR decode(DWIP_REQUEST_SENT_TO,FAD_REQUEST_SENT_TO,1,0) = 0
OR decode(DWIP_REQUESTOR,FAD_REQUESTOR,1,0) = 0
OR decode(DWIP_DATE_OF_REQUEST,FAD_DATE_OF_REQUEST,1,0) = 0
);

COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Insert_Update_Task', 'fedqic Docs', g_Error);
      COMMIT;
      RAISE;

END Update_Documents;

PROCEDURE DOCUMENT_UPDATE_MAIN_TABLE AS

 CURSOR wip_cur IS
   SELECT * FROM corp_etl_document_wip
   WHERE CHANGE_FLAG = 'Y';

   TYPE t_wip_tab IS TABLE OF wip_cur%ROWTYPE INDEX BY PLS_INTEGER;
    wip_tab t_wip_tab;
    v_bulk_limit NUMBER := 1000;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    --v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
    vPROC VARCHAR2(30) := 'DOCUMENT_UPDATE_MAIN_TABLE';
BEGIN
   v_step :=  gPKG||'.'||vPROC||' - Updateing Main table';
   OPEN wip_cur;
   LOOP
     FETCH wip_cur BULK COLLECT INTO wip_tab LIMIT v_bulk_limit;
     EXIT WHEN wip_tab.COUNT = 0; -- Exit when missing rows

BEGIN
FORALL indx IN 1 .. wip_tab.COUNT SAVE EXCEPTIONS
UPDATE corp_etl_document
SET 
APPEAL_ID = wip_tab(indx).APPEAL_ID     
, DOCUMENT_TYPE = wip_tab(indx).DOCUMENT_TYPE
, ICN = wip_tab(indx).ICN 
, SOURCE = wip_tab(indx).SOURCE
, MAILED_DATE = wip_tab(indx).MAILED_DATE
, DUE_DATE = wip_tab(indx).DUE_DATE
, UPLOADED_DATE = wip_tab(indx).UPLOADED_DATE  
, DOCUMENT_CLAIMED_DATE = wip_tab(indx).DOCUMENT_CLAIMED_DATE 
, SCANNED_DATE = wip_tab(indx).SCANNED_DATE 
, CLASSIFIED_DATE= wip_tab(indx).CLASSIFIED_DATE 
, ASSOCIATED_DATE = wip_tab(indx).ASSOCIATED_DATE  
, DATE_RECEIVED = wip_tab(indx).DATE_RECEIVED 
, REQUEST_INFORMATION = wip_tab(indx).REQUEST_INFORMATION
, REQUEST_SENT_TO = wip_tab(indx).REQUEST_SENT_TO
, REQUESTOR = wip_tab(indx).REQUESTOR
, DATE_OF_REQUEST = wip_tab(indx).DATE_OF_REQUEST
, STG_EXTRACT_DATE = wip_tab(indx).STG_EXTRACT_DATE
, STG_LAST_UPDATE_DATE = wip_tab(indx).STG_LAST_UPDATE_DATE
WHERE CEDOC_ID  =  wip_tab(indx).CEDOC_ID;

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
                     'DOCUMENT_UPDATE_MAIN_TABLE',--JOB_NAME
                     '1',--NR_OF_ERROR
                     v_step, --||' '||v_err_msg,--ERROR_DESC
                     null,--ERROR_FIELD
                     v_err_code,--ERROR_CODES
                     sysdate,--CREATE_TS
                     sysdate,--UPDATE_TS
                     'CORP_ETL_DOCUMENT',--DRIVER_TABLE_NAME
                     v_err_index);--DRIVER_KEY_NUMBER
            END LOOP;
          END IF;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE wip_cur;
END DOCUMENT_UPDATE_MAIN_TABLE;

END fedqic_etl_document_pkg;

/

alter session set plsql_code_type = interpreted;