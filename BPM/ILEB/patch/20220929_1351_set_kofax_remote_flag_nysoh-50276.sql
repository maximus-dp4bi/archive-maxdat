UPDATE MAXDAT.CORP_ETL_CONTROL
SET VALUE = 'N'
WHERE NAME IN ('MFB_V2_REMOTE_FLAG','MFB_REMOTE_FLAG');
COMMIT;

