
UPDATE cc_s_acd_new_queues
SET ALERT_FLAG = 'Y'
WHERE application_id NOT in (select value from cc_c_filter where filter_type like '%IGNORE'
UNION
SELECT TO_CHAR(QUEUE_NUMBER) FROM CC_S_CONTACT_QUEUE
WHERE PROJECT_CONFIG_ID <> 0)
and alert_flag = 'N'
;

COMMIT;