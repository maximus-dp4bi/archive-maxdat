alter session set plsql_code_type = native;

create or replace package COMMUNITY_OUTREACH as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

procedure CALC_DCMORCUR;
  
FUNCTION GET_AGE_IN_BUSINESS_DAYS(
    p_create_date   IN DATE,
    p_complete_date IN DATE)
  RETURN NUMBER;
  
FUNCTION GET_AGE_IN_CALENDAR_DAYS(
    p_create_date   IN DATE,
    p_complete_date IN DATE)
  RETURN NUMBER; 

FUNCTION GET_OUTREACH_CYCL_TIME(
    p_create_date   IN DATE,
    p_complete_date IN DATE)
  RETURN NUMBER; 
  
  
FUNCTION GET_JEOPARDY_FLAG(
    p_review_event_start_date IN DATE,
    p_review_event_end_date IN DATE,
    p_wait_for_event_start_date IN DATE,
    p_wait_for_event_end_date IN DATE,
    p_record_outcome_start_date IN DATE,
    p_record_outcome_end_date IN DATE
    )
  RETURN VARCHAR2;
 
FUNCTION GET_REVIEW_TIMELINESS_STATUS(
    p_assd_review_event   IN DATE,
    p_ased_review_event   IN DATE )
  RETURN VARCHAR2;
  
FUNCTION GET_PUB_TO_CAL_TIMELINESS_STAT(
    p_ASSD_WAIT_FOR_EVENT IN DATE,
    p_ASeD_WAIT_FOR_EVENT IN DATE )
  RETURN VARCHAR2;
  
FUNCTION GET_RECORD_OUTCOME_TIME_STAT(
    p_assd_record_outcome IN DATE,
    p_ased_record_outcome IN DATE )
  RETURN VARCHAR2; 

    /* 
  Include: 
    CECOM_ID    
    STG_LAST_UPDATE_DATE
  Exclude:
    AGE_IN_BUSINESS_DAYS
    AGE_IN_CALENDAR_DAYS
    APP_CYCLE_BUS_DAYS
    APP_CYCLE_CAL_DAYS
    JEOPARDY_FLAG
    TIMELINESS_STATUS
    DAYS_UNTIL_TIMEOUT
  */
  
  type T_INS_CMOR_XML is record 
    (
   --  ACTIVITY_CREATE_DT varchar2(19),
     ALL_PLANS_INVITED varchar2(4000),
     ALTERNATE_1_DATE varchar2(19),
     ALTERNATE_2_DATE varchar2(19),
     ALTERNATE_3_DATE varchar2(19),
     ASED_RECORD_OUTCOME varchar2(19),
     ASED_REVIEW_EVENT varchar2(19),
     ASED_WAIT_FOR_EVENT varchar2(19),
     ASF_RECORD_OUTCOME varchar2(1),
     ASF_REVIEW_EVENT varchar2(1),
     ASF_WAIT_FOR_EVENT varchar2(1),
     ASPB_RECORD_OUTCOME varchar2(256),
     ASPB_REVIEW_EVENT varchar2(256),
     ASSD_RECORD_OUTCOME varchar2(19),
     ASSD_REVIEW_EVENT varchar2(19),
     ASSD_WAIT_FOR_EVENT varchar2(19),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(40),
     CANCEL_REASON varchar2(40),
     CECOM_ID varchar2(100),
     CLIENT_REG_REQ_IND varchar2(10),
    -- COMMUNITY_ACTIVITY_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     CONTACT_NAME varchar2(60),
     DENTAL_EVENT_IND varchar2(4000),
     DENTAL_INVITED_IND varchar2(4000),
     DETAILS_SURVEY_ID varchar2(100),
     DURATION varchar2(256),
     ESTIMATED_ATTENDEES varchar2(10),
     EVENT_DATE varchar2(19),
     EVENT_RECEIVED_FROM varchar2(4000),
     EVENT_RECEIVED_VIA varchar2(4000),
     EVENT_TITLE varchar2(4000),
     EVENT_TYPE varchar2(256),
     GENERAL_PUBLIC_IND varchar2(4000),
     GROUP_INDIVIDUAL_IND varchar2(10),
     GWF_ATTENDED varchar2(1),
     GWF_OUTREACH_APPROVED varchar2(1),
     GWF_PUSH_TO_CALENDAR varchar2(1),
     INSTANCE_END_DATE varchar2(19),
     INSTANCE_START_DATE varchar2(19),
     INSTANCE_STATUS varchar2(10),
     LANGUAGES_SUPPORTED varchar2(4000),
     MIGRANTS_IND varchar2(4000),
     MULTILINGUAL_IND varchar2(10),
     NORTHSTAR_EVENT_IND varchar2(4000),
     NORTHSTAR_INVITED_IND varchar2(4000),
     NOTE_REF_ID varchar2(100),
     NUMBER_OF_OCCURENCES varchar2(100),
     OTHER_GROUPS_IND varchar2(4000),
     OUTREACH_SESSION_ID varchar2(100),
     PLANS_TO_ATTEND varchar2(4000),
     PLAN_EXCLUSIVE_IND varchar2(4000),
     PLAN_RSVP_IND varchar2(4000),
     PLAN_SPONSORED_IND varchar2(4000),
     PREGNANT_WOMEN_TEENS_IND varchar2(4000),
     PREPARATION_TIME varchar2(20),
     PRESENTER_NAME varchar2(256),
     PUBLIC_ALLOWED_IND varchar2(10),
     RECURRING_FREQUENCY varchar2(256),
     RECURRING_GROUP_ID varchar2(100),
     REQUESTED_BY varchar2(60),
     REQUEST_DATE varchar2(19),
     REQUEST_METHOD varchar2(256),
     RESCHEDULE_IND varchar2(10),
     RESTRICTED_AGENCY_IND varchar2(4000),
     RSVP_DEADLINE varchar2(4000),
     SCHOOL_AGED_FAMILIES_IND varchar2(4000),
     SENIORS_IND varchar2(4000),
     SESSION_CREATED_BY varchar2(80),
     SESSION_CREATE_DT varchar2(19),
     SESSION_END_TIME varchar2(256),
     SESSION_START_TIME varchar2(256),
     SESSION_STATUS varchar2(256),
     SESSION_STATUS_DT varchar2(19),
     SESSION_UPDATED_BY varchar2(80),
     SESSION_UPDATED_DT varchar2(19),
     SITE_CAPACITY varchar2(100),
     SITE_CITY varchar2(40),
     SITE_COUNTY varchar2(40),
     SITE_ID varchar2(100),
     SITE_LANGUAGE varchar2(512),
     SITE_NAME varchar2(120),
     SITE_SERVICE_AREA varchar2(256),
     SITE_STATE varchar2(2),
     SITE_STATUS varchar2(10),
     SITE_TYPE varchar2(256),
     SITE_ZIP_CD varchar2(32),
     STARPLUS_EVENT_IND varchar2(4000),
     STARPLUS_INVITED_IND varchar2(4000),
     STAR_EVENT_IND varchar2(4000),
     STAR_INVITED_IND varchar2(4000),
     STG_LAST_UPDATE_DATE varchar2(19),
     SURVEY_COMMENTS varchar2(4000),
     SURVEY_NAME varchar2(256),
     TRAVEL_TIME varchar2(20)
    );
      
  /* 
  Include:     
    STG_LAST_UPDATE_DATE
  Exclude:
    AGE_IN_BUSINESS_DAYS
    AGE_IN_CALENDAR_DAYS
    APP_CYCLE_BUS_DAYS
    APP_CYCLE_CAL_DAYS
    JEOPARDY_FLAG
    TIMELINESS_STATUS
    DAYS_UNTIL_TIMEOUT
  */
  
  type T_UPD_CMOR_XML is record
    (
    -- ACTIVITY_CREATE_DT varchar2(19),
     ALL_PLANS_INVITED varchar2(4000),
     ALTERNATE_1_DATE varchar2(19),
     ALTERNATE_2_DATE varchar2(19),
     ALTERNATE_3_DATE varchar2(19),
     ASED_RECORD_OUTCOME varchar2(19),
     ASED_REVIEW_EVENT varchar2(19),
     ASED_WAIT_FOR_EVENT varchar2(19),
     ASF_RECORD_OUTCOME varchar2(1),
     ASF_REVIEW_EVENT varchar2(1),
     ASF_WAIT_FOR_EVENT varchar2(1),
     ASPB_RECORD_OUTCOME varchar2(256),
     ASPB_REVIEW_EVENT varchar2(256),
     ASSD_RECORD_OUTCOME varchar2(19),
     ASSD_REVIEW_EVENT varchar2(19),
     ASSD_WAIT_FOR_EVENT varchar2(19),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(40),
     CANCEL_REASON varchar2(40),
     CLIENT_REG_REQ_IND varchar2(10),
   --  COMMUNITY_ACTIVITY_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     CONTACT_NAME varchar2(60),
     DENTAL_EVENT_IND varchar2(4000),
     DENTAL_INVITED_IND varchar2(4000),
     DETAILS_SURVEY_ID varchar2(100),
     DURATION varchar2(256),
     ESTIMATED_ATTENDEES varchar2(10),
     EVENT_DATE varchar2(19),
     EVENT_RECEIVED_FROM varchar2(4000),
     EVENT_RECEIVED_VIA varchar2(4000),
     EVENT_TITLE varchar2(4000),
     EVENT_TYPE varchar2(256),
     GENERAL_PUBLIC_IND varchar2(4000),
     GROUP_INDIVIDUAL_IND varchar2(10),
     GWF_ATTENDED varchar2(1),
     GWF_OUTREACH_APPROVED varchar2(1),
     GWF_PUSH_TO_CALENDAR varchar2(1),
     INSTANCE_END_DATE varchar2(19),
     INSTANCE_START_DATE varchar2(19),
     INSTANCE_STATUS varchar2(10),
     LANGUAGES_SUPPORTED varchar2(4000),
     MIGRANTS_IND varchar2(4000),
     MULTILINGUAL_IND varchar2(10),
     NORTHSTAR_EVENT_IND varchar2(4000),
     NORTHSTAR_INVITED_IND varchar2(4000),
     NOTE_REF_ID varchar2(100),
     NUMBER_OF_OCCURENCES varchar2(100),
     OTHER_GROUPS_IND varchar2(4000),
     OUTREACH_SESSION_ID varchar2(100),
     PLANS_TO_ATTEND varchar2(4000),
     PLAN_EXCLUSIVE_IND varchar2(4000),
     PLAN_RSVP_IND varchar2(4000),
     PLAN_SPONSORED_IND varchar2(4000),
     PREGNANT_WOMEN_TEENS_IND varchar2(4000),
     PREPARATION_TIME varchar2(20),
     PRESENTER_NAME varchar2(256),
     PUBLIC_ALLOWED_IND varchar2(10),
     RECURRING_FREQUENCY varchar2(256),
     RECURRING_GROUP_ID varchar2(100),
     REQUESTED_BY varchar2(60),
     REQUEST_DATE varchar2(19),
     REQUEST_METHOD varchar2(256),
     RESCHEDULE_IND varchar2(10),
     RESTRICTED_AGENCY_IND varchar2(4000),
     RSVP_DEADLINE varchar2(4000),
     SCHOOL_AGED_FAMILIES_IND varchar2(4000),
     SENIORS_IND varchar2(4000),
     SESSION_CREATED_BY varchar2(80),
     SESSION_CREATE_DT varchar2(19),
     SESSION_END_TIME varchar2(256),
     SESSION_START_TIME varchar2(256),
     SESSION_STATUS varchar2(256),
     SESSION_STATUS_DT varchar2(19),
     SESSION_UPDATED_BY varchar2(80),
     SESSION_UPDATED_DT varchar2(19),
     SITE_CAPACITY varchar2(100),
     SITE_CITY varchar2(40),
     SITE_COUNTY varchar2(40),
     SITE_ID varchar2(100),
     SITE_LANGUAGE varchar2(512),
     SITE_NAME varchar2(120),
     SITE_SERVICE_AREA varchar2(256),
     SITE_STATE varchar2(2),
     SITE_STATUS varchar2(10),
     SITE_TYPE varchar2(256),
     SITE_ZIP_CD varchar2(32),
     STARPLUS_EVENT_IND varchar2(4000),
     STARPLUS_INVITED_IND varchar2(4000),
     STAR_EVENT_IND varchar2(4000),
     STAR_INVITED_IND varchar2(4000),
     STG_LAST_UPDATE_DATE varchar2(19),
     SURVEY_COMMENTS varchar2(4000),
     SURVEY_NAME varchar2(256),
     TRAVEL_TIME varchar2(20)
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

create or replace 
package body COMMUNITY_OUTREACH as

  v_bem_id number := 17; -- 'COMMUNITY OUTREACH'
  v_bil_id number := 17; -- 'OUTREACH SESSION ID'
  v_bsl_id number := 17; -- 'CORP_ETL_COMM_OUTREACH'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  
  v_calc_dcmorcur_job_name varchar2(30) := 'CALC_DCMORCUR';

FUNCTION GET_AGE_IN_BUSINESS_DAYS(
    p_create_date   IN DATE,
    p_complete_date IN DATE)
  RETURN NUMBER
AS
BEGIN
  RETURN BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,NVL(p_complete_date,sysdate));
END;


FUNCTION GET_AGE_IN_CALENDAR_DAYS(
    p_create_date   IN DATE,
    p_complete_date IN DATE)
  RETURN NUMBER
AS
BEGIN
  RETURN TRUNC(NVL(p_complete_date,sysdate)) - TRUNC(p_create_date);
END;


FUNCTION GET_OUTREACH_CYCL_TIME(
    p_create_date   IN DATE,
    p_complete_date IN DATE)
  RETURN NUMBER
AS
BEGIN
IF p_complete_date IS NOT NULL  THEN
  RETURN TRUNC(p_complete_date) - TRUNC(p_create_date);
ELSE RETURN NULL;
END IF;
END;


FUNCTION GET_JEOPARDY_FLAG(
    p_review_event_start_date IN DATE,
    p_review_event_end_date IN DATE,
    p_wait_for_event_start_date IN DATE,
    p_wait_for_event_end_date IN DATE,
    p_record_outcome_start_date IN DATE,
    p_record_outcome_end_date IN DATE
    )
  RETURN VARCHAR2
IS
  v_assd_dt       DATE;
  v_jeopardy_days NUMBER;
BEGIN
  SELECT ASSD_DT,
    OUT_VAR
  INTO v_assd_dt,
    v_jeopardy_days
  FROM
    (SELECT 
      CASE
        WHEN (p_review_event_start_date IS NOT NULL
        AND p_review_event_end_date   IS NULL)
        THEN p_review_event_start_date
        WHEN (p_wait_for_event_start_date IS NOT NULL
        AND p_wait_for_event_end_date   IS NULL)
        THEN p_wait_for_event_start_date
        WHEN (p_record_outcome_start_date IS NOT NULL
        AND p_record_outcome_end_date   IS NULL)
        THEN p_record_outcome_start_date
        else sysdate
      END AS ASSD_DT,
      CASE
        WHEN (p_review_event_start_date IS NOT NULL
        AND p_review_event_end_date   IS NULL)
        THEN 1
        WHEN (p_wait_for_event_start_date IS NOT NULL
        AND p_wait_for_event_start_date   IS NULL)
        THEN 2
        WHEN (p_record_outcome_start_date IS NOT NULL
        AND p_record_outcome_end_date   IS NULL)
        THEN 3
        else 0
      END AS RULE_NO
    FROM dual
    )A
  JOIN corp_etl_list_lkup B
  ON A.Rule_no         = b.ref_id
  AND REF_TYPE         = 'COMM_OUTREACH'
  AND NAME             = 'CommumityORCH_Jeopardy_Days';

IF sysdate-v_assd_dt >= v_jeopardy_days THEN
    RETURN 'Y';
  ELSE
    RETURN 'N';
  END IF;
END; 



FUNCTION GET_REVIEW_TIMELINESS_STATUS(
    p_assd_review_event	in date,
    p_ased_review_event	in date
)
  RETURN VARCHAR2
IS
v_threshold_days number;
begin

select /*+ RESULT_CACHE +*/ OUT_VAR 
into v_threshold_days
from CORP_ETL_LIST_LKUP
where  
  REF_TYPE = 'COMM_OUTREACH'
  and NAME = 'CommumityORCH_Threshold'
  and REF_ID = 1;

if p_ased_review_event is null then
return 'Not Complete';
elsif p_ased_review_event is not null and bus_days_between(p_assd_review_event,p_ased_review_event) <= v_threshold_days then
return 'Timely';
elsif p_ased_review_event is not null and bus_days_between(p_assd_review_event,p_ased_review_event) > v_threshold_days then
return 'Untimely';
ELSE
    RETURN 'Not Required';
  END IF;
END;



FUNCTION GET_PUB_TO_CAL_TIMELINESS_STAT(
    p_ASSD_WAIT_FOR_EVENT	in date,
    p_ASeD_WAIT_FOR_EVENT	in date
)
  RETURN VARCHAR2
IS
v_threshold_days number;
begin

select /*+ RESULT_CACHE +*/ OUT_VAR 
into v_threshold_days
from CORP_ETL_LIST_LKUP
where 
  REF_TYPE = 'COMM_OUTREACH'
  and NAME = 'CommumityORCH_Threshold'
  and REF_ID = 2;

if p_ASeD_WAIT_FOR_EVENT is null then
return 'Not Complete';
elsif p_ASeD_WAIT_FOR_EVENT is not null and p_ASeD_WAIT_FOR_EVENT - p_ASSD_WAIT_FOR_EVENT <= v_threshold_days then
return 'Timely';
elsif p_ASeD_WAIT_FOR_EVENT is not null and p_ASeD_WAIT_FOR_EVENT - p_ASSD_WAIT_FOR_EVENT > v_threshold_days then
return 'Untimely';
ELSE
    RETURN 'Not Required';
  END IF;
END;


FUNCTION GET_RECORD_OUTCOME_TIME_STAT(
    p_assd_record_outcome	in date,
    p_ased_record_outcome	in date
)
  RETURN VARCHAR2
IS
v_threshold_days number;
begin

select /*+ RESULT_CACHE +*/ OUT_VAR 
into v_threshold_days
from CORP_ETL_LIST_LKUP
where  
  REF_TYPE = 'COMM_OUTREACH'
  and NAME = 'CommumityORCH_Threshold'
  and REF_ID = 3;

if p_ased_record_outcome is null then
return 'Not Complete';
elsif p_ased_record_outcome is not null and bus_days_between(p_assd_record_outcome,p_ased_record_outcome) <= v_threshold_days then
return 'Timely';
elsif p_ased_record_outcome is not null and bus_days_between(p_assd_record_outcome,p_ased_record_outcome) > v_threshold_days then
return 'Untimely';
ELSE
    RETURN 'Not Required';
  END IF;
END;



-- Calculate column values in BPM Semantic table D_CMOR_CURRENT.
  procedure CALC_DCMORCUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DCMORCUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin
  
update D_CMOR_CURRENT
    set  
      AGE_IN_BUSINESS_DAYS= GET_AGE_IN_BUSINESS_DAYS(SESSION_CREATE_DATE,COMPLETE_DATE),
      AGE_IN_CALENDAR_DAYS = GET_AGE_IN_CALENDAR_DAYS(SESSION_CREATE_DATE,COMPLETE_DATE),
      OUTREACH_CYCLE_TIME = GET_OUTREACH_CYCL_TIME(SESSION_CREATE_DATE,COMPLETE_DATE),
      JEOPARDY_FLAG = GET_JEOPARDY_FLAG(REVIEW_EVENT_START_DATE,REVIEW_EVENT_END_DATE,WAIT_FOR_EVENT_START_DATE,WAIT_FOR_EVENT_END_DATE,RECORD_OUTCOME_START_DATE,RECORD_OUTCOME_END_DATE),   
      REVIEW_TIMELINESS_STATUS = GET_REVIEW_TIMELINESS_STATUS(REVIEW_EVENT_START_DATE,REVIEW_EVENT_END_DATE),
      PUBLISH_TO_CAL_TIMELY_STATUS = GET_PUB_TO_CAL_TIMELINESS_STAT(WAIT_FOR_EVENT_START_DATE,WAIT_FOR_EVENT_END_DATE),
      RCRD_OUTCOME_TIMELY_STATUS = GET_RECORD_OUTCOME_TIME_STAT(RECORD_OUTCOME_START_DATE,RECORD_OUTCOME_END_DATE)
    
        
    where 
    INSTANCE_END_DATE is null;
     -- COMPLETE_DATE is null 
     -- and CANCEL_DATE is null;
    
    v_num_rows_updated := sql%rowcount;
 
 commit;

     v_log_message := v_num_rows_updated  || ' D_CMOR_CURRENT rows updated with calculated attributes by D_CMOR_CURRENT.';
     BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);
     
   exception
   
     when others then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);

  end;
 

 
-- Get dimension ID for BPM Semantic model - Community Outreach - SESSION_STATUS.
  procedure GET_DCMORSS_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_session_status in varchar2,
      p_dcmorss_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMORSS_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

   SELECT DCMORSS_ID
    INTO p_dcmorss_id
    FROM D_CMOR_SESSION_STATUS
    WHERE 
          session_status  = p_session_status
           OR (session_status   IS NULL AND p_session_status IS NULL);
      
   exception
     when NO_DATA_FOUND then
       p_dcmorss_id := SEQ_DCMORSS_ID.nextval;
       begin
         insert into D_CMOR_SESSION_STATUS (DCMORSS_ID,session_status)
         values (p_dcmorss_id,p_session_status);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DCMORSS_ID into p_dcmorss_id
           from D_CMOR_SESSION_STATUS
           where 
              session_status  = p_session_status
             OR (session_status   IS NULL AND p_session_status IS NULL);
             
         when OTHERS then

           v_sql_code := SQLCODE;
           v_log_message := SQLERRM;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
           raise;

       end;

     when OTHERS then
     
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
       raise;
       
  end; 
 
-- Get record for Community Outreach insert XML.
  procedure GET_INS_CMOR_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_CMOR_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_CMOR_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin  

    select
     -- extractValue(p_data_xml,'/ROWSET/ROW/ACTIVITY_CREATE_DT') "ACTIVITY_CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/ALL_PLANS_INVITED') "ALL_PLANS_INVITED",
      extractValue(p_data_xml,'/ROWSET/ROW/ALTERNATE_1_DATE') "ALTERNATE_1_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/ALTERNATE_2_DATE') "ALTERNATE_2_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/ALTERNATE_3_DATE') "ALTERNATE_3_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RECORD_OUTCOME') "ASED_RECORD_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_REVIEW_EVENT') "ASED_REVIEW_EVENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_WAIT_FOR_EVENT') "ASED_WAIT_FOR_EVENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECORD_OUTCOME') "ASF_RECORD_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_REVIEW_EVENT') "ASF_REVIEW_EVENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_WAIT_FOR_EVENT') "ASF_WAIT_FOR_EVENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_RECORD_OUTCOME') "ASPB_RECORD_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_REVIEW_EVENT') "ASPB_REVIEW_EVENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RECORD_OUTCOME') "ASSD_RECORD_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_REVIEW_EVENT') "ASSD_REVIEW_EVENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_WAIT_FOR_EVENT') "ASSD_WAIT_FOR_EVENT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CECOM_ID') "CECOM_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_REG_REQ_IND') "CLIENT_REG_REQ_IND",
      --extractValue(p_data_xml,'/ROWSET/ROW/COMMUNITY_ACTIVITY_ID') "COMMUNITY_ACTIVITY_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_NAME') "CONTACT_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/DENTAL_EVENT_IND') "DENTAL_EVENT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/DENTAL_INVITED_IND') "DENTAL_INVITED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/DETAILS_SURVEY_ID') "DETAILS_SURVEY_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/DURATION') "DURATION",
      extractValue(p_data_xml,'/ROWSET/ROW/ESTIMATED_ATTENDEES') "ESTIMATED_ATTENDEES",
      extractValue(p_data_xml,'/ROWSET/ROW/EVENT_DATE') "EVENT_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/EVENT_RECEIVED_FROM') "EVENT_RECEIVED_FROM",
      extractValue(p_data_xml,'/ROWSET/ROW/EVENT_RECEIVED_VIA') "EVENT_RECEIVED_VIA",
      extractValue(p_data_xml,'/ROWSET/ROW/EVENT_TITLE') "EVENT_TITLE",
      extractValue(p_data_xml,'/ROWSET/ROW/EVENT_TYPE') "EVENT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERAL_PUBLIC_IND') "GENERAL_PUBLIC_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/GROUP_INDIVIDUAL_IND') "GROUP_INDIVIDUAL_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_ATTENDED') "GWF_ATTENDED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_OUTREACH_APPROVED') "GWF_OUTREACH_APPROVED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_PUSH_TO_CALENDAR') "GWF_PUSH_TO_CALENDAR",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_END_DATE')"INSTANCE_END_DATE",
		  extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_START_DATE')"INSTANCE_START_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LANGUAGES_SUPPORTED') "LANGUAGES_SUPPORTED",
      extractValue(p_data_xml,'/ROWSET/ROW/MIGRANTS_IND') "MIGRANTS_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/MULTILINGUAL_IND') "MULTILINGUAL_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/NORTHSTAR_EVENT_IND') "NORTHSTAR_EVENT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/NORTHSTAR_INVITED_IND') "NORTHSTAR_INVITED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTE_REF_ID') "NOTE_REF_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/NUMBER_OF_OCCURENCES') "NUMBER_OF_OCCURENCES",
      extractValue(p_data_xml,'/ROWSET/ROW/OTHER_GROUPS_IND') "OTHER_GROUPS_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_SESSION_ID') "OUTREACH_SESSION_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/PLANS_TO_ATTEND') "PLANS_TO_ATTEND",
      extractValue(p_data_xml,'/ROWSET/ROW/PLAN_EXCLUSIVE_IND') "PLAN_EXCLUSIVE_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/PLAN_RSVP_IND') "PLAN_RSVP_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/PLAN_SPONSORED_IND') "PLAN_SPONSORED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/PREGNANT_WOMEN_TEENS_IND') "PREGNANT_WOMEN_TEENS_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/PREPARATION_TIME') "PREPARATION_TIME",
      extractValue(p_data_xml,'/ROWSET/ROW/PRESENTER_NAME') "PRESENTER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PUBLIC_ALLOWED_IND') "PUBLIC_ALLOWED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/RECURRING_FREQUENCY') "RECURRING_FREQUENCY",
      extractValue(p_data_xml,'/ROWSET/ROW/RECURRING_GROUP_ID') "RECURRING_GROUP_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUESTED_BY') "REQUESTED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_DATE') "REQUEST_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_METHOD') "REQUEST_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/RESCHEDULE_IND') "RESCHEDULE_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/RESTRICTED_AGENCY_IND') "RESTRICTED_AGENCY_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/RSVP_DEADLINE') "RSVP_DEADLINE",
      extractValue(p_data_xml,'/ROWSET/ROW/SCHOOL_AGED_FAMILIES_IND') "SCHOOL_AGED_FAMILIES_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/SENIORS_IND') "SENIORS_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_CREATED_BY') "SESSION_CREATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_CREATE_DT') "SESSION_CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_END_TIME') "SESSION_END_TIME",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_START_TIME') "SESSION_START_TIME",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_STATUS') "SESSION_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_STATUS_DT') "SESSION_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_UPDATED_BY') "SESSION_UPDATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_UPDATED_DT') "SESSION_UPDATED_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_CAPACITY') "SITE_CAPACITY",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_CITY') "SITE_CITY",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_COUNTY') "SITE_COUNTY",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_ID') "SITE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_LANGUAGE') "SITE_LANGUAGE",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_NAME') "SITE_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_SERVICE_AREA') "SITE_SERVICE_AREA",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_STATE') "SITE_STATE",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_STATUS') "SITE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_TYPE') "SITE_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_ZIP_CD') "SITE_ZIP_CD",
      extractValue(p_data_xml,'/ROWSET/ROW/STARPLUS_EVENT_IND') "STARPLUS_EVENT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/STARPLUS_INVITED_IND') "STARPLUS_INVITED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/STAR_EVENT_IND') "STAR_EVENT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/STAR_INVITED_IND') "STAR_INVITED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/SURVEY_COMMENTS') "SURVEY_COMMENTS",
      extractValue(p_data_xml,'/ROWSET/ROW/SURVEY_NAME') "SURVEY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/TRAVEL_TIME') "TRAVEL_TIME"  
   into p_data_record
       from dual;
     
     exception
     
       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
         raise; 
         
  end;
  
  
 -- Get record for Community Outreach update XML. 
  procedure GET_UPD_CMOR_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_CMOR_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_CMOR_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin 

     select
     -- extractValue(p_data_xml,'/ROWSET/ROW/ACTIVITY_CREATE_DT') "ACTIVITY_CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/ALL_PLANS_INVITED') "ALL_PLANS_INVITED",
      extractValue(p_data_xml,'/ROWSET/ROW/ALTERNATE_1_DATE') "ALTERNATE_1_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/ALTERNATE_2_DATE') "ALTERNATE_2_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/ALTERNATE_3_DATE') "ALTERNATE_3_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RECORD_OUTCOME') "ASED_RECORD_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_REVIEW_EVENT') "ASED_REVIEW_EVENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_WAIT_FOR_EVENT') "ASED_WAIT_FOR_EVENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECORD_OUTCOME') "ASF_RECORD_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_REVIEW_EVENT') "ASF_REVIEW_EVENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_WAIT_FOR_EVENT') "ASF_WAIT_FOR_EVENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_RECORD_OUTCOME') "ASPB_RECORD_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_REVIEW_EVENT') "ASPB_REVIEW_EVENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RECORD_OUTCOME') "ASSD_RECORD_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_REVIEW_EVENT') "ASSD_REVIEW_EVENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_WAIT_FOR_EVENT') "ASSD_WAIT_FOR_EVENT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_REG_REQ_IND') "CLIENT_REG_REQ_IND",
     -- extractValue(p_data_xml,'/ROWSET/ROW/COMMUNITY_ACTIVITY_ID') "COMMUNITY_ACTIVITY_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CONTACT_NAME') "CONTACT_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/DENTAL_EVENT_IND') "DENTAL_EVENT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/DENTAL_INVITED_IND') "DENTAL_INVITED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/DETAILS_SURVEY_ID') "DETAILS_SURVEY_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/DURATION') "DURATION",
      extractValue(p_data_xml,'/ROWSET/ROW/ESTIMATED_ATTENDEES') "ESTIMATED_ATTENDEES",
      extractValue(p_data_xml,'/ROWSET/ROW/EVENT_DATE') "EVENT_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/EVENT_RECEIVED_FROM') "EVENT_RECEIVED_FROM",
      extractValue(p_data_xml,'/ROWSET/ROW/EVENT_RECEIVED_VIA') "EVENT_RECEIVED_VIA",
      extractValue(p_data_xml,'/ROWSET/ROW/EVENT_TITLE') "EVENT_TITLE",
      extractValue(p_data_xml,'/ROWSET/ROW/EVENT_TYPE') "EVENT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERAL_PUBLIC_IND') "GENERAL_PUBLIC_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/GROUP_INDIVIDUAL_IND') "GROUP_INDIVIDUAL_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_ATTENDED') "GWF_ATTENDED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_OUTREACH_APPROVED') "GWF_OUTREACH_APPROVED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_PUSH_TO_CALENDAR') "GWF_PUSH_TO_CALENDAR",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_END_DATE')"INSTANCE_END_DATE",
		  extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_START_DATE')"INSTANCE_START_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LANGUAGES_SUPPORTED') "LANGUAGES_SUPPORTED",
      extractValue(p_data_xml,'/ROWSET/ROW/MIGRANTS_IND') "MIGRANTS_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/MULTILINGUAL_IND') "MULTILINGUAL_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/NORTHSTAR_EVENT_IND') "NORTHSTAR_EVENT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/NORTHSTAR_INVITED_IND') "NORTHSTAR_INVITED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/NOTE_REF_ID') "NOTE_REF_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/NUMBER_OF_OCCURENCES') "NUMBER_OF_OCCURENCES",
      extractValue(p_data_xml,'/ROWSET/ROW/OTHER_GROUPS_IND') "OTHER_GROUPS_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/OUTREACH_SESSION_ID') "OUTREACH_SESSION_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/PLANS_TO_ATTEND') "PLANS_TO_ATTEND",
      extractValue(p_data_xml,'/ROWSET/ROW/PLAN_EXCLUSIVE_IND') "PLAN_EXCLUSIVE_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/PLAN_RSVP_IND') "PLAN_RSVP_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/PLAN_SPONSORED_IND') "PLAN_SPONSORED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/PREGNANT_WOMEN_TEENS_IND') "PREGNANT_WOMEN_TEENS_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/PREPARATION_TIME') "PREPARATION_TIME",
      extractValue(p_data_xml,'/ROWSET/ROW/PRESENTER_NAME') "PRESENTER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PUBLIC_ALLOWED_IND') "PUBLIC_ALLOWED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/RECURRING_FREQUENCY') "RECURRING_FREQUENCY",
      extractValue(p_data_xml,'/ROWSET/ROW/RECURRING_GROUP_ID') "RECURRING_GROUP_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUESTED_BY') "REQUESTED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_DATE') "REQUEST_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_METHOD') "REQUEST_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/RESCHEDULE_IND') "RESCHEDULE_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/RESTRICTED_AGENCY_IND') "RESTRICTED_AGENCY_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/RSVP_DEADLINE') "RSVP_DEADLINE",
      extractValue(p_data_xml,'/ROWSET/ROW/SCHOOL_AGED_FAMILIES_IND') "SCHOOL_AGED_FAMILIES_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/SENIORS_IND') "SENIORS_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_CREATED_BY') "SESSION_CREATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_CREATE_DT') "SESSION_CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_END_TIME') "SESSION_END_TIME",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_START_TIME') "SESSION_START_TIME",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_STATUS') "SESSION_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_STATUS_DT') "SESSION_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_UPDATED_BY') "SESSION_UPDATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/SESSION_UPDATED_DT') "SESSION_UPDATED_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_CAPACITY') "SITE_CAPACITY",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_CITY') "SITE_CITY",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_COUNTY') "SITE_COUNTY",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_ID') "SITE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_LANGUAGE') "SITE_LANGUAGE",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_NAME') "SITE_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_SERVICE_AREA') "SITE_SERVICE_AREA",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_STATE') "SITE_STATE",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_STATUS') "SITE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_TYPE') "SITE_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/SITE_ZIP_CD') "SITE_ZIP_CD",
      extractValue(p_data_xml,'/ROWSET/ROW/STARPLUS_EVENT_IND') "STARPLUS_EVENT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/STARPLUS_INVITED_IND') "STARPLUS_INVITED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/STAR_EVENT_IND') "STAR_EVENT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/STAR_INVITED_IND') "STAR_INVITED_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/SURVEY_COMMENTS') "SURVEY_COMMENTS",
      extractValue(p_data_xml,'/ROWSET/ROW/SURVEY_NAME') "SURVEY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/TRAVEL_TIME') "TRAVEL_TIME"
     into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;
  
  end;  
  

-- Insert fact for BPM Semantic model - Community Outreach process. 
    procedure INS_FCMORBD 
    (p_identifier in varchar2,
     p_start_date in date,
     p_end_date in date,
     p_bi_id in number,
     p_dcmorss_id in number,  
     p_last_update_date in varchar2,
    -- p_stg_last_update_date in varchar2,   
     p_fcmorbd_id out number) 
   as
         v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FCMORBD';
         v_sql_code number := null;
         v_log_message clob := null;
         v_bucket_start_date date := null;
         v_bucket_end_date date := null;
       --  v_stg_last_update_date date := null;
         v_last_update_date date:=null;
    begin
     -- v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      v_last_update_date:=to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
      p_fcmorbd_id := SEQ_FCMORBD_ID.nextval;
      
      v_bucket_start_date := to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt);
      if p_end_date is null then
        v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      else 
        v_bucket_end_date := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      end if;  
      
       -- Validate fact date ranges.
            if p_start_date < v_bucket_start_date
              --or p_start_date > v_bucket_end_date
              or to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt) > v_bucket_end_date
              or v_bucket_start_date > v_bucket_end_date
              or v_bucket_end_date < v_bucket_start_date
            then
              v_sql_code := -20030;
              v_log_message := 'Attempted to insert invalid fact date range.  ' || 
                'D_DATE = ' || p_start_date || 
                ' BUCKET_START_DATE = ' || to_char(v_bucket_start_date,v_date_bucket_fmt) ||
                ' BUCKET_END_DATE = ' || to_char(v_bucket_end_date,v_date_bucket_fmt);
              BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
              RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
      end if;
      
  insert into F_CMOR_BY_DATE
    (FCMORBD_ID, 
     D_DATE, 
     BUCKET_START_DATE, 
     BUCKET_END_DATE, 
     CMOR_BI_ID, 
     DCMORSS_ID, 
     LAST_UPDATE_BY_DATE, 
     INVENTORY_COUNT, 
     CREATION_COUNT, 
     COMPLETION_COUNT )
	values
	(p_fcmorbd_id,
	  p_start_date,
	  to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt),
	  v_bucket_end_date,
	  p_bi_id,
	  p_dcmorss_id,
    v_last_update_date,
	  case 
	  when p_end_date is null then 1
	  else 0
	  end,
	  1,
	  case 
	    when p_end_date is null then 0
	    else 1
	    end
	 );
      exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
      
  end; 
 
 
 -- Insert or update dimension for BPM Semantic model - Community Outreach process - Current.
  procedure SET_DCMORCUR  
  (p_set_type in varchar2,
   p_identifier in varchar2,
   p_bi_id in number,
    p_outreach_session_id            in number,
    p_request_date                   in varchar ,
    p_requested_by                   in varchar,
    p_request_method                 in varchar,
    p_session_created_by             in varchar ,
    p_session_create_date            in varchar ,
    p_event_type                     in varchar ,
    p_cur_session_status             in varchar ,
    p_session_status_date            in varchar ,
    p_public_allowed_indicator       in varchar ,
    p_multilingual_indicator         in varchar ,
    p_group_individual_indicator     in varchar ,
    p_estimated_attendees            in varchar ,
    p_event_date                     in varchar ,
    p_alternative_date_1             in varchar ,
    p_alternative_date_2             in varchar ,
    p_alternative_date_3             in varchar ,
    p_preparation_time               in varchar ,
    p_travel_time                    in varchar ,
    p_presenter_name                 in varchar ,
    p_site_id                        in number ,
    p_site_type                      in varchar ,
    p_site_language                  in varchar ,
    p_site_city                      in varchar ,
    p_site_zip_code                  in varchar ,
    p_site_county                    in varchar ,
    p_site_state                     in varchar ,
    p_site_name                      in varchar ,
    p_site_capacity                  in number ,
    p_site_service_area              in varchar ,
    p_site_status                    in varchar ,
    p_contact_name                   in varchar,
    p_session_updated_by             in varchar ,
    p_session_updated_dt             in varchar ,
    p_note_ref_id                    in number ,
    p_reschedule_indicator           in varchar ,
    p_recurring_group_id             in number ,
    p_recurring_frequency           in varchar ,
    p_number_of_occurences           in number ,
    p_client_reg_req_indicator       in varchar ,
    p_session_start_time             in varchar ,
    p_session_end_time               in varchar ,
    p_details_survey_id              in number ,
    p_survey_name                    in varchar ,
    p_event_title                    in varchar ,
    p_languages_supported            in varchar ,
    p_event_received_from            in varchar ,
    p_event_received_via             in varchar ,
    p_general_public_indicator       in varchar ,
    p_seniors_indicator              in varchar ,
    p_restricted_to_agency_ind in varchar ,
    p_school_aged_families_ind in varchar ,
    p_migrants_indicator             in varchar ,
    p_pregnant_women_teens_ind in varchar ,
    p_other_groups_indicator         in varchar ,
    p_plans_to_attend                in varchar ,
    p_all_plans_invited_indicator    in varchar ,
    p_star_invited_indicator         in varchar ,
    p_starplus_invited_indicator     in varchar ,
    p_dental_invited_indicator       in varchar ,
    p_northstar_invited_indicator    in varchar ,
    p_plan_sponsored_indicator       in varchar ,
    p_plan_exclusive_indicator       in varchar ,
    p_plan_rsvp_indicator            in varchar ,
    p_rsvp_deadline                  in varchar ,
    p_star_event_indicator           in varchar ,
    p_star_plus_event_indicator      in varchar ,
    p_northstar_event_indicator      in varchar ,
    p_dental_event_indicator         in varchar ,
    p_survey_comments                in varchar ,
    p_complete_date                  in varchar ,
    p_cancel_date                    in varchar ,
    p_cancel_by                      in varchar ,
    p_cancel_reason                  in varchar ,
    p_cancel_method                  in varchar ,
    p_instance_start_date in varchar2,
    p_instance_end_date in varchar2,
    p_instance_status                in varchar ,
    p_review_event_start_date        in varchar ,
    p_review_event_end_date          in varchar ,
    p_review_event_performed_by      in varchar ,
    p_wait_for_event_start_date      in varchar ,
    p_wait_for_event_end_date        in varchar ,
    p_record_outcome_start_date      in varchar ,
    p_record_outcome_end_date        in varchar ,
    p_record_outcome_performed_by    in varchar ,
 --   p_community_activity_id          in number ,
 --   p_activity_create_date           in varchar, 
    p_duration         in varchar 
  --  p_age_in_business_days           in number ,
  --  p_age_in_calendar_days           in number ,
  --  p_outreach_cycle_time            in number ,
 --   p_jeopardy_date                  in varchar ,
 --   p_review_timeliness_status       in varchar ,
 --   p_publish_to_cal_timely_status   in varchar ,
 --   p_rcrd_outcome_timely_status     in varchar
   ) 
   
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DCMORCUR';
       v_sql_code number := null;
       v_log_message clob := null;
       r_dcmorcur D_CMOR_CURRENT%rowtype := null;
    --   v_jeopardy_flag varchar2(1) := null; 
  begin
  
r_dcmorcur.CMOR_BI_ID := p_bi_id;  
r_dcmorcur.outreach_session_id	:=p_outreach_session_id; 
r_dcmorcur.request_date	:=to_date(p_request_date,BPM_COMMON.DATE_FMT);
r_dcmorcur.requested_by	:=p_requested_by;
r_dcmorcur.request_method	:=p_request_method;
r_dcmorcur.session_created_by	:=p_session_created_by; 
r_dcmorcur.session_create_date	:=to_date(p_session_create_date,BPM_COMMON.DATE_FMT); 
r_dcmorcur.event_type	:=p_event_type; 
r_dcmorcur.cur_session_status	:=p_cur_session_status; 
r_dcmorcur.session_status_date	:=to_date(p_session_status_date,BPM_COMMON.DATE_FMT); 
r_dcmorcur.public_allowed_indicator	:=p_public_allowed_indicator; 
r_dcmorcur.multilingual_indicator	:=p_multilingual_indicator; 
r_dcmorcur.group_individual_indicator	:=p_group_individual_indicator; 
r_dcmorcur.estimated_attendees	:=p_estimated_attendees; 
r_dcmorcur.event_date	:=to_date(p_event_date,BPM_COMMON.DATE_FMT); 
r_dcmorcur.alternative_date_1	:=to_date(p_alternative_date_1,BPM_COMMON.DATE_FMT); 
r_dcmorcur.alternative_date_2	:=to_date(p_alternative_date_2,BPM_COMMON.DATE_FMT); 
r_dcmorcur.alternative_date_3	:=to_date(p_alternative_date_3,BPM_COMMON.DATE_FMT); 
r_dcmorcur.preparation_time	:=p_preparation_time; 
r_dcmorcur.travel_time	:=p_travel_time; 
r_dcmorcur.presenter_name	:=p_presenter_name; 
r_dcmorcur.site_id	:=p_site_id;
r_dcmorcur.site_type	:=p_site_type; 
r_dcmorcur.site_language	:=p_site_language; 
r_dcmorcur.site_city	:=p_site_city; 
r_dcmorcur.site_zip_code	:=p_site_zip_code; 
r_dcmorcur.site_county	:=p_site_county; 
r_dcmorcur.site_state	:=p_site_state; 
r_dcmorcur.site_name	:=p_site_name; 
r_dcmorcur.site_capacity	:=p_site_capacity;
r_dcmorcur.site_service_area	:=p_site_service_area; 
r_dcmorcur.site_status	:=p_site_status; 
r_dcmorcur.contact_name	:=p_contact_name;
r_dcmorcur.session_updated_by	:=p_session_updated_by; 
r_dcmorcur.session_updated_dt	:=to_date(p_session_updated_dt,BPM_COMMON.DATE_FMT); 
r_dcmorcur.note_ref_id	:=p_note_ref_id;
r_dcmorcur.reschedule_indicator	:=p_reschedule_indicator; 
r_dcmorcur.recurring_group_id	:=p_recurring_group_id;
r_dcmorcur.recurring_frequency	:=p_recurring_frequency; 
r_dcmorcur.number_of_occurences	:=p_number_of_occurences;
r_dcmorcur.client_reg_req_indicator	:=p_client_reg_req_indicator; 
r_dcmorcur.session_start_time	:=p_session_start_time; 
r_dcmorcur.session_end_time	:=p_session_end_time; 
r_dcmorcur.details_survey_id	:=p_details_survey_id;
r_dcmorcur.survey_name	:=p_survey_name; 
r_dcmorcur.event_title	:=p_event_title; 
r_dcmorcur.languages_supported	:=p_languages_supported; 
r_dcmorcur.event_received_from	:=p_event_received_from; 
r_dcmorcur.event_received_via	:=p_event_received_via; 
r_dcmorcur.general_public_indicator	:=p_general_public_indicator; 
r_dcmorcur.seniors_indicator	:=p_seniors_indicator; 
r_dcmorcur.restricted_to_agency_indicator	:=p_restricted_to_agency_ind; 
r_dcmorcur.school_aged_families_indicator	:=p_school_aged_families_ind; 
r_dcmorcur.migrants_indicator	:=p_migrants_indicator; 
r_dcmorcur.pregnant_women_teens_indicator	:=p_pregnant_women_teens_ind; 
r_dcmorcur.other_groups_indicator	:=p_other_groups_indicator; 
r_dcmorcur.plans_to_attend	:=p_plans_to_attend; 
r_dcmorcur.all_plans_invited_indicator	:=p_all_plans_invited_indicator; 
r_dcmorcur.star_invited_indicator	:=p_star_invited_indicator; 
r_dcmorcur.starplus_invited_indicator	:=p_starplus_invited_indicator; 
r_dcmorcur.dental_invited_indicator	:=p_dental_invited_indicator; 
r_dcmorcur.northstar_invited_indicator	:=p_northstar_invited_indicator; 
r_dcmorcur.plan_sponsored_indicator	:=p_plan_sponsored_indicator; 
r_dcmorcur.plan_exclusive_indicator	:=p_plan_exclusive_indicator; 
r_dcmorcur.plan_rsvp_indicator	:=p_plan_rsvp_indicator; 
r_dcmorcur.rsvp_deadline	:=p_rsvp_deadline; 
r_dcmorcur.star_event_indicator	:=p_star_event_indicator; 
r_dcmorcur.star_plus_event_indicator	:=p_star_plus_event_indicator; 
r_dcmorcur.northstar_event_indicator	:=p_northstar_event_indicator; 
r_dcmorcur.dental_event_indicator	:=p_dental_event_indicator; 
r_dcmorcur.survey_comments	:=p_survey_comments; 
r_dcmorcur.complete_date	:=to_date(p_complete_date,BPM_COMMON.DATE_FMT); 
r_dcmorcur.cancel_date	:=to_date(p_cancel_date,BPM_COMMON.DATE_FMT); 
r_dcmorcur.cancel_by	:=p_cancel_by; 
r_dcmorcur.cancel_reason	:=p_cancel_reason; 
r_dcmorcur.cancel_method	:=p_cancel_method; 
r_dcmorcur.instance_status	:=p_instance_status; 
r_dcmorcur.review_event_start_date	:=to_date(p_review_event_start_date,BPM_COMMON.DATE_FMT); 
r_dcmorcur.review_event_end_date	:=to_date(p_review_event_end_date,BPM_COMMON.DATE_FMT); 
r_dcmorcur.review_event_performed_by	:=p_review_event_performed_by; 
r_dcmorcur.wait_for_event_start_date	:=to_date(p_wait_for_event_start_date,BPM_COMMON.DATE_FMT); 
r_dcmorcur.wait_for_event_end_date	:=to_date(p_wait_for_event_end_date,BPM_COMMON.DATE_FMT); 
r_dcmorcur.record_outcome_start_date	:=to_date(p_record_outcome_start_date,BPM_COMMON.DATE_FMT); 
r_dcmorcur.record_outcome_end_date	:=to_date(p_record_outcome_end_date,BPM_COMMON.DATE_FMT); 
r_dcmorcur.record_outcome_performed_by	:=p_record_outcome_performed_by; 
--r_dcmorcur.community_activity_id	:=p_community_activity_id;
--r_dcmorcur.activity_create_date	:=to_date(p_activity_create_date,BPM_COMMON.DATE_FMT); 
r_dcmorcur.duration	:=p_duration; 
r_dcmorcur.instance_start_date := to_date(p_instance_start_date,BPM_COMMON.DATE_FMT);
r_dcmorcur.instance_end_date := to_date(p_instance_end_date,BPM_COMMON.DATE_FMT);
r_dcmorcur.AGE_IN_BUSINESS_DAYS	:=GET_AGE_IN_BUSINESS_DAYS(r_dcmorcur.session_create_date,r_dcmorcur.complete_date);
r_dcmorcur.AGE_IN_CALENDAR_DAYS	:=GET_AGE_IN_CALENDAR_DAYS(r_dcmorcur.session_create_date,r_dcmorcur.complete_date);
r_dcmorcur.OUTREACH_CYCLE_TIME	:=GET_OUTREACH_CYCL_TIME(r_dcmorcur.SESSION_CREATE_DATE,r_dcmorcur.COMPLETE_DATE);
r_dcmorcur.JEOPARDY_FLAG	:=GET_JEOPARDY_FLAG(r_dcmorcur.review_event_start_date,r_dcmorcur.review_event_end_date,r_dcmorcur.wait_for_event_start_date,r_dcmorcur.wait_for_event_end_date,r_dcmorcur.record_outcome_start_date,r_dcmorcur.record_outcome_end_date);
r_dcmorcur.REVIEW_TIMELINESS_STATUS	:=GET_REVIEW_TIMELINESS_STATUS(r_dcmorcur.review_event_start_date,r_dcmorcur.review_event_end_date); 
r_dcmorcur.PUBLISH_TO_CAL_TIMELY_STATUS	:=GET_PUB_TO_CAL_TIMELINESS_STAT (r_dcmorcur.wait_for_event_start_date,r_dcmorcur.wait_for_event_end_date); 
r_dcmorcur.RCRD_OUTCOME_TIMELY_STATUS	:=GET_RECORD_OUTCOME_TIME_STAT(r_dcmorcur.record_outcome_start_date,r_dcmorcur.record_outcome_end_date);


 
  if p_set_type = 'INSERT' then
       insert into D_CMOR_CURRENT
       values r_dcmorcur;
     elsif p_set_type = 'UPDATE' then
       begin
         update D_CMOR_CURRENT
         set row = r_dcmorcur
         where CMOR_BI_ID = p_bi_id;
       end;
     else
       v_log_message := 'Unexpected p_set_type value ' || p_set_type || ' in procedure ' || v_procedure_name || '.';
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
      
    v_new_data T_INS_CMOR_XML := null;
      
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
      
    v_start_date date := null;
    v_end_date date := null; 
    
    v_dcmorss_id  number    := null;
    v_fcmorbd_id number := null;
    
       
    begin
      
        if p_data_version > 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Community Outreach in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);        
        end if;
          
        GET_INS_CMOR_XML(p_new_data_xml,v_new_data);
    
        v_identifier := v_new_data.OUTREACH_SESSION_ID ;
        v_start_date := to_date(v_new_data.INSTANCE_START_DATE,BPM_COMMON.DATE_FMT);
        --v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
        v_end_date := to_date(v_new_data.INSTANCE_END_DATE,BPM_COMMON.DATE_FMT);
        BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
        v_bi_id := SEQ_BI_ID.nextval;        
        
   --  v_receipt_date:= to_date(v_new_data.RECEIPT_DT,BPM_COMMON.DATE_FMT);   
   --  v_jeopardy_status:= GET_JEOPARDY_STATUS(v_receipt_date,v_new_data.INSTANCE_STATUS) ;  
        
     GET_DCMORSS_ID (v_identifier,v_bi_id ,v_new_data.session_status ,v_dcmorss_id );    
  
 -- Insert current dimension and fact as a single transaction.
    begin
          
      commit;
 
SET_DCMORCUR
  ('INSERT',v_identifier,v_bi_id
,v_new_data.OUTREACH_SESSION_ID
,v_new_data.REQUEST_DATE
,v_new_data.REQUESTED_BY
,v_new_data.REQUEST_METHOD
,v_new_data.SESSION_CREATED_BY
,v_new_data.SESSION_CREATE_DT
,v_new_data.EVENT_TYPE
,v_new_data.SESSION_STATUS
,v_new_data.SESSION_STATUS_DT
,v_new_data.PUBLIC_ALLOWED_IND
,v_new_data.MULTILINGUAL_IND
,v_new_data.GROUP_INDIVIDUAL_IND
,v_new_data.ESTIMATED_ATTENDEES
,v_new_data.EVENT_DATE
,v_new_data.ALTERNATE_1_DATE
,v_new_data.ALTERNATE_2_DATE
,v_new_data.ALTERNATE_3_DATE
,v_new_data.PREPARATION_TIME
,v_new_data.TRAVEL_TIME
,v_new_data.PRESENTER_NAME
,v_new_data.SITE_ID
,v_new_data.SITE_TYPE
,v_new_data.SITE_LANGUAGE
,v_new_data.SITE_CITY
,v_new_data.SITE_ZIP_CD
,v_new_data.SITE_COUNTY
,v_new_data.SITE_STATE
,v_new_data.SITE_NAME
,v_new_data.SITE_CAPACITY
,v_new_data.SITE_SERVICE_AREA
,v_new_data.SITE_STATUS
,v_new_data.CONTACT_NAME
,v_new_data.SESSION_UPDATED_BY
,v_new_data.SESSION_UPDATED_DT
,v_new_data.NOTE_REF_ID
,v_new_data.RESCHEDULE_IND
,v_new_data.RECURRING_GROUP_ID
,v_new_data.RECURRING_FREQUENCY
,v_new_data.NUMBER_OF_OCCURENCES
,v_new_data.CLIENT_REG_REQ_IND
,v_new_data.SESSION_START_TIME
,v_new_data.SESSION_END_TIME
,v_new_data.DETAILS_SURVEY_ID
,v_new_data.SURVEY_NAME
,v_new_data.EVENT_TITLE
,v_new_data.LANGUAGES_SUPPORTED
,v_new_data.EVENT_RECEIVED_FROM
,v_new_data.EVENT_RECEIVED_VIA
,v_new_data.GENERAL_PUBLIC_IND
,v_new_data.SENIORS_IND
,v_new_data.RESTRICTED_AGENCY_IND
,v_new_data.SCHOOL_AGED_FAMILIES_IND
,v_new_data.MIGRANTS_IND
,v_new_data.PREGNANT_WOMEN_TEENS_IND
,v_new_data.OTHER_GROUPS_IND
,v_new_data.PLANS_TO_ATTEND
,v_new_data.ALL_PLANS_INVITED
,v_new_data.STAR_INVITED_IND
,v_new_data.STARPLUS_INVITED_IND
,v_new_data.DENTAL_INVITED_IND
,v_new_data.NORTHSTAR_INVITED_IND
,v_new_data.PLAN_SPONSORED_IND
,v_new_data.PLAN_EXCLUSIVE_IND
,v_new_data.PLAN_RSVP_IND
,v_new_data.RSVP_DEADLINE
,v_new_data.STAR_EVENT_IND
,v_new_data.STARPLUS_EVENT_IND
,v_new_data.NORTHSTAR_EVENT_IND
,v_new_data.DENTAL_EVENT_IND
,v_new_data.SURVEY_COMMENTS
,v_new_data.COMPLETE_DT
,v_new_data.CANCEL_DT
,v_new_data.CANCEL_BY
,v_new_data.CANCEL_REASON
,v_new_data.CANCEL_METHOD
,v_new_data.INSTANCE_START_DATE
,v_new_data.INSTANCE_END_DATE
,v_new_data.INSTANCE_STATUS
,v_new_data.ASSD_REVIEW_EVENT 
,v_new_data.ASED_REVIEW_EVENT 
,v_new_data.ASPB_REVIEW_EVENT 
,v_new_data.ASSD_WAIT_FOR_EVENT 
,v_new_data.ASED_WAIT_FOR_EVENT 
,v_new_data.ASSD_RECORD_OUTCOME 
,v_new_data.ASED_RECORD_OUTCOME 
,v_new_data.ASPB_RECORD_OUTCOME 
--,v_new_data.COMMUNITY_ACTIVITY_ID 
--,v_new_data.ACTIVITY_CREATE_DT
,v_new_data.DURATION
);
  
  
  
   INS_FCMORBD (v_identifier, v_start_date, v_end_date, v_bi_id, v_dcmorss_id, v_new_data.SESSION_UPDATED_DT, v_fcmorbd_id);
        
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





-- Update fact for BPM Semantic model - Community Outreach process. 
    procedure UPD_FCMORBD
      (p_identifier in varchar2,  
       p_start_date in date,
       p_end_date in date,
       p_bi_id in number,
       p_dcmorss_id in number,
       p_last_update_date in varchar2,
       p_stg_last_update_date in varchar2,
       p_fcmorbd_id out number)
     as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FCMORBD';
    v_sql_code number := null;
    v_log_message clob := null;
      
    v_fcmorbd_id_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
   -- v_receipt_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;
   -- v_incident_status_dt date := null;
    v_last_update_date date := null;
    v_event_date date := null;  
    
    v_dcmorss_id   number    := null;
    v_fcmorbd_id	 number    := null;
     
    
    r_fcmorbd F_CMOR_BY_DATE%rowtype := null;
  begin 
  
      v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      v_event_date := v_stg_last_update_date;
    --  v_incident_status_dt := to_date(p_incident_status_dt,BPM_COMMON.DATE_FMT);
      v_last_update_date := to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
      
     v_dcmorss_id :=  p_dcmorss_id;   
     v_fcmorbd_id  :=  p_fcmorbd_id;
     
     with most_recent_fact_bi_id as
           (select 
              max(FCMORBD_ID) max_fcmorbd_id,
              max(D_DATE) max_d_date
            from F_CMOR_BY_DATE
            where CMOR_BI_ID = p_bi_id) 
         select 
           fcmorbd.FCMORBD_ID,
           fcmorbd.D_DATE,
           fcmorbd.CREATION_COUNT,
           fcmorbd.COMPLETION_COUNT,
           most_recent_fact_bi_id.max_d_date
         into 
           v_fcmorbd_id_old,
           v_d_date_old,
           v_creation_count_old,
           v_completion_count_old,
           v_max_d_date
         from 
           F_CMOR_BY_DATE fcmorbd,
           most_recent_fact_bi_id 
         where
           fcmorbd.FCMORBD_ID = max_fcmorbd_id
      and fcmorbd.D_DATE = most_recent_fact_bi_id.max_d_date;
      
      -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
        
    -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE. 
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;
    
   if p_end_date is null then
      r_fcmorbd.D_DATE := v_event_date;
      r_fcmorbd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fcmorbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fcmorbd.INVENTORY_COUNT := 1;
      r_fcmorbd.COMPLETION_COUNT := 0;
    else 
         -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
          if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then
          
            delete from F_CMOR_BY_DATE
            where 
              CMOR_BI_ID = p_bi_id
              and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
              
            with most_recent_fact_bi_id as
              (select 
                max(FCMORBD_ID) max_fcmorbd_id,
                max(D_DATE) max_d_date
               from F_CMOR_BY_DATE
               where CMOR_BI_ID = p_bi_id) 
           select 
	             fcmorbd.FCMORBD_ID,
	             fcmorbd.D_DATE,
	             fcmorbd.CREATION_COUNT,
	             fcmorbd.COMPLETION_COUNT,
	             most_recent_fact_bi_id.max_d_date,
	             fcmorbd.DCMORSS_ID, 
	             fcmorbd.LAST_UPDATE_BY_DATE
	           into 
	             v_fcmorbd_id_old,
	             v_d_date_old,
	             v_creation_count_old,
	             v_completion_count_old,
	             v_max_d_date,
	             v_dcmorss_id,
	             v_last_update_date 
	           from 
	             F_CMOR_BY_DATE fcmorbd,
	             most_recent_fact_bi_id 
	           where
	             fcmorbd.FCMORBD_ID = max_fcmorbd_id
          and fcmorbd.D_DATE = most_recent_fact_bi_id.max_d_date;
          
      end if;
      
      r_fcmorbd.D_DATE := p_end_date;
      r_fcmorbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fcmorbd.BUCKET_END_DATE := r_fcmorbd.BUCKET_START_DATE;
      r_fcmorbd.INVENTORY_COUNT := 0;
      r_fcmorbd.COMPLETION_COUNT := 1;
      
    end if;    
    
    p_fcmorbd_id := SEQ_FCMORBD_ID.nextval;
    r_fcmorbd.FCMORBD_ID := p_fcmorbd_id;
    r_fcmorbd.CMOR_BI_ID := p_bi_id;
    r_fcmorbd.DCMORSS_ID := v_dcmorss_id ;
    r_fcmorbd.CREATION_COUNT := 0;
    r_fcmorbd.LAST_UPDATE_BY_DATE := v_last_update_date;
 
 -- Validate fact date ranges.
     if r_fcmorbd.D_DATE < r_fcmorbd.BUCKET_START_DATE
     --  or r_fmjbd.D_DATE > r_fmjbd.BUCKET_END_DATE
       or to_date(to_char(r_fcmorbd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fcmorbd.BUCKET_END_DATE
       or r_fcmorbd.BUCKET_START_DATE > r_fcmorbd.BUCKET_END_DATE
       or r_fcmorbd.BUCKET_END_DATE < r_fcmorbd.BUCKET_START_DATE
     then
       v_sql_code := -20030;
       v_log_message := 'Attempted to insert invalid fact date range.  ' || 
         'D_DATE = ' || r_fcmorbd.D_DATE || 
         ' BUCKET_START_DATE = ' || to_char(r_fcmorbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
         ' BUCKET_END_DATE = ' || to_char(r_fcmorbd.BUCKET_END_DATE,v_date_bucket_fmt);
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
       RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
     end if;
     
   if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fcmorbd.BUCKET_START_DATE then
    
      -- Same bucket time.
      
      if v_creation_count_old = 1 then
        r_fcmorbd.CREATION_COUNT := v_creation_count_old;
      end if;
      
      update F_CMOR_BY_DATE
      set row = r_fcmorbd
      where FCMORBD_ID = v_fcmorbd_id_old;
        
    else  
    
     -- Different bucket time.
        
          update F_CMOR_BY_DATE
          set BUCKET_END_DATE = r_fcmorbd.BUCKET_START_DATE
          where FCMORBD_ID = v_fcmorbd_id_old;
            
          insert into F_CMOR_BY_DATE
          values r_fcmorbd;
          
        end if;
        
      exception
      
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);  
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
        
      v_old_data T_UPD_CMOR_XML := null;
      v_new_data T_UPD_CMOR_XML := null;
      
      v_bi_id number := null;
      v_identifier varchar2(100) := null;
        
      v_start_date date := null;
      v_end_date date := null;
      
      v_dcmorss_id    number    := null;
      v_fcmorbd_id	 number    := null;
   
    
    begin
       
        if p_data_version > 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Community Outreach in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);        
        end if;
          
        GET_UPD_CMOR_XML(p_old_data_xml,v_old_data);
        GET_UPD_CMOR_XML(p_new_data_xml,v_new_data);
        
    v_identifier := v_new_data.OUTREACH_SESSION_ID ;
    --v_start_date := to_date(v_new_data.SESSION_CREATE_DT,BPM_COMMON.DATE_FMT);
   -- v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);   
    v_start_date := to_date(v_new_data.INSTANCE_START_DATE,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(v_new_data.INSTANCE_END_DATE,BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
        
    select CMOR_BI_ID 
    into v_bi_id
    from D_CMOR_CURRENT
    where OUTREACH_SESSION_ID = v_identifier;
    
    GET_DCMORSS_ID (v_identifier,v_bi_id ,v_new_data.Session_Status,v_dcmorss_id );  
         
   -- Update current dimension and fact as a single transaction.
    begin
             
      commit;   
 
  SET_DCMORCUR
        ('UPDATE',v_identifier,v_bi_id,
            v_new_data.OUTREACH_SESSION_ID ,v_new_data.REQUEST_DATE ,v_new_data.REQUESTED_BY ,v_new_data.REQUEST_METHOD ,v_new_data.SESSION_CREATED_BY ,v_new_data.SESSION_CREATE_DT ,v_new_data.EVENT_TYPE ,v_new_data.SESSION_STATUS ,v_new_data.SESSION_STATUS_DT ,v_new_data.PUBLIC_ALLOWED_IND ,v_new_data.MULTILINGUAL_IND ,v_new_data.GROUP_INDIVIDUAL_IND ,v_new_data.ESTIMATED_ATTENDEES ,v_new_data.EVENT_DATE ,v_new_data.ALTERNATE_1_DATE ,v_new_data.ALTERNATE_2_DATE ,v_new_data.ALTERNATE_3_DATE ,v_new_data.PREPARATION_TIME ,v_new_data.TRAVEL_TIME ,v_new_data.PRESENTER_NAME ,v_new_data.SITE_ID ,v_new_data.SITE_TYPE ,v_new_data.SITE_LANGUAGE ,v_new_data.SITE_CITY ,v_new_data.SITE_ZIP_CD ,v_new_data.SITE_COUNTY ,v_new_data.SITE_STATE ,v_new_data.SITE_NAME ,v_new_data.SITE_CAPACITY ,v_new_data.SITE_SERVICE_AREA ,v_new_data.SITE_STATUS ,v_new_data.CONTACT_NAME ,v_new_data.SESSION_UPDATED_BY ,v_new_data.SESSION_UPDATED_DT ,
            v_new_data.NOTE_REF_ID ,v_new_data.RESCHEDULE_IND ,v_new_data.RECURRING_GROUP_ID ,v_new_data.RECURRING_FREQUENCY ,v_new_data.NUMBER_OF_OCCURENCES ,v_new_data.CLIENT_REG_REQ_IND ,v_new_data.SESSION_START_TIME ,v_new_data.SESSION_END_TIME ,v_new_data.DETAILS_SURVEY_ID ,v_new_data.SURVEY_NAME ,v_new_data.EVENT_TITLE ,v_new_data.LANGUAGES_SUPPORTED ,v_new_data.EVENT_RECEIVED_FROM ,v_new_data.EVENT_RECEIVED_VIA ,v_new_data.GENERAL_PUBLIC_IND ,v_new_data.SENIORS_IND ,v_new_data.RESTRICTED_AGENCY_IND ,v_new_data.SCHOOL_AGED_FAMILIES_IND ,v_new_data.MIGRANTS_IND ,v_new_data.PREGNANT_WOMEN_TEENS_IND ,v_new_data.OTHER_GROUPS_IND ,v_new_data.PLANS_TO_ATTEND ,v_new_data.ALL_PLANS_INVITED ,v_new_data.STAR_INVITED_IND ,v_new_data.STARPLUS_INVITED_IND ,v_new_data.DENTAL_INVITED_IND ,v_new_data.NORTHSTAR_INVITED_IND ,v_new_data.PLAN_SPONSORED_IND ,v_new_data.PLAN_EXCLUSIVE_IND ,v_new_data.PLAN_RSVP_IND ,v_new_data.RSVP_DEADLINE ,v_new_data.STAR_EVENT_IND ,v_new_data.STARPLUS_EVENT_IND ,
            v_new_data.NORTHSTAR_EVENT_IND ,v_new_data.DENTAL_EVENT_IND ,v_new_data.SURVEY_COMMENTS ,v_new_data.COMPLETE_DT ,v_new_data.CANCEL_DT ,v_new_data.CANCEL_BY ,v_new_data.CANCEL_REASON ,v_new_data.CANCEL_METHOD ,v_new_data.INSTANCE_START_DATE ,v_new_data.INSTANCE_END_DATE, v_new_data.INSTANCE_STATUS , v_new_data.ASSD_REVIEW_EVENT , v_new_data.ASED_REVIEW_EVENT , v_new_data.ASPB_REVIEW_EVENT , v_new_data.ASSD_WAIT_FOR_EVENT , v_new_data.ASED_WAIT_FOR_EVENT , v_new_data.ASSD_RECORD_OUTCOME , v_new_data.ASED_RECORD_OUTCOME , v_new_data.ASPB_RECORD_OUTCOME , v_new_data.DURATION
        );   
 
 
  UPD_FCMORBD (v_identifier, v_start_date, v_end_date, v_bi_id, v_dcmorss_id, v_new_data.SESSION_UPDATED_DT, v_new_data.stg_last_update_date, v_fcmorbd_id);
    	
 
      
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
      v_log_message := 'No BPM_INSTANCE found.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
      raise; 
        
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
      raise;
  
  end;

 
end;
/
alter session set plsql_code_type = interpreted;