ALTER TABLE app_event_log_stg
ADD (outcome_reason_cd VARCHAR2(32)
     ,program_cd VARCHAR2(32)
     ,program_subtype_cd VARCHAR2(32));

CREATE INDEX APP_EVENT_LOG_STG_IDX04 ON app_event_log_stg(outcome_cd) TABLESPACE MAXDAT_INDX;
CREATE INDEX APP_EVENT_LOG_STG_IDX05 ON app_event_log_stg(rfe_status_cd) TABLESPACE MAXDAT_INDX;