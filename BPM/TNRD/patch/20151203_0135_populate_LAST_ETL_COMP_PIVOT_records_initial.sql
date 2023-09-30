ALTER SESSION SET CURRENT_SCHEMA = MAXDAT;
--select * from bpm_source_lkup;
--2001	CORP_ETL_MW_V2
--12	CORP_ETL_PROC_LETTERS
--16	CORP_ETL_MFB_BATCH
--select distinct job_name from corp_etl_job_statistics;
--MW_V2_RUNALL
--CORP_ETL_MFB_BATCH
--CORP_ETL_MFB_BATCH_COUNTS
--Process_Letters_runall
--CORP_ETL_MFB_FORM
--CORP_ETL_MFB_BATCH_EVENTS
--CORP_ETL_MFB_ENVELOPE
--CORP_ETL_MFB_DOCUMENT
--
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (SEQ_CELL_ID.nextval,'LAST_ETL_COMP_PIVOT','PIVOT','MW_V2_RUNALL','2001','BPM_EVENT_MASTER',2001,trunc(sysdate - 1),to_date('07077777','mmddyyyy'),'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID',sysdate,sysdate);
--
Insert INTO CORP_ETL_LIST_LKUP ( CELL_ID, name, LIST_TYPE, value, OUT_VAR, REF_TYPE, REF_ID, START_DATE, END_DATE, COMMENTS, CREATED_TS, UPDATED_TS ) 
VALUES (SEQ_CELL_ID.NEXTVAL, 'LAST_ETL_COMP_PIVOT', 'PIVOT', 'Process_Letters_runall', '12' , 'BPM_EVENT_MASTER', 12, TRUNC(sysdate - 1), TO_DATE('07077777', 'mmddyyyy'), 'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID' , sysdate, sysdate );
--
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (SEQ_CELL_ID.nextval,'LAST_ETL_COMP_PIVOT','PIVOT','CORP_ETL_MFB_BATCH','16','BPM_EVENT_MASTER',16,trunc(sysdate - 1),to_date('07077777','mmddyyyy'),'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID',sysdate,sysdate);
commit;
