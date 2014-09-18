alter session set plsql_code_type = native;

create or replace package NYEC_INITIATE_RENEWAL as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  /*
  select '     '|| 'CEMR_ID varchar2(100),' attr_element from dual  
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
    bast.BSL_ID = 6
    and atc.TABLE_NAME = 'NYEC_ETL_MONITOR_RENEWAL'
  order by attr_element asc;
  */
  type T_INS_IR_XML is record 
    (
     AGE_IN_BUSINESS_DAYS varchar2(100),
     APP_ID varchar2(100),
     AUTH_CHG_DT varchar2(19),
     AUTH_END_DT varchar2(19),
     CANCEL_DT varchar2(19),
     CEMR_ID varchar2(100),
     CLOCKDOWN_INDICATOR varchar2(1),
     CLOSE_DT varchar2(19),
     GWF_FILE_PROC_RES varchar2(1),
     GWF_EXCEPT_RES varchar2(1),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(20),
     NOTICE_1_COMPLETE_DT varchar2(19),
     NOTICE_1_CREATE_DT varchar2(19),
     NOTICE_1_DUE_DT varchar2(19),
     NOTICE_1_SOURCE_ID varchar2(100),
     NOTICE_1_TYPE varchar2(20),
     NOTICE_2_COMPLETE_DT varchar2(19),
     NOTICE_2_CREATE_DT varchar2(19),
     NOTICE_2_DUE_DT varchar2(19),
     NOTICE_2_SOURCE_ID varchar2(100),
     NOTICE_2_TYPE varchar2(20),
     NOTICE_3_COMPLETE_DT varchar2(19),
     NOTICE_3_CREATE_DT varchar2(19),
     NOTICE_3_DUE_DT varchar2(19),
     NOTICE_3_SOURCE_ID varchar2(100),
     NOTICE_3_TYPE varchar2(20),
     REN_FILE_RECEIPT_DT varchar2(19),
     REN_RECEIPT_DT varchar2(19),
     SHELL_CREATED_BY varchar2(80),
     SHELL_CREATE_DT varchar2(19),
     STATE_CASE_IDEN varchar2(20),
     STG_LAST_UPDATE_DATE varchar2(19)
     );
     
  /*   
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
      bast.BSL_ID = 6
      and atc.TABLE_NAME = 'NYEC_ETL_MONITOR_RENEWAL'
    order by attr_element asc;
  */
  type T_UPD_IR_XML is record
    (
     AGE_IN_BUSINESS_DAYS varchar2(100),
     APP_ID varchar2(100),
     AUTH_CHG_DT varchar2(19),
     AUTH_END_DT varchar2(19),
     CANCEL_DT varchar2(19),
     CLOCKDOWN_INDICATOR varchar2(1),
     CLOSE_DT varchar2(19),
     GWF_FILE_PROC_RES varchar2(1),
     GWF_EXCEPT_RES varchar2(1),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(20),
     NOTICE_1_COMPLETE_DT varchar2(19),
     NOTICE_1_CREATE_DT varchar2(19),
     NOTICE_1_DUE_DT varchar2(19),
     NOTICE_1_SOURCE_ID varchar2(100),
     NOTICE_1_TYPE varchar2(20),
     NOTICE_2_COMPLETE_DT varchar2(19),
     NOTICE_2_CREATE_DT varchar2(19),
     NOTICE_2_DUE_DT varchar2(19),
     NOTICE_2_SOURCE_ID varchar2(100),
     NOTICE_2_TYPE varchar2(20),
     NOTICE_3_COMPLETE_DT varchar2(19),
     NOTICE_3_CREATE_DT varchar2(19),
     NOTICE_3_DUE_DT varchar2(19),
     NOTICE_3_SOURCE_ID varchar2(100),
     NOTICE_3_TYPE varchar2(20),
     REN_FILE_RECEIPT_DT varchar2(19),
     REN_RECEIPT_DT varchar2(19),
     SHELL_CREATED_BY varchar2(80),
     SHELL_CREATE_DT varchar2(19),
     STATE_CASE_IDEN varchar2(20),
     STG_LAST_UPDATE_DATE varchar2(19)
     );
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


create or replace package body NYEC_INITIATE_RENEWAL as

  v_bem_id number := 6; -- 'NYEC OPS Initiate Renewal'
  v_bil_id number := 2; -- 'Application ID'
  v_bsl_id number := 6; -- 'NYEC_ETL_MONITOR_RENEWAL'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';

 -- Get dimension ID for BPM Semantic model - Initiate Renewal process - clockdown Indicator     
procedure GET_DNIRCI_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_clockdown_indicator in varchar2,
      p_dnirci_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNIRCI_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DNIRCI_ID into p_dnirci_id
     from D_NYEC_IR_CLOCKDOWN_IND
     where 
       ("Clockdown Indicator" = p_clockdown_indicator or ("Clockdown Indicator" is null and p_clockdown_indicator is null));
      
   exception
     when NO_DATA_FOUND then
       p_dnirci_id := SEQ_DNIRCI_ID.nextval;
       begin
         insert into D_NYEC_IR_CLOCKDOWN_IND (DNIRCI_ID,"Clockdown Indicator")
         values (p_dnirci_id,p_clockdown_indicator);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DNIRCI_ID into p_dnirci_id
           from D_NYEC_IR_CLOCKDOWN_IND
           where 
             ("Clockdown Indicator" = p_clockdown_indicator or ("Clockdown Indicator" is null and p_clockdown_indicator is null));
             
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
  
  -- Get record for Initiate Renewal insert XML.
  procedure GET_INS_IR_XML
      (p_data_xml in xmltype,
       p_data_record out T_INS_IR_XML)
    as
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_IR_XML';
      v_sql_code number := null;
      v_log_message clob := null;
    begin
 /*     select  '        extractValue(p_data_xml,''/ROWSET/ROW/CEPA_ID'') "' || 'CEMR_ID'|| '",' attr_element from dual
        union 
        select  '        extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
        union 
        select 
        '        extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
        from BPM_ATTRIBUTE_STAGING_TABLE bast
        inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
        where 
        bast.BSL_ID = 6
        and atc.TABLE_NAME = 'NYEC_ETL_MONITOR_RENEWAL'
        order by attr_element asc;
 */
 
         select
         extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_BUSINESS_DAYS') "AGE_IN_BUSINESS_DAYS",
         extractValue(p_data_xml,'/ROWSET/ROW/APP_ID') "APP_ID",
         extractValue(p_data_xml,'/ROWSET/ROW/AUTH_CHG_DT') "AUTH_CHG_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/AUTH_END_DT') "AUTH_END_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/CEPA_ID') "CEMR_ID",
         extractValue(p_data_xml,'/ROWSET/ROW/CLOCKDOWN_INDICATOR') "CLOCKDOWN_INDICATOR",
         extractValue(p_data_xml,'/ROWSET/ROW/CLOSE_DT') "CLOSE_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/GWF_FILE_PROC_RES') "GWF_FILE_PROC_RES",
         extractValue(p_data_xml,'/ROWSET/ROW/GWF_EXCEPT_RES') "GWF_EXCEPT_RES",
         extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
         extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_1_COMPLETE_DT') "NOTICE_1_COMPLETE_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_1_CREATE_DT') "NOTICE_1_CREATE_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_1_DUE_DT') "NOTICE_1_DUE_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_1_SOURCE_ID') "NOTICE_1_SOURCE_ID",
         extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_1_TYPE') "NOTICE_1_TYPE",
         extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_2_COMPLETE_DT') "NOTICE_2_COMPLETE_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_2_CREATE_DT') "NOTICE_2_CREATE_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_2_DUE_DT') "NOTICE_2_DUE_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_2_SOURCE_ID') "NOTICE_2_SOURCE_ID",
         extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_2_TYPE') "NOTICE_2_TYPE",
         extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_3_COMPLETE_DT') "NOTICE_3_COMPLETE_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_3_CREATE_DT') "NOTICE_3_CREATE_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_3_DUE_DT') "NOTICE_3_DUE_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_3_SOURCE_ID') "NOTICE_3_SOURCE_ID",
         extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_3_TYPE') "NOTICE_3_TYPE",
         extractValue(p_data_xml,'/ROWSET/ROW/REN_FILE_RECEIPT_DT') "REN_FILE_RECEIPT_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/REN_RECEIPT_DT') "REN_RECEIPT_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/SHELL_CREATED_BY') "SHELL_CREATED_BY",
         extractValue(p_data_xml,'/ROWSET/ROW/SHELL_CREATE_DT') "SHELL_CREATE_DT",
         extractValue(p_data_xml,'/ROWSET/ROW/STATE_CASE_IDEN') "STATE_CASE_IDEN",
         extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE"
         into p_data_record
	       from dual;
	   
	     exception
	   
	       when OTHERS then
	         v_sql_code := SQLCODE;
	         v_log_message := SQLERRM;
	         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
	        raise; 
	       
    end;
    
  -- Get record for Process App update XML. 
  procedure GET_UPD_IR_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_IR_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_IR_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin 
  
/*    select  '        extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
      union 
      select 
      '        extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
      from BPM_ATTRIBUTE_STAGING_TABLE bast
      inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
      where 
      bast.BSL_ID = 6
      and atc.TABLE_NAME = 'NYEC_ETL_MONITOR_RENEWAL'
      order by attr_element asc;
*/  
        select
        extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_BUSINESS_DAYS') "AGE_IN_BUSINESS_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/APP_ID') "APP_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/AUTH_CHG_DT') "AUTH_CHG_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/AUTH_END_DT') "AUTH_END_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/CLOCKDOWN_INDICATOR') "CLOCKDOWN_INDICATOR",
        extractValue(p_data_xml,'/ROWSET/ROW/CLOSE_DT') "CLOSE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_FILE_PROC_RES') "GWF_FILE_PROC_RES",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_EXCEPT_RES') "GWF_EXCEPT_RES",
        extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_1_COMPLETE_DT') "NOTICE_1_COMPLETE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_1_CREATE_DT') "NOTICE_1_CREATE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_1_DUE_DT') "NOTICE_1_DUE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_1_SOURCE_ID') "NOTICE_1_SOURCE_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_1_TYPE') "NOTICE_1_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_2_COMPLETE_DT') "NOTICE_2_COMPLETE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_2_CREATE_DT') "NOTICE_2_CREATE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_2_DUE_DT') "NOTICE_2_DUE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_2_SOURCE_ID') "NOTICE_2_SOURCE_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_2_TYPE') "NOTICE_2_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_3_COMPLETE_DT') "NOTICE_3_COMPLETE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_3_CREATE_DT') "NOTICE_3_CREATE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_3_DUE_DT') "NOTICE_3_DUE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_3_SOURCE_ID') "NOTICE_3_SOURCE_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/NOTICE_3_TYPE') "NOTICE_3_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/REN_FILE_RECEIPT_DT') "REN_FILE_RECEIPT_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/REN_RECEIPT_DT') "REN_RECEIPT_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/SHELL_CREATED_BY') "SHELL_CREATED_BY",
        extractValue(p_data_xml,'/ROWSET/ROW/SHELL_CREATE_DT') "SHELL_CREATE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/STATE_CASE_IDEN') "STATE_CASE_IDEN",
        extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE"
        into p_data_record
	    from dual;
	
	  exception
	
	    when OTHERS then
	      v_sql_code := SQLCODE;
	      v_log_message := SQLERRM;
	      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
	      raise;
	  
  end;
  
 -- Insert fact for BPM Semantic model - Initiate Renewal process. 
 procedure INS_FIRBD
      (p_identifier in varchar2,
       p_start_date in date,
       p_end_date in date,
       p_bi_id in number,
       p_dnirci_id in number,
       p_authorization_end_date in varchar2,
       p_stg_last_update_date in varchar2,
       p_fnirbd_id out number
       )
  as
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FIRBD';
      v_sql_code number := null;
      v_log_message clob := null;
      v_bucket_start_date date := null;
      v_bucket_end_date date := null;
      v_stg_last_update_date date := null;
      v_authorization_end_date date :=null;
      
      begin
           v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
           v_authorization_end_date:=to_date(p_authorization_end_date,BPM_COMMON.DATE_FMT);
          
           p_fnirbd_id := SEQ_FNIRBD_ID.nextval;
           
           v_bucket_start_date := to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt);
           if p_end_date is null then
           
             v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
           else 
           
             v_bucket_end_date := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
             
      end if;
      
    -- Validate fact date ranges.
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
    
  insert into F_NYEC_IR_BY_DATE
          (FNIRBD_ID,
           D_DATE,
           BUCKET_START_DATE,
           BUCKET_END_DATE,
           NYEC_IR_BI_ID,
           DNIRCI_ID,
           "Authorization End Date",
           CREATION_COUNT,
           INVENTORY_COUNT,
           COMPLETION_COUNT
          )
        values
          (p_fnirbd_id,
           p_start_date,
           v_bucket_start_date,
           v_bucket_end_date,
           p_bi_id,
           p_dnirci_id,
           v_authorization_end_date,
           1,
           case 
           when p_end_date is null then 1
           else 0
           end,
           case 
             when p_end_date is null then 0
             else 1
             end
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
        
        v_new_data T_INS_IR_XML := null;
        
    begin
    if p_data_version != 1 then
            v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Initiate Renewal in procedure ' || v_procedure_name || '.';
            RAISE_APPLICATION_ERROR(-20011,v_log_message);        
          end if;
          
          GET_INS_IR_XML(p_new_data_xml,v_new_data);
      
          v_bi_id := SEQ_BI_ID.nextval;
          v_identifier := v_new_data.APP_ID;
          v_start_date := to_date(v_new_data.REN_FILE_RECEIPT_DT,BPM_COMMON.DATE_FMT);
          v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
          BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
          
       insert into BPM_INSTANCE 
         (BI_ID,BEM_ID,IDENTIFIER,BIL_ID,BSL_ID,
          START_DATE,END_DATE,SOURCE_ID,CREATION_DATE,LAST_UPDATE_DATE)
       values
         (v_bi_id,v_bem_id,v_identifier,v_bil_id,v_bsl_id,
          v_start_date,v_end_date,to_char(v_new_data.CEMR_ID),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT));
   
       commit;
     
       v_bue_id := SEQ_BUE_ID.nextval;
   
       insert into BPM_UPDATE_EVENT
         (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
       values
        (v_bue_id,v_bi_id,v_butl_id,to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),'N');
        
  BPM_EVENT.INSERT_BIA(v_bi_id,298,1,v_new_data.AGE_IN_BUSINESS_DAYS,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,300,3,v_new_data.INSTANCE_COMPLETE_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,301,2,v_new_data.INSTANCE_STATUS,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,302,3,v_new_data.REN_FILE_RECEIPT_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,303,3,v_new_data.SHELL_CREATE_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,304,2,v_new_data.SHELL_CREATED_BY,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,305,1,v_new_data.APP_ID,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,306,3,v_new_data.REN_RECEIPT_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,307,3,v_new_data.AUTH_CHG_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,308,3,v_new_data.AUTH_END_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,309,3,v_new_data.CANCEL_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,310,3,v_new_data.CLOSE_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,311,2,v_new_data.CLOCKDOWN_INDICATOR,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,312,2,v_new_data.STATE_CASE_IDEN,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,313,3,v_new_data.NOTICE_1_DUE_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,314,3,v_new_data.NOTICE_1_CREATE_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,315,3,v_new_data.NOTICE_1_COMPLETE_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,316,2,v_new_data.NOTICE_1_TYPE,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,317,1,v_new_data.NOTICE_1_SOURCE_ID,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,318,3,v_new_data.NOTICE_2_DUE_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,319,3,v_new_data.NOTICE_2_CREATE_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,320,3,v_new_data.NOTICE_2_COMPLETE_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,321,2,v_new_data.NOTICE_2_TYPE,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,322,1,v_new_data.NOTICE_2_SOURCE_ID,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,323,3,v_new_data.NOTICE_3_DUE_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,324,3,v_new_data.NOTICE_3_CREATE_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,325,3,v_new_data.NOTICE_3_COMPLETE_DT,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,326,2,v_new_data.NOTICE_3_TYPE,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,327,1,v_new_data.NOTICE_3_SOURCE_ID,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,442,2,v_new_data.GWF_FILE_PROC_RES,v_start_date,v_bue_id);
	BPM_EVENT.INSERT_BIA(v_bi_id,443,2,v_new_data.GWF_EXCEPT_RES,v_start_date,v_bue_id);
commit;
    
      p_bue_id := v_bue_id;
    
    exception
     
      when OTHERS then
        v_sql_code := SQLCODE;
        v_log_message := SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
 end;
 
 -- Insert or update dimension for BPM Semantic model - Initiate Renewal process - Current.
 
 procedure SET_DNIRCUR
        (p_set_type in varchar2,
 	 p_identifier in varchar2,
	 p_bi_id in number,
	 p_app_id  in varchar2, 
	 p_age_in_business_days  in varchar2,
	 p_instance_complt_dt  in varchar2,
	 p_instance_status  in varchar2,
	 p_renwl_file_recivd_dt  in varchar2,
	 p_shell_app_create_date  in varchar2,
	 p_shell_app_create_source  in varchar2,
	 p_renewal_receipt_date  in varchar2,
	 p_authorization_change_date	  in varchar2, 
	 p_authorization_end_date  in varchar2, 
	 p_cancel_date  in varchar2,
	 p_close_date  in varchar2,
	 p_cur_clockdown_indicator	  in varchar2,
	 p_state_case_identifier	  in varchar2,
	 p_notice_1_type  in varchar2,
	 p_notice_1_due_date  in varchar2,
	 p_notice_1_create_date  in varchar2,
	 p_notice_1_complete_date  in varchar2,
	 p_notice_1_source_id  in varchar2,  
	 p_notice_2_type  in varchar2, 
	 p_notice_2_due_date  in varchar2,
	 p_notice_2_create_date  in varchar2,
	 p_notice_2_complete_date  in varchar2,
	 p_notice_2_source_id  in varchar2,
	 p_notice_3_type  in varchar2,
	 p_notice_3_due_date  in varchar2,
	 p_notice_3_create_date  in varchar2,
	 p_notice_3_complete_date  in varchar2,
	 p_notice_3_source_id  in varchar2,  
	 p_gwf_file_proc_res  in varchar2, 
	 p_gwf_except_res  in varchar2 --,
	 --p_stage_done_date  in varchar2,
	 --p_stg_extract_date  in varchar2,
	 --p_stg_last_update_date  in varchar2,
	 --p_app_status_dt  in varchar2,
	 --p_app_status  in varchar2,
	 --p_app_in_process  in varchar2,
	 --p_stg_last_processed_dt in varchar2,
	 )
    as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DNIRCUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dircur D_NYEC_IR_CURRENT%rowtype := null;
    
    begin
        
      r_dircur."Renewal File Received Date" := to_date(p_renwl_file_recivd_dt,BPM_COMMON.DATE_FMT);
      r_dircur."Instance Complete Date" := to_date(p_instance_complt_dt,BPM_COMMON.DATE_FMT);
      r_dircur.NYEC_IR_BI_ID := p_bi_id;
      r_dircur."APP_ID" := p_app_id; 
      r_dircur."Age in Business Days" := p_age_in_business_days;
      r_dircur."Age in Calendar Days" := trunc(nvl(r_dircur."Instance Complete Date",sysdate)) - trunc(r_dircur."Renewal File Received Date");
      
      r_dircur."Instance Status"               := p_instance_status;
      r_dircur."Shell App Create Date"         := to_date(p_shell_app_create_date,BPM_COMMON.DATE_FMT);
      r_dircur."Shell App Create Source"       := p_shell_app_create_source;
      r_dircur."Renewal_Receipt Date"          := to_date(p_renewal_receipt_date,BPM_COMMON.DATE_FMT);
      r_dircur."Authorization Change Date"     := to_date(p_authorization_change_date,BPM_COMMON.DATE_FMT);
      r_dircur."Authorization End Date"        := to_date(p_authorization_end_date,BPM_COMMON.DATE_FMT); 
      r_dircur."Cancel Date"                   := to_date(p_cancel_date,BPM_COMMON.DATE_FMT);
      r_dircur."Close Date"                    := to_date(p_close_date,BPM_COMMON.DATE_FMT);
      r_dircur."Cur Clockdown Indicator"       := p_cur_clockdown_indicator;
      r_dircur."State Case Identifier"         := p_state_case_identifier;
      r_dircur."Notice 1 Type"                 := p_notice_1_type;
      r_dircur."Notice 1 Due Date"             := to_date(p_notice_1_due_date,BPM_COMMON.DATE_FMT);
      r_dircur."Notice 1 Create Date"          := to_date(p_notice_1_create_date,BPM_COMMON.DATE_FMT);
      r_dircur."Notice 1 Complete Date"        := to_date(p_notice_1_complete_date,BPM_COMMON.DATE_FMT);
      r_dircur."Notice 1 Source ID"            := p_notice_1_source_id;  
      r_dircur."Notice 2 Type"                 := p_notice_2_type; 
      r_dircur."Notice 2 Due Date"             := to_date(p_notice_2_due_date,BPM_COMMON.DATE_FMT);
      r_dircur."Notice 2 Create Date"          := to_date(p_notice_2_create_date,BPM_COMMON.DATE_FMT);
      r_dircur."Notice 2 Complete Date"        := to_date(p_notice_2_complete_date,BPM_COMMON.DATE_FMT);
      r_dircur."Notice 2 Source ID"            := p_notice_2_source_id;
      r_dircur."Notice 3 Type"                 := p_notice_3_type;
      r_dircur."Notice 3 Due Date"             := to_date(p_notice_3_due_date,BPM_COMMON.DATE_FMT);
      r_dircur."Notice 3 Create Date"          := to_date(p_notice_3_create_date,BPM_COMMON.DATE_FMT);
      r_dircur."Notice 3 Complete Date"        := to_date(p_notice_3_complete_date,BPM_COMMON.DATE_FMT);
      r_dircur."Notice 3 Source ID"            := p_notice_3_source_id;  
      r_dircur."File Process Successful Flag"  := p_gwf_file_proc_res; 
      r_dircur."Process Exception Result Flag" := p_gwf_except_res;
      --r_dircur."STAGE_DONE_DATE"         :=	p_stage_done_date;
      --r_dircur."STG_EXTRACT_DATE"        :=	p_stg_extract_date;
      --r_dircur."STG_LAST_UPDATE_DATE"    :=	p_stg_last_update_date;
      --r_dircur."APP_STATUS_DT"           :=	p_app_status_dt;
      --r_dircur."APP_STATUS"              :=	p_app_status;
      --r_dircur."APP_IN_PROCESS"          :=	p_app_in_process;
      --r_dircur."STG_LAST_PROCESSED_DT"   :=	p_stg_last_processed_dt;
      
  if p_set_type = 'INSERT' then
        insert into D_NYEC_IR_CURRENT
        values r_dircur;
       elsif p_set_type = 'UPDATE' then
       begin
         update D_NYEC_IR_CURRENT
         set row = r_dircur
         where NYEC_IR_BI_ID = p_bi_id;
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
       
       v_new_data T_INS_IR_XML := null;
       
       v_bi_id number := null;
       v_identifier varchar2(35) := null;
       
       v_start_date date := null;
       v_end_date date := null;
       
 
       v_dnirci_id number := null;  
       v_fnirbd_id number := null;
       
       begin
         
             if p_data_version != 1 then
               v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Initiate Renewal in procedure ' || v_procedure_name || '.';
               RAISE_APPLICATION_ERROR(-20011,v_log_message);        
             end if;
             
             GET_INS_IR_XML(p_new_data_xml,v_new_data);
             
             v_identifier := v_new_data.APP_ID;
             v_start_date := to_date(v_new_data.REN_FILE_RECEIPT_DT,BPM_COMMON.DATE_FMT);
             v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
             BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
             v_bi_id := SEQ_BI_ID.nextval;             
        
             GET_DNIRCI_ID(v_identifier,v_bi_id,v_new_data.CLOCKDOWN_INDICATOR,v_dnirci_id);
  
            -- Insert current dimension and fact as a single transaction.
            begin
            
        commit;
  SET_DNIRCUR
    ('INSERT',v_identifier,v_bi_id,v_new_data.APP_ID,v_new_data.AGE_IN_BUSINESS_DAYS ,v_new_data.INSTANCE_COMPLETE_DT,v_new_data.INSTANCE_STATUS ,
     v_new_data.REN_FILE_RECEIPT_DT  ,v_new_data.SHELL_CREATE_DT  ,v_new_data.SHELL_CREATED_BY  ,v_new_data.REN_RECEIPT_DT  ,v_new_data.AUTH_CHG_DT,
     v_new_data.AUTH_END_DT   ,v_new_data.CANCEL_DT  ,v_new_data.CLOSE_DT  ,v_new_data.CLOCKDOWN_INDICATOR	,v_new_data.STATE_CASE_IDEN,v_new_data.NOTICE_1_TYPE  ,
     v_new_data.NOTICE_1_DUE_DT  ,v_new_data.NOTICE_1_CREATE_DT  ,v_new_data.NOTICE_1_COMPLETE_DT  ,v_new_data.NOTICE_1_SOURCE_ID    ,v_new_data.NOTICE_2_TYPE   ,
     v_new_data.NOTICE_2_DUE_DT  ,v_new_data.NOTICE_2_CREATE_DT  ,v_new_data.NOTICE_2_COMPLETE_DT  ,v_new_data.NOTICE_2_SOURCE_ID  ,v_new_data.NOTICE_3_TYPE  ,
     v_new_data.NOTICE_3_DUE_DT  ,v_new_data.NOTICE_3_CREATE_DT  ,v_new_data.NOTICE_3_COMPLETE_DT  ,v_new_data.NOTICE_3_SOURCE_ID,
     v_new_data.GWF_FILE_PROC_RES,v_new_data.GWF_EXCEPT_RES);

INS_FIRBD(v_identifier,v_start_date,v_end_date,v_bi_id,v_dnirci_id,v_new_data.AUTH_END_DT,v_new_data.STG_LAST_UPDATE_DATE,v_fnirbd_id);

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
  
 -- Update fact for BPM Semantic model - NYEC Initiate Renewal process. 
 procedure UPD_FIRBD
       (p_identifier in varchar2,
        p_start_date in date,
        p_end_date in date,
        p_bi_id in number,
        p_dnirci_id in number,
        p_authorization_end_date in varchar2,
        p_stg_last_update_date in varchar2,
        p_fnirbd_id out number
       )
as
    
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FIRBD';
      v_sql_code number := null;
      v_log_message clob := null;
      
      v_fnirbd_id_old number := null;
      v_d_date_old date := null;
      v_stg_last_update_date date := null;
      v_authorization_end_date date := null;
      v_creation_count_old number := null;
      v_completion_count_old number := null;
      v_max_d_date date := null;
      v_event_date date := null;
      
      r_fnirbd F_NYEC_IR_BY_DATE%rowtype := null;
      
    begin
    
      v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      v_authorization_end_date := to_date(p_authorization_end_date,BPM_COMMON.DATE_FMT);
      v_event_date := v_stg_last_update_date;
      
      with most_recent_fact_bi_id as
              (select 
                 max(FNIRBD_ID) max_fnirbd_id,
                 max(D_DATE) max_d_date
               from F_NYEC_IR_BY_DATE
               where NYEC_IR_BI_ID = p_bi_id) 
            select 
              fnirbd.FNIRBD_ID,
              fnirbd.D_DATE,
              fnirbd.CREATION_COUNT,
              fnirbd.COMPLETION_COUNT,
            most_recent_fact_bi_id.max_d_date
            into 
              v_fnirbd_id_old,
              v_d_date_old,
              v_creation_count_old,
              v_completion_count_old,
              v_max_d_date
            from 
              F_NYEC_IR_BY_DATE fnirbd,
              most_recent_fact_bi_id 
            where
             fnirbd.FNIRBD_ID = max_fnirbd_id
       and fnirbd.D_DATE = most_recent_fact_bi_id.max_d_date;
       
            
    -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
       
 -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE. 
           if v_stg_last_update_date < v_max_d_date then
             v_stg_last_update_date := v_max_d_date;
    end if;

    if p_end_date is null then
      r_fnirbd.D_DATE := v_event_date;
      r_fnirbd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnirbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnirbd.INVENTORY_COUNT := 1;
      r_fnirbd.COMPLETION_COUNT := 0;
    else
      r_fnirbd.D_DATE := p_end_date;
      r_fnirbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnirbd.BUCKET_END_DATE := r_fnirbd.BUCKET_START_DATE;
      r_fnirbd.INVENTORY_COUNT := 0;
      r_fnirbd.COMPLETION_COUNT := 1;
    end if;
  
      p_fnirbd_id := SEQ_FNIRBD_ID.nextval;
      r_fnirbd.FNIRBD_ID := p_fnirbd_id;
      r_fnirbd.NYEC_IR_BI_ID := p_bi_id;
      r_fnirbd.DNIRCI_ID := p_dnirci_id;
      r_fnirbd."Authorization End Date":=v_authorization_end_date;
      r_fnirbd.CREATION_COUNT := 0; 
      
    -- Validate fact date ranges.
    if r_fnirbd.D_DATE < r_fnirbd.BUCKET_START_DATE
      or to_date(to_char(r_fnirbd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fnirbd.BUCKET_END_DATE
      or r_fnirbd.BUCKET_START_DATE > r_fnirbd.BUCKET_END_DATE
      or r_fnirbd.BUCKET_END_DATE < r_fnirbd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || r_fnirbd.D_DATE || 
        ' BUCKET_START_DATE = ' || to_char(r_fnirbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_fnirbd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
   

      if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fnirbd.BUCKET_START_DATE then
        -- Same bucket time.
        if v_creation_count_old = 1 then
           r_fnirbd.CREATION_COUNT := v_creation_count_old;
        end if;
        update F_NYEC_IR_BY_DATE
        set row = r_fnirbd
        where FNIRBD_ID = v_fnirbd_id_old;
      else
        -- Different bucket time.
        update F_NYEC_IR_BY_DATE
        set BUCKET_END_DATE = r_fnirbd.BUCKET_START_DATE
        where FNIRBD_ID = v_fnirbd_id_old;
        
        insert into F_NYEC_IR_BY_DATE
        values r_fnirbd;
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

    v_old_data T_UPD_IR_XML := null;
    v_new_data T_UPD_IR_XML := null;

  begin
  
if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" with NYEC Initiate Renewal in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if; 

    GET_UPD_IR_XML(p_old_data_xml,v_old_data);
    GET_UPD_IR_XML(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.APP_ID;
    v_start_date := to_date(v_new_data.REN_FILE_RECEIPT_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
    v_stg_last_update_date := to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT);
  
  select BI_ID into v_bi_id
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
      
BPM_EVENT.UPDATE_BIA(v_bi_id,298,1,'N',v_old_data.AGE_IN_BUSINESS_DAYS,v_new_data.AGE_IN_BUSINESS_DAYS,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,300,3,'N',v_old_data.INSTANCE_COMPLETE_DT,v_new_data.INSTANCE_COMPLETE_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,301,2,'N',v_old_data.INSTANCE_STATUS,v_new_data.INSTANCE_STATUS,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,306,3,'N',v_old_data.REN_RECEIPT_DT,v_new_data.REN_RECEIPT_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,307,3,'N',v_old_data.AUTH_CHG_DT,v_new_data.AUTH_CHG_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,308,3,'Y',v_old_data.AUTH_END_DT,v_new_data.AUTH_END_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,309,3,'N',v_old_data.CANCEL_DT,v_new_data.CANCEL_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,310,3,'N',v_old_data.CLOSE_DT,v_new_data.CLOSE_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,311,2,'Y',v_old_data.CLOCKDOWN_INDICATOR,v_new_data.CLOCKDOWN_INDICATOR,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,312,2,'N',v_old_data.STATE_CASE_IDEN,v_new_data.STATE_CASE_IDEN,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,313,3,'N',v_old_data.NOTICE_1_DUE_DT,v_new_data.NOTICE_1_DUE_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,314,3,'N',v_old_data.NOTICE_1_CREATE_DT,v_new_data.NOTICE_1_CREATE_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,315,3,'N',v_old_data.NOTICE_1_COMPLETE_DT,v_new_data.NOTICE_1_COMPLETE_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,316,2,'N',v_old_data.NOTICE_1_TYPE,v_new_data.NOTICE_1_TYPE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,317,1,'N',v_old_data.NOTICE_1_SOURCE_ID,v_new_data.NOTICE_1_SOURCE_ID,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,318,3,'N',v_old_data.NOTICE_2_DUE_DT,v_new_data.NOTICE_2_DUE_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,319,3,'N',v_old_data.NOTICE_2_CREATE_DT,v_new_data.NOTICE_2_CREATE_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,320,3,'N',v_old_data.NOTICE_2_COMPLETE_DT,v_new_data.NOTICE_2_COMPLETE_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,321,2,'N',v_old_data.NOTICE_2_TYPE,v_new_data.NOTICE_2_TYPE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,322,1,'N',v_old_data.NOTICE_2_SOURCE_ID,v_new_data.NOTICE_2_SOURCE_ID,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,323,3,'N',v_old_data.NOTICE_3_DUE_DT,v_new_data.NOTICE_3_DUE_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,324,3,'N',v_old_data.NOTICE_3_CREATE_DT,v_new_data.NOTICE_3_CREATE_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,325,3,'N',v_old_data.NOTICE_3_COMPLETE_DT,v_new_data.NOTICE_3_COMPLETE_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,326,2,'N',v_old_data.NOTICE_3_TYPE,v_new_data.NOTICE_3_TYPE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,327,1,'N',v_old_data.NOTICE_3_SOURCE_ID,v_new_data.NOTICE_3_SOURCE_ID,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,442,2,'N',v_old_data.GWF_FILE_PROC_RES,v_new_data.GWF_FILE_PROC_RES,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,443,2,'N',v_old_data.GWF_EXCEPT_RES,v_new_data.GWF_EXCEPT_RES,v_bue_id,v_stg_last_update_date);

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
      
      v_old_data T_UPD_IR_XML := null;
      v_new_data T_UPD_IR_XML := null;
    
      v_bi_id number := null;
      v_identifier varchar2(35) := null;
      
      v_start_date date := null;
      v_end_date date := null;
      
      V_dnirci_id number := null;
      
      
      v_fnirbd_id number := null;
           
    begin
      if p_data_version != 1 then
        v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Initiate Renewal in procedure ' || v_procedure_name || '.';
        RAISE_APPLICATION_ERROR(-20011,v_log_message);        
      end if;
      
      GET_UPD_IR_XML(p_old_data_xml,v_old_data);
      GET_UPD_IR_XML(p_new_data_xml,v_new_data);
    
      v_identifier := v_new_data.APP_ID;
      v_start_date := to_date(v_new_data.REN_FILE_RECEIPT_DT,BPM_COMMON.DATE_FMT);
      v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
      BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

      select NYEC_IR_BI_ID 
      into v_bi_id
      from D_NYEC_IR_CURRENT
      where APP_ID = v_identifier;

      GET_DNIRCI_ID(v_identifier,v_bi_id,v_new_data.CLOCKDOWN_INDICATOR,v_dnirci_id);
 
    -- Update current dimension and fact as a single transaction.
    begin
              
      commit;
      
  SET_DNIRCUR
   ('UPDATE',v_identifier,v_bi_id,v_new_data.APP_ID,v_new_data.AGE_IN_BUSINESS_DAYS ,v_new_data.INSTANCE_COMPLETE_DT,v_new_data.INSTANCE_STATUS ,
    v_new_data.REN_FILE_RECEIPT_DT  ,v_new_data.SHELL_CREATE_DT  ,v_new_data.SHELL_CREATED_BY  ,v_new_data.REN_RECEIPT_DT  ,v_new_data.AUTH_CHG_DT,
    v_new_data.AUTH_END_DT   ,v_new_data.CANCEL_DT  ,v_new_data.CLOSE_DT  ,v_new_data.CLOCKDOWN_INDICATOR	,v_new_data.STATE_CASE_IDEN,v_new_data.NOTICE_1_TYPE  ,
    v_new_data.NOTICE_1_DUE_DT  ,v_new_data.NOTICE_1_CREATE_DT  ,v_new_data.NOTICE_1_COMPLETE_DT  ,v_new_data.NOTICE_1_SOURCE_ID    ,v_new_data.NOTICE_2_TYPE   ,
    v_new_data.NOTICE_2_DUE_DT  ,v_new_data.NOTICE_2_CREATE_DT  ,v_new_data.NOTICE_2_COMPLETE_DT  ,v_new_data.NOTICE_2_SOURCE_ID  ,v_new_data.NOTICE_3_TYPE  ,
    v_new_data.NOTICE_3_DUE_DT  ,v_new_data.NOTICE_3_CREATE_DT  ,v_new_data.NOTICE_3_COMPLETE_DT  ,v_new_data.NOTICE_3_SOURCE_ID,
    v_new_data.GWF_FILE_PROC_RES,v_new_data.GWF_EXCEPT_RES);
 
 UPD_FIRBD(v_identifier,v_start_date,v_end_date,v_bi_id,v_dnirci_id,v_new_data.AUTH_END_DT,v_new_data.STG_LAST_UPDATE_DATE,v_fnirbd_id);
 
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