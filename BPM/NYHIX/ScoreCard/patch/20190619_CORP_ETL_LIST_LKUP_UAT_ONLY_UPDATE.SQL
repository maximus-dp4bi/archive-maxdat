UPDATE MAXDAT.CORP_ETL_LIST_LKUP 
SET OUT_VAR = 'NYSOH_UAT_MAIL'
WHERE OUT_VAR = 'NYSOH_MAIL';

UPDATE MAXDAT.CORP_ETL_LIST_LKUP 
SET OUT_VAR = 'NYSOH_UAT_FAX'
WHERE OUT_VAR = 'NYSOH_FAX';

UPDATE MAXDAT.CORP_ETL_LIST_LKUP 
SET OUT_VAR = 'NYSOH_UAT_RETURNED_MAIL'
WHERE OUT_VAR = 'NYSOH_RETURNED_MAIL';

COMMIT;
