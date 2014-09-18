BEGIN
/* Call Campaigns, Retry Limits */
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_CallRetryLimit' , 'CALL_CAMPAIGN' , 'OB_DIALER_MISSING_DATA' , '4' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Call Campaign Retry Limit for Missing Data' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_CallRetryLimit' , 'CALL_CAMPAIGN' , 'OB_DIALER_MISSING_DOC' , '1' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Call Campaign Retry Limit for Missing Document' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_CallRetryLimit' , 'CALL_CAMPAIGN' , 'OB_DAILER_RENEWAL_REM' , '3' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Call Campaign Retry Limit for Renewal Reminder' );
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , out_var , ref_type , ref_id , start_date , end_date , comments )
  VALUES ( 'SendInfoToTP_CallRetryLimit' , 'CALL_CAMPAIGN' , 'OB_DIALER_PRE_RENEWAL' , '3' 
         , NULL , NULL , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777')
         , 'Call Campaign Retry Limit for Pre-Renewal Reminder' );
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
END;