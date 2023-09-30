Insert INTO CORP_ETL_LIST_LKUP ( CELL_ID, name, LIST_TYPE, value, OUT_VAR, REF_TYPE, REF_ID, START_DATE, END_DATE, COMMENTS, CREATED_TS, UPDATED_TS ) VALUES ( SEQ_CELL_ID.NEXTVAL, 'LAST_ETL_COMP_PIVOT', 'PIVOT', 'ManageWork_RUNALL', '1' , 'BPM_EVENT_MASTER', 1, TRUNC(sysdate - 1), TO_DATE('07077777', 'mmddyyyy'), 'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID' , sysdate, sysdate );               
COMMit;