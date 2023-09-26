alter session set current_schema = MAXDAT;

ALTER TABLE d_app_processing_timeliness
ADD (reactivation_reason VARCHAR2(256)
,reactivation_event_date DATE);