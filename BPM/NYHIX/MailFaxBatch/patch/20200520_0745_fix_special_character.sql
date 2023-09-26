update maxdat.CORP_ETL_MFB_BATCH
set BATCH_DESCRIPTION='NYSOH_FAX-4/9/2020-7:46:54 AM',
    reprocessing_flag = 'Y'
where batch_guid='{9c30fc38-5ad8-45f4-bd80-310d53a4e6df}';

update maxdat.CORP_ETL_MFB_BATCH_STG
set BATCH_DESCRIPTION='NYSOH_FAX-4/9/2020-7:46:54 AM',
    reprocessing_flag = 'Y'
where batch_guid='{9c30fc38-5ad8-45f4-bd80-310d53a4e6df}';
commit;

update maxdat.CORP_ETL_MFB_BATCH
set BATCH_DESCRIPTION='NYSOH_FAX-3/27/2020-3:19:26 PM'
    reprocessing_flag='Y'
where batch_guid='{bb30b35b-87fc-4e68-8a8d-84d6a4b4c3b9}';

update maxdat.CORP_ETL_MFB_BATCH_STG
set BATCH_DESCRIPTION='NYSOH_FAX-3/27/2020-3:19:26 PM'
    reprocessing_flag='Y'
where batch_guid='{bb30b35b-87fc-4e68-8a8d-84d6a4b4c3b9}';
commit;

