create or replace package maxdat.PROCESS_COMPLAINTS_INCIDENTS as


-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ProcessComplaints/createdb/PROCESS_COMPLAINTS_INCIDENTS_pkg.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 17856 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2016-08-04 21:16:16 -0600 (Thu, 04 Aug 2016) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: pa28085 $';

  procedure CALC_DCMPLCUR;

  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable;

  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable;

  function GET_JEOPARDY_STATUS
    (p_create_dt in date,
     p_forward_dt in date,
     p_complete_dt in date,
     p_identifier_type in varchar2
 )
    return varchar2 parallel_enable;

  function GET_TIMELINESS_STATUS
    (p_create_dt in date,
     p_complete_dt in date,
     p_forwarded in varchar2 default 'N',
     p_forward_dt in date,
     p_identifier_type in varchar2
)
    return varchar2 parallel_enable;

  function GET_SLA_JEOPARDY_DATE
    (p_create_dt in date,
     p_identifier_type in varchar2
 )
  return date parallel_enable;

  function GET_FWDING_TARGET
      (p_forwarded_to in varchar2,
       p_identifier_type in varchar2
   )
    return number parallel_enable result_cache;

  function GET_FWDING_TIMELINESS_STATUS
        (p_forwarded in varchar2,
         p_forwarded_to in varchar2,
         p_complete_dt in date,
         p_assd_reslv_inci_doh in date,
         p_ased_reslv_inci_doh in date,
         p_identifier_type in varchar2
    )
      return varchar2 parallel_enable;
  /*
    Include:
    CECI_ID
    STG_LAST_UPDATE_DATE
  */
  type T_INS_PD_XML is record
    (
     ABOUT_PLAN_CODE varchar2(32),
     ABOUT_PROVIDER_ID varchar2(100),
     ACTION_COMMENTS varchar2(4000),
     ACTION_TYPE varchar2(64),
     ASED_PERFORM_FOLLOWUP varchar2(19),
     ASED_RESOLVE_INCIDENT_DOH varchar2(19),
     ASED_RESOLVE_INCIDENT_EES_CSS varchar2(19),
     ASED_RESOLVE_INCIDENT_SUP varchar2(19),
     ASED_WITHDRAW_INCIDENT varchar2(19),
     ASF_PERFORM_FOLLOWUP varchar2(1),
     ASF_RESOLVE_INCIDENT_DOH varchar2(1),
     ASF_RESOLVE_INCIDENT_EES_CSS varchar2(1),
     ASF_RESOLVE_INCIDENT_SUP varchar2(1),
     ASF_WITHDRAW_INCIDENT varchar2(1),
     ASSD_PERFORM_FOLLOWUP varchar2(19),
     ASSD_RESOLVE_INCIDENT_DOH varchar2(19),
     ASSD_RESOLVE_INCIDENT_EES_CSS varchar2(19),
     ASSD_RESOLVE_INCIDENT_SUP varchar2(19),
     ASSD_WITHDRAW_INCIDENT varchar2(19),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(40),
     CANCEL_REASON varchar2(40),
     CASE_CIN varchar2(30),
     CASE_ID varchar2(100),
     CHANNEL varchar2(80),
     CLIENT_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     CREATED_BY_SUP Varchar2(1),
     CREATED_BY_EID Varchar2(80),
     CREATED_BY_SUP_NAME Varchar2(100),
     CREATED_BY_GROUP varchar2(80),
     CREATED_BY_NAME varchar2(100),
     CREATE_DT varchar2(19),
     CURRENT_TASK_ID varchar2(100),
     CURRENT_STEP varchar2(256),
     DE_TASK_ID varchar2(100),
     FORWARDED varchar2(1),
     FORWARDED_TO varchar2(50),
     FORWARD_DT varchar2(19),
     GWF_ESCALATE_TO_STATE varchar2(1),
     GWF_FOLLOWUP_REQ varchar2(1),
     GWF_RESOLVED_EES_CSS varchar2(30),
     GWF_RESOLVED_SUP varchar2(1),
     GWF_RETURN_TO_STATE varchar2(1),
     INCIDENT_ABOUT varchar2(80),
     INCIDENT_DESCRIPTION varchar2(4000),
     INCIDENT_ID varchar2(100),
     INCIDENT_REASON varchar2(80),
     INCIDENT_STATUS varchar2(80),
     INCIDENT_STATUS_DT varchar2(19),
     INCIDENT_TYPE varchar2(80),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(10),
     LAST_UPDATE_BY_DT varchar2(19),
     LAST_UPDATE_BY_NAME varchar2(100),
     CECI_ID varchar2(100),
     OTHER_PARTY_NAME varchar2(64),
     PLAN_NAME varchar2(64),
     PRIORITY varchar2(256),
     RECEIVED_DT varchar2(19),
     REPORTED_BY varchar2(80),
     REPORTER_NAME varchar2(180),
     REPORTER_PHONE varchar2(32),
     REPORTER_RELATIONSHIP varchar2(64),
     RESOLUTION_DESCRIPTION varchar2(4000),
     RESOLUTION_TYPE varchar2(64),
     SLA_SATISFIED varchar2(1),
     SLA_COMPLETE_DT varchar2(19),
     STG_LAST_UPDATE_DATE varchar2(19),
     TRACKING_NUMBER varchar2(32),
     UPDATED_BY varchar2(80),
     PREF_LANGUAGE varchar2(255)
    );

  /*
    Include:
    STG_LAST_UPDATE_DATE
  */
  type T_UPD_PD_XML is record
    (
          ABOUT_PLAN_CODE varchar2(32),
     ABOUT_PROVIDER_ID varchar2(100),
     ACTION_COMMENTS varchar2(4000),
     ACTION_TYPE varchar2(64),
     ASED_PERFORM_FOLLOWUP varchar2(19),
     ASED_RESOLVE_INCIDENT_DOH varchar2(19),
     ASED_RESOLVE_INCIDENT_EES_CSS varchar2(19),
     ASED_RESOLVE_INCIDENT_SUP varchar2(19),
     ASED_WITHDRAW_INCIDENT varchar2(19),
     ASF_PERFORM_FOLLOWUP varchar2(1),
     ASF_RESOLVE_INCIDENT_DOH varchar2(1),
     ASF_RESOLVE_INCIDENT_EES_CSS varchar2(1),
     ASF_RESOLVE_INCIDENT_SUP varchar2(1),
     ASF_WITHDRAW_INCIDENT varchar2(1),
     ASSD_PERFORM_FOLLOWUP varchar2(19),
     ASSD_RESOLVE_INCIDENT_DOH varchar2(19),
     ASSD_RESOLVE_INCIDENT_EES_CSS varchar2(19),
     ASSD_RESOLVE_INCIDENT_SUP varchar2(19),
     ASSD_WITHDRAW_INCIDENT varchar2(19),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(40),
     CANCEL_REASON varchar2(40),
     CASE_CIN varchar2(30),
     CASE_ID varchar2(100),
     CHANNEL varchar2(80),
     CLIENT_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     CREATED_BY_SUP Varchar2(1),
     CREATED_BY_EID Varchar2(80),
     CREATED_BY_SUP_NAME Varchar2(100),
     CREATED_BY_GROUP varchar2(80),
     CREATED_BY_NAME varchar2(100),
     CREATE_DT varchar2(19),
     CURRENT_TASK_ID varchar2(100),
     CURRENT_STEP varchar2(256),
     DE_TASK_ID varchar2(100),
     FORWARDED varchar2(1),
     FORWARDED_TO varchar2(50),
     FORWARD_DT varchar2(19),
     GWF_ESCALATE_TO_STATE varchar2(1),
     GWF_FOLLOWUP_REQ varchar2(1),
     GWF_RESOLVED_EES_CSS varchar2(30),
     GWF_RESOLVED_SUP varchar2(1),
     GWF_RETURN_TO_STATE varchar2(1),
     INCIDENT_ABOUT varchar2(80),
     INCIDENT_DESCRIPTION varchar2(4000),
     INCIDENT_ID varchar2(100),
     INCIDENT_REASON varchar2(80),
     INCIDENT_STATUS varchar2(80),
     INCIDENT_STATUS_DT varchar2(19),
     INCIDENT_TYPE varchar2(80),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(10),
     LAST_UPDATE_BY_DT varchar2(19),
     LAST_UPDATE_BY_NAME varchar2(100),
     OTHER_PARTY_NAME varchar2(64),
     PLAN_NAME varchar2(64),
     PRIORITY varchar2(256),
     RECEIVED_DT varchar2(19),
     REPORTED_BY varchar2(80),
     REPORTER_NAME varchar2(180),
     REPORTER_PHONE varchar2(32),
     REPORTER_RELATIONSHIP varchar2(64),
     RESOLUTION_DESCRIPTION varchar2(4000),
     RESOLUTION_TYPE varchar2(64),
     SLA_SATISFIED varchar2(1),
     SLA_COMPLETE_DT varchar2(19),
     STG_LAST_UPDATE_DATE varchar2(19),
     TRACKING_NUMBER varchar2(32),
     UPDATED_BY varchar2(80),
     PREF_LANGUAGE varchar2(255)
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
create or replace package body maxdat.PROCESS_COMPLAINTS_INCIDENTS as


  v_bem_id number := 22; -- 'PROCESS_COMPLAINTS_INCIDENTS'
  v_bil_id number := 10; -- 'Incident ID'
  v_bsl_id number := 22; -- ''
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  v_calc_DCMPLCUR_job_name varchar2(30) := 'CALC_DCMPLCUR';
  v_jeopardy_days number ;
  v_fwding_target number;
  v_bus_datewith_target date;
  v_bus_datewith_jeop date;
  v_timeliness_days number ;
  v_step  varchar2(100);
  v_complete_dt date;

  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable
  as
  begin
     return BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,nvl(p_complete_date,sysdate));
  end;
  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable
  as
  begin
    return trunc(nvl(p_complete_date,sysdate)) - trunc(p_create_date);
  end;


  function GET_JEOPARDY_STATUS
    (p_create_dt in date,
     p_forward_dt in date,
     p_complete_dt in date,
     p_identifier_type in varchar2
  )
    return varchar2 parallel_enable
      as
  begin
  if p_identifier_type is not null then

    select /*+ RESULT_CACHE +*/ to_number(out_var)
    into    v_jeopardy_days
    from    corp_etl_list_lkup
    where   name = 'ProcessComp_jeop_threshold'
    and     list_type = 'COMPLAINT'
    and     value = p_identifier_type;

   if  v_jeopardy_days is not null then
     if (ETL_COMMON.GET_BUS_DATE(p_create_dt,v_jeopardy_days) ) < coalesce(p_forward_dt,p_complete_dt,SYSDATE ) then
        return 'Y';
     else
        return 'N';
     end if;
   else
     return 'N';
   end if;
  else
       return 'N';
  end if;
  end;


  function GET_TIMELINESS_STATUS
    (p_create_dt in date,
     p_complete_dt in date,
     p_forwarded in varchar2 default 'N',
     p_forward_dt in date,
     p_identifier_type in varchar2
)
    return varchar2 parallel_enable
  as
  begin

  v_timeliness_days := 0;

 if p_identifier_type is not null then

    select /*+ RESULT_CACHE +*/ to_number(out_var)
    into    v_timeliness_days
    from    corp_etl_list_lkup
    where   name = 'ProcessComp_timeli_threshold'
    and     list_type = 'COMPLAINT'
    and     value = p_identifier_type;

    if v_timeliness_days is not null then
      v_bus_datewith_jeop := ETL_COMMON.GET_BUS_DATE(p_create_dt,v_timeliness_days);
    else
      return 'Not Processed';
    end if;

   -- v_complete_dt := nvl(p_complete_dt,SYSDATE);
    IF p_complete_dt IS NOT NULL THEN
      if P_forwarded is not null and p_forwarded = 'N' then
        if (v_bus_datewith_jeop > p_complete_dt or  v_bus_datewith_jeop = trunc(p_complete_dt))  then
          return 'Processed Timely';
        elsif   v_bus_datewith_jeop < p_complete_dt  then
          return 'Processed Untimely';
        else
          return  'Not Processed';
       end if;
      elsif P_forwarded is not null and p_forwarded = 'Y' then
        if (v_bus_datewith_jeop > nvl(p_forward_dt,p_complete_dt)
              or trunc(v_bus_datewith_jeop) = nvl( trunc(p_forward_dt),trunc(p_complete_dt)))  then
          return 'Processed Timely';
        elsif  v_bus_datewith_jeop < nvl(p_forward_dt,p_complete_dt)  then
          return 'Processed Untimely';
        else
          return  'Not Processed';
        end if;
      else return 'Not Processed';
      end if;
    else
        return 'Not Processed';
    end if;
    else
      return 'Not Processed';
   END IF;
   end;

    function GET_SLA_JEOPARDY_DATE
        (p_create_dt in date,
         p_identifier_type in varchar2
      )
        return date parallel_enable
          as
      begin
      if p_identifier_type is not null then

        select /*+ RESULT_CACHE +*/ to_number(out_var)
        into    v_jeopardy_days
        from    corp_etl_list_lkup
        where   name = 'ProcessComp_jeop_threshold'
        and     list_type = 'COMPLAINT'
        and     value = p_identifier_type;

       return  ETL_COMMON.GET_BUS_DATE(p_create_dt,v_jeopardy_days);

      end if;
  end;


    function GET_FWDING_TARGET
        (p_forwarded_to in varchar2,
         p_identifier_type in varchar2
      )
        return number parallel_enable result_cache
          as
      begin
      v_fwding_target := 0;

      if p_identifier_type is not null and p_forwarded_to is not null then

        select  to_number(out_var)
        into    v_fwding_target
        from    corp_etl_list_lkup
        where   name = 'ProcessComp_Fwding_Target'
       -- and     list_type = 'COMPLAINT'
        and 	list_type = p_identifier_type
        and     value = p_forwarded_to;
      end if;
    return  v_fwding_target;
    end;


  function GET_FWDING_TIMELINESS_STATUS
      ( p_forwarded in varchar2,
       p_forwarded_to in varchar2,
       p_complete_dt in date,
       p_assd_reslv_inci_doh in date,
       p_ased_reslv_inci_doh in date,
       p_identifier_type in varchar2
  )
      return varchar2 parallel_enable
    as
    begin
    v_complete_dt := nvl(p_complete_dt,SYSDATE);

   if p_identifier_type is not null and p_forwarded = 'Y' then

      v_fwding_target := GET_FWDING_TARGET(p_forwarded_to,p_identifier_type);

      if p_assd_reslv_inci_doh is not null then
         v_bus_datewith_target := ETL_COMMON.GET_BUS_DATE(p_assd_reslv_inci_doh,v_fwding_target);
      else
        v_bus_datewith_target := p_complete_dt ;
      end if;

        if (v_bus_datewith_target > nvl( p_ased_reslv_inci_doh,p_complete_dt)
         or trunc(v_bus_datewith_target ) = nvl(trunc(p_ased_reslv_inci_doh) ,trunc(p_complete_dt))) then
          return 'Within Forwarding Target';
        elsif
           v_bus_datewith_target < nvl(p_ased_reslv_inci_doh ,p_complete_dt) then
          return 'Past Forwarding Target';
        else
          return 'Not Processed';
        end if;
     else
        return 'Not Processed';
    end if;
  end;

   -- Calculate column values in BPM Semantic table D_COMPLAINT_CURRENT.
  procedure CALC_DCMPLCUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DCMPLCUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin

    update D_COMPLAINT_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,COMPLETE_DT),
      AGE_IN_CALENDAR_DAYS = GET_AGE_IN_CALENDAR_DAYS(CREATE_DATE,COMPLETE_DT),
      JEOPARDY_FLAG = GET_JEOPARDY_STATUS(CREATE_DATE,FORWARD_DT,COMPLETE_DT,INCIDENT_TYPE),
      TIMELINESS_STATUS = GET_TIMELINESS_STATUS(CREATE_DATE,COMPLETE_DT,FORWARDED_FLAG,FORWARD_DT,INCIDENT_TYPE),
  --    JEOPARDY_DAYS_TYPE = 'B',
  --    SLA_DAYS_TYPE = 'B',
      SLA_JEOPARDY_DATE = GET_SLA_JEOPARDY_DATE(CREATE_DATE,INCIDENT_TYPE),
  --    SLA_JEOPARDY_DAYS = 7,
  --    SLA_TARGET_DAYS = 10,
      INCIDENT_FWD_TIMELINESS_STATUS  = GET_FWDING_TIMELINESS_STATUS(FORWARDED_FLAG,FORWARDED_TO,COMPLETE_DT,RESOLVE_INCIDENT_START,RESOLVE_INCIDENT_END, INCIDENT_TYPE)
   --   INCIDENT_FORWARDING_TARGET = GET_FWDING_TARGET(FORWARDED_TO,INCIDENT_TYPE)
      where
     COMPLETE_DT is null ;
    --  and "Cancel Date" is null;

    v_num_rows_updated := sql%rowcount;

    commit;

    v_log_message := v_num_rows_updated  || ' D_COMPLAINT_CURRENT rows updated with calculated attributes by CALC_DCMPLCUR.';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
  end;


  -- Get dimension ID for BPM Semantic model - PROCESS_COMPLAINTS_INCIDENTS - Instance Status.
  procedure GET_DCMPLIN_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_ins_status in varchar2,
      p_dcmplin_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLIN_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DCMPLIN_ID into p_dcmplin_id
     from D_COMPLAINT_INSTANCE_STATUS
     where
       INSTANCE_STATUS = p_ins_status
       or (INSTANCE_STATUS is null and p_ins_status is null);
   exception
     when NO_DATA_FOUND then
       p_dcmplin_id := SEQ_DCMPLIN_ID.nextval;
       begin
         insert into D_COMPLAINT_INSTANCE_STATUS (DCMPLIN_ID,INSTANCE_STATUS)
         values (p_dcmplin_id,p_ins_status);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DCMPLIN_ID into p_dcmplin_id
           from D_COMPLAINT_INSTANCE_STATUS
           where
             INSTANCE_STATUS = p_ins_status
             or (INSTANCE_STATUS is null and p_ins_status is null);
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


  -- Get dimension ID for BPM Semantic model - PROCESS_COMPLAINTS_INCIDENTS - Incident Status.
  procedure GET_DCMPLIS_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_status in varchar2,
     p_dcmplis_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLIS_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DCMPLIS_ID into p_dcmplis_id
    from D_COMPLAINT_INCIDENT_STATUS
    where
      INCIDENT_STATUS = p_status
      or (INCIDENT_STATUS is null and p_status is null);
  exception
    when NO_DATA_FOUND then
      p_dcmplis_id := SEQ_DCMPLIS_ID.nextval;
      begin
        insert into D_COMPLAINT_INCIDENT_STATUS (DCMPLIS_ID,INCIDENT_STATUS)
        values (p_dcmplis_id,p_status);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DCMPLIS_ID into p_dcmplis_id
          from D_COMPLAINT_INCIDENT_STATUS
          where
            INCIDENT_STATUS = p_status
            or (INCIDENT_STATUS is null and p_status is null);
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


  -- Get dimension ID for BPM Semantic model - PROCESS_COMPLAINTS_INCIDENTS  - SLA Satisfied
  procedure GET_DCMPLSS_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_sla_satisfied in varchar2,
     p_dcmplss_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLSS_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DCMPLSS_ID into p_dcmplss_id
    from D_COMPLAINT_SLA_SATISFIED
    where
      SLA_SATISFIED = p_sla_satisfied
      or (SLA_SATISFIED is null and p_sla_satisfied is null);
  exception
    when NO_DATA_FOUND then
      p_dcmplss_id := SEQ_DCMPLSS_ID.nextval;
      begin
        insert into D_COMPLAINT_SLA_SATISFIED (DCMPLSS_ID,SLA_SATISFIED)
        values (p_dcmplss_id,p_sla_satisfied);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DCMPLSS_ID into p_dcmplss_id
          from D_COMPLAINT_SLA_SATISFIED
          where
            SLA_SATISFIED = p_sla_satisfied
            or (SLA_SATISFIED is null and p_sla_satisfied is null);
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


 -- Get dimension ID for BPM Semantic model - Process Complaints Incidents - action comments
  procedure GET_DCMPLAC_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_action_comments in varchar2,
     p_dcmplac_id out number)
  as
   v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLAC_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    p_dcmplac_id := SEQ_DCMPLAC_ID.nextval;
      begin
       insert into D_COMPLAINT_ACTION_COMMENTS(DCMPLAC_ID,ACTION_COMMENTS)
        values   (p_dcmplac_id,p_action_comments);
                                
        commit;
      exception
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
          raise;
      end;
  end;



  -- Get dimension ID for BPM Semantic model - Process Complaints Incidents -Incident About
  procedure GET_DCMPLIA_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_incident_about in varchar2,
     p_dcmplia_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLIA_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DCMPLIA_ID into p_dcmplia_id
    from D_COMPLAINT_INCIDENT_ABOUT
    where
      INCIDENT_ABOUT  = p_incident_about
      or (INCIDENT_ABOUT  is null and p_incident_about is null);
  exception
    when NO_DATA_FOUND then
      p_dcmplia_id := SEQ_DCMPLIA_ID.nextval;
      begin
        insert into D_COMPLAINT_INCIDENT_ABOUT (DCMPLIA_ID,INCIDENT_ABOUT )
        values (p_dcmplia_id,p_incident_about);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DCMPLIA_ID into p_dcmplia_id
          from D_COMPLAINT_INCIDENT_ABOUT
          where
            INCIDENT_ABOUT  = p_incident_about
            or (INCIDENT_ABOUT  is null and p_incident_about is null);
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


  -- Get dimension ID for BPM Semantic model - Process Complaints Incidents - Incident_Description
  procedure GET_DCMPLID_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_incident_description in varchar2,
     p_dcmplid_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLID_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DCMPLID_ID into p_dcmplid_id
    from D_COMPLAINT_INCIDENT_DESC
    where
     INCIDENT_DESCRIPTION = to_char(p_incident_description)
      or (INCIDENT_DESCRIPTION is null and to_char(p_incident_description) is null);
  exception
    when NO_DATA_FOUND then
      p_dcmplid_id := SEQ_DCMPLID_ID.nextval;
      begin
        insert into D_COMPLAINT_INCIDENT_DESC  (DCMPLID_ID,INCIDENT_DESCRIPTION)
        values (p_dcmplid_id,to_char(p_incident_description));
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DCMPLID_ID into p_dcmplid_id
          from D_COMPLAINT_INCIDENT_DESC
          where
            INCIDENT_DESCRIPTION = to_char(p_incident_description)
            or (INCIDENT_DESCRIPTION is null and to_char(p_incident_description) is null);
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

  -- Get dimension ID for BPM Semantic model - Process Complaints Incidents - Incident_Reason
  procedure GET_DCMPLIR_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_incident_reason in varchar2,
     p_dcmplir_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLIR_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DCMPLIR_ID into p_dcmplir_id
    from D_COMPLAINT_INCIDENT_REASON
    where
     INCIDENT_REASON = p_incident_reason
      or (INCIDENT_REASON is null and p_incident_reason is null);
  exception
    when NO_DATA_FOUND then
      p_dcmplir_id := SEQ_DCMPLIR_ID.nextval;
      begin
        insert into D_COMPLAINT_INCIDENT_REASON  (DCMPLIR_ID,INCIDENT_REASON)
        values (p_dcmplir_id,p_incident_reason);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DCMPLIR_ID into p_dcmplir_id
          from D_COMPLAINT_INCIDENT_REASON
          where
            INCIDENT_REASON = p_incident_reason
            or (INCIDENT_REASON is null and p_incident_reason is null);
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

  -- Get dimension ID for BPM Semantic model - Process Complaints Incidents - Resolution_Description
  procedure GET_DCMPLRD_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_resolution_description in varchar2,
     p_dcmplrd_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLRD_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DCMPLRD_ID into p_dcmplrd_id
    from D_COMPLAINT_RESOLUTION_DESC
    where
     RESOLUTION_DESCRIPTION = to_char(p_resolution_description)
      or (RESOLUTION_DESCRIPTION is null and to_char(p_resolution_description) is null);
  exception
    when NO_DATA_FOUND then
      p_dcmplrd_id := SEQ_DCMPLRD_ID.nextval;
      begin
        insert into D_COMPLAINT_RESOLUTION_DESC  (DCMPLRD_ID,RESOLUTION_DESCRIPTION)
        values (p_dcmplrd_id,to_char(p_resolution_description));
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DCMPLRD_ID into p_dcmplrd_id
          from D_COMPLAINT_RESOLUTION_DESC
          where
            RESOLUTION_DESCRIPTION = to_char(p_resolution_description)
            or (RESOLUTION_DESCRIPTION is null and to_char(p_resolution_description) is null);
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

  -- Get record for Process Document insert XML.
  procedure GET_INS_PD_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_PD_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_PD_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin

    select
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PLAN_CODE') "ABOUT_PLAN_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PROVIDER_ID') "ABOUT_PROVIDER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_COMMENTS') "ACTION_COMMENTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_TYPE') "ACTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_FOLLOWUP') "ASED_PERFORM_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_INCIDENT_DOH') "ASED_RESOLVE_INCIDENT_DOH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_INCIDENT_EES_CSS') "ASED_RESOLVE_INCIDENT_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_INCIDENT_SUP') "ASED_RESOLVE_INCIDENT_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_WITHDRAW_INCIDENT') "ASED_WITHDRAW_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_FOLLOWUP') "ASF_PERFORM_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_INCIDENT_DOH') "ASF_RESOLVE_INCIDENT_DOH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_INCIDENT_EES_CSS') "ASF_RESOLVE_INCIDENT_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_INCIDENT_SUP') "ASF_RESOLVE_INCIDENT_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_WITHDRAW_INCIDENT') "ASF_WITHDRAW_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_FOLLOWUP') "ASSD_PERFORM_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_INCIDENT_DOH') "ASSD_RESOLVE_INCIDENT_DOH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_INCIDENT_EES_CSS') "ASSD_RESOLVE_INCIDENT_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_INCIDENT_SUP') "ASSD_RESOLVE_INCIDENT_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_WITHDRAW_INCIDENT') "ASSD_WITHDRAW_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_CIN') "CASE_CIN",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL') "CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_SUP') "CREATED_BY_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_EID') "CREATED_BY_EID",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_SUP_NAME') "CREATED_BY_SUP_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_GROUP') "CREATED_BY_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_NAME') "CREATED_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_STEP') "CURRENT_STEP",
      extractValue(p_data_xml,'/ROWSET/ROW/DE_TASK_ID') "DE_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED') "FORWARDED",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED_TO') "FORWARDED_TO",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARD_DT') "FORWARD_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_ESCALATE_TO_STATE') "GWF_ESCALATE_TO_STATE",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_FOLLOWUP_REQ') "GWF_FOLLOWUP_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESOLVED_EES_CSS') "GWF_RESOLVED_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESOLVED_SUP') "GWF_RESOLVED_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RETURN_TO_STATE') "GWF_RETURN_TO_STATE",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ABOUT') "INCIDENT_ABOUT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_DESCRIPTION') "INCIDENT_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ID') "INCIDENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_REASON') "INCIDENT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS') "INCIDENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS_DT') "INCIDENT_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_TYPE') "INCIDENT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_DT') "LAST_UPDATE_BY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CECI_ID') "CECI_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OTHER_PARTY_NAME') "OTHER_PARTY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PLAN_NAME') "PLAN_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PRIORITY') "PRIORITY",
      extractValue(p_data_xml,'/ROWSET/ROW/RECEIVED_DT') "RECEIVED_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTED_BY') "REPORTED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_NAME') "REPORTER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_PHONE') "REPORTER_PHONE",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_RELATIONSHIP') "REPORTER_RELATIONSHIP",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_DESCRIPTION') "RESOLUTION_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_TYPE') "RESOLUTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_SATISFIED') "SLA_SATISFIED",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_COMPLETE_DT') "SLA_COMPLETE_DT",
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
  end;


  -- Get record for Process Document update XML.
  procedure GET_UPD_PD_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_PD_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_PD_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin

    select
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PLAN_CODE') "ABOUT_PLAN_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PROVIDER_ID') "ABOUT_PROVIDER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_COMMENTS') "ACTION_COMMENTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_TYPE') "ACTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_FOLLOWUP') "ASED_PERFORM_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_INCIDENT_DOH') "ASED_RESOLVE_INCIDENT_DOH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_INCIDENT_EES_CSS') "ASED_RESOLVE_INCIDENT_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_INCIDENT_SUP') "ASED_RESOLVE_INCIDENT_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_WITHDRAW_INCIDENT') "ASED_WITHDRAW_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_FOLLOWUP') "ASF_PERFORM_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_INCIDENT_DOH') "ASF_RESOLVE_INCIDENT_DOH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_INCIDENT_EES_CSS') "ASF_RESOLVE_INCIDENT_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_INCIDENT_SUP') "ASF_RESOLVE_INCIDENT_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_WITHDRAW_INCIDENT') "ASF_WITHDRAW_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_FOLLOWUP') "ASSD_PERFORM_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_INCIDENT_DOH') "ASSD_RESOLVE_INCIDENT_DOH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_INCIDENT_EES_CSS') "ASSD_RESOLVE_INCIDENT_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_INCIDENT_SUP') "ASSD_RESOLVE_INCIDENT_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_WITHDRAW_INCIDENT') "ASSD_WITHDRAW_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_CIN') "CASE_CIN",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL') "CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_SUP') "CREATED_BY_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_EID') "CREATED_BY_EID",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_SUP_NAME') "CREATED_BY_SUP_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_GROUP') "CREATED_BY_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_NAME') "CREATED_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_STEP') "CURRENT_STEP",
      extractValue(p_data_xml,'/ROWSET/ROW/DE_TASK_ID') "DE_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED') "FORWARDED",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED_TO') "FORWARDED_TO",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARD_DT') "FORWARD_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_ESCALATE_TO_STATE') "GWF_ESCALATE_TO_STATE",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_FOLLOWUP_REQ') "GWF_FOLLOWUP_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESOLVED_EES_CSS') "GWF_RESOLVED_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESOLVED_SUP') "GWF_RESOLVED_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RETURN_TO_STATE') "GWF_RETURN_TO_STATE",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ABOUT') "INCIDENT_ABOUT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_DESCRIPTION') "INCIDENT_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ID') "INCIDENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_REASON') "INCIDENT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS') "INCIDENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS_DT') "INCIDENT_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_TYPE') "INCIDENT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_DT') "LAST_UPDATE_BY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/OTHER_PARTY_NAME') "OTHER_PARTY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PLAN_NAME') "PLAN_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PRIORITY') "PRIORITY",
      extractValue(p_data_xml,'/ROWSET/ROW/RECEIVED_DT') "RECEIVED_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTED_BY') "REPORTED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_NAME') "REPORTER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_PHONE') "REPORTER_PHONE",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_RELATIONSHIP') "REPORTER_RELATIONSHIP",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_DESCRIPTION') "RESOLUTION_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_TYPE') "RESOLUTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_SATISFIED') "SLA_SATISFIED",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_COMPLETE_DT') "SLA_COMPLETE_DT",
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
  end;


  -- Insert fact for BPM Semantic model - ProcessComplaint Incident.
    procedure INS_FPDBD
      (p_identifier in varchar2,
       p_start_date in date,
       p_end_date in date,
       p_bi_id in number,
       p_current_task_id in number,
       p_dcmplac_id in number,
     --  p_dcmples_id in number,
       p_dcmplia_id in number,
       p_dcmplid_id in number,
       p_dcmplir_id in number,
       p_dcmplis_id in number,
       p_dcmplin_id in number,
       p_dcmplrd_id in number,
       p_incident_status_date in varchar2,
       p_last_update_date varchar2,
       p_complete_dt in varchar2,
       p_dcmplss_id in number,
       p_fcmplbd_id out number  )

     as
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FPDBD';
      v_sql_code number := null;
      v_log_message clob := null;
      v_bucket_start_date date := null;
      v_bucket_end_date date := null;
      v_stg_last_update_date date := null;
    --  v_receipt_date date := null;
      v_invoiceable_date date := null;
    --  v_document_status_dt date := null;
      v_jeopardy_status_dt date := null;
    begin
      v_stg_last_update_date := to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
     -- v_document_status_dt := to_date(p_document_status_dt,BPM_COMMON.DATE_FMT);
      v_jeopardy_status_dt := sysdate;
      p_fcmplbd_id := SEQ_FCMPLBD_ID.nextval;
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

      insert into F_COMPLAINT_BY_DATE
        (FCMPLBD_ID ,
          D_DATE ,
          BUCKET_START_DATE ,
          BUCKET_END_DATE ,
          CMPL_BI_ID ,
          DCMPLAC_ID ,
          CURRENT_TASK_ID ,
      --    DCMPLES_ID ,
          DCMPLIA_ID ,
          DCMPLID_ID ,
          DCMPLIR_ID ,
          DCMPLIS_ID ,
          DCMPLIN_ID ,
          DCMPLRD_ID ,
          INCIDENT_STATUS_DATE,
          LAST_UPDATE_DATE ,
          CREATION_COUNT ,
          INVENTORY_COUNT ,
          COMPLETION_COUNT ,
          COMPLETE_DT,
          DCMPLSS_ID
          )
      values
        (p_fcmplbd_id,
         p_start_date,
         v_bucket_start_date,
         v_bucket_end_date,
         p_bi_id,
         p_dcmplac_id,
         p_current_task_id ,
      --   p_dcmples_id ,
         p_dcmplia_id ,
         p_dcmplid_id ,
         p_dcmplir_id ,
         p_dcmplis_id ,
         p_dcmplin_id ,
         p_dcmplrd_id ,
         to_date(p_incident_status_date,BPM_COMMON.DATE_FMT),
         to_date(p_last_update_date,BPM_COMMON.DATE_FMT),
         1,
         case
         when p_end_date is null then 1
         else 0
         end,
         case
           when p_end_date is null then 0
           else 1
           end     ,
         to_date(  p_complete_dt,BPM_COMMON.DATE_FMT),
         p_dcmplss_id
        );
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
  end;


  -- Insert or update dimension for BPM Semantic model - Process Complaint Incident - Current.
  procedure SET_DPCCUR
    (p_set_type                         in  varchar2,
    p_identifier                        in  varchar2,
    p_bi_id                             in  number,
    p_channel                           in  varchar2,
    p_created_by_group                  in  varchar2,
    p_created_by_name                   in  varchar2,
    p_incident_id                       in  number,
    p_tracking_number                   in  varchar2,
    p_create_date                       in  varchar2  ,
    p_res_incident_end                  in  varchar2 ,
    p_res_incident_start                in  varchar2 ,
    p_res_incident_supv_end             in  varchar2 ,
    p_res_incident_supv_st              in  varchar2 ,
    p_resolve_incident_end              in  varchar2 ,
    p_resolve_incident_start            in  varchar2 ,
    p_withdraw_incident_end             in  varchar2 ,
    p_withdraw_incident_start           in  varchar2 ,
    p_followup_actions_end              in  varchar2 ,
    p_followup_actions_start            in  varchar2 ,
    p_about_plan_code                   in  varchar2,
    p_about_provider_id                 in  number,
    p_cur_action_comments               in  varchar2,
    p_action_type                       in  varchar2,
    p_cancel_by                         in  varchar2,
    p_cancel_date                       in  varchar2,
    p_cancel_method                     in  varchar2,
    p_cancel_reason                     in  varchar2,
    p_cur_current_task_id               in  number,
    p_data_entry_task_id                in  number,
    p_cur_incident_about                in  varchar2,
    p_cur_incident_description          in  varchar2,
    p_cur_incident_reason               in  varchar2,
    p_cur_incident_status               in  varchar2,
    p_cur_incident_status_date          in  varchar2,
    p_instance_complete_date            in  varchar2,
    p_cur_instance_status               in  varchar2,
    p_cur_last_update_by_name           in  varchar2,
    p_cur_last_update_date              in  varchar2 ,
    p_last_updated_by                   in  varchar2,
    p_client_id                         in  number,
    p_other_party_name                  in  varchar2,
    p_priority                          in  varchar2,
    p_reported_by                       in  varchar2,
    p_reporter_relationship             in  varchar2,
    p_cur_resolution_description        in  varchar2,
    p_resolution_type                   in  varchar2,
    p_case_id                           in  number,
    p_case_cin                          in  varchar2,
    p_forwarded_flag                    in  varchar2,
    p_incident_type                     in  varchar2,
    p_forwarded_to                      in  varchar2,
    p_sla_days_type                     in  varchar2,
    p_sla_jeopardy_date                 in  date,
    p_sla_jeopardy_days                 in  number,
    p_sla_target_days                   in  number,
    p_age_in_business_days              in  number,
    p_age_in_calendar_days              in  number,
    p_jeopardy_days_type                in  varchar2,
    p_jeopardy_flag                     in  varchar2,
    p_timeliness_status                 in  varchar2,
    p_fwd_timeliness_status             in  varchar2,
    p_incident_forwarding_target        in  varchar2,
    p_complete_dt                       in varchar2,
    p_forward_dt                        in varchar2,
    p_current_step                      in varchar2,
    p_received_dt                       in varchar2,
    p_plan_name                         in varchar2,
    p_reporter_name                     in varchar2,
    p_reporter_phone                    in varchar2,
    p_sla_satisfied                     in varchar2,
    p_sla_complete_dt                   in varchar2,
    p_created_by_sup                    in varchar2,
    p_created_by_eid                    in varchar2,
    p_created_by_sup_name               in varchar2,
    p_gwf_escalate_to_state             in varchar2,
    p_gwf_resolved_ees_css              in varchar2,
    p_gwf_resolved_sup                  in varchar2,
    p_gwf_followup_req                  in varchar2,
    p_gwf_return_to_state               in varchar2,
    p_pref_language                     in varchar2
     )
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DPCCUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dpccur D_COMPLAINT_CURRENT%rowtype := null;
    v_jeopardy_flag varchar2(1) := null;
  begin


  r_dpccur.CMPL_BI_ID := p_bi_id;
  r_dpccur.	CHANNEL                         :=   p_channel                              	;
	r_dpccur.CREATED_BY_GROUP                     	:=   p_created_by_group                     	;
	r_dpccur.CREATED_BY_NAME                      	:=   p_created_by_name                      	;
	r_dpccur.INCIDENT_ID                          	:=   p_incident_id                          	;
	r_dpccur.INCIDENT_TRACKING_NUMBER               :=   p_tracking_number             	;
	r_dpccur.CREATE_DATE                            :=   to_date( p_create_date    ,    BPM_COMMON.DATE_FMT)             	;
	r_dpccur.ATMPT_TO_RES_INCIDENT_END              :=   to_date(p_res_incident_end     ,  BPM_COMMON.DATE_FMT)            ;
	r_dpccur.ATMPT_TO_RES_INCIDENT_START           	:=   to_date(p_res_incident_start    ,  BPM_COMMON.DATE_FMT)         	;
	r_dpccur.ATMPT_TO_RES_INCIDENT_SUPV_END        	:=   to_date(p_res_incident_supv_end ,   BPM_COMMON.DATE_FMT)        	;
	r_dpccur.ATMPT_TO_RES_INCIDENT_SUPV_ST         	:=   to_date( p_res_incident_supv_st  ,   BPM_COMMON.DATE_FMT)        	;
	r_dpccur.RESOLVE_INCIDENT_END                  	:=   to_date( p_resolve_incident_end  ,   BPM_COMMON.DATE_FMT)         ;
	r_dpccur.RESOLVE_INCIDENT_START               	:=   to_date(p_resolve_incident_start ,      BPM_COMMON.DATE_FMT)      ;
	r_dpccur.WITHDRAW_INCIDENT_END                 	:=   to_date(  p_withdraw_incident_end  ,    BPM_COMMON.DATE_FMT)      ;
	r_dpccur.WITHDRAW_INCIDENT_START               	:=   to_date(  p_withdraw_incident_start  ,    BPM_COMMON.DATE_FMT)    ;
	r_dpccur.PERFORM_FOLLOWUP_ACTIONS_END          	:=   to_date(p_followup_actions_end    ,  BPM_COMMON.DATE_FMT)    	;
	r_dpccur.PERFORM_FOLLOWUP_ACTIONS_START        	:=   to_date(p_followup_actions_start  ,    BPM_COMMON.DATE_FMT)  	;
	r_dpccur.ABOUT_PLAN_CODE                      	:=   p_about_plan_code                      	;
	r_dpccur.ABOUT_PROVIDER_ID                    	:=   p_about_provider_id                    	;
	r_dpccur.CUR_ACTION_COMMENTS                  	:=   p_cur_action_comments                 	;
	r_dpccur.ACTION_TYPE                           	:=   p_action_type                           	;
	r_dpccur.CANCEL_BY                            	:=   p_cancel_by                            	;
	r_dpccur.CANCEL_DATE                          	:=   to_date(   p_cancel_date      ,   BPM_COMMON.DATE_FMT)  ;
	r_dpccur.CANCEL_METHOD                        	:=   p_cancel_method                        	;
	r_dpccur.CANCEL_REASON                        	:=   p_cancel_reason                        	;
	r_dpccur.CUR_CURRENT_TASK_ID                  	:=   p_cur_current_task_id                  	;
  r_dpccur.CURRENT_STEP                         	:=   p_current_step                  	;
	r_dpccur.DATA_ENTRY_TASK_ID                   	:=   p_data_entry_task_id                   	;
	r_dpccur.CUR_INCIDENT_ABOUT                   	:=   p_cur_incident_about                   	;
	r_dpccur.CUR_INCIDENT_DESCRIPTION             	:=   p_cur_incident_description            	;
	r_dpccur.CUR_INCIDENT_REASON                  	:=   p_cur_incident_reason                  	;
	r_dpccur.CUR_INCIDENT_STATUS                  	:=   p_cur_incident_status                  	;
	r_dpccur.CUR_INCIDENT_STATUS_DATE             	:=   to_date(  p_cur_incident_status_date   ,     BPM_COMMON.DATE_FMT)          	;
	r_dpccur.INSTANCE_COMPLETE_DATE               	:=   to_date(   p_instance_complete_date     ,   BPM_COMMON.DATE_FMT)            	;
	r_dpccur.CUR_INSTANCE_STATUS                  	:=   p_cur_instance_status                  	;
	r_dpccur.CUR_LAST_UPDATE_BY_NAME              	:=   p_cur_last_update_by_name              	;
	r_dpccur.CUR_LAST_UPDATE_DATE                  	:=   to_date(    p_cur_last_update_date  ,   BPM_COMMON.DATE_FMT)                 	;
	r_dpccur.LAST_UPDATED_BY                      	:=   p_last_updated_by                      	;
	r_dpccur.CLIENT_ID                            	:=   p_client_id                            	;
	r_dpccur.OTHER_PARTY_NAME                     	:=   p_other_party_name                     	;
	r_dpccur.PRIORITY                             	:=   p_priority                             	;
	r_dpccur.REPORTED_BY                          	:=   p_reported_by                          	;
	r_dpccur.REPORTER_RELATIONSHIP                	:=   p_reporter_relationship                	;
	r_dpccur.CUR_RESOLUTION_DESCRIPTION           	:=   p_cur_resolution_description           	;
	r_dpccur.RESOLUTION_TYPE                      	:=   p_resolution_type                      	;
	r_dpccur.CASE_ID                              	:=   p_case_id                              	;
  r_dpccur.CASE_CIN                              	:=   p_case_cin                              	;
	r_dpccur.FORWARDED_FLAG                       	:=   p_forwarded_flag                       	;
	r_dpccur.INCIDENT_TYPE                        	:=   p_incident_type                        	;
	r_dpccur.FORWARDED_To                         	:=   p_forwarded_to                         	;
	r_dpccur.SLA_DAYS_TYPE                        	:=   p_sla_days_type                        	;
	r_dpccur.SLA_JEOPARDY_DATE                      :=   p_sla_jeopardy_date 	;
	r_dpccur.SLA_JEOPARDY_DAYS                    	:=   p_sla_jeopardy_days                    	;
	r_dpccur.SLA_Target_DAYS                      	:=   p_sla_target_days                      	;
	r_dpccur.Age_IN_BUSINESS_DAYS                   :=   GET_AGE_IN_BUSINESS_DAYS(to_date(p_create_date, BPM_COMMON.DATE_FMT), to_date( p_complete_dt, BPM_COMMON.DATE_FMT))	;
	r_dpccur.Age_IN_CALENDAR_DAYS                 	:=   GET_AGE_IN_CALENDAR_DAYS(to_date(p_create_date, BPM_COMMON.DATE_FMT) ,to_date(  p_complete_dt, BPM_COMMON.DATE_FMT))	;
	r_dpccur.JEOPARDY_DAYS_TYPE                   	:=   p_jeopardy_days_type                   	;
	r_dpccur.JEOPARDY_FLAG                        	:=   GET_JEOPARDY_STATUS(to_date(p_create_date, BPM_COMMON.DATE_FMT),to_date(  p_forward_dt, BPM_COMMON.DATE_FMT), to_date(  p_complete_dt, BPM_COMMON.DATE_FMT), p_incident_type)	;
	r_dpccur.TIMELINESS_STATUS                    	:=   GET_TIMELINESS_STATUS(to_date(p_create_date ,BPM_COMMON.DATE_FMT), to_date(  p_complete_dt, BPM_COMMON.DATE_FMT),p_forwarded_flag,to_date(p_forward_dt ,      BPM_COMMON.DATE_FMT), p_incident_type)	;
	r_dpccur.INCIDENT_FWD_TIMELINESS_STATUS         :=   p_fwd_timeliness_status       	;
	r_dpccur.INCIDENT_FORWARDING_TARGET           	:=   p_incident_forwarding_target          	;
  r_dpccur.COMPLETE_DT                            :=  to_date(p_complete_dt, BPM_COMMON.DATE_FMT) ;
  r_dpccur.FORWARD_DT                             :=  to_date(p_forward_dt, BPM_COMMON.DATE_FMT) ;
  r_dpccur.RECEIVED_DT                            :=  to_date(p_received_dt, BPM_COMMON.DATE_FMT) ;
  r_dpccur.PLAN_NAME                              :=  p_plan_name;
  r_dpccur.REPORTER_NAME                          :=  p_reporter_name;
  r_dpccur.REPORTER_PHONE                         :=  p_reporter_phone;
  r_dpccur.SLA_SATISFIED                          :=  p_sla_satisfied;
  r_dpccur.SLA_COMPLETE_DATE                      :=  to_date(p_sla_complete_dt,BPM_COMMON.DATE_FMT) ;
  r_dpccur.CREATED_BY_SUP                         :=  p_created_by_sup;
  r_dpccur.CREATED_BY_EID                         := p_created_by_eid;
  r_dpccur.CREATED_BY_SUP_NAME                    := p_created_by_sup_name;
  r_dpccur.GWF_ESCALATE_TO_STATE                  := p_gwf_escalate_to_state;
  r_dpccur.GWF_RESOLVED_EES_CSS                    := p_gwf_resolved_ees_css;
  r_dpccur.GWF_RESOLVED_SUP                       := p_gwf_resolved_sup;
  r_dpccur.GWF_FOLLOWUP_REQ                       := p_gwf_followup_req;
  r_dpccur.GWF_RETURN_TO_STATE                    := p_gwf_return_to_state;
  r_dpccur.PREF_LANGUAGE                          := p_pref_language;


    if p_set_type = 'INSERT' then
      insert into D_COMPLAINT_CURRENT
      values r_dpccur;
    elsif p_set_type = 'UPDATE' then
      begin
        update D_COMPLAINT_CURRENT
        set row = r_dpccur
        where CMPL_BI_ID = p_bi_id;
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
  end;


  -- Insert BPM Semantic model data.
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_sql_code number := null;
    v_log_message clob := null;
    v_new_data T_INS_PD_XML := null;
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
    v_start_date date := null;
    v_end_date date := null;
    v_dcmplin_id number := null;
    v_dcmplis_id number := null;
    v_dcmples_id number := null;
    v_dcmplac_id number := null;
    v_dcmplia_id number := null;
    v_dcmplid_id number := null;
    v_dcmplir_id number := null;
    v_dcmplrd_id number := null;
    v_dcmplss_id number:= null;
    v_fcmplbd_id number := null;
    v_current_task_id number := null;
     v_sla_days_type         varchar2(50) := null;
     v_sla_jeopardy_date     date := null;
     v_sla_jeopardy_days     number := null;
     v_sla_target_days       number := null;
     v_age_in_business_days    number := null;
     v_age_in_calendar_days    number := null;
     v_jeopardy_days_type varchar2(50) := null;
    v_jeopardy_flag       varchar2(50) := null;
     v_timeliness_status   varchar2(50) := null;
     v_fwd_timeliness_status  varchar2(50) := null  ;
     v_forwarding_target number := null;
  begin

    if p_data_version > 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYHIX Process Complaints Incidents in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;

    GET_INS_PD_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.incident_id;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
    v_bi_id := SEQ_BI_ID.nextval;

   GET_DCMPLIN_ID (v_identifier,v_bi_id,v_new_data.instance_status, v_dcmplin_id);
   GET_DCMPLIS_ID (v_identifier,v_bi_id,v_new_data.incident_status, v_dcmplis_id);
  -- GET_DCMPLES_ID (v_identifier,v_bi_id,v_new_data.enrollment_status, v_dcmples_id);
   GET_DCMPLAC_ID (v_identifier,v_bi_id,v_new_data.action_comments, v_dcmplac_id);
   GET_DCMPLIA_ID (v_identifier,v_bi_id,v_new_data.incident_about,  v_dcmplia_id);
   GET_DCMPLID_ID (v_identifier,v_bi_id,v_new_data.incident_description,  v_dcmplid_id);
   GET_DCMPLIR_ID (v_identifier,v_bi_id,v_new_data.incident_reason,  v_dcmplir_id);
   GET_DCMPLRD_ID (v_identifier,v_bi_id,v_new_data.resolution_description,  v_dcmplrd_id);
   GET_DCMPLSS_ID (v_identifier,v_bi_id,v_new_data.sla_satisfied,  v_dcmplss_id);

      v_sla_days_type          := 'B';
      v_sla_jeopardy_date      := GET_SLA_JEOPARDY_DATE(to_date( v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),v_new_data.INCIDENT_TYPE);
      v_sla_jeopardy_days      := 7;
      v_sla_target_days        := 10;
      v_age_in_business_days   := GET_AGE_IN_BUSINESS_DAYS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.COMPLETE_DT,BPM_COMMON.DATE_FMT));
      v_age_in_calendar_days   := GET_AGE_IN_CALENDAR_DAYS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.COMPLETE_DT,BPM_COMMON.DATE_FMT));
      v_jeopardy_days_type     := 'B';
      v_jeopardy_flag          := GET_JEOPARDY_STATUS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.FORWARD_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.COMPLETE_DT,BPM_COMMON.DATE_FMT),v_new_data.INCIDENT_TYPE) ;
      v_timeliness_status      := GET_TIMELINESS_STATUS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.COMPLETE_DT,BPM_COMMON.DATE_FMT),v_new_data.FORWARDED,to_date(v_new_data.FORWARD_DT,BPM_COMMON.DATE_FMT),v_new_data.INCIDENT_TYPE);
      v_fwd_timeliness_status  := GET_FWDING_TIMELINESS_STATUS(v_new_data.FORWARDED,v_new_data.FORWARDED_TO,to_date( v_new_data.COMPLETE_DT, BPM_COMMON.DATE_FMT),to_date(v_new_data.ASSD_RESOLVE_INCIDENT_DOH,BPM_COMMON.DATE_FMT),to_date(v_new_data.ASED_RESOLVE_INCIDENT_DOH,BPM_COMMON.DATE_FMT), v_new_data.INCIDENT_TYPE);
      v_forwarding_target      := GET_FWDING_TARGET(v_new_data.FORWARDED_TO,v_new_data.INCIDENT_TYPE);

    -- Insert current dimension and fact as a single transaction.
    begin
      commit;
      SET_DPCCUR
        ('INSERT',v_identifier,v_bi_id
          ,v_new_data.channel                 ,
     v_new_data.created_by_group         ,
     v_new_data.created_by_name           ,
     v_new_data.incident_id                ,
     v_new_data.tracking_number    ,
     v_new_data.create_dt                  ,
     v_new_data.ASED_RESOLVE_INCIDENT_EES_CSS     ,
     v_new_data.ASSD_RESOLVE_INCIDENT_EES_CSS    ,
     v_new_data.ASED_RESOLVE_INCIDENT_SUP  ,
     v_new_data.ASSD_RESOLVE_INCIDENT_SUP    ,
     v_new_data.ASED_RESOLVE_INCIDENT_DOH             ,
     v_new_data.ASSD_RESOLVE_INCIDENT_DOH            ,
     v_new_data.ASED_WITHDRAW_INCIDENT               ,
     v_new_data.ASSD_WITHDRAW_INCIDENT              ,
     v_new_data.ASED_PERFORM_FOLLOWUP     ,
     v_new_data.ASSD_PERFORM_FOLLOWUP   ,
     v_new_data.about_plan_code                   ,
     v_new_data.about_provider_id                  ,
     v_new_data.action_comments                 ,
     v_new_data.action_type                          ,
     v_new_data.cancel_by                            ,
     v_new_data.cancel_dt                          ,
     v_new_data.cancel_method                        ,
     v_new_data.cancel_reason                        ,
     v_new_data.current_task_id                  ,
     v_new_data.de_task_id                   ,
     v_new_data.incident_about                   ,
     v_new_data.incident_description             ,
     v_new_data.incident_reason                  ,
     v_new_data.incident_status                  ,
     v_new_data.incident_status_dt             ,
     v_new_data.instance_complete_dt              ,
     v_new_data.instance_status                  ,
     v_new_data.last_update_by_name              ,
     v_new_data.last_update_by_dt                 ,
     v_new_data.updated_by                      ,
     v_new_data.client_id                            ,
     v_new_data.other_party_name                     ,
     v_new_data.priority                             ,
     v_new_data.reported_by                          ,
     v_new_data.reporter_relationship                ,
     v_new_data.resolution_description           ,
     v_new_data.resolution_type                  ,
     v_new_data.case_id                         ,
     v_new_data.case_cin                         ,
     v_new_data.forwarded                       ,
     v_new_data.incident_type                    ,
     v_new_data.forwarded_to                    ,
     v_sla_days_type                        ,
     v_sla_jeopardy_date                    ,
     v_sla_jeopardy_days                    ,
     v_sla_target_days                      ,
     v_age_in_business_days                 ,
     v_age_in_calendar_days                 ,
     v_jeopardy_days_type                   ,
     v_jeopardy_flag                        ,
     v_timeliness_status                    ,
     v_fwd_timeliness_status       ,
     v_forwarding_target  ,
     v_new_data.complete_dt,
     v_new_data.forward_dt,
     v_new_data.current_step,
     v_new_data.received_dt,
     v_new_data.plan_name,
     v_new_data.reporter_name,
     v_new_data.reporter_phone,
     v_new_data.sla_satisfied,
     v_new_data.sla_complete_dt,
     v_new_data.created_by_sup,
     v_new_data.created_by_eid,
     v_new_data.created_by_sup_name,
     v_new_data.gwf_escalate_to_state,
     v_new_data.gwf_resolved_ees_css,
     v_new_data.gwf_resolved_sup,
     v_new_data.gwf_followup_req,
     v_new_data.gwf_return_to_state,
     v_new_data.pref_language
        );
      INS_FPDBD
        (v_identifier,v_start_date,v_end_date,v_bi_id,
          v_current_task_id,
          v_dcmplac_id,
      --    v_dcmples_id,
          v_dcmplia_id,
          v_dcmplid_id,
          v_dcmplir_id,
          v_dcmplis_id,
          v_dcmplin_id,
          v_dcmplrd_id,
          v_new_data.incident_status_dt ,
          v_new_data.last_update_by_dt ,
          v_new_data.complete_dt,
          v_dcmplss_id,
          v_fcmplbd_id);
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


  -- Update fact for BPM Semantic model -ILEB Process Complaints Incidents.
  procedure UPD_FPDBD
    (  p_identifier in varchar2,
       p_end_date in date,
       p_bi_id in number,
       p_current_task_id in number,
       p_dcmplac_id in number,
    --   p_dcmples_id in number,
       p_dcmplia_id in number,
       p_dcmplid_id in number,
       p_dcmplir_id in number,
       p_dcmplis_id in number,
       p_dcmplin_id in number,
       p_dcmplrd_id in number,
       p_incident_status_date in varchar2,
       p_stg_last_update_date in varchar2,
       p_complete_dt in varchar2,
       p_dcmplss_id in number,
       p_sla_complete_date in varchar2,
       p_fcmplbd_id out number
 )
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FPDBD';
    v_sql_code number := null;
    v_log_message clob := null;
    v_fcmplbd_id_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;

    v_event_date date := null;
    v_dcmplin_id number := null;
    v_dcmplis_id number := null;
    v_dcmples_id number := null;
    v_dcmplac_id number := null;
    v_dcmplia_id number := null;
    v_dcmplid_id number := null;
    v_dcmplir_id number := null;
    v_dcmplrd_id number := null;
    v_dcmplss_id number := null;
    v_incident_status_date date:= null;
    v_last_update_date date:= null;
    r_fnpdbd F_COMPLAINT_BY_DATE%rowtype := null;
    v_complete_dt date := null;

    -- added for NYHIX-12036 add sla_complete_date attribute to fact table
    v_sla_complete_date date := null;
  begin
    v_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
    v_event_date := v_last_update_date;
    v_incident_status_date := to_date(p_incident_status_date,BPM_COMMON.DATE_FMT);
    --v_document_jeop_status_dt := sysdate;
    v_dcmplin_id := p_dcmplin_id;
    v_dcmplis_id  := p_dcmplis_id;
   -- v_dcmples_id := p_dcmples_id;
    v_dcmplac_id := p_dcmplac_id;
    v_dcmplia_id := p_dcmplia_id;
    v_dcmplid_id := p_dcmplid_id;
    v_dcmplir_id := p_dcmplir_id;
    v_dcmplrd_id := p_dcmplrd_id;
    v_dcmplss_id := p_dcmplss_id;
    v_complete_dt  := to_date( p_complete_dt,BPM_COMMON.DATE_FMT);
    v_sla_complete_date := to_date( p_sla_complete_date,BPM_COMMON.DATE_FMT);

    with most_recent_fact_bi_id as
      (select
         max(FCMPLBD_ID) max_fcmplbd_id,
         max(D_DATE) max_d_date
       from F_COMPLAINT_BY_DATE
       where CMPL_BI_ID = p_bi_id)
    select
      fnpdbd.FCMPLBD_ID,
      fnpdbd.D_DATE,
      fnpdbd.CREATION_COUNT,
      fnpdbd.COMPLETION_COUNT,
      most_recent_fact_bi_id.max_d_date
    into
      v_fcmplbd_id_old,
      v_d_date_old,
      v_creation_count_old,
      v_completion_count_old,
      v_max_d_date
    from
      F_COMPLAINT_BY_DATE fnpdbd,
      most_recent_fact_bi_id
    where
      fnpdbd.FCMPLBD_ID = max_fcmplbd_id
      and fnpdbd.D_DATE = most_recent_fact_bi_id.max_d_date;

    -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
    -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE.
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;
    if p_end_date is null then
      r_fnpdbd.D_DATE := v_event_date;
      r_fnpdbd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpdbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpdbd.INVENTORY_COUNT := 1;
      r_fnpdbd.COMPLETION_COUNT := 0;
    else
      -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
      if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then
        delete from F_COMPLAINT_BY_DATE
        where
          CMPL_BI_ID = p_bi_id
          and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
    with most_recent_fact_bi_id as
      (select
         max(FCMPLBD_ID) max_fcmplbd_id,
         max(D_DATE) max_d_date
         from F_COMPLAINT_BY_DATE
         where CMPL_BI_ID = p_bi_id)
        select
          fnpdbd.FCMPLBD_ID,
          fnpdbd.D_DATE,
          fnpdbd.CREATION_COUNT,
          fnpdbd.COMPLETION_COUNT,
          most_recent_fact_bi_id.max_d_date,
          fnpdbd.dcmplac_id,
        -- fnpdbd.dcmples_id,
          fnpdbd.dcmplia_id,
          fnpdbd.dcmplid_id,
          fnpdbd.dcmplir_id,
          fnpdbd.dcmplis_id,
          fnpdbd.dcmplin_id,
          fnpdbd.dcmplrd_id,
          fnpdbd.dcmplss_id,
          fnpdbd.sla_complete_date
          into
          v_fcmplbd_id_old,
          v_d_date_old,
          v_creation_count_old,
          v_completion_count_old,
          v_max_d_date,
          v_dcmplac_id,
       --   v_dcmples_id,
          v_dcmplia_id,
          v_dcmplid_id,
          v_dcmplir_id,
          v_dcmplis_id,
          v_dcmplin_id,
          v_dcmplrd_id,
          v_dcmplss_id,
          v_sla_complete_date
         from
          F_COMPLAINT_BY_DATE fnpdbd,
          most_recent_fact_bi_id
        where
          fnpdbd.FCMPLBD_ID = max_fcmplbd_id
          and fnpdbd.D_DATE = most_recent_fact_bi_id.max_d_date;
      end if;
      r_fnpdbd.D_DATE := p_end_date;
      r_fnpdbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpdbd.BUCKET_END_DATE := r_fnpdbd.BUCKET_START_DATE;
      r_fnpdbd.INVENTORY_COUNT := 0;
      r_fnpdbd.COMPLETION_COUNT := 1;
    end if;


    p_fcmplbd_id := SEQ_FCMPLBD_ID.nextval;
    r_fnpdbd.FCMPLBD_ID := p_fcmplbd_id;
    r_fnpdbd.CMPL_BI_ID := p_bi_id;
    r_fnpdbd.DCMPLAC_ID := v_dcmplac_id;
   -- r_fnpdbd.DCMPLES_ID := v_dcmples_id;
    r_fnpdbd.DCMPLIA_ID := v_dcmplia_id;
    r_fnpdbd.DCMPLID_ID := v_dcmplid_id;
    r_fnpdbd.CREATION_COUNT := 0;
    r_fnpdbd.DCMPLIR_ID := v_dcmplir_id;
    r_fnpdbd.DCMPLIS_ID := v_dcmplis_id;
    r_fnpdbd.DCMPLIN_ID := v_dcmplin_id;
    r_fnpdbd.DCMPLRD_ID  := v_dcmplrd_id;
    r_fnpdbd.DCMPLSS_ID  := v_dcmplss_id;
    r_fnpdbd.INCIDENT_STATUS_DATE := v_incident_status_date;
    r_fnpdbd.LAST_UPDATE_DATE := v_last_update_date;
    r_fnpdbd.COMPLETE_DT := v_complete_dt;
    r_fnpdbd.sla_complete_date := v_sla_complete_date; --NYHIX-12036

      -- Validate fact date ranges.
    if r_fnpdbd.D_DATE < r_fnpdbd.BUCKET_START_DATE
      or to_date(to_char(r_fnpdbd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fnpdbd.BUCKET_END_DATE
      or r_fnpdbd.BUCKET_START_DATE > r_fnpdbd.BUCKET_END_DATE
      or r_fnpdbd.BUCKET_END_DATE < r_fnpdbd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' ||
        'D_DATE = ' || r_fnpdbd.D_DATE ||
        ' BUCKET_START_DATE = ' || to_char(r_fnpdbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_fnpdbd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;

    if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fnpdbd.BUCKET_START_DATE then
      -- Same bucket time.
        if v_creation_count_old = 1 then
          r_fnpdbd.CREATION_COUNT := v_creation_count_old;
        end if;

        update F_COMPLAINT_BY_DATE
        set row = r_fnpdbd
        where FCMPLBD_ID = v_fcmplbd_id_old;
    else
      -- Different bucket time.

      update F_COMPLAINT_BY_DATE
      set BUCKET_END_DATE = r_fnpdbd.BUCKET_START_DATE
      where FCMPLBD_ID = v_fcmplbd_id_old;
      insert into F_COMPLAINT_BY_DATE
      values r_fnpdbd;
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
    v_old_data T_UPD_PD_XML := null;
    v_new_data T_UPD_PD_XML := null;
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
    v_start_date date := null;
    v_end_date date := null;
   v_dcmplin_id number := null;
    v_dcmplis_id number := null;
    v_dcmples_id number := null;
    v_dcmplac_id number := null;
    v_dcmplia_id number := null;
    v_dcmplid_id number := null;
    v_dcmplir_id number := null;
    v_dcmplrd_id number := null;
    v_dcmplss_id number := null;
    v_incident_status_date date:= null;
    v_last_update_date date:= null;
    v_fcmplbd_id number := null;

         v_sla_days_type         varchar2(50) := null;
     v_sla_jeopardy_date     date := null;
     v_sla_jeopardy_days     number := null;
     v_sla_target_days       number := null;
     v_age_in_business_days    number := null;
     v_age_in_calendar_days    number := null;
     v_jeopardy_days_type varchar2(50) := null;
    v_jeopardy_flag       varchar2(50) := null;
     v_timeliness_status   varchar2(50) := null;
     v_fwd_timeliness_status  varchar2(50) := null  ;
     v_forwarding_target number := null;
  begin

    if p_data_version > 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYHIX Process Complaints Incidents in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;

    GET_UPD_PD_XML(p_old_data_xml,v_old_data);
    GET_UPD_PD_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.incident_id;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

    select CMPL_BI_ID
    into v_bi_id
    from D_COMPLAINT_CURRENT
    where INCIDENT_ID = v_identifier;

   GET_DCMPLIN_ID (v_identifier,v_bi_id,v_new_data.instance_status, v_dcmplin_id);
   GET_DCMPLIS_ID (v_identifier,v_bi_id,v_new_data.incident_status, v_dcmplis_id);
  -- GET_DCMPLES_ID (v_identifier,v_bi_id,v_new_data.enrollment_status, v_dcmples_id);
   GET_DCMPLAC_ID (v_identifier,v_bi_id,v_new_data.action_comments, v_dcmplac_id);
   GET_DCMPLIA_ID (v_identifier,v_bi_id,v_new_data.incident_about,  v_dcmplia_id);
   GET_DCMPLID_ID (v_identifier,v_bi_id,v_new_data.incident_description,  v_dcmplid_id);
   GET_DCMPLIR_ID (v_identifier,v_bi_id,v_new_data.incident_reason,  v_dcmplir_id);
   GET_DCMPLRD_ID (v_identifier,v_bi_id,v_new_data.resolution_description,  v_dcmplrd_id);
   GET_DCMPLSS_ID (v_identifier,v_bi_id,v_new_data.sla_satisfied,  v_dcmplss_id);

      v_sla_days_type          := 'B';
      v_sla_jeopardy_date      := GET_SLA_JEOPARDY_DATE(to_date( v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),v_new_data.INCIDENT_TYPE);
      v_sla_jeopardy_days      := 7;
      v_sla_target_days        := 10;
      v_age_in_business_days   := GET_AGE_IN_BUSINESS_DAYS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.COMPLETE_DT,BPM_COMMON.DATE_FMT));
      v_age_in_calendar_days   := GET_AGE_IN_CALENDAR_DAYS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.COMPLETE_DT,BPM_COMMON.DATE_FMT));
      v_jeopardy_days_type     := 'B';
      v_jeopardy_flag          := GET_JEOPARDY_STATUS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.FORWARD_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.COMPLETE_DT,BPM_COMMON.DATE_FMT),v_new_data.INCIDENT_TYPE) ;
      v_timeliness_status      := GET_TIMELINESS_STATUS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.COMPLETE_DT,BPM_COMMON.DATE_FMT),v_new_data.FORWARDED,to_date(v_new_data.FORWARD_DT,BPM_COMMON.DATE_FMT),v_new_data.INCIDENT_TYPE);
      v_fwd_timeliness_status  := GET_FWDING_TIMELINESS_STATUS(v_new_data.FORWARDED,v_new_data.FORWARDED_TO,to_date( v_new_data.COMPLETE_DT, BPM_COMMON.DATE_FMT),to_date(v_new_data.ASSD_RESOLVE_INCIDENT_DOH,BPM_COMMON.DATE_FMT),to_date(v_new_data.ASED_RESOLVE_INCIDENT_DOH,BPM_COMMON.DATE_FMT), v_new_data.INCIDENT_TYPE);
      v_forwarding_target      := GET_FWDING_TARGET(v_new_data.FORWARDED_TO,v_new_data.INCIDENT_TYPE);

    -- Update current dimension and fact as a single transaction.
    begin
      commit;
      SET_DPCCUR
        ('UPDATE',v_identifier,v_bi_id
         ,v_new_data.channel                 ,
     v_new_data.created_by_group         ,
     v_new_data.created_by_name           ,
     v_new_data.incident_id                ,
     v_new_data.tracking_number    ,
     v_new_data.create_dt                  ,
     v_new_data.ASED_RESOLVE_INCIDENT_EES_CSS    ,
     v_new_data.ASSD_RESOLVE_INCIDENT_EES_CSS   ,
     v_new_data.ASED_RESOLVE_INCIDENT_SUP  ,
     v_new_data.ASSD_RESOLVE_INCIDENT_SUP    ,
     v_new_data.ASED_RESOLVE_INCIDENT_DOH             ,
     v_new_data.ASSD_RESOLVE_INCIDENT_DOH            ,
     v_new_data.ASED_WITHDRAW_INCIDENT               ,
     v_new_data.ASSD_WITHDRAW_INCIDENT              ,
     v_new_data.ASED_PERFORM_FOLLOWUP     ,
     v_new_data.ASSD_PERFORM_FOLLOWUP   ,
     v_new_data.about_plan_code                   ,
     v_new_data.about_provider_id                  ,
     v_new_data.action_comments                 ,
     v_new_data.action_type                          ,
     v_new_data.cancel_by                            ,
     v_new_data.cancel_dt                          ,
     v_new_data.cancel_method                        ,
     v_new_data.cancel_reason                        ,
     v_new_data.current_task_id                  ,
     v_new_data.de_task_id                   ,
     v_new_data.incident_about                   ,
     v_new_data.incident_description             ,
     v_new_data.incident_reason                  ,
     v_new_data.incident_status                  ,
     v_new_data.incident_status_dt             ,
     v_new_data.instance_complete_dt               ,
     v_new_data.instance_status                  ,
     v_new_data.last_update_by_name              ,
     v_new_data.last_update_by_dt                 ,
     v_new_data.updated_by                      ,
     v_new_data.client_id                            ,
     v_new_data.other_party_name                     ,
     v_new_data.priority                             ,
     v_new_data.reported_by                          ,
     v_new_data.reporter_relationship                ,
     v_new_data.resolution_description           ,
     v_new_data.resolution_type                      ,
     v_new_data.case_id                         ,
     v_new_data.case_cin                         ,
     v_new_data.forwarded                       ,
     v_new_data.incident_type                  ,
     v_new_data.forwarded_to                   ,
    v_sla_days_type                        ,
     v_sla_jeopardy_date                    ,
     v_sla_jeopardy_days                    ,
     v_sla_target_days                      ,
     v_age_in_business_days                 ,
     v_age_in_calendar_days                 ,
     v_jeopardy_days_type                   ,
     v_jeopardy_flag                        ,
     v_timeliness_status                    ,
     v_fwd_timeliness_status       ,
     v_forwarding_target  ,
     v_new_data.complete_dt,
     v_new_data.forward_dt,
     v_new_data.current_step,
     v_new_data.received_dt,
     v_new_data.plan_name,
     v_new_data.reporter_name,
     v_new_data.reporter_phone,
     v_new_data.sla_satisfied,
     v_new_data.sla_complete_dt,
     v_new_data.created_by_sup,
     v_new_data.created_by_eid,
     v_new_data.created_by_sup_name,
     v_new_data.gwf_escalate_to_state,
     v_new_data.gwf_resolved_ees_css,
     v_new_data.gwf_resolved_sup,
     v_new_data.gwf_followup_req,
     v_new_data.gwf_return_to_state,
     v_new_data.pref_language
         );
      UPD_FPDBD
        (v_identifier,v_end_date,v_bi_id, v_new_data.current_task_id ,
          v_dcmplac_id ,
        --  v_dcmples_id ,
          v_dcmplia_id ,
          v_dcmplid_id,
          v_dcmplir_id,
          v_dcmplis_id,
          v_dcmplin_id,
          v_dcmplrd_id,
          v_new_data.incident_status_dt ,
          v_new_data.last_update_by_dt ,
          v_new_data.complete_dt,
          v_dcmplss_id,
          v_new_data.sla_complete_dt,
          v_fcmplbd_id);
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
