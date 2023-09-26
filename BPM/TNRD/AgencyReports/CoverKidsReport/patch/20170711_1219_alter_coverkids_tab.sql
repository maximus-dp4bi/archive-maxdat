alter session set current_schema = MAXDAT;

ALTER TABLE coverkids_approval_stg ADD (letter_mailed_date DATE);
CREATE INDEX CKIDS_APPR_IDX02 ON coverkids_approval_stg(letter_mailed_date) TABLESPACE MAXDAT_INDX;