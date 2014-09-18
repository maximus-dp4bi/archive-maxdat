alter session set plsql_code_type = native;

create or replace package NYHIX_PROCESS_APPEALS as

-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


  procedure CALC_DNPAPLCUR;
    
  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date )
  return number;

  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
  return number;

  function GET_JEOPARDY_STATUS
    (p_create_dt in date,
     p_complete_dt in date,
     p_identifier_type in varchar2 )
  return varchar2;

  function GET_SLA_JEOPARDY_DATE
        (p_create_dt in date,
         p_identifier_type in varchar2 )
  return date;
          
  function GET_TIMELINESS_STATUS
    (p_create_dt in date,
     p_complete_dt in date,
     p_identifier_type in varchar2)
  return varchar2;

/*
 Include
   NEPA_ID
   STG_LAST_UPDATE_DATE
*/

type T_INS_APL_XML is record 
    (
     ABOUT_PLAN_CODE varchar2(32),
     ABOUT_PLAN_NAME varchar2(64),
     ABOUT_PROVIDER_ID varchar2(100),
     ABOUT_PROVIDER_NAME varchar2(100),
     ACTION_COMMENTS varchar2(4000),
     ACTION_TYPE varchar2(64),
     AID_TO_CONTINUE varchar2(1),
     APPEAL_DT varchar2(64),
     APPEAL_HEARING_DT varchar2(19),
     APPEAL_HEARING_LOCATION varchar2(64),
     APPEAL_HEARING_TIME varchar2(64),
     APPELLANT_TYPE varchar2(32),
     APPELLANT_TYPE_DESC varchar2(64),
     ASED_ADVISE_WITHDRAW varchar2(19),
     ASED_CANCEL_HEARING varchar2(19),
     ASED_CONDUCT_ST_REV varchar2(19),
     ASED_CON_HEARING_PROC varchar2(19),
     ASED_DETERMINE_VALID varchar2(19),
     ASED_GATHER_MISS_INFO varchar2(19),
     ASED_PROC_VALID_AMEND varchar2(19),
     ASED_REVIEW_APPEAL varchar2(19),
     ASED_SCHEDULE_HEARING varchar2(19),
     ASED_SHOP_REVIEW varchar2(19),
     ASF_ADVISE_WITHDRAW varchar2(1),
     ASF_CANCEL_HEARING varchar2(1),
     ASF_CONDUCT_ST_REV varchar2(1),
     ASF_CON_HEARING_PROC varchar2(1),
     ASF_DETERMINE_VALID varchar2(1),
     ASF_GATHER_MISS_INFO varchar2(1),
     ASF_PROC_VALID_AMEND varchar2(1),
     ASF_REVIEW_APPEAL varchar2(1),
     ASF_SCHEDULE_HEARING varchar2(1),
     ASF_SHOP_REVIEW varchar2(1),
     ASPB_ADVISE_WITHDRAW varchar2(100),
     ASPB_CANCEL_HEARING varchar2(100),
     ASPB_CONDUCT_ST_REV varchar2(100),
     ASPB_CON_HEARING_PROC varchar2(100),
     ASPB_DETERMINE_VALID varchar2(100),
     ASPB_GATHER_MISS_INFO varchar2(100),
     ASPB_PROC_VALID_AMEND varchar2(100),
     ASPB_REVIEW_APPEAL varchar2(100),
     ASPB_SCHEDULE_HEARING varchar2(100),
     ASPB_SHOP_REVIEW varchar2(100),
     ASSD_ADVISE_WITHDRAW varchar2(19),
     ASSD_CANCEL_HEARING varchar2(19),
     ASSD_CONDUCT_ST_REV varchar2(19),
     ASSD_CON_HEARING_PROC varchar2(19),
     ASSD_DETERMINE_VALID varchar2(19),
     ASSD_GATHER_MISS_INFO varchar2(19),
     ASSD_PROC_VALID_AMEND varchar2(19),
     ASSD_REVIEW_APPEAL varchar2(19),
     ASSD_SCHEDULE_HEARING varchar2(19),
     ASSD_SHOP_REVIEW varchar2(19),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(40),
     CANCEL_REASON varchar2(100),
     CASE_ID varchar2(100),     
     CHANNEL varchar2(80),
     COMPLETE_DT varchar2(19),
     CREATED_BY_GROUP varchar2(80),
     CREATED_BY_NAME varchar2(100),
     CREATE_DT varchar2(19),
     CURRENT_STEP varchar2(256),
     CURRENT_TASK_ID varchar2(100),
     EXPECTED_REQUEST varchar2(100),
     GWF_APPEAL_INVALID varchar2(1),
     GWF_CHANGE_ELIGIBILITY varchar2(1),
     GWF_CHANNEL varchar2(1),
     GWF_RESOLVED varchar2(1),
     GWF_SHOP_REVIEW varchar2(1),
     GWF_VALID varchar2(1),
     GWF_WITHDRAWN_IN_WRITING varchar2(1),
     INCIDENT_ABOUT varchar2(80),
     INCIDENT_DESCRIPTION varchar2(4000),
     INCIDENT_ID varchar2(100),
    -- INCIDENT_REASON varchar2(80),
     INCIDENT_STATUS varchar2(80),
     INCIDENT_STATUS_DT varchar2(19),
     INCIDENT_TYPE varchar2(80),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(10),
     LAST_UPDATE_BY_DT varchar2(19),
     LAST_UPDATE_BY_NAME varchar2(100),
     LINKED_CLIENT varchar2(100),
     NEPA_ID varchar2(100),
     OTHER_PARTY_NAME varchar2(64),
     PRIORITY varchar2(256),
     RECEIPT_DT varchar2(19),
     RECEIVED_DT varchar2(19),
     REPORTED_BY varchar2(80),
     REPORTER_RELATIONSHIP varchar2(64),
     REQUESTED_DAY varchar2(32),
     REQUESTED_TIME varchar2(32),
     RESOLUTION_DESCRIPTION varchar2(4000),
     RESOLUTION_TYPE varchar2(64),
     STAGE_DONE_DT varchar2(19),
     STG_EXTRACT_DATE varchar2(19),
     STG_LAST_UPDATE_DATE varchar2(19),
     TRACKING_NUMBER varchar2(32)
     );
    
/*
 Include
   STG_LAST_UPDATE_DATE
*/

type T_UPD_APL_XML is record
    (
     ABOUT_PLAN_CODE varchar2(32),
     ABOUT_PLAN_NAME varchar2(64),
     ABOUT_PROVIDER_ID varchar2(100),
     ABOUT_PROVIDER_NAME varchar2(100),
     ACTION_COMMENTS varchar2(4000),
     ACTION_TYPE varchar2(64),
     AID_TO_CONTINUE varchar2(1),
     APPEAL_DT varchar2(64),
     APPEAL_HEARING_DT varchar2(19),
     APPEAL_HEARING_LOCATION varchar2(64),
     APPEAL_HEARING_TIME varchar2(64),
     APPELLANT_TYPE varchar2(32),
     APPELLANT_TYPE_DESC varchar2(64),
     ASED_ADVISE_WITHDRAW varchar2(19),
     ASED_CANCEL_HEARING varchar2(19),
     ASED_CONDUCT_ST_REV varchar2(19),
     ASED_CON_HEARING_PROC varchar2(19),
     ASED_DETERMINE_VALID varchar2(19),
     ASED_GATHER_MISS_INFO varchar2(19),
     ASED_PROC_VALID_AMEND varchar2(19),
     ASED_REVIEW_APPEAL varchar2(19),
     ASED_SCHEDULE_HEARING varchar2(19),
     ASED_SHOP_REVIEW varchar2(19),
     ASF_ADVISE_WITHDRAW varchar2(1),
     ASF_CANCEL_HEARING varchar2(1),
     ASF_CONDUCT_ST_REV varchar2(1),
     ASF_CON_HEARING_PROC varchar2(1),
     ASF_DETERMINE_VALID varchar2(1),
     ASF_GATHER_MISS_INFO varchar2(1),
     ASF_PROC_VALID_AMEND varchar2(1),
     ASF_REVIEW_APPEAL varchar2(1),
     ASF_SCHEDULE_HEARING varchar2(1),
     ASF_SHOP_REVIEW varchar2(1),
     ASPB_ADVISE_WITHDRAW varchar2(100),
     ASPB_CANCEL_HEARING varchar2(100),
     ASPB_CONDUCT_ST_REV varchar2(100),
     ASPB_CON_HEARING_PROC varchar2(100),
     ASPB_DETERMINE_VALID varchar2(100),
     ASPB_GATHER_MISS_INFO varchar2(100),
     ASPB_PROC_VALID_AMEND varchar2(100),
     ASPB_REVIEW_APPEAL varchar2(100),
     ASPB_SCHEDULE_HEARING varchar2(100),
     ASPB_SHOP_REVIEW varchar2(100),
     ASSD_ADVISE_WITHDRAW varchar2(19),
     ASSD_CANCEL_HEARING varchar2(19),
     ASSD_CONDUCT_ST_REV varchar2(19),
     ASSD_CON_HEARING_PROC varchar2(19),
     ASSD_DETERMINE_VALID varchar2(19),
     ASSD_GATHER_MISS_INFO varchar2(19),
     ASSD_PROC_VALID_AMEND varchar2(19),
     ASSD_REVIEW_APPEAL varchar2(19),
     ASSD_SCHEDULE_HEARING varchar2(19),
     ASSD_SHOP_REVIEW varchar2(19),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(40),
     CANCEL_REASON varchar2(100),
     CASE_ID varchar2(100),
     CHANNEL varchar2(80),
     COMPLETE_DT varchar2(19),
     CREATED_BY_GROUP varchar2(80),
     CREATED_BY_NAME varchar2(100),
     CREATE_DT varchar2(19),
     CURRENT_STEP varchar2(256),
     CURRENT_TASK_ID varchar2(100),
     EXPECTED_REQUEST varchar2(100),
     GWF_APPEAL_INVALID varchar2(1),
     GWF_CHANGE_ELIGIBILITY varchar2(1),
     GWF_CHANNEL varchar2(1),
     GWF_RESOLVED varchar2(1),
     GWF_SHOP_REVIEW varchar2(1),
     GWF_VALID varchar2(1),
     GWF_WITHDRAWN_IN_WRITING varchar2(1),
     INCIDENT_ABOUT varchar2(80),
     INCIDENT_DESCRIPTION varchar2(4000),
     INCIDENT_ID varchar2(100),
    -- INCIDENT_REASON varchar2(80),
     INCIDENT_STATUS varchar2(80),
     INCIDENT_STATUS_DT varchar2(19),
     INCIDENT_TYPE varchar2(80),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(10),
     LAST_UPDATE_BY_DT varchar2(19),
     LAST_UPDATE_BY_NAME varchar2(100),
     LINKED_CLIENT varchar2(100),
     OTHER_PARTY_NAME varchar2(64),
     PRIORITY varchar2(256),
     RECEIPT_DT varchar2(19),
     RECEIVED_DT varchar2(19),
     REPORTED_BY varchar2(80),
     REPORTER_RELATIONSHIP varchar2(64),
     REQUESTED_DAY varchar2(32),
     REQUESTED_TIME varchar2(32),
     RESOLUTION_DESCRIPTION varchar2(4000),
     RESOLUTION_TYPE varchar2(64),
     STAGE_DONE_DT varchar2(19),
     STG_EXTRACT_DATE varchar2(19),
     STG_LAST_UPDATE_DATE varchar2(19),
     TRACKING_NUMBER varchar2(32)
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

create or replace package body NYHIX_PROCESS_APPEALS as

  v_bem_id number := 23; -- 'NYHIX Process Appeals'
  v_bil_id number := 10; -- 'Incident ID'
  v_bsl_id number := 23; -- 'NYHBE_ETL_PROCESS_APPEALS'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';  
  v_calc_daplcur_job_name varchar2(30) := 'CALC_DNPAPLCUR';  
  v_timeliness_days number;
  v_jeopardy_days number ;
  v_step  varchar2(100);
  v_target_date DATE;
  
function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date
     )
    return number
  as
  begin
    return BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,nvl(p_complete_date,sysdate));
  end;
     
  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number
  as
  begin
    return trunc(nvl(p_complete_date,sysdate)) - trunc(p_create_date);
  end;
  
  function GET_JEOPARDY_STATUS
    (p_create_dt in date,
     p_complete_dt in date,
     p_identifier_type in varchar2
  )
    return varchar2
      as
  begin
  if p_identifier_type is not null then
  
    select  to_number(out_var)
    into    v_jeopardy_days
    from    corp_etl_list_lkup
    where   name = 'APPEALS_JEOPARDY_DAYS'
    and     list_type = 'APPEALS'
    and     value = p_identifier_type;
    
   if  v_jeopardy_days is not null then
     if (p_create_dt + v_jeopardy_days)  < nvl(p_complete_dt,SYSDATE ) then
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

  function GET_SLA_JEOPARDY_DATE
        (p_create_dt in date,
         p_identifier_type in varchar2
      )
        return date
          as
      begin
      if p_identifier_type is not null then
      
        select  to_number(out_var)
        into    v_jeopardy_days
        from    corp_etl_list_lkup
        where   name = 'APPEALS_JEOPARDY_DAYS'
        and     list_type = 'APPEALS'
        and     value = p_identifier_type;
        
       return  (p_create_dt + v_jeopardy_days);
       
      end if;
  end;
  
 function GET_TIMELINESS_STATUS
    (p_create_dt in date,
     p_complete_dt in date,
     p_identifier_type in varchar2
)
    return varchar2
  as
  begin
   if p_identifier_type is not null then
     select  to_number(out_var)
     into    v_timeliness_days
     from    corp_etl_list_lkup
     where   name = 'APPEALS_TIMELINESS_DAYS'
     and     list_type = 'APPEALS'
     and     value = p_identifier_type;
    
     if v_timeliness_days is not null then
       v_target_date := p_create_dt  + v_timeliness_days;
     else
       return  'Not Processed';
     end if;
    
     IF p_complete_dt IS NOT NULL THEN
       if v_target_date < p_complete_dt  then
         return 'Processed Untimely';
       else
         return 'Processed Timely';
       end if;    
     ELSE
       return 'Not Processed';
     END IF;
   else
     return 'Not Processed';
   end if;
  end;
  
-- Calculate column values in BPM Semantic table D_APPEALS_CURRENT.
 procedure CALC_DNPAPLCUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DNPAPLCUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin
    update D_APPEALS_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,CUR_COMPLETE_DATE), -- changed to Complete_Date
      AGE_IN_CALENDAR_DAYS = GET_AGE_IN_CALENDAR_DAYS(CREATE_DATE,CUR_COMPLETE_DATE),
      JEOPARDY_FLAG = GET_JEOPARDY_STATUS(CREATE_DATE,CUR_COMPLETE_DATE,INCIDENT_TYPE),
      APPEAL_TIMELINESS_STATUS = GET_TIMELINESS_STATUS(CREATE_DATE,SCHEDULE_HEARING_END,INCIDENT_TYPE), --calculate timeliness based on status set to Hearing Set - Disp or No Disp...
      SLA_JEOPARDY_DATE = GET_SLA_JEOPARDY_DATE(CREATE_DATE,INCIDENT_TYPE)
      where
      CUR_COMPLETE_DATE is null ;
     
    v_num_rows_updated := sql%rowcount;
    commit;
    v_log_message := v_num_rows_updated  || ' D_APPEALS_CURRENT rows updated with calculated attributes by CALC_DNPAPLCUR.';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
  end;
  
 -- Get dimension ID for BPM Semantic model - Process Appeals - Instance Status.
  procedure GET_DAPLIN_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_ins_status in varchar2,
      p_daplin_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DAPLIN_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DAPLIN_ID into p_daplin_id
     from D_APPEALS_INSTANCE_STATUS
     where
       INSTANCE_STATUS = p_ins_status
       or (INSTANCE_STATUS is null and p_ins_status is null);
   exception
     when NO_DATA_FOUND then
       p_daplin_id := SEQ_DAPLIN_ID.nextval;
       begin
         insert into D_APPEALS_INSTANCE_STATUS (DAPLIN_ID,INSTANCE_STATUS)
         values (p_daplin_id,p_ins_status);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DAPLIN_ID into p_daplin_id
           from D_APPEALS_INSTANCE_STATUS
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
  
  
  -- Get dimension ID for BPM Semantic model - Process Appeals - Incident Status.
  procedure GET_DAPLIS_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_status in varchar2,
     p_daplis_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DAPLIS_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DAPLIS_ID into p_daplis_id
    from D_APPEALS_INCIDENT_STATUS
    where
      INCIDENT_STATUS = p_status
      or (INCIDENT_STATUS is null and p_status is null);
  exception
    when NO_DATA_FOUND then
      p_daplis_id := SEQ_DAPLIS_ID.nextval;
      begin
        insert into D_APPEALS_INCIDENT_STATUS (DAPLIS_ID,INCIDENT_STATUS)
        values (p_daplis_id,p_status);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DAPLIS_ID into p_daplis_id
          from D_APPEALS_INCIDENT_STATUS
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
  
  -- Get dimension ID for BPM Semantic model - Process Appeals - action comments
  procedure GET_DAPLAC_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_action_comments in varchar2,
     p_daplac_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DAPLAC_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
      select DAPLAC_ID into p_daplac_id
      from D_APPEALS_ACTION_COMMENTS
      where ACTION_COMMENTS  = TO_CHAR(p_action_comments)
         or (ACTION_COMMENTS  is null and TO_CHAR(p_action_comments) is null);
  exception
    when NO_DATA_FOUND then
      p_daplac_id := SEQ_DAPLAC_ID.nextval;
      begin
        insert into D_APPEALS_ACTION_COMMENTS
          (DAPLAC_ID,ACTION_COMMENTS)
        values
          (p_daplac_id,TO_CHAR(p_action_comments));
        commit;
      exception
        when DUP_VAL_ON_INDEX then
        select DAPLAC_ID into p_daplac_id
        from D_APPEALS_ACTION_COMMENTS
        where ACTION_COMMENTS  = TO_CHAR(p_action_comments)
         or (ACTION_COMMENTS  is null and TO_CHAR(p_action_comments) is null);
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
  
  
  -- Get dimension ID for BPM Semantic model - Process Appeals -Incident About
  procedure GET_DAPLIA_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_incident_about in varchar2,
     p_daplia_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DAPLIA_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DAPLIA_ID into p_daplia_id
    from D_APPEALS_INCIDENT_ABOUT
    where
      INCIDENT_ABOUT  = p_incident_about
      or (INCIDENT_ABOUT  is null and p_incident_about is null);
  exception
    when NO_DATA_FOUND then
      p_daplia_id := SEQ_DAPLIA_ID.nextval;
      begin
        insert into D_APPEALS_INCIDENT_ABOUT (DAPLIA_ID,INCIDENT_ABOUT )
        values (p_daplia_id,p_incident_about);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DAPLIA_ID into p_daplia_id
          from D_APPEALS_INCIDENT_ABOUT
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
  
  
  -- Get dimension ID for BPM Semantic model - Process Appeals - Incident_Description
  procedure GET_DAPLID_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_incident_description in varchar2,
     p_daplid_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DAPLID_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DAPLID_ID into p_daplid_id
    from D_APPEALS_INCIDENT_DESC
    where
     INCIDENT_DESCRIPTION = p_incident_description
      or (INCIDENT_DESCRIPTION is null and p_incident_description is null);
  exception
    when NO_DATA_FOUND then
      p_daplid_id := SEQ_DAPLID_ID.nextval;
      begin
        insert into D_APPEALS_INCIDENT_DESC  (DAPLID_ID,INCIDENT_DESCRIPTION)
        values (p_daplid_id,p_incident_description);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DAPLID_ID into p_daplid_id
          from D_APPEALS_INCIDENT_DESC
          where
            INCIDENT_DESCRIPTION = p_incident_description
            or (INCIDENT_DESCRIPTION is null and p_incident_description is null);
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
  
   -- Get dimension ID for BPM Semantic model - Process Appeals - Conduct Validity Performed By
  procedure GET_DAPLCVPB_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_conduct_valid_pb in varchar2,
     p_daplcvpb_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DAPLCVPB_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DAPLCVPB_ID into p_daplcvpb_id
    from D_APPEALS_CVPB
    where
     CONDUCT_VALIDITY_PERFORMED_BY = p_conduct_valid_pb
      or (CONDUCT_VALIDITY_PERFORMED_BY is null and p_conduct_valid_pb is null);
  exception
    when NO_DATA_FOUND then
      p_daplcvpb_id := SEQ_DAPLCVPB_ID.nextval;
      begin
        insert into D_APPEALS_CVPB  (DAPLCVPB_ID,CONDUCT_VALIDITY_PERFORMED_BY)
        values (p_daplcvpb_id,p_conduct_valid_pb);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DAPLCVPB_ID into p_daplcvpb_id
          from D_APPEALS_CVPB
          where
            CONDUCT_VALIDITY_PERFORMED_BY = p_conduct_valid_pb
            or (CONDUCT_VALIDITY_PERFORMED_BY is null and p_conduct_valid_pb is null);
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
  
  
-- Get record for Process Incidents insert XML.
  procedure GET_INS_APL_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_APL_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_APL_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin  

    select
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PLAN_CODE') "ABOUT_PLAN_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PLAN_NAME') "ABOUT_PLAN_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PROVIDER_ID') "ABOUT_PROVIDER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PROVIDER_NAME') "ABOUT_PROVIDER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_COMMENTS') "ACTION_COMMENTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_TYPE') "ACTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/AID_TO_CONTINUE') "AID_TO_CONTINUE",
      extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_DT') "APPEAL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_HEARING_DT') "APPEAL_HEARING_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_HEARING_LOCATION') "APPEAL_HEARING_LOCATION",
      extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_HEARING_TIME') "APPEAL_HEARING_TIME",
      extractValue(p_data_xml,'/ROWSET/ROW/APPELLANT_TYPE') "APPELLANT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/APPELLANT_TYPE_DESC') "APPELLANT_TYPE_DESC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_ADVISE_WITHDRAW') "ASED_ADVISE_WITHDRAW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CANCEL_HEARING') "ASED_CANCEL_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CONDUCT_ST_REV') "ASED_CONDUCT_ST_REV",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CON_HEARING_PROC') "ASED_CON_HEARING_PROC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_DETERMINE_VALID') "ASED_DETERMINE_VALID",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_GATHER_MISS_INFO') "ASED_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROC_VALID_AMEND') "ASED_PROC_VALID_AMEND",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_REVIEW_APPEAL') "ASED_REVIEW_APPEAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_SCHEDULE_HEARING') "ASED_SCHEDULE_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_SHOP_REVIEW') "ASED_SHOP_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_ADVISE_WITHDRAW') "ASF_ADVISE_WITHDRAW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CANCEL_HEARING') "ASF_CANCEL_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CONDUCT_ST_REV') "ASF_CONDUCT_ST_REV",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CON_HEARING_PROC') "ASF_CON_HEARING_PROC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_DETERMINE_VALID') "ASF_DETERMINE_VALID",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_GATHER_MISS_INFO') "ASF_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROC_VALID_AMEND') "ASF_PROC_VALID_AMEND",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_REVIEW_APPEAL') "ASF_REVIEW_APPEAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_SCHEDULE_HEARING') "ASF_SCHEDULE_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_SHOP_REVIEW') "ASF_SHOP_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_ADVISE_WITHDRAW') "ASPB_ADVISE_WITHDRAW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CANCEL_HEARING') "ASPB_CANCEL_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CONDUCT_ST_REV') "ASPB_CONDUCT_ST_REV",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CON_HEARING_PROC') "ASPB_CON_HEARING_PROC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_DETERMINE_VALID') "ASPB_DETERMINE_VALID",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_GATHER_MISS_INFO') "ASPB_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PROC_VALID_AMEND') "ASPB_PROC_VALID_AMEND",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_REVIEW_APPEAL') "ASPB_REVIEW_APPEAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_SCHEDULE_HEARING') "ASPB_SCHEDULE_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_SHOP_REVIEW') "ASPB_SHOP_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_ADVISE_WITHDRAW') "ASSD_ADVISE_WITHDRAW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CANCEL_HEARING') "ASSD_CANCEL_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CONDUCT_ST_REV') "ASSD_CONDUCT_ST_REV",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CON_HEARING_PROC') "ASSD_CON_HEARING_PROC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_DETERMINE_VALID') "ASSD_DETERMINE_VALID",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_GATHER_MISS_INFO') "ASSD_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROC_VALID_AMEND') "ASSD_PROC_VALID_AMEND",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_REVIEW_APPEAL') "ASSD_REVIEW_APPEAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_SCHEDULE_HEARING') "ASSD_SCHEDULE_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_SHOP_REVIEW') "ASSD_SHOP_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",      
      extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL') "CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_GROUP') "CREATED_BY_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_NAME') "CREATED_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_STEP') "CURRENT_STEP",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/EXPECTED_REQUEST') "EXPECTED_REQUEST",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_APPEAL_INVALID') "GWF_APPEAL_INVALID",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_CHANGE_ELIGIBILITY') "GWF_CHANGE_ELIGIBILITY",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_CHANNEL') "GWF_CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESOLVED') "GWF_RESOLVED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_SHOP_REVIEW') "GWF_SHOP_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_VALID') "GWF_VALID",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_WITHDRAWN_IN_WRITING') "GWF_WITHDRAWN_IN_WRITING",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ABOUT') "INCIDENT_ABOUT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_DESCRIPTION') "INCIDENT_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ID') "INCIDENT_ID",
     -- extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_REASON') "INCIDENT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS') "INCIDENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS_DT') "INCIDENT_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_TYPE') "INCIDENT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_DT') "LAST_UPDATE_BY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/LINKED_CLIENT') "LINKED_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/NEPA_ID') "NEPA_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OTHER_PARTY_NAME') "OTHER_PARTY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PRIORITY') "PRIORITY",
      extractValue(p_data_xml,'/ROWSET/ROW/RECEIPT_DT') "RECEIPT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/RECEIVED_DT') "RECEIVED_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTED_BY') "REPORTED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_RELATIONSHIP') "REPORTER_RELATIONSHIP",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUESTED_DAY') "REQUESTED_DAY",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUESTED_TIME') "REQUESTED_TIME",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_DESCRIPTION') "RESOLUTION_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_TYPE') "RESOLUTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/STAGE_DONE_DT') "STAGE_DONE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_EXTRACT_DATE') "STG_EXTRACT_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/TRACKING_NUMBER') "TRACKING_NUMBER"
   into p_data_record
       from dual;
     
     exception
     
       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
         raise; 
         
  end;
  
 -- Get record for Process Incidents update XML. 
  procedure GET_UPD_APL_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_APL_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_APL_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin 

     select
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PLAN_CODE') "ABOUT_PLAN_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PLAN_NAME') "ABOUT_PLAN_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PROVIDER_ID') "ABOUT_PROVIDER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PROVIDER_NAME') "ABOUT_PROVIDER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_COMMENTS') "ACTION_COMMENTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_TYPE') "ACTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/AID_TO_CONTINUE') "AID_TO_CONTINUE",
      extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_DT') "APPEAL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_HEARING_DT') "APPEAL_HEARING_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_HEARING_LOCATION') "APPEAL_HEARING_LOCATION",
      extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_HEARING_TIME') "APPEAL_HEARING_TIME",
      extractValue(p_data_xml,'/ROWSET/ROW/APPELLANT_TYPE') "APPELLANT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/APPELLANT_TYPE_DESC') "APPELLANT_TYPE_DESC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_ADVISE_WITHDRAW') "ASED_ADVISE_WITHDRAW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CANCEL_HEARING') "ASED_CANCEL_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CONDUCT_ST_REV') "ASED_CONDUCT_ST_REV",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CON_HEARING_PROC') "ASED_CON_HEARING_PROC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_DETERMINE_VALID') "ASED_DETERMINE_VALID",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_GATHER_MISS_INFO') "ASED_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROC_VALID_AMEND') "ASED_PROC_VALID_AMEND",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_REVIEW_APPEAL') "ASED_REVIEW_APPEAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_SCHEDULE_HEARING') "ASED_SCHEDULE_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_SHOP_REVIEW') "ASED_SHOP_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_ADVISE_WITHDRAW') "ASF_ADVISE_WITHDRAW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CANCEL_HEARING') "ASF_CANCEL_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CONDUCT_ST_REV') "ASF_CONDUCT_ST_REV",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CON_HEARING_PROC') "ASF_CON_HEARING_PROC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_DETERMINE_VALID') "ASF_DETERMINE_VALID",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_GATHER_MISS_INFO') "ASF_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROC_VALID_AMEND') "ASF_PROC_VALID_AMEND",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_REVIEW_APPEAL') "ASF_REVIEW_APPEAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_SCHEDULE_HEARING') "ASF_SCHEDULE_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_SHOP_REVIEW') "ASF_SHOP_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_ADVISE_WITHDRAW') "ASPB_ADVISE_WITHDRAW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CANCEL_HEARING') "ASPB_CANCEL_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CONDUCT_ST_REV') "ASPB_CONDUCT_ST_REV",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CON_HEARING_PROC') "ASPB_CON_HEARING_PROC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_DETERMINE_VALID') "ASPB_DETERMINE_VALID",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_GATHER_MISS_INFO') "ASPB_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PROC_VALID_AMEND') "ASPB_PROC_VALID_AMEND",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_REVIEW_APPEAL') "ASPB_REVIEW_APPEAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_SCHEDULE_HEARING') "ASPB_SCHEDULE_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_SHOP_REVIEW') "ASPB_SHOP_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_ADVISE_WITHDRAW') "ASSD_ADVISE_WITHDRAW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CANCEL_HEARING') "ASSD_CANCEL_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CONDUCT_ST_REV') "ASSD_CONDUCT_ST_REV",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CON_HEARING_PROC') "ASSD_CON_HEARING_PROC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_DETERMINE_VALID') "ASSD_DETERMINE_VALID",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_GATHER_MISS_INFO') "ASSD_GATHER_MISS_INFO",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROC_VALID_AMEND') "ASSD_PROC_VALID_AMEND",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_REVIEW_APPEAL') "ASSD_REVIEW_APPEAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_SCHEDULE_HEARING') "ASSD_SCHEDULE_HEARING",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_SHOP_REVIEW') "ASSD_SHOP_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL') "CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_GROUP') "CREATED_BY_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_NAME') "CREATED_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_STEP') "CURRENT_STEP",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/EXPECTED_REQUEST') "EXPECTED_REQUEST",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_APPEAL_INVALID') "GWF_APPEAL_INVALID",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_CHANGE_ELIGIBILITY') "GWF_CHANGE_ELIGIBILITY",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_CHANNEL') "GWF_CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESOLVED') "GWF_RESOLVED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_SHOP_REVIEW') "GWF_SHOP_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_VALID') "GWF_VALID",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_WITHDRAWN_IN_WRITING') "GWF_WITHDRAWN_IN_WRITING",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ABOUT') "INCIDENT_ABOUT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_DESCRIPTION') "INCIDENT_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ID') "INCIDENT_ID",
     -- extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_REASON') "INCIDENT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS') "INCIDENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS_DT') "INCIDENT_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_TYPE') "INCIDENT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_DT') "LAST_UPDATE_BY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/LINKED_CLIENT') "LINKED_CLIENT",
      extractValue(p_data_xml,'/ROWSET/ROW/OTHER_PARTY_NAME') "OTHER_PARTY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PRIORITY') "PRIORITY",
      extractValue(p_data_xml,'/ROWSET/ROW/RECEIPT_DT') "RECEIPT_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/RECEIVED_DT') "RECEIVED_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTED_BY') "REPORTED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_RELATIONSHIP') "REPORTER_RELATIONSHIP",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUESTED_DAY') "REQUESTED_DAY",
      extractValue(p_data_xml,'/ROWSET/ROW/REQUESTED_TIME') "REQUESTED_TIME",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_DESCRIPTION') "RESOLUTION_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_TYPE') "RESOLUTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/STAGE_DONE_DT') "STAGE_DONE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_EXTRACT_DATE') "STG_EXTRACT_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/TRACKING_NUMBER') "TRACKING_NUMBER"
     into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;
  
  end;  
  
  -- Insert fact for BPM Semantic model - Process Appeals.
    procedure INS_FAPLBD
      (p_identifier in varchar2,
       p_start_date in date,
       p_end_date in date,
       p_apl_bi_id in number,
       p_current_task_id in number,
       p_daplac_id in number,       
       p_daplia_id in number,
       p_daplid_id in number,
      -- p_daplir_id in number,
       p_daplis_id in number,
       p_daplin_id in number,
       p_daplcvpb_id in number,
       p_incident_status_date in varchar2,
       p_conduct_validity_start in varchar2,
       p_conduct_validity_end in varchar2,
       p_complete_date in varchar2,
       p_last_update_date varchar2,
       p_faplbd_id out number  )
 
     as
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FAPLBD';
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
      v_jeopardy_status_dt := sysdate;
      p_faplbd_id := SEQ_FAPLBD_ID.nextval;
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
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_apl_bi_id,v_log_message,v_sql_code);
        RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
      end if;
      
      insert into F_APPEALS_BY_DATE
        (FAPLBD_ID ,
          D_DATE , 
          BUCKET_START_DATE , 
          BUCKET_END_DATE ,
          APL_BI_ID,
          DAPLAC_ID,
          CURRENT_TASK_ID,          
          DAPLIA_ID,
          DAPLID_ID,
       --   DAPLIR_ID,
          DAPLIS_ID,
          DAPLIN_ID,
          DAPLCVPB_ID,
          INCIDENT_STATUS_DATE,
          CONDUCT_VALIDITY_START,
          CONDUCT_VALIDITY_END,
          COMPLETE_DATE,
          CREATION_COUNT,
          INVENTORY_COUNT,
          COMPLETION_COUNT 
          )
      values
        (p_faplbd_id,
         p_start_date,
         v_bucket_start_date,
         v_bucket_end_date,
         p_apl_bi_id,
         p_daplac_id,
         p_current_task_id ,         
         p_daplia_id ,
         p_daplid_id ,
       --  p_daplir_id ,
         p_daplis_id ,
         p_daplin_id ,
         p_daplcvpb_id ,
         to_date(p_incident_status_date,BPM_COMMON.DATE_FMT),
         to_date(p_conduct_validity_start,BPM_COMMON.DATE_FMT),
         to_date(p_conduct_validity_end,BPM_COMMON.DATE_FMT),
         to_date(p_complete_date,BPM_COMMON.DATE_FMT),
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
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_apl_bi_id,v_log_message,v_sql_code);
      raise;
  end;
  
  
  -- Insert or update dimension for BPM Semantic model - Process Appeals - Current.
  procedure SET_DAPLCUR
    (p_set_type                         in  varchar2,
    p_identifier                        in  varchar2,
    p_apl_bi_id                         in  number,
    p_channel                           in  varchar2,
    p_created_by_group                  in  varchar2,
    p_created_by_name                   in  varchar2,
    p_incident_id                       in  number,
    p_incident_type                     in  varchar2,
    p_tracking_number                   in  varchar2,
    p_create_date                       in  varchar2  ,                 
    p_receipt_date                      in  varchar2,
    p_cur_incident_about                in  varchar2,
    --p_cur_incident_reason               in  varchar2,
    p_cur_incident_status_date          in  varchar2,
    p_instance_complete_date            in  varchar2,    
    p_last_update_by_name               in  varchar2,
    p_last_update_date                  in  varchar2 ,
    p_reported_by                       in  varchar2,
    p_reporter_relationship             in  varchar2,
    p_linked_client                     in  number,
    p_case_id                           in  number,
    p_other_party_name                  in  varchar2,
    p_cur_instance_status               in  varchar2,
    p_cur_incident_description          in  varchar2,
    p_cur_incident_status               in  varchar2,
    p_priority                          in  varchar2,
    p_about_plan_code                   in  varchar2,
    p_about_plan_name                   in  varchar2,
    p_about_provider_id                 in  varchar2,
    p_about_provider_name               in  varchar2,
    p_cur_action_comments               in  varchar2,
    p_action_type                       in  varchar2, 
    p_cur_current_task_id               in  number,
    p_resolution_description            in  varchar2,
    p_resolution_type                   in  varchar2,
    p_cancel_by                         in  varchar2,
    p_cancel_date                       in  varchar2,
    p_cancel_method                     in  varchar2,
    p_cancel_reason                     in  varchar2,        
    p_review_apl_start                  in  varchar2,
    p_review_apl_end                    in  varchar2,
    p_review_apl_pb                     in  varchar2,
    p_cur_conduct_valid_start           in  varchar2,    
    p_cur_conduct_valid_end             in  varchar2,    
    p_cur_validity_pb                   in  varchar2,    
    p_valid_amend_start                 in  varchar2,
    p_valid_amend_end                   in  varchar2,
    p_valid_amend_pb                    in  varchar2,    
    p_gather_mi_start                  in  varchar2,
    p_gather_mi_end                    in  varchar2,
    p_gather_mi_pb                     in  varchar2,    
    p_sd_review_start                  in  varchar2,
    p_sd_review_end                    in  varchar2,
    p_sd_review_pb                     in  varchar2,    
    p_sched_hearing_start              in  varchar2,
    p_sched_hearing_end                in  varchar2,
    p_sched_hearing_pb                 in  varchar2,    
    p_conduct_hearing_start            in  varchar2,
    p_conduct_hearing_end              in  varchar2,
    p_conduct_hearing_pb               in  varchar2,
    p_conduct_st_review_start          in  varchar2,
    p_conduct_st_review_end            in  varchar2,
    p_conduct_st_review_pb             in  varchar2,
    p_cancel_hearing_start             in  varchar2,
    p_cancel_hearing_end               in  varchar2,
    p_cancel_hearing_pb                in  varchar2,
    p_advise_withdraw_start            in  varchar2,
    p_advise_withdraw_end              in  varchar2,
    p_advise_withdraw_pb               in  varchar2,    
--    p_sla_jeopardy_date                 in  varchar2,       
--    p_sla_jeopardy_days                 in  number,
--    p_sla_target_days                   in  number,
--    p_age_in_business_days              in  number,            
--    p_age_in_calendar_days              in  number,
--    p_jeopardy_flag                     in  varchar2,
--    p_jeopardy_days_type                in  varchar2,
--    p_timeliness_status                 in  varchar2,    
    p_gwf_channel                       in  varchar2,
    p_gwf_appeal_invalid                in  varchar2,
    p_gwf_change_elig                   in  varchar2,
    p_gwf_valid                         in  varchar2,
    p_gwf_shop_review                   in  varchar2,
    p_gwf_resolved                      in  varchar2,
    p_gwf_withdraw                      in  varchar2,
    p_asf_review_appeal                 in  varchar2,
    p_asf_determine_valid               in  varchar2,
    p_asf_proc_valid_amend              in  varchar2,
    p_asf_gather_miss_info              in  varchar2,
    p_asf_shop_review                   in  varchar2,
    p_asf_sched_hearing                 in  varchar2,
    p_asf_con_hearing_proc              in  varchar2,
    p_asf_conduct_st_rev                in  varchar2,
    p_asf_cancel_hearing                in  varchar2,
    p_asf_advise_withdraw               in  varchar2,
    p_appeal_hearing_date               in  varchar2,
    p_appeal_date	                      in  varchar2,
    p_appeal_hearing_location	          in  varchar2,
    p_appeal_hearing_time               in  varchar2,
    p_appellant_type                    in  varchar2,
    p_appellant_desc                    in  varchar2,
    p_expected_appeal_req               in number,
    p_requested_day                     in  varchar2,
    p_requested_time                    in  varchar2,
    p_aid_to_continue                   in  varchar2,
    p_complete_date                     in  varchar2,
    p_current_step                      in varchar2,
    p_received_date                     in varchar2
     )
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DAPLCUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_aplcur D_APPEALS_CURRENT%rowtype := null;
    v_jeopardy_flag varchar2(1) := null;
  begin

    r_aplcur.APL_BI_ID                          	:=	    p_apl_bi_id	;
    r_aplcur.ABOUT_PLAN_CODE                     	:=	    p_about_plan_code	;
    r_aplcur.ABOUT_PLAN_NAME                     	:=	    p_about_plan_name	;
    r_aplcur.ABOUT_PROVIDER_ID	                  :=	    p_about_provider_id	;
    r_aplcur.ABOUT_PROVIDER_NAME	                :=	    p_about_provider_name 	;
    r_aplcur.ACTION_TYPE	                        :=	    p_action_type   	;
    r_aplcur.ADVISE_TO_WTHD_IN_WRITING_END      	:=	    to_date(p_advise_withdraw_end ,     BPM_COMMON.DATE_FMT) ;         	
    r_aplcur.ADVISE_TO_WTHD_IN_WRITING_ST        	:=	    to_date(p_advise_withdraw_start ,     BPM_COMMON.DATE_FMT) ;         	
    r_aplcur.ADVISE_TO_WTHD_IN_WRT_PERF_BY      	:=	    p_advise_withdraw_pb	;
    r_aplcur.APPEAL_HEARING_DATE	                :=      to_date(p_appeal_hearing_date ,     BPM_COMMON.DATE_FMT) ;         	
    r_aplcur.ASF_ADVISE_WITHDRAW                 	:=	    p_asf_advise_withdraw               	;
    r_aplcur.ASF_CANCEL_HEARING                  	:=	    p_asf_cancel_hearing                	;
    r_aplcur.ASF_CON_HEARING_PROC	                :=	    p_asf_con_hearing_proc              	;
    r_aplcur.ASF_CONDUCT_ST_REV                  	:=	    p_asf_conduct_st_rev                	;
    r_aplcur.ASF_DETERMINE_VALID                 	:=	    p_asf_determine_valid               	;
    r_aplcur.ASF_GATHER_MISS_INFO                	:=	    p_asf_gather_miss_info              	;
    r_aplcur.ASF_PROC_VALID_AMEND	                :=	    p_asf_proc_valid_amend ;             	
    r_aplcur.ASF_REVIEW_APPEAL	                  :=	    p_asf_review_appeal                 	;
    r_aplcur.ASF_SCHEDULE_HEARING	                :=	    p_asf_sched_hearing                 	;
    r_aplcur.ASF_SHOP_REVIEW	                    :=	    p_asf_shop_review                   	;
    r_aplcur.CANCEL_BY	                          :=	    p_cancel_by                         	;
    r_aplcur.CANCEL_DATE                        	:=	    to_date( p_cancel_date,BPM_COMMON.DATE_FMT);	
    r_aplcur.CANCEL_HEARING_END	                  :=	    to_date(p_cancel_hearing_end ,     BPM_COMMON.DATE_FMT)      ;    	
    r_aplcur.CANCEL_HEARING_PERFORMED_BY        	:=	    p_cancel_hearing_pb                	;
    r_aplcur.CANCEL_HEARING_START	                :=	    to_date(   p_cancel_hearing_start     ,     BPM_COMMON.DATE_FMT)      ;    	
    r_aplcur.CANCEL_METHOD                      	:=	    p_cancel_method                     	;
    r_aplcur.CANCEL_REASON                      	:=	    p_cancel_reason                             	;
    r_aplcur.CASE_ID	                            :=	    p_case_id                           	;
    r_aplcur.CHANNEL	                            :=	    p_channel                           	;
    r_aplcur.CONDUCT_HEARING_PROCESS_END	        :=    	to_date(p_conduct_hearing_end  ,     BPM_COMMON.DATE_FMT)    ;	
    r_aplcur.CONDUCT_HEARING_PROCESS_START	      :=     	to_date(   p_conduct_hearing_start    ,     BPM_COMMON.DATE_FMT) ;         	
    r_aplcur.CONDUCT_STATE_REVIEW_END	            :=	    to_date(p_conduct_st_review_end  ,     BPM_COMMON.DATE_FMT) ;         	
    r_aplcur.CONDUCT_STATE_REVIEW_START	          :=	    to_date(p_conduct_st_review_start    ,     BPM_COMMON.DATE_FMT)  ;        	
    r_aplcur.CREATE_DATE	                        :=	    to_date( p_create_date,BPM_COMMON.DATE_FMT);	
    r_aplcur.CREATED_BY_GROUP                   	:=	    p_created_by_group                  	;
    r_aplcur.CREATED_BY_NAME	                    :=	    p_created_by_name                   	;
    r_aplcur.CUR_ACTION_COMMENTS	                :=	    p_cur_action_comments               	;
    r_aplcur.CUR_CONDUCT_VALIDITY_END           	:=	    to_date(  p_cur_conduct_valid_end  ,     BPM_COMMON.DATE_FMT)  ;        	
    r_aplcur.CUR_CONDUCT_VALIDITY_START	          :=	    to_date(p_cur_conduct_valid_start  ,     BPM_COMMON.DATE_FMT)       ;   	
    r_aplcur.CUR_CURRENT_TASK_ID                	:=	    p_cur_current_task_id               	;
    r_aplcur.CUR_INCIDENT_ABOUT	                  :=	    p_cur_incident_about                	;
    r_aplcur.CUR_INCIDENT_DESCRIPTION	            :=	    p_cur_incident_description	;
    --r_aplcur.CUR_INCIDENT_REASON	                :=	    p_cur_incident_reason               	;
    r_aplcur.CUR_INCIDENT_STATUS                	:=	    p_cur_incident_status               	;
    r_aplcur.CUR_INCIDENT_STATUS_DATE	            :=	    to_date( p_cur_incident_status_date,BPM_COMMON.DATE_FMT)	;
    r_aplcur.CUR_INSTANCE_STATUS	                :=	    p_cur_instance_status               	;
    r_aplcur.CUR_VALIDITY_PERFORMED_BY	          :=	    p_cur_validity_pb                       	;
    r_aplcur.GATHER_MISSING_INFO_PERFORM_BY	      :=	    p_gather_mi_pb                         	;
    r_aplcur.GATHER_MISSING_INFO_START	          :=	    to_date(p_gather_mi_start  ,     BPM_COMMON.DATE_FMT)   ;       	
    r_aplcur.GATHER_MISSING_INFORMATION_END	      :=	    to_date( p_gather_mi_end  ,     BPM_COMMON.DATE_FMT)  ;        	
    r_aplcur.GWF_APPEAL_INVALID	                  :=	    p_gwf_appeal_invalid                  	;
    r_aplcur.GWF_CHANGE_ELIGIBILITY	              :=	    p_gwf_change_elig                   	;
    r_aplcur.GWF_CHANNEL	                        :=	    p_gwf_channel                       	;
    r_aplcur.GWF_RESOLVED	                        :=	    p_gwf_resolved                      	;
    r_aplcur.GWF_SHOP_REVIEW	                    :=	    p_gwf_shop_review                   	;
    r_aplcur.GWF_VALID	                          :=	    p_gwf_valid                         	;
    r_aplcur.GWF_WITHDRAWN_IN_WRITING	            :=	    p_gwf_withdraw                      	;
    r_aplcur.HEARING_PROCESS_PERFORMED_BY	        :=	    p_conduct_hearing_pb               	;
    r_aplcur.INCIDENT_ID	                        :=	    p_incident_id                       	;
    r_aplcur.INCIDENT_TRACKING_NUMBER	            :=	    p_tracking_number                   	;
    r_aplcur.INCIDENT_TYPE	                      :=		  p_incident_type ;
    r_aplcur.INSTANCE_COMPLETE_DATE               :=	    to_date( p_instance_complete_date ,BPM_COMMON.DATE_FMT);	
    r_aplcur.CUR_COMPLETE_DATE                    :=	    to_date( p_complete_date ,BPM_COMMON.DATE_FMT);	
    r_aplcur.LAST_UPDATE_BY_NAME	                :=	    p_last_update_by_name               	;
    r_aplcur.LAST_UPDATE_DATE	                    :=	    to_date( p_last_update_date  ,BPM_COMMON.DATE_FMT);	
    r_aplcur.LINKED_CLIENT	                      :=	    p_linked_client                     	;
    r_aplcur.OTHER_PARTY_NAME	                    :=	    p_other_party_name                  	;
    r_aplcur.PRIORITY	                            :=	    p_priority                          	;
    r_aplcur.RECEIPT_DATE	                        :=	    to_date( p_receipt_date ,BPM_COMMON.DATE_FMT);	
    r_aplcur.REPORTED_BY	                        :=	    p_reported_by                       	;
    r_aplcur.REPORTER_RELATIONSHIP	              :=	    p_reporter_relationship             	;
    r_aplcur.RESOLUTION_DESCRIPTION             	:=	    p_resolution_description            	;
    r_aplcur.RESOLUTION_TYPE	                    :=	    p_resolution_type                   	;
    r_aplcur.REVIEW_APPEAL_END	                  :=	    to_date( p_review_apl_end   ,     BPM_COMMON.DATE_FMT)  ;	
    r_aplcur.REVIEW_APPEAL_START	                :=	    to_date(p_review_apl_start    ,     BPM_COMMON.DATE_FMT) ;         	
    r_aplcur.REVIEW_APPEALPERFORMED_BY	          :=	    p_review_apl_pb                     	;
    r_aplcur.SCHEDULE_HEARING_END	                :=	    to_date( p_sched_hearing_end   ,     BPM_COMMON.DATE_FMT)  ;        	
    r_aplcur.SCHEDULE_HEARING_PERFORMED_BY	      :=	    p_sched_hearing_pb                     	;
    r_aplcur.SCHEDULE_HEARING_START	              :=    	to_date(p_sched_hearing_start ,     BPM_COMMON.DATE_FMT)  ;        	
    r_aplcur.SHOP_DESK_REVIEW_INFO_END	          :=	    to_date( p_sd_review_end  ,     BPM_COMMON.DATE_FMT) ;         	
    r_aplcur.SHOP_DESK_REVIEW_INFO_PRFRM_BY	      :=	    p_sd_review_pb                         	;
    r_aplcur.SHOP_DESK_REVIEW_INFO_START	        :=	    to_date(p_sd_review_start ,     BPM_COMMON.DATE_FMT)    ;      	    
    r_aplcur.STATE_REVIEW_PERFORMED_BY	          :=	    p_conduct_st_review_pb             	;
    r_aplcur.VALIDITY_AMENDMENT_END	              :=	    to_date(p_valid_amend_end  ,     BPM_COMMON.DATE_FMT)  ;        	
    r_aplcur.VALIDITY_AMENDMENT_PERFORM_BY	      :=	    p_valid_amend_pb ;                       	
    r_aplcur.VALIDITY_AMENDMENT_START	            :=	    to_date(p_valid_amend_start  ,     BPM_COMMON.DATE_FMT)  ;        	
    r_aplcur.APPEAL_DATE	                        :=	    p_appeal_date	;
    r_aplcur.APPEAL_HEARING_LOCATION	            :=	    p_appeal_hearing_location	;
    r_aplcur.APPEAL_HEARING_TIME	                :=		  p_appeal_hearing_time;
    r_aplcur.APPELLANT_TYPE	                      :=		  p_appellant_type;
    r_aplcur.APPELLANT_TYPE_DESCRIPTION	          :=		  p_appellant_desc;
    r_aplcur.EXPECTED_APPEAL_REQUEST	            :=		  p_expected_appeal_req;
    r_aplcur.REQUESTED_HEARING_DAY	              :=		  p_requested_day;
    r_aplcur.REQUESTED_HEARING_TIME	              :=		  p_requested_time;
    r_aplcur.AID_TO_CONTINUE	                    :=		  p_aid_to_continue;
    
    r_aplcur.JEOPARDY_DAYS_TYPE                 	:=	    'C' ; --p_jeopardy_days_type 	;
    r_aplcur.SLA_JEOPARDY_DATE	                  :=	    GET_SLA_JEOPARDY_DATE(to_date( p_create_date,BPM_COMMON.DATE_FMT),p_incident_type);          
    r_aplcur.AGE_IN_BUSINESS_DAYS	                :=		  GET_AGE_IN_BUSINESS_DAYS(to_date(p_create_date, BPM_COMMON.DATE_FMT), to_date( p_complete_date, BPM_COMMON.DATE_FMT))	;
    r_aplcur.AGE_IN_CALENDAR_DAYS                	:=		  GET_AGE_IN_CALENDAR_DAYS(to_date(p_create_date, BPM_COMMON.DATE_FMT) ,to_date( p_complete_date, BPM_COMMON.DATE_FMT))	;    
    r_aplcur.APPEAL_TIMELINESS_STATUS	            :=		  GET_TIMELINESS_STATUS(to_date(p_create_date ,BPM_COMMON.DATE_FMT), NVL(to_date( p_sched_hearing_end, BPM_COMMON.DATE_FMT),to_date( p_complete_date, BPM_COMMON.DATE_FMT)), p_incident_type)	;    
    r_aplcur.JEOPARDY_FLAG	                      :=		  GET_JEOPARDY_STATUS(to_date(p_create_date, BPM_COMMON.DATE_FMT), to_date( p_complete_date, BPM_COMMON.DATE_FMT), p_incident_type)	;
    r_aplcur.SLA_JEOPARDY_DAYS                  	:=	    v_jeopardy_days      	;
    r_aplcur.SLA_TARGET_DAYS	                    :=	    v_timeliness_days    	;   
    r_aplcur.RECEIVED_DATE                        :=      to_date(p_received_date ,     BPM_COMMON.DATE_FMT)  ;
    r_aplcur.CURRENT_STEP                         :=      p_current_step;
    
    if p_set_type = 'INSERT' then
      insert into D_APPEALS_CURRENT
      values r_aplcur;
    elsif p_set_type = 'UPDATE' then
      begin
        update D_APPEALS_CURRENT
        set row = r_aplcur
        where APL_BI_ID = p_apl_bi_id;
      end;
    else
      v_log_message := 'Unexpected p_set_type value "' || p_set_type || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_apl_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(-20001,v_log_message);
    end if;
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_apl_bi_id,v_log_message,v_sql_code);
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
    v_new_data T_INS_APL_XML := null;
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
    v_start_date date := null;
    v_end_date date := null;
    v_daplin_id number := null;
    v_daplis_id number := null;
    --v_daples_id number := null;
    v_daplac_id number := null;
    v_daplia_id number := null;
    v_daplid_id number := null;
    --v_daplir_id number := null;
    v_daplcvpb_id number := null;
    v_faplbd_id number := null;
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
    
  begin
  
    if p_data_version > 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYHIX Process Appeals in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;
    
    GET_INS_APL_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.incident_id;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
    v_bi_id := SEQ_BI_ID.nextval;
   
   GET_DAPLIN_ID (v_identifier,v_bi_id,v_new_data.instance_status, v_daplin_id);
   GET_DAPLIS_ID (v_identifier,v_bi_id,v_new_data.incident_status, v_daplis_id);
   --GET_DAPLES_ID (v_identifier,v_bi_id,v_new_data.enrollment_status, v_daples_id);
   GET_DAPLAC_ID (v_identifier,v_bi_id,v_new_data.action_comments, v_daplac_id);
   GET_DAPLIA_ID (v_identifier,v_bi_id,v_new_data.incident_about,  v_daplia_id);
   GET_DAPLID_ID (v_identifier,v_bi_id,v_new_data.incident_description,  v_daplid_id);
   --GET_DAPLIR_ID (v_identifier,v_bi_id,v_new_data.incident_reason,  v_daplir_id);
   GET_DAPLCVPB_ID (v_identifier,v_bi_id,v_new_data.aspb_determine_valid,  v_daplcvpb_id);
   
      
   /*   v_sla_jeopardy_date      := GET_SLA_JEOPARDY_DATE(to_date( v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),v_new_data.INCIDENT_TYPE);   
      v_jeopardy_flag          := GET_JEOPARDY_STATUS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.INSTANCE_COMPLETE_DT,BPM_COMMON.DATE_FMT),v_new_data.INCIDENT_TYPE) ;         
      v_timeliness_status      := GET_TIMELINESS_STATUS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.INSTANCE_COMPLETE_DT,BPM_COMMON.DATE_FMT),v_new_data.INCIDENT_TYPE);                   
      v_sla_jeopardy_days      := v_jeopardy_days;  
      v_sla_target_days        := v_timeliness_days;  
      v_sla_days_type          := 'C';
      v_jeopardy_days_type     := 'C';
      v_age_in_business_days   := GET_AGE_IN_BUSINESS_DAYS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.INSTANCE_COMPLETE_DT,BPM_COMMON.DATE_FMT));    
      v_age_in_calendar_days   := GET_AGE_IN_CALENDAR_DAYS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.INSTANCE_COMPLETE_DT,BPM_COMMON.DATE_FMT));        
     */ 
      

    -- Insert current dimension and fact as a single transaction.
    begin
      commit;
      SET_DAPLCUR
        ('INSERT',v_identifier,v_bi_id,
          v_new_data.channel ,
          v_new_data.created_by_group ,
          v_new_data.created_by_name ,
          v_new_data.incident_id ,
          v_new_data.incident_type ,
          v_new_data.tracking_number ,
          v_new_data.create_dt ,
          v_new_data.receipt_dt ,
          v_new_data.incident_about ,
          --v_new_data.incident_reason ,
          v_new_data.incident_status_dt ,
          v_new_data.instance_complete_dt ,
          v_new_data.last_update_by_name ,
          v_new_data.last_update_by_dt ,
          v_new_data.reported_by ,
          v_new_data.reporter_relationship ,
          v_new_data.linked_client ,
          v_new_data.case_id ,     
          v_new_data.other_party_name ,
          v_new_data.instance_status ,
          v_new_data.incident_description ,
          v_new_data.incident_status ,
          v_new_data.priority ,
          v_new_data.about_plan_code ,
          v_new_data.about_plan_name ,
          v_new_data.about_provider_id ,
          v_new_data.about_provider_name ,
          v_new_data.action_comments ,
          v_new_data.action_type ,
          v_new_data.current_task_id ,
          v_new_data.resolution_description ,
          v_new_data.resolution_type ,
          v_new_data.cancel_by ,
          v_new_data.cancel_dt ,
          v_new_data.cancel_method ,
          v_new_data.cancel_reason ,
          v_new_data.assd_review_appeal ,
          v_new_data.ased_review_appeal ,
          v_new_data.aspb_review_appeal ,
          v_new_data.assd_determine_valid ,
          v_new_data.ased_determine_valid ,
          v_new_data.aspb_determine_valid ,
          v_new_data.assd_proc_valid_amend ,
          v_new_data.ased_proc_valid_amend ,
          v_new_data.aspb_proc_valid_amend ,
          v_new_data.assd_gather_miss_info ,
          v_new_data.ased_gather_miss_info ,
          v_new_data.aspb_gather_miss_info ,
          v_new_data.assd_shop_review ,
          v_new_data.ased_shop_review ,
          v_new_data.aspb_shop_review ,
          v_new_data.assd_schedule_hearing ,
          v_new_data.ased_schedule_hearing ,
          v_new_data.aspb_schedule_hearing ,
          v_new_data.assd_con_hearing_proc ,
          v_new_data.ased_con_hearing_proc ,
          v_new_data.aspb_con_hearing_proc ,
          v_new_data.assd_conduct_st_rev ,
          v_new_data.ased_conduct_st_rev ,
          v_new_data.aspb_conduct_st_rev ,
          v_new_data.assd_cancel_hearing ,
          v_new_data.ased_cancel_hearing ,
          v_new_data.aspb_cancel_hearing ,
          v_new_data.assd_advise_withdraw ,
          v_new_data.ased_advise_withdraw ,
          v_new_data.aspb_advise_withdraw ,
          v_new_data.gwf_channel ,
          v_new_data.gwf_appeal_invalid ,
          v_new_data.gwf_change_eligibility ,
          v_new_data.gwf_valid ,
          v_new_data.gwf_shop_review ,
          v_new_data.gwf_resolved ,
          v_new_data.gwf_withdrawn_in_writing ,
          v_new_data.asf_review_appeal ,
          v_new_data.asf_determine_valid ,
          v_new_data.asf_proc_valid_amend ,
          v_new_data.asf_gather_miss_info ,
          v_new_data.asf_shop_review ,
          v_new_data.asf_schedule_hearing ,
          v_new_data.asf_con_hearing_proc ,
          v_new_data.asf_conduct_st_rev ,
          v_new_data.asf_cancel_hearing ,
          v_new_data.asf_advise_withdraw ,
          v_new_data.appeal_hearing_dt ,
          v_new_data.appeal_dt ,
          v_new_data.appeal_hearing_location ,
          v_new_data.appeal_hearing_time ,
          v_new_data.appellant_type ,
          v_new_data.appellant_type_desc ,
          v_new_data.expected_request ,
          v_new_data.requested_day ,
          v_new_data.requested_time ,
          v_new_data.aid_to_continue,
          v_new_data.complete_dt,
          v_new_data.current_step,
          v_new_data.received_dt);

 
      INS_FAPLBD
        (v_identifier,v_start_date,v_end_date,v_bi_id,
          v_current_task_id,
          v_daplac_id,
          --v_daples_id,
          v_daplia_id,
          v_daplid_id,
          --v_daplir_id,
          v_daplis_id,
          v_daplin_id,
          v_daplcvpb_id,
          v_new_data.incident_status_dt ,
          v_new_data.assd_determine_valid,
          v_new_data.ased_determine_valid ,
          v_new_data.complete_dt,
          v_new_data.last_update_by_dt ,
          v_faplbd_id);
       
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
  
  
  -- Update fact for BPM Semantic model -ILEB Process Appeals.
  procedure UPD_FAPLBD
    (  p_identifier in varchar2,
       p_end_date in date,
       p_bi_id in number,
       p_current_task_id in number,
       p_daplac_id in number,
       --p_daples_id in number,
       p_daplia_id in number,
       p_daplid_id in number,
       --p_daplir_id in number,
       p_daplis_id in number,
       p_daplin_id in number,
       p_daplcvpb_id in number,
       p_incident_status_date in varchar2,
       p_stg_last_update_date in varchar2,
       p_complete_date in varchar2,       
       p_faplbd_id out number 
 )
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FAPLBD';
    v_sql_code number := null;
    v_log_message clob := null;
    v_faplbd_id_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;
   
    v_event_date date := null;
    v_daplin_id number := null;
    v_daplis_id number := null;
    --v_daples_id number := null;
    v_daplac_id number := null;
    v_daplia_id number := null;
    v_daplid_id number := null;
    --v_daplir_id number := null;
    v_daplcvpb_id number := null;
    v_incident_status_date date:= null;
    v_complete_date date := null;
    v_last_update_date date:= null;    
    r_faplbd F_APPEALS_BY_DATE%rowtype := null;
  begin    
    v_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
    v_event_date := v_last_update_date;
    v_incident_status_date := to_date(p_incident_status_date,BPM_COMMON.DATE_FMT);
    v_complete_date := to_date(p_complete_date,BPM_COMMON.DATE_FMT);
    --v_document_jeop_status_dt := sysdate;
    v_daplin_id := p_daplin_id;
    v_daplis_id  := p_daplis_id;
    --v_daples_id := p_daples_id;
    v_daplac_id := p_daplac_id;
    v_daplia_id := p_daplia_id;
    v_daplid_id := p_daplid_id;
    --v_daplir_id := p_daplir_id;
    v_daplcvpb_id := p_daplcvpb_id;
    with most_recent_fact_bi_id as
      (select
         max(FAPLBD_ID) max_faplbd_id,
         max(D_DATE) max_d_date
       from F_APPEALS_BY_DATE
       where APL_BI_ID = p_bi_id)
    select
      faplbd.FAPLBD_ID,
      faplbd.D_DATE,
      faplbd.CREATION_COUNT,
      faplbd.COMPLETION_COUNT,
      most_recent_fact_bi_id.max_d_date
    into
      v_faplbd_id_old,
      v_d_date_old,
      v_creation_count_old,
      v_completion_count_old,
      v_max_d_date
    from
      F_APPEALS_BY_DATE faplbd,
      most_recent_fact_bi_id
    where
      faplbd.FAPLBD_ID = max_faplbd_id
      and faplbd.D_DATE = most_recent_fact_bi_id.max_d_date;
    -- Do not modify fact table further once an instance has completed ever before.
    
    if v_completion_count_old >= 1 then
      return;
    end if;
    -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE.
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;
    if p_end_date is null then
      r_faplbd.D_DATE := v_event_date;
      r_faplbd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_faplbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_faplbd.INVENTORY_COUNT := 1;
      r_faplbd.COMPLETION_COUNT := 0;
    else
      -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
      if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then
        delete from F_APPEALS_BY_DATE
        where
          APL_BI_ID = p_bi_id
          and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
    with most_recent_fact_bi_id as
      (select
         max(FAPLBD_ID) max_faplbd_id,
         max(D_DATE) max_d_date
         from F_APPEALS_BY_DATE
         where APL_BI_ID = p_bi_id)
        select
          faplbd.FAPLBD_ID,
          faplbd.D_DATE,
          faplbd.CREATION_COUNT,
          faplbd.COMPLETION_COUNT,
          most_recent_fact_bi_id.max_d_date,
          faplbd.daplac_id,
          --faplbd.daples_id,
          faplbd.daplia_id,
          faplbd.daplid_id,
          --faplbd.daplir_id,
          faplbd.daplis_id,
          faplbd.daplin_id,
          faplbd.daplcvpb_id
          into
          v_faplbd_id_old,
          v_d_date_old,
          v_creation_count_old,
          v_completion_count_old,
          v_max_d_date,
          v_daplac_id,
          --v_daples_id,
          v_daplia_id,
          v_daplid_id,
          --v_daplir_id,
          v_daplis_id,
          v_daplin_id,
          v_daplcvpb_id
         from
          F_APPEALS_BY_DATE faplbd,
          most_recent_fact_bi_id
        where
          faplbd.FAPLBD_ID = max_faplbd_id
          and faplbd.D_DATE = most_recent_fact_bi_id.max_d_date;
      end if;
      r_faplbd.D_DATE := p_end_date;
      r_faplbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_faplbd.BUCKET_END_DATE := r_faplbd.BUCKET_START_DATE;
      r_faplbd.INVENTORY_COUNT := 0;
      r_faplbd.COMPLETION_COUNT := 1;
    end if;


    p_faplbd_id := SEQ_FAPLBD_ID.nextval;
    r_faplbd.FAPLBD_ID := p_faplbd_id;
    r_faplbd.APL_BI_ID := p_bi_id;
    r_faplbd.DAPLAC_ID := v_daplac_id;
    --r_faplbd.DAPLES_ID := v_dcmples_id;
    r_faplbd.DAPLIA_ID := v_daplia_id;
    r_faplbd.DAPLID_ID := v_daplid_id;
    r_faplbd.CREATION_COUNT := 0;
    --r_faplbd.DAPLIR_ID := v_daplir_id;
    r_faplbd.DAPLIS_ID := v_daplis_id;
    r_faplbd.DAPLIN_ID := v_daplin_id; 
    r_faplbd.DAPLCVPB_ID  := v_daplcvpb_id; 
    r_faplbd.INCIDENT_STATUS_DATE := v_incident_status_date;
    r_faplbd.COMPLETE_DATE := v_complete_date; --added 11/7
    --r_faplbd.LAST_UPDATE_DATE := v_last_update_by_dt;
    
      -- Validate fact date ranges.
    if r_faplbd.D_DATE < r_faplbd.BUCKET_START_DATE
      or to_date(to_char(r_faplbd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_faplbd.BUCKET_END_DATE
      or r_faplbd.BUCKET_START_DATE > r_faplbd.BUCKET_END_DATE
      or r_faplbd.BUCKET_END_DATE < r_faplbd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || r_faplbd.D_DATE || 
        ' BUCKET_START_DATE = ' || to_char(r_faplbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_faplbd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
    
    if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_faplbd.BUCKET_START_DATE then
      -- Same bucket time.
        if v_creation_count_old = 1 then
          r_faplbd.CREATION_COUNT := v_creation_count_old;
        end if;
        update F_APPEALS_BY_DATE
        set row = r_faplbd
        where FAPLBD_ID = v_faplbd_id_old;
    else
      -- Different bucket time.

      update F_APPEALS_BY_DATE
      set BUCKET_END_DATE = r_faplbd.BUCKET_START_DATE
      where FAPLBD_ID = v_faplbd_id_old;
      insert into F_APPEALS_BY_DATE
      values r_faplbd;
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
    v_old_data T_UPD_APL_XML := null;
    v_new_data T_UPD_APL_XML := null;
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
    v_start_date date := null;
    v_end_date date := null;
   v_daplin_id number := null;
    v_daplis_id number := null;
    --v_daples_id number := null;
    v_daplac_id number := null;
    v_daplia_id number := null;
    v_daplid_id number := null;
   -- v_daplir_id number := null;
    v_daplcvpb_id number := null;
    v_incident_status_date date:= null;    
    v_last_update_date date:= null;
    v_faplbd_id number := null;
    
         v_sla_days_type         varchar2(50) := null;
     v_sla_jeopardy_date     date := null;      
     v_sla_jeopardy_days     number := null;
     v_sla_target_days       number := null;                  
     v_age_in_business_days    number := null;          
     v_age_in_calendar_days    number := null;             
     v_jeopardy_days_type varchar2(50) := null;
    v_jeopardy_flag       varchar2(50) := null;                 
     v_timeliness_status   varchar2(50) := null;                 
  begin
  
    if p_data_version > 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYHIX Process Appeals in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;
    
    GET_UPD_APL_XML(p_old_data_xml,v_old_data);
    GET_UPD_APL_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.incident_id;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

    select APL_BI_ID 
    into v_bi_id
    from D_APPEALS_CURRENT
    where INCIDENT_ID = v_identifier;    
      
   GET_DAPLIN_ID (v_identifier,v_bi_id,v_new_data.instance_status, v_daplin_id);
   GET_DAPLIS_ID (v_identifier,v_bi_id,v_new_data.incident_status, v_daplis_id);
   --GET_DAPLES_ID (v_identifier,v_bi_id,v_new_data.enrollment_status, v_daples_id);
   GET_DAPLAC_ID (v_identifier,v_bi_id,v_new_data.action_comments, v_daplac_id);
   GET_DAPLIA_ID (v_identifier,v_bi_id,v_new_data.incident_about,  v_daplia_id);
   GET_DAPLID_ID (v_identifier,v_bi_id,v_new_data.incident_description,  v_daplid_id);
   --GET_DAPLIR_ID (v_identifier,v_bi_id,v_new_data.incident_reason,  v_daplir_id);
   GET_DAPLCVPB_ID (v_identifier,v_bi_id,v_new_data.aspb_determine_valid,  v_daplcvpb_id);

      
    /*  v_sla_jeopardy_date      := GET_SLA_JEOPARDY_DATE(to_date( v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),v_new_data.INCIDENT_TYPE);   
      v_jeopardy_flag          := GET_JEOPARDY_STATUS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.INSTANCE_COMPLETE_DT,BPM_COMMON.DATE_FMT),v_new_data.INCIDENT_TYPE) ;         
      v_timeliness_status      := GET_TIMELINESS_STATUS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.INSTANCE_COMPLETE_DT,BPM_COMMON.DATE_FMT),v_new_data.INCIDENT_TYPE);                   
      v_age_in_business_days   := GET_AGE_IN_BUSINESS_DAYS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.INSTANCE_COMPLETE_DT,BPM_COMMON.DATE_FMT));    
      v_age_in_calendar_days   := GET_AGE_IN_CALENDAR_DAYS(to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT),to_date(v_new_data.INSTANCE_COMPLETE_DT,BPM_COMMON.DATE_FMT));    
      v_sla_jeopardy_days      := v_jeopardy_days;  
      v_sla_target_days        := v_timeliness_days;                  
      v_sla_days_type          := 'C';
      v_jeopardy_days_type     := 'C';*/
      

      
    -- Update current dimension and fact as a single transaction.
    begin
      commit;
      SET_DAPLCUR
        ('UPDATE',v_identifier,v_bi_id,
                  v_new_data.channel ,
          v_new_data.created_by_group ,
          v_new_data.created_by_name ,
          v_new_data.incident_id ,
          v_new_data.incident_type ,
          v_new_data.tracking_number ,
          v_new_data.create_dt ,
          v_new_data.receipt_dt ,
          v_new_data.incident_about ,
          --v_new_data.incident_reason ,
          v_new_data.incident_status_dt ,
          v_new_data.instance_complete_dt ,
          v_new_data.last_update_by_name ,
          v_new_data.last_update_by_dt ,
          v_new_data.reported_by ,
          v_new_data.reporter_relationship ,
          v_new_data.linked_client ,
          v_new_data.case_id ,     
          v_new_data.other_party_name ,
          v_new_data.instance_status ,
          v_new_data.incident_description ,
          v_new_data.incident_status ,
          v_new_data.priority ,
          v_new_data.about_plan_code ,
          v_new_data.about_plan_name ,
          v_new_data.about_provider_id ,
          v_new_data.about_provider_name ,
          v_new_data.action_comments ,
          v_new_data.action_type ,
          v_new_data.current_task_id ,
          v_new_data.resolution_description ,
          v_new_data.resolution_type ,
          v_new_data.cancel_by ,
          v_new_data.cancel_dt ,
          v_new_data.cancel_method ,
          v_new_data.cancel_reason ,
          v_new_data.assd_review_appeal ,
          v_new_data.ased_review_appeal ,
          v_new_data.aspb_review_appeal ,
          v_new_data.assd_determine_valid ,
          v_new_data.ased_determine_valid ,
          v_new_data.aspb_determine_valid ,
          v_new_data.assd_proc_valid_amend ,
          v_new_data.ased_proc_valid_amend ,
          v_new_data.aspb_proc_valid_amend ,
          v_new_data.assd_gather_miss_info ,
          v_new_data.ased_gather_miss_info ,
          v_new_data.aspb_gather_miss_info ,
          v_new_data.assd_shop_review ,
          v_new_data.ased_shop_review ,
          v_new_data.aspb_shop_review ,
          v_new_data.assd_schedule_hearing ,
          v_new_data.ased_schedule_hearing ,
          v_new_data.aspb_schedule_hearing ,
          v_new_data.assd_con_hearing_proc ,
          v_new_data.ased_con_hearing_proc ,
          v_new_data.aspb_con_hearing_proc ,
          v_new_data.assd_conduct_st_rev ,
          v_new_data.ased_conduct_st_rev ,
          v_new_data.aspb_conduct_st_rev ,
          v_new_data.assd_cancel_hearing ,
          v_new_data.ased_cancel_hearing ,
          v_new_data.aspb_cancel_hearing ,
          v_new_data.assd_advise_withdraw ,
          v_new_data.ased_advise_withdraw ,
          v_new_data.aspb_advise_withdraw ,
          v_new_data.gwf_channel ,
          v_new_data.gwf_appeal_invalid ,
          v_new_data.gwf_change_eligibility ,
          v_new_data.gwf_valid ,
          v_new_data.gwf_shop_review ,
          v_new_data.gwf_resolved ,
          v_new_data.gwf_withdrawn_in_writing ,
          v_new_data.asf_review_appeal ,
          v_new_data.asf_determine_valid ,
          v_new_data.asf_proc_valid_amend ,
          v_new_data.asf_gather_miss_info ,
          v_new_data.asf_shop_review ,
          v_new_data.asf_schedule_hearing ,
          v_new_data.asf_con_hearing_proc ,
          v_new_data.asf_conduct_st_rev ,
          v_new_data.asf_cancel_hearing ,
          v_new_data.asf_advise_withdraw ,
          v_new_data.appeal_hearing_dt ,
          v_new_data.appeal_dt ,
          v_new_data.appeal_hearing_location ,
          v_new_data.appeal_hearing_time ,
          v_new_data.appellant_type ,
          v_new_data.appellant_type_desc ,
          v_new_data.expected_request ,
          v_new_data.requested_day ,
          v_new_data.requested_time ,
          v_new_data.aid_to_continue,
          v_new_data.complete_dt ,
          v_new_data.current_step,
          v_new_data.received_dt
         );
      UPD_FAPLBD
        (v_identifier,v_end_date,v_bi_id, v_new_data.current_task_id ,
          v_daplac_id ,
          --v_daples_id ,
          v_daplia_id ,
          v_daplid_id,
          --v_daplir_id,
          v_daplis_id,
          v_daplin_id,
          v_daplcvpb_id,
          v_new_data.incident_status_dt ,
          v_new_data.stg_last_update_date ,
          v_new_data.complete_dt,
          v_faplbd_id);
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
	