/* Obsolete - No longer kept up to date. */

/*
alter session set plsql_code_type = native;

create or replace procedure UPD_NYEC_PROCESS_APP_MI_BE
  (p_old_data_xml in xmltype,
   p_new_data_xml in xmltype,
   p_bue_id out number)
as

  v_be_id number := null;
  v_bem_id number := 4; -- 'NYEC_ETL_PROCESS_APP_MI'  
  v_bi_id number := null;
  v_bsl_id number := 4;-- 'NYEC_ETL_PROCESS_APP_MI'
  v_bue_id number := null;
  v_butl_id number := 1; -- 'ETL'
  
  v_identifier varchar2(100) := null;
  
  v_start_date date := null;
  v_end_date date := null;
  v_current_date date := sysdate;
  
  v_sql_code number := null;
  v_error_message clob := null;
  
  /* select '     ' || 'STAGE_DONE_DATE' || ' varchar2(100),'  from dual
     union
    (select 
     case 
     when atc.DATA_TYPE = 'DATE' then '     ' || atc.COLUMN_NAME || ' varchar2(19),'
     when atc.DATA_TYPE = 'VARCHAR2' then '     ' || atc.COLUMN_NAME || ' varchar2(' || atc.DATA_LENGTH || '),'
     else '     ' || atc.COLUMN_NAME || ' varchar2(100),' 
     end column_elements
     from BPM_ATTRIBUTE_STAGING_TABLE bast
     inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
     where 
     bast.BSL_ID = 4 --'NYEC_ETL_PROCESS_APP_MI'
     and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_APP_MI');*/
     
  type t_data_xml_type is record
    ( 
     APP_ID varchar2(100),
     MISSING_INFO_ID varchar2(100),
     MI_ITEM_CREATE_DT varchar2(19),
     MI_ITEM_CREATE_TASK_TYPE varchar2(35),
     MI_ITEM_LEVEL varchar2(20),
     MI_ITEM_REQUESTED_BY varchar2(50),
     MI_ITEM_SATISFIED_CHANNEL varchar2(35),
     MI_ITEM_STATUS varchar2(35),
     MI_ITEM_STATUS_DT varchar2(19),
     MI_ITEM_STATUS_PERFORMER varchar2(50),
     MI_ITEM_TYPE varchar2(20),
     MI_LETTER_CYCLE_END_DT varchar2(19),
     MI_LETTER_CYCLE_START_DT varchar2(19),
     MI_LETTER_ID varchar2(100),
     MI_LETTER_REQUIRED_STATUS varchar2(20),
     MI_VALIDATED_DT varchar2(19),
     RFE_STATUS varchar2(35),
     RFE_STATUS_DT varchar2(19),
     STAGE_DONE_DATE varchar2(100),
     UNDELIVERABLE_IND varchar2(1),
     UNDELIVERABLE_IND_DT varchar2(19) 
    );
  v_old_data t_data_xml_type := null;
  v_new_data t_data_xml_type := null;

begin
  
  /*(select  '    xmlquery(''$x/ROWSET/ROW/' || 'STAGE_DONE_DATE' || '/text()[1]'' passing p_old_data_xml as "x" returning content).getStringVal() "' || 'STAGE_DONE_DATE' || '",' from dual)
    union
   (select 
    '    xmlquery(''$x/ROWSET/ROW/' || atc.COLUMN_NAME || '/text()[1]'' passing p_old_data_xml as "x" returning content).getStringVal() "' || atc.COLUMN_NAME || '",'
   from BPM_ATTRIBUTE_STAGING_TABLE bast
   inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
   where 
   bast.BSL_ID =   4 --'NYEC_ETL_PROCESS_APP_MI'
   and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_APP_MI');*/
   
  select
    xmlquery('$x/ROWSET/ROW/APP_ID/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "APP_ID",
    xmlquery('$x/ROWSET/ROW/MISSING_INFO_ID/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MISSING_INFO_ID",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_CREATE_DT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_ITEM_CREATE_DT",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_CREATE_TASK_TYPE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_ITEM_CREATE_TASK_TYPE",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_LEVEL/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_ITEM_LEVEL",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_REQUESTED_BY/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_ITEM_REQUESTED_BY",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_SATISFIED_CHANNEL/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_ITEM_SATISFIED_CHANNEL",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_STATUS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_ITEM_STATUS",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_STATUS_DT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_ITEM_STATUS_DT",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_STATUS_PERFORMER/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_ITEM_STATUS_PERFORMER",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_TYPE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_ITEM_TYPE",
    xmlquery('$x/ROWSET/ROW/MI_LETTER_CYCLE_END_DT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_LETTER_CYCLE_END_DT",
    xmlquery('$x/ROWSET/ROW/MI_LETTER_CYCLE_START_DT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_LETTER_CYCLE_START_DT",
    xmlquery('$x/ROWSET/ROW/MI_LETTER_ID/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_LETTER_ID",
    xmlquery('$x/ROWSET/ROW/MI_LETTER_REQUIRED_STATUS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_LETTER_REQUIRED_STATUS",
    xmlquery('$x/ROWSET/ROW/MI_VALIDATED_DT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_VALIDATED_DT",
    xmlquery('$x/ROWSET/ROW/RFE_STATUS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "RFE_STATUS",
    xmlquery('$x/ROWSET/ROW/RFE_STATUS_DT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "RFE_STATUS_DT",
    xmlquery('$x/ROWSET/ROW/STAGE_DONE_DATE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "STAGE_DONE_DATE",
    xmlquery('$x/ROWSET/ROW/UNDELIVERABLE_IND/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "UNDELIVERABLE_IND",
    xmlquery('$x/ROWSET/ROW/UNDELIVERABLE_IND_DT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "UNDELIVERABLE_IND_DT" 
  into v_old_data
  from dual;
  
  /*(select '    xmlquery(''$x/ROWSET/ROW/' || 'STAGE_DONE_DATE' || '/text()[1]'' passing p_new_data_xml as "x" returning content).getStringVal() "' || 'STAGE_DONE_DATE'|| '",' from dual)
    union
   (select 
    '    xmlquery(''$x/ROWSET/ROW/' || atc.COLUMN_NAME || '/text()[1]'' passing p_new_data_xml as "x" returning content).getStringVal() "' || atc.COLUMN_NAME || '",'
   from BPM_ATTRIBUTE_STAGING_TABLE bast
   inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
   where 
   bast.BSL_ID = 4 --'NYEC_ETL_PROCESS_APP_MI'
   and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_APP_MI'); */
   
  select
    xmlquery('$x/ROWSET/ROW/APP_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "APP_ID",
    xmlquery('$x/ROWSET/ROW/MISSING_INFO_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MISSING_INFO_ID",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_CREATE_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_ITEM_CREATE_DT",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_CREATE_TASK_TYPE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_ITEM_CREATE_TASK_TYPE",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_LEVEL/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_ITEM_LEVEL",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_REQUESTED_BY/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_ITEM_REQUESTED_BY",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_SATISFIED_CHANNEL/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_ITEM_SATISFIED_CHANNEL",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_STATUS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_ITEM_STATUS",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_STATUS_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_ITEM_STATUS_DT",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_STATUS_PERFORMER/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_ITEM_STATUS_PERFORMER",
    xmlquery('$x/ROWSET/ROW/MI_ITEM_TYPE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_ITEM_TYPE",
    xmlquery('$x/ROWSET/ROW/MI_LETTER_CYCLE_END_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_LETTER_CYCLE_END_DT",
    xmlquery('$x/ROWSET/ROW/MI_LETTER_CYCLE_START_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_LETTER_CYCLE_START_DT",
    xmlquery('$x/ROWSET/ROW/MI_LETTER_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_LETTER_ID",
    xmlquery('$x/ROWSET/ROW/MI_LETTER_REQUIRED_STATUS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_LETTER_REQUIRED_STATUS",
    xmlquery('$x/ROWSET/ROW/MI_VALIDATED_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_VALIDATED_DT",
    xmlquery('$x/ROWSET/ROW/RFE_STATUS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "RFE_STATUS",
    xmlquery('$x/ROWSET/ROW/RFE_STATUS_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "RFE_STATUS_DT",
    xmlquery('$x/ROWSET/ROW/STAGE_DONE_DATE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "STAGE_DONE_DATE",
    xmlquery('$x/ROWSET/ROW/UNDELIVERABLE_IND/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "UNDELIVERABLE_IND",
    xmlquery('$x/ROWSET/ROW/UNDELIVERABLE_IND_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "UNDELIVERABLE_IND_DT" 
  into v_new_data
  from dual;

  v_identifier := substr(v_new_data.MISSING_INFO_ID,1,100);
  v_end_date := to_date(v_new_data.STAGE_DONE_DATE,BPM_COMMON.DATE_FMT);
  
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
  
  BPM_EVENT.UPDATE_BIA(v_bi_id,228,1,'N',v_old_data.MI_LETTER_ID,v_new_data.MI_LETTER_ID,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,229,2,'Y',v_old_data.RFE_STATUS,v_new_data.RFE_STATUS,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,230,3,'Y',v_old_data.RFE_STATUS_DT,v_new_data.RFE_STATUS_DT,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,231,2,'Y',v_old_data.MI_ITEM_STATUS,v_new_data.MI_ITEM_STATUS,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,232,3,'Y',v_old_data.MI_ITEM_STATUS_DT,v_new_data.MI_ITEM_STATUS_DT,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,233,2,'Y',v_old_data.MI_ITEM_STATUS_PERFORMER,v_new_data.MI_ITEM_STATUS_PERFORMER,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,234,2,'N',v_old_data.MI_ITEM_SATISFIED_CHANNEL,v_new_data.MI_ITEM_SATISFIED_CHANNEL,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,235,3,'N',v_old_data.MI_LETTER_CYCLE_START_DT,v_new_data.MI_LETTER_CYCLE_START_DT,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,236,3,'N',v_old_data.MI_LETTER_CYCLE_END_DT,v_new_data.MI_LETTER_CYCLE_END_DT,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,240,2,'N',v_old_data.UNDELIVERABLE_IND,v_new_data.UNDELIVERABLE_IND,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,241,3,'N',v_old_data.UNDELIVERABLE_IND_DT,v_new_data.UNDELIVERABLE_IND_DT,v_bue_id);
  BPM_EVENT.UPDATE_BIA(v_bi_id,242,3,'N',v_old_data.MI_VALIDATED_DT,v_new_data.MI_VALIDATED_DT,v_bue_id);
  
  commit;
  
  p_bue_id := v_bue_id;
  
exception

  when NO_DATA_FOUND then
    
    BPM_COMMON.ERROR_MSG(sysdate,$$PLSQL_UNIT,v_identifier,null,null,null,'No BPM_INSTANCE found for IDENTIFIER = ' || v_identifier);
    
  when OTHERS then
  
    v_sql_code := SQLCODE;
    v_error_message := SQLERRM;
    
    BPM_COMMON.ERROR_MSG(sysdate,$$PLSQL_UNIT,v_identifier,v_bi_id,null,v_sql_code,v_error_message);

end;
/

commit;

alter session set plsql_code_type = interpreted;
*/