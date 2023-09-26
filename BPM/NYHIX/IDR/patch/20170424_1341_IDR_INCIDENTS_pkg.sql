alter session set plsql_code_type = native;

create or replace package IDR_INCIDENTS as

 -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/IDR/createdb/IDR_INCIDENTS_pkg.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 18543 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2016-10-24 10:44:19 -0600 (Mon, 24 Oct 2016) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: gt83345 $';

  procedure CALC_DIDRCUR;


  function GET_AGE_IN_BUSINESS_DAYS
      ( p_create_dt in date,
        p_complete_date in date
       )
  return number parallel_enable;

  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_dt in date,
     p_complete_date in date
     )
    return number parallel_enable;

  function GET_SLA_DAYS_TYPE
    (p_incident_type in varchar2)
  return varchar2 parallel_enable result_cache;

    function GET_TARGET_DAYS
        (p_incident_type in varchar2)
    return varchar2 parallel_enable result_cache;

    function GET_JEOPARDY_DAYS
        (p_incident_type in varchar2)
    return varchar2 parallel_enable result_cache;

	 function GET_JEOPARDY_FLAG
     ( p_incident_type in varchar2,
       P_CREATE_DT     in DATE)
    return varchar2 parallel_enable;

    function GET_TIMELY_STATUS
      (
        P_CREATE_DT     in DATE,
        p_incident_type in varchar2,
        p_COMPLETE_DT   in date
       )
    return varchar2 parallel_enable;

 /* 
  Include: 
    NEII_ID    
    STG_LAST_UPDATE_DATE
  */

type T_INS_IDR_XML is record
    (
     ABOUT_PLAN_CODE varchar2(32),
     ABOUT_PROVIDER_ID varchar2(100),
     ACCOUNT_ID varchar2(30),
     ACTION_COMMENTS varchar2(4000),
     ACTION_TYPE varchar2(64),
     APPELLANT_TYPE varchar2(32),
     APPELLANT_TYPE_DESC varchar2(64),     
     ASED_GATHER_MISS_INFO varchar2(19),
     ASED_IDR_REVIEW_DOCS varchar2(19),
     ASF_GATHER_MISS_INFO varchar2(1),
     ASF_IDR_REVIEW_DOCS varchar2(1),
     ASPB_GATHER_MISS_INFO varchar2(150),
     ASPB_IDR_REVIEW_DOCS varchar2(150),
     ASSD_GATHER_MISS_INFO varchar2(19),
     ASSD_IDR_REVIEW_DOCS varchar2(19),
     CANCEL_BY varchar2(150),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(30),
     CANCEL_REASON varchar2(50),
     CASE_ID varchar2(100),
     CHANNEL varchar2(80),
     CLIENT_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     CREATED_BY_GROUP varchar2(80),
     CREATED_BY_NAME varchar2(150),
     CREATE_DT varchar2(19),
     CURRENT_STEP varchar2(256),
     CURRENT_TASK_ID varchar2(100),
     ENROLLMENT_STATUS varchar2(50),
     FORWARDED varchar2(1),
     FORWARDED_TO varchar2(30),
     GWF_CONTINUE_APPEAL varchar2(1),
     INCIDENT_ABOUT varchar2(80),
     INCIDENT_DESCRIPTION varchar2(4000),
     INCIDENT_ID varchar2(100),
     INCIDENT_STATUS varchar2(80),
     INCIDENT_STATUS_DT varchar2(19),
     INCIDENT_TYPE varchar2(80),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(10),
     LAST_UPDATE_BY_DT varchar2(19),
     LAST_UPDATE_BY_NAME varchar2(150),
     NEII_ID varchar2(100),
     OTHER_PARTY_NAME varchar2(64),
     PRIORITY varchar2(64),
     REPORTED_BY varchar2(80),
     REPORTER_NAME varchar2(180),
     REPORTER_PHONE varchar2(32),
     REPORTER_RELATIONSHIP varchar2(64),
     RESOLUTION_DESCRIPTION varchar2(4000),
     RESOLUTION_TYPE varchar2(64),
     STG_LAST_UPDATE_DATE varchar2(19),
     TRACKING_NUMBER varchar2(32),
     UPDATED_BY varchar2(80),
     PREF_LANGUAGE varchar2(255)
    );

/* 
  Include:     
    STG_LAST_UPDATE_DATE
  */

type T_UPD_IDR_XML is record
    (
     ABOUT_PLAN_CODE varchar2(32),
     ABOUT_PROVIDER_ID varchar2(100),
     ACCOUNT_ID varchar2(30),
     ACTION_COMMENTS varchar2(4000),
     ACTION_TYPE varchar2(64),
     APPELLANT_TYPE varchar2(32),
     APPELLANT_TYPE_DESC varchar2(64),     
     ASED_GATHER_MISS_INFO varchar2(19),
     ASED_IDR_REVIEW_DOCS varchar2(19),
     ASF_GATHER_MISS_INFO varchar2(1),
     ASF_IDR_REVIEW_DOCS varchar2(1),
     ASPB_GATHER_MISS_INFO varchar2(150),
     ASPB_IDR_REVIEW_DOCS varchar2(150),
     ASSD_GATHER_MISS_INFO varchar2(19),
     ASSD_IDR_REVIEW_DOCS varchar2(19),
     CANCEL_BY varchar2(150),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(30),
     CANCEL_REASON varchar2(50),
     CASE_ID varchar2(100),
     CHANNEL varchar2(80),
     CLIENT_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     CREATED_BY_GROUP varchar2(80),
     CREATED_BY_NAME varchar2(150),
     CREATE_DT varchar2(19),
     CURRENT_STEP varchar2(256),
     CURRENT_TASK_ID varchar2(100),
     ENROLLMENT_STATUS varchar2(50),
     FORWARDED varchar2(1),
     FORWARDED_TO varchar2(30),
     GWF_CONTINUE_APPEAL varchar2(1),
     INCIDENT_ABOUT varchar2(80),
     INCIDENT_DESCRIPTION varchar2(4000),
     INCIDENT_ID varchar2(100),
     INCIDENT_STATUS varchar2(80),
     INCIDENT_STATUS_DT varchar2(19),
     INCIDENT_TYPE varchar2(80),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(10),
     LAST_UPDATE_BY_DT varchar2(19),
     LAST_UPDATE_BY_NAME varchar2(150),
     OTHER_PARTY_NAME varchar2(64),
     PRIORITY varchar2(64),
     REPORTED_BY varchar2(80),
     REPORTER_NAME varchar2(180),
     REPORTER_PHONE varchar2(32),     
     REPORTER_RELATIONSHIP varchar2(64),
     RESOLUTION_DESCRIPTION varchar2(4000),
     RESOLUTION_TYPE varchar2(64),
     STG_LAST_UPDATE_DATE varchar2(19),
     TRACKING_NUMBER varchar2(32),
     UPDATED_BY varchar2(80),
     PREF_LANGUAGE VARCHAR2(255)
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
create or replace package body IDR_INCIDENTS as

  v_bem_id number := 21; -- 'NYHIX IDR Incidents'
  v_bil_id number := 21; -- 'INCIDENT_ID'
  v_bsl_id number := 21; -- 'NYHX_ETL_IDR_INCIDENTS'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';

  v_calc_dmecur_job_name varchar2(30) := 'CALC_DIDRCUR';

function GET_AGE_IN_BUSINESS_DAYS
    (p_create_dt in date,
     p_complete_date in date
     )
    return number
  as
  begin
  return BPM_COMMON.BUS_DAYS_BETWEEN(p_create_dt,nvl(p_complete_date,sysdate));
  end;


  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_dt in date,
     p_complete_date in date)
    return number
  as
  begin
    return trunc(nvl(p_complete_date,sysdate)) - trunc(p_create_dt);
  end;

   function GET_SLA_DAYS_TYPE
    (p_incident_type in varchar2)
    return varchar2 result_cache
  as
     v_SLA_days_type varchar2(1) := null;
  begin

    select JEP.sla_days_type
    into v_SLA_days_type
    from IDR_timeliness_jeopardy JEP
    where incident_type = p_incident_type;

     return v_SLA_days_type;
  end GET_SLA_DAYS_TYPE;

  function GET_TARGET_DAYS
    (p_incident_type in varchar2)
    return varchar2 result_cache
  as
     v_target_days number := null;
  begin

    select JEP.target_days
    into v_target_days
    from IDR_timeliness_jeopardy JEP
    where incident_type = p_incident_type;

     return v_target_days;
  end GET_TARGET_DAYS;

  function GET_JEOPARDY_DAYS
    (p_incident_type in varchar2)
    return varchar2 result_cache
  as
     v_jeopardy_days number := null;
  begin

    select JEP.jeopardy_days
    into v_jeopardy_days
    from IDR_timeliness_jeopardy JEP
    where incident_type = p_incident_type;

     return v_jeopardy_days;
  end GET_JEOPARDY_DAYS;

  function GET_JEOPARDY_FLAG
    (p_incident_type in varchar2,
     P_CREATE_DT     in DATE)
   return varchar2
   as
     v_jeopardy_days number := null;
     v_SLA_days_type varchar2(1) := null;

  begin

   v_jeopardy_days := GET_JEOPARDY_DAYS(p_incident_type);
   v_SLA_days_type := GET_SLA_DAYS_TYPE(p_incident_type);

    if (v_SLA_days_type = 'B'
        and trunc(sysdate) >= etl_common.GET_BUS_DATE(trunc(P_CREATE_DT),v_jeopardy_days))
     or
       (v_SLA_days_type = 'C'
        and trunc(sysdate) >= trunc(P_CREATE_DT) + v_jeopardy_days) then
      return 'Y';
    else
      return 'N';
    end if;

  end GET_JEOPARDY_FLAG;

  function GET_TIMELY_STATUS
    (
     P_CREATE_DT     in DATE,
     p_incident_type in varchar2,
     p_COMPLETE_DT in date
     )
    return varchar2
  AS
    v_target_days    number := null;
    v_SLA_days_type varchar2(1) := null;

  BEGIN

    v_target_days   := GET_TARGET_DAYS(p_incident_type);
    v_SLA_days_type := GET_SLA_DAYS_TYPE(p_incident_type);

    if p_COMPLETE_DT is null then
      return 'Not Processed';
    elsif (v_SLA_days_type = 'B' and GET_AGE_IN_BUSINESS_DAYS(p_CREATE_DT, p_COMPLETE_DT) <= v_target_days)
          or
          (v_SLA_days_type = 'C' and (p_COMPLETE_DT-p_CREATE_DT) <= v_target_days) then
      return 'Timely';
    else
      return 'Untimely';
    end if;

  END GET_TIMELY_STATUS;

-- Calculate column values in BPM Semantic table D_IDR_CURRENT.
  procedure CALC_DIDRCUR
/*
This procedure calculates the semantic layer attributes.
*/
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DIDRCUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_counter   NUMBER  := 0;
    v_num_rows_updated number := null;

  begin

    update D_IDR_CURRENT
    set
      AGE_IN_BUSINESS_DAYS  = GET_AGE_IN_BUSINESS_DAYS( create_dt, INSTANCE_COMPLETE_DT),
      AGE_IN_CALENDAR_DAYS  = GET_AGE_IN_CALENDAR_DAYS( create_dt, INSTANCE_COMPLETE_DT),
      JEOPARDY_DATE         = ETL_COMMON.GET_BUS_DATE( create_dt, GET_JEOPARDY_DAYS('INFORMAL DISPUTE RESOLUTION')),
      JEOPARDY_DAYS         = GET_JEOPARDY_DAYS('INFORMAL DISPUTE RESOLUTION'),
      JEOPARDY_DAYS_TYPE    = GET_SLA_DAYS_TYPE('INFORMAL DISPUTE RESOLUTION'),
      TARGET_DAYS           = GET_TARGET_DAYS('INFORMAL DISPUTE RESOLUTION'),
      JEOPARDY_FLAG         = GET_JEOPARDY_FLAG('INFORMAL DISPUTE RESOLUTION',create_dt),
      IDR_TIMELINESS_STATUS = GET_TIMELY_STATUS(create_dt, 'INFORMAL DISPUTE RESOLUTION', CUR_COMPLETE_DT)
    where
      INSTANCE_COMPLETE_DT is null
      and CANCEL_DT is null;

      v_num_rows_updated := sql%rowcount;
 COMMIT;

     v_log_message := v_num_rows_updated  || ' D_IDR_CURRENT rows updated with calculated attributes by CALC_DIDRCUR.';
     BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);

   exception

     when others then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);

  end CALC_DIDRCUR;
--------------------------------------------------------------------------------------------
-- Get dimension ID for BPM Semantic model - Action Comments.
  procedure GET_DIDRAC_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_ACTION_COMMENTS in varchar2,
      p_DIDRAC_ID out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DIDRAC_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DIDRAC_ID
     into p_DIDRAC_ID
     from D_IDR_ACTION_COMMENTS
     where
       ACTION_COMMENTS = p_ACTION_COMMENTS
       or (ACTION_COMMENTS is null and p_ACTION_COMMENTS is null);

   exception

     when NO_DATA_FOUND then

       p_DIDRAC_ID := SEQ_DIDRAC_ID.nextval;
       begin
         insert into D_IDR_ACTION_COMMENTS (DIDRAC_ID, ACTION_COMMENTS)
         values (p_DIDRAC_ID,p_ACTION_COMMENTS);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DIDRAC_ID into p_DIDRAC_ID
           from D_IDR_ACTION_COMMENTS
           where
             ACTION_COMMENTS = p_ACTION_COMMENTS
             or (ACTION_COMMENTS is null and p_ACTION_COMMENTS is null);

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

  end GET_DIDRAC_ID;
--------------------------------------------------------------------------------------------
-- Get dimension ID for BPM Semantic model - Enrollment Status.
  procedure GET_DIDRES_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_enroll_status in varchar2,
      p_DIDRES_ID out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DIDRES_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DIDRES_ID
     into p_DIDRES_ID
     from D_IDR_ENROLLMENT_STATUS
     where
       Enrollment_Status = p_enroll_status
       or (Enrollment_Status is null and p_enroll_status is null);

   exception

     when NO_DATA_FOUND then

       p_DIDRES_ID := SEQ_DIDRES_ID.nextval;
       begin
         insert into D_IDR_ENROLLMENT_STATUS (DIDRES_ID, Enrollment_Status)
         values (p_DIDRES_ID,p_enroll_status);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DIDRES_ID
           into p_DIDRES_ID
           from D_IDR_ENROLLMENT_STATUS
           where
             Enrollment_Status = p_enroll_status
             or (Enrollment_Status is null and p_enroll_status is null);

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

  end GET_DIDRES_ID;
--------------------------------------------------------------------------------------------
-- Get dimension ID for BPM Semantic model - INCIDENT_ABOUT.
  procedure GET_DIDRIA_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_INCIDENT_ABOUT in varchar2,
      p_DIDRIA_ID out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DIDRIA_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DIDRIA_ID
     into p_DIDRIA_ID
     from D_IDR_INCIDENT_ABOUT
     where
       INCIDENT_ABOUT = p_INCIDENT_ABOUT
       or (INCIDENT_ABOUT is null and p_INCIDENT_ABOUT is null);

   exception

     when NO_DATA_FOUND then

       p_DIDRIA_ID := SEQ_DIDRIA_ID.nextval;
       begin
         insert into D_IDR_INCIDENT_ABOUT (DIDRIA_ID, INCIDENT_ABOUT)
         values (p_DIDRIA_ID,p_INCIDENT_ABOUT);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DIDRIA_ID into p_DIDRIA_ID
           from D_IDR_INCIDENT_ABOUT
           where
             INCIDENT_ABOUT = p_INCIDENT_ABOUT
             or (INCIDENT_ABOUT is null and p_INCIDENT_ABOUT is null);

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

  end GET_DIDRIA_ID;
--------------------------------------------------------------------------------------------
-- Get dimension ID for BPM Semantic model - INCIDENT_DESCRIPTION.
  procedure GET_DIDRID_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_INCIDENT_DESCRIPTION in varchar2,
      p_DIDRID_ID out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DIDRID_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DIDRID_ID
     into p_DIDRID_ID
     from D_IDR_INCIDENT_DESCRIPTION
     where
       INCIDENT_DESCRIPTION = p_INCIDENT_DESCRIPTION
       or (INCIDENT_DESCRIPTION is null and p_INCIDENT_DESCRIPTION is null);

   exception

     when NO_DATA_FOUND then

       p_DIDRID_ID := SEQ_DIDRID_ID.nextval;
       begin
         insert into D_IDR_INCIDENT_DESCRIPTION (DIDRID_ID, INCIDENT_DESCRIPTION)
         values (p_DIDRID_ID,p_INCIDENT_DESCRIPTION);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DIDRID_ID into p_DIDRID_ID
           from D_IDR_INCIDENT_DESCRIPTION
           where
             INCIDENT_DESCRIPTION = p_INCIDENT_DESCRIPTION
             or (INCIDENT_DESCRIPTION is null and p_INCIDENT_DESCRIPTION is null);

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

  end GET_DIDRID_ID;
--------------------------------------------------------------------------------------------
-- Get dimension ID for BPM Semantic model - INCIDENT_STATUS.
  procedure GET_DIDRIS_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_INCIDENT_STATUS in varchar2,
      p_DIDRIS_ID out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DIDRIS_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DIDRIS_ID
     into p_DIDRIS_ID
     from D_IDR_INCIDENT_STATUS
     where
       INCIDENT_STATUS = p_INCIDENT_STATUS
       or (INCIDENT_STATUS is null and p_INCIDENT_STATUS is null);

   exception

     when NO_DATA_FOUND then

       p_DIDRIS_ID := SEQ_DIDRIS_ID.nextval;
       begin
         insert into D_IDR_INCIDENT_STATUS (DIDRIS_ID, INCIDENT_STATUS)
         values (p_DIDRIS_ID,p_INCIDENT_STATUS);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DIDRIS_ID into p_DIDRIS_ID
           from D_IDR_INCIDENT_STATUS
           where
             INCIDENT_STATUS = p_INCIDENT_STATUS
             or (INCIDENT_STATUS is null and p_INCIDENT_STATUS is null);

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

  end GET_DIDRIS_ID;
--------------------------------------------------------------------------------------------
-- Get dimension ID for BPM Semantic model - INSTANCE_STATUS.
  procedure GET_DIDRIN_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_INSTANCE_STATUS in varchar2,
      p_DIDRIN_ID out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DIDRIN_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DIDRIN_ID
     into p_DIDRIN_ID
     from D_IDR_INSTANCE_STATUS
     where
       INSTANCE_STATUS = p_INSTANCE_STATUS
       or (INSTANCE_STATUS is null and p_INSTANCE_STATUS is null);

   exception

     when NO_DATA_FOUND then

       p_DIDRIN_ID := SEQ_DIDRIN_ID.nextval;
       begin
         insert into D_IDR_INSTANCE_STATUS (DIDRIN_ID, INSTANCE_STATUS)
         values (p_DIDRIN_ID,p_INSTANCE_STATUS);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DIDRIN_ID into p_DIDRIN_ID
           from D_IDR_INSTANCE_STATUS
           where
             INSTANCE_STATUS = p_INSTANCE_STATUS
             or (INSTANCE_STATUS is null and p_INSTANCE_STATUS is null);

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

  end GET_DIDRIN_ID;
--------------------------------------------------------------------------------------------
-- Get dimension ID for BPM Semantic model - LAST_UPDATE_BY_NAME.
  procedure GET_DIDRLUBN_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_LAST_UPDATE_BY_NAME in varchar2,
      p_DIDRLUBN_ID out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DIDRLUBN_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DIDRLUBN_ID
     into p_DIDRLUBN_ID
     from D_IDR_LAST_UPDATE_BY_NAME
     where
       LAST_UPDATE_BY_NAME = p_LAST_UPDATE_BY_NAME
       or (LAST_UPDATE_BY_NAME is null and p_LAST_UPDATE_BY_NAME is null);

   exception

     when NO_DATA_FOUND then

       p_DIDRLUBN_ID := SEQ_DIDRLUBN_ID.nextval;
       begin
         insert into D_IDR_LAST_UPDATE_BY_NAME (DIDRLUBN_ID, LAST_UPDATE_BY_NAME)
         values (p_DIDRLUBN_ID, p_LAST_UPDATE_BY_NAME);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DIDRLUBN_ID into p_DIDRLUBN_ID
           from D_IDR_LAST_UPDATE_BY_NAME
           where
             LAST_UPDATE_BY_NAME = p_LAST_UPDATE_BY_NAME
             or (LAST_UPDATE_BY_NAME is null and p_LAST_UPDATE_BY_NAME is null);

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

  end GET_DIDRLUBN_ID;
--------------------------------------------------------------------------------------------
-- Get dimension ID for BPM Semantic model - UPDATED_BY.
  procedure GET_DIDRLUB_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_LAST_UPDATED_BY in varchar2,
      p_DIDRLUB_ID out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DIDRLUB_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DIDRLUB_ID
     into p_DIDRLUB_ID
     from D_IDR_LAST_UPDATED_BY
     where
       LAST_UPDATED_BY = p_LAST_UPDATED_BY
       or (LAST_UPDATED_BY is null and p_LAST_UPDATED_BY is null);

   exception

     when NO_DATA_FOUND then

       p_DIDRLUB_ID := SEQ_DIDRLUB_ID.nextval;
       begin
         insert into D_IDR_LAST_UPDATED_BY (DIDRLUB_ID, LAST_UPDATED_BY)
         values (p_DIDRLUB_ID, p_LAST_UPDATED_BY);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DIDRLUB_ID into p_DIDRLUB_ID
           from D_IDR_LAST_UPDATED_BY
           where
             LAST_UPDATED_BY = p_LAST_UPDATED_BY
             or (LAST_UPDATED_BY is null and p_LAST_UPDATED_BY is null);

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

  end GET_DIDRLUB_ID;
--------------------------------------------------------------------------------------------
-- Get dimension ID for BPM Semantic model - DIDRRD_ID.
  procedure GET_DIDRRD_ID
     (P_IDENTIFIER in varchar2,
      P_BI_ID in number,
      P_RESOLUTION_DESCRIPTION in varchar2,
      p_DIDRRD_ID out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DIDRRD_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DIDRRD_ID
     into p_DIDRRD_ID
     from D_IDR_RESOLUTION_DESCRIPTION
     where
       RESOLUTION_DESCRIPTION = to_char(P_RESOLUTION_DESCRIPTION)
       or (RESOLUTION_DESCRIPTION is null and to_char(P_RESOLUTION_DESCRIPTION) is null);

   exception

     when NO_DATA_FOUND then

       p_DIDRRD_ID := SEQ_DIDRRD_ID.nextval;
       begin
         insert into D_IDR_RESOLUTION_DESCRIPTION (DIDRRD_ID, RESOLUTION_DESCRIPTION)
         values (p_DIDRRD_ID, to_char(P_RESOLUTION_DESCRIPTION));
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DIDRRD_ID into p_DIDRRD_ID
           from D_IDR_RESOLUTION_DESCRIPTION
           where
             RESOLUTION_DESCRIPTION = to_char(P_RESOLUTION_DESCRIPTION)
             or (RESOLUTION_DESCRIPTION is null and to_char(P_RESOLUTION_DESCRIPTION) is null);

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

  end GET_DIDRRD_ID;
--------------------------------------------------------------------------------------------
-- Get dimension ID for BPM Semantic model - RESOLUTION_TYPE.
  procedure GET_DIDRRT_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_RESOLUTION_TYPE in varchar2,
      p_DIDRRT_ID out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DIDRRT_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DIDRRT_ID
     into p_DIDRRT_ID
     from D_IDR_RESOLUTION_TYPE
     where
       RESOLUTION_TYPE = p_RESOLUTION_TYPE
       or (RESOLUTION_TYPE is null and p_RESOLUTION_TYPE is null);

   exception

     when NO_DATA_FOUND then

       p_DIDRRT_ID := SEQ_DIDRRT_ID.nextval;
       begin
         insert into D_IDR_RESOLUTION_TYPE (DIDRRT_ID, RESOLUTION_TYPE)
         values (p_DIDRRT_ID, p_RESOLUTION_TYPE);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select p_DIDRRT_ID into p_DIDRRT_ID
           from D_IDR_RESOLUTION_TYPE
           where
             RESOLUTION_TYPE = p_RESOLUTION_TYPE
             or (RESOLUTION_TYPE is null and p_RESOLUTION_TYPE is null);

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

  end GET_DIDRRT_ID;
--------------------------------------------------------------------------------------------
-- Get record for IDR Incidents insert XML.
  procedure GET_INS_IDR_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_IDR_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_IDR_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin

    select
            extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PLAN_CODE') "ABOUT_PLAN_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PROVIDER_ID') "ABOUT_PROVIDER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ACCOUNT_ID') "ACCOUNT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_COMMENTS') "ACTION_COMMENTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_TYPE') "ACTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/APPELLANT_TYPE') "APPELLANT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/APPELLANT_TYPE_DESC') "APPELLANT_TYPE_DESC",      
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_GATHER_MISS_INFO') "ASED_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_IDR_REVIEW_DOCS') "ASED_IDR_REVIEW_DOCS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_GATHER_MISS_INFO') "ASF_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_IDR_REVIEW_DOCS') "ASF_IDR_REVIEW_DOCS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_GATHER_MISS_INFO') "ASPB_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_IDR_REVIEW_DOCS') "ASPB_IDR_REVIEW_DOCS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_GATHER_MISS_INFO') "ASSD_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_IDR_REVIEW_DOCS') "ASSD_IDR_REVIEW_DOCS",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL') "CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_GROUP') "CREATED_BY_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_NAME') "CREATED_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_STEP') "CURRENT_STEP",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLLMENT_STATUS') "ENROLLMENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED') "FORWARDED",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED_TO') "FORWARDED_TO",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_CONTINUE_APPEAL') "GWF_CONTINUE_APPEAL",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ABOUT') "INCIDENT_ABOUT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_DESCRIPTION') "INCIDENT_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ID') "INCIDENT_ID",
      --extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_REASON') "INCIDENT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS') "INCIDENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS_DT') "INCIDENT_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_TYPE') "INCIDENT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_DT') "LAST_UPDATE_BY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/NEII_ID') "NEII_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OTHER_PARTY_NAME') "OTHER_PARTY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PRIORITY') "PRIORITY",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTED_BY') "REPORTED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_NAME') "REPORTER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_PHONE') "REPORTER_PHONE",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_RELATIONSHIP') "REPORTER_RELATIONSHIP",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_DESCRIPTION') "RESOLUTION_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_TYPE') "RESOLUTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/TRACKING_NUMBER') "TRACKING_NUMBER",
      extractValue(p_data_xml,'/ROWSET/ROW/UPDATED_BY') "UPDATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/PREF_LANGUAGE') "PREF_LANGUAGE"
       into p_data_record
       from dual;

     exception

       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
         raise;

  end GET_INS_IDR_XML;

 -- Get record for IDR Incidents update XML.
  procedure GET_UPD_IDR_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_IDR_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_IDR_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin

     select
            extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PLAN_CODE') "ABOUT_PLAN_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PROVIDER_ID') "ABOUT_PROVIDER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ACCOUNT_ID') "ACCOUNT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_COMMENTS') "ACTION_COMMENTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_TYPE') "ACTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/APPELLANT_TYPE') "APPELLANT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/APPELLANT_TYPE_DESC') "APPELLANT_TYPE_DESC",      
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_GATHER_MISS_INFO') "ASED_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_IDR_REVIEW_DOCS') "ASED_IDR_REVIEW_DOCS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_GATHER_MISS_INFO') "ASF_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_IDR_REVIEW_DOCS') "ASF_IDR_REVIEW_DOCS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_GATHER_MISS_INFO') "ASPB_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_IDR_REVIEW_DOCS') "ASPB_IDR_REVIEW_DOCS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_GATHER_MISS_INFO') "ASSD_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_IDR_REVIEW_DOCS') "ASSD_IDR_REVIEW_DOCS",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL') "CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_GROUP') "CREATED_BY_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_NAME') "CREATED_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_STEP') "CURRENT_STEP",      
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLLMENT_STATUS') "ENROLLMENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED') "FORWARDED",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED_TO') "FORWARDED_TO",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_CONTINUE_APPEAL') "GWF_CONTINUE_APPEAL",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ABOUT') "INCIDENT_ABOUT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_DESCRIPTION') "INCIDENT_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ID') "INCIDENT_ID",
      --extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_REASON') "INCIDENT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS') "INCIDENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS_DT') "INCIDENT_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_TYPE') "INCIDENT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_DT') "LAST_UPDATE_BY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/OTHER_PARTY_NAME') "OTHER_PARTY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PRIORITY') "PRIORITY",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTED_BY') "REPORTED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_NAME') "REPORTER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_PHONE') "REPORTER_PHONE",      
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_RELATIONSHIP') "REPORTER_RELATIONSHIP",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_DESCRIPTION') "RESOLUTION_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_TYPE') "RESOLUTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/TRACKING_NUMBER') "TRACKING_NUMBER",
      extractValue(p_data_xml,'/ROWSET/ROW/UPDATED_BY') "UPDATED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/PREF_LANGUAGE') "PREF_LANGUAGE"
     into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;

  end GET_UPD_IDR_XML;

 -- Insert fact for BPM Semantic model - Manage Enroll process.
    procedure INS_FIDRBD
    (P_IDENTIFIER       in number,
     P_START_DATE       in date,
     P_END_DATE         in date,
     p_bi_id            in number,
     p_DIDRAC_ID        in number,
     P_CURRENT_TASK_ID  in number,
     P_DIDRES_ID        in number,
     P_DIDRIA_ID        in number,
     P_DIDRID_ID        in number,
     --P_DIDRIR_ID        in number,
     p_DIDRIS_ID        in number,
     P_DIDRIN_ID        in number,
     p_DIDRLUBN_ID      in number,
     P_DIDRLUB_ID       in number,
     p_DIDRRD_ID        in number,
     P_DIDRRT_ID        in number,
     p_Client_ID            in number,
     P_INCIDENT_STATUS_DATE in varchar2,
     P_LAST_UPDATE_DATE     in varchar2,
     p_complete_date        in varchar2,
     p_fidrbd_id            out number)
   as
         v_procedure_name       varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FIDRBD';
         v_sql_code             number := null;
         v_log_message          clob := null;
         v_bucket_start_date    date := null;
         v_bucket_end_date      date := null;
         v_Incident_Status_Date date := null;
         V_LAST_UPDATE_DATE     date := null;
         v_complete_Date        date := null;
    begin

      v_Incident_Status_Date := to_date(p_Incident_Status_Date, BPM_COMMON.DATE_FMT);
      v_Last_Update_Date := to_date(p_Last_Update_Date, BPM_COMMON.DATE_FMT);
      v_complete_Date := to_date(p_complete_Date, BPM_COMMON.DATE_FMT);
      p_fidrbd_id := SEQ_FIDRBD_ID.nextval;

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
              BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
              RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
      end if;

       insert into F_IDR_BY_DATE
        (
    FIDRBD_ID,
    D_DATE,
    BUCKET_START_DATE,
    BUCKET_END_DATE,
    IDR_BI_ID,
	  DIDRAC_ID,
	  CURRENT_TASK_ID,
	  DIDRES_ID,
	  DIDRIA_ID,
	  DIDRID_ID,
	  --DIDRIR_ID,
	  DIDRIS_ID,
	  DIDRIN_ID,
	  DIDRLUBN_ID,
	  DIDRLUB_ID,
	  DIDRRD_ID,
	  DIDRRT_ID,
	  CLIENT_ID,
	  INCIDENT_STATUS_DT,
	  LAST_UPDATE_BY_DT,
    COMPLETE_DT,
	  CREATION_COUNT,
	  INVENTORY_COUNT,
    COMPLETION_COUNT
    )
  values
  ( p_fidrbd_id,
    p_start_date,
    v_bucket_start_date,
    v_bucket_end_date,
    p_bi_id,
    p_DIDRAC_ID,
	  p_CURRENT_TASK_ID,
	  p_DIDRES_ID,
	  p_DIDRIA_ID,
	  p_DIDRID_ID,
	  --p_DIDRIR_ID,
	  p_DIDRIS_ID,
	  p_DIDRIN_ID,
	  p_DIDRLUBN_ID,
	  p_DIDRLUB_ID,
	  p_DIDRRD_ID,
	  p_DIDRRT_ID,
	  p_CLIENT_ID,
	  v_Incident_Status_Date,
	  v_Last_Update_Date,
    V_complete_date,
    1, --creation
    case when p_end_date is null then 1 else 0 end, --inventory
    case when p_end_date is null then 0 else 1 end --completion
   );
      exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;

  end INS_FIDRBD;

 -- Insert or update dimension for BPM Semantic model - IDR Incidents - Current.
  procedure SET_DIDRCUR
  (
p_set_type               in  varchar2,
p_identifier             in  varchar2,
p_bi_id                  in  number,
p_INCIDENT_ID            in  varchar2,
P_CREATED_BY_GROUP       in  varchar2,
p_CREATED_BY_NAME        in   varchar2,
p_TRACKING_NUMBER        in   varchar2,
p_CREATE_DT              in  varchar2,
p_INCIDENT_TYPE          in   varchar2,
p_CLIENT_ID              in   varchar2,
p_ASSD_IDR_REVIEW_DOCS   in   varchar2,
p_ASED_IDR_REVIEW_DOCS   in   varchar2,
p_ASPB_IDR_REVIEW_DOCS   in   varchar2,
p_ASSD_GATHER_MISS_INFO  in   varchar2,
p_ASED_GATHER_MISS_INFO  in   varchar2,
p_ASPB_GATHER_MISS_INFO  in   varchar2,
p_ABOUT_PLAN_CODE        in   varchar2,
p_ABOUT_PROVIDER_ID      in   varchar2,
p_ACTION_COMMENTS        in   varchar2,
p_ACTION_TYPE            in   varchar2,
p_CANCEL_BY              in   varchar2,
p_CANCEL_DT              in   varchar2,
p_CANCEL_METHOD          in   varchar2,
p_CANCEL_REASON          in   varchar2,
p_CURRENT_TASK_ID        in   varchar2,
p_ENROLLMENT_STATUS      in   varchar2,
p_INCIDENT_ABOUT         in   varchar2,
p_INCIDENT_DESCRIPTION   in   varchar2,
--p_INCIDENT_REASON        in   varchar2,
p_INCIDENT_STATUS        in   varchar2,
p_INCIDENT_STATUS_DT     in   varchar2,
p_INSTANCE_COMPLETE_DT   in   varchar2,
p_INSTANCE_STATUS        in   varchar2,
p_LAST_UPDATE_BY_NAME    in   varchar2,
P_LAST_UPDATE_BY_DT      in   varchar2,
p_UPDATED_BY             in   varchar2,
p_OTHER_PARTY_NAME       in   varchar2,
P_PRIORITY               in   varchar2,
p_REPORTED_BY            in   varchar2,
p_REPORTER_RELATIONSHIP  in   varchar2,
P_RESOLUTION_DESCRIPTION in   varchar2,
P_RESOLUTION_TYPE        in   varchar2,
p_CASE_ID                in   varchar2,
p_FORWARDED              in   varchar2,
p_FORWARDED_TO           in   varchar2,
p_ASF_IDR_REVIEW_DOCS    in   varchar2,
p_ASF_GATHER_MISS_INFO   in   varchar2,
p_GWF_CONTINUE_APPEAL    in   varchar2,
p_COMPLETE_DT            in   varchar2,
p_CURRENT_STEP           in   varchar2,
p_APPELLANT_TYPE         in   varchar2,
p_APPELLANT_TYPE_DESC    in   varchar2,
p_reporter_name          in   varchar2,
p_reporter_phone         in   varchar2,
p_channel                in   varchar2,
p_account_id			 in   varchar2,
p_pref_language          in   varchar2
)
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DIDRCUR';
       v_sql_code number := null;
       v_log_message clob := null;
       r_didrcur D_IDR_CURRENT%rowtype := null;
       v_jeopardy_flag varchar2(1) := null;
  begin

r_didrcur.IDR_BI_ID                     := p_bi_id;
r_didrcur.INCIDENT_ID                   := p_INCIDENT_ID;
R_DIDRCUR.CREATED_BY_GROUP              := P_CREATED_BY_GROUP;
r_didrcur.CREATED_BY_NAME               := p_CREATED_BY_NAME;
R_DIDRCUR.TRACKING_NUMBER               := P_TRACKING_NUMBER;
r_didrcur.CREATE_DT                     := to_date(p_CREATE_DT,BPM_COMMON.DATE_FMT);
r_didrcur.INCIDENT_TYPE                 := p_INCIDENT_TYPE;
r_didrcur.CUR_CLIENT_ID                 := p_CLIENT_ID;
R_DIDRCUR.ASSD_IDR_REVIEW_DOCS          := TO_DATE(P_ASSD_IDR_REVIEW_DOCS,BPM_COMMON.DATE_FMT);
r_didrcur.ASED_IDR_REVIEW_DOCS          := to_date(p_ASED_IDR_REVIEW_DOCS,BPM_COMMON.DATE_FMT);
R_DIDRCUR.ASPB_IDR_REVIEW_DOCS          := P_ASPB_IDR_REVIEW_DOCS;
r_didrcur.ASSD_GATHER_MISS_INFO         := to_date(p_ASSD_GATHER_MISS_INFO,BPM_COMMON.DATE_FMT);
r_didrcur.ASED_GATHER_MISS_INFO         := to_date(p_ASED_GATHER_MISS_INFO,BPM_COMMON.DATE_FMT);
r_didrcur.ASPB_GATHER_MISS_INFO         := p_ASPB_GATHER_MISS_INFO;
r_didrcur.ABOUT_PLAN_CODE               := p_ABOUT_PLAN_CODE;
r_didrcur.ABOUT_PROVIDER_ID             := p_ABOUT_PROVIDER_ID;
r_didrcur.CUR_ACTION_COMMENTS           := p_ACTION_COMMENTS;
r_didrcur.ACTION_TYPE                   := p_ACTION_TYPE;
R_DIDRCUR.CANCEL_BY                     := P_CANCEL_BY;
R_DIDRCUR.CANCEL_DT                     := to_date(P_CANCEL_DT,BPM_COMMON.DATE_FMT);
R_DIDRCUR.CANCEL_METHOD                 := P_CANCEL_METHOD;
r_didrcur.CANCEL_REASON                 := p_CANCEL_REASON;
r_didrcur.CUR_CURRENT_TASK_ID           := p_CURRENT_TASK_ID;
r_didrcur.CUR_ENROLLMENT_STATUS         := p_ENROLLMENT_STATUS;
r_didrcur.CUR_INCIDENT_ABOUT            := p_INCIDENT_ABOUT;
r_didrcur.CUR_INCIDENT_DESCRIPTION      := p_INCIDENT_DESCRIPTION;
--r_didrcur.CUR_INCIDENT_REASON           := p_INCIDENT_REASON;
R_DIDRCUR.CUR_INCIDENT_STATUS           := P_INCIDENT_STATUS;
R_DIDRCUR.CUR_INCIDENT_STATUS_DT        := TO_DATE(P_INCIDENT_STATUS_DT,BPM_COMMON.DATE_FMT);
r_didrcur.INSTANCE_COMPLETE_DT          := to_date(p_INSTANCE_COMPLETE_DT,BPM_COMMON.DATE_FMT);
r_didrcur.CUR_INSTANCE_STATUS           := p_INSTANCE_STATUS;
R_DIDRCUR.CUR_LAST_UPDATE_BY_NAME       := P_LAST_UPDATE_BY_NAME;
r_didrcur.CUR_LAST_UPDATE_BY_DT         := to_date(p_LAST_UPDATE_BY_DT,BPM_COMMON.DATE_FMT);
r_didrcur.CUR_LAST_UPDATED_BY           :=  p_UPDATED_BY;
r_didrcur.OTHER_PARTY_NAME              :=  p_OTHER_PARTY_NAME;
r_didrcur.PRIORITY                      :=  p_PRIORITY;
r_didrcur.REPORTED_BY                   :=  p_REPORTED_BY;
R_DIDRCUR.REPORTER_RELATIONSHIP         :=  P_REPORTER_RELATIONSHIP;
r_didrcur.CUR_RESOLUTION_DESCRIPTION    :=  p_RESOLUTION_DESCRIPTION;
r_didrcur.CUR_RESOLUTION_TYPE           :=  p_RESOLUTION_TYPE;
R_DIDRCUR.CASE_ID                       :=  P_CASE_ID;
r_didrcur.FORWARDED                     :=  p_FORWARDED;
r_didrcur.FORWARDED_TO                  :=  p_FORWARDED_TO;
r_didrcur.CUR_COMPLETE_DT               :=  to_date(p_COMPLETE_DT,BPM_COMMON.DATE_FMT);

r_didrcur.ASF_IDR_REVIEW_DOCS           :=  p_ASF_IDR_REVIEW_DOCS;
r_didrcur.ASF_GATHER_MISS_INFO          :=  p_ASF_GATHER_MISS_INFO;
r_didrcur.GWF_CONTINUE_APPEAL           :=  p_GWF_CONTINUE_APPEAL;
r_didrcur.CURRENT_STEP                  :=  p_CURRENT_STEP;
r_didrcur.APPELLANT_TYPE                :=  p_APPELLANT_TYPE;
r_didrcur.APPELLANT_TYPE_DESCRIPTION    :=  p_APPELLANT_TYPE_DESC;
r_didrcur.REPORTER_NAME                 :=  p_REPORTER_NAME;
r_didrcur.REPORTER_PHONE                :=  p_REPORTER_PHONE;
r_didrcur.CHANNEL                       :=  p_channel;
r_didrcur.ACCOUNT_ID                    :=  p_account_id;
r_didrcur.PREF_LANGUAGE                 :=  p_pref_language;

r_didrcur.JEOPARDY_DATE         :=  ETL_COMMON.GET_BUS_DATE(to_date(p_CREATE_DT,BPM_COMMON.DATE_FMT),GET_JEOPARDY_DAYS('INFORMAL DISPUTE RESOLUTION'));
r_didrcur.JEOPARDY_DAYS         :=  GET_JEOPARDY_DAYS('INFORMAL DISPUTE RESOLUTION');
r_didrcur.JEOPARDY_DAYS_TYPE    :=  GET_SLA_DAYS_TYPE('INFORMAL DISPUTE RESOLUTION');
r_didrcur.TARGET_DAYS           :=  GET_TARGET_DAYS('INFORMAL DISPUTE RESOLUTION');
r_didrcur.AGE_IN_CALENDAR_DAYS  :=  GET_AGE_IN_CALENDAR_DAYS(to_date(p_CREATE_DT,BPM_COMMON.DATE_FMT),to_date(p_INSTANCE_COMPLETE_DT,BPM_COMMON.DATE_FMT));
r_didrcur.AGE_IN_BUSINESS_DAYS  :=  GET_AGE_IN_BUSINESS_DAYS(to_date(p_CREATE_DT,BPM_COMMON.DATE_FMT),to_date(p_INSTANCE_COMPLETE_DT,BPM_COMMON.DATE_FMT));
r_didrcur.JEOPARDY_FLAG         :=  GET_JEOPARDY_FLAG('INFORMAL DISPUTE RESOLUTION',to_date(p_create_dt,BPM_COMMON.DATE_FMT));
r_didrcur.IDR_TIMELINESS_STATUS :=  GET_TIMELY_STATUS(to_date(p_CREATE_DT,BPM_COMMON.DATE_FMT), 'INFORMAL DISPUTE RESOLUTION',to_date(p_COMPLETE_DT,BPM_COMMON.DATE_FMT));

  if p_set_type = 'INSERT' then
       insert into D_IDR_CURRENT
       values r_didrcur;

     elsif p_set_type = 'UPDATE' then
       begin
         update D_IDR_CURRENT
         set row = r_didrcur
         where IDR_BI_ID = p_bi_id;
       end;

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

  end SET_DIDRCUR;

   -- Insert BPM Semantic model data.
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_sql_code number := null;
    v_log_message clob := null;

    v_new_data T_INS_IDR_XML := null;

    v_bi_id      number := null;
    v_identifier varchar2(100) := null;

    v_start_date date := null;
    v_end_date date := null;

  v_DIDRAC_ID   number    := null;
  v_DIDRES_ID   number    := null;
  v_DIDRIA_ID   number    := null;
  v_DIDRID_ID   number    := null;
  --v_DIDRIR_ID   number    := null;
  v_DIDRIS_ID   number    := null;
  v_DIDRIN_ID   number    := null;
  v_DIDRLUBN_ID number    := null;
  v_DIDRLUB_ID  number    := null;
  v_DIDRRD_ID  number    := null;
  v_DIDRRT_ID   number    := null;
  v_fidrbd_id   number    := null;


    begin

        if p_data_version != 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYHIX IDR Incidents in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);
        end if;

        GET_INS_IDR_XML(p_new_data_xml,v_new_data);

        v_identifier := v_new_data.INCIDENT_ID ;
        v_start_date := to_date(v_new_data.create_dt,BPM_COMMON.DATE_FMT);
        v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
        BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
        v_bi_id := SEQ_BI_ID.nextval;

     --v_receipt_date:= to_date(v_new_data.RECEIPT_DT,BPM_COMMON.DATE_FMT);
     --v_jeopardy_status:= GET_JEOPARDY_STATUS(v_receipt_date,v_new_data.INSTANCE_STATUS);
   GET_DIDRAC_ID(v_identifier, v_bi_id, v_new_data.ACTION_COMMENTS, v_DIDRAC_ID);
   GET_DIDRES_ID(v_identifier, v_bi_id, v_new_data.ENROLLMENT_STATUS, v_DIDRES_ID);
   GET_DIDRIA_ID(v_identifier, v_bi_id, v_new_data.INCIDENT_ABOUT, v_DIDRIA_ID);
   GET_DIDRID_ID(v_identifier, v_bi_id, v_new_data.INCIDENT_DESCRIPTION, v_DIDRID_ID);
   --GET_DIDRIR_ID(v_identifier, v_bi_id, v_new_data.INCIDENT_REASON, v_DIDRIR_ID);
   GET_DIDRIS_ID(v_identifier, v_bi_id, v_new_data.INCIDENT_STATUS, v_DIDRIS_ID);
   GET_DIDRIN_ID(v_identifier, v_bi_id, v_new_data.INSTANCE_STATUS, v_DIDRIN_ID);
   GET_DIDRLUBN_ID(v_identifier, v_bi_id, v_new_data.LAST_UPDATE_BY_NAME, v_DIDRLUBN_ID);
   GET_DIDRLUB_ID(v_identifier, v_bi_id, v_new_data.UPDATED_BY, v_DIDRLUB_ID);
   GET_DIDRRD_ID(v_identifier, v_bi_id, v_new_data.RESOLUTION_DESCRIPTION, v_DIDRRD_ID);
   GET_DIDRRT_ID(v_identifier, v_bi_id, v_new_data.RESOLUTION_TYPE, v_DIDRRT_ID);


 -- Insert current dimension and fact as a single transaction.
    begin

      commit;
   SET_DIDRCUR
        ('INSERT',v_identifier,v_bi_id,
   --v_new_data.IDR_BI_ID,
   v_new_data.INCIDENT_ID,
   v_new_data.CREATED_BY_GROUP,
   v_new_data.CREATED_BY_NAME,
   v_new_data.TRACKING_NUMBER,
   v_new_data.CREATE_DT,
   v_new_data.INCIDENT_TYPE,
   v_new_data.CLIENT_ID,
   v_new_data.ASSD_IDR_REVIEW_DOCS,
   v_new_data.ASED_IDR_REVIEW_DOCS,
   v_new_data.ASPB_IDR_REVIEW_DOCS,
   v_new_data.ASSD_GATHER_MISS_INFO,
   v_new_data.ASED_GATHER_MISS_INFO,
   v_new_data.ASPB_GATHER_MISS_INFO,
   v_new_data.ABOUT_PLAN_CODE,
   v_new_data.ABOUT_PROVIDER_ID,
   v_new_data.ACTION_COMMENTS,
   v_new_data.ACTION_TYPE,
   v_new_data.CANCEL_BY,
   v_new_data.CANCEL_DT,
   v_new_data.CANCEL_METHOD,
   v_new_data.CANCEL_REASON,
   v_new_data.CURRENT_TASK_ID,
   v_new_data.ENROLLMENT_STATUS,
   v_new_data.INCIDENT_ABOUT,
   v_new_data.INCIDENT_DESCRIPTION,
   --v_new_data.INCIDENT_REASON,
   v_new_data.INCIDENT_STATUS,
   v_new_data.INCIDENT_STATUS_DT,
   v_new_data.INSTANCE_COMPLETE_DT,
   v_new_data.INSTANCE_STATUS,
   v_new_data.LAST_UPDATE_BY_NAME,
   v_new_data.LAST_UPDATE_BY_DT,
   v_new_data.UPDATED_BY,
   v_new_data.OTHER_PARTY_NAME,
   v_new_data.PRIORITY,
   v_new_data.REPORTED_BY,
   v_new_data.REPORTER_RELATIONSHIP,
   v_new_data.RESOLUTION_DESCRIPTION,
   v_new_data.RESOLUTION_TYPE,
   v_new_data.CASE_ID,
   v_new_data.FORWARDED,
   v_new_data.FORWARDED_TO,
   v_new_data.ASF_IDR_REVIEW_DOCS,
   v_new_data.ASF_GATHER_MISS_INFO,
   v_new_data.GWF_CONTINUE_APPEAL,
   v_new_data.COMPLETE_DT,
   v_new_data.CURRENT_STEP,
   v_new_data.APPELLANT_TYPE,
   v_new_data.APPELLANT_TYPE_DESC,
   v_new_data.REPORTER_NAME,
   v_new_data.REPORTER_PHONE,
   v_new_data.CHANNEL,
   v_new_data.ACCOUNT_ID,
   v_new_data.PREF_LANGUAGE
   
  );

   INS_FIDRBD
        (v_identifier ,v_start_date ,v_end_date ,v_bi_id , v_DIDRAC_ID ,
        v_new_data.CURRENT_TASK_ID,v_DIDRES_ID, v_DIDRIA_ID,v_DIDRID_ID, --v_DIDRIR_ID,
        v_DIDRIS_ID,v_DIDRIN_ID,v_DIDRLUBN_ID,v_DIDRLUB_ID,v_DIDRRD_ID,
        v_DIDRRT_ID,v_new_data.Client_ID,v_new_data.Incident_Status_Dt,
        v_new_data.LAST_UPDATE_BY_DT,  v_new_data.COMPLETE_DT,
        v_fidrbd_id
         );

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

  end INSERT_BPM_SEMANTIC;


  -- Update fact for BPM Semantic model - NYHIX IDR Incident process.
    procedure UPD_FIDRBD
      (
       P_IDENTIFIER       in number,
       P_START_DATE       in date,
       P_END_DATE         in date,
       p_bi_id            in number,
       P_DIDRAC_ID        in number,
       P_CURRENT_TASK_ID  in number,
       P_DIDRES_ID        in number,
       P_DIDRIA_ID        in number,
       P_DIDRID_ID        in number,
       --P_DIDRIR_ID        in number,
       p_DIDRIS_ID        in number,
       P_DIDRIN_ID        in number,
       P_DIDRLUBN_ID      in number,
       P_DIDRLUB_ID       in number,
       P_DIDRRD_ID        in number,
       P_DIDRRT_ID        in number,
       P_CLIENT_ID              IN number,
       P_Incident_Status_Dt     in Varchar2,
       P_LAST_UPDATE_BY_DT      in Varchar2,
       P_COMPLETE_DT        in Varchar2,
       P_Stg_Last_Update_Date   In Varchar2,
       P_FIDRBD_ID              OUT number
       )
     as
    V_PROCEDURE_NAME varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FIDRBD';
    v_sql_code number := null;
    v_log_message clob := null;

    v_fidrbd_id_old        number := null;
    v_d_date_old           date := null;
    V_CURRENT_TASK_ID      Number := Null;
    V_CLIENT_ID            Number := Null;
    V_INCIDENT_STATUS_DT   Date := Null;
    V_LAST_UPDATE_BY_DT    date := null;
    V_COMPLETE_DT          date := null;
    v_Stg_Last_Update_Date date := null;
    v_creation_count_old   number := null;
    v_completion_count_old number := null;
    v_max_d_date           date := null;
    v_event_date           date := null;

    v_DIDRAC_ID        number := null;
    v_DIDRES_ID        number := null;
    v_DIDRIA_ID        number := null;
    v_DIDRID_ID        number := null;
    --v_DIDRIR_ID        number := null;
    v_DIDRIS_ID        number := null;
    v_DIDRIN_ID        number := null;
    v_DIDRLUBN_ID      number := null;
    v_DIDRLUB_ID       number := null;
    v_DIDRRD_ID        number := null;
    v_DIDRRT_ID        number := null;
    v_fidrbd_id        number := null;

    r_fidrbd    F_IDR_BY_DATE%rowtype := null;

  begin

      V_Stg_Last_Update_Date := To_Date(P_Stg_Last_Update_Date, Bpm_Common.Date_Fmt);
      V_LAST_UPDATE_BY_DT    := to_date(P_LAST_UPDATE_BY_DT, BPM_COMMON.DATE_FMT);
      v_event_date           := v_stg_last_update_date;
      v_CURRENT_TASK_ID      := p_CURRENT_TASK_ID;
      V_CLIENT_ID            := P_CLIENT_ID;
      v_INCIDENT_STATUS_DT   := to_date(p_INCIDENT_STATUS_DT,BPM_COMMON.DATE_FMT);
      v_COMPLETE_DT          := to_date(p_COMPLETE_DT,BPM_COMMON.DATE_FMT);

     v_DIDRAC_ID     := p_DIDRAC_ID;
     v_DIDRES_ID     := p_DIDRES_ID;
     v_DIDRIA_ID     := p_DIDRIA_ID;
     v_DIDRID_ID     := p_DIDRID_ID;
     --v_DIDRIR_ID     := p_DIDRIR_ID;
     v_DIDRIS_ID     := p_DIDRIS_ID;
     v_DIDRIN_ID     := p_DIDRIN_ID;
     v_DIDRLUBN_ID   := p_DIDRLUBN_ID;
     v_DIDRLUB_ID    := p_DIDRLUB_ID;
     v_DIDRRD_ID     := p_DIDRRD_ID;
     v_DIDRRT_ID     := p_DIDRRT_ID;
     v_fidrbd_id     := p_fidrbd_id;

     with most_recent_fact_bi_id as
           (select
              max(FIDRBD_ID) max_fidrbd_id,
              max(D_DATE) max_d_date
            from F_IDR_BY_DATE
            where IDR_BI_ID = p_bi_id)
         select
           fidrbd.FIDRBD_ID,
           fidrbd.D_DATE,
           fidrbd.CREATION_COUNT,
           fidrbd.COMPLETION_COUNT,
           most_recent_fact_bi_id.max_d_date
         into
           v_fidrbd_id_old,
           v_d_date_old,
           v_creation_count_old,
           v_completion_count_old,
           v_max_d_date
         from
           F_IDR_BY_DATE fidrbd,
           most_recent_fact_bi_id
         where
           fidrbd.FIDRBD_ID = max_fidrbd_id
      and fidrbd.D_DATE = most_recent_fact_bi_id.max_d_date;

      -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;

    -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE.
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;

   if p_end_date is null then
      r_fidrbd.D_DATE := v_event_date;
      r_fidrbd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fidrbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fidrbd.INVENTORY_COUNT := 1;
      r_fidrbd.COMPLETION_COUNT := 0;
    else
         -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
          if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then

            delete from F_IDR_BY_DATE
            where
              IDR_BI_ID = p_bi_id
              and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);

            with most_recent_fact_bi_id as
              (select
                 max(FIDRBD_ID) max_fidrbd_id,
                 max(D_DATE) max_d_date
               from F_IDR_BY_DATE
           where IDR_BI_ID = p_bi_id)
           select
               fidrbd.FIDRBD_ID,
               fidrbd.D_DATE,
               fidrbd.CREATION_COUNT,
               fidrbd.COMPLETION_COUNT,
               most_recent_fact_bi_id.max_d_date,
               fidrbd.DIDRAC_ID,
               fidrbd.DIDRES_ID,
               fidrbd.DIDRIA_ID,
               fidrbd.DIDRID_ID,
               --fidrbd.DIDRIR_ID,
               fidrbd.DIDRIS_ID,
               fidrbd.DIDRIN_ID,
               fidrbd.DIDRLUBN_ID,
               fidrbd.DIDRLUB_ID,
               fidrbd.DIDRRD_ID,
               fidrbd.DIDRRT_ID,
               fidrbd.CURRENT_TASK_ID,
               fidrbd.CLIENT_ID,
               fidrbd.INCIDENT_STATUS_DT,
               fidrbd.LAST_UPDATE_BY_DT,
               fidrbd.COMPLETE_DT
             into
               v_fidrbd_id_old,
               v_d_date_old,
               v_creation_count_old,
               v_completion_count_old,
               v_max_d_date,
               v_DIDRAC_ID,
               v_DIDRES_ID,
               v_DIDRIA_ID,
               v_DIDRID_ID,
               --v_DIDRIR_ID,
               v_DIDRIS_ID,
               v_DIDRIN_ID,
               v_DIDRLUBN_ID,
               v_DIDRLUB_ID,
               v_DIDRRD_ID,
               v_DIDRRT_ID,
               v_CURRENT_TASK_ID,
               v_CLIENT_ID,
               v_INCIDENT_STATUS_DT,
               v_LAST_UPDATE_BY_DT,
               v_COMPLETE_DT
             from
               F_IDR_BY_DATE fidrbd,
               most_recent_fact_bi_id
             where
               fidrbd.FIDRBD_ID = max_fidrbd_id
          and fidrbd.D_DATE = most_recent_fact_bi_id.max_d_date;

      end if;

      r_fidrbd.D_DATE := p_end_date;
      r_fidrbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fidrbd.BUCKET_END_DATE := r_fidrbd.BUCKET_START_DATE;
      r_fidrbd.INVENTORY_COUNT := 0;
      r_fidrbd.COMPLETION_COUNT := 1;

    end if;

               p_fidrbd_id                   := SEQ_FIDRBD_ID.nextval;
               r_fidrbd.FIDRBD_ID            := p_fidrbd_id;
               r_fidrbd.IDR_BI_ID            := p_bi_id;
               r_fidrbd.DIDRAC_ID            := v_DIDRAC_ID;
               r_fidrbd.DIDRES_ID            := v_DIDRES_ID;
               r_fidrbd.DIDRIA_ID            := v_DIDRIA_ID;
               r_fidrbd.DIDRID_ID            := v_DIDRID_ID;
               --r_fidrbd.DIDRIR_ID            := v_DIDRIR_ID;
               r_fidrbd.DIDRIS_ID            := v_DIDRIS_ID;
               r_fidrbd.DIDRIN_ID            := v_DIDRIN_ID;
               r_fidrbd.DIDRLUBN_ID          := v_DIDRLUBN_ID;
               r_fidrbd.DIDRLUB_ID           := v_DIDRLUB_ID;
               r_fidrbd.DIDRRD_ID            := v_DIDRRD_ID;
               R_Fidrbd.Didrrt_Id            := v_Didrrt_Id;
               R_Fidrbd.Current_Task_Id      := V_Current_Task_Id;
               R_FIDRBD.CLIENT_ID            := V_CLIENT_ID;
               r_fidrbd.INCIDENT_STATUS_DT   := v_INCIDENT_STATUS_DT;
               r_fidrbd.LAST_UPDATE_BY_DT    := V_LAST_UPDATE_BY_DT;
               r_fidrbd.COMPLETE_DT          := V_COMPLETE_DT;
               r_fidrbd.CREATION_COUNT       := 0;

 -- Validate fact date ranges.
     if r_fidrbd.D_DATE < r_fidrbd.BUCKET_START_DATE
       or to_date(to_char(r_fidrbd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fidrbd.BUCKET_END_DATE
       or r_fidrbd.BUCKET_START_DATE > r_fidrbd.BUCKET_END_DATE
       or r_fidrbd.BUCKET_END_DATE < r_fidrbd.BUCKET_START_DATE
     then
       v_sql_code := -20030;
       v_log_message := 'Attempted to insert invalid fact date range.  ' ||
         'D_DATE = ' || r_fidrbd.D_DATE ||
         ' BUCKET_START_DATE = ' || to_char(r_fidrbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
         ' BUCKET_END_DATE = ' || to_char(r_fidrbd.BUCKET_END_DATE,v_date_bucket_fmt);
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
       RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
     end if;

   if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fidrbd.BUCKET_START_DATE then

      -- Same bucket time.

      if v_creation_count_old = 1 then
        r_fidrbd.CREATION_COUNT := v_creation_count_old;
      end if;

      update F_IDR_BY_DATE
      set row = r_fidrbd
      where FIDRBD_ID = v_fidrbd_id_old;

    else

     -- Different bucket time.

          update F_IDR_BY_DATE
          set BUCKET_END_DATE = r_fidrbd.BUCKET_START_DATE
          where FIDRBD_ID = v_fidrbd_id_old;

          insert into F_IDR_BY_DATE
          values r_fidrbd;

        end if;

      exception

        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
          raise;

      end UPD_FIDRBD;

  -- Update BPM Semantic model data.
  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype)
  as

      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';
      v_sql_code number := null;
      v_log_message clob := null;

      v_old_data T_UPD_IDR_XML := null;
      v_new_data T_UPD_IDR_XML := null;

      v_bi_id number := null;
      v_identifier varchar2(100) := null;

      v_start_date date := null;
      v_end_date date := null;

      v_DIDRAC_ID   number    := null;
      v_DIDRES_ID   number    := null;
      v_DIDRIA_ID   number    := null;
      v_DIDRID_ID   number    := null;
      --v_DIDRIR_ID   number    := null;
      v_DIDRIS_ID   number    := null;
      v_DIDRIN_ID   number    := null;
      v_DIDRLUBN_ID number    := null;
      V_DIDRLUB_ID  number    := null;
      v_DIDRRD_ID   number    := null;
      v_DIDRRT_ID   number    := null;
      V_FIDRBD_ID   number    := null;
      v_fmebd_id    number    := null;

    begin

        if P_DATA_VERSION != 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYHX IDR Incidents in procedure' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);
        end if;

        GET_UPD_IDR_XML(p_old_data_xml,v_old_data);
        GET_UPD_IDR_XML(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.INCIDENT_ID ;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

    select IDR_BI_ID 
    into v_bi_id
    from D_IDR_CURRENT
    where INCIDENT_ID = v_identifier;

   GET_DIDRAC_ID(v_identifier, v_bi_id, v_new_data.ACTION_COMMENTS, v_DIDRAC_ID);
   GET_DIDRES_ID(v_identifier, v_bi_id, v_new_data.ENROLLMENT_STATUS, v_DIDRES_ID);
   GET_DIDRIA_ID(v_identifier, v_bi_id, v_new_data.INCIDENT_ABOUT, v_DIDRIA_ID);
   GET_DIDRID_ID(v_identifier, v_bi_id, v_new_data.INCIDENT_DESCRIPTION, v_DIDRID_ID);
   --GET_DIDRIR_ID(v_identifier, v_bi_id, v_new_data.INCIDENT_REASON, v_DIDRIR_ID);
   GET_DIDRIS_ID(v_identifier, v_bi_id, v_new_data.INCIDENT_STATUS, v_DIDRIS_ID);
   GET_DIDRIN_ID(v_identifier, v_bi_id, v_new_data.INSTANCE_STATUS, v_DIDRIN_ID);
   GET_DIDRLUBN_ID(v_identifier, v_bi_id, v_new_data.LAST_UPDATE_BY_NAME, v_DIDRLUBN_ID);
   GET_DIDRLUB_ID(v_identifier, v_bi_id, v_new_data.UPDATED_BY, v_DIDRLUB_ID);
   GET_DIDRRD_ID(v_identifier, v_bi_id, v_new_data.RESOLUTION_DESCRIPTION, v_DIDRRD_ID);
   GET_DIDRRT_ID(v_identifier, v_bi_id, v_new_data.RESOLUTION_TYPE, v_DIDRRT_ID);

   -- Update current dimension and fact as a single transaction.
    begin

      commit;

  SET_DIDRCUR
        ('UPDATE',v_identifier,v_bi_id,
   v_new_data.INCIDENT_ID,
   v_new_data.CREATED_BY_GROUP,
   v_new_data.CREATED_BY_NAME,
   v_new_data.TRACKING_NUMBER,
   v_new_data.CREATE_DT,
   v_new_data.INCIDENT_TYPE,
   v_new_data.CLIENT_ID,
   v_new_data.ASSD_IDR_REVIEW_DOCS,
   v_new_data.ASED_IDR_REVIEW_DOCS,
   v_new_data.ASPB_IDR_REVIEW_DOCS,
   v_new_data.ASSD_GATHER_MISS_INFO,
   v_new_data.ASED_GATHER_MISS_INFO,
   v_new_data.ASPB_GATHER_MISS_INFO,
   v_new_data.ABOUT_PLAN_CODE,
   v_new_data.ABOUT_PROVIDER_ID,
   v_new_data.ACTION_COMMENTS,
   v_new_data.ACTION_TYPE,
   v_new_data.CANCEL_BY,
   v_new_data.CANCEL_DT,
   v_new_data.CANCEL_METHOD,
   v_new_data.CANCEL_REASON,
   v_new_data.CURRENT_TASK_ID,
   v_new_data.ENROLLMENT_STATUS,
   v_new_data.INCIDENT_ABOUT,
   v_new_data.INCIDENT_DESCRIPTION,
   --v_new_data.INCIDENT_REASON,
   v_new_data.INCIDENT_STATUS,
   v_new_data.INCIDENT_STATUS_DT,
   v_new_data.INSTANCE_COMPLETE_DT,
   v_new_data.INSTANCE_STATUS,
   v_new_data.LAST_UPDATE_BY_NAME,
   V_NEW_DATA.LAST_UPDATE_BY_DT,
   v_new_data.UPDATED_BY,
   v_new_data.OTHER_PARTY_NAME,
   v_new_data.PRIORITY,
   v_new_data.REPORTED_BY,
   v_new_data.REPORTER_RELATIONSHIP,
   v_new_data.RESOLUTION_DESCRIPTION,
   v_new_data.RESOLUTION_TYPE,
   v_new_data.CASE_ID,
   v_new_data.FORWARDED,
   v_new_data.FORWARDED_TO,
   v_new_data.ASF_IDR_REVIEW_DOCS,
   v_new_data.ASF_GATHER_MISS_INFO,
   v_new_data.GWF_CONTINUE_APPEAL,
   v_new_data.COMPLETE_DT,
   v_new_data.CURRENT_STEP,
   v_new_data.APPELLANT_TYPE,
   v_new_data.APPELLANT_TYPE_DESC,
   v_new_data.REPORTER_NAME,
   v_new_data.REPORTER_PHONE,
   v_new_data.CHANNEL,
   v_new_data.ACCOUNT_ID,
   v_new_data.PREF_LANGUAGE
  );


  UPD_FIDRBD
        (v_identifier ,v_start_date ,v_end_date ,v_bi_id , v_DIDRAC_ID, v_new_data.CURRENT_TASK_ID, v_DIDRES_ID,
       v_DIDRIA_ID, v_DIDRID_ID, /*v_DIDRIR_ID,*/ v_DIDRIS_ID, v_DIDRIN_ID, v_DIDRLUBN_ID, v_DIDRLUB_ID,
       V_DIDRRD_ID, V_DIDRRT_ID, V_NEW_DATA.CLIENT_ID, V_NEW_DATA.INCIDENT_STATUS_DT, V_NEW_DATA.LAST_UPDATE_BY_DT,
       V_NEW_DATA.COMPLETE_DT,
       v_new_data.Stg_Last_Update_Date,
       v_FIDRBD_ID
         );


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

  end UPDATE_BPM_SEMANTIC;

end IDR_INCIDENTS;
/

  
alter session set plsql_code_type = interpreted;