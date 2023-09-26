CREATE OR REPLACE package MW_V2 as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MW_V2/createdb/MW_V2_pkg.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 12838 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2014-11-17 14:06:53 -0700 (Mon, 17 Nov 2014) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: pa28085 $';

  procedure CALC_DMWCUR_V2;

  function GET_AGE_IN_BUSINESS_DAYS
    (p_WORK_RECEIPT_DATE in date,
     p_INSTANCE_END_DATE in date)
    return number;

  function GET_AGE_IN_CALENDAR_DAYS
    (p_WORK_RECEIPT_DATE in date,
     p_INSTANCE_END_DATE in date)
    return number;

  function GET_JEOPARDY_FLAG
    (
     p_TASK_TYPE_ID in number,
     p_CURR_WORK_RECEIPT_DATE in date,
     p_INSTANCE_END_DATE in date)
    return varchar2;

  function GET_STATUS_AGE_IN_BUS_DAYS
    (p_status_date in date,
     p_INSTANCE_END_DATE in date)
    return number;

  function GET_STATUS_AGE_IN_CAL_DAYS
    (p_status_date in date,
     p_INSTANCE_END_DATE in date)
    return number;

 function GET_TIMELINESS_STATUS
    (p_INSTANCE_END_DATE in date,
     p_TASK_TYPE_ID in number,
     p_CURR_WORK_RECEIPT_DATE in date)
    return varchar2;

 function GET_JEOPARDY_DAYS
    (p_task_type_id in number)
    return number result_cache;

  function GET_SLA_DAYS
    (p_task_type_id in number)
    return number result_cache;

  function GET_SLA_DAYS_TYPE
    (p_task_type_id in number)
    return varchar2 result_cache;

  /*
  Include:
    CEMW_ID
    STG_LAST_UPDATE_DATE
  */
  type T_INS_MW_XML is record
    (
  CANCELLED_BY_STAFF_ID      varchar2(100),
  CANCEL_METHOD              varchar2(50),
  CANCEL_REASON              varchar2(256),
  CANCEL_WORK_DATE           varchar2(19),
  CASE_ID                    varchar2(100),
  CEMW_ID                    varchar2(100),
  CLIENT_ID                  varchar2(100),
  COMPLETE_DATE              varchar2(19),
  CREATE_DATE                varchar2(19),
  CREATED_BY_STAFF_ID        varchar2(100),
  ESCALATED_FLAG             varchar2(1),
  ESCALATED_TO_STAFF_ID	     varchar2(100),
  FORWARDED_BY_STAFF_ID	     varchar2(100),
  FORWARDED_FLAG             varchar2(1),
  BUSINESS_UNIT_ID           varchar2(100),
  INSTANCE_START_DATE        varchar2(19),
  INSTANCE_END_DATE          varchar2(19),
  LAST_UPDATE_BY_STAFF_ID    varchar2(100),
  LAST_UPDATE_DATE           varchar2(19),
  LAST_EVENT_DATE            varchar2(19),
  OWNER_STAFF_ID             varchar2(100),
  PARENT_TASK_ID             varchar2(100),
  SOURCE_REFERENCE_ID        varchar2(100),
  SOURCE_REFERENCE_TYPE      varchar2(30),
  STATUS_DATE                varchar2(19),
  STG_EXTRACT_DATE           varchar2(19),
  STG_LAST_UPDATE_DATE       varchar2(19),
  STAGE_DONE_DATE            varchar2(19),
  TASK_ID                    varchar2(100),
  TASK_PRIORITY              varchar2(50),
  TASK_STATUS                varchar2(50),
  TASK_TYPE_ID               varchar2(100),
  TEAM_ID                    varchar2(100),
  UNIT_OF_WORK               varchar2(30),
  WORK_RECEIPT_DATE          varchar2(19),
  SOURCE_PROCESS_ID          varchar2(100),
  SOURCE_PROCESS_INSTANCE_ID varchar2(100),
  CHANNEL                    varchar2(25),
  RULE_EXECUTED              varchar2(100)
    );

  /*
  Include:
    STG_LAST_UPDATE_DATE
  */
  type T_UPD_MW_XML is record
    (
  CANCELLED_BY_STAFF_ID      varchar2(100),
  CANCEL_METHOD              varchar2(50),
  CANCEL_REASON              varchar2(256),
  CANCEL_WORK_DATE           varchar2(19),
  CASE_ID                    varchar2(100),
  CLIENT_ID                  varchar2(100),
  COMPLETE_DATE              varchar2(19),
  CREATE_DATE                varchar2(19),
  CREATED_BY_STAFF_ID        varchar2(100),
  ESCALATED_FLAG             varchar2(1),
  ESCALATED_TO_STAFF_ID	     varchar2(100),
  FORWARDED_BY_STAFF_ID	     varchar2(100),
  FORWARDED_FLAG             varchar2(1),
  BUSINESS_UNIT_ID           varchar2(100),
  INSTANCE_START_DATE        varchar2(19),
  INSTANCE_END_DATE          varchar2(19),
  LAST_UPDATE_BY_STAFF_ID    varchar2(100),
  LAST_UPDATE_DATE           varchar2(19),
  LAST_EVENT_DATE            varchar2(19),
  OWNER_STAFF_ID             varchar2(100),
  PARENT_TASK_ID             varchar2(100),
  SOURCE_REFERENCE_ID        varchar2(100),
  SOURCE_REFERENCE_TYPE      varchar2(30),
  STATUS_DATE                varchar2(19),
  STG_EXTRACT_DATE           varchar2(19),
  STG_LAST_UPDATE_DATE       varchar2(19),
  STAGE_DONE_DATE            varchar2(19),
  TASK_ID                    varchar2(100),
  TASK_PRIORITY              varchar2(50),
  TASK_STATUS                varchar2(50),
  TASK_TYPE_ID               varchar2(100),
  TEAM_ID                    varchar2(100),
  UNIT_OF_WORK               varchar2(30),
  WORK_RECEIPT_DATE          varchar2(19),
  SOURCE_PROCESS_ID          varchar2(100),
  SOURCE_PROCESS_INSTANCE_ID varchar2(100),
  CHANNEL                    varchar2(25),
  RULE_EXECUTED              varchar2(100)
    );

  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype);

  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype);

end;
/


CREATE OR REPLACE package body MW_V2 as

  v_bem_id number := 2001; -- 'OPS Manage Work V2'
  v_bil_id number := 3; -- 'Task ID'
  v_bsl_id number := 2001; -- 'CORP_ETL_MW_V2'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';

  v_calc_dnpacur_job_name varchar2(30) := 'CALC_DNPACUR';


  function GET_AGE_IN_BUSINESS_DAYS
    (p_WORK_RECEIPT_DATE in date,
     p_INSTANCE_END_DATE in date)
    return number
  as
  begin
     return BPM_COMMON.BUS_DAYS_BETWEEN(p_WORK_RECEIPT_DATE,nvl(p_INSTANCE_END_DATE,sysdate));
  end;


  function GET_AGE_IN_CALENDAR_DAYS
    (p_WORK_RECEIPT_DATE in date,
     p_INSTANCE_END_DATE in date)
    return number
  as
  begin
    return trunc(nvl(p_INSTANCE_END_DATE,sysdate)) - trunc(p_WORK_RECEIPT_DATE);
  end;


  function GET_JEOPARDY_FLAG
    (
     p_TASK_TYPE_ID in number,
     p_CURR_WORK_RECEIPT_DATE in date,
     p_INSTANCE_END_DATE in date)
    return varchar2
  as
    v_sla_days_type varchar2(1) := null;
    v_age_in_business_days number := null;
    v_age_in_calendar_days number := null;
    v_sla_jeopardy_days number := null;

  begin
    
    v_sla_days_type := GET_SLA_DAYS_TYPE(p_TASK_TYPE_ID);

    if v_sla_days_type is null
    then
       return 'N';
    end if;
    
    v_age_in_business_days := GET_AGE_IN_BUSINESS_DAYS(p_CURR_WORK_RECEIPT_DATE,p_INSTANCE_END_DATE);
    v_age_in_calendar_days := GET_AGE_IN_CALENDAR_DAYS(p_CURR_WORK_RECEIPT_DATE,p_INSTANCE_END_DATE);
    v_sla_jeopardy_days := GET_JEOPARDY_DAYS(p_TASK_TYPE_ID);

    if (v_sla_days_type = 'B'
        and v_age_in_business_days is not null
        and v_sla_jeopardy_days is not null
        and v_age_in_business_days >= v_sla_jeopardy_days)
     or
       (v_sla_days_type = 'C'
        and v_age_in_calendar_days is not null
        and v_sla_jeopardy_days is not null
        and v_age_in_calendar_days >= v_sla_jeopardy_days)
     then

      return 'Y';
    else
      return 'N';
    end if;

  end;


  function GET_STATUS_AGE_IN_BUS_DAYS
    (p_status_date in date,
     p_INSTANCE_END_DATE in date)
    return number
  as
  begin
     return BPM_COMMON.BUS_DAYS_BETWEEN(p_status_date,nvl(p_INSTANCE_END_DATE,sysdate));
  end;


  function GET_STATUS_AGE_IN_CAL_DAYS
    (p_status_date in date,
     p_INSTANCE_END_DATE in date)
    return number
  as
  begin
    return trunc(nvl(p_INSTANCE_END_DATE,sysdate)) - trunc(p_status_date);
  end;


  function GET_TIMELINESS_STATUS
    (p_INSTANCE_END_DATE in date,
     p_TASK_TYPE_ID in number,
     p_CURR_WORK_RECEIPT_DATE in date)
    return varchar2
  as
    v_sla_days_type        varchar2(1) := null;
    v_sla_days             number := null;
    v_age_in_business_days number := null;
    v_age_in_calendar_days number := null;
    v_sla_jeopardy_days    number := null;

  begin

    v_sla_days_type := GET_SLA_DAYS_TYPE(p_TASK_TYPE_ID);
    v_sla_days := GET_SLA_DAYS(p_TASK_TYPE_ID);
    v_age_in_business_days := GET_AGE_IN_BUSINESS_DAYS(p_CURR_WORK_RECEIPT_DATE,p_INSTANCE_END_DATE);
    v_age_in_calendar_days := GET_AGE_IN_CALENDAR_DAYS(p_CURR_WORK_RECEIPT_DATE,p_INSTANCE_END_DATE);
    v_sla_jeopardy_days := GET_JEOPARDY_DAYS(p_TASK_TYPE_ID);

    if p_INSTANCE_END_DATE is null then
      return 'Not Complete';
    elsif v_sla_days is null then
      return 'Not Required';
    elsif (v_sla_days_type = 'B' and v_age_in_business_days > v_sla_days)
          or
          (v_sla_days_type = 'C' and v_age_in_calendar_days > v_sla_days) then
      return 'Untimely';
    else
      return 'Timely';
    end if;
  end;

  function GET_JEOPARDY_DAYS
    (p_task_type_id in number)
    return number result_cache
  as
  v_jeopardy_days number := null;
  begin
	select sla_jeopardy_days
	  into v_jeopardy_days
	  from d_task_types
	 where task_type_id = p_task_type_id;

	return v_jeopardy_days;
  exception when no_data_found then return null;
  end;

  function GET_SLA_DAYS
    (p_task_type_id in number)
    return number result_cache
  as
  v_sla_days  number := null;
  begin
	select sla_days
	  into v_sla_days
	  from d_task_types
	 where task_type_id = p_task_type_id;

	return v_sla_days;
  exception when no_data_found then return null;
  end;

  function GET_SLA_DAYS_TYPE
    (p_task_type_id in number)
    return varchar2 result_cache
  as
  v_sla_days_type varchar2(1) := null;
  begin
	select sla_days_type
	  into v_sla_days_type
	  from d_task_types
	 where task_type_id = p_task_type_id;

	return v_sla_days_type;
  exception when no_data_found then return null;
  end;


  -- Calculate column values in BPM Semantic table D_MW_V2_CURRENT.
  procedure CALC_DMWCUR_V2
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DMWCUR_V2';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin

    update D_MW_V2_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = GET_AGE_IN_BUSINESS_DAYS(CURR_WORK_RECEIPT_DATE,INSTANCE_END_DATE),
      AGE_IN_CALENDAR_DAYS = GET_AGE_IN_CALENDAR_DAYS(CURR_WORK_RECEIPT_DATE,INSTANCE_END_DATE),
      JEOPARDY_FLAG = GET_JEOPARDY_FLAG(TASK_TYPE_ID,
	                                    CURR_WORK_RECEIPT_DATE,
                                        INSTANCE_END_DATE
                    				   ),
      STATUS_AGE_IN_BUS_DAYS = GET_STATUS_AGE_IN_BUS_DAYS(CURR_STATUS_DATE,INSTANCE_END_DATE),
      STATUS_AGE_IN_CAL_DAYS = GET_STATUS_AGE_IN_CAL_DAYS(CURR_STATUS_DATE,INSTANCE_END_DATE),
      TIMELINESS_STATUS = GET_TIMELINESS_STATUS(
                             INSTANCE_END_DATE,
                             TASK_TYPE_ID,
                             CURR_WORK_RECEIPT_DATE
                             )
    where
       INSTANCE_END_DATE is null
      and CANCEL_WORK_DATE is null;

    v_num_rows_updated := sql%rowcount;

    commit;

    v_log_message := v_num_rows_updated  || ' D_MW_V2_CURRENT rows updated with calculated attributes by CALC_DMWCUR_V2.';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);

  exception

    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);

  end;

   -- Get record for Manage Work insert data.
  procedure GET_INS_MW_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_MW_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_MW_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin

   select
        extractValue(p_data_xml,'/ROWSET/ROW/CANCELLED_BY_STAFF_ID') "CANCELLED_BY_STAFF_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
        extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
        extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_WORK_DATE') "CANCEL_WORK_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/CEMW_ID') "CEMW_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DATE') "COMPLETE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DATE') "CREATE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_STAFF_ID') "CREATED_BY_STAFF_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/ESCALATED_FLAG') "ESCALATED_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/ESCALATED_TO_STAFF_ID') "ESCALATED_TO_STAFF_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED_BY_STAFF_ID') "FORWARDED_BY_STAFF_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED_FLAG') "FORWARDED_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/BUSINESS_UNIT_ID') "BUSINESS_UNIT_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_START_DATE') "INSTANCE_START_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_END_DATE') "INSTANCE_END_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_STAFF_ID') "LAST_UPDATE_BY_STAFF_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_DATE') "LAST_UPDATE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/LAST_EVENT_DATE') "LAST_EVENT_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/OWNER_STAFF_ID') "OWNER_STAFF_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/PARENT_TASK_ID') "PARENT_TASK_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_REFERENCE_ID') "SOURCE_REFERENCE_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_REFERENCE_TYPE') "SOURCE_REFERENCE_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/STATUS_DATE') "STATUS_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/STG_EXTRACT_DATE') "STG_EXTRACT_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/STAGE_DONE_DATE') "STAGE_DONE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/TASK_ID') "TASK_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/TASK_PRIORITY') "TASK_PRIORITY",
        extractValue(p_data_xml,'/ROWSET/ROW/TASK_STATUS') "TASK_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/TASK_TYPE_ID') "TASK_TYPE_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/TEAM_ID') "TEAM_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/UNIT_OF_WORK') "UNIT_OF_WORK",
        extractValue(p_data_xml,'/ROWSET/ROW/WORK_RECEIPT_DATE') "WORK_RECEIPT_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_PROCESS_ID') "SOURCE_PROCESS_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_PROCESS_INSTANCE_ID') "SOURCE_PROCESS_INSTANCE_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL') "CHANNEL",
        extractValue(p_data_xml,'/ROWSET/ROW/RULE_EXECUTED') "RULE_EXECUTED"
    into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
     BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;

  end;


  -- Get record for Manage Work update data XML.
  procedure GET_UPD_MW_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_MW_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_MW_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin

    select
        extractValue(p_data_xml,'/ROWSET/ROW/CANCELLED_BY_STAFF_ID') "CANCELLED_BY_STAFF_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
        extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
        extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_WORK_DATE') "CANCEL_WORK_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DATE') "COMPLETE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DATE') "CREATE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_STAFF_ID') "CREATED_BY_STAFF_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/ESCALATED_FLAG') "ESCALATED_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/ESCALATED_TO_STAFF_ID') "ESCALATED_TO_STAFF_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED_BY_STAFF_ID') "FORWARDED_BY_STAFF_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED_FLAG') "FORWARDED_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/BUSINESS_UNIT_ID') "BUSINESS_UNIT_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_START_DATE') "INSTANCE_START_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_END_DATE') "INSTANCE_END_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_STAFF_ID') "LAST_UPDATE_BY_STAFF_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_DATE') "LAST_UPDATE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/LAST_EVENT_DATE') "LAST_EVENT_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/OWNER_STAFF_ID') "OWNER_STAFF_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/PARENT_TASK_ID') "PARENT_TASK_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_REFERENCE_ID') "SOURCE_REFERENCE_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_REFERENCE_TYPE') "SOURCE_REFERENCE_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/STATUS_DATE') "STATUS_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/STG_EXTRACT_DATE') "STG_EXTRACT_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/STAGE_DONE_DATE') "STAGE_DONE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/TASK_ID') "TASK_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/TASK_PRIORITY') "TASK_PRIORITY",
        extractValue(p_data_xml,'/ROWSET/ROW/TASK_STATUS') "TASK_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/TASK_TYPE_ID') "TASK_TYPE_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/TEAM_ID') "TEAM_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/UNIT_OF_WORK') "UNIT_OF_WORK",
        extractValue(p_data_xml,'/ROWSET/ROW/WORK_RECEIPT_DATE') "WORK_RECEIPT_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_PROCESS_ID') "SOURCE_PROCESS_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_PROCESS_INSTANCE_ID') "SOURCE_PROCESS_INSTANCE_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL') "CHANNEL",
        extractValue(p_data_xml,'/ROWSET/ROW/RULE_EXECUTED') "RULE_EXECUTED"
     into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;

  end;


  -- Insert fact for BPM Semantic model - Manage Work process.
  procedure INS_DMWBD
    (p_identifier in varchar2,
     p_bucket_start_date in date,
     p_bucket_end_date in date,
     p_bi_id in number,
     p_task_status in varchar2,
     p_business_unit_id in varchar2,
     p_team_id in varchar2,
     p_last_update_date in varchar2,
     p_status_date in varchar2,
     p_work_receipt_date in varchar2,
     p_last_event_date in varchar2,
     p_dmwbd_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_DMWBD';
    v_sql_code number := null;
    v_log_message clob := null;

  begin

    p_DMWBD_ID := SEQ_DMWBD_ID.nextval;

    insert into D_MW_V2_HISTORY
      (DMWBD_ID,
       BUCKET_START_DATE,
       BUCKET_END_DATE,
       MW_BI_ID,
       TASK_STATUS,
       BUSINESS_UNIT_ID,
       TEAM_ID,
       LAST_UPDATE_DATE,
       STATUS_DATE,
       WORK_RECEIPT_DATE,
       LAST_EVENT_DATE
       )
    values
      (p_dmwbd_id,
       p_bucket_start_date,
       p_bucket_end_date,
       p_bi_id,
       p_task_status,
       p_business_unit_id,
       p_team_id,
       to_date(p_last_update_date,BPM_COMMON.DATE_FMT),
       to_date(p_status_date,BPM_COMMON.DATE_FMT),
       to_date(p_work_receipt_date,BPM_COMMON.DATE_FMT),
       to_date(p_last_event_date,BPM_COMMON.DATE_FMT)
       );

  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
  end;

  -- Insert or update dimension for BPM Semantic model - Manage Work V2 process - Current.
  procedure SET_DMWCUR
      (p_set_type in varchar2,
       p_identifier in varchar2,
       p_bi_id in number,
       p_cancelled_by_staff_id in varchar2,
       p_cancel_method in varchar2,
       p_cancel_reason in varchar2,
       p_cancel_work_date in varchar2,
       p_case_id in varchar2,
       p_client_id in varchar2,
       p_complete_date in varchar2,
       p_create_date in varchar2,
       p_created_by_staff_id in varchar2,
       p_escalated_flag in varchar2,
       p_escalated_to_staff_id in varchar2,
       p_forwarded_by_staff_id in varchar2,
       p_forwarded_flag in varchar2,
       p_business_unit_id in varchar2,
       p_instance_start_date in varchar2,
       p_instance_end_date in varchar2,
       p_last_update_by_staff_id in varchar2,
       p_last_update_date in varchar2,
       p_last_event_date in varchar2,
       p_owner_staff_id in varchar2,
       p_parent_task_id in varchar2,
       p_source_reference_id in varchar2,
       p_source_reference_type in varchar2,
       p_status_date in varchar2,
       p_stg_extract_date in varchar2,
       p_stg_last_update_date in varchar2,
       p_stage_done_date in varchar2,
       p_task_id in varchar2,
       p_task_priority in varchar2,
       p_task_status in varchar2,
       p_task_type_id in varchar2,
       p_team_id in varchar2,
       p_unit_of_work in varchar2,
       p_work_receipt_date in varchar2,
       p_source_process_id in varchar2,
       p_source_process_instance_id in varchar2,
       p_channel in varchar2,
       p_rule_executed in varchar2
       )
  as

    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DMWCUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dmwcur D_MW_V2_CURRENT%rowtype := null;
    v_dmwcur_rows number := null;

  begin

  r_dmwcur.mw_bi_id                      :=  p_bi_id;
  r_dmwcur.AGE_IN_BUSINESS_DAYS          :=  GET_AGE_IN_BUSINESS_DAYS(to_date(p_WORK_RECEIPT_DATE,BPM_COMMON.DATE_FMT), to_date(p_INSTANCE_END_DATE,BPM_COMMON.DATE_FMT));
  r_dmwcur.AGE_IN_CALENDAR_DAYS          :=  GET_AGE_IN_CALENDAR_DAYS(to_date(p_WORK_RECEIPT_DATE,BPM_COMMON.DATE_FMT), to_date(p_INSTANCE_END_DATE,BPM_COMMON.DATE_FMT));
  r_dmwcur.CANCELLED_BY_STAFF_ID         :=  p_CANCELLED_BY_STAFF_ID;
  r_dmwcur.CANCEL_METHOD                 :=  p_CANCEL_METHOD;
  r_dmwcur.CANCEL_REASON                 :=  p_CANCEL_REASON;
  r_dmwcur.CANCEL_WORK_DATE              :=  to_date(p_CANCEL_WORK_DATE,BPM_COMMON.DATE_FMT);
  r_dmwcur.CASE_ID                       :=  p_CASE_ID;
  r_dmwcur.CLIENT_ID                     :=  p_CLIENT_ID;
  r_dmwcur.COMPLETE_DATE                 :=  to_date(p_COMPLETE_DATE,BPM_COMMON.DATE_FMT);
  r_dmwcur.CREATE_DATE                   :=  to_date(p_CREATE_DATE,BPM_COMMON.DATE_FMT);
  r_dmwcur.CURR_CREATED_BY_STAFF_ID      :=  p_CREATED_BY_STAFF_ID;
  r_dmwcur.ESCALATED_FLAG                :=  p_ESCALATED_FLAG;
  r_dmwcur.CURR_ESCALATED_TO_STAFF_ID    :=  p_ESCALATED_TO_STAFF_ID;
  r_dmwcur.FORWARDED_FLAG                :=  p_FORWARDED_FLAG;
  r_dmwcur.CURR_FORWARDED_BY_STAFF_ID    :=  p_FORWARDED_BY_STAFF_ID;
  r_dmwcur.CURR_BUSINESS_UNIT_ID         :=  p_BUSINESS_UNIT_ID;
  r_dmwcur.INSTANCE_START_DATE           :=  to_date(p_INSTANCE_START_DATE,BPM_COMMON.DATE_FMT);
  r_dmwcur.INSTANCE_END_DATE             :=  to_date(p_INSTANCE_END_DATE,BPM_COMMON.DATE_FMT);
  r_dmwcur.JEOPARDY_FLAG                 :=  GET_JEOPARDY_FLAG(P_TASK_TYPE_ID,
                                                               to_date(P_WORK_RECEIPT_DATE,BPM_COMMON.DATE_FMT),
                                                               to_date(P_INSTANCE_END_DATE,BPM_COMMON.DATE_FMT)
                                                              );
  r_dmwcur.CURR_LAST_UPD_BY_STAFF_ID     :=  p_LAST_UPDATE_BY_STAFF_ID ;
  r_dmwcur.CURR_LAST_UPDATE_DATE         :=  to_date(p_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT);
  r_dmwcur.LAST_EVENT_DATE               :=  to_date(p_LAST_EVENT_DATE,BPM_COMMON.DATE_FMT);
  r_dmwcur.CURR_OWNER_STAFF_ID           :=  p_OWNER_STAFF_ID ;
  r_dmwcur.PARENT_TASK_ID                :=  p_PARENT_TASK_ID ;
  r_dmwcur.SOURCE_REFERENCE_ID           :=  p_SOURCE_REFERENCE_ID ;
  r_dmwcur.SOURCE_REFERENCE_TYPE         :=  p_SOURCE_REFERENCE_TYPE  ;
  r_dmwcur.CURR_STATUS_DATE              :=  to_date(p_STATUS_DATE,BPM_COMMON.DATE_FMT);
  r_dmwcur.STATUS_AGE_IN_BUS_DAYS        :=  GET_STATUS_AGE_IN_BUS_DAYS(to_date(p_status_date,BPM_COMMON.DATE_FMT), to_date(p_INSTANCE_END_DATE,BPM_COMMON.DATE_FMT));
  r_dmwcur.STATUS_AGE_IN_CAL_DAYS        :=  GET_STATUS_AGE_IN_CAL_DAYS(to_date(p_status_date,BPM_COMMON.DATE_FMT), to_date(p_INSTANCE_END_DATE,BPM_COMMON.DATE_FMT));
  r_dmwcur.STG_EXTRACT_DATE              :=  to_date(p_STG_EXTRACT_DATE,BPM_COMMON.DATE_FMT);
  r_dmwcur.STG_LAST_UPDATE_DATE          :=  to_date(p_STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT);
  r_dmwcur.STAGE_DONE_DATE               :=  to_date(p_STAGE_DONE_DATE,BPM_COMMON.DATE_FMT);
  r_dmwcur.TASK_ID                       :=  p_TASK_ID ;
  r_dmwcur.TASK_PRIORITY                 :=  p_TASK_PRIORITY ;
  r_dmwcur.CURR_TASK_STATUS              :=  p_TASK_STATUS ;
  r_dmwcur.TASK_TYPE_ID                  :=  p_TASK_TYPE_ID ;
  r_dmwcur.CURR_TEAM_ID                  :=  p_TEAM_ID  ;
  r_dmwcur.TIMELINESS_STATUS             :=  GET_TIMELINESS_STATUS(
                                                         to_date(p_INSTANCE_END_DATE,BPM_COMMON.DATE_FMT),
                                                         p_TASK_TYPE_ID,
                                                         to_date(p_WORK_RECEIPT_DATE,BPM_COMMON.DATE_FMT)
                                                         );
  r_dmwcur.UNIT_OF_WORK                  :=  p_UNIT_OF_WORK  ;
  r_dmwcur.CURR_WORK_RECEIPT_DATE        :=  to_date(p_WORK_RECEIPT_DATE,BPM_COMMON.DATE_FMT);
  r_dmwcur.SOURCE_PROCESS_ID             :=  p_source_process_id;
  r_dmwcur.SOURCE_PROCESS_INSTANCE_ID    :=  p_source_process_instance_id;
  r_dmwcur.CHANNEL                       :=  p_channel; 
  r_dmwcur.RULE_EXECUTED                 :=  p_rule_executed;

    if p_set_type = 'INSERT' then
      insert into D_MW_V2_CURRENT
      values r_dmwcur;
    elsif p_set_type = 'UPDATE' then
      update D_MW_V2_CURRENT
      set row = r_dmwcur
      where MW_BI_ID = p_bi_id;
    else
      v_log_message := 'Unexpected p_set_type value "' || p_set_type || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(-20001,v_log_message);
    end if;

  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
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
    v_new_data T_INS_MW_XML := null;
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
    v_bucket_start_date date := null;
    v_bucket_end_date date := null;
    v_dmwbd_id number := null;

  begin

    if p_data_version != 3
    then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Manage Work V2 in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;

    GET_INS_MW_XML(p_new_data_xml,v_new_data);
  	v_identifier := v_new_data.TASK_ID;
    v_BUCKET_START_DATE := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_bi_id := SEQ_BI_ID.nextval;
    v_identifier := v_new_data.TASK_ID;

    -- Insert current dimension and fact as a single transaction.
    begin

      SET_DMWCUR
        ('INSERT',
         v_identifier,
         v_bi_id,
         v_new_data.CANCELLED_BY_STAFF_ID,
         v_new_data.CANCEL_METHOD,
         v_new_data.CANCEL_REASON,
         v_new_data.CANCEL_WORK_DATE,
         v_new_data.CASE_ID,
         v_new_data.CLIENT_ID,
         v_new_data.COMPLETE_DATE,
         v_new_data.CREATE_DATE,
         v_new_data.CREATED_BY_STAFF_ID,
         v_new_data.ESCALATED_FLAG,
         v_new_data.ESCALATED_TO_STAFF_ID,
         v_new_data.FORWARDED_BY_STAFF_ID,
         v_new_data.FORWARDED_FLAG,
         v_new_data.BUSINESS_UNIT_ID,
         v_new_data.INSTANCE_START_DATE,
         v_new_data.INSTANCE_END_DATE,
         v_new_data.LAST_UPDATE_BY_STAFF_ID,
         v_new_data.LAST_UPDATE_DATE,
         v_new_data.LAST_EVENT_DATE,
         v_new_data.OWNER_STAFF_ID,
         v_new_data.PARENT_TASK_ID,
         v_new_data.SOURCE_REFERENCE_ID,
         v_new_data.SOURCE_REFERENCE_TYPE,
         v_new_data.STATUS_DATE,
         v_new_data.STG_EXTRACT_DATE,
         v_new_data.STG_LAST_UPDATE_DATE,
         v_new_data.STAGE_DONE_DATE,
         v_new_data.TASK_ID,
         v_new_data.TASK_PRIORITY,
         v_new_data.TASK_STATUS,
         v_new_data.TASK_TYPE_ID,
         v_new_data.TEAM_ID,
         v_new_data.UNIT_OF_WORK,
         v_new_data.WORK_RECEIPT_DATE,
         v_new_data.SOURCE_PROCESS_ID,
         v_new_data.SOURCE_PROCESS_INSTANCE_ID,
         v_new_data.CHANNEL,
         v_new_data.RULE_EXECUTED
         );

      INS_DMWBD(v_identifier,
              v_bucket_start_date,
              v_bucket_end_date,
              v_bi_id,
              v_new_data.TASK_STATUS,
              v_new_data.BUSINESS_UNIT_ID,
              v_new_data.TEAM_ID,
              v_new_data.LAST_UPDATE_DATE,
              v_new_data.STATUS_DATE,
              v_new_data.WORK_RECEIPT_DATE,
              v_new_data.LAST_EVENT_DATE,
              v_dmwbd_id);

      commit;

    exception

      when OTHERS then
        rollback;
        v_sql_code := SQLCODE;
        v_log_message := 'Rolled back initial insert for current dimension and fact.  ' || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);
        raise;

    end;

  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);
      raise;

  end;


-- Update history for BPM Semantic model - Manage Work V2 process.
  procedure UPD_DMWBD
    (p_identifier in number,
     p_start_date in varchar2,
     p_end_date in varchar2,
     p_bi_id in number,
     p_task_status in varchar2,
     p_business_unit_id in number,
     p_team_id in number,
     p_last_update_date in varchar2,
     p_status_date in varchar2,
     p_work_receipt_date in varchar2,
     p_last_event_date in varchar2,
     p_dmwbd_id out number)
  as

    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_DMWBD';
    v_sql_code number := null;
    v_log_message clob := null;

   v_identifier number := null;
   v_bi_id number := null;
   v_max_last_event_date date :=null;
   v_last_event_date_current date := null;
   v_dmwbd_id number := null;
   v_last_event_date date := null;

   v_dmwbd_id_old number := null;
   v_bucket_start_date_old date := null;
   v_bucket_end_date_old date := null;
   v_mw_bi_id_old number := null;
   v_task_status_old varchar2(32) := null;
   v_business_unit_id_old number := null;
   v_team_id_old number := null;
   v_last_update_date_old date := null;
   v_status_date_old date := null;
   v_work_receipt_date_old date := null;
   v_last_event_date_old date := null;

   v_last_update_date  date := null;
   v_status_date  date := null;
   v_work_receipt_date  date := null;
   v_max_dmwbd_id date := null;


   r_DMWBD D_MW_V2_HISTORY%rowtype := null;

  begin

   v_identifier := p_identifier;
   v_bi_id := p_bi_id;
   v_DMWBD_id  := p_DMWBD_id;
   v_last_event_date := to_date(p_last_event_date,BPM_COMMON.DATE_FMT);
   v_last_update_date := to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
   v_status_date := to_date(p_status_date,BPM_COMMON.DATE_FMT);
   v_work_receipt_date := to_date(p_work_receipt_date,BPM_COMMON.DATE_FMT);

  with most_recent_hist_bi_id as (
   select
    max(DMWBD_ID) MAX_DMWBD_ID,
    max(LAST_EVENT_DATE) MAX_LAST_EVENT_DATE
   from D_MW_V2_HISTORY
  where MW_BI_ID = P_BI_ID)
   select
      most_recent_hist_bi_id.MAX_DMWBD_ID,
      most_recent_hist_bi_id.MAX_LAST_EVENT_DATE,
      h.BUCKET_START_DATE,
      h.BUCKET_END_DATE,
      h.TASK_STATUS,
      h.BUSINESS_UNIT_ID,
	    h.TEAM_ID,
	    h.LAST_UPDATE_DATE,
	    h.STATUS_DATE,
	    h.WORK_RECEIPT_DATE
   into
        v_DMWBD_ID_old,
        v_LAST_EVENT_DATE_old,
        v_bucket_start_date_old,
        v_bucket_end_date_old,
        v_TASK_STATUS_old,
    	  v_BUSINESS_UNIT_ID_old,
    	  v_TEAM_ID_old,
    	  v_LAST_UPDATE_DATE_old,
    	  v_STATUS_DATE_old,
    	  v_WORK_RECEIPT_DATE_old
   from D_MW_V2_HISTORY h,
        most_recent_hist_bi_id
   where h.DMWBD_ID = MAX_DMWBD_ID
     and h.LAST_EVENT_DATE = MAX_LAST_EVENT_DATE;

   select LAST_EVENT_DATE
    into  V_LAST_EVENT_DATE_CURRENT
   from D_MW_V2_HISTORY
   where DMWBD_ID = V_DMWBD_ID_OLD;

--Validate last_event_date with specific DMFDBD_ID
   if(v_LAST_EVENT_DATE_old != v_last_event_date_current) then
        v_sql_code := -20030;
        v_log_message := 'MAX(LAST_EVENT_DATE) is not equal to the LAST_EVENT_DATE of MAX(DMWBD_ID). ' || ' LAST_EVENT_DATE = ' || to_char(v_last_event_date,v_date_bucket_fmt) || ' MAX_LAST_EVENT_DATE = ' || to_char
       (v_last_event_date_old,v_date_bucket_fmt) || 'MAX(DMWBD_ID) = '||v_DMWBD_ID_old;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
        RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
   end if;

-- Continues updates
--If same day update then set the bucket start date to minimum date and bucket end date to max date
   if trunc(v_last_event_date) = trunc(v_last_event_date_old)
     and v_bucket_start_date_old = to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt)
	 then r_dmwbd.BUCKET_START_DATE := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
   elsif trunc(v_last_event_date) = trunc(v_last_event_date_old)
      and v_bucket_start_date_old != to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt)
	  then  r_dmwbd.BUCKET_START_DATE := v_bucket_start_date_old;
   elsif trunc(v_last_event_date) > trunc(v_last_event_date_old)
     then r_dmwbd.BUCKET_START_DATE := trunc(v_last_event_date);
   end if;

   r_dmwbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
   p_DMWBD_id := SEQ_DMWBD_ID.nextval;
   r_dmwbd.DMWBD_ID := p_DMWBD_id;
   r_dmwbd.MW_BI_ID := p_bi_id;
   r_dmwbd.task_status := p_task_status;
   r_dmwbd.business_unit_id := p_business_unit_id;
   r_dmwbd.team_id := p_team_id;
   r_dmwbd.last_event_date := v_last_event_date;
   r_dmwbd.last_update_date := v_last_update_date;
   r_dmwbd.status_date := v_status_date;
   r_dmwbd.work_receipt_date := v_work_receipt_date;

     if trunc(v_last_event_date) > trunc(v_last_event_date_old) and
        (v_task_status_old <> r_dmwbd.task_status or
         v_business_unit_id_old <> r_dmwbd.business_unit_id or
         v_team_id_old <> r_dmwbd.team_id or
         v_last_update_date_old <> r_dmwbd.last_update_date or
         v_status_date_old <> r_dmwbd.status_date or
         v_work_receipt_date_old <> r_dmwbd.work_receipt_date) then

		update D_MW_V2_HISTORY
        set BUCKET_END_DATE = trunc(v_last_event_date) - 1
        where DMWBD_ID = v_DMWBD_id_old;

        insert into D_MW_V2_HISTORY
        values r_DMWBD;

     end if;

     if trunc(v_last_event_date) = trunc(v_last_event_date_old) and
        (v_task_status_old <> r_dmwbd.task_status or
         v_business_unit_id_old <> r_dmwbd.business_unit_id or
         v_team_id_old <> r_dmwbd.team_id or
         v_last_update_date_old <> r_dmwbd.last_update_date or
         v_status_date_old <> r_dmwbd.status_date or
         v_work_receipt_date_old <> r_dmwbd.work_receipt_date) then

        update D_MW_V2_HISTORY
        set row = r_dmwbd
        where DMWBD_ID = v_DMWBD_id_old;

     end if;

--validate LAST EVENT DATE
     if trunc(v_last_event_date) < trunc(v_last_event_date_old) then
        v_sql_code := -20030;
        v_log_message := 'Attempted to insert invalid date range.  ' || ' LAST_EVENT_DATE = ' || to_char(v_last_event_date,v_date_bucket_fmt) || ' MAX_LAST_EVENT_DATE = ' || to_char
(v_last_event_date_old,v_date_bucket_fmt);
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
        RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
     end if;

     -- Validate fact date ranges.
    if r_dmwbd.BUCKET_START_DATE > r_dmwbd.BUCKET_END_DATE
      or r_dmwbd.BUCKET_END_DATE < r_dmwbd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid date range.  ' ||
        ' BUCKET_START_DATE = ' || to_char(r_dmwbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_dmwbd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;

    exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM ||
        ' BUCKET_START_DATE = ' || to_char(r_dmwbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_dmwbd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);
    raise;

  end UPD_DMWBD;

 -- Update BPM Semantic model data.
  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype)
  as

    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';
    v_sql_code number := null;
    v_log_message clob := null;
    v_old_data T_UPD_MW_XML := null;
    v_new_data T_UPD_MW_XML := null;
    v_bi_id number := null;
    v_identifier number := null;
    v_dmwbd_id number := null;
    v_bucket_start_date date := null;
    v_bucket_end_date date := null;


  begin

    if p_data_version != 3 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Manage Work V2 procedure ' || v_procedure_name ||'.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;

	  GET_UPD_MW_XML(p_old_data_xml,v_old_data);
    GET_UPD_MW_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.TASK_ID;
    v_bucket_start_date := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);

	select MW_BI_ID
    into v_bi_id
    from D_MW_V2_CURRENT
    where TASK_ID = v_identifier;

begin
     SET_DMWCUR
        ('UPDATE',
		     v_identifier,
		     v_bi_id,
         v_new_data.CANCELLED_BY_STAFF_ID,
    		 v_new_data.CANCEL_METHOD,
    		 v_new_data.CANCEL_REASON,
    		 v_new_data.CANCEL_WORK_DATE,
         v_new_data.CASE_ID,
    		 v_new_data.CLIENT_ID,
    		 v_new_data.COMPLETE_DATE,
    		 v_new_data.CREATE_DATE,
         v_new_data.CREATED_BY_STAFF_ID,
    		 v_new_data.ESCALATED_FLAG,
    		 v_new_data.ESCALATED_TO_STAFF_ID,
         v_new_data.FORWARDED_BY_STAFF_ID,
    		 v_new_data.FORWARDED_FLAG,
    		 v_new_data.BUSINESS_UNIT_ID,
         v_new_data.INSTANCE_START_DATE,
    		 v_new_data.INSTANCE_END_DATE,
    		 v_new_data.LAST_UPDATE_BY_STAFF_ID,
    		 v_new_data.LAST_UPDATE_DATE,
    		 v_new_data.LAST_EVENT_DATE,
         v_new_data.OWNER_STAFF_ID,
    		 v_new_data.PARENT_TASK_ID,
    		 v_new_data.SOURCE_REFERENCE_ID,
    		 v_new_data.SOURCE_REFERENCE_TYPE,
    		 v_new_data.STATUS_DATE,
    		 v_new_data.STG_EXTRACT_DATE,
    		 v_new_data.STG_LAST_UPDATE_DATE,
    		 v_new_data.STAGE_DONE_DATE,
    		 v_new_data.TASK_ID,
    		 v_new_data.TASK_PRIORITY,
    		 v_new_data.TASK_STATUS,
    		 v_new_data.TASK_TYPE_ID,
    		 v_new_data.TEAM_ID,
    		 v_new_data.UNIT_OF_WORK,
    		 v_new_data.WORK_RECEIPT_DATE,
         v_new_data.SOURCE_PROCESS_ID,
         v_new_data.SOURCE_PROCESS_INSTANCE_ID,
		 v_new_data.CHANNEL,
		 v_new_data.RULE_EXECUTED
         );

      UPD_DMWBD(v_identifier,
	              v_bucket_start_date,
			          v_bucket_end_date,
				        v_bi_id,
				        v_new_data.TASK_STATUS,
				        v_new_data.BUSINESS_UNIT_ID,
				        v_new_data.TEAM_ID,
			          v_new_data.LAST_UPDATE_DATE,
				        v_new_data.STATUS_DATE,
				        v_new_data.WORK_RECEIPT_DATE,
				        v_new_data.LAST_EVENT_DATE,
				        v_dmwbd_id);

      commit;

  exception
   when OTHERS then
   rollback;
    v_sql_code := SQLCODE;
    v_log_message := 'Rolled back latest current dimension and fact changes.'  || SQLERRM ||
        ' BUCKET_START_DATE = ' || to_char(v_bucket_start_date,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(v_bucket_end_date,v_date_bucket_fmt);
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);
   raise;
  end;

  exception
   when NO_DATA_FOUND then
    v_sql_code := SQLCODE;
    v_log_message := 'No BPM_INSTANCE found.'|| SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);
  raise;

   when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM || ' BUCKET_START_DATE = ' || to_char(v_bucket_start_date,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(v_bucket_end_date,v_date_bucket_fmt);
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);
   raise;

  end UPDATE_BPM_SEMANTIC;

end;
/
