/* CORP_ETL_LIST_LKUP (unique: NAME, LIST_TYPE, VALUE) */

-- 1/8/13 Made new lookup records. Discontinued previous lookups.Add commit.

BEGIN
/* Instance types 
     FLEX_CHAR1   INFO_REQ_GROUP
     FLEX_CHAR2   INFO_REQ_TYPE
     FLEX_CHAR3   INFO_REQ_SOURCE
     FLEX_CHAR4   GWF_REQUEST_TYPE
     FLEX_CHAR5   LETTER_TYPE
     FLEX_CHAR6   SLA_DAY_TYPE (B/C)
     FLEX_INT1    SLA_DAYS
     FLEX_INT2    SLA_JEOPARDY_DAYS
     FLEX_INT3    SLA_TARGET_DAYS
     FLEX_INT4    CALL_RETRY_LIMIT
*/
  -- 
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6, flex_int1, flex_int2, flex_int3)
  VALUES ( 'SITP_INSTANCE_TYPE' , 'LIST' , 'MI2' , 'LETTER' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'MI2-Missing Information Letter' 
         , 'Letter' , 'MI Letter' , 'Letter Req' , 'L' , 'MI Letter' , 'B' , 2 , 2 , 3);
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6, flex_int1, flex_int2, flex_int3)
  VALUES ( 'SITP_INSTANCE_TYPE' , 'LIST' , 'RR1' , 'LETTER' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'RR1-Renewal App Reminder 1' 
         , 'Letter' , 'Renewal Reminder Letter' , 'Letter Req' , 'L' , 'Renewal Reminder' , 'B' , 2 , 2 , 3);
  -- Material Request
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6, flex_int1, flex_int2, flex_int3)
  VALUES ( 'SITP_INSTANCE_TYPE' , 'LIST' , 'XX' , 'MATERIAL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'XX-Material Request' 
         , 'Material Request' , 'Material Request' , 'Letter Req' , 'L' , 'Material Request' , 'B' , 2 , 2 , 3);
  -- Call Campaigns
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6, flex_int1, flex_int2, flex_int3, flex_int4)
  VALUES ( 'SITP_INSTANCE_TYPE' , 'LIST' , 'OB_DIALER_MISSING_DATA' , 'CALL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'CALL_RETRY_LIMIT (FLEX_INT1) is also dictated by SendTP - Rule 1 and 2' 
         , 'Outbound Call' , 'Call Campaign - Missing Data' , 'Event' , 'C' , '' , 'B' , 2, 2 , 3, 4);
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6, flex_int1, flex_int2, flex_int3, flex_int4)
  VALUES ( 'SITP_INSTANCE_TYPE' , 'LIST' , 'OB_DIALER_MISSING_DOC' , 'CALL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'CALL_RETRY_LIMIT (FLEX_INT1) is also dictated by SendTP - Rule 1 and 2' 
         , 'Outbound Call' , 'Call Campaign - Missing Document' , 'Event' , 'C' , '' , 'B' , 2, 2 , 3, 1);
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6, flex_int1, flex_int2, flex_int3, flex_int4)
  VALUES ( 'SITP_INSTANCE_TYPE' , 'LIST' , 'OB_DIALER_PRE_RENEWAL' , 'CALL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'CALL_RETRY_LIMIT (FLEX_INT1) is also dictated by SendTP - Rule 1 and 2' 
         , 'Outbound Call' , 'Call Campaign - 30 day prior Renewal Reminder' , 'Event' , 'C' , '' , 'B' , 2, 2 , 3, 3);
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6, flex_int1, flex_int2, flex_int3, flex_int4)
  VALUES ( 'SITP_INSTANCE_TYPE' , 'LIST' , 'OB_DIALER_RENEWAL_REM' , 'CALL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'CALL_RETRY_LIMIT (FLEX_INT1) is also dictated by SendTP - Rule 1 and 2' 
         , 'Outbound Call' , 'Call Campaign - 10 day Renewal Reminder' , 'Event' , 'C' , '' , 'B' , 2, 2 , 3, 3);


  -- Images and IEDR
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6, flex_int1, flex_int2, flex_int3)
  VALUES ( 'SITP_INSTANCE_TYPE' , 'LIST' , 'DOC_LINK' , 'IMAGE' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), '' 
         , 'Image' , 'Image' , 'DCN' , 'I' , '' , 'B' , 2 , 2 , 3);
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6, flex_int1, flex_int2, flex_int3)
  VALUES ( 'SITP_INSTANCE_TYPE' , 'LIST' , 'IEDR_DCN_CASE' , 'IMAGE' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), '' 
         , 'Image' , 'Image' , 'IEDR' , 'I' , '' , 'B' , 2 , 2 , 3);

  -- Referral Summary
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6, flex_int1, flex_int2, flex_int3)
  VALUES ( 'SITP_INSTANCE_TYPE' , 'LIST' , 'FILE' , 'REFERRAL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), '' 
         , 'Referral' , 'District Referral' , 'CIN' , 'R' , '' , 'B' , 2 , 2 , 3);


/* Letter Statuses that affect ASF Mailed flag
  -- ETL Letter Attributes
     FLEX_CHAR1   Status description
     FLEX_CHAR2   Letter Linked (Flag for ASF and GWF)
     FLEX_CHAR3   Cancelled (Indicator for query's Mail Flag and CANCEL_DATE)
     FLEX_CHAR4   Completed (Indicator for query)
*/
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6)
  VALUES ( 'SITP_LETTER_STATUS' , 'LIST' , 'CANC' , 'LETTERMATERIAL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'All Letter Statuses. Letter Linked (Flag for ASF and GWF) (FLEX_CHAR2), Cancelled (FLEX_CHAR3)' 
         , 'Cancel' , 'N' , '' , '' , '' , '');
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6)
  VALUES ( 'SITP_LETTER_STATUS' , 'LIST' , 'COMBND' , 'LETTERMATERIAL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'All Letter Statuses. Letter Linked (Flag for ASF and GWF) (FLEX_CHAR2), Cancelled (FLEX_CHAR3)' 
         , 'Combined similar Requests' , 'N' , '' , '' , '' , '');
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6)
  VALUES ( 'SITP_LETTER_STATUS' , 'LIST' , 'ERR' , 'LETTERMATERIAL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'All Letter Statuses. Letter Linked (Flag for ASF and GWF) (FLEX_CHAR2), Cancelled (FLEX_CHAR3)' 
         , 'Errored' , 'Y' , '' , 'Y' , '' , '');
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6)
  VALUES ( 'SITP_LETTER_STATUS' , 'LIST' , 'HOLD' , 'LETTERMATERIAL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'All Letter Statuses. Letter Linked (Flag for ASF and GWF) (FLEX_CHAR2), Cancelled (FLEX_CHAR3)' 
         , 'On hold' , 'N' , '' , '' , '' , '');
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6)
  VALUES ( 'SITP_LETTER_STATUS' , 'LIST' , 'MAIL' , 'LETTERMATERIAL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'All Letter Statuses. Letter Linked (Flag for ASF and GWF) (FLEX_CHAR2), Cancelled (FLEX_CHAR3)' 
         , 'Mailed' , 'Y' , '' , '' , '' , '');
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6)
  VALUES ( 'SITP_LETTER_STATUS' , 'LIST' , 'OBE' , 'LETTERMATERIAL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'All Letter Statuses. Letter Linked (Flag for ASF and GWF) (FLEX_CHAR2), Cancelled (FLEX_CHAR3)' 
         , 'Overcome by Events' , 'N' , '' , '' , '' , '');
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6)
  VALUES ( 'SITP_LETTER_STATUS' , 'LIST' , 'PRINTED' , 'LETTERMATERIAL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'All Letter Statuses. Letter Linked (Flag for ASF and GWF) (FLEX_CHAR2), Cancelled (FLEX_CHAR3)' 
         , 'Printed' , 'N' , '' , '' , '' , '');
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6)
  VALUES ( 'SITP_LETTER_STATUS' , 'LIST' , 'REJ' , 'LETTERMATERIAL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'All Letter Statuses. Letter Linked (Flag for ASF and GWF) (FLEX_CHAR2), Cancelled (FLEX_CHAR3)' 
         , 'Rejected' , 'Y' , 'Y' , '' , '' , '');
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6)
  VALUES ( 'SITP_LETTER_STATUS' , 'LIST' , 'REQ' , 'LETTERMATERIAL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'All Letter Statuses. Letter Linked (Flag for ASF and GWF) (FLEX_CHAR2), Cancelled (FLEX_CHAR3)' 
         , 'Requested' , 'N' , '' , '' , '' , '');
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6)
  VALUES ( 'SITP_LETTER_STATUS' , 'LIST' , 'RSND' , 'LETTERMATERIAL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'All Letter Statuses. Letter Linked (Flag for ASF and GWF) (FLEX_CHAR2), Cancelled (FLEX_CHAR3)' 
         , 'Resend' , 'N' , '' , '' , '' , '');
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6)
  VALUES ( 'SITP_LETTER_STATUS' , 'LIST' , 'RTND' , 'LETTERMATERIAL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'All Letter Statuses. Letter Linked (Flag for ASF and GWF) (FLEX_CHAR2), Cancelled (FLEX_CHAR3)' 
         , 'Returned' , 'N' , '' , '' , '' , '');
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6)
  VALUES ( 'SITP_LETTER_STATUS' , 'LIST' , 'SENT' , 'LETTERMATERIAL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'All Letter Statuses. Letter Linked (Flag for ASF and GWF) (FLEX_CHAR2), Cancelled (FLEX_CHAR3)' 
         , 'Sent to mailhouse' , 'N' , '' , '' , '' , '');
  INSERT INTO corp_etl_list_lkup
  ( name , list_type , value , ref_type ,start_date , end_date , comments 
  , flex_char1, flex_char2, flex_char3, flex_char4, flex_char5, flex_char6)
  VALUES ( 'SITP_LETTER_STATUS' , 'LIST' , 'VOID' , 'LETTERMATERIAL' 
         , TRUNC(SYSDATE) , TO_DATE('07-JUL-7777'), 'All Letter Statuses. Letter Linked (Flag for ASF and GWF) (FLEX_CHAR2), Cancelled (FLEX_CHAR3)' 
         , 'Voided' , 'Y' , 'Y' , '' , '' , '');


  COMMIT;
END;
/