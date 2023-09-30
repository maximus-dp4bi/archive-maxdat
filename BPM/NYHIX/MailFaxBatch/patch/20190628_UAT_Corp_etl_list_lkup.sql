INSERT INTO maxdat.CORP_ETL_LIST_LKUP
	(NAME, LIST_TYPE, VALUE, OUT_VAR, REF_TYPE, REF_ID, START_DATE, END_DATE, COMMENTS, CREATED_TS, UPDATED_TS	)
VALUES
	('MFB_BATCH_CLASS_LIST15','MFB_BATCH_CLASS_LIST', 'These are the NYHIX PROD Batch Classes',
	'NYSOH_MAIL', 
	NULL, NULL, 
	to_date ('2019-03-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS')	, to_date ('1977-07-07', 'YYYY-MM-DD'),
	NULL, SYSDATE, SYSDATE 	);

COMMIT;
	
INSERT INTO maxdat.CORP_ETL_LIST_LKUP
	(NAME, LIST_TYPE, VALUE, OUT_VAR, REF_TYPE, REF_ID, START_DATE, END_DATE, COMMENTS, CREATED_TS, UPDATED_TS	)
VALUES
	('MFB_BATCH_CLASS_LIST16','MFB_BATCH_CLASS_LIST', 'These are the NYHIX PROD Batch Classes',
	'NYSOH_FAX',
	NULL, NULL, 
	to_date ('2019-03-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS')	, to_date ('2022-12-31', 'YYYY-MM-DD'),
	NULL, SYSDATE, SYSDATE 	);

COMMIT;
	
INSERT INTO maxdat.CORP_ETL_LIST_LKUP
	(NAME, LIST_TYPE, VALUE, OUT_VAR, REF_TYPE, REF_ID, START_DATE, END_DATE, COMMENTS, CREATED_TS, UPDATED_TS	)
VALUES
	('MFB_BATCH_CLASS_LIST17','MFB_BATCH_CLASS_LIST', 'These are the NYHIX PROD Batch Classes',
	'NYSOH_RETURNED_MAIL', 
	NULL, NULL, 
	to_date ('2019-03-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS')	, to_date ('1977-07-07', 'YYYY-MM-DD'),
	NULL, SYSDATE, SYSDATE 	);

COMMIT;	

-- NYHO-FPBP-FAX

INSERT INTO maxdat.CORP_ETL_LIST_LKUP
	(NAME, LIST_TYPE, VALUE, OUT_VAR, REF_TYPE, REF_ID, START_DATE, END_DATE, COMMENTS, CREATED_TS, UPDATED_TS	)
VALUES
	('MFB_BATCH_CLASS_LIST17','MFB_BATCH_CLASS_LIST', 'These are the NYHIX PROD Batch Classes',
	'NYHO-FPBP-FAX', 
	NULL, NULL, 
	to_date ('2019-03-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS')	, to_date ('2022-12-31', 'YYYY-MM-DD'),
	NULL, SYSDATE, SYSDATE 	);

COMMIT;	



select * from maxdat.CORP_ETL_LIST_LKUP where name like 'MFB_BATCH_CLASS_LIST%' order by 1 desc

