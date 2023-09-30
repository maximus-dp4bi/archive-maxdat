--------------------------------------------------------------
--  Control Record Initial Insert
--------------------------------------------------------------

insert into maxdat.corp_etl_control(name, value_type, value, description, created_ts, updated_ts)
values('MAX_APP_DOC_REDACTION_DATE', 'D', to_date('20200620 00:00:00','yyyymmdd hh24:mi:ss'),
'This is the max create date of last redaction from MAXHIX', sysdate, sysdate);

commit;
