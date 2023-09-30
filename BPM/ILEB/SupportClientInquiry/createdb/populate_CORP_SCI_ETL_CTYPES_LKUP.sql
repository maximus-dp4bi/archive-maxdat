-- Call Types
INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_CONTACT_TYPE','LIST','INBOUND','Inbound','ENUM_CALL_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Contact/Call Types',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_CONTACT_TYPE','LIST','OUTBOUND','Outbound','ENUM_CALL_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Contact/Call Types',SYSDATE,SYSDATE);


COMMIT;

--
