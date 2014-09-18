update CORP_ETL_MFB_BATCH set ASF_VALIDATE_DATA='Y' where ASED_VALIDATE_DATA is not null;
commit;
