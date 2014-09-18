-- New control for MEA

insert into corp_etl_list_lkup (NAME, LIST_TYPE, VALUE, OUT_VAR, REF_TYPE, REF_ID, START_DATE, END_DATE, COMMENTS, CREATED_TS, UPDATED_TS)
values ('LAST_ETL_COMP_PIVOT', 'PIVOT', 'ProcessManageEnroll_RUNALL', '14', 'BPM_EVENT_MASTER', 14, TRUNC(SYSDATE), to_date('07-07-7777', 'dd-mm-yyyy'), 'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID', SYSDATE, SYSDATE);

COMMIT;