alter session set plsql_code_type = native;

create or replace package ETL_MANAGE_ENROLLMENT_PKG as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.

  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  procedure MEA_WIP_TO_BPM;
    
end;
/
create or replace package body ETL_MANAGE_ENROLLMENT_PKG as

PROCEDURE MEA_WIP_TO_BPM AS
 CURSOR MEA_cur IS
select ceme_id,
       SERVICE_AREA, COUNTY_CODE, ZIP_CODE, ENROLLMENT_STATUS_CODE, ENROLLMENT_STATUS_DT, AA_DUE_DT, ENRL_PACK_ID, ENRL_PACK_REQUEST_DT, ENROLL_FEE_AMNT_DUE,
       ENROLL_FEE_AMNT_PAID, ENROLL_FEE_PAID_DT, fee_paid_flg, SLCT_METHOD, SLCT_CREATE_BY_NAME, SLCT_CREATE_DT, SLCT_LAST_UPDATE_BY_NAME, SLCT_LAST_UPDATE_DT,
       SLCT_AUTO_PROC, ASSD_SELECTION_RECD, ASED_SELECTION_RECD, ASSD_SEND_ENROLL_PACKET, ASED_SEND_ENROLL_PACKET, FIRST_FOLLOWUP_ID, FIRST_FOLLOWUP_TYPE_CODE,
       ASSD_FIRST_FOLLOWUP, ASED_FIRST_FOLLOWUP, SECOND_FOLLOWUP_ID, SECOND_FOLLOWUP_TYPE_CODE, ASSD_SECOND_FOLLOWUP, ASED_SECOND_FOLLOWUP, THIRD_FOLLOWUP_ID,
       THIRD_FOLLOWUP_TYPE_CODE, ASSD_THIRD_FOLLOWUP, ASED_THIRD_FOLLOWUP, FOURTH_FOLLOWUP_ID, FOURTH_FOLLOWUP_TYPE_CODE, ASSD_FOURTH_FOLLOWUP,
       ASED_FOURTH_FOLLOWUP,  ASSD_AUTO_ASSIGN,  ASED_AUTO_ASSIGN, ASSD_WAIT_FOR_FEE,  ASED_WAIT_FOR_FEE, ASF_CANCEL_ENRL_ACTIVITY, ASF_SEND_ENROLL_PACKET,
       ASF_SELECTION_RECD, ASF_FIRST_FOLLOWUP, ASF_SECOND_FOLLOWUP, ASF_THIRD_FOLLOWUP, ASF_FOURTH_FOLLOWUP, ASF_AUTO_ASSIGN, ASF_WAIT_FOR_FEE,
       GWF_ENRL_PACK_REQ, GWF_FIRST_FOLLOWUP_REQ, GWF_SECOND_FOLLOWUP_REQ, GWF_THIRD_FOLLOWUP_REQ, GWF_FOURTH_FOLLOWUP_REQ, GWF_REQUIRED_FEE_PAID,
       INSTANCE_STATUS, COMPLETE_DT, CANCEL_DT, CANCEL_REASON, CANCEL_METHOD, CANCEL_BY, STAGE_DONE_DATE
  from corp_etl_manage_enroll_wip
where update_flg = 'Y'
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying all the update rules to the WIP table.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll
        set 
       SERVICE_AREA=			 MEA_cur_tab(indx).SERVICE_AREA,
       COUNTY_CODE=			 MEA_cur_tab(indx).COUNTY_CODE,
       ZIP_CODE=			 MEA_cur_tab(indx).ZIP_CODE,
       ENROLLMENT_STATUS_CODE=		 MEA_cur_tab(indx).ENROLLMENT_STATUS_CODE,
       ENROLLMENT_STATUS_DT=		 MEA_cur_tab(indx).ENROLLMENT_STATUS_DT,
       AA_DUE_DT=			 MEA_cur_tab(indx).AA_DUE_DT,
       ENRL_PACK_ID=			 MEA_cur_tab(indx).ENRL_PACK_ID,
       ENRL_PACK_REQUEST_DT=		 MEA_cur_tab(indx).ENRL_PACK_REQUEST_DT,
       ENROLL_FEE_AMNT_DUE=		 MEA_cur_tab(indx).ENROLL_FEE_AMNT_DUE,
       ENROLL_FEE_AMNT_PAID=		 MEA_cur_tab(indx).ENROLL_FEE_AMNT_PAID,
       ENROLL_FEE_PAID_DT=		 MEA_cur_tab(indx).ENROLL_FEE_PAID_DT,
       fee_paid_flg=			 MEA_cur_tab(indx).fee_paid_flg,
       SLCT_METHOD=			 MEA_cur_tab(indx).SLCT_METHOD,
       SLCT_CREATE_BY_NAME=		 MEA_cur_tab(indx).SLCT_CREATE_BY_NAME,
       SLCT_CREATE_DT=			 MEA_cur_tab(indx).SLCT_CREATE_DT,
       SLCT_LAST_UPDATE_BY_NAME=	 MEA_cur_tab(indx).SLCT_LAST_UPDATE_BY_NAME,
       SLCT_LAST_UPDATE_DT=		 MEA_cur_tab(indx).SLCT_LAST_UPDATE_DT,
       SLCT_AUTO_PROC=			 MEA_cur_tab(indx).SLCT_AUTO_PROC,
       ASSD_SELECTION_RECD=		 MEA_cur_tab(indx).ASSD_SELECTION_RECD,
       ASED_SELECTION_RECD=		 MEA_cur_tab(indx).ASED_SELECTION_RECD,
       ASSD_SEND_ENROLL_PACKET=		 MEA_cur_tab(indx).ASSD_SEND_ENROLL_PACKET,
       ASED_SEND_ENROLL_PACKET=		 MEA_cur_tab(indx).ASED_SEND_ENROLL_PACKET,
       FIRST_FOLLOWUP_ID=		 MEA_cur_tab(indx).FIRST_FOLLOWUP_ID,
       FIRST_FOLLOWUP_TYPE_CODE=	 MEA_cur_tab(indx).FIRST_FOLLOWUP_TYPE_CODE,
       ASSD_FIRST_FOLLOWUP=		 MEA_cur_tab(indx).ASSD_FIRST_FOLLOWUP,
       ASED_FIRST_FOLLOWUP=		 MEA_cur_tab(indx).ASED_FIRST_FOLLOWUP,
       SECOND_FOLLOWUP_ID=		 MEA_cur_tab(indx).SECOND_FOLLOWUP_ID,
       SECOND_FOLLOWUP_TYPE_CODE=	 MEA_cur_tab(indx).SECOND_FOLLOWUP_TYPE_CODE,
       ASSD_SECOND_FOLLOWUP=		 MEA_cur_tab(indx).ASSD_SECOND_FOLLOWUP,
       ASED_SECOND_FOLLOWUP=		 MEA_cur_tab(indx).ASED_SECOND_FOLLOWUP,
       THIRD_FOLLOWUP_ID=		 MEA_cur_tab(indx).THIRD_FOLLOWUP_ID,
       THIRD_FOLLOWUP_TYPE_CODE=	 MEA_cur_tab(indx).THIRD_FOLLOWUP_TYPE_CODE,
       ASSD_THIRD_FOLLOWUP=		 MEA_cur_tab(indx).ASSD_THIRD_FOLLOWUP,
       ASED_THIRD_FOLLOWUP=		 MEA_cur_tab(indx).ASED_THIRD_FOLLOWUP,
       FOURTH_FOLLOWUP_ID=		 MEA_cur_tab(indx).FOURTH_FOLLOWUP_ID,
       FOURTH_FOLLOWUP_TYPE_CODE=	 MEA_cur_tab(indx).FOURTH_FOLLOWUP_TYPE_CODE,
       ASSD_FOURTH_FOLLOWUP=		 MEA_cur_tab(indx).ASSD_FOURTH_FOLLOWUP,
       ASED_FOURTH_FOLLOWUP=		 MEA_cur_tab(indx).ASED_FOURTH_FOLLOWUP,
       ASSD_AUTO_ASSIGN=		 MEA_cur_tab(indx).ASSD_AUTO_ASSIGN,
       ASED_AUTO_ASSIGN=		 MEA_cur_tab(indx).ASED_AUTO_ASSIGN,
       ASSD_WAIT_FOR_FEE=		 MEA_cur_tab(indx).ASSD_WAIT_FOR_FEE,
       ASED_WAIT_FOR_FEE=		 MEA_cur_tab(indx).ASED_WAIT_FOR_FEE,
       ASF_CANCEL_ENRL_ACTIVITY=	 MEA_cur_tab(indx).ASF_CANCEL_ENRL_ACTIVITY,
       ASF_SEND_ENROLL_PACKET=		 MEA_cur_tab(indx).ASF_SEND_ENROLL_PACKET,
       ASF_SELECTION_RECD=		 MEA_cur_tab(indx).ASF_SELECTION_RECD,
       ASF_FIRST_FOLLOWUP=		 MEA_cur_tab(indx).ASF_FIRST_FOLLOWUP,
       ASF_SECOND_FOLLOWUP=		 MEA_cur_tab(indx).ASF_SECOND_FOLLOWUP,
       ASF_THIRD_FOLLOWUP=		 MEA_cur_tab(indx).ASF_THIRD_FOLLOWUP,
       ASF_FOURTH_FOLLOWUP=		 MEA_cur_tab(indx).ASF_FOURTH_FOLLOWUP,
       ASF_AUTO_ASSIGN=			 MEA_cur_tab(indx).ASF_AUTO_ASSIGN,
       ASF_WAIT_FOR_FEE=		 MEA_cur_tab(indx).ASF_WAIT_FOR_FEE,
       GWF_ENRL_PACK_REQ=		 MEA_cur_tab(indx).GWF_ENRL_PACK_REQ,
       GWF_FIRST_FOLLOWUP_REQ=		 MEA_cur_tab(indx).GWF_FIRST_FOLLOWUP_REQ,
       GWF_SECOND_FOLLOWUP_REQ=		 MEA_cur_tab(indx).GWF_SECOND_FOLLOWUP_REQ,
       GWF_THIRD_FOLLOWUP_REQ=		 MEA_cur_tab(indx).GWF_THIRD_FOLLOWUP_REQ,
       GWF_FOURTH_FOLLOWUP_REQ=		 MEA_cur_tab(indx).GWF_FOURTH_FOLLOWUP_REQ,
       GWF_REQUIRED_FEE_PAID=		 MEA_cur_tab(indx).GWF_REQUIRED_FEE_PAID,
       INSTANCE_STATUS=			 MEA_cur_tab(indx).INSTANCE_STATUS,
       COMPLETE_DT=			 MEA_cur_tab(indx).COMPLETE_DT,
       CANCEL_DT=			 MEA_cur_tab(indx).CANCEL_DT,
       CANCEL_REASON=			 MEA_cur_tab(indx).CANCEL_REASON,
       CANCEL_METHOD=			 MEA_cur_tab(indx).CANCEL_METHOD,
       CANCEL_BY=			 MEA_cur_tab(indx).CANCEL_BY,
       STAGE_DONE_DATE=			 MEA_cur_tab(indx).STAGE_DONE_DATE
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

EXCEPTION
          WHEN OTHERS THEN
             IF SQLCODE = -24381 THEN
                 FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
                     v_err_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE; --SQLCODE;
                     v_err_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
                     insert into corp_etl_error_log values(
                        SEQ_CEEL_ID.nextval,--CEEL_ID
                        sysdate,--ERR_DATE
                        'CRITICAL',--ERR_LEVEL
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_WIP_TO_BPM',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_WIP_TO_BPM;

END ETL_MANAGE_ENROLLMENT_PKG;
/

alter session set plsql_code_type = interpreted;