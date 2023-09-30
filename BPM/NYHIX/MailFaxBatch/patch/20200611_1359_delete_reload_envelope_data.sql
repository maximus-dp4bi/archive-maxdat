
--Get counts before delete
SELECT DISTINCT ecn
FROM corp_etl_mfb_envelope
WHERE trunc(stg_extract_date) >= to_date('06/07/2020','mm/dd/yyyy')
;

SELECT DISTINCT ecn
FROM corp_etl_mfb_envelope_stg
WHERE trunc(stg_extract_date) >= to_date('06/07/2020','mm/dd/yyyy')
;

--Clear out data in Envelope table where extract date is on or after 6/7
--Set Look back days to 5. Look back days is currently set to 3.  The ETL is getting data from 6/8 onwards.  
---Setting it to 7, the ETL will get data from 6/5 onwards
--Deploy ETL fix


DELETE FROM corp_etl_mfb_envelope
WHERE trunc(stg_extract_date) >= to_date('06/07/2020','mm/dd/yyyy');
commit;

DELETE FROM corp_etl_mfb_envelope_stg
WHERE trunc(stg_extract_date) >= to_date('06/07/2020','mm/dd/yyyy');
commit;

UPDATE corp_etl_control
SET value = '7'
WHERE NAME in('MFB_CENTRAL_LOOKBACK_DAYS','MFB_REMOTE_LOOKBACK_DAYS','MFB_ARS_LOOKBACK_DAYS');
commit;

--Get counts after delete
SELECT DISTINCT ecn
FROM corp_etl_mfb_envelope
WHERE trunc(stg_extract_date) >= to_date('06/07/2020','mm/dd/yyyy')
;

SELECT DISTINCT ecn
FROM corp_etl_mfb_envelope_stg
WHERE trunc(stg_extract_date) >= to_date('06/07/2020','mm/dd/yyyy')
;

