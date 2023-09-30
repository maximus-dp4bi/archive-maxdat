drop view maxdat_support.wr_service_transactions_sv;

CREATE OR REPLACE VIEW maxdat_support.wr_service_transactions_sv
AS
SELECT CASE WHEN service_name = 'submitQA' THEN 'Work or Other Activities'
	   	    WHEN service_name = 'submitEx' THEN 'Exemptions'	   	    
          ELSE 'Unknown' END AS survey_type
       ,CASE WHEN "source" IS NOT NULL THEN "source" ELSE 'Unknown' END  AS "source"   
       ,CASE WHEN service_name IN('submitQA', 'submitEx') AND status = 'Success' THEN 1 ELSE 0 END AS success_count
       ,CASE WHEN service_name IN('submitQA', 'submitEx') AND status = 'Failure' THEN 1 ELSE 0 END AS unsuccessful_count
       ,begin_time
       ,end_time
       ,service_name
       ,survey_id
       ,task_id
       ,status
       ,service_txn_id
       ,outbound_ind
       ,target
       ,hoh_ind
       ,"input" AS "input"       
	   ,'NA' sms_message_sent
	  ,CAST(begin_time AS DATE) report_date
	  ,CONCAT(TRIM(LEADING '0' FROM pc.interval_start_time_of_day12),pc.am_pm,'-',TRIM(LEADING '0' FROM pc.interval_end_time_of_day12),pc.am_pm) time_period
FROM (SELECT *
      FROM (SELECT tx.*, RANK() OVER(PARTITION BY survey_id ORDER BY begin_time DESC) rnk
		    FROM ws.service_txn tx  
			WHERE 1=1
			AND tx.service_name IN('submitQA', 'submitEx')
			AND tx.survey_id <> 0
		    AND ((tx.status = 'Success' AND tx.target_persisted_ind = 1)
			   OR (tx.status = 'Failure' AND tx.target_persisted_ind in (1,4)) ) ) s
	  WHERE rnk = 1 ) tx	
LEFT JOIN maxdat_support.wr_c_time_period_config pc ON
   CAST(CONCAT(CAST(tx.begin_time AS DATE),' ',TO_CHAR(tx.begin_time,'hh24:mi')::TIME) AS TIMESTAMP) >= pc.interval_start_date
    AND CAST(CONCAT(cast(tx.begin_time AS DATE),' ',TO_CHAR(tx.begin_time,'hh24:mi')::TIME) AS TIMESTAMP) <= pc.interval_end_date	  	  
UNION ALL     
SELECT 'NA' AS survey_type
       ,CASE WHEN "source" IS NOT NULL THEN "source" ELSE 'Unknown' END  AS "source"   
       ,0 AS success_count
       ,0 AS unsuccessful_count
       ,begin_time
       ,end_time
       ,service_name
       ,survey_id
       ,task_id
       ,status
       ,service_txn_id
       ,outbound_ind
       ,target
       ,hoh_ind
       ,"input" AS "input"       
       ,CASE WHEN service_name IN('SubmitSMS') AND outbound_ind = 1 AND target = 'SMS'
               AND CAST(input::json->'message' AS TEXT) LIKE '%opting into%' THEN 'Non-Keyword Opt-In Welcome Message'
 			 WHEN service_name IN('SubmitSMS')  AND outbound_ind = 1 AND target = 'SMS' 
 			   AND CAST(input::json->'message' AS TEXT) LIKE '%opting out%' THEN 'Non-Keyword Opt-Out Message'
		  	 WHEN service_name IN('SubmitSMS')  AND outbound_ind = 1 AND target = 'SMS' AND hoh_ind::character varying = 'Y' 
		  	   AND CAST(input::json->'message' AS TEXT) LIKE '%mibridges%' THEN 'HOH WR Reminder'
	   	  	 WHEN service_name IN('SubmitSMS')  AND outbound_ind = 1 AND target = 'SMS' AND hoh_ind::character varying = 'N' 
	   	  	   AND CAST(input::json->'message' AS TEXT) LIKE '%activities for the month%'  THEN 'Non HOH WR Reminder'	   	  	  
		  	 WHEN service_name IN('smsOptInfo') AND outbound_ind = 0 AND target = 'Maximus' AND REPLACE(CAST(input::json->'optType' AS TEXT),'"','') = 'OUT' THEN 'STOP'		
	   ELSE 'Unknown' END  sms_message_sent
	  ,CAST(begin_time as DATE) report_date
	  ,CONCAT(TRIM(LEADING '0' FROM pc.interval_start_time_of_day12),pc.am_pm,'-',TRIM(LEADING '0' FROM pc.interval_end_time_of_day12),pc.am_pm) time_period
FROM ws.service_txn tx
  --LEFT JOIN maxdat_support.wr_c_time_period_config pc ON tx.begin_time >= pc.interval_start_date and tx.begin_time <= pc.interval_end_date
  LEFT JOIN maxdat_support.wr_c_time_period_config pc ON
   CAST(CONCAT(CAST(tx.begin_time AS DATE),' ',TO_CHAR(tx.begin_time,'hh24:mi')::TIME) AS TIMESTAMP) >= pc.interval_start_date
    AND CAST(CONCAT(cast(tx.begin_time AS DATE),' ',TO_CHAR(tx.begin_time,'hh24:mi')::TIME) AS TIMESTAMP) <= pc.interval_end_date
WHERE 1=1
AND ( (service_name = 'SubmitSMS' AND source IN('CSR','IVR','WEB','JOB','SMS') AND target = 'SMS' )
   OR (service_name = 'smsOptInfo' AND source = 'SMS' AND target = 'Maximus' AND REPLACE(CAST(input::json->'optType' AS TEXT),'"','') = 'OUT') )
AND ( (status = 'Success' ) OR (status = 'Failure' AND task_id != 0)   );

ALTER TABLE maxdat_support.wr_service_transactions_sv OWNER TO maxdat_support;
GRANT ALL ON TABLE maxdat_support.wr_service_transactions_sv TO maxdat_support;
GRANT SELECT ON TABLE maxdat_support.wr_service_transactions_sv TO maxdatsupport_readonly;
GRANT SELECT ON TABLE maxdat_support.wr_service_transactions_sv TO maxdat_reports;
