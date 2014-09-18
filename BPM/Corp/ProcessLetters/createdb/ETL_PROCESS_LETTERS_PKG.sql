alter session set plsql_code_type = native;

create or replace package ETL_PROCESS_LETTERS_PKG as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.

  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';
  
  
  procedure PL_POPULATE_TEMP_TBLS;
  
  procedure PL_UPDATE_MAIN_TABLE;
  
end;
/    

create or replace package body ETL_PROCESS_LETTERS_PKG as

PROCEDURE PL_POPULATE_TEMP_TBLS AS
 
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN
    
   execute immediate 'truncate table CORP_ETL_PROC_LETTERS_OLTP';

insert into CORP_ETL_PROC_LETTERS_OLTP
(
CEPN_ID   
, LETTER_REQUEST_ID   
, CREATE_DT   
, CREATE_BY  
, REQUEST_DT  
, LETTER_TYPE 
, PROGRAM  
, CASE_ID 
, COUNTY_CODE  
, ZIP_CODE 
, LANGUAGE  
, REPRINT  
, REQUEST_DRIVER_TYPE 
, REQUEST_DRIVER_TABLE 
, STATUS 
, STATUS_DT   
, SENT_DT 
, PRINT_DT 
, MAILED_DT 
, RETURN_DT  
, RETURN_REASON 
, REJECT_REASON 
, ERROR_REASON  
, TRANSMIT_FILE_NAME 
, TRANSMIT_FILE_DT 
, LETTER_RESP_FILE_NAME  
, LETTER_RESP_FILE_DT 
, LAST_UPDATE_DT  
, LAST_UPDATE_BY_NAME  
, NEWBORN_FLAG  
, TASK_ID 
, CANCEL_DT 
, CANCEL_BY  
, COMPLETE_DT  
, INSTANCE_STATUS  
, ASSD_PROCESS_LETTER_REQ 
, ASED_PROCESS_LETTER_REQ 
, ASSD_TRANSMIT  
, ASED_TRANSMIT  
, ASSD_RECEIVE_CONFIRMATION 
, ASED_RECEIVE_CONFIRMATION 
, ASSD_CREATE_ROUTE_WORK 
, ASED_CREATE_ROUTE_WORK  
, ASF_PROCESS_LETTER_REQ  
, ASF_TRANSMIT  
, ASF_RECEIVE_CONFIRMATION  
, ASF_CREATE_ROUTE_WORK  
, GWF_VALID 
, GWF_OUTCOME 
, GWF_WORK_REQUIRED 
, STG_EXTRACT_DATE   
, STG_LAST_UPDATE_DATE   
, STAGE_DONE_DATE 
, STG_INSERT_UPDATE
, MATERIAL_REQUEST_ID 
, FAMILY_MEMBER_COUNT 
, AIAN_MEMBER_COUNT  
--, STG_INSERT_JOB_ID
)
select CEPN_ID   
, LETTER_REQUEST_ID   
, CREATE_DT   
, CREATE_BY  
, REQUEST_DT  
, LETTER_TYPE 
, PROGRAM  
, CASE_ID 
, COUNTY_CODE  
, ZIP_CODE 
, LANGUAGE  
, REPRINT  
, REQUEST_DRIVER_TYPE 
, REQUEST_DRIVER_TABLE 
, STATUS 
, STATUS_DT   
, SENT_DT 
, PRINT_DT 
, MAILED_DT 
, RETURN_DT  
, RETURN_REASON 
, REJECT_REASON 
, ERROR_REASON  
, TRANSMIT_FILE_NAME 
, TRANSMIT_FILE_DT 
, LETTER_RESP_FILE_NAME  
, LETTER_RESP_FILE_DT 
, LAST_UPDATE_DT  
, LAST_UPDATE_BY_NAME  
, NEWBORN_FLAG  
, TASK_ID 
, CANCEL_DT 
, CANCEL_BY  
, COMPLETE_DT  
, INSTANCE_STATUS  
, ASSD_PROCESS_LETTER_REQ 
, ASED_PROCESS_LETTER_REQ 
, ASSD_TRANSMIT  
, ASED_TRANSMIT  
, ASSD_RECEIVE_CONFIRMATION 
, ASED_RECEIVE_CONFIRMATION 
, ASSD_CREATE_ROUTE_WORK 
, ASED_CREATE_ROUTE_WORK  
, ASF_PROCESS_LETTER_REQ  
, ASF_TRANSMIT  
, ASF_RECEIVE_CONFIRMATION  
, ASF_CREATE_ROUTE_WORK  
, GWF_VALID 
, GWF_OUTCOME 
, GWF_WORK_REQUIRED 
, STG_EXTRACT_DATE   
, STG_LAST_UPDATE_DATE   
, STAGE_DONE_DATE 
, 'I'	STG_INSERT_UPDATE
--, ${ETL_JOBID} STG_INSERT_JOB_ID
, MATERIAL_REQUEST_ID 
, FAMILY_MEMBER_COUNT 
, AIAN_MEMBER_COUNT 
from CORP_ETL_PROC_LETTERS
where instance_status = 'Active';
commit;


execute immediate 'truncate table CORP_ETL_PROC_LETTERS_WIP_BPM';

insert into CORP_ETL_PROC_LETTERS_WIP_BPM
(
CEPN_ID   
, LETTER_REQUEST_ID   
, CREATE_DT   
, CREATE_BY  
, REQUEST_DT  
, LETTER_TYPE 
, PROGRAM  
, CASE_ID 
, COUNTY_CODE  
, ZIP_CODE 
, LANGUAGE  
, REPRINT  
, REQUEST_DRIVER_TYPE 
, REQUEST_DRIVER_TABLE 
, STATUS 
, STATUS_DT   
, SENT_DT 
, PRINT_DT 
, MAILED_DT 
, RETURN_DT  
, RETURN_REASON 
, REJECT_REASON 
, ERROR_REASON  
, TRANSMIT_FILE_NAME 
, TRANSMIT_FILE_DT 
, LETTER_RESP_FILE_NAME  
, LETTER_RESP_FILE_DT 
, LAST_UPDATE_DT  
, LAST_UPDATE_BY_NAME  
, NEWBORN_FLAG  
, TASK_ID 
, CANCEL_DT 
, CANCEL_BY  
, COMPLETE_DT  
, INSTANCE_STATUS  
, ASSD_PROCESS_LETTER_REQ 
, ASED_PROCESS_LETTER_REQ 
, ASSD_TRANSMIT  
, ASED_TRANSMIT  
, ASSD_RECEIVE_CONFIRMATION 
, ASED_RECEIVE_CONFIRMATION 
, ASSD_CREATE_ROUTE_WORK 
, ASED_CREATE_ROUTE_WORK  
, ASF_PROCESS_LETTER_REQ  
, ASF_TRANSMIT  
, ASF_RECEIVE_CONFIRMATION  
, ASF_CREATE_ROUTE_WORK  
, GWF_VALID 
, GWF_OUTCOME 
, GWF_WORK_REQUIRED 
, STG_EXTRACT_DATE   
, STG_LAST_UPDATE_DATE   
, STAGE_DONE_DATE 
, MATERIAL_REQUEST_ID 
, FAMILY_MEMBER_COUNT 
, AIAN_MEMBER_COUNT 
)
select CEPN_ID   
, LETTER_REQUEST_ID   
, CREATE_DT   
, CREATE_BY  
, REQUEST_DT  
, LETTER_TYPE 
, PROGRAM  
, CASE_ID 
, COUNTY_CODE  
, ZIP_CODE 
, LANGUAGE  
, REPRINT  
, REQUEST_DRIVER_TYPE 
, REQUEST_DRIVER_TABLE 
, STATUS 
, STATUS_DT   
, SENT_DT 
, PRINT_DT 
, MAILED_DT 
, RETURN_DT  
, RETURN_REASON 
, REJECT_REASON 
, ERROR_REASON  
, TRANSMIT_FILE_NAME 
, TRANSMIT_FILE_DT 
, LETTER_RESP_FILE_NAME  
, LETTER_RESP_FILE_DT 
, LAST_UPDATE_DT  
, LAST_UPDATE_BY_NAME  
, NEWBORN_FLAG  
, TASK_ID 
, CANCEL_DT 
, CANCEL_BY  
, COMPLETE_DT  
, INSTANCE_STATUS  
, ASSD_PROCESS_LETTER_REQ 
, ASED_PROCESS_LETTER_REQ 
, ASSD_TRANSMIT  
, ASED_TRANSMIT  
, ASSD_RECEIVE_CONFIRMATION 
, ASED_RECEIVE_CONFIRMATION 
, ASSD_CREATE_ROUTE_WORK 
, ASED_CREATE_ROUTE_WORK  
, ASF_PROCESS_LETTER_REQ  
, ASF_TRANSMIT  
, ASF_RECEIVE_CONFIRMATION  
, ASF_CREATE_ROUTE_WORK  
, GWF_VALID 
, GWF_OUTCOME 
, GWF_WORK_REQUIRED 
, STG_EXTRACT_DATE   
, STG_LAST_UPDATE_DATE   
, STAGE_DONE_DATE 
, MATERIAL_REQUEST_ID 
, FAMILY_MEMBER_COUNT 
, AIAN_MEMBER_COUNT 
from CORP_ETL_PROC_LETTERS
where instance_status = 'Active';
commit;

END PL_POPULATE_TEMP_TBLS;


PROCEDURE PL_UPDATE_MAIN_TABLE AS

 cursor wip_cur is
(
select   CEPN_ID   
, LETTER_REQUEST_ID   
, CREATE_DT   
, CREATE_BY  
, REQUEST_DT  
, LETTER_TYPE 
, PROGRAM  
, CASE_ID 
, COUNTY_CODE  
, ZIP_CODE 
, LANGUAGE  
, REPRINT  
, REQUEST_DRIVER_TYPE 
, REQUEST_DRIVER_TABLE 
, STATUS 
, STATUS_DT   
, SENT_DT 
, PRINT_DT 
, MAILED_DT 
, RETURN_DT  
, RETURN_REASON 
, REJECT_REASON 
, ERROR_REASON  
, TRANSMIT_FILE_NAME 
, TRANSMIT_FILE_DT 
, LETTER_RESP_FILE_NAME  
, LETTER_RESP_FILE_DT 
, LAST_UPDATE_DT  
, LAST_UPDATE_BY_NAME  
, NEWBORN_FLAG  
, TASK_ID 
, CANCEL_DT 
, CANCEL_BY  
, COMPLETE_DT  
, INSTANCE_STATUS  
, ASSD_PROCESS_LETTER_REQ 
, ASED_PROCESS_LETTER_REQ 
, ASSD_TRANSMIT  
, ASED_TRANSMIT  
, ASSD_RECEIVE_CONFIRMATION 
, ASED_RECEIVE_CONFIRMATION 
, ASSD_CREATE_ROUTE_WORK 
, ASED_CREATE_ROUTE_WORK  
, ASF_PROCESS_LETTER_REQ  
, ASF_TRANSMIT  
, ASF_RECEIVE_CONFIRMATION  
, ASF_CREATE_ROUTE_WORK  
, GWF_VALID 
, GWF_OUTCOME 
, GWF_WORK_REQUIRED 
, STG_EXTRACT_DATE   
, STG_LAST_UPDATE_DATE   
, STAGE_DONE_DATE 
, MATERIAL_REQUEST_ID 
, FAMILY_MEMBER_COUNT 
, AIAN_MEMBER_COUNT 
  from CORP_ETL_PROC_LETTERS_WIP_BPM
where updated = 'Y');
   
   TYPE t_wip_tab IS TABLE OF wip_cur%ROWTYPE INDEX BY PLS_INTEGER;
    wip_tab t_wip_tab;
    v_bulk_limit NUMBER := 500;    
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN
    
   OPEN wip_cur;
   LOOP
     FETCH wip_cur BULK COLLECT INTO wip_tab LIMIT v_bulk_limit;
     EXIT WHEN wip_tab.COUNT = 0; -- Exit when missing rows
     
     BEGIN
       FORALL indx IN 1 .. wip_tab.COUNT SAVE EXCEPTIONS         
         update CORP_ETL_PROC_LETTERS
     set 
  CEPN_ID   	  					      =  wip_tab(indx).CEPN_ID   
, LETTER_REQUEST_ID   	    		= wip_tab(indx).LETTER_REQUEST_ID   
, CREATE_DT   	    				    = wip_tab(indx).CREATE_DT   
, CREATE_BY  	    				      = wip_tab(indx).CREATE_BY  
, REQUEST_DT  	    				    = wip_tab(indx).REQUEST_DT  
, LETTER_TYPE 	    				    = wip_tab(indx).LETTER_TYPE 
, PROGRAM  	    					      = wip_tab(indx).PROGRAM  
, CASE_ID 	    					      = wip_tab(indx).CASE_ID 
, COUNTY_CODE  	    				    = wip_tab(indx).COUNTY_CODE  
, ZIP_CODE 	    					      = wip_tab(indx).ZIP_CODE 
, LANGUAGE  	    				      = wip_tab(indx).LANGUAGE  
, REPRINT  	    					      = wip_tab(indx).REPRINT  
, REQUEST_DRIVER_TYPE 	    		= wip_tab(indx).REQUEST_DRIVER_TYPE 
, REQUEST_DRIVER_TABLE 	    		= wip_tab(indx).REQUEST_DRIVER_TABLE 
, STATUS 	    					        = wip_tab(indx).STATUS 
, STATUS_DT   	    				    = wip_tab(indx).STATUS_DT   
, SENT_DT 	    					      = wip_tab(indx).SENT_DT 
, PRINT_DT 	    					      = wip_tab(indx).PRINT_DT 
, MAILED_DT 	    				      = wip_tab(indx).MAILED_DT 
, RETURN_DT  	    				      = wip_tab(indx).RETURN_DT  
, RETURN_REASON 	    			    = wip_tab(indx).RETURN_REASON 
, REJECT_REASON 	    			    = wip_tab(indx).REJECT_REASON 
, ERROR_REASON  	    			    = wip_tab(indx).ERROR_REASON  
, TRANSMIT_FILE_NAME 	    		  = wip_tab(indx).TRANSMIT_FILE_NAME 
, TRANSMIT_FILE_DT 	    			  = wip_tab(indx).TRANSMIT_FILE_DT 
, LETTER_RESP_FILE_NAME  			  = wip_tab(indx).LETTER_RESP_FILE_NAME  
, LETTER_RESP_FILE_DT 	    		= wip_tab(indx).LETTER_RESP_FILE_DT 
, LAST_UPDATE_DT  	    			  = wip_tab(indx).LAST_UPDATE_DT  
, LAST_UPDATE_BY_NAME  	    		= wip_tab(indx).LAST_UPDATE_BY_NAME  
, NEWBORN_FLAG  	    			    = wip_tab(indx).NEWBORN_FLAG  
, TASK_ID 	    					      = wip_tab(indx).TASK_ID 
, CANCEL_DT 	    				      = wip_tab(indx).CANCEL_DT 
, CANCEL_BY  	    				      = wip_tab(indx).CANCEL_BY  
, COMPLETE_DT  	    				    = wip_tab(indx).COMPLETE_DT  
, INSTANCE_STATUS  	    			  = wip_tab(indx).INSTANCE_STATUS  
, ASSD_PROCESS_LETTER_REQ 			= wip_tab(indx).ASSD_PROCESS_LETTER_REQ 
, ASED_PROCESS_LETTER_REQ 			= wip_tab(indx).ASED_PROCESS_LETTER_REQ 
, ASSD_TRANSMIT  	    			    = wip_tab(indx).ASSD_TRANSMIT  
, ASED_TRANSMIT  	    			    = wip_tab(indx).ASED_TRANSMIT  
, ASSD_RECEIVE_CONFIRMATION 	  = wip_tab(indx).ASSD_RECEIVE_CONFIRMATION 
, ASED_RECEIVE_CONFIRMATION 	  = wip_tab(indx).ASED_RECEIVE_CONFIRMATION 
, ASSD_CREATE_ROUTE_WORK 	    	= wip_tab(indx).ASSD_CREATE_ROUTE_WORK 
, ASED_CREATE_ROUTE_WORK  	    = wip_tab(indx).ASED_CREATE_ROUTE_WORK  
, ASF_PROCESS_LETTER_REQ  	    = wip_tab(indx).ASF_PROCESS_LETTER_REQ  
, ASF_TRANSMIT  	    			    = wip_tab(indx).ASF_TRANSMIT  
, ASF_RECEIVE_CONFIRMATION  	  = wip_tab(indx).ASF_RECEIVE_CONFIRMATION  
, ASF_CREATE_ROUTE_WORK  	    	= wip_tab(indx).ASF_CREATE_ROUTE_WORK  
, GWF_VALID 	    				      = wip_tab(indx).GWF_VALID 
, GWF_OUTCOME 	    				    = wip_tab(indx).GWF_OUTCOME 
, GWF_WORK_REQUIRED 	    		  = wip_tab(indx).GWF_WORK_REQUIRED 
, STG_EXTRACT_DATE   	    		  = wip_tab(indx).STG_EXTRACT_DATE   
, STG_LAST_UPDATE_DATE   	    	= wip_tab(indx).STG_LAST_UPDATE_DATE   
, STAGE_DONE_DATE	    			    = WIP_TAB(INDX).STAGE_DONE_DATE 
, MATERIAL_REQUEST_ID 		      = WIP_TAB(INDX).MATERIAL_REQUEST_ID 
, FAMILY_MEMBER_COUNT 		      = WIP_TAB(INDX).FAMILY_MEMBER_COUNT 
, AIAN_MEMBER_COUNT 		        = WIP_TAB(INDX).AIAN_MEMBER_COUNT 
  WHERE cepn_id = wip_tab(indx).cepn_id;

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
                     'PROCESS_LETTERS',--PROCESS_NAME
                     'PL_UPDATE_MAIN_TABLE',--JOB_NAME
                     '1',--NR_OF_ERROR
                     v_step, --||' '||v_err_msg,--ERROR_DESC
                     null,--ERROR_FIELD
                     v_err_code,--ERROR_CODES
                     sysdate,--CREATE_TS
                     sysdate,--UPDATE_TS
                     'CORP_ETL_PROCESS_LETTERS',--DRIVER_TABLE_NAME
                     v_err_index);--DRIVER_KEY_NUMBER
            END LOOP;
          END IF;                     
     END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE wip_cur;
END PL_UPDATE_MAIN_TABLE;

END ETL_PROCESS_LETTERS_PKG;
/

alter session set plsql_code_type = interpreted;
