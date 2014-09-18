-- 4/8 Global controls
INSERT INTO corp_etl_control(name,value_type,value,description)
VALUES('CLIENT_INQUIRY_CONTACT_DAYS','N','30','Client Inquiry''s Number of business days to look for call records.');

INSERT INTO corp_etl_control(name,value_type,value,description)
VALUES('CLIENT_INQUIRY_DEPLOY_DATE','D',TO_CHAR(SYSDATE,'DD- MON-YYYY'),'Client Inquiry''s production deployment date. Used in Rules Validation scripts.');

INSERT INTO corp_etl_control(name,value_type,value,description)
VALUES('CLIENT_INQUIRY_LAST_CALL_ID','N','0','Client Inquiry''s last processed call record ID.');


COMMIT;

--
