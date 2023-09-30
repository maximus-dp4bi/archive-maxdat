--TX DE task created so that DE_ref_ids returned from function Get_Inlist_Str2 has step_definition_id 1059
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'TASK_MONITOR_TYPE'
  ,'LIST'
  ,'Enrollment Data Entry Task'
  ,'Data Entry Unit'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Enrollment Data Entry Task' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Enrollment Data Entry Task'
  ,sysdate
  ,sysdate);
  
  commit;