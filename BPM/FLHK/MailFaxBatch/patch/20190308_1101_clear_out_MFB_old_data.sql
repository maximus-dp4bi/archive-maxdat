
delete from CORP_ETL_MFB_DOCUMENT
where batch_guid > 40492 and batch_guid < 271474;
commit;


delete from CORP_ETL_MFB_FORM
where batch_guid > 40492 and batch_guid < 271474;
commit;

delete from CORP_ETL_MFB_BATCH_EVENTS
where batch_guid > 40492 and batch_guid < 271474;
commit;

delete from CORP_ETL_MFB_BATCH
where batch_guid > 40492 and batch_guid < 271474;
commit;

delete from table F_MFB_BY_HOUR where MFB_BI_ID in 
(select MFB_BI_ID from d_flhk_mfb_current where batch_guid > 40492 and batch_guid < 271474)
commit;


delete from d_flhk_mfb_current
where batch_guid > 40492 and batch_guid < 271474;
commit;

