alter table step_instance_stg
add reason_cd varchar2(32);

CREATE INDEX step_instance_stg_reason_idx ON step_instance_stg (reason_cd)
TABLESPACE maxdat_indx;