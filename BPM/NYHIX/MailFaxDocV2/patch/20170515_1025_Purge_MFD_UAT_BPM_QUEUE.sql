delete from NYHIX_ETL_MAIL_FAX_DOC_V2
where dcn in (
'10011527', 
'10011526', 
'10011528', 
'10011522', 
'10011523')
;

delete from NYHIX_ETL_MAIL_FAX_DOC_APP_V2
where APP_DOC_DATA_ID in (select APP_DOC_DATA_ID from NYHIX_ETL_MAIL_FAX_DOC_V2 where dcn in (
'10011527', 
'10011526', 
'10011528', 
'10011522', 
'10011523')
)
;

delete from NYHIX_ETL_MAIL_FAX_DOC_CSC_V2
where KOFAX_DCN in (select KOFAX_DCN from NYHIX_ETL_MAIL_FAX_DOC_V2 where dcn in (
'10011527', 
'10011526', 
'10011528', 
'10011522', 
'10011523')
)
;

delete from NYHIX_ETL_MAIL_FAX_DOC_OLTP_V2
where dcn in (
'10011527', 
'10011526', 
'10011528', 
'10011522', 
'10011523')
;

delete from NYHIX_ETL_MAIL_FAX_DOC_WIP_V2
where dcn in (
'10011527', 
'10011526', 
'10011528', 
'10011522', 
'10011523')
;

delete from MAXDAT.F_NYHIX_MFD_BY_DATE
where nyhix_mfd_bi_id in (select nyhix_mfd_bi_id from D_NYHIX_MFD_CURRENT where dcn in (
'10011527', 
'10011526', 
'10011528', 
'10011522', 
'10011523')
)
;

delete from D_NYHIX_MFD_HISTORY_V2
where NYHIX_MFD_BI_ID IN(SELECT NYHIX_MFD_BI_ID from D_NYHIX_MFD_CURRENT_V2
where dcn in (
'10011527', 
'10011526', 
'10011528', 
'10011522', 
'10011523'))
;

delete from D_NYHIX_MFD_CURRENT_V2
where dcn in (
'10011527', 
'10011526', 
'10011528', 
'10011522', 
'10011523')
;

DELETE FROM BPM_UPDATE_EVENT_QUEUE
where BSL_ID = 24 
and identifier in (
'10011527', 
'10011526', 
'10011528', 
'10011522', 
'10011523')
;

Commit;
