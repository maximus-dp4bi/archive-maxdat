alter session set plsql_code_type = native;

create or replace package Process_Appeals as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/FEDQIC/createdb/Process_Appeals_pkg.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 21871 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2017-12-04 17:23:19 -0500 (Mon, 04 Dec 2017) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: gt83345 $';

  procedure CALC_DAPCUR;
  procedure UPDATE_DAY_PART_COUNTS;
  procedure INSERT_NEW_ROWS_DAY_PART_COUNTS;

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

  /*
  Include:
    CEAP_ID
    STG_LAST_UPDATE_DATE
  */
  type T_INS_MW_XML is record
    (
  CEAP_ID varchar2(100)
, APPEAL_ID VARCHAR2(100)
, CREATE_DATE VARCHAR2(100)
, COMPLETE_DATE VARCHAR2(100)
, CANCELLED_DATE VARCHAR2(100)
, ADJUDICATOR VARCHAR2(100)  
, DEADLINE_DATE VARCHAR2(100) 
, APPEAL_ISSUE VARCHAR2(100)
, APPEAL_ITEM VARCHAR2(100)  
, APPEAL_NUMBER VARCHAR2(20 CHAR) 
, APPEAL_PRIORITY_ID VARCHAR2(100)
, REQUEST_RECEIVED VARCHAR2(100)  
, APPEAL_STAGE VARCHAR2(100)  
, APPEAL_STATUS VARCHAR2(100) 
, APPEAL_TYPE VARCHAR2(100)
, APPEAL_DISMISSAL VARCHAR2(100)
, APPEAL_DISMISSAL_REASON VARCHAR2(100)
, AUTO_FORWARD VARCHAR2(100)
, CASE_FILE_REQUEST_DATE VARCHAR2(100) 
, ACKNOWLEDGEMENT_LETTER_DATE VARCHAR2(100) 
, DECISION_MAILED_DATE VARCHAR2(100) 
, DECISION_SENT_PLAN_DATE VARCHAR2(100) 
, MEDICAL_REVIEW_CHECK VARCHAR2(1) 
, APPEAL_PART_ID VARCHAR2(100) 
, APPEAL_REASON VARCHAR2(100) 
, APPEAL_TOLLING_DATE VARCHAR2(100)
, APPEAL_NOTICE_DATE VARCHAR2(100)
, CASE_FILE_RECEIVED_DATE VARCHAR2(100)  
, CLAIMED_DATE VARCHAR2(100)
, DECISION VARCHAR2(100)
, DECISION_NOTIFICATION_METHOD VARCHAR2(100)
, HPMS VARCHAR2(100)
, HPMS_REQUESTED_DATE VARCHAR2(100)
, IS_REQUEST_FOR_INFORMATION_P VARCHAR2(1)
, MAC VARCHAR2(100)
, MEDICARE_TYPE VARCHAR2(100)
, MSP VARCHAR2(100)
, NEW_DOCUMENTATION_REVIEWED VARCHAR2(1)
, PHYSICIAN_SPECIALTY VARCHAR2(100)
, PRECHECK_COMPLETED VARCHAR2(1)
, REASON_FOR_APPEAL VARCHAR2(4000)
, WITHDRAWAL VARCHAR2(1)
, WITHDRAWAL_REQUEST_SUBMITTED VARCHAR2(100)
, NON_ENGLISH VARCHAR2(100)
, NON_ENGLISH_OTHER VARCHAR2(250)
, DISPOSITION VARCHAR2(100)
, DISPOSITION_EXPLANATION VARCHAR2(100)
, PROCEDURAL_DECISION_REASON VARCHAR2(100)
, SUBSTANTIVE_REASON VARCHAR2(100)
, FIRST_REVIEW_CASE_ATTESTATIO VARCHAR2(100)
, FIRST_MEDICAL_REVIEW_DECISIO VARCHAR2(100)
, FIRST_REVIEWER VARCHAR2(100)
, THIRD_MEDICAL_REVIEW_DECISIO VARCHAR2(100)
, THIRD_REVIEW_CASE_ATTESTATIO VARCHAR2(100)
, THIRD_REVIEWER VARCHAR2(100)
, EXPERT_REVIEW_CASE_ATTESTATI VARCHAR2(100)
, EXPERT_REVIEW_CITATION VARCHAR2(4000)
, EXPERT_REVIEWER_MD_ID VARCHAR2(100)	
, STG_EXTRACT_DATE VARCHAR2(100)
, STG_LAST_UPDATE_DATE VARCHAR2(100)
, CLOSED_DATE VARCHAR2(100)
, WITHDRAWN_DATE VARCHAR2(100)

,DEMO_REOPENING_TYPE VARCHAR2(100)
,OTHER_REOPENING_TYPE VARCHAR2(100)
,CASE_CURRENTLY_WITH_ALJ VARCHAR2(100)
,DATE_OF_REQUEST_TO_ALJ	 VARCHAR2(100)
,DEMO_REOPENING_DUE_DATE VARCHAR2(100)
,DEMO_REO_SENT_TO_OMHA_DATE VARCHAR2(100)
,OMHA_RESPONSE_RECEIVED	VARCHAR2(100)
,RESPONSE_FROM_OMHA VARCHAR2(100)
,ADDITIONAL_INFO_REQUESTED VARCHAR2(100)
,REQUESTED_INFORMATION_DUE VARCHAR2(100)
,DEMO_REOPEN_FOLLOW_UP VARCHAR2(100)
,ADDITIONAL_INFO_RECEIVED VARCHAR2(100)
,REOPENING_DECISION_RESULTS VARCHAR2(100)
,NOT_REOPENED_REASON VARCHAR2(100)
,OMHA_REMAND_REQUEST VARCHAR2(100)
,REMAND_ELIGIBILITY_RESPONSE VARCHAR2(100)
,REMAND_RECEIVED_DATE VARCHAR2(100)
,OMHA_REMAND_REQUEST_RESPONSE VARCHAR2(100)
,OMHA_WITHDRAW_FORM_SENT VARCHAR2(100)
,OMHA_WITHDRAW_FORM_RETURNED VARCHAR2(100)
,OMHA_NOTIFIED_OF_WITHDRAWL VARCHAR2(100)
,ALJ_WITHDRAWAL	 VARCHAR2(100)
,DEMO_REOPENING_APPEAL_NUMBER VARCHAR2(100)
,REOPENING_ANALYSIS_COMPLETED VARCHAR2(100)
,REOPENING_ANALYSIS_OUTCOME VARCHAR2(100)
,NOT_PURSUED_BY_CONTR_REASON VARCHAR2(100)
,ACK_LETTER_MAILED VARCHAR2(100)
,REO_DECISION_LETTER_MAILED VARCHAR2(100)
,REOPENING_OUTCOME VARCHAR2(100)
,DECLINE_TO_REOPEN_DECISION VARCHAR2(100)
,APPEAL_ATTESTATION_DATE VARCHAR2(100)
,APPEAL_ATTESTATION VARCHAR2(100)
,DEMO_SCHEDULED	 VARCHAR2(100)
,DEMO_NOTIFICATION_LETTER_SENT VARCHAR2(100)
,RESPONSE_DUE VARCHAR2(100)
,RESPONSE_RECEIVED VARCHAR2(100)
,DEMO_ACCEPTANCE_STATUS	VARCHAR2(100)
,TELE_DEMO_FOLLOW_UP	 VARCHAR2(100)
,DEMO_NOTIFICATION_LTR_RESENT VARCHAR2(100)
,RESCHEDULED_RESPONSE_DUE VARCHAR2(100)
,RESCHEDULE_RESPONSE_RECEIVED	 VARCHAR2(100)
,VERBAL_CONFIRMATION		 VARCHAR2(100)
,RESCHEDULED_DEMO_STATUS		 VARCHAR2(100)
,PROVIDER_OR_SUPPLIER_NAME	 VARCHAR2(100)
,DEMO_CONFERENCE_STATUS		 VARCHAR2(100)
,REVIEW_TYPE			 VARCHAR2(100)
,EXPERT_REVIEW_DECISION		 VARCHAR2(100)		
,REVIEW_NUMBER			 VARCHAR2(100)
    );

  /*
  Include:
    STG_LAST_UPDATE_DATE
  */
  type T_UPD_MW_XML is record
    (
  APPEAL_ID VARCHAR2(100)
, CREATE_DATE VARCHAR2(100)
, COMPLETE_DATE VARCHAR2(100)
, CANCELLED_DATE VARCHAR2(100)
, ADJUDICATOR VARCHAR2(100)  
, DEADLINE_DATE VARCHAR2(100) 
, APPEAL_ISSUE VARCHAR2(100)
, APPEAL_ITEM VARCHAR2(100)  
, APPEAL_NUMBER VARCHAR2(20 CHAR) 
, APPEAL_PRIORITY_ID VARCHAR2(100)
, REQUEST_RECEIVED VARCHAR2(100)  
, APPEAL_STAGE VARCHAR2(100)  
, APPEAL_STATUS VARCHAR2(100) 
, APPEAL_TYPE VARCHAR2(100)
, APPEAL_DISMISSAL VARCHAR2(100)
, APPEAL_DISMISSAL_REASON VARCHAR2(100)
, AUTO_FORWARD VARCHAR2(100)
, CASE_FILE_REQUEST_DATE VARCHAR2(100) 
, ACKNOWLEDGEMENT_LETTER_DATE VARCHAR2(100) 
, DECISION_MAILED_DATE VARCHAR2(100) 
, DECISION_SENT_PLAN_DATE VARCHAR2(100) 
, MEDICAL_REVIEW_CHECK VARCHAR2(1) 
, APPEAL_PART_ID VARCHAR2(100) 
, APPEAL_REASON VARCHAR2(100) 
, APPEAL_TOLLING_DATE VARCHAR2(100)
, APPEAL_NOTICE_DATE VARCHAR2(100)
, CASE_FILE_RECEIVED_DATE VARCHAR2(100)  
, CLAIMED_DATE VARCHAR2(100)
, DECISION VARCHAR2(100)
, DECISION_NOTIFICATION_METHOD VARCHAR2(100)
, HPMS VARCHAR2(100)
, HPMS_REQUESTED_DATE VARCHAR2(100)
, IS_REQUEST_FOR_INFORMATION_P VARCHAR2(1)
, MAC VARCHAR2(100)
, MEDICARE_TYPE VARCHAR2(100)
, MSP VARCHAR2(100)
, NEW_DOCUMENTATION_REVIEWED VARCHAR2(1)
, PHYSICIAN_SPECIALTY VARCHAR2(100)
, PRECHECK_COMPLETED VARCHAR2(1)
, REASON_FOR_APPEAL VARCHAR2(4000)
, WITHDRAWAL VARCHAR2(1)
, WITHDRAWAL_REQUEST_SUBMITTED VARCHAR2(100)
, NON_ENGLISH VARCHAR2(100)
, NON_ENGLISH_OTHER VARCHAR2(250)
, DISPOSITION VARCHAR2(100)
, DISPOSITION_EXPLANATION VARCHAR2(100)
, PROCEDURAL_DECISION_REASON VARCHAR2(100)
, SUBSTANTIVE_REASON VARCHAR2(100)
, FIRST_REVIEW_CASE_ATTESTATIO VARCHAR2(100)
, FIRST_MEDICAL_REVIEW_DECISIO VARCHAR2(100)
, FIRST_REVIEWER VARCHAR2(100)
, THIRD_MEDICAL_REVIEW_DECISIO VARCHAR2(100)
, THIRD_REVIEW_CASE_ATTESTATIO VARCHAR2(100)
, THIRD_REVIEWER VARCHAR2(100)
, EXPERT_REVIEW_CASE_ATTESTATI VARCHAR2(100)
, EXPERT_REVIEW_CITATION VARCHAR2(4000)
, EXPERT_REVIEWER_MD_ID VARCHAR2(100)
, STG_EXTRACT_DATE VARCHAR2(100)
, STG_LAST_UPDATE_DATE VARCHAR2(100)
, CLOSED_DATE VARCHAR2(100)
, WITHDRAWN_DATE VARCHAR2(100)

,DEMO_REOPENING_TYPE VARCHAR2(100)
,OTHER_REOPENING_TYPE VARCHAR2(100)
,CASE_CURRENTLY_WITH_ALJ VARCHAR2(100)
,DATE_OF_REQUEST_TO_ALJ	 VARCHAR2(100)
,DEMO_REOPENING_DUE_DATE VARCHAR2(100)
,DEMO_REO_SENT_TO_OMHA_DATE VARCHAR2(100)
,OMHA_RESPONSE_RECEIVED	VARCHAR2(100)
,RESPONSE_FROM_OMHA VARCHAR2(100)
,ADDITIONAL_INFO_REQUESTED VARCHAR2(100)
,REQUESTED_INFORMATION_DUE VARCHAR2(100)
,DEMO_REOPEN_FOLLOW_UP VARCHAR2(100)
,ADDITIONAL_INFO_RECEIVED VARCHAR2(100)
,REOPENING_DECISION_RESULTS VARCHAR2(100)
,NOT_REOPENED_REASON VARCHAR2(100)
,OMHA_REMAND_REQUEST VARCHAR2(100)
,REMAND_ELIGIBILITY_RESPONSE VARCHAR2(100)
,REMAND_RECEIVED_DATE VARCHAR2(100)
,OMHA_REMAND_REQUEST_RESPONSE VARCHAR2(100)
,OMHA_WITHDRAW_FORM_SENT VARCHAR2(100)
,OMHA_WITHDRAW_FORM_RETURNED VARCHAR2(100)
,OMHA_NOTIFIED_OF_WITHDRAWL VARCHAR2(100)
,ALJ_WITHDRAWAL	 VARCHAR2(100)
,DEMO_REOPENING_APPEAL_NUMBER VARCHAR2(100)
,REOPENING_ANALYSIS_COMPLETED VARCHAR2(100)
,REOPENING_ANALYSIS_OUTCOME VARCHAR2(100)
,NOT_PURSUED_BY_CONTR_REASON VARCHAR2(100)
,ACK_LETTER_MAILED VARCHAR2(100)
,REO_DECISION_LETTER_MAILED VARCHAR2(100)
,REOPENING_OUTCOME VARCHAR2(100)
,DECLINE_TO_REOPEN_DECISION VARCHAR2(100)
,APPEAL_ATTESTATION_DATE VARCHAR2(100)
,APPEAL_ATTESTATION VARCHAR2(100)
,DEMO_SCHEDULED	 VARCHAR2(100)
,DEMO_NOTIFICATION_LETTER_SENT VARCHAR2(100)
,RESPONSE_DUE VARCHAR2(100)
,RESPONSE_RECEIVED VARCHAR2(100)
,DEMO_ACCEPTANCE_STATUS	VARCHAR2(100)
,TELE_DEMO_FOLLOW_UP	 VARCHAR2(100)
,DEMO_NOTIFICATION_LTR_RESENT VARCHAR2(100)
,RESCHEDULED_RESPONSE_DUE VARCHAR2(100)
,RESCHEDULE_RESPONSE_RECEIVED	 VARCHAR2(100)
,VERBAL_CONFIRMATION		 VARCHAR2(100)
,RESCHEDULED_DEMO_STATUS		 VARCHAR2(100)
,PROVIDER_OR_SUPPLIER_NAME	 VARCHAR2(100)
,DEMO_CONFERENCE_STATUS		 VARCHAR2(100)
,REVIEW_TYPE			 VARCHAR2(100)
,EXPERT_REVIEW_DECISION		 VARCHAR2(100)		
,REVIEW_NUMBER			 VARCHAR2(100)
    );

  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype);

  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype);

end Process_Appeals;
/
create or replace package body Process_Appeals as
  g_Error   VARCHAR2(4000);
  v_bem_id number := 2002; -- 'Federal QIC'
  v_bil_id number := 3; -- 'Task ID' --???
  v_bsl_id number := 2004; -- 'FEDQIC_ETL_APPEALS'
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
     --return BPM_COMMON.BUS_DAYS_BETWEEN(p_CURR_CLAIM_DATE,nvl(p_INSTANCE_END_DATE,sysdate));
return (nvl(p_INSTANCE_END_DATE,sysdate) - p_CURR_CLAIM_DATE)*24; 
  end;

 function GET_TASK_UNCLAIMED_TIME
    (p_CREATE_DATE in date,
     p_CURR_CLAIM_DATE in date)
    return number parallel_enable
  as
  begin
     --return BPM_COMMON.BUS_DAYS_BETWEEN(p_CREATE_DATE,nvl(p_CURR_CLAIM_DATE,sysdate));
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

procedure UPDATE_DAY_PART_COUNTS
as
	v_min_create_date date := null;
	v_max_complete_date date :=null;
	v_max_termination_date date :=null;
begin


update F_APPEALS_BY_DAY_BY_PART set 
creation_count = 0,
inventory_count=0,
sla_inventory_count=0,
completion_count=0,
closed_count=0,
cancellation_count=0,
withdrawn_count=0,
termination_count=0,
timely_appeals_count=0,
untimely_appeals_count=0,
last_update_date=sysdate;
commit;
update  F_APPEALS_BY_DAY_BY_PART ft
set (creation_count, inventory_count,sla_inventory_count, completion_count, closed_count,cancellation_count,withdrawn_count, termination_count,timely_appeals_count, untimely_appeals_count, last_update_date) = 
(SELECT  creation_count, inventory_count,sla_inventory_count, completion_count, closed_count,cancellation_count,withdrawn_count, termination_count,timely_appeals_count, untimely_appeals_count, last_update_date 
FROM (
SELECT 
d_date
,appeal_part_id
,sum(creation_count) as creation_count
,sum(inventory_count) as inventory_count
,sum(sla_inventory_count) as sla_inventory_count
,sum(completion_count) as completion_count
,sum(closed_count) as closed_count
,sum(cancellation_count) as cancellation_count
,sum(withdrawn_count) as withdrawn_count
,sum(termination_count) as termination_count
,sum(timely_appeals_count) as timely_appeals_count
,sum(untimely_appeals_count) as untimely_appeals_count
,sysdate as last_update_date
from (
SELECT 
a.appeal_id,
bdd.d_date,
a.appeal_part_id,
              CASE WHEN bdd.D_DATE = TRUNC(a.CREATE_DATE) THEN 1 ELSE 0 END AS CREATION_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.CLOSED_DATE) OR bdd.D_DATE = TRUNC(a.CANCELLED_DATE) OR bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE)) THEN 0 ELSE 1 END AS INVENTORY_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.CLOSED_DATE) OR bdd.D_DATE = TRUNC(a.CANCELLED_DATE) OR bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE))
		OR (a.COMPLETE_DATE IS NOT NULL AND bdd.d_DATE >= TRUNC(a.COMPLETE_DATE))
		THEN 0 ELSE 1 END AS SLA_INVENTORY_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.COMPLETE_DATE) THEN 1 ELSE 0 END AS COMPLETION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.CLOSED_DATE) THEN 1 ELSE 0 END AS CLOSED_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.CANCELLED_DATE) THEN 1 ELSE 0 END AS CANCELLATION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE) THEN 1 ELSE 0 END AS WITHDRAWN_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.CLOSED_DATE) OR bdd.D_DATE = TRUNC(a.CANCELLED_DATE) OR bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE)) THEN 1 ELSE 0 END AS TERMINATION_COUNT,
              CASE WHEN  (bdd.D_DATE = TRUNC(a.COMPLETE_DATE) AND bdd.D_DATE <= a.DEADLINE_DATE AND a.complete_date <= a.deadline_date) THEN 1 ELSE 0 END as TIMELY_APPEALS_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.COMPLETE_DATE) AND (bdd.D_DATE > a.DEADLINE_DATE or a.complete_date > a.deadline_date)) THEN 1 ELSE 0 END as UNTIMELY_APPEALS_COUNT
FROM D_DATES bdd
JOIN D_MW_APPEAL_INSTANCE a
  ON  (
       ((a.create_date is null) OR (bdd.D_DATE >= TRUNC(a.CREATE_DATE)))
       AND (
                ((closed_date is null) OR (bdd.d_date <= trunc(closed_date))) AND
 		((cancelled_date is null) OR (bdd.d_date <= trunc(cancelled_date))) AND
     		((withdrawn_date is null) OR (bdd.d_date <= trunc(withdrawn_date)))
            )
    )
WHERE bdd.D_DATE >= TRUNC((SYSDATE - trunc((select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')/2)),'MONTH')
)
group by d_date, appeal_part_id
) results
where ft.d_date = results.d_date
and ft.appeal_part_id = results.appeal_part_id
)
where ft.d_date >= TRUNC((SYSDATE - trunc((select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')/2)),'MONTH');
commit;
update  F_APPEALS_BY_DAY_BY_PART ft
set (creation_count, inventory_count,sla_inventory_count, completion_count, closed_count,cancellation_count,withdrawn_count, termination_count,timely_appeals_count, untimely_appeals_count, last_update_date) = 
(SELECT  creation_count, inventory_count,sla_inventory_count, completion_count, closed_count,cancellation_count,withdrawn_count, termination_count,timely_appeals_count, untimely_appeals_count, last_update_date 
FROM (
SELECT 
d_date
,appeal_part_id
,sum(creation_count) as creation_count
,sum(inventory_count) as inventory_count
,sum(sla_inventory_count) as sla_inventory_count
,sum(completion_count) as completion_count
,sum(closed_count) as closed_count
,sum(cancellation_count) as cancellation_count
,sum(withdrawn_count) as withdrawn_count
,sum(termination_count) as termination_count
,sum(timely_appeals_count) as timely_appeals_count
,sum(untimely_appeals_count) as untimely_appeals_count
,sysdate as last_update_date
from (
SELECT 
a.appeal_id,
bdd.d_date,
a.appeal_part_id,
              CASE WHEN bdd.D_DATE = TRUNC(a.CREATE_DATE) THEN 1 ELSE 0 END AS CREATION_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.CLOSED_DATE) OR bdd.D_DATE = TRUNC(a.CANCELLED_DATE) OR bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE)) THEN 0 ELSE 1 END AS INVENTORY_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.CLOSED_DATE) OR bdd.D_DATE = TRUNC(a.CANCELLED_DATE) OR bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE))
		OR (a.COMPLETE_DATE IS NOT NULL AND bdd.d_DATE >= TRUNC(a.COMPLETE_DATE))
		THEN 0 ELSE 1 END AS SLA_INVENTORY_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.COMPLETE_DATE) THEN 1 ELSE 0 END AS COMPLETION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.CLOSED_DATE) THEN 1 ELSE 0 END AS CLOSED_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.CANCELLED_DATE) THEN 1 ELSE 0 END AS CANCELLATION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE) THEN 1 ELSE 0 END AS WITHDRAWN_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.CLOSED_DATE) OR bdd.D_DATE = TRUNC(a.CANCELLED_DATE) OR bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE)) THEN 1 ELSE 0 END AS TERMINATION_COUNT,
              CASE WHEN  (bdd.D_DATE = TRUNC(a.COMPLETE_DATE) AND bdd.D_DATE <= a.DEADLINE_DATE AND a.complete_date <= a.deadline_date) THEN 1 ELSE 0 END as TIMELY_APPEALS_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.COMPLETE_DATE) AND (bdd.D_DATE > a.DEADLINE_DATE or a.complete_date > a.deadline_date)) THEN 1 ELSE 0 END as UNTIMELY_APPEALS_COUNT
FROM D_DATES bdd
JOIN D_MW_APPEAL_INSTANCE a
  ON  (
       ((a.create_date is null) OR (bdd.D_DATE >= TRUNC(a.CREATE_DATE)))
       AND (
                ((closed_date is null) OR (bdd.d_date <= trunc(closed_date))) AND
 		((cancelled_date is null) OR (bdd.d_date <= trunc(cancelled_date))) AND
     		((withdrawn_date is null) OR (bdd.d_date <= trunc(withdrawn_date)))
            )
    )
WHERE bdd.D_DATE >= TRUNC((SYSDATE - (select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')),'MONTH')
AND bdd.d_date < TRUNC((SYSDATE - trunc((select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')/2)),'MONTH')
)
group by d_date, appeal_part_id
) results
where ft.d_date = results.d_date
and ft.appeal_part_id = results.appeal_part_id
)
WHERE ft.D_DATE >= TRUNC((SYSDATE - (select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')),'MONTH')
AND ft.d_date < TRUNC((SYSDATE - trunc((select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')/2)),'MONTH');
commit;
update F_APPEALS_BY_DAY_BY_PART set 
creation_count = 0
,inventory_count = 0
,sla_inventory_count = 0
,completion_count = 0
,closed_count = 0
,cancellation_count = 0
,withdrawn_count = 0
,termination_count = 0
,timely_appeals_count = 0
,untimely_appeals_count = 0
where creation_count is null;
commit;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('DAILY_UPDATE_APPEALS_BY_DAY', 'fedqic MW', g_Error);
      COMMIT;
      RAISE;
end;

procedure INSERT_NEW_ROWS_DAY_PART_COUNTS
as
v_max_date date := null;
begin
select max(d_date) into v_max_date from f_appeals_by_day_by_part;
if (v_max_date < trunc(sysdate)) then 
insert into F_APPEALS_BY_DAY_BY_PART ft
(SELECT  SEQ_ABD_DP_ID.nextVal,d_date, appeal_part_id, creation_count, inventory_count,sla_inventory_count, completion_count, closed_count,cancellation_count,withdrawn_count, termination_count,timely_appeals_count, untimely_appeals_count, last_update_date 
FROM (
SELECT 
d_date
,appeal_part_id
,sum(creation_count) as creation_count
,sum(inventory_count) as inventory_count
,sum(sla_inventory_count) as sla_inventory_count
,sum(completion_count) as completion_count
,sum(closed_count) as closed_count
,sum(cancellation_count) as cancellation_count
,sum(withdrawn_count) as withdrawn_count
,sum(termination_count) as termination_count
,sum(timely_appeals_count) as timely_appeals_count
,sum(untimely_appeals_count) as untimely_appeals_count
,sysdate as last_update_date
from (
SELECT 
a.appeal_id,
bdd.d_date,
a.appeal_part_id,
              CASE WHEN bdd.D_DATE = TRUNC(a.CREATE_DATE) THEN 1 ELSE 0 END AS CREATION_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.CLOSED_DATE) OR bdd.D_DATE = TRUNC(a.CANCELLED_DATE) OR bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE)) THEN 0 ELSE 1 END AS INVENTORY_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.CLOSED_DATE) OR bdd.D_DATE = TRUNC(a.CANCELLED_DATE) OR bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE))
		OR (a.COMPLETE_DATE IS NOT NULL AND bdd.d_DATE >= TRUNC(a.COMPLETE_DATE))
		THEN 0 ELSE 1 END AS SLA_INVENTORY_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.COMPLETE_DATE) THEN 1 ELSE 0 END AS COMPLETION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.CLOSED_DATE) THEN 1 ELSE 0 END AS CLOSED_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.CANCELLED_DATE) THEN 1 ELSE 0 END AS CANCELLATION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE) THEN 1 ELSE 0 END AS WITHDRAWN_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.CLOSED_DATE) OR bdd.D_DATE = TRUNC(a.CANCELLED_DATE) OR bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE)) THEN 1 ELSE 0 END AS TERMINATION_COUNT,
              CASE WHEN  (bdd.D_DATE = TRUNC(a.COMPLETE_DATE) AND bdd.D_DATE <= a.DEADLINE_DATE AND a.complete_date <= a.deadline_date) THEN 1 ELSE 0 END as TIMELY_APPEALS_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.COMPLETE_DATE) AND (bdd.D_DATE > a.DEADLINE_DATE or a.complete_date > a.deadline_date)) THEN 1 ELSE 0 END as UNTIMELY_APPEALS_COUNT
FROM D_DATES bdd
JOIN D_MW_APPEAL_INSTANCE a
  ON  (
       ((a.create_date is null) OR (bdd.D_DATE >= TRUNC(a.CREATE_DATE)))
       AND (
                ((closed_date is null) OR (bdd.d_date <= trunc(closed_date))) AND
 		((cancelled_date is null) OR (bdd.d_date <= trunc(cancelled_date))) AND
     		((withdrawn_date is null) OR (bdd.d_date <= trunc(withdrawn_date)))
            )
    )
WHERE bdd.D_DATE > v_max_date
)
group by d_date, appeal_part_id
));
commit;
insert into F_APPEALS_BY_DAY_BY_PART 
(ABD_DP_ID,
D_DATE,
APPEAL_PART_ID,
creation_count,
inventory_count,
sla_inventory_count,
completion_count,
closed_count,
cancellation_count,
withdrawn_count,
termination_count,
timely_appeals_count,
untimely_appeals_count,
LAST_UPDATE_DATE)
SELECT 
SEQ_ABD_DP_ID.nextVal, res.*, sysdate as last_update_date from
(select
bdd.d_date
,ap.part_id
,sum(0) as creation_count
,sum(0) as inventory_count
,sum(0) as sla_inventory_count
,sum(0) as completion_count
,sum(0) as closed_count
,sum(0) as cancellation_count
,sum(0) as withdrawn_count
,sum(0) as termination_count
,sum(0) as timely_appeals_count
,sum(0) as untimely_appeals_count
FROM D_DATES bdd
CROSS JOIN d_appeal_parts ap
WHERE bdd.D_DATE > v_max_date 
group by bdd.d_date, ap.part_id
order by bdd.d_date, ap.part_id) res
where not exists (select 1 from f_appeals_by_day_by_part ft 
where ft.d_date = res.d_date 
and ft.appeal_part_id = res.part_id);
commit;
end if;
delete F_APPEALS_BY_DAY_BY_PART fa
where fa.D_DATE < TRUNC((SYSDATE - (select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')),'MONTH');
commit;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('DAILY_INS_DEL_NEW_APPEALS_BY_DAY', 'fedqic MW', g_Error);
      COMMIT;
      RAISE;
end;


  -- Calculate column values in BPM Semantic table D_MW_TASK_INSTANCE.
  procedure CALC_DAPCUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DAPCUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin

    update D_MW_TASK_INSTANCE
    set
     TASK_CLAIMED_TIME = GET_TASK_CLAIMED_TIME(CURR_CLAIM_DATE,INSTANCE_END_DATE)
     
    where
       INSTANCE_END_DATE is null
      and CANCEL_WORK_DATE is null;

    v_num_rows_updated := sql%rowcount;

    update D_MW_TASK_INSTANCE
    set
     TASK_UNCLAIMED_TIME = GET_TASK_UNCLAIMED_TIME(CREATE_DATE,COALESCE(CURR_CLAIM_DATE,INSTANCE_END_DATE))
     
    where
      CURR_CLAIM_DATE is null
      and CANCEL_WORK_DATE is null;

    v_num_rows_updated := v_num_rows_updated + sql%rowcount;

    commit;

    v_log_message := v_num_rows_updated  || ' D_MW_TASK_INSTANCE rows updated with calculated attributes by CALC_DAPCUR.';
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
extractValue(p_data_xml,'/ROWSET/ROW/CEAP_ID') "CEAP_ID",
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_ID') "APPEAL_ID",
extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DATE') "CREATE_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DATE') "COMPLETE_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/CANCELLED_DATE') "CANCELLED_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/ADJUDICATOR') "ADJUDICATOR",  
extractValue(p_data_xml,'/ROWSET/ROW/DEADLINE_DATE') "DEADLINE_DATE", 
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_ISSUE') "APPEAL_ISSUE",
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_ITEM') "APPEAL_ITEM",  
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_NUMBER') "APPEAL_NUMBER", 
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_PRIORITY_ID') "APPEAL_PRIORITY_ID",
extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_RECEIVED') "REQUEST_RECEIVED",  
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_STAGE') "APPEAL_STAGE",  
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_STATUS') "APPEAL_STATUS", 
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_TYPE') "APPEAL_TYPE",
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_DISMISSAL') "APPEAL_DISMISSAL",
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_DISMISSAL_REASON') "APPEAL_DISMISSAL_REASON",
extractValue(p_data_xml,'/ROWSET/ROW/AUTO_FORWARD') "AUTO_FORWARD",
extractValue(p_data_xml,'/ROWSET/ROW/CASE_FILE_REQUEST_DATE') "CASE_FILE_REQUEST_DATE", 
extractValue(p_data_xml,'/ROWSET/ROW/ACKNOWLEDGEMENT_LETTER_DATE') "ACKNOWLEDGEMENT_LETTER_DATE", 
extractValue(p_data_xml,'/ROWSET/ROW/DECISION_MAILED_DATE') "DECISION_MAILED_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/DECISION_SENT_PLAN_DATE') "DECISION_SENT_PLAN_DATE", 
extractValue(p_data_xml,'/ROWSET/ROW/MEDICAL_REVIEW_CHECK') "MEDICAL_REVIEW_CHECK", 
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_PART_ID') "APPEAL_PART_ID", 
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_REASON') "APPEAL_REASON", 
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_TOLLING_DATE') "APPEAL_TOLLING_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_NOTICE_DATE') "APPEAL_NOTICE_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/CASE_FILE_RECEIVED_DATE') "CASE_FILE_RECEIVED_DATE",  
extractValue(p_data_xml,'/ROWSET/ROW/CLAIMED_DATE') "CLAIMED_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/DECISION') "DECISION",
extractValue(p_data_xml,'/ROWSET/ROW/DECISION_NOTIFICATION_METHOD') "DECISION_NOTIFICATION_METHOD",
extractValue(p_data_xml,'/ROWSET/ROW/HPMS') "HPMS",
extractValue(p_data_xml,'/ROWSET/ROW/HPMS_REQUESTED_DATE') "HPMS_REQUESTED_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/IS_REQUEST_FOR_INFORMATION_P') "IS_REQUEST_FOR_INFORMATION_P",
extractValue(p_data_xml,'/ROWSET/ROW/MAC') "MAC",
extractValue(p_data_xml,'/ROWSET/ROW/MEDICARE_TYPE') "MEDICARE_TYPE",
extractValue(p_data_xml,'/ROWSET/ROW/MSP') "MSP",
extractValue(p_data_xml,'/ROWSET/ROW/NEW_DOCUMENTATION_REVIEWED') "NEW_DOCUMENTATION_REVIEWED",
extractValue(p_data_xml,'/ROWSET/ROW/PHYSICIAN_SPECIALTY') "PHYSICIAN_SPECIALTY",
extractValue(p_data_xml,'/ROWSET/ROW/PRECHECK_COMPLETED') "PRECHECK_COMPLETED",
extractValue(p_data_xml,'/ROWSET/ROW/REASON_FOR_APPEAL') "REASON_FOR_APPEAL",
extractValue(p_data_xml,'/ROWSET/ROW/WITHDRAWAL') "WITHDRAWAL",
extractValue(p_data_xml,'/ROWSET/ROW/WITHDRAWAL_REQUEST_SUBMITTED') "WITHDRAWAL_REQUEST_SUBMITTED",
extractValue(p_data_xml,'/ROWSET/ROW/NON_ENGLISH') "NON_ENGLISH",
extractValue(p_data_xml,'/ROWSET/ROW/NON_ENGLISH_OTHER') "NON_ENGLISH_OTHER",
extractValue(p_data_xml,'/ROWSET/ROW/DISPOSITION') "DISPOSITION",
extractValue(p_data_xml,'/ROWSET/ROW/DISPOSITION_EXPLANATION') "DISPOSITION_EXPLANATION",
extractValue(p_data_xml,'/ROWSET/ROW/PROCEDURAL_DECISION_REASON') "PROCEDURAL_DECISION_REASON",
extractValue(p_data_xml,'/ROWSET/ROW/SUBSTANTIVE_REASON') "SUBSTANTIVE_REASON",
extractValue(p_data_xml,'/ROWSET/ROW/FIRST_REVIEW_CASE_ATTESTATIO') "FIRST_REVIEW_CASE_ATTESTATIO",
extractValue(p_data_xml,'/ROWSET/ROW/FIRST_MEDICAL_REVIEW_DECISIO') "FIRST_MEDICAL_REVIEW_DECISIO",
extractValue(p_data_xml,'/ROWSET/ROW/FIRST_REVIEWER') "FIRST_REVIEWER",
extractValue(p_data_xml,'/ROWSET/ROW/THIRD_MEDICAL_REVIEW_DECISIO') "THIRD_MEDICAL_REVIEW_DECISIO",
extractValue(p_data_xml,'/ROWSET/ROW/THIRD_REVIEW_CASE_ATTESTATIO') "THIRD_REVIEW_CASE_ATTESTATIO",
extractValue(p_data_xml,'/ROWSET/ROW/THIRD_REVIEWER') "THIRD_REVIEWER",
extractValue(p_data_xml,'/ROWSET/ROW/EXPERT_REVIEW_CASE_ATTESTATI') "EXPERT_REVIEW_CASE_ATTESTATI",
extractValue(p_data_xml,'/ROWSET/ROW/EXPERT_REVIEW_CITATION') "EXPERT_REVIEW_CITATION",
extractValue(p_data_xml,'/ROWSET/ROW/EXPERT_REVIEWER_MD_ID') "EXPERT_REVIEWER_MD_ID",	
extractValue(p_data_xml,'/ROWSET/ROW/STG_EXTRACT_DATE') "STG_EXTRACT_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/CLOSED_DATE') "CLOSED_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/WITHDRAWN_DATE') "WITHDRAWN_DATE"

,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_REOPENING_TYPE') "DEMO_REOPENING_TYPE"
,extractValue(p_data_xml,'/ROWSET/ROW/OTHER_REOPENING_TYPE') "OTHER_REOPENING_TYPE"
,extractValue(p_data_xml,'/ROWSET/ROW/CASE_CURRENTLY_WITH_ALJ') "CASE_CURRENTLY_WITH_ALJ"
,extractValue(p_data_xml,'/ROWSET/ROW/DATE_OF_REQUEST_TO_ALJ') "DATE_OF_REQUEST_TO_ALJ"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_REOPENING_DUE_DATE') "DEMO_REOPENING_DUE_DATE"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_REO_SENT_TO_OMHA_DATE') "DEMO_REO_SENT_TO_OMHA_DATE"
,extractValue(p_data_xml,'/ROWSET/ROW/OMHA_RESPONSE_RECEIVED') "OMHA_RESPONSE_RECEIVED"
,extractValue(p_data_xml,'/ROWSET/ROW/RESPONSE_FROM_OMHA') "RESPONSE_FROM_OMHA"
,extractValue(p_data_xml,'/ROWSET/ROW/ADDITIONAL_INFO_REQUESTED') "ADDITIONAL_INFO_REQUESTED"
,extractValue(p_data_xml,'/ROWSET/ROW/REQUESTED_INFORMATION_DUE') "REQUESTED_INFORMATION_DUE"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_REOPEN_FOLLOW_UP') "DEMO_REOPEN_FOLLOW_UP"
,extractValue(p_data_xml,'/ROWSET/ROW/ADDITIONAL_INFO_RECEIVED') "ADDITIONAL_INFO_RECEIVED"
,extractValue(p_data_xml,'/ROWSET/ROW/REOPENING_DECISION_RESULTS') "REOPENING_DECISION_RESULTS"
,extractValue(p_data_xml,'/ROWSET/ROW/NOT_REOPENED_REASON') "NOT_REOPENED_REASON"
,extractValue(p_data_xml,'/ROWSET/ROW/OMHA_REMAND_REQUEST') "OMHA_REMAND_REQUEST"
,extractValue(p_data_xml,'/ROWSET/ROW/REMAND_ELIGIBILITY_RESPONSE') "REMAND_ELIGIBILITY_RESPONSE"
,extractValue(p_data_xml,'/ROWSET/ROW/REMAND_RECEIVED_DATE') "REMAND_RECEIVED_DATE"
,extractValue(p_data_xml,'/ROWSET/ROW/OMHA_REMAND_REQUEST_RESPONSE') "OMHA_REMAND_REQUEST_RESPONSE"
,extractValue(p_data_xml,'/ROWSET/ROW/OMHA_WITHDRAW_FORM_SENT') "OMHA_WITHDRAW_FORM_SENT"
,extractValue(p_data_xml,'/ROWSET/ROW/OMHA_WITHDRAW_FORM_RETURNED') "OMHA_WITHDRAW_FORM_RETURNED"
,extractValue(p_data_xml,'/ROWSET/ROW/OMHA_NOTIFIED_OF_WITHDRAWL') "OMHA_NOTIFIED_OF_WITHDRAWL"
,extractValue(p_data_xml,'/ROWSET/ROW/ALJ_WITHDRAWAL') "ALJ_WITHDRAWAL"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_REOPENING_APPEAL_NUMBER') "DEMO_REOPENING_APPEAL_NUMBER"
,extractValue(p_data_xml,'/ROWSET/ROW/REOPENING_ANALYSIS_COMPLETED') "REOPENING_ANALYSIS_COMPLETED"
,extractValue(p_data_xml,'/ROWSET/ROW/REOPENING_ANALYSIS_OUTCOME') "REOPENING_ANALYSIS_OUTCOME"
,extractValue(p_data_xml,'/ROWSET/ROW/NOT_PURSUED_BY_CONTR_REASON') "NOT_PURSUED_BY_CONTR_REASON"
,extractValue(p_data_xml,'/ROWSET/ROW/ACK_LETTER_MAILED') "ACK_LETTER_MAILED"
,extractValue(p_data_xml,'/ROWSET/ROW/REO_DECISION_LETTER_MAILED') "REO_DECISION_LETTER_MAILED"
,extractValue(p_data_xml,'/ROWSET/ROW/REOPENING_OUTCOME') "REOPENING_OUTCOME"
,extractValue(p_data_xml,'/ROWSET/ROW/DECLINE_TO_REOPEN_DECISION') "DECLINE_TO_REOPEN_DECISION"
,extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_ATTESTATION_DATE') "APPEAL_ATTESTATION_DATE"
,extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_ATTESTATION') "APPEAL_ATTESTATION"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_SCHEDULED') "DEMO_SCHEDULED"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_NOTIFICATION_LETTER_SENT') "DEMO_NOTIFICATION_LETTER_SENT"
,extractValue(p_data_xml,'/ROWSET/ROW/RESPONSE_DUE') "RESPONSE_DUE"
,extractValue(p_data_xml,'/ROWSET/ROW/RESPONSE_RECEIVED') "RESPONSE_RECEIVED"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_ACCEPTANCE_STATUS') "DEMO_ACCEPTANCE_STATUS"
,extractValue(p_data_xml,'/ROWSET/ROW/TELE_DEMO_FOLLOW_UP') "TELE_DEMO_FOLLOW_UP"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_NOTIFICATION_LTR_RESENT') "DEMO_NOTIFICATION_LTR_RESENT"
,extractValue(p_data_xml,'/ROWSET/ROW/RESCHEDULED_RESPONSE_DUE') "RESCHEDULED_RESPONSE_DUE"
,extractValue(p_data_xml,'/ROWSET/ROW/RESCHEDULE_RESPONSE_RECEIVED') "RESCHEDULE_RESPONSE_RECEIVED"
,extractValue(p_data_xml,'/ROWSET/ROW/VERBAL_CONFIRMATION') "VERBAL_CONFIRMATION"
,extractValue(p_data_xml,'/ROWSET/ROW/RESCHEDULED_DEMO_STATUS') "RESCHEDULED_DEMO_STATUS"
,extractValue(p_data_xml,'/ROWSET/ROW/PROVIDER_OR_SUPPLIER_NAME') "PROVIDER_OR_SUPPLIER_NAME"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_CONFERENCE_STATUS') "DEMO_CONFERENCE_STATUS"
,extractValue(p_data_xml,'/ROWSET/ROW/REVIEW_TYPE') "REVIEW_TYPE"
,extractValue(p_data_xml,'/ROWSET/ROW/EXPERT_REVIEW_DECISION') "EXPERT_REVIEW_DECISION"
,extractValue(p_data_xml,'/ROWSET/ROW/REVIEW_NUMBER') "REVIEW_NUMBER"

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
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_ID') "APPEAL_ID",
extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DATE') "CREATE_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DATE') "COMPLETE_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/CANCELLED_DATE') "CANCELLED_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/ADJUDICATOR') "ADJUDICATOR",  
extractValue(p_data_xml,'/ROWSET/ROW/DEADLINE_DATE') "DEADLINE_DATE", 
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_ISSUE') "APPEAL_ISSUE",
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_ITEM') "APPEAL_ITEM",  
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_NUMBER') "APPEAL_NUMBER", 
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_PRIORITY_ID') "APPEAL_PRIORITY_ID",
extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_RECEIVED') "REQUEST_RECEIVED",  
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_STAGE') "APPEAL_STAGE",  
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_STATUS') "APPEAL_STATUS", 
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_TYPE') "APPEAL_TYPE",
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_DISMISSAL') "APPEAL_DISMISSAL",
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_DISMISSAL_REASON') "APPEAL_DISMISSAL_REASON",
extractValue(p_data_xml,'/ROWSET/ROW/AUTO_FORWARD') "AUTO_FORWARD",
extractValue(p_data_xml,'/ROWSET/ROW/CASE_FILE_REQUEST_DATE') "CASE_FILE_REQUEST_DATE", 
extractValue(p_data_xml,'/ROWSET/ROW/ACKNOWLEDGEMENT_LETTER_DATE') "ACKNOWLEDGEMENT_LETTER_DATE", 
extractValue(p_data_xml,'/ROWSET/ROW/DECISION_MAILED_DATE') "DECISION_MAILED_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/DECISION_SENT_PLAN_DATE') "DECISION_SENT_PLAN_DATE", 
extractValue(p_data_xml,'/ROWSET/ROW/MEDICAL_REVIEW_CHECK') "MEDICAL_REVIEW_CHECK", 
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_PART_ID') "APPEAL_PART_ID", 
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_REASON') "APPEAL_REASON", 
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_TOLLING_DATE') "APPEAL_TOLLING_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_NOTICE_DATE') "APPEAL_NOTICE_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/CASE_FILE_RECEIVED_DATE') "CASE_FILE_RECEIVED_DATE",  
extractValue(p_data_xml,'/ROWSET/ROW/CLAIMED_DATE') "CLAIMED_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/DECISION') "DECISION",
extractValue(p_data_xml,'/ROWSET/ROW/DECISION_NOTIFICATION_METHOD') "DECISION_NOTIFICATION_METHOD",
extractValue(p_data_xml,'/ROWSET/ROW/HPMS') "HPMS",
extractValue(p_data_xml,'/ROWSET/ROW/HPMS_REQUESTED_DATE') "HPMS_REQUESTED_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/IS_REQUEST_FOR_INFORMATION_P') "IS_REQUEST_FOR_INFORMATION_P",
extractValue(p_data_xml,'/ROWSET/ROW/MAC') "MAC",
extractValue(p_data_xml,'/ROWSET/ROW/MEDICARE_TYPE') "MEDICARE_TYPE",
extractValue(p_data_xml,'/ROWSET/ROW/MSP') "MSP",
extractValue(p_data_xml,'/ROWSET/ROW/NEW_DOCUMENTATION_REVIEWED') "NEW_DOCUMENTATION_REVIEWED",
extractValue(p_data_xml,'/ROWSET/ROW/PHYSICIAN_SPECIALTY') "PHYSICIAN_SPECIALTY",
extractValue(p_data_xml,'/ROWSET/ROW/PRECHECK_COMPLETED') "PRECHECK_COMPLETED",
extractValue(p_data_xml,'/ROWSET/ROW/REASON_FOR_APPEAL') "REASON_FOR_APPEAL",
extractValue(p_data_xml,'/ROWSET/ROW/WITHDRAWAL') "WITHDRAWAL",
extractValue(p_data_xml,'/ROWSET/ROW/WITHDRAWAL_REQUEST_SUBMITTED') "WITHDRAWAL_REQUEST_SUBMITTED",
extractValue(p_data_xml,'/ROWSET/ROW/NON_ENGLISH') "NON_ENGLISH",
extractValue(p_data_xml,'/ROWSET/ROW/NON_ENGLISH_OTHER') "NON_ENGLISH_OTHER",
extractValue(p_data_xml,'/ROWSET/ROW/DISPOSITION') "DISPOSITION",
extractValue(p_data_xml,'/ROWSET/ROW/DISPOSITION_EXPLANATION') "DISPOSITION_EXPLANATION",
extractValue(p_data_xml,'/ROWSET/ROW/PROCEDURAL_DECISION_REASON') "PROCEDURAL_DECISION_REASON",
extractValue(p_data_xml,'/ROWSET/ROW/SUBSTANTIVE_REASON') "SUBSTANTIVE_REASON",
extractValue(p_data_xml,'/ROWSET/ROW/FIRST_REVIEW_CASE_ATTESTATIO') "FIRST_REVIEW_CASE_ATTESTATIO",
extractValue(p_data_xml,'/ROWSET/ROW/FIRST_MEDICAL_REVIEW_DECISIO') "FIRST_MEDICAL_REVIEW_DECISIO",
extractValue(p_data_xml,'/ROWSET/ROW/FIRST_REVIEWER') "FIRST_REVIEWER",
extractValue(p_data_xml,'/ROWSET/ROW/THIRD_MEDICAL_REVIEW_DECISIO') "THIRD_MEDICAL_REVIEW_DECISIO",
extractValue(p_data_xml,'/ROWSET/ROW/THIRD_REVIEW_CASE_ATTESTATIO') "THIRD_REVIEW_CASE_ATTESTATIO",
extractValue(p_data_xml,'/ROWSET/ROW/THIRD_REVIEWER') "THIRD_REVIEWER",
extractValue(p_data_xml,'/ROWSET/ROW/EXPERT_REVIEW_CASE_ATTESTATI') "EXPERT_REVIEW_CASE_ATTESTATI",
extractValue(p_data_xml,'/ROWSET/ROW/EXPERT_REVIEW_CITATION') "EXPERT_REVIEW_CITATION",
extractValue(p_data_xml,'/ROWSET/ROW/EXPERT_REVIEWER_MD_ID') "EXPERT_REVIEWER_MD_ID",
extractValue(p_data_xml,'/ROWSET/ROW/STG_EXTRACT_DATE') "STG_EXTRACT_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/CLOSED_DATE') "CLOSED_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/WITHDRAWN_DATE') "WITHDRAWN_DATE"

,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_REOPENING_TYPE') "DEMO_REOPENING_TYPE"
,extractValue(p_data_xml,'/ROWSET/ROW/OTHER_REOPENING_TYPE') "OTHER_REOPENING_TYPE"
,extractValue(p_data_xml,'/ROWSET/ROW/CASE_CURRENTLY_WITH_ALJ') "CASE_CURRENTLY_WITH_ALJ"
,extractValue(p_data_xml,'/ROWSET/ROW/DATE_OF_REQUEST_TO_ALJ') "DATE_OF_REQUEST_TO_ALJ"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_REOPENING_DUE_DATE') "DEMO_REOPENING_DUE_DATE"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_REO_SENT_TO_OMHA_DATE') "DEMO_REO_SENT_TO_OMHA_DATE"
,extractValue(p_data_xml,'/ROWSET/ROW/OMHA_RESPONSE_RECEIVED') "OMHA_RESPONSE_RECEIVED"
,extractValue(p_data_xml,'/ROWSET/ROW/RESPONSE_FROM_OMHA') "RESPONSE_FROM_OMHA"
,extractValue(p_data_xml,'/ROWSET/ROW/ADDITIONAL_INFO_REQUESTED') "ADDITIONAL_INFO_REQUESTED"
,extractValue(p_data_xml,'/ROWSET/ROW/REQUESTED_INFORMATION_DUE') "REQUESTED_INFORMATION_DUE"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_REOPEN_FOLLOW_UP') "DEMO_REOPEN_FOLLOW_UP"
,extractValue(p_data_xml,'/ROWSET/ROW/ADDITIONAL_INFO_RECEIVED') "ADDITIONAL_INFO_RECEIVED"
,extractValue(p_data_xml,'/ROWSET/ROW/REOPENING_DECISION_RESULTS') "REOPENING_DECISION_RESULTS"
,extractValue(p_data_xml,'/ROWSET/ROW/NOT_REOPENED_REASON') "NOT_REOPENED_REASON"
,extractValue(p_data_xml,'/ROWSET/ROW/OMHA_REMAND_REQUEST') "OMHA_REMAND_REQUEST"
,extractValue(p_data_xml,'/ROWSET/ROW/REMAND_ELIGIBILITY_RESPONSE') "REMAND_ELIGIBILITY_RESPONSE"
,extractValue(p_data_xml,'/ROWSET/ROW/REMAND_RECEIVED_DATE') "REMAND_RECEIVED_DATE"
,extractValue(p_data_xml,'/ROWSET/ROW/OMHA_REMAND_REQUEST_RESPONSE') "OMHA_REMAND_REQUEST_RESPONSE"
,extractValue(p_data_xml,'/ROWSET/ROW/OMHA_WITHDRAW_FORM_SENT') "OMHA_WITHDRAW_FORM_SENT"
,extractValue(p_data_xml,'/ROWSET/ROW/OMHA_WITHDRAW_FORM_RETURNED') "OMHA_WITHDRAW_FORM_RETURNED"
,extractValue(p_data_xml,'/ROWSET/ROW/OMHA_NOTIFIED_OF_WITHDRAWL') "OMHA_NOTIFIED_OF_WITHDRAWL"
,extractValue(p_data_xml,'/ROWSET/ROW/ALJ_WITHDRAWAL') "ALJ_WITHDRAWAL"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_REOPENING_APPEAL_NUMBER') "DEMO_REOPENING_APPEAL_NUMBER"
,extractValue(p_data_xml,'/ROWSET/ROW/REOPENING_ANALYSIS_COMPLETED') "REOPENING_ANALYSIS_COMPLETED"
,extractValue(p_data_xml,'/ROWSET/ROW/REOPENING_ANALYSIS_OUTCOME') "REOPENING_ANALYSIS_OUTCOME"
,extractValue(p_data_xml,'/ROWSET/ROW/NOT_PURSUED_BY_CONTR_REASON') "NOT_PURSUED_BY_CONTR_REASON"
,extractValue(p_data_xml,'/ROWSET/ROW/ACK_LETTER_MAILED') "ACK_LETTER_MAILED"
,extractValue(p_data_xml,'/ROWSET/ROW/REO_DECISION_LETTER_MAILED') "REO_DECISION_LETTER_MAILED"
,extractValue(p_data_xml,'/ROWSET/ROW/REOPENING_OUTCOME') "REOPENING_OUTCOME"
,extractValue(p_data_xml,'/ROWSET/ROW/DECLINE_TO_REOPEN_DECISION') "DECLINE_TO_REOPEN_DECISION"
,extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_ATTESTATION_DATE') "APPEAL_ATTESTATION_DATE"
,extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_ATTESTATION') "APPEAL_ATTESTATION"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_SCHEDULED') "DEMO_SCHEDULED"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_NOTIFICATION_LETTER_SENT') "DEMO_NOTIFICATION_LETTER_SENT"
,extractValue(p_data_xml,'/ROWSET/ROW/RESPONSE_DUE') "RESPONSE_DUE"
,extractValue(p_data_xml,'/ROWSET/ROW/RESPONSE_RECEIVED') "RESPONSE_RECEIVED"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_ACCEPTANCE_STATUS') "DEMO_ACCEPTANCE_STATUS"
,extractValue(p_data_xml,'/ROWSET/ROW/TELE_DEMO_FOLLOW_UP') "TELE_DEMO_FOLLOW_UP"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_NOTIFICATION_LTR_RESENT') "DEMO_NOTIFICATION_LTR_RESENT"
,extractValue(p_data_xml,'/ROWSET/ROW/RESCHEDULED_RESPONSE_DUE') "RESCHEDULED_RESPONSE_DUE"
,extractValue(p_data_xml,'/ROWSET/ROW/RESCHEDULE_RESPONSE_RECEIVED') "RESCHEDULE_RESPONSE_RECEIVED"
,extractValue(p_data_xml,'/ROWSET/ROW/VERBAL_CONFIRMATION') "VERBAL_CONFIRMATION"
,extractValue(p_data_xml,'/ROWSET/ROW/RESCHEDULED_DEMO_STATUS') "RESCHEDULED_DEMO_STATUS"
,extractValue(p_data_xml,'/ROWSET/ROW/PROVIDER_OR_SUPPLIER_NAME') "PROVIDER_OR_SUPPLIER_NAME"
,extractValue(p_data_xml,'/ROWSET/ROW/DEMO_CONFERENCE_STATUS') "DEMO_CONFERENCE_STATUS"
,extractValue(p_data_xml,'/ROWSET/ROW/REVIEW_TYPE') "REVIEW_TYPE"
,extractValue(p_data_xml,'/ROWSET/ROW/EXPERT_REVIEW_DECISION') "EXPERT_REVIEW_DECISION"
,extractValue(p_data_xml,'/ROWSET/ROW/REVIEW_NUMBER') "REVIEW_NUMBER"

     into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;

  end;

/*
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
	CLAIM_DATE
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
	   to_date(p_claim_date,BPM_COMMON.DATE_FMT)
	   );

  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
  end;
*/

  -- Insert or update dimension for BPM Semantic model - MW process - Current.
  procedure SET_DMWCUR
      (p_set_type in varchar2,
       p_identifier in varchar2,
       p_bi_id in number,

 p_APPEAL_ID in varchar2,
p_CREATE_DATE in varchar2,
p_COMPLETE_DATE in varchar2,
p_CANCELLED_DATE in varchar2,
p_ADJUDICATOR in varchar2,  
p_DEADLINE_DATE in varchar2, 
p_APPEAL_ISSUE in varchar2,
p_APPEAL_ITEM in varchar2,  
p_APPEAL_NUMBER in varchar2, 
p_APPEAL_PRIORITY_ID in varchar2,
p_REQUEST_RECEIVED in varchar2, 
p_APPEAL_STAGE in varchar2,  
p_APPEAL_STATUS in varchar2, 
p_APPEAL_TYPE in varchar2,
p_APPEAL_DISMISSAL in varchar2,
p_APPEAL_DISMISSAL_REASON in varchar2,
p_AUTO_FORWARD in varchar2,
p_CASE_FILE_REQUEST_DATE in varchar2, 
p_ACKNOWLEDGEMENT_LETTER_DATE in varchar2, 
p_DECISION_MAILED_DATE in varchar2,
p_DECISION_SENT_PLAN_DATE in varchar2, 
p_MEDICAL_REVIEW_CHECK in varchar2,
p_APPEAL_PART_ID in varchar2,
p_APPEAL_REASON in varchar2, 
p_APPEAL_TOLLING_DATE in varchar2,
p_APPEAL_NOTICE_DATE in varchar2,
p_CASE_FILE_RECEIVED_DATE in varchar2,  
p_CLAIMED_DATE in varchar2,
p_DECISION in varchar2,
p_DECISION_NOTIFICATION_METHOD in varchar2,
p_HPMS in varchar2,
p_HPMS_REQUESTED_DATE in varchar2,
p_IS_REQUEST_FOR_INFORMATION_P in varchar2,
p_MAC in varchar2,
p_MEDICARE_TYPE in varchar2,
p_MSP in varchar2,
p_NEW_DOCUMENTATION_REVIEWED in varchar2,
p_PHYSICIAN_SPECIALTY in varchar2,
p_PRECHECK_COMPLETED in varchar2,
p_REASON_FOR_APPEAL in varchar2,
p_WITHDRAWAL in varchar2,
p_WITHDRAWAL_REQUEST_SUBMITTED in varchar2,
p_NON_ENGLISH in varchar2,
p_NON_ENGLISH_OTHER in varchar2,
p_DISPOSITION in varchar2,
p_DISPOSITION_EXPLANATION in varchar2,
p_PROCEDURAL_DECISION_REASON in varchar2,
p_SUBSTANTIVE_REASON in varchar2,
p_FIRST_REVIEW_CASE_ATTESTATIO in varchar2,
p_FIRST_MEDICAL_REVIEW_DECISIO in varchar2,
p_FIRST_REVIEWER in varchar2,
p_THIRD_MEDICAL_REVIEW_DECISIO in varchar2,
p_THIRD_REVIEW_CASE_ATTESTATIO in varchar2,
p_THIRD_REVIEWER in varchar2,
p_EXPERT_REVIEW_CASE_ATTESTATI in varchar2,
p_EXPERT_REVIEW_CITATION in varchar2,
p_EXPERT_REVIEWER_MD_ID in varchar2,
p_STG_EXTRACT_DATE in VARCHAR2,
p_STG_LAST_UPDATE_DATE in VARCHAR2,
p_CLOSED_DATE in varchar2,
p_WITHDRAWN_DATE in varchar2,

p_DEMO_REOPENING_TYPE in varchar2,
p_OTHER_REOPENING_TYPE in varchar2,
p_CASE_CURRENTLY_WITH_ALJ in varchar2,
p_DATE_OF_REQUEST_TO_ALJ in varchar2,
p_DEMO_REOPENING_DUE_DATE in varchar2,
p_DEMO_REO_SENT_TO_OMHA_DATE in varchar2,
p_OMHA_RESPONSE_RECEIVED in varchar2,
p_RESPONSE_FROM_OMHA in varchar2,
p_ADDITIONAL_INFO_REQUESTED in varchar2,
p_REQUESTED_INFORMATION_DUE in varchar2,
p_DEMO_REOPEN_FOLLOW_UP in varchar2,
p_ADDITIONAL_INFO_RECEIVED in varchar2,
p_REOPENING_DECISION_RESULTS in varchar2,
p_NOT_REOPENED_REASON in varchar2,
p_OMHA_REMAND_REQUEST in varchar2,
p_REMAND_ELIGIBILITY_RESPONSE in varchar2,
p_REMAND_RECEIVED_DATE in varchar2,
p_OMHA_REMAND_REQUEST_RESPONSE in varchar2,
p_OMHA_WITHDRAW_FORM_SENT in varchar2,
p_OMHA_WITHDRAW_FORM_RETURNED in varchar2,
p_OMHA_NOTIFIED_OF_WITHDRAWL in varchar2,
p_ALJ_WITHDRAWAL in varchar2,
p_DEMO_REOPENING_APPEAL_NUMBER in varchar2,
p_REOPENING_ANALYSIS_COMPLETED in varchar2,
p_REOPENING_ANALYSIS_OUTCOME in varchar2,
p_NOT_PURSUED_BY_CONTR_REASON in varchar2,
p_ACK_LETTER_MAILED in varchar2,
p_REO_DECISION_LETTER_MAILED in varchar2,
p_REOPENING_OUTCOME in varchar2,
p_DECLINE_TO_REOPEN_DECISION in varchar2,
p_APPEAL_ATTESTATION_DATE in varchar2,
p_APPEAL_ATTESTATION in varchar2,
p_DEMO_SCHEDULED in varchar2,
p_DEMO_NOTIFICATION_LETTER_SENT in varchar2,
p_RESPONSE_DUE in varchar2,
p_RESPONSE_RECEIVED in varchar2,
p_DEMO_ACCEPTANCE_STATUS in varchar2,
p_TELE_DEMO_FOLLOW_UP in varchar2,
p_DEMO_NOTIFICATION_LTR_RESENT in varchar2,
p_RESCHEDULED_RESPONSE_DUE in varchar2,
p_RESCHEDULE_RESPONSE_RECEIVED in varchar2,
p_VERBAL_CONFIRMATION in varchar2,
p_RESCHEDULED_DEMO_STATUS in varchar2,
p_PROVIDER_OR_SUPPLIER_NAME in varchar2,	
p_DEMO_CONFERENCE_STATUS in varchar2,
p_REVIEW_TYPE	 in varchar2,
p_EXPERT_REVIEW_DECISION in varchar2,		
p_REVIEW_NUMBER	 in varchar2
       )
  as

    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DMWCUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dmwcur D_MW_APPEAL_INSTANCE%rowtype := null;
    v_dmwcur_rows number := null;

  begin

  r_dmwcur.ap_bi_id                      :=  p_bi_id;

--timeliness columns go here
r_dmwcur.ACKNOWLEDGEMENT_LETTER_AGE_IN_BUS_DAYS := null;
r_dmwcur.ACKNOWLEDGEMENT_LETTER_AGE_IN_CAL_DAYS := null;
r_dmwcur.ACKNOWLEDGEMENT_LETTER_TIMELINESS_STATUS := null;
r_dmwcur.ACKNOWLEDGEMENT_LETTER_JEOPARDY_FLAG	:= 'N';

r_dmwcur.CASE_FILE_AGE_IN_BUS_DAYS	:= null;
r_dmwcur.CASE_FILE_AGE_IN_CAL_DAYS	:= null;
r_dmwcur.CASE_FILE_TIMELINESS_STATUS := null;
r_dmwcur.CASE_FILE_JEOPARDY_FLAG := 'N';

r_dmwcur.APPEAL_AGE_IN_BUS_DAYS	:= null;
r_dmwcur.APPEAL_AGE_IN_CAL_DAYS	:= null;
r_dmwcur.APPEAL_TIMELINESS_STATUS := null;
r_dmwcur.APPEAL_JEOPARDY_FLAG := 'N';

r_dmwcur.CASE_FILE_ENTRY_AGE_IN_BUS_DAYS := null;
r_dmwcur.CASE_FILE_ENTRY_AGE_IN_CAL_DAYS := null;
r_dmwcur.CASE_FILE_ENTRY_TIMELINESS_STATUS := null;
r_dmwcur.CASE_FILE_ENTRY_JEOPARDY_FLAG := 'N';


r_dmwcur.DECISION_LETTER_AGE_IN_BUS_DAYS := null;
r_dmwcur.DECISION_LETTER_AGE_IN_CAL_DAYS := null;
r_dmwcur.DECISION_LETTER_TIMELINESS_STATUS := null;
r_dmwcur.DECISION_LETTER_JEOPARDY_FLAG := 'N';

r_dmwcur.REQUEST_HPMS_AGE_IN_BUS_DAYS := null;
r_dmwcur.REQUEST_HPMS_AGE_IN_CAL_DAYS := null;
r_dmwcur.REQUEST_HPMS_TIMELINESS_STATUS	:= null;
r_dmwcur.REQUEST_HPMS_JEOPARDY_FLAG := 'N';

r_dmwcur.ADJUDICATOR_PROCESS_AGE_IN_BUS_DAYS := null;
r_dmwcur.ADJUDICATOR_PROCESS_AGE_IN_CAL_DAYS := null;
r_dmwcur.ADJUDICATOR_PROCESS_TIMELINESS_STATUS := null;
r_dmwcur.ADJUDICATOR_PROCESS_JEOPARDY_FLAG := 'N';

r_dmwcur.CASE_FILE_REQUEST_AGE_IN_BUS_DAYS := null;
r_dmwcur.CASE_FILE_REQUEST_AGE_IN_CAL_DAYS := null;
r_dmwcur.CASE_FILE_REQUEST_TIMELINESS_STATUS := null;
r_dmwcur.CASE_FILE_REQUEST_JEOPARDY_FLAG := 'N';

r_dmwcur.APPEAL_ID         :=  p_APPEAL_ID;
r_dmwcur.CREATE_DATE         :=  to_timestamp(p_CREATE_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.COMPLETE_DATE         :=  to_timestamp(p_COMPLETE_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.CANCELLED_DATE         :=  to_timestamp(p_CANCELLED_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.ADJUDICATOR         :=  p_ADJUDICATOR;  
r_dmwcur.DEADLINE_DATE         :=  to_timestamp(p_DEADLINE_DATE,BPM_COMMON.DATE_FMT); 
r_dmwcur.APPEAL_ISSUE         :=  p_APPEAL_ISSUE;
r_dmwcur.APPEAL_ITEM         :=  p_APPEAL_ITEM;  
r_dmwcur.APPEAL_NUMBER         :=  p_APPEAL_NUMBER; 
r_dmwcur.APPEAL_PRIORITY_ID         :=  p_APPEAL_PRIORITY_ID;
r_dmwcur.REQUEST_RECEIVED         :=  to_timestamp(p_REQUEST_RECEIVED,BPM_COMMON.DATE_FMT);
r_dmwcur.APPEAL_STAGE         :=  p_APPEAL_STAGE;  
r_dmwcur.APPEAL_STATUS         :=  p_APPEAL_STATUS; 
r_dmwcur.APPEAL_TYPE         :=  p_APPEAL_TYPE;
r_dmwcur.APPEAL_DISMISSAL         :=  p_APPEAL_DISMISSAL;
r_dmwcur.APPEAL_DISMISSAL_REASON         :=  p_APPEAL_DISMISSAL_REASON;
r_dmwcur.AUTO_FORWARD         :=  p_AUTO_FORWARD;
r_dmwcur.CASE_FILE_REQUEST_DATE         :=  to_timestamp(p_CASE_FILE_REQUEST_DATE,BPM_COMMON.DATE_FMT); 
r_dmwcur.ACKNOWLEDGEMENT_LETTER_DATE        :=  to_timestamp(p_ACKNOWLEDGEMENT_LETTER_DATE,BPM_COMMON.DATE_FMT); 
r_dmwcur.DECISION_MAILED_DATE         :=  to_timestamp(p_DECISION_MAILED_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.DECISION_SENT_PLAN_DATE         := to_timestamp(p_DECISION_SENT_PLAN_DATE,BPM_COMMON.DATE_FMT); 
r_dmwcur.MEDICAL_REVIEW_CHECK         :=  p_MEDICAL_REVIEW_CHECK;
r_dmwcur.APPEAL_PART_ID         :=  p_APPEAL_PART_ID;
r_dmwcur.APPEAL_REASON         :=  p_APPEAL_REASON; 
r_dmwcur.APPEAL_TOLLING_DATE         :=  to_timestamp(p_APPEAL_TOLLING_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.APPEAL_NOTICE_DATE         :=  to_timestamp(p_APPEAL_NOTICE_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.CASE_FILE_RECEIVED_DATE         := to_timestamp(p_CASE_FILE_RECEIVED_DATE,BPM_COMMON.DATE_FMT);  
r_dmwcur.CLAIMED_DATE         :=  to_timestamp(p_CLAIMED_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.DECISION         :=  p_DECISION;
r_dmwcur.DECISION_NOTIFICATION_METHOD         :=  p_DECISION_NOTIFICATION_METHOD;
r_dmwcur.HPMS         :=  p_HPMS;
r_dmwcur.HPMS_REQUESTED_DATE         :=  to_timestamp(p_HPMS_REQUESTED_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.IS_REQUEST_FOR_INFORMATION_P         :=  p_IS_REQUEST_FOR_INFORMATION_P;
r_dmwcur.MAC         :=  p_MAC;
r_dmwcur.MEDICARE_TYPE         :=  p_MEDICARE_TYPE;
r_dmwcur.MSP         :=  p_MSP;
r_dmwcur.NEW_DOCUMENTATION_REVIEWED         :=  p_NEW_DOCUMENTATION_REVIEWED;
r_dmwcur.PHYSICIAN_SPECIALTY         :=  p_PHYSICIAN_SPECIALTY;
r_dmwcur.PRECHECK_COMPLETED         :=  p_PRECHECK_COMPLETED;
r_dmwcur.REASON_FOR_APPEAL         :=  p_REASON_FOR_APPEAL;
r_dmwcur.WITHDRAWAL         :=  p_WITHDRAWAL;
r_dmwcur.WITHDRAWAL_REQUEST_SUBMITTED         :=  p_WITHDRAWAL_REQUEST_SUBMITTED;
r_dmwcur.NON_ENGLISH         :=  p_NON_ENGLISH;
r_dmwcur.NON_ENGLISH_OTHER         :=  p_NON_ENGLISH_OTHER;
r_dmwcur.DISPOSITION         :=  p_DISPOSITION;
r_dmwcur.DISPOSITION_EXPLANATION         :=  p_DISPOSITION_EXPLANATION;
r_dmwcur.PROCEDURAL_DECISION_REASON         :=  p_PROCEDURAL_DECISION_REASON;
r_dmwcur.SUBSTANTIVE_REASON         :=  p_SUBSTANTIVE_REASON;
r_dmwcur.FIRST_REVIEW_CASE_ATTESTATIO         :=  to_timestamp(p_FIRST_REVIEW_CASE_ATTESTATIO,BPM_COMMON.DATE_FMT);
r_dmwcur.FIRST_MEDICAL_REVIEW_DECISIO         :=  p_FIRST_MEDICAL_REVIEW_DECISIO;
r_dmwcur.FIRST_REVIEWER         :=  p_FIRST_REVIEWER;
r_dmwcur.THIRD_MEDICAL_REVIEW_DECISIO         :=  p_THIRD_MEDICAL_REVIEW_DECISIO;
r_dmwcur.THIRD_REVIEW_CASE_ATTESTATIO         :=  to_timestamp(p_THIRD_REVIEW_CASE_ATTESTATIO,BPM_COMMON.DATE_FMT);
r_dmwcur.THIRD_REVIEWER         :=  p_THIRD_REVIEWER;
r_dmwcur.EXPERT_REVIEW_CASE_ATTESTATI         :=  to_timestamp(p_EXPERT_REVIEW_CASE_ATTESTATI,BPM_COMMON.DATE_FMT);
r_dmwcur.EXPERT_REVIEW_CITATION         :=  p_EXPERT_REVIEW_CITATION;
r_dmwcur.EXPERT_REVIEWER_MD_ID         :=  p_EXPERT_REVIEWER_MD_ID;
r_dmwcur.STG_EXTRACT_DATE         :=  to_timestamp(p_STG_EXTRACT_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.STG_LAST_UPDATE_DATE         :=  to_timestamp(p_STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.CLOSED_DATE         :=  to_timestamp(p_CLOSED_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.WITHDRAWN_DATE         :=  to_timestamp(p_WITHDRAWN_DATE,BPM_COMMON.DATE_FMT);

r_dmwcur.DEMO_REOPENING_TYPE		:=  p_DEMO_REOPENING_TYPE;
r_dmwcur.OTHER_REOPENING_TYPE		:=  p_OTHER_REOPENING_TYPE;
r_dmwcur.CASE_CURRENTLY_WITH_ALJ	:=  p_CASE_CURRENTLY_WITH_ALJ;
r_dmwcur.DATE_OF_REQUEST_TO_ALJ		:=  to_timestamp(p_DATE_OF_REQUEST_TO_ALJ,BPM_COMMON.DATE_FMT); 
r_dmwcur.DEMO_REOPENING_DUE_DATE	:=  to_timestamp(p_DEMO_REOPENING_DUE_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.DEMO_REO_SENT_TO_OMHA_DATE	:=  to_timestamp(p_DEMO_REO_SENT_TO_OMHA_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.OMHA_RESPONSE_RECEIVED		:=  to_timestamp(p_OMHA_RESPONSE_RECEIVED,BPM_COMMON.DATE_FMT);
r_dmwcur.RESPONSE_FROM_OMHA		:=  p_RESPONSE_FROM_OMHA;
r_dmwcur.ADDITIONAL_INFO_REQUESTED	:=  to_timestamp(p_ADDITIONAL_INFO_REQUESTED,BPM_COMMON.DATE_FMT);
r_dmwcur.REQUESTED_INFORMATION_DUE	:=  to_timestamp(p_REQUESTED_INFORMATION_DUE,BPM_COMMON.DATE_FMT);
r_dmwcur.DEMO_REOPEN_FOLLOW_UP		:=  to_timestamp(p_DEMO_REOPEN_FOLLOW_UP,BPM_COMMON.DATE_FMT);
r_dmwcur.ADDITIONAL_INFO_RECEIVED	:=  to_timestamp(p_ADDITIONAL_INFO_RECEIVED,BPM_COMMON.DATE_FMT);
r_dmwcur.REOPENING_DECISION_RESULTS	:=  p_REOPENING_DECISION_RESULTS;
r_dmwcur.NOT_REOPENED_REASON		:=  p_NOT_REOPENED_REASON;

r_dmwcur.OMHA_REMAND_REQUEST		:=  to_timestamp(p_OMHA_REMAND_REQUEST,BPM_COMMON.DATE_FMT);
r_dmwcur.REMAND_ELIGIBILITY_RESPONSE	:=  to_timestamp(p_REMAND_ELIGIBILITY_RESPONSE,BPM_COMMON.DATE_FMT);
r_dmwcur.REMAND_RECEIVED_DATE		:=  to_timestamp(p_REMAND_RECEIVED_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.OMHA_REMAND_REQUEST_RESPONSE	:=  p_OMHA_REMAND_REQUEST_RESPONSE;
r_dmwcur.OMHA_WITHDRAW_FORM_SENT	:=  to_timestamp(p_OMHA_WITHDRAW_FORM_SENT,BPM_COMMON.DATE_FMT);
r_dmwcur.OMHA_WITHDRAW_FORM_RETURNED	:=  to_timestamp(p_OMHA_WITHDRAW_FORM_RETURNED,BPM_COMMON.DATE_FMT);
r_dmwcur.OMHA_NOTIFIED_OF_WITHDRAWL	:=  to_timestamp(p_OMHA_NOTIFIED_OF_WITHDRAWL,BPM_COMMON.DATE_FMT);
r_dmwcur.ALJ_WITHDRAWAL			:=  to_timestamp(p_ALJ_WITHDRAWAL,BPM_COMMON.DATE_FMT);
r_dmwcur.DEMO_REOPENING_APPEAL_NUMBER	:=  p_DEMO_REOPENING_APPEAL_NUMBER;
r_dmwcur.REOPENING_ANALYSIS_COMPLETED	:=  to_timestamp(p_REOPENING_ANALYSIS_COMPLETED,BPM_COMMON.DATE_FMT);
r_dmwcur.REOPENING_ANALYSIS_OUTCOME	:=  p_REOPENING_ANALYSIS_OUTCOME;
r_dmwcur.NOT_PURSUED_BY_CONTR_REASON	:=  p_NOT_PURSUED_BY_CONTR_REASON;
r_dmwcur.ACK_LETTER_MAILED		:=  to_timestamp(p_ACK_LETTER_MAILED,BPM_COMMON.DATE_FMT);
r_dmwcur.REO_DECISION_LETTER_MAILED	:=  to_timestamp(p_REO_DECISION_LETTER_MAILED,BPM_COMMON.DATE_FMT);
r_dmwcur.REOPENING_OUTCOME		:=  p_REOPENING_OUTCOME;
r_dmwcur.DECLINE_TO_REOPEN_DECISION	:=  to_timestamp(p_DECLINE_TO_REOPEN_DECISION,BPM_COMMON.DATE_FMT);
r_dmwcur.APPEAL_ATTESTATION_DATE	:=  to_timestamp(p_APPEAL_ATTESTATION_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.APPEAL_ATTESTATION		:=  p_APPEAL_ATTESTATION;
r_dmwcur.DEMO_SCHEDULED			:=  to_timestamp(p_DEMO_SCHEDULED,BPM_COMMON.DATE_FMT);
r_dmwcur.DEMO_NOTIFICATION_LETTER_SENT	:=  to_timestamp(p_DEMO_NOTIFICATION_LETTER_SENT,BPM_COMMON.DATE_FMT);
r_dmwcur.RESPONSE_DUE			:=  to_timestamp(p_RESPONSE_DUE,BPM_COMMON.DATE_FMT);
r_dmwcur.RESPONSE_RECEIVED		:=  to_timestamp(p_RESPONSE_RECEIVED,BPM_COMMON.DATE_FMT);
r_dmwcur.DEMO_ACCEPTANCE_STATUS		:=  p_DEMO_ACCEPTANCE_STATUS;
r_dmwcur.TELE_DEMO_FOLLOW_UP		:=  to_timestamp(p_TELE_DEMO_FOLLOW_UP,BPM_COMMON.DATE_FMT);
r_dmwcur.DEMO_NOTIFICATION_LTR_RESENT	:=  to_timestamp(p_DEMO_NOTIFICATION_LTR_RESENT,BPM_COMMON.DATE_FMT);
r_dmwcur.RESCHEDULED_RESPONSE_DUE	:=  to_timestamp(p_RESCHEDULED_RESPONSE_DUE,BPM_COMMON.DATE_FMT);
r_dmwcur.RESCHEDULE_RESPONSE_RECEIVED	:=  to_timestamp(p_RESCHEDULE_RESPONSE_RECEIVED,BPM_COMMON.DATE_FMT);
r_dmwcur.VERBAL_CONFIRMATION		:=  to_timestamp(p_VERBAL_CONFIRMATION,BPM_COMMON.DATE_FMT);
r_dmwcur.RESCHEDULED_DEMO_STATUS	:=  p_RESCHEDULED_DEMO_STATUS;
r_dmwcur.PROVIDER_OR_SUPPLIER_NAME	:=  p_PROVIDER_OR_SUPPLIER_NAME;	
r_dmwcur.DEMO_CONFERENCE_STATUS		:=  p_DEMO_CONFERENCE_STATUS;
r_dmwcur.REVIEW_TYPE			:=  p_REVIEW_TYPE;
r_dmwcur.EXPERT_REVIEW_DECISION		:=  p_EXPERT_REVIEW_DECISION;		
r_dmwcur.REVIEW_NUMBER			:=  p_REVIEW_NUMBER;


    if p_set_type = 'INSERT' then
      insert into D_MW_APPEAL_INSTANCE
      values r_dmwcur;




    elsif p_set_type = 'UPDATE' then
      update D_MW_APPEAL_INSTANCE
      set row = r_dmwcur
      where AP_BI_ID = p_bi_id;
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
    --v_bucket_start_date date := null;
    --v_bucket_end_date date := null;
    --v_dmwbd_id number := null;

  begin
  DBMS_OUTPUT.put_line('in MW.INSERT_BPM_SEMANTIC...');
    if p_data_version != 3
    then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for MW in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;

    GET_INS_MW_XML(p_new_data_xml,v_new_data);
  	v_identifier := v_new_data.APPEAL_ID;
    --v_BUCKET_START_DATE := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    --v_BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_bi_id := SEQ_AP_BI_ID.nextval;
    v_identifier := v_new_data.APPEAL_ID;

    -- Insert current dimension and fact as a single transaction.
    begin

      SET_DMWCUR
        ('INSERT',
		     v_identifier,
		     v_bi_id,
          v_new_data.APPEAL_ID,
v_new_data.CREATE_DATE,
v_new_data.COMPLETE_DATE,
v_new_data.CANCELLED_DATE,
v_new_data.ADJUDICATOR,  
v_new_data.DEADLINE_DATE, 
v_new_data.APPEAL_ISSUE,
v_new_data.APPEAL_ITEM,  
v_new_data.APPEAL_NUMBER, 
v_new_data.APPEAL_PRIORITY_ID,
v_new_data.REQUEST_RECEIVED, 
v_new_data.APPEAL_STAGE,  
v_new_data.APPEAL_STATUS, 
v_new_data.APPEAL_TYPE,
v_new_data.APPEAL_DISMISSAL,
v_new_data.APPEAL_DISMISSAL_REASON,
v_new_data.AUTO_FORWARD,
v_new_data.CASE_FILE_REQUEST_DATE, 
v_new_data.ACKNOWLEDGEMENT_LETTER_DATE, 
v_new_data.DECISION_MAILED_DATE,
v_new_data.DECISION_SENT_PLAN_DATE, 
v_new_data.MEDICAL_REVIEW_CHECK,
v_new_data.APPEAL_PART_ID,
v_new_data.APPEAL_REASON, 
v_new_data.APPEAL_TOLLING_DATE,
v_new_data.APPEAL_NOTICE_DATE,
v_new_data.CASE_FILE_RECEIVED_DATE,  
v_new_data.CLAIMED_DATE,
v_new_data.DECISION,
v_new_data.DECISION_NOTIFICATION_METHOD,
v_new_data.HPMS,
v_new_data.HPMS_REQUESTED_DATE,
v_new_data.IS_REQUEST_FOR_INFORMATION_P,
v_new_data.MAC,
v_new_data.MEDICARE_TYPE,
v_new_data.MSP,
v_new_data.NEW_DOCUMENTATION_REVIEWED,
v_new_data.PHYSICIAN_SPECIALTY,
v_new_data.PRECHECK_COMPLETED,
v_new_data.REASON_FOR_APPEAL,
v_new_data.WITHDRAWAL,
v_new_data.WITHDRAWAL_REQUEST_SUBMITTED,
v_new_data.NON_ENGLISH,
v_new_data.NON_ENGLISH_OTHER,
v_new_data.DISPOSITION,
v_new_data.DISPOSITION_EXPLANATION,
v_new_data.PROCEDURAL_DECISION_REASON,
v_new_data.SUBSTANTIVE_REASON,
v_new_data.FIRST_REVIEW_CASE_ATTESTATIO,
v_new_data.FIRST_MEDICAL_REVIEW_DECISIO,
v_new_data.FIRST_REVIEWER,
v_new_data.THIRD_MEDICAL_REVIEW_DECISIO,
v_new_data.THIRD_REVIEW_CASE_ATTESTATIO,
v_new_data.THIRD_REVIEWER,
v_new_data.EXPERT_REVIEW_CASE_ATTESTATI,
v_new_data.EXPERT_REVIEW_CITATION,
v_new_data.EXPERT_REVIEWER_MD_ID,
v_new_data.STG_EXTRACT_DATE,
v_new_data.STG_LAST_UPDATE_DATE,
v_new_data.CLOSED_DATE,
v_new_data.WITHDRAWN_DATE,

v_new_data.DEMO_REOPENING_TYPE,
v_new_data.OTHER_REOPENING_TYPE,
v_new_data.CASE_CURRENTLY_WITH_ALJ,
v_new_data.DATE_OF_REQUEST_TO_ALJ,
v_new_data.DEMO_REOPENING_DUE_DATE,
v_new_data.DEMO_REO_SENT_TO_OMHA_DATE,
v_new_data.OMHA_RESPONSE_RECEIVED,
v_new_data.RESPONSE_FROM_OMHA,
v_new_data.ADDITIONAL_INFO_REQUESTED,
v_new_data.REQUESTED_INFORMATION_DUE,
v_new_data.DEMO_REOPEN_FOLLOW_UP,
v_new_data.ADDITIONAL_INFO_RECEIVED,
v_new_data.REOPENING_DECISION_RESULTS,
v_new_data.NOT_REOPENED_REASON,
v_new_data.OMHA_REMAND_REQUEST,
v_new_data.REMAND_ELIGIBILITY_RESPONSE,
v_new_data.REMAND_RECEIVED_DATE,
v_new_data.OMHA_REMAND_REQUEST_RESPONSE,
v_new_data.OMHA_WITHDRAW_FORM_SENT,
v_new_data.OMHA_WITHDRAW_FORM_RETURNED,
v_new_data.OMHA_NOTIFIED_OF_WITHDRAWL,
v_new_data.ALJ_WITHDRAWAL,
v_new_data.DEMO_REOPENING_APPEAL_NUMBER,
v_new_data.REOPENING_ANALYSIS_COMPLETED,
v_new_data.REOPENING_ANALYSIS_OUTCOME,
v_new_data.NOT_PURSUED_BY_CONTR_REASON,
v_new_data.ACK_LETTER_MAILED,
v_new_data.REO_DECISION_LETTER_MAILED,
v_new_data.REOPENING_OUTCOME,
v_new_data.DECLINE_TO_REOPEN_DECISION,
v_new_data.APPEAL_ATTESTATION_DATE,
v_new_data.APPEAL_ATTESTATION,
v_new_data.DEMO_SCHEDULED,
v_new_data.DEMO_NOTIFICATION_LETTER_SENT,
v_new_data.RESPONSE_DUE,
v_new_data.RESPONSE_RECEIVED,
v_new_data.DEMO_ACCEPTANCE_STATUS,
v_new_data.TELE_DEMO_FOLLOW_UP,
v_new_data.DEMO_NOTIFICATION_LTR_RESENT,
v_new_data.RESCHEDULED_RESPONSE_DUE,
v_new_data.RESCHEDULE_RESPONSE_RECEIVED,
v_new_data.VERBAL_CONFIRMATION,
v_new_data.RESCHEDULED_DEMO_STATUS,
v_new_data.PROVIDER_OR_SUPPLIER_NAME,	
v_new_data.DEMO_CONFERENCE_STATUS,
v_new_data.REVIEW_TYPE	,
v_new_data.EXPERT_REVIEW_DECISION,		
v_new_data.REVIEW_NUMBER
         );

/*
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
				        v_dmwbd_id);

*/
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

/*
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
	    h.CLAIM_DATE
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
          v_CLAIM_DATE_old
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

     if trunc(v_last_event_date) > trunc(v_last_event_date_old) and
        (v_task_status_old <> r_dmwbd.task_status or
         v_business_unit_id_old <> r_dmwbd.business_unit_id or
         v_team_id_old <> r_dmwbd.team_id or
         v_last_update_date_old <> r_dmwbd.last_update_date or
         v_status_date_old <> r_dmwbd.status_date or
         v_work_receipt_date_old <> r_dmwbd.work_receipt_date or
         v_claim_date_old <> r_dmwbd.claim_date) then

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
         v_claim_date_old <> r_dmwbd.claim_date) then

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
*/

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
    --v_bucket_start_date date := null;
    --v_bucket_end_date date := null;


  begin
DBMS_OUTPUT.put_line('in MW.INSERT_BPM_SEMANTIC...');
    if p_data_version != 3 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for MW procedure ' || v_procedure_name ||'.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;

	  GET_UPD_MW_XML(p_old_data_xml,v_old_data);
    GET_UPD_MW_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.APPEAL_ID;
    --v_bucket_start_date := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    --v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);

	select AP_BI_ID
    into v_bi_id
    from D_MW_APPEAL_INSTANCE
    where APPEAL_ID = v_identifier;

begin
     SET_DMWCUR
        ('UPDATE',
		     v_identifier,
		     v_bi_id,
          v_new_data.APPEAL_ID,
v_new_data.CREATE_DATE,
v_new_data.COMPLETE_DATE,
v_new_data.CANCELLED_DATE,
v_new_data.ADJUDICATOR,  
v_new_data.DEADLINE_DATE, 
v_new_data.APPEAL_ISSUE,
v_new_data.APPEAL_ITEM,  
v_new_data.APPEAL_NUMBER, 
v_new_data.APPEAL_PRIORITY_ID,
v_new_data.REQUEST_RECEIVED, 
v_new_data.APPEAL_STAGE,  
v_new_data.APPEAL_STATUS, 
v_new_data.APPEAL_TYPE,
v_new_data.APPEAL_DISMISSAL,
v_new_data.APPEAL_DISMISSAL_REASON,
v_new_data.AUTO_FORWARD,
v_new_data.CASE_FILE_REQUEST_DATE, 
v_new_data.ACKNOWLEDGEMENT_LETTER_DATE, 
v_new_data.DECISION_MAILED_DATE,
v_new_data.DECISION_SENT_PLAN_DATE, 
v_new_data.MEDICAL_REVIEW_CHECK,
v_new_data.APPEAL_PART_ID,
v_new_data.APPEAL_REASON, 
v_new_data.APPEAL_TOLLING_DATE,
v_new_data.APPEAL_NOTICE_DATE,
v_new_data.CASE_FILE_RECEIVED_DATE,  
v_new_data.CLAIMED_DATE,
v_new_data.DECISION,
v_new_data.DECISION_NOTIFICATION_METHOD,
v_new_data.HPMS,
v_new_data.HPMS_REQUESTED_DATE,
v_new_data.IS_REQUEST_FOR_INFORMATION_P,
v_new_data.MAC,
v_new_data.MEDICARE_TYPE,
v_new_data.MSP,
v_new_data.NEW_DOCUMENTATION_REVIEWED,
v_new_data.PHYSICIAN_SPECIALTY,
v_new_data.PRECHECK_COMPLETED,
v_new_data.REASON_FOR_APPEAL,
v_new_data.WITHDRAWAL,
v_new_data.WITHDRAWAL_REQUEST_SUBMITTED,
v_new_data.NON_ENGLISH,
v_new_data.NON_ENGLISH_OTHER,
v_new_data.DISPOSITION,
v_new_data.DISPOSITION_EXPLANATION,
v_new_data.PROCEDURAL_DECISION_REASON,
v_new_data.SUBSTANTIVE_REASON,
v_new_data.FIRST_REVIEW_CASE_ATTESTATIO,
v_new_data.FIRST_MEDICAL_REVIEW_DECISIO,
v_new_data.FIRST_REVIEWER,
v_new_data.THIRD_MEDICAL_REVIEW_DECISIO,
v_new_data.THIRD_REVIEW_CASE_ATTESTATIO,
v_new_data.THIRD_REVIEWER,
v_new_data.EXPERT_REVIEW_CASE_ATTESTATI,
v_new_data.EXPERT_REVIEW_CITATION,
v_new_data.EXPERT_REVIEWER_MD_ID,
v_new_data.STG_EXTRACT_DATE,
v_new_data.STG_LAST_UPDATE_DATE,
v_new_data.CLOSED_DATE,
v_new_data.WITHDRAWN_DATE,

v_new_data.DEMO_REOPENING_TYPE,
v_new_data.OTHER_REOPENING_TYPE,
v_new_data.CASE_CURRENTLY_WITH_ALJ,
v_new_data.DATE_OF_REQUEST_TO_ALJ,
v_new_data.DEMO_REOPENING_DUE_DATE,
v_new_data.DEMO_REO_SENT_TO_OMHA_DATE,
v_new_data.OMHA_RESPONSE_RECEIVED,
v_new_data.RESPONSE_FROM_OMHA,
v_new_data.ADDITIONAL_INFO_REQUESTED,
v_new_data.REQUESTED_INFORMATION_DUE,
v_new_data.DEMO_REOPEN_FOLLOW_UP,
v_new_data.ADDITIONAL_INFO_RECEIVED,
v_new_data.REOPENING_DECISION_RESULTS,
v_new_data.NOT_REOPENED_REASON,
v_new_data.OMHA_REMAND_REQUEST,
v_new_data.REMAND_ELIGIBILITY_RESPONSE,
v_new_data.REMAND_RECEIVED_DATE,
v_new_data.OMHA_REMAND_REQUEST_RESPONSE,
v_new_data.OMHA_WITHDRAW_FORM_SENT,
v_new_data.OMHA_WITHDRAW_FORM_RETURNED,
v_new_data.OMHA_NOTIFIED_OF_WITHDRAWL,
v_new_data.ALJ_WITHDRAWAL,
v_new_data.DEMO_REOPENING_APPEAL_NUMBER,
v_new_data.REOPENING_ANALYSIS_COMPLETED,
v_new_data.REOPENING_ANALYSIS_OUTCOME,
v_new_data.NOT_PURSUED_BY_CONTR_REASON,
v_new_data.ACK_LETTER_MAILED,
v_new_data.REO_DECISION_LETTER_MAILED,
v_new_data.REOPENING_OUTCOME,
v_new_data.DECLINE_TO_REOPEN_DECISION,
v_new_data.APPEAL_ATTESTATION_DATE,
v_new_data.APPEAL_ATTESTATION,
v_new_data.DEMO_SCHEDULED,
v_new_data.DEMO_NOTIFICATION_LETTER_SENT,
v_new_data.RESPONSE_DUE,
v_new_data.RESPONSE_RECEIVED,
v_new_data.DEMO_ACCEPTANCE_STATUS,
v_new_data.TELE_DEMO_FOLLOW_UP,
v_new_data.DEMO_NOTIFICATION_LTR_RESENT,
v_new_data.RESCHEDULED_RESPONSE_DUE,
v_new_data.RESCHEDULE_RESPONSE_RECEIVED,
v_new_data.VERBAL_CONFIRMATION,
v_new_data.RESCHEDULED_DEMO_STATUS,
v_new_data.PROVIDER_OR_SUPPLIER_NAME,	
v_new_data.DEMO_CONFERENCE_STATUS,
v_new_data.REVIEW_TYPE	,
v_new_data.EXPERT_REVIEW_DECISION,		
v_new_data.REVIEW_NUMBER
         );

/*
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
				        v_dmwbd_id);

*/
      commit;

  exception
   when OTHERS then
   rollback;
    v_sql_code := SQLCODE;
    v_log_message := 'Rolled back latest current dimension and fact changes.'  || SQLERRM;
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
    v_log_message := SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);
   raise;

  end UPDATE_BPM_SEMANTIC;

end Process_Appeals;
/

alter session set plsql_code_type = interpreted;