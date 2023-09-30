use role SYSADMIN;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema PUBLIC;

{
  "communicationId": "c05b583c-b56f-4440-940a-8a452b240881",
  "conversationId": "001a013b-138b-4fb0-bcfc-dd387659b526",
  "engineId": "r2d2",
  "language": "en-us",
  "participant": "external",
  "phrase": "that would be perfect and do you have that number just in case like we're disconnected or something or i",
  "sentiment": 9.541299939155579e-01,
  "sentimentStartTime": "2021-10-21 15:11:35.864",
  "transcriptId": "6606cf3b-ab88-469b-8c36-52d9710daf63"
}

SELECT
	p.projectid,
	p.projectname,
	p.conversationId,
	p.mysql_count,
	D.v2_parquet_file_count
FROM
(
		(
			SELECT 
				projectid,
				projectname,
				conversationId,
				count(*)		AS mysql_count
			FROM 
				pureinsights_prd.raw.transcription_sentiment	pts
			GROUP BY
				projectid,
				projectname,
				conversationId
			HAVING 
				count(*) > 1
		)	p
		LEFT JOIN
		(
			SELECT 
				projectid,
				projectname,
				to_char(tsb.raw:conversationId) AS conversationId,
				count(*)	AS v2_parquet_file_count
			FROM 
				raw.transcription_sentiment_batched	tsb 	
			GROUP BY
				projectid,
				projectname,
				tsb.raw:conversationId
			HAVING 
				count(*) > 1
		)	d
		ON 
		(
			p.conversationId = D.conversationId		
		)
)
WHERE 	
	p.mysql_count != D.v2_parquet_file_count
AND p.projectid != '$ProjectID'
ORDER BY 
	p.projectid,
	p.conversationId;

SELECT * FROM pureinsights_prd.raw.transcription_sentiment;

SELECT 
	projectid,
	projectname,
	conversationid,
	sentimentstarttime,
	participantname,
	queuename,
	phrase,
	sentiment,
	program_name,
	internalparticipantname,
	count(*) 	AS num_records
FROM
	pureinsights_prd.raw.transcription_sentiment
WHERE
	projectid != '$ProjectID'
GROUP BY
	projectid,
	projectname,
	conversationid,
	sentimentstarttime,
	participantname,
	queuename,
	phrase,
	sentiment,
	program_name,
	internalparticipantname
HAVING 
	count(*) > 1
ORDER BY 
	projectid,
	projectname,
	conversationid,
	sentimentstarttime,
	participantname,
	queuename,
	phrase,
	sentiment,
	program_name,
	internalparticipantname;

