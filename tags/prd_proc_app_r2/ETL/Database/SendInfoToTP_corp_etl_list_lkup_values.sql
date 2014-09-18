BEGIN
/* Call Campaigns, Retry Limits */
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'Outbound Dialer Missing Data' , 'CALL_CAMPAIGN' , 'OB_DIALER_MISSING_DATA' , '4' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Retry Limit for Missing Data' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'Outbound Dialer Missing Data' , 'CALL_CAMPAIGN' , 'OB_DIALER_MISSING_DATA_FAIL' , '4' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Retry Limit for Missing Data' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'Outbound Dialer Missing Doc' , 'CALL_CAMPAIGN' , 'OB_DIALER_MISSING_DOC' , '1' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Retry Limit for Missing Document' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'Outbound Dialer Missing Doc' , 'CALL_CAMPAIGN' , 'OB_DIALER_MISSING_DOC_FAIL' , '1' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Retry Limit for Missing Document' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'Outbound Dialer Pre-Renewal' , 'CALL_CAMPAIGN' , 'OB_DAILER_RENEWAL_REM' , '3' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Retry Limit for Renewal Reminder' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'Outbound Dialer Pre-Renewal' , 'CALL_CAMPAIGN' , 'OB_DAILER_RENEWAL_REM_FAIL' , '3' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Retry Limit for Renewal Reminder' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'Outbound Dialer Renewal Remind' , 'CALL_CAMPAIGN' , 'OB_DIALER_PRE_RENEWAL' , '3' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Retry Limit for Pre-Renewal Reminder' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'Outbound Dialer Renewal Remind' , 'CALL_CAMPAIGN' , 'OB_DIALER_PRE_RENEWAL_FAIL' , '3' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Retry Limit for Pre-Renewal Reminder' );
/* Call Campaign Cross Reference */    
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_Call_Campaign_XREF' , 'XREF' , 'OB_DIALER_PRE_RENEWAL' , 'PRE_RENEWAL' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Event to ETL File Cross Reference' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_Call_Campaign_XREF' , 'XREF' , 'OB_DIALER_PRE_RENEWAL_FAIL' , 'PRE_RENEWAL' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Event to ETL File Cross Reference' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_Call_Campaign_XREF' , 'XREF' , 'OB_DIALER_MISSING_DATA' , 'MISSING_DATA' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Event to ETL File Cross Reference' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_Call_Campaign_XREF' , 'XREF' , 'OB_DIALER_MISSING_DATA_FAIL' , 'MISSING_DATA' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Event to ETL File Cross Reference' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_Call_Campaign_XREF' , 'XREF' , 'OB_DIALER_MISSING_DOC' , 'MISSING_DOC' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Event to ETL File Cross Reference' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_Call_Campaign_XREF' , 'XREF' , 'OB_DIALER_MISSING_DOC_FAIL' , 'MISSING_DOC' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Event to ETL File Cross Reference' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_Call_Campaign_XREF' , 'XREF' , 'OB_DAILER_RENEWAL_REM_FAIL' , 'RENEWAL_REM' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Event to ETL File Cross Reference' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_Call_Campaign_XREF' , 'XREF' , 'OB_DAILER_RENEWAL_REM' , 'RENEWAL_REM' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Send Info to TP: Call Campaign Event to ETL File Cross Reference' );
/* Call Campaign Response Events */    
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_OB_DAILER_Resp' , 'BIZ_EVENT_TYPE  ' , 'OB_DIALER_MISSING_DATA_SUCCESS' , 'Success' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Outbound Dialer Missing Data Success' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_OB_DAILER_Resp' , 'BIZ_EVENT_TYPE' , 'OB_DIALER_MISSING_DOC_SUCCESS' , 'Success' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Outbound Dialer Missing Documentation Success' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_OB_DAILER_Resp' , 'BIZ_EVENT_TYPE' , 'OB_DAILER_RENEWAL_REM_SUCCESS' , 'Success' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Outbound Dialer Renewal Reminder Success' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_OB_DAILER_Resp' , 'BIZ_EVENT_TYPE' , 'OB_DIALER_PRE_RENEWAL_SUCCESS' , 'Success' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Outbound Dialer Pre-Renewal Success' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_OB_DAILER_Resp' , 'BIZ_EVENT_TYPE' , 'OB_DIALER_MISSING_DOC_FAIL' , 'Failed' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Outbound Dialer Missing Documentation Fail' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_OB_DAILER_Resp' , 'BIZ_EVENT_TYPE' , 'OB_DIALER_MISSING_DATA_FAIL' , 'Failed' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Outbound Dialer Missing Data Failed' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_OB_DAILER_Resp' , 'BIZ_EVENT_TYPE' , 'OB_DAILER_RENEWAL_REM_FAIL' , 'Failed' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Outbound Dialer Renewal Reminder Failed' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_OB_DAILER_Resp' , 'BIZ_EVENT_TYPE' , 'OB_DIALER_PRE_RENEWAL_FAIL' , 'Failed' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Outbound Dialer Pre-Renewal Failed' );
/* SLA Days */         
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_SLA_Days' , 'LIST' , 'C' , '2' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Used to calculate SLA Days for Outbound Calls (Events): Value = GWF_REQUSET_TYPE' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_SLA_Days' , 'LIST' , 'I' , '2' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Used to calculate SLA Days for Images: Value = GWF_REQUSET_TYPE' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_SLA_Days' , 'LIST' , 'L	' , '2' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Used to calculate SLA Days for Letters & Material Requests: Value = GWF_REQUSET_TYPE' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_SLA_Days' , 'LIST' , 'R' , '2' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Used to calculate SLA Days for Referrals: Value = GWF_REQUSET_TYPE' );
/* Letter Types to Track */
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_Letter_Types' , 'LIST' , 'MI2' , 'Letter' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Value for MI2-Missing Information Letter, out_var is ' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_Letter_Types' , 'LIST' , 'RR1' , 'Letter' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Value for RR1-Reminder Letter' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_Letter_Types' , 'LIST' , 'XX' , 'Material Request' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Value for XX-Materials Request Letter' );
/* Letter Status */
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'ENUM_LM_STATUS' , 'LIST' , 'COMBND' , 'Combined Similar Requests' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Combined Similar Requests' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'ENUM_LM_STATUS' , 'LIST' , 'OBE' , 'Overcome by Events' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Overcome by Events' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'ENUM_LM_STATUS' , 'LIST' , 'VOID' , 'Voided' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Voided' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'ENUM_LM_STATUS' , 'LIST' , 'RTND' , 'Returned' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Returned' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'ENUM_LM_STATUS' , 'LIST' , 'REQ' , 'Requested' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Requested' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'ENUM_LM_STATUS' , 'LIST' , 'CANC' , 'Canceled' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Canceled' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'ENUM_LM_STATUS' , 'LIST' , 'SENT' , 'Sent' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Sent to mailhouse' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'ENUM_LM_STATUS' , 'LIST' , 'RSND' , 'Resend' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Resend' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'ENUM_LM_STATUS' , 'LIST' , 'HOLD' , 'On hold' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'On hold' );
/* Call Result */
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_CallResult' , 'LIST' , 'V' , 'Unsuccessful Outreach' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Voice Mail' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_CallResult' , 'LIST' , 'T' , 'Successful Outreach' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Live caller reached, Xfered to call center' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_CallResult' , 'LIST' , 'E' , 'Invalid Number' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Error' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_CallResult' , 'LIST' , 'B' , 'Unsuccessful Outreach' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Busy Signal' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_CallResult' , 'LIST' , 'F' , 'Invalid Number' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Fax' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_CallResult' , 'LIST' , 'H' , 'Successful Outreach' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Live caller answers and hangs up before Xfer' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_CallResult' , 'LIST' , 'I' , 'Invalid Number' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Invalid Number' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SITP_CallResult' , 'LIST' , 'R' , 'Unsuccessful Outreach' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Ring No Answer' );
END;