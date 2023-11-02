-- Insert corp_etl_control rows for rm_document_transaction_summary run 
INSERT INTO maxdat.corp_etl_control (
name,
value_type,
value,
description
) VALUES (
'MFB_V2_RM_DOC_TRANS_SUMMARY_RUN_FLAG',
'V',
'Y',
'Signal to run RM_Document_Transaction_Summary'
);

insert into maxdat.corp_etl_control (
name,
value_type,
value,
description
) values (
'MFB_V2_RM_DOC_TRANS_SUMMARY_LAST_UPDATE_DATE',
'D',
'01/01/2023 00:00:00',
'Last insertts for RM_DOC_TRANS_SUMMARY FORMAT MM/DD/YYYY hh24/mi/ss'
);

commit;