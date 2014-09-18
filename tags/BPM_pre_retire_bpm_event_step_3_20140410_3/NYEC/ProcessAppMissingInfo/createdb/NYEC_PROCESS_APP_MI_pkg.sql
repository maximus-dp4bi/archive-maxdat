alter session set plsql_code_type = native;

/*
  Columns REFER_TO_DISTRICT_IND, REFER_TO_DISTRICT_IND_DT,UNDELIVERABLE_IND,UNDELIVERABLE_IND_DT have been removed as per 
  Elizabeth T Wright's suggestion 11/13/12 (Refer to patch 20121108_1032_process_app_mi_r2_for_bpm_events)
*/

create or replace package NYEC_PROCESS_APP_MI as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  /*
  select '     '|| 'CEPAM_ID varchar2(100),' attr_element from dual  
  union 
  select '     '|| 'STAGE_DONE_DATE varchar2(19),' attr_element from dual  
  union 
  select '     '|| 'STG_LAST_UPDATE_DATE varchar2(19),' attr_element from dual  
  union 
  select 
    case 
      when atc.DATA_TYPE = 'DATE' then '     ' || atc.COLUMN_NAME || ' varchar2(19),'
      when atc.DATA_TYPE = 'VARCHAR2' then '     ' || atc.COLUMN_NAME || ' varchar2(' || atc.DATA_LENGTH || '),'
      else '     ' || atc.COLUMN_NAME || ' varchar2(100),' 
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
  bast.BSL_ID = 4
  and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_APP_MI'
  order by attr_element asc;
  */
  type T_INS_PAMI_XML is record
    (APP_ID varchar2(100),
     CEPAM_ID varchar2(100),
     HEART_MI_DUE_DT varchar2(19),
     MAXE_MI_DUE_DT varchar2(19),
     MISSING_INFO_ID varchar2(100),
     MI_ITEM_CREATE_DT varchar2(19),
     MI_ITEM_CREATE_TASK_TYPE varchar2(35),
     MI_ITEM_LEVEL varchar2(20),
     MI_ITEM_REQUESTED_BY varchar2(50),
     MI_ITEM_SATISFIED_REASON varchar2(60),
     MI_ITEM_STATUS varchar2(35),
     MI_ITEM_STATUS_DT varchar2(19),
     MI_ITEM_STATUS_PERFORMER varchar2(50),
     MI_ITEM_TYPE varchar2(20),
     MI_LETTER_CYCLE_END_DT varchar2(19),
     MI_LETTER_CYCLE_START_DT varchar2(19),
     MI_LETTER_ID varchar2(100),
     MI_LETTER_NAME varchar2(60),
     MI_LETTER_REQUIRED_STATUS varchar2(20),
     MI_TYPE_NAME varchar2(100),
     MI_VALIDATED_DT varchar2(19),
     RFE_STATUS varchar2(35),
     RFE_STATUS_DT varchar2(19),
     STAGE_DONE_DATE varchar2(19),
     STG_LAST_UPDATE_DATE varchar2(19));
     
  /*  
  select '     '|| 'STAGE_DONE_DATE varchar2(19),' attr_element from dual  
  union 
  select '     '|| 'STG_LAST_UPDATE_DATE varchar2(19),' attr_element from dual  
  union 
  select 
    case 
      when atc.DATA_TYPE = 'DATE' then '     ' || atc.COLUMN_NAME || ' varchar2(19),'
      when atc.DATA_TYPE = 'VARCHAR2' then '     ' || atc.COLUMN_NAME || ' varchar2(' || atc.DATA_LENGTH || '),'
      else '     ' || atc.COLUMN_NAME || ' varchar2(100),' 
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
  bast.BSL_ID = 4
  and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_APP_MI'
  order by attr_element asc;
  */
  type T_UPD_PAMI_XML is record
    (APP_ID varchar2(100),
     HEART_MI_DUE_DT varchar2(19),
     MAXE_MI_DUE_DT varchar2(19),
     MISSING_INFO_ID varchar2(100),
     MI_ITEM_CREATE_DT varchar2(19),
     MI_ITEM_CREATE_TASK_TYPE varchar2(35),
     MI_ITEM_LEVEL varchar2(20),
     MI_ITEM_REQUESTED_BY varchar2(50),
     MI_ITEM_SATISFIED_REASON varchar2(60),
     MI_ITEM_STATUS varchar2(35),
     MI_ITEM_STATUS_DT varchar2(19),
     MI_ITEM_STATUS_PERFORMER varchar2(50),
     MI_ITEM_TYPE varchar2(20),
     MI_LETTER_CYCLE_END_DT varchar2(19),
     MI_LETTER_CYCLE_START_DT varchar2(19),
     MI_LETTER_ID varchar2(100),
     MI_LETTER_NAME varchar2(60),
     MI_LETTER_REQUIRED_STATUS varchar2(20),
     MI_TYPE_NAME varchar2(100),
     MI_VALIDATED_DT varchar2(19),
     RFE_STATUS varchar2(35),
     RFE_STATUS_DT varchar2(19),
     STAGE_DONE_DATE varchar2(19),
     STG_LAST_UPDATE_DATE varchar2(19));
     
   procedure INSERT_BPM_EVENT
    (p_data_version in number,
     p_new_data_xml in xmltype,
     p_bue_id out number);
     
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype);
     
  procedure UPDATE_BPM_EVENT
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype,
     p_bue_id out number);
     
  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype);
     
end;
/

create or replace package body NYEC_PROCESS_APP_MI as

  v_bem_id number := 4; -- 'NYEC OPS Process Application MI'
  v_bil_id number := 6; -- 'Missing Info ID'
  v_bsl_id number := 4; -- 'NYEC_ETL_PROCESS_APP_MI'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  
  -- Get dimension ID for BPM Semantic model - Process app MI- Item status performer
   procedure GET_DNPAMIISP_ID
       (p_identifier in varchar2,
        p_bi_id in number,
        p_MI_item_stats_perfrmr in varchar2,
        p_dnpamiisp_id out number)
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAMIISP_ID';
       v_sql_code number := null;
       v_log_message clob := null;
     begin
       select DNPAMIISP_ID into p_dnpamiisp_id
       from D_NYEC_PAMI_ITEM_STATUS_PER
       where "MI Item Status Performer" = p_MI_item_stats_perfrmr or ("MI Item Status Performer" is null and p_MI_item_stats_perfrmr is null);
     exception
       when NO_DATA_FOUND then
         p_dnpamiisp_id := SEQ_DNPAMIISP_ID.nextval;
         begin
           insert into D_NYEC_PAMI_ITEM_STATUS_PER (DNPAMIISP_ID,"MI Item Status Performer")
           values (p_dnpamiisp_id,p_MI_item_stats_perfrmr);
           commit;
         exception
           when DUP_VAL_ON_INDEX then
             select DNPAMIISP_ID into p_dnpamiisp_id
             from D_NYEC_PAMI_ITEM_STATUS_PER
             where "MI Item Status Performer" = p_MI_item_stats_perfrmr or ("MI Item Status Performer" is null and p_MI_item_stats_perfrmr is null);
          when OTHERS then
           v_sql_code := SQLCODE;
           v_log_message := SQLERRM;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
           raise;
         end;
       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
         raise;
  end;
  
     -- Get dimension ID for BPM Semantic model - Process app MI- Item status
     
     procedure GET_DNPAMIIS_ID
           (p_identifier in varchar2,
            p_bi_id in number,
            p_MI_item_status in varchar2,
            p_dnpamiis_id out number)
         as
           v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAMIIS_ID';
           v_sql_code number := null;
           v_log_message clob := null;
         begin
           select DNPAMIIS_ID into p_dnpamiis_id
           from D_NYEC_PAMI_ITEM_STATUS
           where "MI Item Status" = p_MI_item_status or ("MI Item Status" is null and p_MI_item_status is null);
         exception
           when NO_DATA_FOUND then
             p_dnpamiis_id := SEQ_DNPAMIIS_ID.nextval;
             begin
               insert into D_NYEC_PAMI_ITEM_STATUS (DNPAMIIS_ID,"MI Item Status")
               values (p_dnpamiis_id,p_MI_item_status);
               commit;
             exception
               when DUP_VAL_ON_INDEX then
                 select DNPAMIIS_ID into p_dnpamiis_id
                 from D_NYEC_PAMI_ITEM_STATUS
                 where "MI Item Status" = p_MI_item_status or ("MI Item Status" is null and p_MI_item_status is null);
              when OTHERS then
               v_sql_code := SQLCODE;
               v_log_message := SQLERRM;
               BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
               raise;
             end;
           when OTHERS then
             v_sql_code := SQLCODE;
             v_log_message := SQLERRM;
             BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
             raise;
  end;
  
  -- Get dimension ID for BPM Semantic model - Process app MI- RFE status
  
    procedure GET_DNPAMIRS_ID
        (p_identifier in varchar2,
         p_bi_id in number,
         p_RFE_status in varchar2,
         p_dnpamirs_id out number)
      as
        v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAMIRS_ID';
        v_sql_code number := null;
        v_log_message clob := null;
      begin
        select DNPAMIRS_ID into p_dnpamirs_id
        from D_NYEC_PAMI_RFE_STATUS
        where "RFE Status" = p_RFE_status or ("RFE Status" is null and p_RFE_status is null);
      exception
        when NO_DATA_FOUND then
          p_dnpamirs_id := SEQ_DNPAMIRS_ID.nextval;
          begin
            insert into D_NYEC_PAMI_RFE_STATUS (DNPAMIRS_ID,"RFE Status")
            values (p_dnpamirs_id,p_RFE_status);
            commit;
          exception
            when DUP_VAL_ON_INDEX then
              select DNPAMIRS_ID into p_dnpamirs_id
              from D_NYEC_PAMI_RFE_STATUS
              where "RFE Status" = p_RFE_status or ("RFE Status" is null and p_RFE_status is null);
           when OTHERS then
            v_sql_code := SQLCODE;
            v_log_message := SQLERRM;
            BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
            raise;
          end;
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code); 
          raise;
  end;
  
   -- Get record for Process App MI insert XML.
   
   procedure GET_INS_PAMI_XML
       (p_data_xml in xmltype,
        p_data_record out T_INS_PAMI_XML)
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_PAMI_XML';
       v_sql_code number := null;
       v_log_message clob := null;
  begin
  
   /*
    select  '        extractValue(p_data_xml,''/ROWSET/ROW/CEPAM_ID'') "' || 'CEPAM_ID'|| '",' attr_element from dual
    union 
    select  '        extractValue(p_data_xml,''/ROWSET/ROW/STAGE_DONE_DATE'') "' || 'STAGE_DONE_DATE'|| '",' attr_element from dual
    union 
    select  '        extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
    union 
    select 
    '        extractValue(p_data_xml,/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
    from BPM_ATTRIBUTE_STAGING_TABLE bast
    inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
    where 
      bast.BSL_ID = 4
      and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_APP_MI'
    order by attr_element asc;
    */
    select
        extractValue(p_data_xml,'/ROWSET/ROW/APP_ID') "APP_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/CEPAM_ID') "CEPAM_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/HEART_MI_DUE_DT') "HEART_MI_DUE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MAXE_MI_DUE_DT') "MAXE_MI_DUE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MISSING_INFO_ID') "MISSING_INFO_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_CREATE_DT') "MI_ITEM_CREATE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_CREATE_TASK_TYPE') "MI_ITEM_CREATE_TASK_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_LEVEL') "MI_ITEM_LEVEL",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_REQUESTED_BY') "MI_ITEM_REQUESTED_BY",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_SATISFIED_REASON') "MI_ITEM_SATISFIED_REASON",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_STATUS') "MI_ITEM_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_STATUS_DT') "MI_ITEM_STATUS_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_STATUS_PERFORMER') "MI_ITEM_STATUS_PERFORMER",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_TYPE') "MI_ITEM_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_CYCLE_END_DT') "MI_LETTER_CYCLE_END_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_CYCLE_START_DT') "MI_LETTER_CYCLE_START_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_ID') "MI_LETTER_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_NAME') "MI_LETTER_NAME",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_REQUIRED_STATUS') "MI_LETTER_REQUIRED_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_TYPE_NAME') "MI_TYPE_NAME",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_VALIDATED_DT') "MI_VALIDATED_DT",
       -- extractValue(p_data_xml,'/ROWSET/ROW/REFER_TO_DISTRICT_IND') "REFER_TO_DISTRICT_IND",
       -- extractValue(p_data_xml,'/ROWSET/ROW/REFER_TO_DISTRICT_IND_DT') "REFER_TO_DISTRICT_IND_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/RFE_STATUS') "RFE_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/RFE_STATUS_DT') "RFE_STATUS_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/STAGE_DONE_DATE') "STAGE_DONE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE"--,
        --extractValue(p_data_xml,'/ROWSET/ROW/UNDELIVERABLE_IND') "UNDELIVERABLE_IND",
        --extractValue(p_data_xml,'/ROWSET/ROW/UNDELIVERABLE_IND_DT') "UNDELIVERABLE_IND_DT"   
        into p_data_record
	from dual;
	
	  exception
	
	    when OTHERS then
	      v_sql_code := SQLCODE;
	      v_log_message := SQLERRM;
	      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
	      raise;
	    
  end;
  
  -- Get record for Process App MI update XML. 
  
  procedure GET_UPD_PAMI_XML
      (p_data_xml in xmltype,
       p_data_record out T_UPD_PAMI_XML)
    as
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_PAMI_XML';
      v_sql_code number := null;
      v_log_message clob := null;
  begin 
  
  /*
  select  '        extractValue(p_data_xml,''/ROWSET/ROW/STAGE_DONE_DATE'') "' || 'STAGE_DONE_DATE'|| '",' attr_element from dual
      union 
       select  '        extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
      union 
      select 
      '        extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
      from BPM_ATTRIBUTE_STAGING_TABLE bast
      inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
      where 
      bast.BSL_ID = 4
      and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_APP_MI'
    order by attr_element asc;
  */
  
        select
        extractValue(p_data_xml,'/ROWSET/ROW/APP_ID') "APP_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/HEART_MI_DUE_DT') "HEART_MI_DUE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MAXE_MI_DUE_DT') "MAXE_MI_DUE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MISSING_INFO_ID') "MISSING_INFO_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_CREATE_DT') "MI_ITEM_CREATE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_CREATE_TASK_TYPE') "MI_ITEM_CREATE_TASK_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_LEVEL') "MI_ITEM_LEVEL",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_REQUESTED_BY') "MI_ITEM_REQUESTED_BY",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_SATISFIED_REASON') "MI_ITEM_SATISFIED_REASON",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_STATUS') "MI_ITEM_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_STATUS_DT') "MI_ITEM_STATUS_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_STATUS_PERFORMER') "MI_ITEM_STATUS_PERFORMER",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_ITEM_TYPE') "MI_ITEM_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_CYCLE_END_DT') "MI_LETTER_CYCLE_END_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_CYCLE_START_DT') "MI_LETTER_CYCLE_START_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_ID') "MI_LETTER_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_NAME') "MI_LETTER_NAME",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_REQUIRED_STATUS') "MI_LETTER_REQUIRED_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_TYPE_NAME') "MI_TYPE_NAME",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_VALIDATED_DT') "MI_VALIDATED_DT",
        -- extractValue(p_data_xml,'/ROWSET/ROW/REFER_TO_DISTRICT_IND') "REFER_TO_DISTRICT_IND",
        -- extractValue(p_data_xml,'/ROWSET/ROW/REFER_TO_DISTRICT_IND_DT') "REFER_TO_DISTRICT_IND_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/RFE_STATUS') "RFE_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/RFE_STATUS_DT') "RFE_STATUS_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/STAGE_DONE_DATE') "STAGE_DONE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE"--,
        --extractValue(p_data_xml,'/ROWSET/ROW/UNDELIVERABLE_IND') "UNDELIVERABLE_IND",
        --extractValue(p_data_xml,'/ROWSET/ROW/UNDELIVERABLE_IND_DT') "UNDELIVERABLE_IND_DT"
        into p_data_record
	from dual;
	
	  exception
	
	    when OTHERS then
	      v_sql_code := SQLCODE;
	      v_log_message := SQLERRM;
	      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
	      raise;
	  
  end;
  
   -- Insert fact for BPM Semantic model - Process App MI process. 
   
   procedure INS_FPAMIBD
         (p_identifier in varchar2,
          p_start_date in date,
          p_end_date in date,
          p_bi_id in number,
          p_dnpamirs_id in number,
          p_dnpamiis_id in number,
          p_dnpamiisp_id in number,
          p_mi_item_status_date in varchar2,
          p_rfe_status_date in varchar2,
          p_stg_last_update_date in varchar2,
          p_fnpamibd_id out number)
  as
  v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FPAMIBD';
  v_sql_code number := null;
  v_log_message clob := null;
  v_bucket_start_date date := null;
  v_bucket_end_date date := null;
  v_mi_item_status_date date :=null;
  v_rfe_status_date date:=null;
  
  v_stg_last_update_date date := null;
  
  begin
        v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
        v_mi_item_status_date:=to_date(p_mi_item_status_date,BPM_COMMON.DATE_FMT);
        v_rfe_status_date:=to_date(p_rfe_status_date,BPM_COMMON.DATE_FMT);
        p_fnpamibd_id := SEQ_FNPAMIBD_ID.nextval; 
        
        v_bucket_start_date := to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt);
        if p_end_date is null then
        
          v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
        else 
        
          v_bucket_end_date := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
          
        end if;
        
    -- Validate fact date ranges.
    /*
    if p_start_date < v_bucket_start_date
      or to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt) > v_bucket_end_date
      or v_bucket_start_date > v_bucket_end_date
      or v_bucket_end_date < v_bucket_start_date
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || p_start_date || 
        ' BUCKET_START_DATE = ' || to_char(v_bucket_start_date,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(v_bucket_end_date,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;        
    */
    
        insert into F_NYEC_PAMI_BY_DATE
          (FNPAMIBD_ID,
           D_DATE,
           BUCKET_START_DATE,
           BUCKET_END_DATE,
           NYEC_PAMI_BI_ID,
           DNPAMIIS_ID,
           DNPAMIISP_ID,
           DNPAMIRS_ID,
           "MI Item Status Date",
           CREATION_COUNT,
           INVENTORY_COUNT,
           COMPLETION_COUNT,
           "RFE Status Date")
        values
          (p_fnpamibd_id,
           p_start_date,
           v_bucket_start_date,
           v_bucket_end_date,
           p_bi_id,
           p_dnpamiis_id,
           p_dnpamiisp_id,
           p_dnpamirs_id,
           v_mi_item_status_date,
           1,
           case 
           when p_end_date is null then 1
           else 0
           end,
           case 
             when p_end_date is null then 0
             else 1
             end,
            v_rfe_status_date
            );
      exception
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
          raise;
    end; 
    
     -- Insert BPM Event model data.
        procedure INSERT_BPM_EVENT
          (p_data_version in number,
           p_new_data_xml in xmltype,
           p_bue_id out number)
        as
        
          v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_EVENT';
          v_sql_code number := null;
          v_log_message clob := null;
          
          v_bi_id number := null;
          v_bue_id number := null;
        
          v_identifier varchar2(35) := null;
          
          v_start_date date := null;
          v_end_date date := null;
          v_app_complete_date date:=null;
         
          
          v_new_data T_INS_PAMI_XML := null;
          
        begin
      
          if p_data_version != 1 then
            v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Process App MI in procedure ' || v_procedure_name || '.';
            RAISE_APPLICATION_ERROR(-20011,v_log_message);        
          end if;
          
          GET_INS_PAMI_XML(p_new_data_xml,v_new_data);
      
          v_bi_id := SEQ_BI_ID.nextval;
          v_identifier := v_new_data.MISSING_INFO_ID;
          v_start_date := to_date(v_new_data.MI_ITEM_CREATE_DT,BPM_COMMON.DATE_FMT);
         
         
         if (v_new_data.MI_ITEM_STATUS='Unsatisfied') then
	   
	   begin
       
       with rn as
        (select nvl(max(REACTIVATION_NBR),0) max_reactivation_number
         from NYEC_ETL_PROCESS_APP
         where APP_ID = v_new_data.app_id)
       select COMPLETE_DT
       into v_app_complete_date
       from 
         NYEC_ETL_PROCESS_APP,
         rn
       where 
         APP_ID = v_new_data.app_id
         and REACTIVATION_NBR = rn.max_reactivation_number;
	     
	     exception
	        when NO_DATA_FOUND then
	        null;
          
	   end;
	   
	   v_end_date:=coalesce(v_app_complete_date,BPM_COMMON.MAX_DATE);
	   else if (v_new_data.MI_ITEM_STATUS='Satisfied' or v_new_data.MI_ITEM_STATUS='Removed') then
	   v_end_date:=coalesce(to_date(v_new_data.MI_ITEM_STATUS_DT,BPM_COMMON.DATE_FMT),BPM_COMMON.MAX_DATE);
	   else
	   v_end_date:=BPM_COMMON.MAX_DATE;
	   end if;
	   end if;
     
          BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
        
          insert into BPM_INSTANCE 
            (BI_ID,BEM_ID,IDENTIFIER,BIL_ID,BSL_ID,
             START_DATE,END_DATE,SOURCE_ID,CREATION_DATE,LAST_UPDATE_DATE)
          values
            (v_bi_id,v_bem_id,v_identifier,v_bil_id,v_bsl_id,
             v_start_date,v_end_date,to_char(v_new_data.CEPAM_ID),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT));
      
          commit;
        
          v_bue_id := SEQ_BUE_ID.nextval;
      
          insert into BPM_UPDATE_EVENT
            (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
          values
        (v_bue_id,v_bi_id,v_butl_id,to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),'N');
        
           BPM_EVENT.INSERT_BIA(v_bi_id,221,1,v_new_data.APP_ID,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,222,1,v_new_data.MISSING_INFO_ID,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,223,2,v_new_data.MI_ITEM_LEVEL,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,224,2,v_new_data.MI_ITEM_TYPE,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,225,3,v_new_data.MI_ITEM_CREATE_DT,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,226,2,v_new_data.MI_ITEM_REQUESTED_BY,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,227,2,v_new_data.MI_LETTER_REQUIRED_STATUS,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,228,1,v_new_data.MI_LETTER_ID,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,229,2,v_new_data.RFE_STATUS,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,230,3,v_new_data.RFE_STATUS_DT,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,231,2,v_new_data.MI_ITEM_STATUS,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,232,3,v_new_data.MI_ITEM_STATUS_DT,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,233,2,v_new_data.MI_ITEM_STATUS_PERFORMER,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,235,3,v_new_data.MI_LETTER_CYCLE_START_DT,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,236,3,v_new_data.MI_LETTER_CYCLE_END_DT,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,237,2,v_new_data.MI_ITEM_CREATE_TASK_TYPE,v_start_date,v_bue_id);
	  -- BPM_EVENT.INSERT_BIA(v_bi_id,238,2,v_new_data.REFER_TO_DISTRICT_IND,v_start_date,v_bue_id);
	  -- BPM_EVENT.INSERT_BIA(v_bi_id,239,3,v_new_data.REFER_TO_DISTRICT_IND_DT,v_start_date,v_bue_id);
	  -- BPM_EVENT.INSERT_BIA(v_bi_id,240,2,v_new_data.UNDELIVERABLE_IND,v_start_date,v_bue_id);
	  -- BPM_EVENT.INSERT_BIA(v_bi_id,241,3,v_new_data.UNDELIVERABLE_IND_DT,v_start_date,v_bue_id);
           BPM_EVENT.INSERT_BIA(v_bi_id,242,3,v_new_data.MI_VALIDATED_DT,v_start_date,v_bue_id);
           
           BPM_EVENT.INSERT_BIA(v_bi_id,420,3,v_new_data.HEART_MI_DUE_DT,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,421,3,v_new_data.MAXE_MI_DUE_DT,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,422,2,v_new_data.MI_TYPE_NAME,v_start_date,v_bue_id);
	   BPM_EVENT.INSERT_BIA(v_bi_id,423,2,v_new_data.MI_LETTER_NAME,v_start_date,v_bue_id);
           BPM_EVENT.INSERT_BIA(v_bi_id,424,2,v_new_data.MI_ITEM_SATISFIED_REASON,v_start_date,v_bue_id);
           
commit;
    
      p_bue_id := v_bue_id;
    
    exception
     
      when OTHERS then
        v_sql_code := SQLCODE;
        v_log_message := SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
    
  end;
  
  -- Insert or update dimension for BPM Semantic model - Process App MI process - Current.
  
    procedure SET_DPAMICUR
     (   p_set_type in varchar2,
     	 p_identifier in varchar2,
     	 p_bi_id in number,
         p_MI_item_id in number,
	 p_application_id in number,
	 p_MI_item_level in varchar2, 
	 p_MI_item_type in varchar2 ,
	 p_MI_item_create_date in varchar2,
	 p_MI_item_requested_by in varchar2, 
	 p_MI_letter_required_status in varchar2 ,
	 p_MI_letter_id in number, 
	 p_rfe_status in varchar2, 
	 p_rfe_status_date in varchar2,
	 p_MI_item_status in varchar2, 
	 p_MI_item_status_date in varchar2,
	 p_MI_item_status_performer in varchar2 ,
         p_MI_letter_cycle_start_date in varchar2,
	 p_MI_letter_cycle_end_date in varchar2,
	 p_MI_item_create_task_type in varchar2, 
	-- p_refr_to_district_checkbx in varchar2,
	-- p_refr_to_district_checkbx_dt in varchar2,
	-- p_undeliverable_checkbox in varchar2, 
	-- p_undeliverable_checkbox_date in varchar2,
	 p_MI_validated_date in varchar2,
	 p_heart_MI_due_date in varchar2,
	 p_maxe_MI_due_date in varchar2,
	 p_MI_type in varchar2, 
	 p_MI_letter_name in varchar2, 
         p_MI_satisfied_reason in varchar2  )
    as
    
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DPAMICUR';
          v_sql_code number := null;
          v_log_message clob := null;
          r_dpamicur D_NYEC_PAMI_CURRENT%rowtype := null;
          
    begin
        r_dpamicur.NYEC_PAMI_BI_ID := p_bi_id;
        r_dpamicur."MI Item ID" :=p_MI_item_id ;         
    	r_dpamicur."Application ID" :=p_application_id;
      	r_dpamicur."MI Item Level" :=p_MI_item_level; 
	r_dpamicur."MI Item Type" :=p_MI_item_type; 
	r_dpamicur."MI Item Create Date" :=to_date(p_MI_item_create_date,BPM_COMMON.DATE_FMT); 	 
	r_dpamicur."MI Item Requested By" :=p_MI_item_requested_by;	 
	r_dpamicur."MI Letter Required Status" := p_MI_letter_required_status;	
	r_dpamicur."MI Letter ID" :=p_MI_letter_id;	 
	r_dpamicur."Cur RFE Status" :=p_rfe_status;	 
	r_dpamicur."RFE Status Date" :=to_date(p_rfe_status_date,BPM_COMMON.DATE_FMT);	 
	r_dpamicur."Cur MI Item Status" :=p_MI_item_status;	 
	r_dpamicur."MI Item Status Date" :=to_date(p_MI_item_status_date,BPM_COMMON.DATE_FMT);	 
	r_dpamicur."Cur MI Item Status Performer" :=p_MI_item_status_performer; 
	r_dpamicur."MI Letter Cycle Start Date" :=to_date(p_MI_letter_cycle_start_date,BPM_COMMON.DATE_FMT); 
	r_dpamicur."MI Letter Cycle End Date" :=to_date(p_MI_letter_cycle_end_date,BPM_COMMON.DATE_FMT);	 
	r_dpamicur."MI Item Create Task Type" :=p_MI_item_create_task_type;	 
	--r_dpamicur."Refer to District Checkbx" :=p_refr_to_district_checkbx;	 
	--r_dpamicur."Refer to District Checkbx Date" :=to_date(p_refr_to_district_checkbx_dt,BPM_COMMON.DATE_FMT);	
	--r_dpamicur."Undeliverable Checkbox" :=p_undeliverable_checkbox;
	--r_dpamicur."Undeliverable Checkbox Date" :=to_date(p_undeliverable_checkbox_date,BPM_COMMON.DATE_FMT);	
	r_dpamicur."MI Validated Date" :=to_date(p_MI_validated_date,BPM_COMMON.DATE_FMT);	 
	r_dpamicur."HEART MI Due Date" :=to_date(p_heart_MI_due_date,BPM_COMMON.DATE_FMT);	 
	r_dpamicur."MAXe MI Due Date" :=to_date(p_maxe_MI_due_date,BPM_COMMON.DATE_FMT);	 
	r_dpamicur."MI Type" :=p_MI_type ;	 
	r_dpamicur. "MI Letter Name" :=p_MI_letter_name ;	 
	r_dpamicur."MI Satisfied Reason" :=p_MI_satisfied_reason;
	
if p_set_type = 'INSERT' then
       insert into D_NYEC_PAMI_CURRENT
       values r_dpamicur;
      elsif p_set_type = 'UPDATE' then
      begin
        update D_NYEC_PAMI_CURRENT
        set row = r_dpamicur
        where NYEC_PAMI_BI_ID = p_bi_id;
      end;
      else
        v_log_message := 'Unexpected p_set_type value "' || p_set_type || '" in procedure ' || v_procedure_name || '.';
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
        RAISE_APPLICATION_ERROR(-20001,v_log_message);
      end if;
      
    exception
      when OTHERS then
        v_sql_code := SQLCODE;
        v_log_message := SQLERRM;
     BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
        raise;
  end;
  
  -- Insert BPM Semantic model data.
  
  procedure INSERT_BPM_SEMANTIC
        (p_data_version in number,
         p_new_data_xml in xmltype)
      as
      
        v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
        v_sql_code number := null;
        v_log_message clob := null;
        
        v_new_data T_INS_PAMI_XML := null;
        
        v_bi_id number := null;
        v_identifier varchar2(35) := null;
        
        v_start_date date := null;
        v_end_date date := null;
        v_app_complete_date date:=null;
        
  
        v_dnpamiisp_id number := null;  
        v_dnpamiis_id number := null;
        v_dnpamirs_id number := null;
        v_fnpamibd_id number := null;
            
    begin
    
    if p_data_version != 1 then
            v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Process App MI in procedure ' || v_procedure_name || '.';
            RAISE_APPLICATION_ERROR(-20011,v_log_message);        
          end if;
          
          GET_INS_PAMI_XML(p_new_data_xml,v_new_data);
          
          v_identifier := v_new_data.MISSING_INFO_ID;
          v_start_date := to_date(v_new_data.MI_ITEM_CREATE_DT,BPM_COMMON.DATE_FMT);
        
          if (v_new_data.MI_ITEM_STATUS='Unsatisfied') then
	  	   
	  	   begin
           
           with rn as
             (select nvl(max(REACTIVATION_NBR),0) max_reactivation_number
              from NYEC_ETL_PROCESS_APP
              where APP_ID = v_new_data.app_id)
           select COMPLETE_DT
           into v_app_complete_date
           from 
             NYEC_ETL_PROCESS_APP,
             rn
           where 
             APP_ID = v_new_data.app_id
             and REACTIVATION_NBR = rn.max_reactivation_number;
	  	     
	  	     exception
           
	  	       when NO_DATA_FOUND then
	  	       null;
	  	   end;
	  	   
	  	   v_end_date:=coalesce(v_app_complete_date,BPM_COMMON.MAX_DATE);
	  	   else if (v_new_data.MI_ITEM_STATUS='Satisfied' or v_new_data.MI_ITEM_STATUS='Removed') then
	  	   v_end_date:=coalesce(to_date(v_new_data.MI_ITEM_STATUS_DT,BPM_COMMON.DATE_FMT),BPM_COMMON.MAX_DATE);
	  	   else
	  	   v_end_date:=BPM_COMMON.MAX_DATE;
	  	   end if;
	   end if;
         
     BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
     v_bi_id := SEQ_BI_ID.nextval;
        
   GET_DNPAMIISP_ID(v_identifier,v_bi_id,v_new_data.MI_ITEM_STATUS_PERFORMER,v_dnpamiisp_id );
   GET_DNPAMIIS_ID(v_identifier,v_bi_id,v_new_data.MI_ITEM_STATUS,v_dnpamiis_id);	  
   GET_DNPAMIRS_ID(v_identifier,v_bi_id,v_new_data.RFE_STATUS,v_dnpamirs_id);
   
 -- Insert current dimension and fact as a single transaction.
          begin
          
      commit;
         

 
 SET_DPAMICUR
 ('INSERT',v_identifier,v_bi_id,v_new_data.MISSING_INFO_ID ,v_new_data.APP_ID ,v_new_data.MI_ITEM_LEVEL ,v_new_data.MI_ITEM_TYPE,v_new_data.MI_ITEM_CREATE_DT,v_new_data.MI_ITEM_REQUESTED_BY,v_new_data.MI_LETTER_REQUIRED_STATUS  ,v_new_data.MI_LETTER_ID , 
   v_new_data.RFE_STATUS ,v_new_data.RFE_STATUS_DT,v_new_data.MI_ITEM_STATUS, v_new_data.MI_ITEM_STATUS_DT ,v_new_data.MI_ITEM_STATUS_PERFORMER,v_new_data.MI_LETTER_CYCLE_START_DT ,
   v_new_data.MI_LETTER_CYCLE_END_DT,v_new_data.MI_ITEM_CREATE_TASK_TYPE ,/*v_new_data.REFER_TO_DISTRICT_IND,v_new_data.REFER_TO_DISTRICT_IND_DT,v_new_data.UNDELIVERABLE_IND, v_new_data.UNDELIVERABLE_IND_DT ,*/
   v_new_data.MI_VALIDATED_DT ,v_new_data.HEART_MI_DUE_DT ,v_new_data.MAXE_MI_DUE_DT ,v_new_data.MI_TYPE_NAME , v_new_data.MI_LETTER_NAME , v_new_data.MI_ITEM_SATISFIED_REASON );
      
     
 INS_FPAMIBD
 (v_identifier ,v_start_date ,v_end_date ,v_bi_id ,v_dnpamirs_id ,v_dnpamiis_id ,v_dnpamiisp_id ,v_new_data.MI_ITEM_STATUS_DT ,
 v_new_data.RFE_STATUS_DT ,v_new_data.STG_LAST_UPDATE_DATE ,v_fnpamibd_id) ;
 
 commit;
             
           exception
           
             when OTHERS then
               rollback;
               v_sql_code := SQLCODE;
	       v_log_message := 'Rolled back initial insert for current dimension and fact.  ' || SQLERRM;
               BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);  
               raise;
       
     end;
       
     exception
       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
        raise; 
       
  end;
  
  -- Update fact for BPM Semantic model - NYEC Process App process. 
     procedure UPD_FPAMIBD
         (p_identifier in varchar2,
          p_start_date in date,
          p_end_date in date,
          p_bi_id in number,
          p_dnpamirs_id in number,
          p_dnpamiis_id in number,
          p_dnpamiisp_id in number,
          p_mi_item_status_date in varchar2,
          p_rfe_status_date in varchar2,
          p_stg_last_update_date in varchar2,
 	  p_fnpamibd_id out number)
 	
     as
     
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FPAMIBD';
       v_sql_code number := null;
       v_log_message clob := null;
       
       v_fnpamibd_id_old number := null;
       v_d_date_old date := null;
       v_stg_last_update_date date := null;
       v_mi_item_status_date date := null;
       v_creation_count_old number := null;
       v_completion_count_old number := null;
       v_max_d_date date := null;
       v_rfe_status_date date:= null;
       v_event_date date := null;
   
       r_fnpamibd F_NYEC_PAMI_BY_DATE%rowtype := null;
       
     begin
  
       v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
       v_mi_item_status_date := to_date(p_mi_item_status_date,BPM_COMMON.DATE_FMT);
       v_rfe_status_date:=to_date(p_rfe_status_date,BPM_COMMON.DATE_FMT);
       v_event_date := v_stg_last_update_date;
       
       with most_recent_fact_bi_id as
         (select 
            max(FNPAMIBD_ID) max_fnpamibd_id,
            max(D_DATE) max_d_date
          from F_NYEC_PAMI_BY_DATE
          where NYEC_PAMI_BI_ID = p_bi_id) 
       select 
         fnpamibd.FNPAMIBD_ID,
         fnpamibd.D_DATE,
         fnpamibd.CREATION_COUNT,
         fnpamibd.COMPLETION_COUNT,
       most_recent_fact_bi_id.max_d_date
       into 
         v_fnpamibd_id_old,
         v_d_date_old,
         v_creation_count_old,
         v_completion_count_old,
         v_max_d_date
       from 
         F_NYEC_PAMI_BY_DATE fnpamibd,
         most_recent_fact_bi_id 
       where
        fnpamibd.FNPAMIBD_ID = max_fnpamibd_id
        and fnpamibd.D_DATE = most_recent_fact_bi_id.max_d_date;
        
    -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
    
      -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE. 
            if v_stg_last_update_date < v_max_d_date then
              v_stg_last_update_date := v_max_d_date;
     end if;
     
    if p_end_date is null then
      r_fnpamibd.D_DATE := v_event_date;
      r_fnpamibd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpamibd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpamibd.INVENTORY_COUNT := 1;
      r_fnpamibd.COMPLETION_COUNT := 0;
    else
      r_fnpamibd.D_DATE := p_end_date;
      r_fnpamibd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpamibd.BUCKET_END_DATE := r_fnpamibd.BUCKET_START_DATE;
      r_fnpamibd.INVENTORY_COUNT := 0;
      r_fnpamibd.COMPLETION_COUNT := 1;
    end if;
   
       p_fnpamibd_id := SEQ_FNPAMIBD_ID.nextval;
       r_fnpamibd.FNPAMIBD_ID := p_fnpamibd_id;
       r_fnpamibd.D_DATE := v_stg_last_update_date; 
       r_fnpamibd.NYEC_PAMI_BI_ID := p_bi_id;
       r_fnpamibd.DNPAMIISP_ID := p_dnpamiisp_id;
       r_fnpamibd.DNPAMIIS_ID := p_dnpamiis_id;
       r_fnpamibd.DNPAMIRS_ID := p_dnpamirs_id;
       r_fnpamibd."MI Item Status Date":=v_mi_item_status_date;
       r_fnpamibd.CREATION_COUNT := 0;
       r_fnpamibd."RFE Status Date":=v_rfe_status_date;
       r_fnpamibd.DNPAMIISP_ID:=p_dnpamiisp_id;
       r_fnpamibd.DNPAMIIS_ID:=p_dnpamiis_id;
       r_fnpamibd.DNPAMIRS_ID:=p_dnpamirs_id;

    -- Validate fact date ranges.
    /*
    if r_fnpamibd.D_DATE < r_fnpamibd.BUCKET_START_DATE
      or to_date(to_char(r_fnpamibd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fnpamibd.BUCKET_END_DATE
      or r_fnpamibd.BUCKET_START_DATE > r_fnpamibd.BUCKET_END_DATE
      or r_fnpamibd.BUCKET_END_DATE < r_fnpamibd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || r_fnpamibd.D_DATE || 
        ' BUCKET_START_DATE = ' || to_char(r_fnpamibd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_fnpamibd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
    */
       
       if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fnpamibd.BUCKET_START_DATE then
         -- Same bucket time.
         if v_creation_count_old = 1 then
            r_fnpamibd.CREATION_COUNT := v_creation_count_old;
         end if;
         update F_NYEC_PAMI_BY_DATE
         set row = r_fnpamibd
         where FNPAMIBD_ID = v_fnpamibd_id_old;
       else
         -- Different bucket time.
         update F_NYEC_PAMI_BY_DATE
         set BUCKET_END_DATE = r_fnpamibd.BUCKET_START_DATE
         where FNPAMIBD_ID = v_fnpamibd_id_old;
         
         insert into F_NYEC_PAMI_BY_DATE
         values r_fnpamibd;
       end if;
     
     exception
       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
       raise; 
    end;
    
     -- Update BPM Event model data.
      procedure UPDATE_BPM_EVENT
        (p_data_version in number,
         p_old_data_xml in xmltype,
         p_new_data_xml in xmltype,
         p_bue_id out number)
      as
    
        v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_EVENT';  
        v_sql_code number := null;
        v_log_message clob := null;
        
        v_be_id number := null;
        v_bi_id number := null;
        v_bue_id number := null;
      
        v_identifier varchar2(35) := null;
      
        v_start_date date := null;
        v_end_date date := null;
        v_stg_last_update_date date := null;
        v_app_complete_date date:=null;
    
        v_old_data T_UPD_PAMI_XML := null;
        v_new_data T_UPD_PAMI_XML := null;
    
      begin
    
        if p_data_version != 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" with NYEC Process App MI in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);        
        end if; 
    
        GET_UPD_PAMI_XML(p_old_data_xml,v_old_data);
        GET_UPD_PAMI_XML(p_new_data_xml,v_new_data);
    
        v_identifier := v_new_data.MISSING_INFO_ID;
        v_stg_last_update_date := to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT);
        
        if (v_new_data.MI_ITEM_STATUS='Unsatisfied') then
		   
		   begin
		   
         with rn as
           (select nvl(max(REACTIVATION_NBR),0) max_reactivation_number
            from NYEC_ETL_PROCESS_APP
            where APP_ID = v_new_data.app_id)
         select COMPLETE_DT
         into v_app_complete_date
         from 
           NYEC_ETL_PROCESS_APP,
           rn
         where 
           APP_ID = v_new_data.app_id
           and REACTIVATION_NBR = rn.max_reactivation_number;	
           
		     exception
         
		       when NO_DATA_FOUND then
		         null;
             
		   end;
		   
		   v_end_date:=coalesce(v_app_complete_date,BPM_COMMON.MAX_DATE);
		   else if (v_new_data.MI_ITEM_STATUS='Satisfied' or v_new_data.MI_ITEM_STATUS='Removed') then
		   v_end_date:=coalesce(to_date(v_new_data.MI_ITEM_STATUS_DT,BPM_COMMON.DATE_FMT),BPM_COMMON.MAX_DATE);
		   else
		   v_end_date:=BPM_COMMON.MAX_DATE;
		   end if;
		   end if;
       
       v_start_date := to_date(v_new_data.MI_ITEM_CREATE_DT,BPM_COMMON.DATE_FMT);
       BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
 
  select BI_ID 
	into v_bi_id
	from BPM_INSTANCE
	where 
	IDENTIFIER = v_identifier
	and BEM_ID = v_bem_id
        and BSL_ID = v_bsl_id;
   
    
        if v_end_date is not null then
          update BPM_INSTANCE
          set
            END_DATE = v_end_date,
            LAST_UPDATE_DATE = v_stg_last_update_date
          where BI_ID = v_bi_id;
        else
          update BPM_INSTANCE
          set LAST_UPDATE_DATE = v_stg_last_update_date
          where BI_ID = v_bi_id;
        end if;
    
        commit;
        
       
    
        v_bue_id := SEQ_BUE_ID.nextval;
      
        insert into BPM_UPDATE_EVENT
          (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
        values
          (v_bue_id,v_bi_id,v_butl_id,v_stg_last_update_date,'N');
      
      BPM_EVENT.UPDATE_BIA(v_bi_id,228,1,'N',v_old_data.MI_LETTER_ID,v_new_data.MI_LETTER_ID,v_bue_id,v_stg_last_update_date);
      BPM_EVENT.UPDATE_BIA(v_bi_id,229,2,'Y',v_old_data.RFE_STATUS,v_new_data.RFE_STATUS,v_bue_id,v_stg_last_update_date);
      BPM_EVENT.UPDATE_BIA(v_bi_id,230,3,'Y',v_old_data.RFE_STATUS_DT,v_new_data.RFE_STATUS_DT,v_bue_id,v_stg_last_update_date);
      BPM_EVENT.UPDATE_BIA(v_bi_id,231,2,'Y',v_old_data.MI_ITEM_STATUS,v_new_data.MI_ITEM_STATUS,v_bue_id,v_stg_last_update_date);
      BPM_EVENT.UPDATE_BIA(v_bi_id,232,3,'Y',v_old_data.MI_ITEM_STATUS_DT,v_new_data.MI_ITEM_STATUS_DT,v_bue_id,v_stg_last_update_date);
      BPM_EVENT.UPDATE_BIA(v_bi_id,233,2,'Y',v_old_data.MI_ITEM_STATUS_PERFORMER,v_new_data.MI_ITEM_STATUS_PERFORMER,v_bue_id,v_stg_last_update_date);
     -- BPM_EVENT.UPDATE_BIA(v_bi_id,234,2,'N',v_old_data.MI_ITEM_SATISFIED_CHANNEL,v_new_data.MI_ITEM_SATISFIED_CHANNEL,v_bue_id,v_stg_last_update_date);
      BPM_EVENT.UPDATE_BIA(v_bi_id,235,3,'N',v_old_data.MI_LETTER_CYCLE_START_DT,v_new_data.MI_LETTER_CYCLE_START_DT,v_bue_id,v_stg_last_update_date);
      BPM_EVENT.UPDATE_BIA(v_bi_id,236,3,'N',v_old_data.MI_LETTER_CYCLE_END_DT,v_new_data.MI_LETTER_CYCLE_END_DT,v_bue_id,v_stg_last_update_date);
     -- BPM_EVENT.UPDATE_BIA(v_bi_id,238,2,'N',v_old_data.REFER_TO_DISTRICT_IND,v_new_data.REFER_TO_DISTRICT_IND,v_bue_id,v_stg_last_update_date);
     -- BPM_EVENT.UPDATE_BIA(v_bi_id,239,3,'N',v_old_data.REFER_TO_DISTRICT_IND_DT,v_new_data.REFER_TO_DISTRICT_IND_DT,v_bue_id,v_stg_last_update_date);
     -- BPM_EVENT.UPDATE_BIA(v_bi_id,240,2,'N',v_old_data.UNDELIVERABLE_IND,v_new_data.UNDELIVERABLE_IND,v_bue_id,v_stg_last_update_date);
     -- BPM_EVENT.UPDATE_BIA(v_bi_id,241,3,'N',v_old_data.UNDELIVERABLE_IND_DT,v_new_data.UNDELIVERABLE_IND_DT,v_bue_id,v_stg_last_update_date);
      BPM_EVENT.UPDATE_BIA(v_bi_id,242,3,'N',v_old_data.MI_VALIDATED_DT,v_new_data.MI_VALIDATED_DT,v_bue_id,v_stg_last_update_date);
      
      BPM_EVENT.UPDATE_BIA(v_bi_id,420,3,'N',v_old_data.HEART_MI_DUE_DT,v_new_data.HEART_MI_DUE_DT,v_bue_id,v_stg_last_update_date);
      BPM_EVENT.UPDATE_BIA(v_bi_id,421,3,'N',v_old_data.MAXE_MI_DUE_DT,v_new_data.MAXE_MI_DUE_DT,v_bue_id,v_stg_last_update_date);
      BPM_EVENT.UPDATE_BIA(v_bi_id,422,2,'N',v_old_data.MI_TYPE_NAME,v_new_data.MI_TYPE_NAME,v_bue_id,v_stg_last_update_date);
      BPM_EVENT.UPDATE_BIA(v_bi_id,423,2,'N',v_old_data.MI_LETTER_NAME,v_new_data.MI_LETTER_NAME,v_bue_id,v_stg_last_update_date);
      BPM_EVENT.UPDATE_BIA(v_bi_id,424,2,'N',v_old_data.MI_ITEM_SATISFIED_REASON,v_new_data.MI_ITEM_SATISFIED_REASON,v_bue_id,v_stg_last_update_date);
      

          
        commit;
      
        p_bue_id := v_bue_id;
      
      exception
    
        when NO_DATA_FOUND then
          v_sql_code := SQLCODE;
	  v_log_message := 'No BPM_INSTANCE found.  ' || SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);  
          raise;
          
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code); 
          raise;
    
  end;
  
   -- Update BPM Semantic model data.
      procedure UPDATE_BPM_SEMANTIC
        (p_data_version in number,
         p_old_data_xml in xmltype,
         p_new_data_xml in xmltype)
      as
      
        v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';   
        v_sql_code number := null;
        v_log_message clob := null;
        
        v_old_data T_UPD_PAMI_XML := null;
        v_new_data T_UPD_PAMI_XML := null;
      
        v_bi_id number := null;
        v_identifier varchar2(35) := null;
        
        v_start_date date := null;
        v_end_date date := null;
        v_app_complete_date date:=null;
        
        v_dnpamiisp_id number := null;  
	v_dnpamiis_id number := null;
	v_dnpamirs_id number := null;
        v_fnpamibd_id number := null;
        
      
        
        
      begin
     
        if p_data_version != 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Process App MI in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);        
        end if;
        
        GET_UPD_PAMI_XML(p_old_data_xml,v_old_data);
        GET_UPD_PAMI_XML(p_new_data_xml,v_new_data);
      
        v_identifier := v_new_data.MISSING_INFO_ID;
        v_start_date := to_date(v_new_data.MI_ITEM_CREATE_DT,BPM_COMMON.DATE_FMT);
       
       if (v_new_data.MI_ITEM_STATUS='Unsatisfied') then
       	  	   
       	  	   begin

                 with rn as
                   (select nvl(max(REACTIVATION_NBR),0) max_reactivation_number
                    from NYEC_ETL_PROCESS_APP
                    where APP_ID = v_new_data.app_id)
                 select COMPLETE_DT
                 into v_app_complete_date
                 from 
                   NYEC_ETL_PROCESS_APP,
                   rn
                 where 
                   APP_ID = v_new_data.app_id
                   and REACTIVATION_NBR = rn.max_reactivation_number;
       	  	     
       	  	     exception
                 
       	  	       when NO_DATA_FOUND then
       	  	         null;
                     
       	  	   end;
       	  	   
       	  	   v_end_date:=coalesce(v_app_complete_date,BPM_COMMON.MAX_DATE);
       	  	   else if (v_new_data.MI_ITEM_STATUS='Satisfied' or v_new_data.MI_ITEM_STATUS='Removed') then
       	  	   v_end_date:=coalesce(to_date(v_new_data.MI_ITEM_STATUS_DT,BPM_COMMON.DATE_FMT),BPM_COMMON.MAX_DATE);
       	  	   else
       	  	   v_end_date:=BPM_COMMON.MAX_DATE;
       	  	   end if;
	   end if;
       
     BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
      
     select NYEC_PAMI_BI_ID 
     into v_bi_id
     from D_NYEC_PAMI_CURRENT
     where "MI Item ID" = v_identifier;
    
         GET_DNPAMIISP_ID(v_identifier,v_bi_id,v_new_data.MI_ITEM_STATUS_PERFORMER,v_dnpamiisp_id );
	       GET_DNPAMIIS_ID(v_identifier,v_bi_id,v_new_data.MI_ITEM_STATUS,v_dnpamiis_id);	  
         GET_DNPAMIRS_ID(v_identifier,v_bi_id,v_new_data.RFE_STATUS,v_dnpamirs_id);
        
        -- Update current dimension and fact as a single transaction.
            begin
               
        commit;
           
      
       SET_DPAMICUR
       ('UPDATE',v_identifier,v_bi_id,v_new_data.MISSING_INFO_ID ,v_new_data.APP_ID ,v_new_data.MI_ITEM_LEVEL ,v_new_data.MI_ITEM_TYPE,v_new_data.MI_ITEM_CREATE_DT,v_new_data.MI_ITEM_REQUESTED_BY,v_new_data.MI_LETTER_REQUIRED_STATUS  ,v_new_data.MI_LETTER_ID , 
         v_new_data.RFE_STATUS ,v_new_data.RFE_STATUS_DT,v_new_data.MI_ITEM_STATUS, v_new_data.MI_ITEM_STATUS_DT ,v_new_data.MI_ITEM_STATUS_PERFORMER,v_new_data.MI_LETTER_CYCLE_START_DT ,
         v_new_data.MI_LETTER_CYCLE_END_DT,v_new_data.MI_ITEM_CREATE_TASK_TYPE ,/*v_new_data.REFER_TO_DISTRICT_IND,v_new_data.REFER_TO_DISTRICT_IND_DT,v_new_data.UNDELIVERABLE_IND, v_new_data.UNDELIVERABLE_IND_DT ,*/
         v_new_data.MI_VALIDATED_DT ,v_new_data.HEART_MI_DUE_DT ,v_new_data.MAXE_MI_DUE_DT ,v_new_data.MI_TYPE_NAME , v_new_data.MI_LETTER_NAME , v_new_data.MI_ITEM_SATISFIED_REASON );
            
           
       UPD_FPAMIBD
       (v_identifier ,v_start_date ,v_end_date ,v_bi_id ,v_dnpamirs_id ,v_dnpamiis_id ,v_dnpamiisp_id ,v_new_data.MI_ITEM_STATUS_DT ,
        v_new_data.RFE_STATUS_DT ,v_new_data.STG_LAST_UPDATE_DATE ,v_fnpamibd_id) ;
        
        
              commit;
              
            exception
            
              when OTHERS then
                rollback;
                v_sql_code := SQLCODE;
                v_log_message := 'Rolled back initial insert for current dimension and fact.  ' || SQLERRM;
                BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code); 
                raise;
        
      end;
        
      exception
    
        when NO_DATA_FOUND then
          v_sql_code := SQLCODE;
          v_log_message := 'No BPM_INSTANCE found.  ' || SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code); 
         raise; 
          
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code); 
          raise;
    
      end;
    
    end;
    /
    
alter session set plsql_code_type = interpreted;
  