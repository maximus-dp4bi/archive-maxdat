use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

UPDATE raw.primary_presence SET ingestiondatetime = '2022-09-17 01:01:01.001' 
WHERE (projectid, raw, ingestiondatetime, ingestionsource) IN
(
	SELECT projectid, raw, ingestiondatetime, ingestionsource FROM raw.primary_presence p1 WHERE projectid IN ('321' , '2001', '5555', '1301')
	AND to_date(ingestiondatetime) = '2022-09-16' 
	AND to_char(raw) = (SELECT to_char(max(raw)) FROM raw.primary_presence p2 WHERE p1.projectid = p2.projectid AND to_date(p2.ingestiondatetime) = to_date(p1.ingestiondatetime))
);
