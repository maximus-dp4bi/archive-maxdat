alter session set plsql_code_type = native;

create or replace package NYEC_PROCESS_MI as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  /*
  select '     '|| 'NEPM_ID varchar2(100),' attr_element from dual  
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
  bast.BSL_ID = 5
  and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_MI'
  order by attr_element asc;
  */
  type T_INS_PMI_XML is record
    (AGE_IN_BUSINESS_DAYS varchar2(100),
     ALL_MI_SATISFIED varchar2(1),
     APP_ID varchar2(100),
     ASED_COMPLETE_MI_TASK varchar2(19),
     ASED_CREATE_STATE_ACCEPT varchar2(19),
     ASED_DETERMINE_MI_OUTCOME varchar2(19),
     ASED_PERFORM_QC varchar2(19),
     ASED_PERFORM_RESEARCH varchar2(19),
     ASED_RECEIVE_MI varchar2(19),
     ASED_SEND_MI_LETTER varchar2(19),
     ASF_COMPLETE_MI_TASK varchar2(1),
     ASF_CREATE_STATE_ACCEPT varchar2(1),
     ASF_DETERMINE_MI_OUTCOME varchar2(1),
     ASF_PERFORM_QC varchar2(1),
     ASF_PERFORM_RESEARCH varchar2(1),
     ASF_RECEIVE_MI varchar2(1),
     ASF_SEND_MI_LETTER varchar2(1),
     ASPB_COMPLETE_MI_TASK varchar2(100),
     ASPB_CREATE_STATE_ACCEPT varchar2(100),
     ASPB_DETERMINE_MI_OUTCOME varchar2(100),
     ASPB_PERFORM_QC varchar2(100),
     ASPB_PERFORM_RESEARCH varchar2(100),
     ASPB_RECEIVE_MI varchar2(100),
     ASPB_SEND_MI_LETTER varchar2(100),
     ASSD_COMPLETE_MI_TASK varchar2(19),
     ASSD_CREATE_STATE_ACCEPT varchar2(19),
     ASSD_DETERMINE_MI_OUTCOME varchar2(19),
     ASSD_PERFORM_QC varchar2(19),
     ASSD_PERFORM_RESEARCH varchar2(19),
     ASSD_RECEIVE_MI varchar2(19),
     ASSD_SEND_MI_LETTER varchar2(19),
     CANCEL_DATE varchar2(19),
     CURRENT_TASK_ID varchar2(100),
     GWF_CHANNEL varchar2(1),
     GWF_MANUAL_LETTER varchar2(1),
     GWF_MI_OUTCOME varchar2(1),
     GWF_PHONE_QC_REQ varchar2(1),
     GWF_QC_OUTCOME varchar2(1),
     GWF_QC_REQUIRED varchar2(1),
     GWF_SEND_RESEARCH varchar2(1),
     GWF_UPDATE_STATE varchar2(1),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(50),
     JEOPARDY_FLAG varchar2(1),
     MAN_LETTER_ID varchar2(100),
     MAN_LETTER_SENT_DT varchar2(19),
     MI_CALL_CAMPAIGN varchar2(50),
     MI_CHANNEL varchar2(20),
     MI_CYCLE_BUS_DAYS varchar2(100),
     MI_CYCLE_END_DT varchar2(19),
     MI_CYCLE_START_DT varchar2(19),
     MI_LETTER_REQUEST_ID varchar2(100),
     MI_LETTER_SENT_ON varchar2(19),
     MI_LETTER_STATUS varchar2(50),
     MI_RECEIPT_DT varchar2(19),
     MI_TASK_COMPLETE_DATE varchar2(19),
     MI_TASK_CREATE_DATE varchar2(19),
     MI_TASK_ID varchar2(100),
     MI_TASK_TYPE varchar2(50),
     MI_TYPE varchar2(50),
     NEPM_ID varchar2(100),
     NEW_MI_CREATION_DATE varchar2(19),
     NEW_MI_SATISFIED_DATE varchar2(19),
     PENDING_MI_TYPE varchar2(100),
     QC_TASK_ID varchar2(100),
     RESEARCH_REASON varchar2(50),
     RESEARCH_TASK_ID varchar2(100),
     SLA_DAYS varchar2(100),
     SLA_DAYS_TYPE varchar2(20),
     SLA_JEOPARDY_DAYS varchar2(100),
     SLA_JEOPARDY_DT varchar2(19),
     SLA_TARGET_DAYS varchar2(100),
     STATE_REVIEW_TASK_ID varchar2(100),
     STG_LAST_UPDATE_DATE varchar2(19));
     
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
  bast.BSL_ID = 5
  and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_MI'
  order by attr_element asc;
  */
  type T_UPD_PMI_XML is record
    (AGE_IN_BUSINESS_DAYS varchar2(100),
     ALL_MI_SATISFIED varchar2(1),
     APP_ID varchar2(100),
     ASED_COMPLETE_MI_TASK varchar2(19),
     ASED_CREATE_STATE_ACCEPT varchar2(19),
     ASED_DETERMINE_MI_OUTCOME varchar2(19),
     ASED_PERFORM_QC varchar2(19),
     ASED_PERFORM_RESEARCH varchar2(19),
     ASED_RECEIVE_MI varchar2(19),
     ASED_SEND_MI_LETTER varchar2(19),
     ASF_COMPLETE_MI_TASK varchar2(1),
     ASF_CREATE_STATE_ACCEPT varchar2(1),
     ASF_DETERMINE_MI_OUTCOME varchar2(1),
     ASF_PERFORM_QC varchar2(1),
     ASF_PERFORM_RESEARCH varchar2(1),
     ASF_RECEIVE_MI varchar2(1),
     ASF_SEND_MI_LETTER varchar2(1),
     ASPB_COMPLETE_MI_TASK varchar2(100),
     ASPB_CREATE_STATE_ACCEPT varchar2(100),
     ASPB_DETERMINE_MI_OUTCOME varchar2(100),
     ASPB_PERFORM_QC varchar2(100),
     ASPB_PERFORM_RESEARCH varchar2(100),
     ASPB_RECEIVE_MI varchar2(100),
     ASPB_SEND_MI_LETTER varchar2(100),
     ASSD_COMPLETE_MI_TASK varchar2(19),
     ASSD_CREATE_STATE_ACCEPT varchar2(19),
     ASSD_DETERMINE_MI_OUTCOME varchar2(19),
     ASSD_PERFORM_QC varchar2(19),
     ASSD_PERFORM_RESEARCH varchar2(19),
     ASSD_RECEIVE_MI varchar2(19),
     ASSD_SEND_MI_LETTER varchar2(19),
     CANCEL_DATE varchar2(19),
     CURRENT_TASK_ID varchar2(100),
     GWF_CHANNEL varchar2(1),
     GWF_MANUAL_LETTER varchar2(1),
     GWF_MI_OUTCOME varchar2(1),
     GWF_PHONE_QC_REQ varchar2(1),
     GWF_QC_OUTCOME varchar2(1),
     GWF_QC_REQUIRED varchar2(1),
     GWF_SEND_RESEARCH varchar2(1),
     GWF_UPDATE_STATE varchar2(1),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(50),
     JEOPARDY_FLAG varchar2(1),
     MAN_LETTER_ID varchar2(100),
     MAN_LETTER_SENT_DT varchar2(19),
     MI_CALL_CAMPAIGN varchar2(50),
     MI_CHANNEL varchar2(20),
     MI_CYCLE_BUS_DAYS varchar2(100),
     MI_CYCLE_END_DT varchar2(19),
     MI_CYCLE_START_DT varchar2(19),
     MI_LETTER_REQUEST_ID varchar2(100),
     MI_LETTER_SENT_ON varchar2(19),
     MI_LETTER_STATUS varchar2(50),
     MI_RECEIPT_DT varchar2(19),
     MI_TASK_COMPLETE_DATE varchar2(19),
     MI_TASK_CREATE_DATE varchar2(19),
     MI_TASK_ID varchar2(100),
     MI_TASK_TYPE varchar2(50),
     MI_TYPE varchar2(50),
     NEW_MI_CREATION_DATE varchar2(19),
     NEW_MI_SATISFIED_DATE varchar2(19),
     PENDING_MI_TYPE varchar2(100),
     QC_TASK_ID varchar2(100),
     RESEARCH_REASON varchar2(50),
     RESEARCH_TASK_ID varchar2(100),
     SLA_DAYS varchar2(100),
     SLA_DAYS_TYPE varchar2(20),
     SLA_JEOPARDY_DAYS varchar2(100),
     SLA_JEOPARDY_DT varchar2(19),
     SLA_TARGET_DAYS varchar2(100),
     STATE_REVIEW_TASK_ID varchar2(100),
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


create or replace package body NYEC_PROCESS_MI as

  v_bem_id number := 5; -- 'NYEC OPS Process MI'
  v_bil_id number := 7; -- 'Missing Task ID'
  v_bsl_id number := 5; -- 'NYEC_ETL_PROCESS_MI'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';


  -- Get dimension ID for BPM Semantic model - Process MI- App id
  procedure GET_DNPMIAI_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_application_id in varchar2,
     p_dnpmiai_id out number)
  as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPMIAI_ID';
       v_sql_code number := null;
       v_log_message clob := null;
     begin
       select DNPMIAI_ID into p_dnpmiai_id
       from D_NYEC_PMI_APP_ID
       where "Application ID" = p_application_id or ("Application ID" is null and p_application_id is null);
     exception
       when NO_DATA_FOUND then
         p_dnpmiai_id := SEQ_DNPMIAI_ID.nextval;
         begin
           insert into D_NYEC_PMI_APP_ID (DNPMIAI_ID,"Application ID")
           values (p_dnpmiai_id,p_application_id);
           commit;
         exception
           when DUP_VAL_ON_INDEX then
             select DNPMIAI_ID into p_dnpmiai_id
             from D_NYEC_PMI_APP_ID
             where "Application ID" = p_application_id or ("Application ID" is null and p_application_id is null);
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
   
-- Get dimension ID for BPM Semantic model - Process MI- MI type

procedure GET_DNPMIIMIT_ID
       (p_identifier in varchar2,
        p_bi_id in number,
        p_inbound_MI_type in varchar2,
        p_dnpmiimit_id out number)
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPMIIMIT_IDs';
       v_sql_code number := null;
       v_log_message clob := null;
     begin
       select DNPMIIMIT_ID into p_dnpmiimit_id
       from D_NYEC_PMI_INBOUND_MI_TYPE
       where "Inbound MI Type" = p_inbound_MI_type or ("Inbound MI Type" is null and p_inbound_MI_type is null);
     exception
       when NO_DATA_FOUND then
         p_dnpmiimit_id := SEQ_DNPMIIMIT_ID.nextval;
         begin
           insert into D_NYEC_PMI_INBOUND_MI_TYPE (DNPMIIMIT_ID,"Inbound MI Type")
           values (p_dnpmiimit_id,p_inbound_MI_type);
           commit;
         exception
           when DUP_VAL_ON_INDEX then
             select DNPMIIMIT_ID into p_dnpmiimit_id
             from D_NYEC_PMI_INBOUND_MI_TYPE
             where "Inbound MI Type" = p_inbound_MI_type or ("Inbound MI Type" is null and p_inbound_MI_type is null);
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
  
-- Get dimension ID for BPM Semantic model - Process MI- Letter Status

procedure GET_DNPMILS_ID
       (p_identifier in varchar2,
        p_bi_id in number,
        p_MI_letter_status in varchar2,
        p_dnpmils_id out number)
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPMILS_ID';
       v_sql_code number := null;
       v_log_message clob := null;
     begin
       select DNPMILS_ID into p_dnpmils_id
       from D_NYEC_PMI_LETTER_STATUS
       where "MI Letter Status" = p_MI_letter_status or ("MI Letter Status" is null and p_MI_letter_status is null);
     exception
       when NO_DATA_FOUND then
         p_dnpmils_id := SEQ_DNPMILS_ID.nextval;
         begin
           insert into D_NYEC_PMI_LETTER_STATUS (DNPMILS_ID,"MI Letter Status")
           values (p_dnpmils_id,p_MI_letter_status);
           commit;
         exception
           when DUP_VAL_ON_INDEX then
             select DNPMILS_ID into p_dnpmils_id
             from D_NYEC_PMI_LETTER_STATUS
             where "MI Letter Status" = p_MI_letter_status or ("MI Letter Status" is null and p_MI_letter_status is null);
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
  
-- Get dimension ID for BPM Semantic model - Process MI- Pending MI type

procedure GET_DNPMIPMIT_ID
       (p_identifier in varchar2,
        p_bi_id in number,
        p_pending_MI_type in varchar2,
        p_dnpmipmit_id out number)
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPMIPMIT_ID';
       v_sql_code number := null;
       v_log_message clob := null;
     begin
       select DNPMIPMIT_ID into p_dnpmipmit_id
       from D_NYEC_PMI_PENDING_MI_TYPE
       where "Pending MI Type" = p_pending_MI_type or ("Pending MI Type" is null and p_pending_MI_type is null);
     exception
       when NO_DATA_FOUND then
         p_dnpmipmit_id := SEQ_DNPMIPMIT_ID.nextval;
         begin
           insert into D_NYEC_PMI_PENDING_MI_TYPE (DNPMIPMIT_ID,"Pending MI Type")
           values (p_dnpmipmit_id,p_pending_MI_type);
           commit;
         exception
           when DUP_VAL_ON_INDEX then
             select DNPMIPMIT_ID into p_dnpmipmit_id
             from D_NYEC_PMI_PENDING_MI_TYPE
             where "Pending MI Type" = p_pending_MI_type or ("Pending MI Type" is null and p_pending_MI_type is null);
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
  
-- Get dimension ID for BPM Semantic model - Process MI- Task id

procedure GET_DNPMIQTI_ID
       (p_identifier in varchar2,
        p_bi_id in number,
        p_QC_task_id in varchar2,
        p_dnpmiqti_id out number)
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPMIQTI_ID';
       v_sql_code number := null;
       v_log_message clob := null;
     begin
       select DNPMIQTI_ID into p_dnpmiqti_id
       from D_NYEC_PMI_QC_TASK_ID
       where "QC Task ID" = p_QC_task_id or ("QC Task ID" is null and p_QC_task_id is null);
     exception
       when NO_DATA_FOUND then
         p_dnpmiqti_id := SEQ_DNPMIQTI_ID.nextval;
         begin
           insert into D_NYEC_PMI_QC_TASK_ID (DNPMIQTI_ID,"QC Task ID")
           values (p_dnpmiqti_id,p_QC_task_id);
           commit;
         exception
           when DUP_VAL_ON_INDEX then
             select DNPMIQTI_ID into p_dnpmiqti_id
             from D_NYEC_PMI_QC_TASK_ID
             where "QC Task ID" = p_dnpmiqti_id or ("QC Task ID" is null and p_dnpmiqti_id is null);
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
  
-- Get dimension ID for BPM Semantic model - Process MI- Research reason

procedure GET_DNPMIRR_ID
       (p_identifier in varchar2,
        p_bi_id in number,
        p_research_reason in varchar2,
        p_dnpmirr_id out number)
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPMIRR_ID';
       v_sql_code number := null;
       v_log_message clob := null;
     begin
       select DNPMIRR_ID into p_dnpmirr_id
       from D_NYEC_PMI_RESEARCH_REASON
       where "Research Reason" = p_research_reason or ("Research Reason" is null and p_research_reason is null);
     exception
       when NO_DATA_FOUND then
         p_dnpmirr_id := SEQ_DNPMIRR_ID.nextval;
         begin
           insert into D_NYEC_PMI_RESEARCH_REASON (DNPMIRR_ID,"Research Reason")
           values (p_dnpmirr_id,p_research_reason);
           commit;
         exception
           when DUP_VAL_ON_INDEX then
             select DNPMIRR_ID into p_dnpmirr_id
             from D_NYEC_PMI_RESEARCH_REASON
             where "Research Reason" = p_research_reason or ("Research Reason" is null and p_research_reason is null);
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

-- Get dimension ID for BPM Semantic model - Process MI- Research task id 

procedure GET_DNPMIRTI_ID
       (p_identifier in varchar2,
        p_bi_id in number,
        p_research_task_id in varchar2,
        p_dnpmirti_id out number)
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPMIRTI_ID';
       v_sql_code number := null;
       v_log_message clob := null;
     begin
       select DNPMIRTI_ID into p_dnpmirti_id
       from D_NYEC_PMI_RESEARCH_TASK_ID
       where "Research Task ID" = p_research_task_id or ("Research Task ID" is null and p_research_task_id is null);
     exception
       when NO_DATA_FOUND then
         p_dnpmirti_id := SEQ_DNPMIRTI_ID.nextval;
         begin
           insert into D_NYEC_PMI_RESEARCH_TASK_ID (DNPMIRTI_ID,"Research Task ID")
           values (p_dnpmirti_id,p_research_task_id);
           commit;
         exception
           when DUP_VAL_ON_INDEX then
             select DNPMIRTI_ID into p_dnpmirti_id
             from D_NYEC_PMI_RESEARCH_TASK_ID
             where "Research Task ID" = p_research_task_id or ("Research Task ID" is null and p_research_task_id is null);
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
  
-- Get dimension ID for BPM Semantic model - Process MI- Review task id

procedure GET_DNPMISRTI_ID
       (p_identifier in varchar2,
        p_bi_id in number,
        p_state_review_task_id in varchar2,
        p_dnpmisrti_id out number)
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPMISRTI_ID';
       v_sql_code number := null;
       v_log_message clob := null;
     begin
       select DNPMISRTI_ID into p_dnpmisrti_id
       from D_NYEC_PMI_ST_REV_TASK_ID
       where "State Review Task ID" = p_state_review_task_id or ("State Review Task ID" is null and p_state_review_task_id is null);
     exception
       when NO_DATA_FOUND then
         p_dnpmisrti_id := SEQ_DNPMISRTI_ID.nextval;
         begin
           insert into D_NYEC_PMI_ST_REV_TASK_ID (DNPMISRTI_ID,"State Review Task ID")
           values (p_dnpmisrti_id,p_state_review_task_id);
           commit;
         exception
           when DUP_VAL_ON_INDEX then
             select DNPMISRTI_ID into p_dnpmisrti_id
             from D_NYEC_PMI_ST_REV_TASK_ID
             where "State Review Task ID" = p_state_review_task_id or ("State Review Task ID" is null and p_state_review_task_id is null);
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


  -- Get record for Process MI insert XML.
  procedure GET_INS_PMI_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_PMI_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_PMI_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    /*
        select  '      extractValue(p_data_xml,''/ROWSET/ROW/NEPM_ID'') "' || 'NEPM_ID'|| '",' attr_element from dual
        union 
        select  '      extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
        union 
        select 
        '        extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
        from BPM_ATTRIBUTE_STAGING_TABLE bast
        inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
        where 
        bast.BSL_ID = 5
        and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_MI'
        order by attr_element asc;
    */
    select
        extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_BUSINESS_DAYS') "AGE_IN_BUSINESS_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/ALL_MI_SATISFIED') "ALL_MI_SATISFIED",
        extractValue(p_data_xml,'/ROWSET/ROW/APP_ID') "APP_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_COMPLETE_MI_TASK') "ASED_COMPLETE_MI_TASK",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_STATE_ACCEPT') "ASED_CREATE_STATE_ACCEPT",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_DETERMINE_MI_OUTCOME') "ASED_DETERMINE_MI_OUTCOME",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_QC') "ASED_PERFORM_QC",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_RESEARCH') "ASED_PERFORM_RESEARCH",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_RECEIVE_MI') "ASED_RECEIVE_MI",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_SEND_MI_LETTER') "ASED_SEND_MI_LETTER",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_COMPLETE_MI_TASK') "ASF_COMPLETE_MI_TASK",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_STATE_ACCEPT') "ASF_CREATE_STATE_ACCEPT",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_DETERMINE_MI_OUTCOME') "ASF_DETERMINE_MI_OUTCOME",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_QC') "ASF_PERFORM_QC",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_RESEARCH') "ASF_PERFORM_RESEARCH",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECEIVE_MI') "ASF_RECEIVE_MI",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_SEND_MI_LETTER') "ASF_SEND_MI_LETTER",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_COMPLETE_MI_TASK') "ASPB_COMPLETE_MI_TASK",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CREATE_STATE_ACCEPT') "ASPB_CREATE_STATE_ACCEPT",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_DETERMINE_MI_OUTCOME') "ASPB_DETERMINE_MI_OUTCOME",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_QC') "ASPB_PERFORM_QC",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_RESEARCH') "ASPB_PERFORM_RESEARCH",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_RECEIVE_MI') "ASPB_RECEIVE_MI",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_SEND_MI_LETTER') "ASPB_SEND_MI_LETTER",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_COMPLETE_MI_TASK') "ASSD_COMPLETE_MI_TASK",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_STATE_ACCEPT') "ASSD_CREATE_STATE_ACCEPT",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_DETERMINE_MI_OUTCOME') "ASSD_DETERMINE_MI_OUTCOME",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_QC') "ASSD_PERFORM_QC",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_RESEARCH') "ASSD_PERFORM_RESEARCH",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RECEIVE_MI') "ASSD_RECEIVE_MI",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_SEND_MI_LETTER') "ASSD_SEND_MI_LETTER",
        extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DATE') "CANCEL_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_CHANNEL') "GWF_CHANNEL",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_MANUAL_LETTER') "GWF_MANUAL_LETTER",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_MI_OUTCOME') "GWF_MI_OUTCOME",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_PHONE_QC_REQ') "GWF_PHONE_QC_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_QC_OUTCOME') "GWF_QC_OUTCOME",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_QC_REQUIRED') "GWF_QC_REQUIRED",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_SEND_RESEARCH') "GWF_SEND_RESEARCH",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_UPDATE_STATE') "GWF_UPDATE_STATE",
        extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/JEOPARDY_FLAG') "JEOPARDY_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/MAN_LETTER_ID') "MAN_LETTER_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/MAN_LETTER_SENT_DT') "MAN_LETTER_SENT_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_CALL_CAMPAIGN') "MI_CALL_CAMPAIGN",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_CHANNEL') "MI_CHANNEL",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_CYCLE_BUS_DAYS') "MI_CYCLE_BUS_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_CYCLE_END_DT') "MI_CYCLE_END_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_CYCLE_START_DT') "MI_CYCLE_START_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_REQUEST_ID') "MI_LETTER_REQUEST_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_SENT_ON') "MI_LETTER_SENT_ON",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_STATUS') "MI_LETTER_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_RECEIPT_DT') "MI_RECEIPT_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_TASK_COMPLETE_DATE') "MI_TASK_COMPLETE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_TASK_CREATE_DATE') "MI_TASK_CREATE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_TASK_ID') "MI_TASK_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_TASK_TYPE') "MI_TASK_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/MI_TYPE') "MI_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/NEPM_ID') "NEPM_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/NEW_MI_CREATION_DATE') "NEW_MI_CREATION_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/NEW_MI_SATISFIED_DATE') "NEW_MI_SATISFIED_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/PENDING_MI_TYPE') "PENDING_MI_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/QC_TASK_ID') "QC_TASK_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/RESEARCH_REASON') "RESEARCH_REASON",
        extractValue(p_data_xml,'/ROWSET/ROW/RESEARCH_TASK_ID') "RESEARCH_TASK_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS') "SLA_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS_TYPE') "SLA_DAYS_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_JEOPARDY_DAYS') "SLA_JEOPARDY_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_JEOPARDY_DT') "SLA_JEOPARDY_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_TARGET_DAYS') "SLA_TARGET_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/STATE_REVIEW_TASK_ID') "STATE_REVIEW_TASK_ID",
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


  -- Get record for Process MI update XML. 
  procedure GET_UPD_PMI_XML
      (p_data_xml in xmltype,
       p_data_record out T_UPD_PMI_XML)
    as
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_PMI_XML';
      v_sql_code number := null;
      v_log_message clob := null;
  begin 
  
    /*
     select  '      extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
     union 
     select 
     '      extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
     from BPM_ATTRIBUTE_STAGING_TABLE bast
     inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
     where 
     bast.BSL_ID = 5
     and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_MI'
     order by attr_element asc;
    */
    select
      extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_BUSINESS_DAYS') "AGE_IN_BUSINESS_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/ALL_MI_SATISFIED') "ALL_MI_SATISFIED",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_ID') "APP_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_COMPLETE_MI_TASK') "ASED_COMPLETE_MI_TASK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_STATE_ACCEPT') "ASED_CREATE_STATE_ACCEPT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_DETERMINE_MI_OUTCOME') "ASED_DETERMINE_MI_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_QC') "ASED_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_RESEARCH') "ASED_PERFORM_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RECEIVE_MI') "ASED_RECEIVE_MI",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_SEND_MI_LETTER') "ASED_SEND_MI_LETTER",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_COMPLETE_MI_TASK') "ASF_COMPLETE_MI_TASK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_STATE_ACCEPT') "ASF_CREATE_STATE_ACCEPT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_DETERMINE_MI_OUTCOME') "ASF_DETERMINE_MI_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_QC') "ASF_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_RESEARCH') "ASF_PERFORM_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECEIVE_MI') "ASF_RECEIVE_MI",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_SEND_MI_LETTER') "ASF_SEND_MI_LETTER",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_COMPLETE_MI_TASK') "ASPB_COMPLETE_MI_TASK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CREATE_STATE_ACCEPT') "ASPB_CREATE_STATE_ACCEPT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_DETERMINE_MI_OUTCOME') "ASPB_DETERMINE_MI_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_QC') "ASPB_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_RESEARCH') "ASPB_PERFORM_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_RECEIVE_MI') "ASPB_RECEIVE_MI",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_SEND_MI_LETTER') "ASPB_SEND_MI_LETTER",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_COMPLETE_MI_TASK') "ASSD_COMPLETE_MI_TASK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_STATE_ACCEPT') "ASSD_CREATE_STATE_ACCEPT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_DETERMINE_MI_OUTCOME') "ASSD_DETERMINE_MI_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_QC') "ASSD_PERFORM_QC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_RESEARCH') "ASSD_PERFORM_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RECEIVE_MI') "ASSD_RECEIVE_MI",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_SEND_MI_LETTER') "ASSD_SEND_MI_LETTER",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DATE') "CANCEL_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_CHANNEL') "GWF_CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_MANUAL_LETTER') "GWF_MANUAL_LETTER",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_MI_OUTCOME') "GWF_MI_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_PHONE_QC_REQ') "GWF_PHONE_QC_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_QC_OUTCOME') "GWF_QC_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_QC_REQUIRED') "GWF_QC_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_SEND_RESEARCH') "GWF_SEND_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_UPDATE_STATE') "GWF_UPDATE_STATE",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/JEOPARDY_FLAG') "JEOPARDY_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/MAN_LETTER_ID') "MAN_LETTER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/MAN_LETTER_SENT_DT') "MAN_LETTER_SENT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_CALL_CAMPAIGN') "MI_CALL_CAMPAIGN",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_CHANNEL') "MI_CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_CYCLE_BUS_DAYS') "MI_CYCLE_BUS_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_CYCLE_END_DT') "MI_CYCLE_END_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_CYCLE_START_DT') "MI_CYCLE_START_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_REQUEST_ID') "MI_LETTER_REQUEST_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_SENT_ON') "MI_LETTER_SENT_ON",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_LETTER_STATUS') "MI_LETTER_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_RECEIPT_DT') "MI_RECEIPT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_TASK_COMPLETE_DATE') "MI_TASK_COMPLETE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_TASK_CREATE_DATE') "MI_TASK_CREATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_TASK_ID') "MI_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_TASK_TYPE') "MI_TASK_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/MI_TYPE') "MI_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/NEW_MI_CREATION_DATE') "NEW_MI_CREATION_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/NEW_MI_SATISFIED_DATE') "NEW_MI_SATISFIED_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/PENDING_MI_TYPE') "PENDING_MI_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/QC_TASK_ID') "QC_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/RESEARCH_REASON') "RESEARCH_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/RESEARCH_TASK_ID') "RESEARCH_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS') "SLA_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS_TYPE') "SLA_DAYS_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_JEOPARDY_DAYS') "SLA_JEOPARDY_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_JEOPARDY_DT') "SLA_JEOPARDY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_TARGET_DAYS') "SLA_TARGET_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/STATE_REVIEW_TASK_ID') "STATE_REVIEW_TASK_ID",
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
  
-- Insert fact for BPM Semantic model - Process MI process. 

procedure INS_FPMIBD
  (p_identifier in varchar2,       
   p_start_date in date,       
   p_end_date in date,       
   p_bi_id in number,       
   p_dnpmiai_id in number,       
   p_dnpmils_id in number,       
   p_dnpmiimit_id in number,       
   p_dnpmipmit_id in number,       
   p_dnpmiqti_id in number,       
   p_dnpmirr_id in number,       
   p_dnpmirti_id in number,       
   p_dnpmisrti_id in number,       
   p_stg_last_update_date in varchar2,       
   p_fnpmibd_id out number              
   )
   
as
  v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FPMIBD';
  v_sql_code number := null;
  v_log_message clob := null;
  v_bucket_start_date date := null;
  v_bucket_end_date date := null;
  
  v_stg_last_update_date date := null;
  
begin
        v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
        
        p_fnpmibd_id := SEQ_FNPMIBD_ID.nextval; 

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
        
           insert into F_NYEC_PMI_BY_DATE 
	   (FNPMIBD_ID,  
	    D_DATE , 
	    BUCKET_START_DATE , 
	    BUCKET_END_DATE , 
	    NYEC_PMI_BI_ID , 
	    DNPMIAI_ID , 
	    DNPMILS_ID , 
	    DNPMIIMIT_ID , 
	    DNPMIPMIT_ID , 
	    DNPMIQTI_ID , 
	    DNPMIRR_ID , 
	    DNPMIRTI_ID , 
	    DNPMISRTI_ID , 
	    CREATION_COUNT,
	    INVENTORY_COUNT,
	    COMPLETION_COUNT
	   ) 
          values
          (p_fnpmibd_id,
           p_start_date,
           to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt),
           v_bucket_end_date,
           p_bi_id,
           p_dnpmiai_id,
           p_dnpmils_id,
           p_dnpmiimit_id,
           p_dnpmipmit_id,
           p_dnpmiqti_id,
           p_dnpmirr_id,
           p_dnpmirti_id,
           p_dnpmisrti_id,
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
          
          
          
           
           v_new_data T_INS_PMI_XML := null;
           
        begin
        
            if p_data_version != 1 then
            v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Process MI in procedure ' || v_procedure_name || '.';
            RAISE_APPLICATION_ERROR(-20011,v_log_message);        
          end if;
          
          GET_INS_PMI_XML(p_new_data_xml,v_new_data);
      
          v_bi_id := SEQ_BI_ID.nextval;
          v_identifier := v_new_data.MI_TASK_ID;
          v_start_date := to_date(v_new_data.MI_TASK_CREATE_DATE,BPM_COMMON.DATE_FMT);
          v_end_date := to_date(v_new_data.INSTANCE_COMPLETE_DT,BPM_COMMON.DATE_FMT);
          BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);          
         
       insert into BPM_INSTANCE 
                   (BI_ID,BEM_ID,IDENTIFIER,BIL_ID,BSL_ID,
                    START_DATE,END_DATE,SOURCE_ID,CREATION_DATE,LAST_UPDATE_DATE)
                 values
                   (v_bi_id,v_bem_id,v_identifier,v_bil_id,v_bsl_id, 
                    v_start_date,v_end_date,to_char(v_new_data.NEPM_ID),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT));
             
                 commit;
               
                 v_bue_id := SEQ_BUE_ID.nextval;
                 
                
             
                 insert into BPM_UPDATE_EVENT
                   (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
                 values
        (v_bue_id,v_bi_id,v_butl_id,to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),'N');
        
     BPM_EVENT.INSERT_BIA(v_bi_id,243,1,v_new_data.AGE_IN_BUSINESS_DAYS,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,245,1,v_new_data.APP_ID,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,246,3,v_new_data.ASED_COMPLETE_MI_TASK,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,247,3,v_new_data.ASED_CREATE_STATE_ACCEPT,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,248,3,v_new_data.ASED_DETERMINE_MI_OUTCOME,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,249,3,v_new_data.ASED_PERFORM_QC,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,250,3,v_new_data.ASED_PERFORM_RESEARCH,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,251,3,v_new_data.ASED_RECEIVE_MI,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,252,3,v_new_data.ASED_SEND_MI_LETTER,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,253,2,v_new_data.ASPB_COMPLETE_MI_TASK,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,254,2,v_new_data.ASPB_CREATE_STATE_ACCEPT,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,255,2,v_new_data.ASPB_DETERMINE_MI_OUTCOME,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,256,2,v_new_data.ASPB_PERFORM_QC,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,257,2,v_new_data.ASPB_PERFORM_RESEARCH,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,258,2,v_new_data.ASPB_RECEIVE_MI,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,259,2,v_new_data.ASPB_SEND_MI_LETTER,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,260,3,v_new_data.ASSD_COMPLETE_MI_TASK,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,261,3,v_new_data.ASSD_CREATE_STATE_ACCEPT,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,262,3,v_new_data.ASSD_DETERMINE_MI_OUTCOME,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,263,3,v_new_data.ASSD_PERFORM_QC,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,264,3,v_new_data.ASSD_PERFORM_RESEARCH,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,265,3,v_new_data.ASSD_RECEIVE_MI,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,266,3,v_new_data.ASSD_SEND_MI_LETTER,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,267,3,v_new_data.CANCEL_DATE,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,268,1,v_new_data.CURRENT_TASK_ID,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,269,3,v_new_data.INSTANCE_COMPLETE_DT,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,270,2,v_new_data.INSTANCE_STATUS,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,271,2,v_new_data.JEOPARDY_FLAG,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,272,1,v_new_data.MAN_LETTER_ID,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,273,3,v_new_data.MAN_LETTER_SENT_DT,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,274,2,v_new_data.MI_CALL_CAMPAIGN,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,275,2,v_new_data.MI_CHANNEL,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,276,1,v_new_data.MI_CYCLE_BUS_DAYS,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,277,3,v_new_data.MI_CYCLE_END_DT,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,278,3,v_new_data.MI_CYCLE_START_DT,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,279,1,v_new_data.MI_LETTER_REQUEST_ID,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,280,2,v_new_data.MI_LETTER_STATUS,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,281,3,v_new_data.MI_RECEIPT_DT,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,282,3,v_new_data.MI_TASK_COMPLETE_DATE,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,283,3,v_new_data.MI_TASK_CREATE_DATE,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,284,1,v_new_data.MI_TASK_ID,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,285,2,v_new_data.MI_TASK_TYPE,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,286,2,v_new_data.MI_TYPE,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,287,2,v_new_data.PENDING_MI_TYPE,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,288,1,v_new_data.QC_TASK_ID,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,289,2,v_new_data.RESEARCH_REASON,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,290,1,v_new_data.RESEARCH_TASK_ID,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,291,1,v_new_data.SLA_DAYS,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,292,2,v_new_data.SLA_DAYS_TYPE,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,293,1,v_new_data.SLA_JEOPARDY_DAYS,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,294,3,v_new_data.SLA_JEOPARDY_DT,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,295,1,v_new_data.SLA_TARGET_DAYS,v_start_date,v_bue_id); 
     BPM_EVENT.INSERT_BIA(v_bi_id,296,1,v_new_data.STATE_REVIEW_TASK_ID,v_start_date,v_bue_id);
     
     BPM_EVENT.INSERT_BIA(v_bi_id,444,2,v_new_data.GWF_CHANNEL,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,445,2,v_new_data.GWF_PHONE_QC_REQ,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,446,2,v_new_data.GWF_UPDATE_STATE,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,447,2,v_new_data.GWF_MANUAL_LETTER,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,448,2,v_new_data.GWF_SEND_RESEARCH,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,449,2,v_new_data.GWF_QC_REQUIRED,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,450,2,v_new_data.GWF_QC_OUTCOME,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,451,2,v_new_data.GWF_MI_OUTCOME,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,452,2,v_new_data.ASF_RECEIVE_MI,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,453,2,v_new_data.ASF_CREATE_STATE_ACCEPT,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,454,2,v_new_data.ASF_DETERMINE_MI_OUTCOME,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,455,2,v_new_data.ASF_COMPLETE_MI_TASK,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,456,2,v_new_data.ASF_PERFORM_QC,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,457,2,v_new_data.ASF_PERFORM_RESEARCH,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,458,2,v_new_data.ASF_SEND_MI_LETTER,v_start_date,v_bue_id);
     
     BPM_EVENT.INSERT_BIA(v_bi_id,477,2,v_new_data.ALL_MI_SATISFIED,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,478,3,v_new_data.NEW_MI_CREATION_DATE,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,479,3,v_new_data.NEW_MI_SATISFIED_DATE,v_start_date,v_bue_id);
     BPM_EVENT.INSERT_BIA(v_bi_id,480,3,v_new_data.MI_LETTER_SENT_ON,v_start_date,v_bue_id);
     
    commit;
        
          p_bue_id := v_bue_id;
        
        exception
         
          when OTHERS then
            v_sql_code := SQLCODE;
            v_log_message := SQLERRM;
            BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code); 
        
      end;
  
-- Insert or update dimension for BPM Semantic model - Process MI process - Current.
         
procedure SET_DPMICUR
(p_set_type                      in    varchar2,
 p_identifier                    in    varchar2,
 p_bi_id                         in    number,
 p_age_in_business_days          in    number, 
 p_cur_application_id            in    number, 
 p_cancel_date                   in    varchar2,
 p_cmplte_mi_tsk_end_dt          in    varchar2,
 p_cmplte_mi_tsk_prfrmd_by       in    varchar2,
 p_cmplte_mi_tsk_strt_dt         in    varchar2,
 p_crt_st_acpt_tsk_end_dt        in    varchar2,
 p_crt_st_acpt_tsk_perf_by       in    varchar2,
 p_crt_st_acpt_tsk_strt_dt       in    varchar2,
 p_current_task_id               in    number,
 p_detrmne_mi_outcm_end_dt       in    varchar2,
 p_detrmne_mi_outcm_perf_by      in    varchar2,
 p_detrmne_mi_outcm_strt_dt      in    varchar2,
 p_cur_inbound_mi_type           in    varchar2,
 p_instance_complt_dt            in    varchar2,
 p_instance_status               in    varchar2,
 p_jeopardy_flag                 in    varchar2,
 p_mi_receipt_date               in    varchar2,
 p_mi_channel                    in    varchar2,
 p_mi_task_type                  in    varchar2,
 p_mi_task_id                    in    number,
 p_mi_task_create_date           in    varchar2,
 p_mi_task_complete_date         in    varchar2,
 p_mi_cycle_business_days        in    number,
 p_mi_cycle_end_date             in    varchar2,
 p_mi_cycle_start_date           in    varchar2,
 p_mi_call_campaign              in    varchar2,
 p_mi_letter_request_id          in    number,
 p_cur_mi_letter_status          in    varchar2,
 p_manual_letter_id              in    number,
 p_manual_letter_sent_date       in    varchar2,
 p_cur_pending_mi_type           in    varchar2,
 p_perfrm_qc_end_date            in    varchar2,
 p_perfrm_qc_perfrmd_by          in    varchar2,
 p_perfrm_qc_start_date          in    varchar2,
 p_perfrm_resrch_end_dt          in    varchar2,
 p_perfrm_resrch_perfrmd_by      in    varchar2,
 p_perfrm_resrch_strt_dt         in    varchar2,
 p_cur_qc_task_id                in    number,
 p_receive_mi_end_date           in    varchar2,
 p_receive_mi_perfrmd_by         in    varchar2,
 p_receive_mi_start_date         in    varchar2,
 p_request_mi_end_date           in    varchar2,
 p_request_mi_perfrmd_by         in    varchar2,
 p_request_mi_start_date         in    varchar2,
 p_cur_research_reason           in    varchar2,
 p_cur_research_task_id          in    number,
 p_sla_days                      in    number,
 p_sla_days_type                 in    varchar2,
 p_sla_jeopardy_date             in    varchar2,
 p_sla_jeopardy_days             in    number,
 p_sla_target_days               in    number,
 p_cur_state_revw_tsk_id         in    number,
 p_channel_flag                  in    varchar2,
 p_qc_required_phone_flag        in    varchar2,
 p_update_state_system_flag      in    varchar2,
 p_manual_letter_flag            in    varchar2,
 p_send_research_flag            in    varchar2,
 p_qc_required_flag              in    varchar2,
 p_qc_outcome_flag               in    varchar2,
 p_mi_outcome_flag               in    varchar2,
 p_receive_mi_flag               in    varchar2,
 p_create_state_accept_flag      in    varchar2,
 p_determine_mi_outcome_flag     in    varchar2,
 p_complete_mi_task_flag         in    varchar2,
 p_perform_qc_on_mi_flag         in    varchar2,
 p_perform_research_flag         in    varchar2,
 p_send_mi_letter_flag           in    varchar2,
 p_all_mi_satisfied              in    varchar2,
 p_new_mi_creation_date          in    varchar2,
 p_new_mi_satisfied_date         in    varchar2,
 p_mi_letter_sent_on             in    varchar2
 )
 as
 
 v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DPMICUR';
           v_sql_code number := null;
           v_log_message clob := null;
           r_dpmicur D_NYEC_PMI_CURRENT%rowtype := null;
           
    begin

r_dpmicur."Age in Business Days"          := p_age_in_business_days;  
r_dpmicur."MI Task Create Date"           := to_date(p_mi_task_create_date,BPM_COMMON.DATE_FMT);   
r_dpmicur."MI Task Complete Date"         := to_date(p_mi_task_complete_date,BPM_COMMON.DATE_FMT);  
    
r_dpmicur."Age in Calendar Days" := trunc(nvl(r_dpmicur."MI Task Complete Date",sysdate)) - trunc(r_dpmicur."MI Task Create Date");    

r_dpmicur."SLA Days Type" := p_sla_days_type;
r_dpmicur."SLA Days" := p_sla_days;
   
r_dpmicur."SLA Jeopardy Days" := p_sla_jeopardy_days;
r_dpmicur."SLA Target Days" := p_sla_target_days;

      if r_dpmicur."MI Task Complete Date" is null then
        r_dpmicur."Timeliness Status" := 'Not Complete';
      elsif p_sla_days is null then
        r_dpmicur."Timeliness Status" := 'Not Required';
      elsif (p_sla_days_type = 'B' and p_age_in_business_days > p_sla_days)
            or
            (p_sla_days_type = 'C' and r_dpmicur."Age in Calendar Days" > p_sla_days) then
        r_dpmicur."Timeliness Status" := 'Untimely';
      else
        r_dpmicur."Timeliness Status" := 'Timely';
      end if;
      
    
r_dpmicur.NYEC_PMI_BI_ID := p_bi_id;
        
r_dpmicur."Cur Application ID"            := p_cur_application_id;       
r_dpmicur."Cancel Date"                   := to_date(p_cancel_date,BPM_COMMON.DATE_FMT);              
r_dpmicur."Complete MI Task End Date"     := to_date(p_cmplte_mi_tsk_end_dt,BPM_COMMON.DATE_FMT);     
r_dpmicur."Complete MI Task Performed By" := p_cmplte_mi_tsk_prfrmd_by;  
r_dpmicur."Complete MI Task Start Date"   := to_date(p_cmplte_mi_tsk_strt_dt,BPM_COMMON.DATE_FMT);   
r_dpmicur."Crt St Accept Task End Date"   := to_date(p_crt_st_acpt_tsk_end_dt,BPM_COMMON.DATE_FMT);   
r_dpmicur."Crt St Accept Task Perf By"    := p_crt_st_acpt_tsk_perf_by;  
r_dpmicur."Crt St Accept Task Start Date" := to_date(p_crt_st_acpt_tsk_strt_dt,BPM_COMMON.DATE_FMT); 
r_dpmicur."Current Task ID"               := p_current_task_id;          
r_dpmicur."Determine MI Outcm End Date"   := to_date(p_detrmne_mi_outcm_end_dt,BPM_COMMON.DATE_FMT);  
r_dpmicur."Determine MI Outcm Perf By"    := p_detrmne_mi_outcm_perf_by; 
r_dpmicur."Determine MI Outcm Start Date" := to_date(p_detrmne_mi_outcm_strt_dt,BPM_COMMON.DATE_FMT); 
r_dpmicur."Cur Inbound MI Type"           := p_cur_inbound_mi_type;      
r_dpmicur."Instance Complete Date"        := to_date(p_instance_complt_dt,BPM_COMMON.DATE_FMT);       
r_dpmicur."Instance Status"               := p_instance_status;          
r_dpmicur."Jeopardy Flag"                 := p_jeopardy_flag;            
r_dpmicur."MI Receipt Date"               := to_date(p_mi_receipt_date,BPM_COMMON.DATE_FMT);          
r_dpmicur."MI Channel"                    := p_mi_channel;               
r_dpmicur."MI Task Type"                  := p_mi_task_type;             
r_dpmicur."MI Task ID"                    := p_mi_task_id;               
r_dpmicur."MI Task Complete Date"         := to_date(p_mi_task_complete_date,BPM_COMMON.DATE_FMT);    
r_dpmicur."MI Cycle Business Days"        := p_mi_cycle_business_days;   
r_dpmicur."MI Cycle End Date"             := to_date(p_mi_cycle_end_date,BPM_COMMON.DATE_FMT);        
r_dpmicur."MI Cycle Start Date"           := to_date(p_mi_cycle_start_date,BPM_COMMON.DATE_FMT);      
r_dpmicur."MI Call Campaign"              := p_mi_call_campaign;         
r_dpmicur."MI Letter Request ID"          := p_mi_letter_request_id;     
r_dpmicur."Cur MI Letter Status"          := p_cur_mi_letter_status;     
r_dpmicur."Manual Letter ID"              := p_manual_letter_id;         
r_dpmicur."Manual Letter Sent Date"       := to_date(p_manual_letter_sent_date,BPM_COMMON.DATE_FMT);  
r_dpmicur."Cur Pending MI Type"           := p_cur_pending_mi_type;      
r_dpmicur."Perform QC End Date"           := to_date(p_perfrm_qc_end_date,BPM_COMMON.DATE_FMT);       
r_dpmicur."Perform QC Performed By"       := p_perfrm_qc_perfrmd_by;     
r_dpmicur."Perform QC Start Date"         := to_date(p_perfrm_qc_start_date,BPM_COMMON.DATE_FMT);     
r_dpmicur."Perform Research End Date"     := to_date(p_perfrm_resrch_end_dt,BPM_COMMON.DATE_FMT);     
r_dpmicur."Perform Research Performed By" := p_perfrm_resrch_perfrmd_by; 
r_dpmicur."Perform Research Start Date"   := to_date(p_perfrm_resrch_strt_dt,BPM_COMMON.DATE_FMT);   
r_dpmicur."Cur QC Task ID"                := p_cur_qc_task_id;           
r_dpmicur."Receive MI End Date"           := to_date(p_receive_mi_end_date,BPM_COMMON.DATE_FMT);      
r_dpmicur."Receive MI Performed By"       := p_receive_mi_perfrmd_by;    
r_dpmicur."Receive MI Start Date"         := to_date(p_receive_mi_start_date,BPM_COMMON.DATE_FMT);    
r_dpmicur."Request MI End Date"           := to_date(p_request_mi_end_date,BPM_COMMON.DATE_FMT);      
r_dpmicur."Request MI Performed By"       := p_request_mi_perfrmd_by;    
r_dpmicur."Request MI Start Date"         := to_date(p_request_mi_start_date,BPM_COMMON.DATE_FMT);    
r_dpmicur."Cur Research Reason"           := p_cur_research_reason;      
r_dpmicur."Cur Research Task ID"          := p_cur_research_task_id;     
r_dpmicur."SLA Jeopardy Date"             := to_date(p_sla_jeopardy_date,BPM_COMMON.DATE_FMT);        
r_dpmicur."Cur State Review Task ID"      := p_cur_state_revw_tsk_id;    
r_dpmicur."Channel Flag"                  := p_channel_flag;
r_dpmicur."QC Required - Phone Flag"      := p_qc_required_phone_flag;
r_dpmicur."Update State System Flag"      := p_update_state_system_flag;
r_dpmicur."Manual Letter Flag"            := p_manual_letter_flag;
r_dpmicur."Send Research Flag"            := p_send_research_flag;
r_dpmicur."QC Required Flag"              := p_qc_required_flag;
r_dpmicur."QC Outcome Flag"               := p_qc_outcome_flag;
r_dpmicur."MI Outcome Flag"               := p_mi_outcome_flag;
r_dpmicur."Receive MI Flag"               := p_receive_mi_flag;
r_dpmicur."Create State Accept Flag"      := p_create_state_accept_flag;
r_dpmicur."Determine MI Outcome Flag"     := p_determine_mi_outcome_flag;
r_dpmicur."Complete MI Task Flag"         := p_complete_mi_task_flag;
r_dpmicur."Perform QC on MI Flag"         := p_perform_qc_on_mi_flag;
r_dpmicur."Perform Research Flag"         := p_perform_research_flag;
r_dpmicur."Send MI Letter Flag"           := p_send_mi_letter_flag;
r_dpmicur."All MI Satisfied"              := p_all_mi_satisfied;
r_dpmicur."New MI Creation Date"          := to_date(p_new_mi_creation_date,BPM_COMMON.DATE_FMT);
r_dpmicur."New MI Satisfied Date"         := to_date(p_new_mi_satisfied_date,BPM_COMMON.DATE_FMT);
r_dpmicur."MI Letter Sent On"    := to_date(p_mi_letter_sent_on,BPM_COMMON.DATE_FMT);
    
if p_set_type = 'INSERT' then
       insert into D_NYEC_PMI_CURRENT
       values r_dpmicur;
      elsif p_set_type = 'UPDATE' then
        update D_NYEC_PMI_CURRENT
        set row = r_dpmicur
        where NYEC_PMI_BI_ID = p_bi_id;
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
        
        v_new_data T_INS_PMI_XML := null;
        
        v_bi_id number := null;
        v_identifier varchar2(35) := null;
        
        v_start_date date := null;
        v_end_date date := null;
        
        v_dnpmiai_id  number :=null;    
	v_dnpmils_id  number :=null;    
	v_dnpmiimit_id   number :=null; 
	v_dnpmipmit_id number :=null; 
	v_dnpmiqti_id number :=null; 
	v_dnpmirr_id number :=null; 
	v_dnpmirti_id number :=null; 
	v_dnpmisrti_id number :=null; 
	v_fnpmibd_id number :=null; 
	
	begin
	    
	    if p_data_version != 1 then
	            v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Process MI in procedure ' || v_procedure_name || '.';
	            RAISE_APPLICATION_ERROR(-20011,v_log_message);        
	          end if;
	          
	          GET_INS_PMI_XML(p_new_data_xml,v_new_data);
	          
	    v_identifier := v_new_data.MI_TASK_ID;
      v_start_date := to_date(v_new_data.MI_TASK_CREATE_DATE,BPM_COMMON.DATE_FMT);
      v_end_date := to_date(v_new_data.INSTANCE_COMPLETE_DT,BPM_COMMON.DATE_FMT);
      BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
      v_bi_id := SEQ_BI_ID.nextval;
          
GET_DNPMIAI_ID(v_identifier,v_bi_id,v_new_data.APP_ID,v_dnpmiai_id );
GET_DNPMIIMIT_ID(v_identifier,v_bi_id,v_new_data.MI_TYPE,v_dnpmiimit_id);
GET_DNPMILS_ID(v_identifier,v_bi_id,v_new_data.MI_LETTER_STATUS,v_dnpmils_id);
GET_DNPMIPMIT_ID(v_identifier,v_bi_id,v_new_data.PENDING_MI_TYPE,v_dnpmipmit_id);
GET_DNPMIQTI_ID(v_identifier,v_bi_id,v_new_data.QC_TASK_ID,v_dnpmiqti_id);
GET_DNPMIRR_ID(v_identifier,v_bi_id,v_new_data.RESEARCH_REASON,v_dnpmirr_id);
GET_DNPMIRTI_ID(v_identifier,v_bi_id,v_new_data.RESEARCH_TASK_ID,v_dnpmirti_id);
GET_DNPMISRTI_ID(v_identifier,v_bi_id,v_new_data.STATE_REVIEW_TASK_ID,v_dnpmisrti_id);

-- Insert current dimension and fact as a single transaction.
          begin
          
      commit;
         
SET_DPMICUR('INSERT',v_identifier,v_bi_id,v_new_data.AGE_IN_BUSINESS_DAYS,v_new_data.APP_ID,v_new_data.CANCEL_DATE,
v_new_data.ASED_COMPLETE_MI_TASK,v_new_data.ASPB_COMPLETE_MI_TASK,v_new_data.ASSD_COMPLETE_MI_TASK,v_new_data.ASED_CREATE_STATE_ACCEPT,
v_new_data.ASPB_CREATE_STATE_ACCEPT,v_new_data.ASSD_CREATE_STATE_ACCEPT,v_new_data.CURRENT_TASK_ID,v_new_data.ASED_DETERMINE_MI_OUTCOME,
v_new_data.ASPB_DETERMINE_MI_OUTCOME,v_new_data.ASSD_DETERMINE_MI_OUTCOME,v_new_data.MI_TYPE,v_new_data.INSTANCE_COMPLETE_DT,
v_new_data.INSTANCE_STATUS,v_new_data.JEOPARDY_FLAG,v_new_data.MI_RECEIPT_DT,v_new_data.MI_CHANNEL,v_new_data.MI_TASK_TYPE,v_new_data.MI_TASK_ID,
v_new_data.MI_TASK_CREATE_DATE,v_new_data.MI_TASK_COMPLETE_DATE,v_new_data.MI_CYCLE_BUS_DAYS,v_new_data.MI_CYCLE_END_DT,v_new_data.MI_CYCLE_START_DT,
v_new_data.MI_CALL_CAMPAIGN,v_new_data.MI_LETTER_REQUEST_ID,v_new_data.MI_LETTER_STATUS,v_new_data.MAN_LETTER_ID,v_new_data.MAN_LETTER_SENT_DT,
v_new_data.PENDING_MI_TYPE,v_new_data.ASED_PERFORM_QC,v_new_data.ASPB_PERFORM_QC,v_new_data.ASSD_PERFORM_QC,v_new_data.ASED_PERFORM_RESEARCH,
v_new_data.ASPB_PERFORM_RESEARCH,v_new_data.ASSD_PERFORM_RESEARCH,v_new_data.QC_TASK_ID,v_new_data.ASED_RECEIVE_MI,v_new_data.ASPB_RECEIVE_MI,
v_new_data.ASSD_RECEIVE_MI,v_new_data.ASED_SEND_MI_LETTER,v_new_data.ASPB_SEND_MI_LETTER,v_new_data.ASSD_SEND_MI_LETTER,v_new_data.RESEARCH_REASON,
v_new_data.RESEARCH_TASK_ID,v_new_data.SLA_DAYS,v_new_data.SLA_DAYS_TYPE,v_new_data.SLA_JEOPARDY_DT,v_new_data.SLA_JEOPARDY_DAYS,v_new_data.SLA_TARGET_DAYS,v_new_data.STATE_REVIEW_TASK_ID,
v_new_data.GWF_CHANNEL,v_new_data.GWF_PHONE_QC_REQ,v_new_data.GWF_UPDATE_STATE,v_new_data.GWF_MANUAL_LETTER,
v_new_data.GWF_SEND_RESEARCH,v_new_data.GWF_QC_REQUIRED,v_new_data.GWF_QC_OUTCOME,v_new_data.GWF_MI_OUTCOME,
v_new_data.ASF_RECEIVE_MI,v_new_data.ASF_CREATE_STATE_ACCEPT,v_new_data.ASF_DETERMINE_MI_OUTCOME,
v_new_data.ASF_COMPLETE_MI_TASK,v_new_data.ASF_PERFORM_QC,v_new_data.ASF_PERFORM_RESEARCH,v_new_data.ASF_SEND_MI_LETTER,
v_new_data.ALL_MI_SATISFIED,v_new_data.NEW_MI_CREATION_DATE,v_new_data.NEW_MI_SATISFIED_DATE,v_new_data.MI_LETTER_SENT_ON);

INS_FPMIBD(v_identifier,v_start_date,v_end_date,v_bi_id,v_dnpmiai_id,v_dnpmils_id,
v_dnpmiimit_id,v_dnpmipmit_id,v_dnpmiqti_id,v_dnpmirr_id,v_dnpmirti_id,
v_dnpmisrti_id,v_new_data.STG_LAST_UPDATE_DATE,v_fnpmibd_id);

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
  
  -- Update fact for BPM Semantic model - NYEC Process MI process. 

procedure UPD_FPMIBD
  (p_identifier in varchar2,       
   p_start_date in date,       
   p_end_date in date,       
   p_bi_id in number,       
   p_dnpmiai_id in number,       
   p_dnpmils_id in number,       
   p_dnpmiimit_id in number,       
   p_dnpmipmit_id in number,       
   p_dnpmiqti_id in number,       
   p_dnpmirr_id in number,       
   p_dnpmirti_id in number,       
   p_dnpmisrti_id in number,       
   p_stg_last_update_date in varchar2,       
   p_fnpmibd_id out number              
   )
   
as

v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FPMIBD';
       v_sql_code number := null;
       v_log_message clob := null;
       
       V_fnpmibd_id_old number := null;
       v_d_date_old date := null;
       v_stg_last_update_date date := null;
       v_creation_count_old number := null;
       v_completion_count_old number := null;
       v_max_d_date date := null;
       v_event_date date := null;
      
       r_fnpmibd F_NYEC_PMI_BY_DATE%rowtype := null;
       
     begin

       v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
       v_event_date := v_stg_last_update_date;
       
       with most_recent_fact_bi_id as
                (select 
                   max(FNPMIBD_ID) max_fnpmibd_id,
                   max(D_DATE) max_d_date
                 from F_NYEC_PMI_BY_DATE
                 where NYEC_PMI_BI_ID = p_bi_id) 
              select 
                fnpmibd.FNPMIBD_ID,
                fnpmibd.D_DATE,
                fnpmibd.CREATION_COUNT,
                fnpmibd.COMPLETION_COUNT,
                most_recent_fact_bi_id.max_d_date
              into 
                v_fnpmibd_id_old,
                v_d_date_old,
                v_creation_count_old,
                v_completion_count_old,
                v_max_d_date
              from 
                F_NYEC_PMI_BY_DATE fnpmibd,
                most_recent_fact_bi_id 
              where
               fnpmibd.FNPMIBD_ID = max_fnpmibd_id
               and fnpmibd.D_DATE = most_recent_fact_bi_id.max_d_date;
 
     -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;       
     
        -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE. 
              if v_stg_last_update_date < v_max_d_date then
                v_stg_last_update_date := v_max_d_date;
       end if;
       
    if p_end_date is null then
      r_fnpmibd.D_DATE := v_event_date;
      r_fnpmibd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpmibd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpmibd.INVENTORY_COUNT := 1;
      r_fnpmibd.COMPLETION_COUNT := 0;
    else
      r_fnpmibd.D_DATE := p_end_date;
      r_fnpmibd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpmibd.BUCKET_END_DATE := r_fnpmibd.BUCKET_START_DATE;
      r_fnpmibd.INVENTORY_COUNT := 0;
      r_fnpmibd.COMPLETION_COUNT := 1;
    end if;
         p_fnpmibd_id := SEQ_FNPMIBD_ID.nextval;
         r_fnpmibd.FNPMIBD_ID := p_fnpmibd_id;
       r_fnpmibd.NYEC_PMI_BI_ID := p_bi_id;
       r_fnpmibd.dnpmiai_id := p_dnpmiai_id;
       r_fnpmibd.dnpmils_id := p_dnpmils_id;
       r_fnpmibd.dnpmiimit_id := p_dnpmiimit_id;
       r_fnpmibd.dnpmipmit_id := p_dnpmipmit_id;
       r_fnpmibd.dnpmiqti_id := p_dnpmiqti_id;
       r_fnpmibd.dnpmirr_id := p_dnpmirr_id ;
       r_fnpmibd.dnpmirti_id := p_dnpmirti_id ;
       r_fnpmibd.dnpmisrti_id := p_dnpmisrti_id;
       r_fnpmibd.CREATION_COUNT := 0;
       
    -- Validate fact date ranges.
    if r_fnpmibd.D_DATE < r_fnpmibd.BUCKET_START_DATE
      or to_date(to_char(r_fnpmibd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fnpmibd.BUCKET_END_DATE
      or r_fnpmibd.BUCKET_START_DATE > r_fnpmibd.BUCKET_END_DATE
      or r_fnpmibd.BUCKET_END_DATE < r_fnpmibd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || r_fnpmibd.D_DATE || 
        ' BUCKET_START_DATE = ' || to_char(r_fnpmibd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_fnpmibd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;      
       
       if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fnpmibd.BUCKET_START_DATE then
         -- Same bucket time.
         if v_creation_count_old = 1 then
            r_fnpmibd.CREATION_COUNT := v_creation_count_old;
         end if;
         update F_NYEC_PMI_BY_DATE
         set row = r_fnpmibd
         where FNPMIBD_ID = v_fnpmibd_id_old;
       else
         -- Different bucket time.
         update F_NYEC_PMI_BY_DATE
         set BUCKET_END_DATE = r_fnpmibd.BUCKET_START_DATE
         where FNPMIBD_ID = v_fnpmibd_id_old;
         
         insert into F_NYEC_PMI_BY_DATE
         values r_fnpmibd;
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
        
     
         v_old_data T_UPD_PMI_XML := null;
         v_new_data T_UPD_PMI_XML := null;
     
      begin

if p_data_version != 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" with NYEC Process MI in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);        
        end if; 
    
        GET_UPD_PMI_XML(p_old_data_xml,v_old_data);
        GET_UPD_PMI_XML(p_new_data_xml,v_new_data);
    
          v_identifier := v_new_data.MI_TASK_ID;
          v_start_date := to_date(v_new_data.MI_TASK_CREATE_DATE,BPM_COMMON.DATE_FMT);
          v_end_date := to_date(v_new_data.INSTANCE_COMPLETE_DT,BPM_COMMON.DATE_FMT);
          BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier); 
          v_stg_last_update_date:=to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT);
          
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
          
   BPM_EVENT.UPDATE_BIA(v_bi_id,243,1,'N',v_old_data.AGE_IN_BUSINESS_DAYS,v_new_data.AGE_IN_BUSINESS_DAYS,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,245,1,'Y',v_old_data.APP_ID,v_new_data.APP_ID,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,246,3,'N',v_old_data.ASED_COMPLETE_MI_TASK,v_new_data.ASED_COMPLETE_MI_TASK,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,247,3,'N',v_old_data.ASED_CREATE_STATE_ACCEPT,v_new_data.ASED_CREATE_STATE_ACCEPT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,248,3,'N',v_old_data.ASED_DETERMINE_MI_OUTCOME,v_new_data.ASED_DETERMINE_MI_OUTCOME,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,249,3,'N',v_old_data.ASED_PERFORM_QC,v_new_data.ASED_PERFORM_QC,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,250,3,'N',v_old_data.ASED_PERFORM_RESEARCH,v_new_data.ASED_PERFORM_RESEARCH,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,251,3,'N',v_old_data.ASED_RECEIVE_MI,v_new_data.ASED_RECEIVE_MI,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,252,3,'N',v_old_data.ASED_SEND_MI_LETTER,v_new_data.ASED_SEND_MI_LETTER,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,253,2,'N',v_old_data.ASPB_COMPLETE_MI_TASK,v_new_data.ASPB_COMPLETE_MI_TASK,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,254,2,'N',v_old_data.ASPB_CREATE_STATE_ACCEPT,v_new_data.ASPB_CREATE_STATE_ACCEPT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,255,2,'N',v_old_data.ASPB_DETERMINE_MI_OUTCOME,v_new_data.ASPB_DETERMINE_MI_OUTCOME,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,256,2,'N',v_old_data.ASPB_PERFORM_QC,v_new_data.ASPB_PERFORM_QC,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,257,2,'N',v_old_data.ASPB_PERFORM_RESEARCH,v_new_data.ASPB_PERFORM_RESEARCH,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,258,2,'N',v_old_data.ASPB_RECEIVE_MI,v_new_data.ASPB_RECEIVE_MI,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,259,2,'N',v_old_data.ASPB_SEND_MI_LETTER,v_new_data.ASPB_SEND_MI_LETTER,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,260,3,'N',v_old_data.ASSD_COMPLETE_MI_TASK,v_new_data.ASSD_COMPLETE_MI_TASK,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,261,3,'N',v_old_data.ASSD_CREATE_STATE_ACCEPT,v_new_data.ASSD_CREATE_STATE_ACCEPT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,262,3,'N',v_old_data.ASSD_DETERMINE_MI_OUTCOME,v_new_data.ASSD_DETERMINE_MI_OUTCOME,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,263,3,'N',v_old_data.ASSD_PERFORM_QC,v_new_data.ASSD_PERFORM_QC,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,264,3,'N',v_old_data.ASSD_PERFORM_RESEARCH,v_new_data.ASSD_PERFORM_RESEARCH,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,265,3,'N',v_old_data.ASSD_RECEIVE_MI,v_new_data.ASSD_RECEIVE_MI,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,266,3,'N',v_old_data.ASSD_SEND_MI_LETTER,v_new_data.ASSD_SEND_MI_LETTER,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,267,3,'N',v_old_data.CANCEL_DATE,v_new_data.CANCEL_DATE,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,268,1,'N',v_old_data.CURRENT_TASK_ID,v_new_data.CURRENT_TASK_ID,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,269,3,'N',v_old_data.INSTANCE_COMPLETE_DT,v_new_data.INSTANCE_COMPLETE_DT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,270,2,'N',v_old_data.INSTANCE_STATUS,v_new_data.INSTANCE_STATUS,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,271,2,'N',v_old_data.JEOPARDY_FLAG,v_new_data.JEOPARDY_FLAG,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,272,1,'N',v_old_data.MAN_LETTER_ID,v_new_data.MAN_LETTER_ID,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,273,3,'N',v_old_data.MAN_LETTER_SENT_DT,v_new_data.MAN_LETTER_SENT_DT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,274,2,'N',v_old_data.MI_CALL_CAMPAIGN,v_new_data.MI_CALL_CAMPAIGN,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,275,2,'N',v_old_data.MI_CHANNEL,v_new_data.MI_CHANNEL,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,276,1,'N',v_old_data.MI_CYCLE_BUS_DAYS,v_new_data.MI_CYCLE_BUS_DAYS,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,277,3,'N',v_old_data.MI_CYCLE_END_DT,v_new_data.MI_CYCLE_END_DT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,279,1,'N',v_old_data.MI_LETTER_REQUEST_ID,v_new_data.MI_LETTER_REQUEST_ID,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,280,2,'Y',v_old_data.MI_LETTER_STATUS,v_new_data.MI_LETTER_STATUS,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,282,3,'N',v_old_data.MI_TASK_COMPLETE_DATE,v_new_data.MI_TASK_COMPLETE_DATE,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,286,2,'Y',v_old_data.MI_TYPE,v_new_data.MI_TYPE,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,287,2,'Y',v_old_data.PENDING_MI_TYPE,v_new_data.PENDING_MI_TYPE,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,288,1,'Y',v_old_data.QC_TASK_ID,v_new_data.QC_TASK_ID,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,289,2,'Y',v_old_data.RESEARCH_REASON,v_new_data.RESEARCH_REASON,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,290,1,'Y',v_old_data.RESEARCH_TASK_ID,v_new_data.RESEARCH_TASK_ID,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,291,1,'N',v_old_data.SLA_DAYS,v_new_data.SLA_DAYS,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,292,2,'N',v_old_data.SLA_DAYS_TYPE,v_new_data.SLA_DAYS_TYPE,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,293,1,'N',v_old_data.SLA_JEOPARDY_DAYS,v_new_data.SLA_JEOPARDY_DAYS,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,294,3,'N',v_old_data.SLA_JEOPARDY_DT,v_new_data.SLA_JEOPARDY_DT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,295,1,'N',v_old_data.SLA_TARGET_DAYS,v_new_data.SLA_TARGET_DAYS,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,296,1,'Y',v_old_data.STATE_REVIEW_TASK_ID,v_new_data.STATE_REVIEW_TASK_ID,v_bue_id,v_stg_last_update_date);

     BPM_EVENT.UPDATE_BIA(v_bi_id,444,2,'N',v_old_data.GWF_CHANNEL,v_new_data.GWF_CHANNEL,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,445,2,'N',v_old_data.GWF_PHONE_QC_REQ,v_new_data.GWF_PHONE_QC_REQ,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,446,2,'N',v_old_data.GWF_UPDATE_STATE,v_new_data.GWF_UPDATE_STATE,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,447,2,'N',v_old_data.GWF_MANUAL_LETTER,v_new_data.GWF_MANUAL_LETTER,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,448,2,'N',v_old_data.GWF_SEND_RESEARCH,v_new_data.GWF_SEND_RESEARCH,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,449,2,'N',v_old_data.GWF_QC_REQUIRED,v_new_data.GWF_QC_REQUIRED,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,450,2,'N',v_old_data.GWF_QC_OUTCOME,v_new_data.GWF_QC_OUTCOME,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,451,2,'N',v_old_data.GWF_MI_OUTCOME,v_new_data.GWF_MI_OUTCOME,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,452,2,'N',v_old_data.ASF_RECEIVE_MI,v_new_data.ASF_RECEIVE_MI,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,453,2,'N',v_old_data.ASF_CREATE_STATE_ACCEPT,v_new_data.ASF_CREATE_STATE_ACCEPT,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,454,2,'N',v_old_data.ASF_DETERMINE_MI_OUTCOME,v_new_data.ASF_DETERMINE_MI_OUTCOME,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,455,2,'N',v_old_data.ASF_COMPLETE_MI_TASK,v_new_data.ASF_COMPLETE_MI_TASK,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,456,2,'N',v_old_data.ASF_PERFORM_QC,v_new_data.ASF_PERFORM_QC,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,457,2,'N',v_old_data.ASF_PERFORM_RESEARCH,v_new_data.ASF_PERFORM_RESEARCH,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,458,2,'N',v_old_data.ASF_SEND_MI_LETTER,v_new_data.ASF_SEND_MI_LETTER,v_bue_id,v_stg_last_update_date);
   
     BPM_EVENT.UPDATE_BIA(v_bi_id,477,2,'N',v_old_data.ALL_MI_SATISFIED,v_new_data.ALL_MI_SATISFIED,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,478,3,'N',v_old_data.NEW_MI_CREATION_DATE,v_new_data.NEW_MI_CREATION_DATE,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,479,3,'N',v_old_data.NEW_MI_SATISFIED_DATE,v_new_data.NEW_MI_SATISFIED_DATE,v_bue_id,v_stg_last_update_date);
     BPM_EVENT.UPDATE_BIA(v_bi_id,480,3,'N',v_old_data.MI_LETTER_SENT_ON,v_new_data.MI_LETTER_SENT_ON,v_bue_id,v_stg_last_update_date);   
     
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
        
        v_old_data T_UPD_PMI_XML := null;
        v_new_data T_UPD_PMI_XML := null;
      
        v_bi_id number := null;
        v_identifier varchar2(35) := null;
        
        v_start_date date := null;
        v_end_date date := null;

        v_dnpmiai_id  number :=null;    
	v_dnpmils_id  number :=null;    
	v_dnpmiimit_id   number :=null; 
	v_dnpmipmit_id number :=null; 
	v_dnpmiqti_id number :=null; 
	v_dnpmirr_id number :=null; 
	v_dnpmirti_id number :=null; 
	v_dnpmisrti_id number :=null; 
	v_fnpmibd_id number :=null;     

 begin
      
         if p_data_version != 1 then
           v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Process MI in procedure ' || v_procedure_name || '.';
           RAISE_APPLICATION_ERROR(-20011,v_log_message);        
         end if;
         
         GET_UPD_PMI_XML(p_old_data_xml,v_old_data);
         GET_UPD_PMI_XML(p_new_data_xml,v_new_data);
      
         v_identifier := v_new_data.MI_TASK_ID;
	       v_start_date := to_date(v_new_data.MI_TASK_CREATE_DATE,BPM_COMMON.DATE_FMT);
         v_end_date := to_date(v_new_data.INSTANCE_COMPLETE_DT,BPM_COMMON.DATE_FMT);
         BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
    
         select NYEC_PMI_BI_ID 
         into v_bi_id
         from D_NYEC_PMI_CURRENT
         where "MI Task ID" = v_identifier;
        
GET_DNPMIAI_ID(v_identifier,v_bi_id,v_new_data.APP_ID,v_dnpmiai_id );
GET_DNPMIIMIT_ID(v_identifier,v_bi_id,v_new_data.MI_TYPE,v_dnpmiimit_id);
GET_DNPMILS_ID(v_identifier,v_bi_id,v_new_data.MI_LETTER_STATUS,v_dnpmils_id);
GET_DNPMIPMIT_ID(v_identifier,v_bi_id,v_new_data.PENDING_MI_TYPE,v_dnpmipmit_id);
GET_DNPMIQTI_ID(v_identifier,v_bi_id,v_new_data.QC_TASK_ID,v_dnpmiqti_id);
GET_DNPMIRR_ID(v_identifier,v_bi_id,v_new_data.RESEARCH_REASON,v_dnpmirr_id);
GET_DNPMIRTI_ID(v_identifier,v_bi_id,v_new_data.RESEARCH_TASK_ID,v_dnpmirti_id);
GET_DNPMISRTI_ID(v_identifier,v_bi_id,v_new_data.STATE_REVIEW_TASK_ID,v_dnpmisrti_id);

 -- Update current dimension and fact as a single transaction.
            begin
               
        commit;
 
SET_DPMICUR('UPDATE',v_identifier,v_bi_id,v_new_data.AGE_IN_BUSINESS_DAYS,v_new_data.APP_ID,v_new_data.CANCEL_DATE,
v_new_data.ASED_COMPLETE_MI_TASK,v_new_data.ASPB_COMPLETE_MI_TASK,v_new_data.ASSD_COMPLETE_MI_TASK,v_new_data.ASED_CREATE_STATE_ACCEPT,
v_new_data.ASPB_CREATE_STATE_ACCEPT,v_new_data.ASSD_CREATE_STATE_ACCEPT,v_new_data.CURRENT_TASK_ID,v_new_data.ASED_DETERMINE_MI_OUTCOME,
v_new_data.ASPB_DETERMINE_MI_OUTCOME,v_new_data.ASSD_DETERMINE_MI_OUTCOME,v_new_data.MI_TYPE,v_new_data.INSTANCE_COMPLETE_DT,
v_new_data.INSTANCE_STATUS,v_new_data.JEOPARDY_FLAG,v_new_data.MI_RECEIPT_DT,v_new_data.MI_CHANNEL,v_new_data.MI_TASK_TYPE,v_new_data.MI_TASK_ID,
v_new_data.MI_TASK_CREATE_DATE,v_new_data.MI_TASK_COMPLETE_DATE,v_new_data.MI_CYCLE_BUS_DAYS,v_new_data.MI_CYCLE_END_DT,v_new_data.MI_CYCLE_START_DT,
v_new_data.MI_CALL_CAMPAIGN,v_new_data.MI_LETTER_REQUEST_ID,v_new_data.MI_LETTER_STATUS,v_new_data.MAN_LETTER_ID,v_new_data.MAN_LETTER_SENT_DT,
v_new_data.PENDING_MI_TYPE,v_new_data.ASED_PERFORM_QC,v_new_data.ASPB_PERFORM_QC,v_new_data.ASSD_PERFORM_QC,v_new_data.ASED_PERFORM_RESEARCH,
v_new_data.ASPB_PERFORM_RESEARCH,v_new_data.ASSD_PERFORM_RESEARCH,v_new_data.QC_TASK_ID,v_new_data.ASED_RECEIVE_MI,v_new_data.ASPB_RECEIVE_MI,
v_new_data.ASSD_RECEIVE_MI,v_new_data.ASED_SEND_MI_LETTER,v_new_data.ASPB_SEND_MI_LETTER,v_new_data.ASSD_SEND_MI_LETTER,v_new_data.RESEARCH_REASON,
v_new_data.RESEARCH_TASK_ID,v_new_data.SLA_DAYS,v_new_data.SLA_DAYS_TYPE,v_new_data.SLA_JEOPARDY_DT,v_new_data.SLA_JEOPARDY_DAYS,v_new_data.SLA_TARGET_DAYS,v_new_data.STATE_REVIEW_TASK_ID,
v_new_data.GWF_CHANNEL,v_new_data.GWF_PHONE_QC_REQ,v_new_data.GWF_UPDATE_STATE,v_new_data.GWF_MANUAL_LETTER,
v_new_data.GWF_SEND_RESEARCH,v_new_data.GWF_QC_REQUIRED,v_new_data.GWF_QC_OUTCOME,v_new_data.GWF_MI_OUTCOME,
v_new_data.ASF_RECEIVE_MI,v_new_data.ASF_CREATE_STATE_ACCEPT,v_new_data.ASF_DETERMINE_MI_OUTCOME,
v_new_data.ASF_COMPLETE_MI_TASK,v_new_data.ASF_PERFORM_QC,v_new_data.ASF_PERFORM_RESEARCH,v_new_data.ASF_SEND_MI_LETTER,
v_new_data.ALL_MI_SATISFIED,v_new_data.NEW_MI_CREATION_DATE,v_new_data.NEW_MI_SATISFIED_DATE,v_new_data.MI_LETTER_SENT_ON);

UPD_FPMIBD(v_identifier,v_start_date,v_end_date,v_bi_id,v_dnpmiai_id,v_dnpmils_id,
v_dnpmiimit_id,v_dnpmipmit_id,v_dnpmiqti_id,v_dnpmirr_id,v_dnpmirti_id,
v_dnpmisrti_id,v_new_data.STG_LAST_UPDATE_DATE,v_fnpmibd_id);

commit;
              
            exception
            
              when OTHERS then
                rollback;
                v_sql_code := SQLCODE;
                v_log_message := 'Rolled back latest current dimension and fact changes.'  || SQLERRM;
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




