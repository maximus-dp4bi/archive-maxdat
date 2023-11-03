--Create db table RM_Document_Transaction_Summary
Create table maxdat.RM_Document_Transaction_Summary(
	function_name varchar2(50) NULL,
	mailroom_received_dt varchar2(50) NULL,
	insertts varchar2(50) NULL,
	request_receiveddate varchar2(50) NULL,
	ecn varchar2(50) NULL,
	response_code varchar2(50) NULL,
	step_name varchar2(50) NULL,
	batch_name varchar2(50) NULL,
	uuid varchar2(50) NULL,
	pdf_name varchar2(50) NULL
);

CREATE INDEX MAXDAT.IDX1_RM_Doc_Trans_summ_fn ON MAXDAT.RM_Document_Transaction_Summary (function_name);
CREATE INDEX MAXDAT.IDX2_RM_Doc_Trans_summ_ecn ON MAXDAT.RM_Document_Transaction_Summary (ecn);
CREATE INDEX MAXDAT.IDX3_RM_Doc_Trans_summ_it ON MAXDAT.RM_Document_Transaction_Summary (insertts);
CREATE INDEX MAXDAT.IDX4_RM_Doc_Trans_summ_rc ON MAXDAT.RM_Document_Transaction_Summary (response_code);
CREATE INDEX MAXDAT.IDX5_RM_Doc_Trans_summ_sn ON MAXDAT.RM_Document_Transaction_Summary (step_name);
CREATE INDEX MAXDAT.IDX6_RM_Doc_Trans_summ_bn ON MAXDAT.RM_Document_Transaction_Summary (batch_name);
CREATE INDEX MAXDAT.IDX7_RM_Doc_Trans_summ_uid ON MAXDAT.RM_Document_Transaction_Summary (uuid);


  GRANT SELECT ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_READ_ONLY;
  GRANT DELETE ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_OLTP_SIUD;
  GRANT SELECT ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_OLTP_SIUD;
  GRANT UPDATE ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_OLTP_SIU;
  GRANT SELECT ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_OLTP_SIU;
  GRANT UPDATE ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_OLTP_SIU;

-------------------------------------------------------------------
--Create db table RM_Document_Transaction_Summary_OLTP
Create table maxdat.RM_Document_Transaction_Summary_OLTP(
	function_name varchar2(50) NULL,
	mailroom_received_dt varchar2(50) NULL,
	insertts varchar2(50) NULL,
	request_receiveddate varchar2(50) NULL,
	ecn varchar2(50) NULL,
	response_code varchar2(50) NULL,
	step_name varchar2(50) NULL,
	batch_name varchar2(50) NULL,
	uuid varchar2(50) NULL,
	pdf_name varchar2(50) NULL
);

CREATE INDEX MAXDAT.IDX1_RM_Doc_Trans_summ_OLTP_fn ON MAXDAT.RM_Document_Transaction_Summary_OLTP (function_name);
CREATE INDEX MAXDAT.IDX2_RM_Doc_Trans_summ_OLTP_ecn ON MAXDAT.RM_Document_Transaction_Summary_OLTP (ecn);
CREATE INDEX MAXDAT.IDX3_RM_Doc_Trans_summ_OLTP_it ON MAXDAT.RM_Document_Transaction_Summary_OLTP (insertts);
CREATE INDEX MAXDAT.IDX4_RM_Doc_Trans_summ_OLTP_rc ON MAXDAT.RM_Document_Transaction_Summary_OLTP (response_code);
CREATE INDEX MAXDAT.IDX5_RM_Doc_Trans_summ_OLTP_sn ON MAXDAT.RM_Document_Transaction_Summary_OLTP (step_name);
CREATE INDEX MAXDAT.IDX6_RM_Doc_Trans_summ_OLTP_bn ON MAXDAT.RM_Document_Transaction_Summary_OLTP (batch_name);
CREATE INDEX MAXDAT.IDX7_RM_Doc_Trans_summ_OLTP_uid ON MAXDAT.RM_Document_Transaction_Summary_OLTP (uuid);


  GRANT SELECT ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_READ_ONLY;
  GRANT DELETE ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT SELECT ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT UPDATE ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_OLTP_SIU;
  GRANT SELECT ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_OLTP_SIU;
  GRANT UPDATE ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_OLTP_SIU;
  
-------------------------------------------------------------------
--Create db view RM_Doc_Transaction_Summary_SV
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT"."RM_DOC_TRANSACTION_SUMMARY_SV" ("FUNCTION_NAME", "MAILROOM_RECEIVED_DT", "INSERTTS", "REQUEST_RECEIVEDDATE", "ECN", "RESPONSE_CODE", "STEP_NAME", "BATCH_NAME", "UUID", "PDF_NAME") AS 
  select 
    function_name,
	to_date(substr(mailroom_received_dt,1,10),'yyyy-mm-dd') mailroom_received_dt,
	to_date(insertts, 'yyyy-mm-dd hh24:mi:ss') insertts,
	to_date(request_receiveddate, 'yyyy-mm-dd hh24:mi:ss') request_receiveddate,
	ecn,
	response_code,
	step_name,
	batch_name,
	uuid,
	pdf_name
 from MAXDAT.RM_Document_Transaction_Summary;


  GRANT SELECT ON "MAXDAT"."RM_DOC_TRANSACTION_SUMMARY_SV" TO "MAXDAT_READ_ONLY";
  GRANT SELECT ON "MAXDAT"."RM_DOC_TRANSACTION_SUMMARY_SV" TO "MAXDAT_OLTP_SIUD";
  GRANT SELECT ON "MAXDAT"."RM_DOC_TRANSACTION_SUMMARY_SV" TO "MAXDAT_OLTP_SIU";
