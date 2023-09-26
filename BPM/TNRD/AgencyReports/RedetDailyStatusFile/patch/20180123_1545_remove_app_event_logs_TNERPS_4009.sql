delete from app_event_log_stg
where application_id = 895015
AND app_event_cd IN('PEND_CK','CK_APPR_MA');

delete from ETL_E_DAILY_ACCENT_STAGING_STG
where application_id =895015;

commit;