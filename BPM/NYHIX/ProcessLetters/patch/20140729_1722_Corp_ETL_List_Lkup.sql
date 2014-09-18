/*
Created on 29-Jul-2014 by Raj A.
Createdb deployment scripts was missing this global control. So, added it.
*/
Insert INTO CORP_ETL_LIST_LKUP 
( CELL_ID, name, LIST_TYPE, value, OUT_VAR, REF_TYPE, REF_ID, START_DATE, END_DATE, COMMENTS, CREATED_TS, UPDATED_TS ) 
VALUES 
( SEQ_CELL_ID.NEXTVAL, 'LAST_ETL_COMP_PIVOT', 'PIVOT', 'Process_Letters_runall', '12' , 'BPM_EVENT_MASTER', 12, TRUNC(sysdate - 1), TO_DATE('07077777', 'mmddyyyy'), 'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID' , sysdate, sysdate );
COMMIT;