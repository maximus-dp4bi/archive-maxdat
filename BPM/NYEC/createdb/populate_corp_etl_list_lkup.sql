
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval,'LAST_ETL_COMP_PIVOT','PIVOT','ManageWork_RUNALL','1','BPM_EVENT_MASTER',1,trunc(sysdate - 1),to_date('07077777','mmddyyyy'),'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID',sysdate,sysdate);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval,'LAST_ETL_COMP_PIVOT','PIVOT','Process_Complaints_RUN_ALL','22','BPM_EVENT_MASTER',22,to_date('20-NOV-13','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID',to_date('20-NOV-13','DD-MON-RR'),to_date('20-NOV-13','DD-MON-RR'));

commit;