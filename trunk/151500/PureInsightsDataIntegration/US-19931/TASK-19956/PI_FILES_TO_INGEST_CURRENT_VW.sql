use role SYSADMIN;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema PUBLIC;

CREATE OR REPLACE FORCE VIEW PI_FILES_TO_INGEST_CURRENT_VW COPY GRANTS AS
	SELECT 
		d.*
	FROM
		(
			SELECT * FROM raw.pi_files_to_ingest_1001
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_101
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_1101
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_1111
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_1201
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_1301
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_2001
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_201
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_221
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_2222
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_301
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_321
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_3333
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_361
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_401
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_421
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_4444
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_501
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_551
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_555
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_5555
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_601
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_621
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_6666
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_701
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_740
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_801
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_8888
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_901
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_903
		)	D
		INNER JOIN d_pi_tables T ON (d.tablename = T.table_name AND T.active = TRUE AND T.ingest_type IS NOT NULL);
	
GRANT SELECT ON PI_FILES_TO_INGEST_CURRENT_VW TO PI_DATA_INGEST_DEV_ALERT_USER;