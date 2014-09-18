Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (461,2,'Resolution Description','Free text field to document Incident Resolution');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (459,2,'Action Comments','Free text field to document Actions taken to the incident.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1499,2,'Incident Description','Free text field to document Incident description');

Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (573,459,10,'BOTH',to_date('2013-04-11 09:09:00','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Y');
Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (575,461,10,'BOTH',to_date('2013-04-11 09:09:00','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Y');
Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (579,1499,10,'BOTH',to_date('2014-01-06 09:09:00','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'N');

update BPM_ATTRIBUTE_STAGING_TABLE set ba_id = 618 where staging_table_column = 'ENROLLEE_RIN';
delete from bpm_attribute where ba_id = 2593;


delete from corp_etl_process_incidents;

update corp_etl_control set value = '0' where name = 'LAST_INCIDENT_ID';

update corp_etl_control set value = '200' where name = 'INC_LOOK_BACK_DAYS';

commit;