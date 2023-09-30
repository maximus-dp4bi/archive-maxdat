delete from corp_etl_list_lkup
where name = 'LAST_ETL_COMP_PIVOT'
and value = 'ManageWork_RUNALL';

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (SEQ_CELL_ID.nextval,'LAST_ETL_COMP_PIVOT','PIVOT','MW_V2_RUNALL','2001','BPM_EVENT_MASTER',2001,trunc(sysdate - 1),to_date('07077777','mmddyyyy'),'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID',sysdate,sysdate);

commit;