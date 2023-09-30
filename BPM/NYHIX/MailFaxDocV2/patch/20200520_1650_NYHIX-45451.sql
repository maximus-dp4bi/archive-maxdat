alter session set current_schema = MAXDAT;
CREATE TABLE  MAXDAT.NYHIX_ETL_MAIL_FAX_DOC_CSC_V2BCK 
   (	"CSC_DETAIL_ID" NUMBER(18,0) NOT NULL ENABLE, 
	"KOFAX_DCN" VARCHAR2(256 BYTE), 
	"CSC_PROC_STATUS_CD" VARCHAR2(256 BYTE), 
	"CSC_PROC_ERROR_CD" VARCHAR2(256 BYTE), 
	"CSC_PROC_DT" DATE, 
	"ACTION_STATUS" VARCHAR2(50 BYTE), 
	 CONSTRAINT "CD_ID_PK_BCK" PRIMARY KEY ("CSC_DETAIL_ID")
   ) SEGMENT CREATION IMMEDIATE ;
   
INSERT INTO MAXDAT.NYHIX_ETL_MAIL_FAX_DOC_CSC_V2BCK 
Select * from MAXDAT.NYHIX_ETL_MAIL_FAX_DOC_CSC_V2 ;
MERGE into nyhix_etl_mail_fax_doc_csc_v2
USING nyhix_etl_mail_fax_doc_csc_hist
ON (
nyhix_etl_mail_fax_doc_csc_v2.csc_detail_id =nyhix_etl_mail_fax_doc_csc_hist.csc_detail_id
AND    nyhix_etl_mail_fax_doc_csc_v2.kofax_dcn =nyhix_etl_mail_fax_doc_csc_hist.kofax_dcn
) 
WHEN MATCHED THEN UPDATE SET nyhix_etl_mail_fax_doc_csc_v2.ACTION_STATUS = nyhix_etl_mail_fax_doc_csc_hist.ACTION_STATUS ;
commit;