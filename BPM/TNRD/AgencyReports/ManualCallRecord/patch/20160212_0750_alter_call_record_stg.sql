ALTER TABLE call_record_stg
ADD (EVENT_ID NUMBER(18,0));

ALTER TABLE call_record_stg
MODIFY CALL_RECORD_ID NUMBER(18,0) NOT NULL;

DROP INDEX XPKCALL_RECORD;

CREATE UNIQUE INDEX XPKCALL_RECORD ON CALL_RECORD_STG (CALL_RECORD_ID, EVENT_ID) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON CALL_RECORD_STG TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_MANUAL_CALL_ACTION_SV
AS
select call_record_id,	
caller_type,
call_type,	
call_tracking_number,
worker_id,	
worker_username,
language,	
call_action,	
call_start_ts,	
call_end_ts,	
created_by,	
create_ts,	
updated_by,
update_ts,	
note_ref_id,	
call_record_field1,
event_id,
parent_call_record_id
FROM call_record_stg;

GRANT SELECT ON D_MANUAL_CALL_ACTION_SV TO MAXDAT_READ_ONLY;