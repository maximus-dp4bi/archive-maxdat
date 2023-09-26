ALTER SESSION SET CURRENT_SCHEMA = MAXDAT;
CREATE TABLE  MAXDAT.NYHIX_ETL_MAIL_FAX_DOC_CSC_V2BCK 
   ("CSC_DETAIL_ID" NUMBER(18,0) NOT NULL ENABLE, 
	"KOFAX_DCN" VARCHAR2(256 BYTE), 
	"CSC_PROC_STATUS_CD" VARCHAR2(256 BYTE), 
	"CSC_PROC_ERROR_CD" VARCHAR2(256 BYTE), 
	"CSC_PROC_DT" DATE, 
	"ACTION_STATUS" VARCHAR2(50 BYTE), 
	 CONSTRAINT "CD_ID_PK_BCK" PRIMARY KEY ("CSC_DETAIL_ID")
   ) SEGMENT CREATION IMMEDIATE ;
   
INSERT INTO MAXDAT.NYHIX_ETL_MAIL_FAX_DOC_CSC_V2BCK 
SELECT    CSC_DETAIL_ID,    KOFAX_DCN,    CSC_PROC_STATUS_CD,    CSC_PROC_ERROR_CD,    CSC_PROC_DT,    NULL FROM     MAXDAT.NYHIX_ETL_MAIL_FAX_DOC_CSC_V2;

MERGE INTO NYHIX_ETL_MAIL_FAX_DOC_CSC_V2
USING NYHIX_ETL_MAIL_FAX_DOC_CSC_HIST
ON (
NYHIX_ETL_MAIL_FAX_DOC_CSC_V2.CSC_DETAIL_ID =NYHIX_ETL_MAIL_FAX_DOC_CSC_HIST.CSC_DETAIL_ID
AND    NYHIX_ETL_MAIL_FAX_DOC_CSC_V2.KOFAX_DCN =NYHIX_ETL_MAIL_FAX_DOC_CSC_HIST.KOFAX_DCN
) 
WHEN MATCHED THEN UPDATE SET NYHIX_ETL_MAIL_FAX_DOC_CSC_V2.ACTION_STATUS = NYHIX_ETL_MAIL_FAX_DOC_CSC_HIST.ACTION_STATUS ;
COMMIT;