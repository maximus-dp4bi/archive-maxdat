delete from CORP_ETL_CONTROL Where name like 'EMRS%' or name like 'HCO%';
commit;

insert into CORP_ETL_CONTROL
values ('EMRS_ADDR_CREATE_DATE','D','2017/01/01 00:00:00','Max address creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_ADDR_UPDATE_DATE','D','2017/01/01 00:00:00','Max address update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_PHONE_CREATE_DATE','D','2017/01/01 00:00:00','Max phone creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_PHONE_UPDATE_DATE','D','2017/01/01 00:00:00','Max phone update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_DEMOGRAPHICS_CREATE_DATE','D','2017/01/01 00:00:00','Max demographics creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_DEMOGRAPHICS_UPDATE_DATE','D','2017/01/01 00:00:00','Max demographics update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_MAIL_CREATE_DATE','D','2017/01/01 00:00:00','Max mail creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_MAIL_UPDATE_DATE','D','2017/01/01 00:00:00','Max mail update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_MAIL_STATUS_CREATE_DATE','D','2017/01/01 00:00:00','Max mail transition creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_MAIL_METMAIL_UPDATE_DATE','D','2017/01/01 00:00:00','Max metmail update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_MAIL_METMAIL_CREATE_DATE','D','2017/01/01 00:00:00','Max metmail create date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_MAIL_RETURNED_CREATE_DATE','D','2017/01/01 00:00:00','Max mail returned creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_MAIL_RETURNED_UPDATE_DATE','D','2017/01/01 00:00:00','Max mail returned update date from source', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL
VALUES ('EMRS_EDER_DISENROLL_CREATE_DATE', 'D', '2017/01/01 00:00:00', 'Max EDER Disenroll creation date from source', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL
VALUES ('EMRS_EDER_DISENROLL_UPDATE_DATE', 'D', '2017/01/01 00:00:00', 'Max EDER Disenroll update date from source', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL
VALUES ('EMRS_EDER_DISENROLL_HIST_CREATE_DATE', 'D', '2017/01/01 00:00:00', 'Max EDER Disenroll History creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_FORM_CREATE_DATE','D','2017/01/01 00:00:00','Max form creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_FORM_INCOMPLETE_CREATE_DATE','D','2017/01/01 00:00:00','Max beneformincomplete reason creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_FORM_INCOMPLETE_UPDATE_DATE','D','2017/01/01 00:00:00','Max beneformincomplete reason update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_FORM_MANUALENR_CREATE_DATE','D','2017/01/01 00:00:00','Max manualenrollment creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_FORM_MANUALENR_UPDATE_DATE','D','2017/01/01 00:00:00','Max manualenrollment update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_ENROLLMENT_CREATE_DATE','D','2017/01/01 00:00:00','Max enrollment create date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_ENROLLMENT_UPDATE_DATE','D','2017/01/01 00:00:00','Max enrollment update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_FORM_EXEMPT_CREATE_DATE','D','2017/01/01 00:00:00','Max form exempt record creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_FORM_EXEMPT_UPDATE_DATE','D','2017/01/01 00:00:00','Max form exempt record update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_FORM_EDER_CREATE_DATE','D','2017/01/01 00:00:00','Max form eder record creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_FORM_EDER_UPDATE_DATE','D','2017/01/01 00:00:00','Max form eder record update date from source', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL
VALUES ('EMRS_EXEMPTION_CREATE_DATE', 'D', '2017/01/01 00:00:00', 'Max Exemption creation date from source', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL
VALUES ('EMRS_EXEMPTION_UPDATE_DATE', 'D', '2017/01/01 00:00:00', 'Max Exemption update date from source', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL
VALUES ('EMRS_EXEMPTION_HIST_CREATE_DATE', 'D', '2017/01/01 00:00:00', 'Max Exemption History creation date from source', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL
VALUES ('EMRS_CASE_UPDATE_DATE','D','2017/01/01 00:00:00','Max Case update date from source', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL
VALUES ('EMRS_CLIENT_UPDATE_DATE','D','2017/01/01 00:00:00','Max Beneficiary update date from source', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL
VALUES ('EMRS_CLIENT_EXT_UPDATE_DATE','D','2017/01/01 00:00:00','Max Beneficiary Extension update date from source', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL
VALUES ('EMRS_REC_THRESHOLD','N','1000000','Threshold to run the process Bulk VS Partitioned', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL
VALUES ('HCO_OB_CALL_ID','N',57402,'Last Outbound call ID processed', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL
VALUES ('HCO_IVR_TRANSACTION_ID','N',1,'Last IVR transaction ID processed', sysdate, sysdate);


commit;
