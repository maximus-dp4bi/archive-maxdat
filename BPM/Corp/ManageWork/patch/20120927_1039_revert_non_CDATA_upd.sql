alter session set plsql_code_type = native;

create or replace procedure UPD_CORP_ETL_MANAGE_WORK_BE
  (p_old_data_xml in xmltype,
   p_new_data_xml in xmltype,
   p_bue_id out number)
as

  v_be_id number := null;
  v_bem_id number := 1; -- 'NYEC OPS Manage Work'
  v_bi_id number := null;
  v_bsl_id number := 1; -- 'CORP_ETL_MANAGE_WORK'
  v_bue_id number := null;
  v_butl_id number := 1; -- 'ETL'
  
  v_identifier varchar2(100) := null;
  
  v_start_date date := null;
  v_end_date date := null;
  v_current_date date := sysdate;
  
  v_sql_code number := null;
  v_error_message clob := null;
  
  /* select 
     case 
     when atc.DATA_TYPE = 'DATE' then '     ' || atc.COLUMN_NAME || ' varchar2(19),'
     when atc.DATA_TYPE = 'VARCHAR2' then '     ' || atc.COLUMN_NAME || ' varchar2(' || atc.DATA_LENGTH || '),'
     else '     ' || atc.COLUMN_NAME || ' varchar2(100),' 
     end column_elements
     from BPM_ATTRIBUTE_STAGING_TABLE bast
     inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
     where 
     bast.BSL_ID = 1
     and atc.TABLE_NAME = 'CORP_ETL_MANAGE_WORK' 
     order by atc.COLUMN_NAME asc;*/
  type t_data_xml_type is record
    ( 
     AGE_IN_BUSINESS_DAYS varchar2(100),
     AGE_IN_CALENDAR_DAYS varchar2(100),
     CANCEL_WORK_DATE varchar2(19),
     CANCEL_WORK_FLAG varchar2(1),
     COMPLETE_DATE varchar2(19),
     COMPLETE_FLAG varchar2(1),
     CREATED_BY_NAME varchar2(100),
     CREATE_DATE varchar2(19),
     ESCALATED_FLAG varchar2(1),
     ESCALATED_TO_NAME varchar2(100),
     FORWARDED_BY_NAME varchar2(100),
     FORWARDED_FLAG varchar2(1),
     GROUP_NAME varchar2(100),
     GROUP_PARENT_NAME varchar2(100),
     GROUP_SUPERVISOR_NAME varchar2(100),
     JEOPARDY_FLAG varchar2(1),
     LAST_UPDATE_BY_NAME varchar2(100),
     LAST_UPDATE_DATE varchar2(19),
     OWNER_NAME varchar2(100),
     SLA_DAYS varchar2(100),
     SLA_DAYS_TYPE varchar2(1),
     SLA_JEOPARDY_DAYS varchar2(100),
     SLA_TARGET_DAYS varchar2(100),
     SOURCE_REFERENCE_ID varchar2(100),
     SOURCE_REFERENCE_TYPE varchar2(30),
     STATUS_AGE_IN_BUS_DAYS varchar2(100),
     STATUS_AGE_IN_CAL_DAYS varchar2(100),
     STATUS_DATE varchar2(19),
     TASK_ID varchar2(100),
     TASK_STATUS varchar2(50),
     TASK_TYPE varchar2(100),
     TEAM_NAME varchar2(100),
     TEAM_PARENT_NAME varchar2(100),
     TEAM_SUPERVISOR_NAME varchar2(100),
     TIMELINESS_STATUS varchar2(20),
     UNIT_OF_WORK varchar2(30)
    );
  v_old_data t_data_xml_type := null;
  v_new_data t_data_xml_type := null;

begin
  
  /*select 
    '    xmlquery(''$x/ROWSET/ROW/' || atc.COLUMN_NAME || '/text()[1]'' passing p_old_data_xml as "x" returning content).getStringVal() "' || atc.COLUMN_NAME || '",'
   from BPM_ATTRIBUTE_STAGING_TABLE bast
   inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
   where 
   bast.BSL_ID = 1
   and atc.TABLE_NAME = 'CORP_ETL_MANAGE_WORK' 
   order by atc.COLUMN_NAME asc;*/
  select
     xmlquery('$x/ROWSET/ROW/AGE_IN_BUSINESS_DAYS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "AGE_IN_BUSINESS_DAYS",
     xmlquery('$x/ROWSET/ROW/AGE_IN_CALENDAR_DAYS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "AGE_IN_CALENDAR_DAYS",
     xmlquery('$x/ROWSET/ROW/CANCEL_WORK_DATE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "CANCEL_WORK_DATE",
     xmlquery('$x/ROWSET/ROW/CANCEL_WORK_FLAG/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "CANCEL_WORK_FLAG",
     xmlquery('$x/ROWSET/ROW/COMPLETE_DATE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "COMPLETE_DATE",
     xmlquery('$x/ROWSET/ROW/COMPLETE_FLAG/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "COMPLETE_FLAG",
     xmlquery('$x/ROWSET/ROW/CREATED_BY_NAME/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "CREATED_BY_NAME",
     xmlquery('$x/ROWSET/ROW/CREATE_DATE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "CREATE_DATE",
     xmlquery('$x/ROWSET/ROW/ESCALATED_FLAG/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ESCALATED_FLAG",
     xmlquery('$x/ROWSET/ROW/ESCALATED_TO_NAME/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ESCALATED_TO_NAME",
     xmlquery('$x/ROWSET/ROW/FORWARDED_BY_NAME/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "FORWARDED_BY_NAME",
     xmlquery('$x/ROWSET/ROW/FORWARDED_FLAG/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "FORWARDED_FLAG",
     xmlquery('$x/ROWSET/ROW/GROUP_NAME/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "GROUP_NAME",
     xmlquery('$x/ROWSET/ROW/GROUP_PARENT_NAME/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "GROUP_PARENT_NAME",
     xmlquery('$x/ROWSET/ROW/GROUP_SUPERVISOR_NAME/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "GROUP_SUPERVISOR_NAME",
     xmlquery('$x/ROWSET/ROW/JEOPARDY_FLAG/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "JEOPARDY_FLAG",
     xmlquery('$x/ROWSET/ROW/LAST_UPDATE_BY_NAME/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "LAST_UPDATE_BY_NAME",
     xmlquery('$x/ROWSET/ROW/LAST_UPDATE_DATE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "LAST_UPDATE_DATE",
     xmlquery('$x/ROWSET/ROW/OWNER_NAME/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "OWNER_NAME",
     xmlquery('$x/ROWSET/ROW/SLA_DAYS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "SLA_DAYS",
     xmlquery('$x/ROWSET/ROW/SLA_DAYS_TYPE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "SLA_DAYS_TYPE",
     xmlquery('$x/ROWSET/ROW/SLA_JEOPARDY_DAYS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "SLA_JEOPARDY_DAYS",
     xmlquery('$x/ROWSET/ROW/SLA_TARGET_DAYS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "SLA_TARGET_DAYS",
     xmlquery('$x/ROWSET/ROW/SOURCE_REFERENCE_ID/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "SOURCE_REFERENCE_ID",
     xmlquery('$x/ROWSET/ROW/SOURCE_REFERENCE_TYPE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "SOURCE_REFERENCE_TYPE",
     xmlquery('$x/ROWSET/ROW/STATUS_AGE_IN_BUS_DAYS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "STATUS_AGE_IN_BUS_DAYS",
     xmlquery('$x/ROWSET/ROW/STATUS_AGE_IN_CAL_DAYS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "STATUS_AGE_IN_CAL_DAYS",
     xmlquery('$x/ROWSET/ROW/STATUS_DATE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "STATUS_DATE",
     xmlquery('$x/ROWSET/ROW/TASK_ID/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "TASK_ID",
     xmlquery('$x/ROWSET/ROW/TASK_STATUS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "TASK_STATUS",
     xmlquery('$x/ROWSET/ROW/TASK_TYPE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "TASK_TYPE",
     xmlquery('$x/ROWSET/ROW/TEAM_NAME/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "TEAM_NAME",
     xmlquery('$x/ROWSET/ROW/TEAM_PARENT_NAME/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "TEAM_PARENT_NAME",
     xmlquery('$x/ROWSET/ROW/TEAM_SUPERVISOR_NAME/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "TEAM_SUPERVISOR_NAME",
     xmlquery('$x/ROWSET/ROW/TIMELINESS_STATUS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "TIMELINESS_STATUS",
     xmlquery('$x/ROWSET/ROW/UNIT_OF_WORK/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "UNIT_OF_WORK"
  into v_old_data
  from dual;
  
  /*select 
    '    xmlquery(''$x/ROWSET/ROW/' || atc.COLUMN_NAME || '/text()[1]'' passing p_new_data_xml as "x" returning content).getStringVal() "' || atc.COLUMN_NAME || '",'
   from BPM_ATTRIBUTE_STAGING_TABLE bast
   inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
   where 
   bast.BSL_ID = 1
   and atc.TABLE_NAME = 'CORP_ETL_MANAGE_WORK' 
   order by atc.COLUMN_NAME asc;*/
  select
    xmlquery('$x/ROWSET/ROW/AGE_IN_BUSINESS_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "AGE_IN_BUSINESS_DAYS",
    xmlquery('$x/ROWSET/ROW/AGE_IN_CALENDAR_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "AGE_IN_CALENDAR_DAYS",
    xmlquery('$x/ROWSET/ROW/CANCEL_WORK_DATE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "CANCEL_WORK_DATE",
    xmlquery('$x/ROWSET/ROW/CANCEL_WORK_FLAG/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "CANCEL_WORK_FLAG",
    xmlquery('$x/ROWSET/ROW/COMPLETE_DATE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "COMPLETE_DATE",
    xmlquery('$x/ROWSET/ROW/COMPLETE_FLAG/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "COMPLETE_FLAG",
    xmlquery('$x/ROWSET/ROW/CREATED_BY_NAME/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "CREATED_BY_NAME",
    xmlquery('$x/ROWSET/ROW/CREATE_DATE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "CREATE_DATE",
    xmlquery('$x/ROWSET/ROW/ESCALATED_FLAG/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ESCALATED_FLAG",
    xmlquery('$x/ROWSET/ROW/ESCALATED_TO_NAME/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ESCALATED_TO_NAME",
    xmlquery('$x/ROWSET/ROW/FORWARDED_BY_NAME/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "FORWARDED_BY_NAME",
    xmlquery('$x/ROWSET/ROW/FORWARDED_FLAG/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "FORWARDED_FLAG",
    xmlquery('$x/ROWSET/ROW/GROUP_NAME/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "GROUP_NAME",
    xmlquery('$x/ROWSET/ROW/GROUP_PARENT_NAME/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "GROUP_PARENT_NAME",
    xmlquery('$x/ROWSET/ROW/GROUP_SUPERVISOR_NAME/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "GROUP_SUPERVISOR_NAME",
    xmlquery('$x/ROWSET/ROW/JEOPARDY_FLAG/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "JEOPARDY_FLAG",
    xmlquery('$x/ROWSET/ROW/LAST_UPDATE_BY_NAME/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "LAST_UPDATE_BY_NAME",
    xmlquery('$x/ROWSET/ROW/LAST_UPDATE_DATE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "LAST_UPDATE_DATE",
    xmlquery('$x/ROWSET/ROW/OWNER_NAME/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "OWNER_NAME",
    xmlquery('$x/ROWSET/ROW/SLA_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SLA_DAYS",
    xmlquery('$x/ROWSET/ROW/SLA_DAYS_TYPE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SLA_DAYS_TYPE",
    xmlquery('$x/ROWSET/ROW/SLA_JEOPARDY_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SLA_JEOPARDY_DAYS",
    xmlquery('$x/ROWSET/ROW/SLA_TARGET_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SLA_TARGET_DAYS",
    xmlquery('$x/ROWSET/ROW/SOURCE_REFERENCE_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SOURCE_REFERENCE_ID",
    xmlquery('$x/ROWSET/ROW/SOURCE_REFERENCE_TYPE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SOURCE_REFERENCE_TYPE",
    xmlquery('$x/ROWSET/ROW/STATUS_AGE_IN_BUS_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "STATUS_AGE_IN_BUS_DAYS",
    xmlquery('$x/ROWSET/ROW/STATUS_AGE_IN_CAL_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "STATUS_AGE_IN_CAL_DAYS",
    xmlquery('$x/ROWSET/ROW/STATUS_DATE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "STATUS_DATE",
    xmlquery('$x/ROWSET/ROW/TASK_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "TASK_ID",
    xmlquery('$x/ROWSET/ROW/TASK_STATUS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "TASK_STATUS",
    xmlquery('$x/ROWSET/ROW/TASK_TYPE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "TASK_TYPE",
    xmlquery('$x/ROWSET/ROW/TEAM_NAME/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "TEAM_NAME",
    xmlquery('$x/ROWSET/ROW/TEAM_PARENT_NAME/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "TEAM_PARENT_NAME",
    xmlquery('$x/ROWSET/ROW/TEAM_SUPERVISOR_NAME/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "TEAM_SUPERVISOR_NAME",
    xmlquery('$x/ROWSET/ROW/TIMELINESS_STATUS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "TIMELINESS_STATUS",
    xmlquery('$x/ROWSET/ROW/UNIT_OF_WORK/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "UNIT_OF_WORK"
  into v_new_data
  from dual;

  v_identifier := substr(v_new_data.TASK_ID,1,100);
  v_end_date := to_date(coalesce(v_new_data.COMPLETE_DATE,v_new_data.CANCEL_WORK_DATE),BPM_COMMON.DATE_FMT);
  
  select BI_ID into v_bi_id
  from BPM_INSTANCE
  where 
    BEM_ID = v_bem_id
    and BSL_ID = v_bsl_id
    and IDENTIFIER = v_identifier;

  if v_end_date is not null then
    update BPM_INSTANCE
    set
      END_DATE = v_end_date,
      LAST_UPDATE_DATE = v_current_date
    where BI_ID = v_bi_id;
  else
    update BPM_INSTANCE
    set LAST_UPDATE_DATE = v_current_date
    where BI_ID = v_bi_id;
  end if;

  commit;

  v_bue_id := SEQ_BUE_ID.nextval;
  
  insert into BPM_UPDATE_EVENT
    (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
  values
    (v_bue_id,v_bi_id,v_butl_id,v_current_date,'N');
  
  BPM_EVENT.UPDATE_BIA(v_bi_id, 1,1,'N',v_old_data.AGE_IN_BUSINESS_DAYS,v_new_data.AGE_IN_BUSINESS_DAYS,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id, 3,3,'Y',v_old_data.CANCEL_WORK_DATE,v_new_data.CANCEL_WORK_DATE,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id, 5,3,'Y',v_old_data.COMPLETE_DATE,v_new_data.COMPLETE_DATE,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id, 9,2,'Y',v_old_data.ESCALATED_FLAG,v_new_data.ESCALATED_FLAG,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,10,2,'Y',v_old_data.ESCALATED_TO_NAME,v_new_data.ESCALATED_TO_NAME,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,11,2,'Y',v_old_data.FORWARDED_BY_NAME,v_new_data.FORWARDED_BY_NAME,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,12,2,'Y',v_old_data.FORWARDED_FLAG,v_new_data.FORWARDED_FLAG,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,13,2,'Y',v_old_data.GROUP_NAME,v_new_data.GROUP_NAME,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,14,2,'Y',v_old_data.GROUP_PARENT_NAME,v_new_data.GROUP_PARENT_NAME,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,15,2,'Y',v_old_data.GROUP_SUPERVISOR_NAME,v_new_data.GROUP_SUPERVISOR_NAME,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,17,2,'Y',v_old_data.LAST_UPDATE_BY_NAME,v_new_data.LAST_UPDATE_BY_NAME,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,18,3,'Y',v_old_data.LAST_UPDATE_DATE,v_new_data.LAST_UPDATE_DATE,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,19,2,'Y',v_old_data.OWNER_NAME,v_new_data.OWNER_NAME,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,20,1,'N',v_old_data.SLA_DAYS,v_new_data.SLA_DAYS,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,21,2,'N',v_old_data.SLA_DAYS_TYPE,v_new_data.SLA_DAYS_TYPE,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,22,1,'N',v_old_data.SLA_JEOPARDY_DAYS,v_new_data.SLA_JEOPARDY_DAYS,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,23,1,'N',v_old_data.SLA_TARGET_DAYS,v_new_data.SLA_TARGET_DAYS,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,24,1,'N',v_old_data.SOURCE_REFERENCE_ID,v_new_data.SOURCE_REFERENCE_ID,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,25,2,'N',v_old_data.SOURCE_REFERENCE_TYPE,v_new_data.SOURCE_REFERENCE_TYPE,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,26,1,'N',v_old_data.STATUS_AGE_IN_BUS_DAYS,v_new_data.STATUS_AGE_IN_BUS_DAYS,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,28,3,'Y',v_old_data.STATUS_DATE,v_new_data.STATUS_DATE,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,30,2,'Y',v_old_data.TASK_STATUS,v_new_data.TASK_STATUS,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,31,2,'Y',v_old_data.TASK_TYPE,v_new_data.TASK_TYPE,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,32,2,'Y',v_old_data.TEAM_NAME,v_new_data.TEAM_NAME,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,33,2,'Y',v_old_data.TEAM_PARENT_NAME,v_new_data.TEAM_PARENT_NAME,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,34,2,'Y',v_old_data.TEAM_SUPERVISOR_NAME,v_new_data.TEAM_SUPERVISOR_NAME,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,36,2,'N',v_old_data.UNIT_OF_WORK,v_new_data.UNIT_OF_WORK,v_bue_id);
  
  commit;
  
  p_bue_id := v_bue_id;
  
exception

  when NO_DATA_FOUND then
    
    BPM_COMMON.ERROR_MSG(sysdate,$$PLSQL_UNIT,v_identifier,null,null,null,'No BPM_INSTANCE found for IDENTIFIER = ' || v_identifier);
    
  when OTHERS then
  
    v_sql_code := SQLCODE;
    v_error_message := substr(SQLERRM,1,500);
    
    BPM_COMMON.ERROR_MSG(sysdate,$$PLSQL_UNIT,v_identifier,v_bi_id,null,v_sql_code,v_error_message);

end;
/

commit;

alter session set plsql_code_type = interpreted;