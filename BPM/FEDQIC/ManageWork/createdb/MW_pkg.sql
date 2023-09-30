alter session set plsql_code_type = native;

create or replace package MW as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/FEDQIC/ManageWork/createdb/MW_pkg.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 21871 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2017-12-04 17:23:19 -0500 (Mon, 04 Dec 2017) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: gt83345 $';

  procedure CALC_DMWCUR;
  procedure UPDATE_APPEAL_TASKS_BY_DAY_COUNTS;
  procedure INSERT_NEW_ROWS_APPEAL_TASKS_BY_DAY_COUNTS;

  function GET_AGE_IN_BUSINESS_DAYS
    (p_WORK_RECEIPT_DATE in date,
     p_INSTANCE_END_DATE in date)
    return number parallel_enable;

 function GET_TASK_CLAIMED_TIME
    (p_CURR_CLAIM_DATE in date,
     p_INSTANCE_END_DATE in date)
    return number parallel_enable;


 function GET_TASK_UNCLAIMED_TIME
    (p_CREATE_DATE in date,
     p_CURR_CLAIM_DATE in date)
    return number parallel_enable;

  function GET_AGE_IN_CALENDAR_DAYS
    (p_WORK_RECEIPT_DATE in date,
     p_INSTANCE_END_DATE in date)
    return number parallel_enable;

  function GET_JEOPARDY_FLAG
    (
     p_TASK_TYPE_ID in number,
     p_CURR_WORK_RECEIPT_DATE in date,
     p_INSTANCE_END_DATE in date)
    return varchar2 parallel_enable;

  function GET_STATUS_AGE_IN_BUS_DAYS
    (p_status_date in date,
     p_INSTANCE_END_DATE in date)
    return number parallel_enable;

  function GET_STATUS_AGE_IN_CAL_DAYS
    (p_status_date in date,
     p_INSTANCE_END_DATE in date)
    return number parallel_enable;

 function GET_TIMELINESS_STATUS
    (p_INSTANCE_END_DATE in date,
     p_TASK_TYPE_ID in number,
     p_CURR_WORK_RECEIPT_DATE in date)
    return varchar2 parallel_enable;

	function GET_JEOPARDY_DAYS
    (p_task_type_id in number)
    return number parallel_enable result_cache;

  function GET_JEOPARDY_DAYS_APPEAL
    (p_part in number,
     p_appeal_priority_key in number,
     p_appeal_config_type in number		
    )
    return number parallel_enable result_cache;

  function GET_JEOPARDY_DAYS_APPEAL_TT
  	(p_task_type_id in number,
     	p_part in number,
     	p_appeal_priority_key in number,
     	p_appeal_config_type in number		
    	)
    return number parallel_enable result_cache;

    function GET_SLA_DAYS
    (p_task_type_id in number)
    return number parallel_enable result_cache;

  function GET_SLA_DAYS_APPEAL
    (p_part in number,
     p_appeal_priority_key in number,
     p_appeal_config_type in number		
    )
    return number parallel_enable result_cache;

function GET_SLA_DAYS_APPEAL_TT
    (p_task_type_id in number,
     p_part in number,
     p_appeal_priority_key in number,
     p_appeal_config_type in number		
    )
    return number parallel_enable result_cache;

  function GET_SLA_DAYS_TYPE
    (p_task_type_id in number)
    return varchar2 parallel_enable result_cache;

  function BUS_HOURS_BETWEEN
    (p_start_date in date,
     p_end_date in date)
    return number parallel_enable;

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
  CEMW_ID		     varchar2(100),
  CLIENT_ID                  varchar2(100),
  COMPLETE_DATE              varchar2(19),
  CREATE_DATE                varchar2(19),
  CREATED_BY_STAFF_ID	     varchar2(100),
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
  OWNER_STAFF_ID	     varchar2(100),
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
  CLAIM_DATE		     varchar2(19),
  ROLE			     varchar2(50),
  PART			     varchar2(255),
  RECEIVED_DATE		     varchar2(19),
  APPEAL_STAGE 		     varchar2(100),
  PREVIOUS_TASK_TYPE_ID      varchar2(100),
  NON_STANDARD_WORK_FLAG     varchar2(1),
  HANDLE_TIME                varchar2(100)	
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
  CREATED_BY_STAFF_ID	     varchar2(100),
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
  OWNER_STAFF_ID	     varchar2(100),
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
  CLAIM_DATE		     varchar2(19),
  ROLE			     varchar2(50),
  PART			     varchar2(255),
  RECEIVED_DATE		     varchar2(19),
  APPEAL_STAGE 		     varchar2(100),
  PREVIOUS_TASK_TYPE_ID      varchar2(100),
  NON_STANDARD_WORK_FLAG     varchar2(1),
  HANDLE_TIME                varchar2(100)		
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
create or replace package body MW as
  g_Error   VARCHAR2(4000);
  v_bem_id number := 42; -- 'Federal QIC'
  v_bil_id number := 3; -- 'Task ID'
  v_bsl_id number := 2003; -- 'FEDQIC_ETL'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';

  v_calc_dnpacur_job_name varchar2(30) := 'CALC_DNPACUR';

  function GET_AGE_IN_BUSINESS_DAYS
    (p_WORK_RECEIPT_DATE in date,
     p_INSTANCE_END_DATE in date)
    return number parallel_enable
  as
  begin
     return BPM_COMMON.BUS_DAYS_BETWEEN(p_WORK_RECEIPT_DATE,nvl(p_INSTANCE_END_DATE,sysdate));
  end;

 function GET_TASK_CLAIMED_TIME
    (p_CURR_CLAIM_DATE in date,
     p_INSTANCE_END_DATE in date)
    return number parallel_enable
  as
  begin
--     return BUS_HOURS_BETWEEN(p_CURR_CLAIM_DATE,nvl(p_INSTANCE_END_DATE,sysdate));
return (nvl(p_INSTANCE_END_DATE,sysdate) - p_CURR_CLAIM_DATE)*24; 
  end;

 function GET_TASK_UNCLAIMED_TIME
    (p_CREATE_DATE in date,
     p_CURR_CLAIM_DATE in date)
    return number parallel_enable
  as
  begin
--     return BUS_HOURS_BETWEEN(p_CREATE_DATE,nvl(p_CURR_CLAIM_DATE,sysdate));
return (nvl(p_CURR_CLAIM_DATE,sysdate) - p_CREATE_DATE)*24;
  end;

  function GET_AGE_IN_CALENDAR_DAYS
    (p_WORK_RECEIPT_DATE in date,
     p_INSTANCE_END_DATE in date)
    return number parallel_enable
  as
  begin
    return trunc(nvl(p_INSTANCE_END_DATE,sysdate)) - trunc(p_WORK_RECEIPT_DATE);
  end;


  function GET_JEOPARDY_FLAG
    (
     p_TASK_TYPE_ID in number,
     p_CURR_WORK_RECEIPT_DATE in date,
     p_INSTANCE_END_DATE in date)
    return varchar2 parallel_enable
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
    return number parallel_enable
  as
  begin
  if p_INSTANCE_END_DATE is not null
  then
	return 0;
  end if;

     return BPM_COMMON.BUS_DAYS_BETWEEN(p_status_date,nvl(p_INSTANCE_END_DATE,sysdate));
  end;

  function GET_STATUS_AGE_IN_CAL_DAYS
    (p_status_date in date,
     p_INSTANCE_END_DATE in date)
    return number parallel_enable
  as
  begin
	if p_INSTANCE_END_DATE is not null
	then
	return 0;
	end if;
    return trunc(nvl(p_INSTANCE_END_DATE,sysdate)) - trunc(p_status_date);
  end;


  function GET_TIMELINESS_STATUS
    (p_INSTANCE_END_DATE in date,
     p_TASK_TYPE_ID in number,
     p_CURR_WORK_RECEIPT_DATE in date)
    return varchar2 parallel_enable
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
    return number parallel_enable result_cache
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

  function GET_JEOPARDY_DAYS_APPEAL
    (p_part in number,
     p_appeal_priority_key in number,
     p_appeal_config_type in number		
    )
    return number parallel_enable result_cache
  as
  v_jeopardy_days number := null;
  begin
	select sla_jeopardy_days
	  into v_jeopardy_days
	  from C_MW_APPEALS_TIMELINESS_CONFIG
	where task_type_id is null
	and part_id = p_part
	and appeal_priority_id = p_appeal_priority_key
	and appeal_config_type_id = p_appeal_config_type;

	return v_jeopardy_days;
  exception when no_data_found then return null;
  end;

  function GET_JEOPARDY_DAYS_APPEAL_TT
  	(p_task_type_id in number,
     	p_part in number,
     	p_appeal_priority_key in number,
     	p_appeal_config_type in number		
    	)
    return number parallel_enable result_cache
  as
  v_jeopardy_days number := null;
  begin
	select sla_jeopardy_days
	  into v_jeopardy_days
	  from C_MW_APPEALS_TIMELINESS_CONFIG
	where task_type_id = p_task_type_id
	and part_id = p_part
	and appeal_priority_id = p_appeal_priority_key
	and appeal_config_type_id = p_appeal_config_type;


	return v_jeopardy_days;
  exception when no_data_found then return null;
  end;


  function GET_SLA_DAYS
    (p_task_type_id in number)
    return number parallel_enable result_cache
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

  function GET_SLA_DAYS_APPEAL
    (p_part in number,
     p_appeal_priority_key in number,
     p_appeal_config_type in number		
    )
    return number parallel_enable result_cache
  as
  v_sla_days  number := null;
  begin
	select sla_days
	  into v_sla_days
	  from C_MW_APPEALS_TIMELINESS_CONFIG
	where task_type_id is null
	and part_id = p_part
	and appeal_priority_id = p_appeal_priority_key
	and appeal_config_type_id = p_appeal_config_type;

	return v_sla_days;
  exception when no_data_found then return null;
  end;

function GET_SLA_DAYS_APPEAL_TT
    (p_task_type_id in number,
     p_part in number,
     p_appeal_priority_key in number,
     p_appeal_config_type in number		
    )
    return number parallel_enable result_cache
  as
  v_sla_days  number := null;
  begin
	select sla_days
	  into v_sla_days
	  from C_MW_APPEALS_TIMELINESS_CONFIG
	where task_type_id = p_task_type_id
	and part_id = p_part
	and appeal_priority_id = p_appeal_priority_key
	and appeal_config_type_id = p_appeal_config_type;

	return v_sla_days;
  exception when no_data_found then return null;
  end;

  function BUS_HOURS_BETWEEN
    (p_start_date in date,
     p_end_date in date)
    return number parallel_enable
  as
    v_num_days number := 0;
    v_from_date date := null;
    v_to_date date := null;
    v_bus_hours number := 0; 
  begin
  
    v_from_date := p_start_date;
    v_to_date := p_end_date;
  
    with date_tab as
      (select v_from_date + level - 1 business_date
       from dual
       connect by level <= v_to_date - v_from_date + 1)
    select /*+ RESULT_CACHE +*/ count(business_date) - 1 
    into v_num_days
    from date_tab
    where
      to_char(business_date,'DY') not in ('SUN')
      and business_date not in 
        (select HOLIDAY_DATE 
         from HOLIDAYS 
         where HOLIDAY_DATE between v_from_date and v_to_date);
  
    if v_num_days < 0 then
      v_num_days := 0;
    end if;
    
    v_bus_hours := (24*( (v_to_date - trunc(v_to_date)) - (v_from_date - trunc(v_from_date)) )); 
    if v_bus_hours < 0 then
        v_bus_hours := v_bus_hours + 24;
    end if;
    v_bus_hours := v_bus_hours + (v_num_days*24);

    return v_bus_hours;    
    
  end;


  function GET_SLA_DAYS_TYPE
    (p_task_type_id in number)
    return varchar2 parallel_enable result_cache
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


  -- Calculate column values in BPM Semantic table D_MW_TASK_INSTANCE.
  procedure CALC_DMWCUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DMWCUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin

    update D_MW_TASK_INSTANCE
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
                             ),
     TASK_CLAIMED_TIME = GET_TASK_CLAIMED_TIME(CURR_CLAIM_DATE,INSTANCE_END_DATE),
     TASK_UNCLAIMED_TIME = GET_TASK_UNCLAIMED_TIME(CREATE_DATE,COALESCE(CURR_CLAIM_DATE,INSTANCE_END_DATE))
     
    where
       INSTANCE_END_DATE is null
      and CANCEL_WORK_DATE is null;

    v_num_rows_updated := sql%rowcount;

    commit;

    v_log_message := v_num_rows_updated  || ' D_MW_TASK_INSTANCE rows updated with calculated attributes by CALC_DMWCUR.';
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

	extractValue(p_data_xml,'/ROWSET/ROW/CLAIM_DATE') "CLAIM_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/ROLE') "ROLE",
	extractValue(p_data_xml,'/ROWSET/ROW/PART') "PART",
	extractValue(p_data_xml,'/ROWSET/ROW/RECEIVED_DATE') "RECEIVED_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_STAGE') "APPEAL_STAGE",
	extractValue(p_data_xml,'/ROWSET/ROW/PREVIOUS_TASK_TYPE_ID') "PREVIOUS_TASK_TYPE_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/NON_STANDARD_WORK_FLAG') "NON_STANDARD_WORK_FLAG",
	extractValue(p_data_xml,'/ROWSET/ROW/HANDLE_TIME') "HANDLE_TIME"	
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

        extractValue(p_data_xml,'/ROWSET/ROW/CLAIM_DATE') "CLAIM_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/ROLE') "ROLE",
        extractValue(p_data_xml,'/ROWSET/ROW/PART') "PART",
        extractValue(p_data_xml,'/ROWSET/ROW/RECEIVED_DATE') "RECEIVED_DATE",
	extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_STAGE') "APPEAL_STAGE",
	extractValue(p_data_xml,'/ROWSET/ROW/PREVIOUS_TASK_TYPE_ID') "PREVIOUS_TASK_TYPE_ID",
	extractValue(p_data_xml,'/ROWSET/ROW/NON_STANDARD_WORK_FLAG') "NON_STANDARD_WORK_FLAG",
	extractValue(p_data_xml,'/ROWSET/ROW/HANDLE_TIME') "HANDLE_TIME"
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
     p_claim_date in varchar2,
     p_appeal_stage in varchar2,
     p_dmwbd_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_DMWBD';
    v_sql_code number := null;
    v_log_message clob := null;

  begin

    p_DMWBD_ID := SEQ_DMWBD_ID.nextval;

    insert into D_MW_TASK_HISTORY
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
	   LAST_EVENT_DATE,
	CLAIM_DATE,
        APPEAL_STAGE
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
	   to_date(p_last_event_date,BPM_COMMON.DATE_FMT),
	   to_date(p_claim_date,BPM_COMMON.DATE_FMT),
        to_number(p_appeal_stage)
	   );

  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
  end;

  -- Insert or update dimension for BPM Semantic model - MW process - Current.
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

	p_claim_date in varchar2,
	p_role in varchar2,
	p_part in varchar2,
	p_received_date in varchar2,
	p_appeal_stage in varchar2,
	p_previous_task_type_id in varchar2,
	p_non_standard_work_flag in varchar2,
	p_handle_time in varchar2
       )
  as

    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DMWCUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dmwcur D_MW_TASK_INSTANCE%rowtype := null;
    v_dmwcur_rows number := null;

  begin

  r_dmwcur.mw_bi_id                      :=  p_bi_id;
  r_dmwcur.AGE_IN_BUSINESS_DAYS          :=  GET_AGE_IN_BUSINESS_DAYS(to_date(p_WORK_RECEIPT_DATE,BPM_COMMON.DATE_FMT), to_date(p_INSTANCE_END_DATE,BPM_COMMON.DATE_FMT));
  r_dmwcur.AGE_IN_CALENDAR_DAYS          :=  GET_AGE_IN_CALENDAR_DAYS(to_date(p_WORK_RECEIPT_DATE,BPM_COMMON.DATE_FMT), to_date(p_INSTANCE_END_DATE,BPM_COMMON.DATE_FMT));

  r_dmwcur.TASK_CLAIMED_TIME     	 :=  GET_TASK_CLAIMED_TIME(to_date(p_CLAIM_DATE,BPM_COMMON.DATE_FMT),to_date(p_INSTANCE_END_DATE,BPM_COMMON.DATE_FMT));
  r_dmwcur.TASK_UNCLAIMED_TIME     	 :=  GET_TASK_UNCLAIMED_TIME(to_date(p_CREATE_DATE,BPM_COMMON.DATE_FMT),COALESCE(to_date(p_CLAIM_DATE,BPM_COMMON.DATE_FMT),to_date(p_INSTANCE_END_DATE,BPM_COMMON.DATE_FMT) ));

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

  r_dmwcur.CURR_CLAIM_DATE    		 :=  to_date(p_CLAIM_DATE,BPM_COMMON.DATE_FMT);
  r_dmwcur.ROLE                  	 :=  p_ROLE  ;
  r_dmwcur.PART                  	 :=  p_PART  ;
  r_dmwcur.RECEIVED_DATE    		 :=  to_date(p_RECEIVED_DATE,BPM_COMMON.DATE_FMT);

  r_dmwcur.APPEAL_STAGE                  :=  p_APPEAL_STAGE  ;
  r_dmwcur.PREVIOUS_TASK_TYPE_ID         :=  p_PREVIOUS_TASK_TYPE_ID  ;
  r_dmwcur.NON_STANDARD_WORK_FLAG        :=  p_NON_STANDARD_WORK_FLAG  ;
  r_dmwcur.HANDLE_TIME                   :=  p_HANDLE_TIME  ;


    if p_set_type = 'INSERT' then
      insert into D_MW_TASK_INSTANCE
      values r_dmwcur;
    elsif p_set_type = 'UPDATE' then
      update D_MW_TASK_INSTANCE
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
  DBMS_OUTPUT.put_line('in MW.INSERT_BPM_SEMANTIC...');
    if p_data_version != 3
    then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for MW in procedure ' || v_procedure_name || '.';
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
         
	 v_new_data.CLAIM_DATE,
         v_new_data.ROLE,
         v_new_data.PART,
         v_new_data.RECEIVED_DATE,
	 v_new_data.APPEAL_STAGE,
	 v_new_data.PREVIOUS_TASK_TYPE_ID,
	 v_new_data.NON_STANDARD_WORK_FLAG,
	 v_new_data.HANDLE_TIME
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
					v_new_data.CLAIM_DATE,
					v_new_data.APPEAL_STAGE,
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
     p_claim_date in varchar2,
     p_appeal_stage in varchar2,
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
   v_claim_date date :=null;
   v_appeal_stage number := null;

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
   v_claim_date_old date :=null;
   v_appeal_stage_old number := null;

   v_last_update_date  date := null;
   v_status_date  date := null;
   v_work_receipt_date  date := null;
   v_max_dmwbd_id date := null;


   r_DMWBD D_MW_TASK_HISTORY%rowtype := null;

  begin

   v_identifier := p_identifier;
   v_bi_id := p_bi_id;
   v_DMWBD_id  := p_DMWBD_id;
   v_last_event_date := to_date(p_last_event_date,BPM_COMMON.DATE_FMT);
   v_last_update_date := to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
   v_status_date := to_date(p_status_date,BPM_COMMON.DATE_FMT);
   v_work_receipt_date := to_date(p_work_receipt_date,BPM_COMMON.DATE_FMT);
   v_claim_date :=to_date(p_claim_date,BPM_COMMON.DATE_FMT); 
   v_appeal_stage := to_number(p_appeal_stage);

  with most_recent_hist_bi_id as (
   select
    max(DMWBD_ID) MAX_DMWBD_ID,
    max(LAST_EVENT_DATE) MAX_LAST_EVENT_DATE
   from D_MW_TASK_HISTORY
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
	    h.WORK_RECEIPT_DATE,
	    h.CLAIM_DATE,
            h.APPEAL_STAGE
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
    	  v_WORK_RECEIPT_DATE_old,
          v_CLAIM_DATE_old,
          v_appeal_stage_old
   from D_MW_TASK_HISTORY h,
        most_recent_hist_bi_id
   where h.DMWBD_ID = MAX_DMWBD_ID
     and h.LAST_EVENT_DATE = MAX_LAST_EVENT_DATE;

   select LAST_EVENT_DATE
    into  V_LAST_EVENT_DATE_CURRENT
   from D_MW_TASK_HISTORY
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
   r_dmwbd.claim_date := v_claim_date;
   r_dmwbd.appeal_stage := v_appeal_stage;

     if trunc(v_last_event_date) > trunc(v_last_event_date_old) and
        (v_task_status_old <> r_dmwbd.task_status or
         v_business_unit_id_old <> r_dmwbd.business_unit_id or
         v_team_id_old <> r_dmwbd.team_id or
         v_last_update_date_old <> r_dmwbd.last_update_date or
         v_status_date_old <> r_dmwbd.status_date or
         v_work_receipt_date_old <> r_dmwbd.work_receipt_date or
         v_claim_date_old <> r_dmwbd.claim_date or
         v_appeal_stage_old <> r_dmwbd.appeal_stage) then

		update D_MW_TASK_HISTORY
        set BUCKET_END_DATE = trunc(v_last_event_date) - 1
        where DMWBD_ID = v_DMWBD_id_old;

        insert into D_MW_TASK_HISTORY
        values r_DMWBD;

     end if;

     if trunc(v_last_event_date) = trunc(v_last_event_date_old) and
        (v_task_status_old <> r_dmwbd.task_status or
         v_business_unit_id_old <> r_dmwbd.business_unit_id or
         v_team_id_old <> r_dmwbd.team_id or
         v_last_update_date_old <> r_dmwbd.last_update_date or
         v_status_date_old <> r_dmwbd.status_date or
         v_work_receipt_date_old <> r_dmwbd.work_receipt_date or
         v_claim_date_old <> r_dmwbd.claim_date or
         v_appeal_stage_old <> r_dmwbd.appeal_stage) then

        update D_MW_TASK_HISTORY
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
DBMS_OUTPUT.put_line('in MW.INSERT_BPM_SEMANTIC...');
    if p_data_version != 3 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for MW procedure ' || v_procedure_name ||'.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;

	  GET_UPD_MW_XML(p_old_data_xml,v_old_data);
    GET_UPD_MW_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.TASK_ID;
    v_bucket_start_date := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);

	select MW_BI_ID
    into v_bi_id
    from D_MW_TASK_INSTANCE
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

         v_new_data.CLAIM_DATE,
         v_new_data.ROLE,
         v_new_data.PART,
         v_new_data.RECEIVED_DATE,
	 v_new_data.APPEAL_STAGE,
	 v_new_data.PREVIOUS_TASK_TYPE_ID,
	 v_new_data.NON_STANDARD_WORK_FLAG,
	 v_new_data.HANDLE_TIME

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
					v_new_data.CLAIM_DATE,
					v_new_data.APPEAL_STAGE,
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

procedure UPDATE_APPEAL_TASKS_BY_DAY_COUNTS
as
	v_min_create_date date := null;
	v_max_complete_date date :=null;
	v_max_termination_date date :=null;
begin
delete f_appeal_tasks_by_day;
commit;
insert into F_APPEAL_TASKS_BY_DAY ft
(SELECT  SEQ_ATBD_DPT_ID.nextVal,d_date, appeal_part_id, task_type_id,creation_count, inventory_count,completion_count,cancellation_count,last_update_date 
FROM (
SELECT 
d_date
,appeal_part_id
,task_type_id
,sum(creation_count) as creation_count
,sum(inventory_count) as inventory_count
,sum(completion_count) as completion_count
,sum(cancellation_count) as cancellation_count
,sysdate as last_update_date
from (
SELECT 
bdd.d_date,
a.appeal_part_id as appeal_part_id,
t.task_type_id,
              CASE WHEN bdd.D_DATE = TRUNC(t.CREATE_DATE) THEN 1 ELSE 0 END AS CREATION_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(t.COMPLETE_DATE) OR bdd.D_DATE = TRUNC(t.CANCEL_WORK_DATE)) THEN 0 ELSE 1 END AS INVENTORY_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(t.COMPLETE_DATE) THEN 1 ELSE 0 END AS COMPLETION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(t.CANCEL_WORK_DATE) THEN 1 ELSE 0 END AS CANCELLATION_COUNT
FROM D_DATES bdd
JOIN D_MW_TASK_INSTANCE t
  ON  (
       (bdd.D_DATE >= TRUNC(t.CREATE_DATE))
       AND (
                ((t.complete_date is null) OR (bdd.d_date <= trunc(t.complete_date))) AND
 		((t.cancel_work_date is null) OR (bdd.d_date <= trunc(t.cancel_work_date))) 
            )
    )
join D_MW_APPEAL_INSTANCE a
ON t.source_reference_id = a.appeal_id
WHERE bdd.D_DATE >= TRUNC((SYSDATE - trunc((select value from corp_etl_control where name = 'APPEAL_TASKS_CUBE_SPAN')/4)),'MONTH')
)
group by d_date, appeal_part_id, task_type_id
));
commit;
insert into F_APPEAL_TASKS_BY_DAY ft
(SELECT SEQ_ATBD_DPT_ID.nextVal,d_date, appeal_part_id, task_type_id,creation_count, inventory_count,completion_count,cancellation_count,last_update_date 
FROM (
SELECT 
d_date
,appeal_part_id
,task_type_id
,sum(creation_count) as creation_count
,sum(inventory_count) as inventory_count
,sum(completion_count) as completion_count
,sum(cancellation_count) as cancellation_count
,sysdate as last_update_date
from (
SELECT 
bdd.d_date,
a.appeal_part_id as appeal_part_id,
t.task_type_id,
              CASE WHEN bdd.D_DATE = TRUNC(t.CREATE_DATE) THEN 1 ELSE 0 END AS CREATION_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(t.COMPLETE_DATE) OR bdd.D_DATE = TRUNC(t.CANCEL_WORK_DATE)) THEN 0 ELSE 1 END AS INVENTORY_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(t.COMPLETE_DATE) THEN 1 ELSE 0 END AS COMPLETION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(t.CANCEL_WORK_DATE) THEN 1 ELSE 0 END AS CANCELLATION_COUNT
FROM D_DATES bdd
JOIN D_MW_TASK_INSTANCE t
  ON  (
       (bdd.D_DATE >= TRUNC(t.CREATE_DATE))
       AND (
                ((t.complete_date is null) OR (bdd.d_date <= trunc(t.complete_date))) AND
 		((t.cancel_work_date is null) OR (bdd.d_date <= trunc(t.cancel_work_date))) 
            )
    )
join D_MW_APPEAL_INSTANCE a
ON t.source_reference_id = a.appeal_id
WHERE bdd.d_date >= TRUNC((SYSDATE - trunc(2*(select value from corp_etl_control where name = 'APPEAL_TASKS_CUBE_SPAN')/4)),'MONTH')
AND bdd.d_date < TRUNC((SYSDATE - trunc((select value from corp_etl_control where name = 'APPEAL_TASKS_CUBE_SPAN')/4)),'MONTH')
)
group by d_date, appeal_part_id, task_type_id
));
commit;
insert into F_APPEAL_TASKS_BY_DAY ft
(SELECT  SEQ_ATBD_DPT_ID.nextVal,d_date, appeal_part_id, task_type_id,creation_count, inventory_count,completion_count,cancellation_count,last_update_date 
FROM (
SELECT 
d_date
,appeal_part_id
,task_type_id
,sum(creation_count) as creation_count
,sum(inventory_count) as inventory_count
,sum(completion_count) as completion_count
,sum(cancellation_count) as cancellation_count
,sysdate as last_update_date
from (
SELECT 
bdd.d_date,
a.appeal_part_id as appeal_part_id,
t.task_type_id,
              CASE WHEN bdd.D_DATE = TRUNC(t.CREATE_DATE) THEN 1 ELSE 0 END AS CREATION_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(t.COMPLETE_DATE) OR bdd.D_DATE = TRUNC(t.CANCEL_WORK_DATE)) THEN 0 ELSE 1 END AS INVENTORY_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(t.COMPLETE_DATE) THEN 1 ELSE 0 END AS COMPLETION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(t.CANCEL_WORK_DATE) THEN 1 ELSE 0 END AS CANCELLATION_COUNT
FROM D_DATES bdd
JOIN D_MW_TASK_INSTANCE t
  ON  (
       (bdd.D_DATE >= TRUNC(t.CREATE_DATE))
       AND (
                ((t.complete_date is null) OR (bdd.d_date <= trunc(t.complete_date))) AND
 		((t.cancel_work_date is null) OR (bdd.d_date <= trunc(t.cancel_work_date))) 
            )
    )
join D_MW_APPEAL_INSTANCE a
ON t.source_reference_id = a.appeal_id
WHERE bdd.d_date >= TRUNC((SYSDATE - trunc(3*(select value from corp_etl_control where name = 'APPEAL_TASKS_CUBE_SPAN')/4)),'MONTH')
AND bdd.d_date < TRUNC((SYSDATE - trunc(2*(select value from corp_etl_control where name = 'APPEAL_TASKS_CUBE_SPAN')/4)),'MONTH')
)
group by d_date, appeal_part_id, task_type_id
));
commit;
insert into F_APPEAL_TASKS_BY_DAY ft
(SELECT  SEQ_ATBD_DPT_ID.nextVal,d_date, appeal_part_id, task_type_id,creation_count, inventory_count,completion_count,cancellation_count,last_update_date 
FROM (
SELECT 
d_date
,appeal_part_id
,task_type_id
,sum(creation_count) as creation_count
,sum(inventory_count) as inventory_count
,sum(completion_count) as completion_count
,sum(cancellation_count) as cancellation_count
,sysdate as last_update_date
from (
SELECT 
bdd.d_date,
a.appeal_part_id as appeal_part_id,
t.task_type_id,
              CASE WHEN bdd.D_DATE = TRUNC(t.CREATE_DATE) THEN 1 ELSE 0 END AS CREATION_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(t.COMPLETE_DATE) OR bdd.D_DATE = TRUNC(t.CANCEL_WORK_DATE)) THEN 0 ELSE 1 END AS INVENTORY_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(t.COMPLETE_DATE) THEN 1 ELSE 0 END AS COMPLETION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(t.CANCEL_WORK_DATE) THEN 1 ELSE 0 END AS CANCELLATION_COUNT
FROM D_DATES bdd
JOIN D_MW_TASK_INSTANCE t
  ON  (
       (bdd.D_DATE >= TRUNC(t.CREATE_DATE))
       AND (
                ((t.complete_date is null) OR (bdd.d_date <= trunc(t.complete_date))) AND
 		((t.cancel_work_date is null) OR (bdd.d_date <= trunc(t.cancel_work_date))) 
            )
    )
join D_MW_APPEAL_INSTANCE a
ON t.source_reference_id = a.appeal_id
WHERE bdd.d_date >= TRUNC((SYSDATE - trunc((select value from corp_etl_control where name = 'APPEAL_TASKS_CUBE_SPAN'))),'MONTH')
AND bdd.d_date < TRUNC((SYSDATE - trunc(3*(select value from corp_etl_control where name = 'APPEAL_TASKS_CUBE_SPAN')/4)),'MONTH')
)
group by d_date, appeal_part_id, task_type_id
));
commit;
insert into F_APPEAL_TASKS_BY_DAY
(ATD_DPT_ID,
D_DATE,
APPEAL_PART_ID,
TASK_TYPE_ID,
creation_count,
inventory_count,
completion_count,
cancellation_count,
LAST_UPDATE_DATE)
SELECT 
SEQ_ATBD_DPT_ID.nextVal, res.*, sysdate as last_update_date from
(select
bdd.d_date
,ap.part_id as appeal_part_id
,t.status_id as task_type_id
,sum(0) as creation_count
,sum(0) as inventory_count
,sum(0) as completion_count
,sum(0) as cancellation_count
FROM D_DATES bdd
CROSS JOIN D_APPEAL_STATUSES t
CROSS JOIN d_appeal_parts ap
WHERE bdd.D_DATE >= TRUNC((SYSDATE - (select value from corp_etl_control where name = 'APPEAL_TASKS_CUBE_SPAN')),'MONTH')
group by bdd.d_date, ap.part_id, t.status_id
order by bdd.d_date, ap.part_id,t.status_id) res
where not exists (select 1 from f_appeal_tasks_by_day ft 
where ft.d_date = res.d_date 
and ft.appeal_part_id = res.appeal_part_id and ft.task_type_id = res.task_type_id);
commit;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('DAILY_UPDATE_APPEAL_TASKS', 'fedqic MW', g_Error);
      COMMIT;
      RAISE;
end;
procedure INSERT_NEW_ROWS_APPEAL_TASKS_BY_DAY_COUNTS
as
v_max_date date := null;
begin
select max(d_date) into v_max_date from f_appeal_tasks_by_day;
if (v_max_date < trunc(sysdate)) then
insert into F_APPEAL_TASKS_BY_DAY ft
(SELECT  SEQ_ATBD_DPT_ID.nextVal,d_date, appeal_part_id, task_type_id,creation_count, inventory_count,completion_count,cancellation_count,last_update_date 
FROM (
SELECT 
d_date
,appeal_part_id
,task_type_id
,sum(creation_count) as creation_count
,sum(inventory_count) as inventory_count
,sum(completion_count) as completion_count
,sum(cancellation_count) as cancellation_count
,sysdate as last_update_date
from (
SELECT 
bdd.d_date,
a.appeal_part_id as appeal_part_id,
t.task_type_id,
              CASE WHEN bdd.D_DATE = TRUNC(t.CREATE_DATE) THEN 1 ELSE 0 END AS CREATION_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(t.COMPLETE_DATE) OR bdd.D_DATE = TRUNC(t.CANCEL_WORK_DATE)) THEN 0 ELSE 1 END AS INVENTORY_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(t.COMPLETE_DATE) THEN 1 ELSE 0 END AS COMPLETION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(t.CANCEL_WORK_DATE) THEN 1 ELSE 0 END AS CANCELLATION_COUNT
FROM D_DATES bdd
JOIN D_MW_TASK_INSTANCE t
  ON  (
       (bdd.D_DATE >= TRUNC(t.CREATE_DATE))
       AND (
                ((t.complete_date is null) OR (bdd.d_date <= trunc(t.complete_date))) AND
 		((t.cancel_work_date is null) OR (bdd.d_date <= trunc(t.cancel_work_date))) 
            )
    )
join D_MW_APPEAL_INSTANCE a
ON t.source_reference_id = a.appeal_id
WHERE bdd.D_DATE > v_max_date
)
group by d_date, appeal_part_id, task_type_id
));
commit;
insert into F_APPEAL_TASKS_BY_DAY
(ATD_DPT_ID,
D_DATE,
APPEAL_PART_ID,
TASK_TYPE_ID,
creation_count,
inventory_count,
completion_count,
cancellation_count,
LAST_UPDATE_DATE)
SELECT 
SEQ_ATBD_DPT_ID.nextVal, res.*, sysdate as last_update_date from
(select
bdd.d_date
,ap.part_id as appeal_part_id
,t.status_id as task_type_id
,sum(0) as creation_count
,sum(0) as inventory_count
,sum(0) as completion_count
,sum(0) as cancellation_count
FROM D_DATES bdd
CROSS JOIN D_APPEAL_STATUSES t
CROSS JOIN d_appeal_parts ap
WHERE bdd.D_DATE > v_max_date
group by bdd.d_date, ap.part_id, t.status_id
order by bdd.d_date, ap.part_id,t.status_id) res
where not exists (select 1 from f_appeal_tasks_by_day ft 
where ft.d_date = res.d_date 
and ft.appeal_part_id = res.appeal_part_id and ft.task_type_id = res.task_type_id);
commit;
end if;
delete F_APPEAL_TASKS_BY_DAY ft
where ft.D_DATE < TRUNC((SYSDATE - (select value from corp_etl_control where name = 'APPEAL_TASKS_CUBE_SPAN')),'MONTH');
commit;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('DAILY_INS_DEL_NEW_APPEAL_TASKS', 'fedqic MW', g_Error);
      COMMIT;
      RAISE;
end;
end;
/

alter session set plsql_code_type = interpreted;