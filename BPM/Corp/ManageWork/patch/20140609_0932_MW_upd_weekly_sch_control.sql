-- Switch from weekly schedule to daily (deployed only to NYEC and NYHIX)

UPDATE corp_etl_control SET Value = TO_CHAR(SYSDATE-1,'YYYY/MM/DD')  WHERE Name = 'MW_BATCH_MISMATCH_LAST_UPDATE';
UPDATE corp_etl_control SET Value = 'MON, TUE, WED, THU, FRI, SAT, SUN'  WHERE Name = 'MW_BATCH_MISMATCH_DAY';

COMMIT;
