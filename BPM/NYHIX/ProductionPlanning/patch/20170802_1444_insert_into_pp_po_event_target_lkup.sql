INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP 
(event_id, name, target, scorecard_flag, start_date, end_date, create_by, create_datetime, scorecard_group, EE_ADHERENCE, ops_group, WORKSUBACTIVITY_FLAG) 
VALUES ( 1525, 'Undeliverable RM Scan', 0,'N',to_date('2017-08-02','YYYY-MM-DD'), null,'script',sysdate, 'Undeliverable RM Scan','N','Mailroom','N'); 

commit;
