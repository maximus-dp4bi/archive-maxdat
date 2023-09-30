ALTER TABLE hco_d_form MODIFY (mail_type VARCHAR2(10));
ALTER TABLE hco_s_form_stg MODIFY(MailType VARCHAR2(10));

UPDATE corp_etl_control
SET value = '2020/12/01 00:00:00'
WHERE name = 'HCO_FORM_CREATE_DATE';

COMMIT;