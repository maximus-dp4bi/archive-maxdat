ALTER TABLE maxdat.ENUM_ENVELOPE_STATUS_STG    MODIFY REPORT_LABEL VARCHAR2(256 BYTE);
ALTER TABLE maxdat.ENUM_DOC_CODE_TO_TYPE_STG    MODIFY REPORT_LABEL VARCHAR2(256 BYTE);
ALTER TABLE maxdat.ENUM_DOC_CODE_TO_TYPE_STG_BKP    MODIFY REPORT_LABEL VARCHAR2(256 BYTE);
ALTER TABLE maxdat.ENUM_ENVELOPE_STATUS_STG_BKP    MODIFY REPORT_LABEL VARCHAR2(256 BYTE);
ALTER TABLE maxdat.NYHIX_ETL_MAIL_FAX_DOC MODIFY  FORM_TYPE_CD VARCHAR2(256 BYTE);
ALTER TABLE maxdat.NYHIX_ETL_MAIL_FAX_DOC_OLTP MODIFY  FORM_TYPE_CD VARCHAR2(256 BYTE); 
ALTER TABLE maxdat.NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM MODIFY  FORM_TYPE_CD VARCHAR2(256 BYTE);
ALTER TABLE maxdat.NYHIX_ETL_MAIL_FAX_DOC_OLTP_V2 MODIFY  FORM_TYPE_CD VARCHAR2(256 BYTE);
ALTER TABLE maxdat.NYHIX_ETL_MAIL_FAX_DOC_WIP_V2 MODIFY  FORM_TYPE_CD VARCHAR2(256 BYTE);
ALTER TABLE maxdat.NYHIX_ETL_MAIL_FAX_DOC_V2 MODIFY  FORM_TYPE_CD VARCHAR2(256 BYTE);
ALTER TABLE maxdat.D_NYHIX_MFD_CURRENT_V2 MODIFY  FORM_TYPE_CD VARCHAR2(256 BYTE);
ALTER TABLE maxdat.APP_DOC_DATA_STG_BKP		MODIFY 	DOCUMENT_SUB_TYPE VARCHAR2(256 BYTE);
ALTER TABLE maxdat.APP_DOC_DATA_STG		MODIFY 	DOCUMENT_SUB_TYPE VARCHAR2(256 BYTE);
ALTER TABLE maxdat.DLY_APP_DOC_DATA_STG		MODIFY 	DOCUMENT_SUB_TYPE VARCHAR2(256 BYTE);
ALTER TABLE maxdat.FORM_TYPE_CHANGE_HISTORY_STG	MODIFY 	OLD_DOCUMENT_SUB_TYPE VARCHAR2(256 BYTE);
ALTER TABLE maxdat.FORM_TYPE_CHANGE_HISTORY_STG	MODIFY 	NEW_DOCUMENT_SUB_TYPE VARCHAR2(256 BYTE);
ALTER TABLE maxdat.APP_DOC_DATA_NYEC_STG	MODIFY 	DOCUMENT_SUB_TYPE VARCHAR2(256 BYTE);

Commit;
