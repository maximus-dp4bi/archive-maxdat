alter session set current_schema = MAXDAT;
INSERT INTO maxdat.corp_etl_control (name, value_type, value, description, created_ts, updated_ts) VALUES ('MFD_CSC_LOOK_BACK_DAYS','N','5','This is MFD CSC look back days',sysdate,sysdate);
commit;





