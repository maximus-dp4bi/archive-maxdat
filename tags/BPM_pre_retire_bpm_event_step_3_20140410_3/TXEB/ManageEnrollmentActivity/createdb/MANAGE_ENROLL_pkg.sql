alter session set plsql_code_type = native;

create or replace package maxdat.MANAGE_ENROLL as

 -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  procedure CALC_DMECUR;


  function GET_AGE_IN_BUSINESS_DAYS
      ( p_create_dt in date,
        p_complete_date in date
       )
  return number;

  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_dt in date,
     p_complete_date in date
     )
    return number;

function GET_SLA_DAYS
      (p_SLA_type in varchar2,
       p_NEWBORN_FLAG in varchar2
       )
  return number;

function GET_SLA_DAYS_TYPE
    (p_SLA_type in varchar2,
     p_newborn_flag in varchar2)
    return varchar2;

function GET_ENRL_FEE_REQ
    (p_ENROLL_FEE_AMNT_DUE in NUMBER)
    return varchar2;

 function GET_DAYS_TO_AA
    (p_AUTO_ASSIGNMENT_DUE_DATE in DATE,
     P_CREATE_DT DATE)
    return NUMBER;

function GET_TIMELY_STATUS
    (p_ASED          in DATE,
     P_CREATE_DT     in DATE,
     p_SLA_type      in varchar2,
     p_NEWBORN_FLAG  in varchar2
     )
    return varchar2;

function GET_FOLLOWUP_TYPE
    (P_FOLLOWUP_TYPE_CODE     in varchar2)
    return varchar2;

function GET_ENRL_ACTIVITY_OUTCOME
   (p_cancel_dt     in date,
    p_complete_dt   in date,
    p_slct_method   in varchar,
    p_cancel_reason in varchar
    )
    return varchar2;

/*
select '     '|| 'CEME_ID varchar2(100),' attr_element from dual
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
    BAST.BSL_ID = 14
    and ATC.TABLE_NAME = 'CORP_ETL_MANAGE_ENROLL'
  order by attr_element asc;
*/

type T_INS_ME_XML is record
    (
     AA_DUE_DT varchar2(19),
     AGE_IN_BUSINESS_DAYS varchar2(100),
     AGE_IN_CALENDAR_DAYS varchar2(100),
     ASED_AUTO_ASSIGN varchar2(19),
     ASED_FIRST_FOLLOWUP varchar2(19),
     ASED_FOURTH_FOLLOWUP varchar2(19),
     ASED_SECOND_FOLLOWUP varchar2(19),
     ASED_SELECTION_RECD varchar2(19),
     ASED_SEND_ENROLL_PACKET varchar2(19),
     ASED_THIRD_FOLLOWUP varchar2(19),
     ASED_WAIT_FOR_FEE varchar2(19),
     ASF_AUTO_ASSIGN varchar2(1),
     ASF_CANCEL_ENRL_ACTIVITY varchar2(1),
     ASF_FIRST_FOLLOWUP varchar2(1),
     ASF_FOURTH_FOLLOWUP varchar2(1),
     ASF_SECOND_FOLLOWUP varchar2(1),
     ASF_SELECTION_RECD varchar2(1),
     ASF_SEND_ENROLL_PACKET varchar2(1),
     ASF_THIRD_FOLLOWUP varchar2(1),
     ASF_WAIT_FOR_FEE varchar2(1),
     ASSD_AUTO_ASSIGN varchar2(19),
     ASSD_FIRST_FOLLOWUP varchar2(19),
     ASSD_FOURTH_FOLLOWUP varchar2(19),
     ASSD_SECOND_FOLLOWUP varchar2(19),
     ASSD_SELECTION_RECD varchar2(19),
     ASSD_SEND_ENROLL_PACKET varchar2(19),
     ASSD_THIRD_FOLLOWUP varchar2(19),
     ASSD_WAIT_FOR_FEE varchar2(19),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(20),
     CANCEL_REASON varchar2(100),
     CASE_ID varchar2(100),
     CEME_ID varchar2(100),
     CHIP_EMI_ID varchar2(100),
     CHIP_EMI_MAILED_DT varchar2(19),
     CHIP_HPC_ID varchar2(100),
     CHIP_HPC_MAILED_DT varchar2(19),
     CLIENT_CIN varchar2(32),
     CLIENT_ENROLL_STATUS_ID varchar2(100),
     CLIENT_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     COUNTY_CODE varchar2(32),
     CREATE_DT varchar2(19),
     ENRL_PACK_ID varchar2(100),
     ENRL_PACK_REQUEST_DT varchar2(19),
     ENROLLMENT_STATUS_CODE varchar2(32),
     ENROLLMENT_STATUS_DT varchar2(19),
     ENROLL_FEE_AMNT_DUE varchar2(100),
     ENROLL_FEE_AMNT_PAID varchar2(100),
     ENROLL_FEE_PAID_DT varchar2(19),
     FEE_PAID_FLG varchar2(1),
     FIRST_FOLLOWUP_ID varchar2(100),
     FIRST_FOLLOWUP_TYPE_CODE varchar2(40),
     FOURTH_FOLLOWUP_ID varchar2(37),
     FOURTH_FOLLOWUP_TYPE_CODE varchar2(40),
     GENERIC_FIELD_1 varchar2(50),
     GENERIC_FIELD_2 varchar2(50),
     GENERIC_FIELD_3 varchar2(50),
     GENERIC_FIELD_4 varchar2(50),
     GENERIC_FIELD_5 varchar2(50),
     GWF_ENRL_PACK_REQ varchar2(1),
     GWF_FIRST_FOLLOWUP_REQ varchar2(1),
     GWF_FOURTH_FOLLOWUP_REQ varchar2(1),
     GWF_REQUIRED_FEE_PAID varchar2(1),
     GWF_SECOND_FOLLOWUP_REQ varchar2(1),
     GWF_THIRD_FOLLOWUP_REQ varchar2(1),
     INSTANCE_STATUS varchar2(10),
     NEWBORN_FLG varchar2(1),
     PLAN_TYPE varchar2(32),
     PROGRAM_TYPE varchar2(32),
     SECOND_FOLLOWUP_ID varchar2(100),
     SECOND_FOLLOWUP_TYPE_CODE varchar2(40),
     SERVICE_AREA varchar2(32),
     SLCT_AUTO_PROC varchar2(1),
     SLCT_CREATE_BY_NAME varchar2(80),
     SLCT_CREATE_DT varchar2(19),
     SLCT_LAST_UPDATE_BY_NAME varchar2(80),
     SLCT_LAST_UPDATE_DT varchar2(19),
     SLCT_METHOD varchar2(32),
     STG_LAST_UPDATE_DATE varchar2(19),
     SUBPROGRAM_TYPE varchar2(32),
     THIRD_FOLLOWUP_ID varchar2(37),
     THIRD_FOLLOWUP_TYPE_CODE varchar2(40),
     ZIP_CODE varchar2(32)
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
    BAST.BSL_ID = 14
    and atc.TABLE_NAME = 'CORP_ETL_MANAGE_ENROLL'
order by attr_element asc;
*/

type T_UPD_ME_XML is record
    (
          AA_DUE_DT varchar2(19),
     AGE_IN_BUSINESS_DAYS varchar2(100),
     AGE_IN_CALENDAR_DAYS varchar2(100),
     ASED_AUTO_ASSIGN varchar2(19),
     ASED_FIRST_FOLLOWUP varchar2(19),
     ASED_FOURTH_FOLLOWUP varchar2(19),
     ASED_SECOND_FOLLOWUP varchar2(19),
     ASED_SELECTION_RECD varchar2(19),
     ASED_SEND_ENROLL_PACKET varchar2(19),
     ASED_THIRD_FOLLOWUP varchar2(19),
     ASED_WAIT_FOR_FEE varchar2(19),
     ASF_AUTO_ASSIGN varchar2(1),
     ASF_CANCEL_ENRL_ACTIVITY varchar2(1),
     ASF_FIRST_FOLLOWUP varchar2(1),
     ASF_FOURTH_FOLLOWUP varchar2(1),
     ASF_SECOND_FOLLOWUP varchar2(1),
     ASF_SELECTION_RECD varchar2(1),
     ASF_SEND_ENROLL_PACKET varchar2(1),
     ASF_THIRD_FOLLOWUP varchar2(1),
     ASF_WAIT_FOR_FEE varchar2(1),
     ASSD_AUTO_ASSIGN varchar2(19),
     ASSD_FIRST_FOLLOWUP varchar2(19),
     ASSD_FOURTH_FOLLOWUP varchar2(19),
     ASSD_SECOND_FOLLOWUP varchar2(19),
     ASSD_SELECTION_RECD varchar2(19),
     ASSD_SEND_ENROLL_PACKET varchar2(19),
     ASSD_THIRD_FOLLOWUP varchar2(19),
     ASSD_WAIT_FOR_FEE varchar2(19),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(20),
     CANCEL_REASON varchar2(100),
     CASE_ID varchar2(100),
     CHIP_EMI_ID varchar2(100),
     CHIP_EMI_MAILED_DT varchar2(19),
     CHIP_HPC_ID varchar2(100),
     CHIP_HPC_MAILED_DT varchar2(19),
     CLIENT_CIN varchar2(32),
     CLIENT_ENROLL_STATUS_ID varchar2(100),
     CLIENT_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     COUNTY_CODE varchar2(32),
     CREATE_DT varchar2(19),
     ENRL_PACK_ID varchar2(100),
     ENRL_PACK_REQUEST_DT varchar2(19),
     ENROLLMENT_STATUS_CODE varchar2(32),
     ENROLLMENT_STATUS_DT varchar2(19),
     ENROLL_FEE_AMNT_DUE varchar2(100),
     ENROLL_FEE_AMNT_PAID varchar2(100),
     ENROLL_FEE_PAID_DT varchar2(19),
     FEE_PAID_FLG varchar2(1),     
     FIRST_FOLLOWUP_ID varchar2(100),
     FIRST_FOLLOWUP_TYPE_CODE varchar2(40),
     FOURTH_FOLLOWUP_ID varchar2(37),
     FOURTH_FOLLOWUP_TYPE_CODE varchar2(40),
     GENERIC_FIELD_1 varchar2(50),
     GENERIC_FIELD_2 varchar2(50),
     GENERIC_FIELD_3 varchar2(50),
     GENERIC_FIELD_4 varchar2(50),
     GENERIC_FIELD_5 varchar2(50),
     GWF_ENRL_PACK_REQ varchar2(1),
     GWF_FIRST_FOLLOWUP_REQ varchar2(1),
     GWF_FOURTH_FOLLOWUP_REQ varchar2(1),
     GWF_REQUIRED_FEE_PAID varchar2(1),
     GWF_SECOND_FOLLOWUP_REQ varchar2(1),
     GWF_THIRD_FOLLOWUP_REQ varchar2(1),
     INSTANCE_STATUS varchar2(10),
     NEWBORN_FLG varchar2(1),
     PLAN_TYPE varchar2(32),
     PROGRAM_TYPE varchar2(32),
     SECOND_FOLLOWUP_ID varchar2(100),
     SECOND_FOLLOWUP_TYPE_CODE varchar2(40),
     SERVICE_AREA varchar2(32),
     SLCT_AUTO_PROC varchar2(1),
     SLCT_CREATE_BY_NAME varchar2(80),
     SLCT_CREATE_DT varchar2(19),
     SLCT_LAST_UPDATE_BY_NAME varchar2(80),
     SLCT_LAST_UPDATE_DT varchar2(19),
     SLCT_METHOD varchar2(32),
     STG_LAST_UPDATE_DATE varchar2(19),
     SUBPROGRAM_TYPE varchar2(32),     
     THIRD_FOLLOWUP_ID varchar2(37),
     THIRD_FOLLOWUP_TYPE_CODE varchar2(40),
     ZIP_CODE varchar2(32)
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
create or replace package body maxdat.MANAGE_ENROLL as

  v_bem_id number := 14; -- 'Manage Enrollment'
  v_bil_id number := 14; -- 'Client Enroll Status ID'
  v_bsl_id number := 14; -- 'CORP_ETL_MANAGE_ENROLL'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';

  v_calc_dmecur_job_name varchar2(30) := 'CALC_DPICUR';

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

   function GET_SLA_DAYS
    (p_SLA_type in varchar2,
     p_newborn_flag in varchar2)
    return number
  as
     v_SLA_days number := null;
  begin

    select sla.sla_days
    into v_SLA_days
    from Rule_lkup_mng_enrl_sla sla
    where sla_type = p_SLA_type
    and newborn_flag = p_newborn_flag;

     return v_SLA_days;
  end;

  function GET_SLA_DAYS_TYPE
    (p_SLA_type in varchar2,
     p_newborn_flag in varchar2)
    return varchar2
  as
     v_SLA_days_type varchar2(1) := null;
  begin

    select sla.sla_days_type
    into v_SLA_days_type
    from Rule_lkup_mng_enrl_sla sla
    where sla_type = p_SLA_type
    and newborn_flag = p_newborn_flag;

     return v_SLA_days_type;
  end;

 function GET_ENRL_FEE_REQ
    (p_ENROLL_FEE_AMNT_DUE in NUMBER)
    return varchar2
  AS
    v_ENRL_FEE_REQ VARCHAR2(1);
  BEGIN

    select case when p_ENROLL_FEE_AMNT_DUE > 0 THEN 'Y'
                WHEN p_ENROLL_FEE_AMNT_DUE >= 0 THEN 'N'
           end
     into v_ENRL_FEE_REQ
     from dual;

     return v_ENRL_FEE_REQ;
  END;

function GET_DAYS_TO_AA
    (p_auto_assignment_due_date in date,
     p_create_dt in date)
    return number
  as
    v_days_to_aa number := null;
  begin

    if p_auto_assignment_due_date is not null then
      v_days_to_aa := p_auto_assignment_due_date - p_create_dt;
    end if;

    return trunc(v_days_to_aa);
  end;

  function GET_TIMELY_STATUS
    (p_ASED          in DATE,
     P_CREATE_DT     in DATE,
     p_SLA_type      in varchar2,
     p_newborn_flag  in varchar2
     )
    return varchar2
  AS
    v_AA_TIMELY_STATUS varchar2(10):=null;
    v_SLA_days_type    varchar2(1) := null; 
    v_SLA_days         number      := null;
    
  BEGIN
    
    v_SLA_days_type := GET_SLA_DAYS_TYPE(p_SLA_type, p_newborn_flag);
    v_SLA_days      := GET_SLA_DAYS(p_SLA_type, p_newborn_flag);

    select case when p_ASED is null then 'NA'
                when p_ASED is not null and v_SLA_days_type = 'C' and trunc(p_ASED-p_CREATE_DT) <= v_SLA_days then 'Timely'
                when p_ASED is not null and v_SLA_days_type = 'B' and GET_AGE_IN_BUSINESS_DAYS(p_CREATE_DT, p_ASED) <= v_SLA_days then 'Timely'
           else 'Untimely'
           end
      into v_AA_TIMELY_STATUS
     from dual;

     return v_AA_TIMELY_STATUS;
  END;

  function GET_FOLLOWUP_TYPE
    (P_FOLLOWUP_TYPE_CODE     in varchar2)
    return varchar2
  AS
    v_FOLLOWUP_TYPE varchar2(200);
  BEGIN

     select case when P_FOLLOWUP_TYPE_CODE is not null
                 then (select distinct FU.FOLLOWUP_TYPE
                         from Rule_Lkup_Mng_Enrl_Followup FU
                         where FU.FOLLOWUP_TYPE_CODE = P_FOLLOWUP_TYPE_CODE
                         )
                    else null end
      into v_FOLLOWUP_TYPE
      from dual;

     return v_FOLLOWUP_TYPE;
  END;

  function GET_ENRL_ACTIVITY_OUTCOME
   (p_cancel_dt     in date,
    p_complete_dt   in date,
    p_slct_method   in varchar,
    p_cancel_reason in varchar
    )
    return varchar2
   as
     v_ENRL_ACTIVITY_OUTCOME varchar2(200) := null;

   begin
     select case when p_cancel_dt is null and p_complete_dt is not null and p_slct_method = 'Auto-Assigned' then 'Enrolled - AutoAssign'
                 when p_cancel_dt is null and p_complete_dt is not null and p_slct_method in ('Phone','Mail','Fax','Online') then 'Enrolled - Selections Received'
                 when p_cancel_dt is not null and p_complete_dt is not null and p_cancel_reason = 'No longer eligible' then 'Loss of Eligibility'
                 when p_cancel_dt is not null and p_complete_dt is not null and p_cancel_reason = 'New Enrollment Packet Required' then 'New Packet Required'
                 when p_cancel_dt is not null and p_complete_dt is not null and p_cancel_reason = 'Failed to Pay' then 'Failed to Pay Enroll Fee'
                 else null
             end
      into v_ENRL_ACTIVITY_OUTCOME
      from dual;

      return v_ENRL_ACTIVITY_OUTCOME;
    end;


-- Calculate column values in BPM Semantic table D_ME_CURRENT.
  procedure CALC_DMECUR
/*
This procedure calculates the semantic layer attributes.
*/
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DMECUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin


update D_ME_CURRENT
    set
      Age_In_Business_Days          = GET_AGE_IN_BUSINESS_DAYS( create_dt, COMPLETE_DATE),
      Age_In_Calendar_Days          = GET_AGE_IN_CALENDAR_DAYS( create_dt, COMPLETE_DATE),
      AUTO_ASSIGN_SLA_DAYS          = GET_SLA_DAYS('AUTO_ASSIGNMENT',  NEWBORN_FLG),
      AUTO_ASSIGN_SLA_DAYS_TYPE     = GET_SLA_DAYS_TYPE('AUTO_ASSIGNMENT',  NEWBORN_FLG),
      ENROLL_PACKET_SLA_DAYS        = GET_SLA_DAYS('ENROLLMENT_PACKET',  NEWBORN_FLG),
      ENROLL_PACKET_SLA_DAYS_TYPE   = GET_SLA_DAYS_TYPE('ENROLLMENT_PACKET',  NEWBORN_FLG),
      FIRST_FOLLOWUP_SLA_DAYS       = GET_SLA_DAYS('FIRST_FOLLOWUP',  NEWBORN_FLG),
      FIRST_FOLLOWUP_SLA_DAYS_TYPE  = GET_SLA_DAYS_TYPE('FIRST_FOLLOWUP',  NEWBORN_FLG),
      SECOND_FOLLOWUP_SLA_DAYS      = GET_SLA_DAYS('SECOND_FOLLOWUP',  NEWBORN_FLG),
      SECOND_FOLLOWUP_SLA_DAYS_TYPE = GET_SLA_DAYS_TYPE('SECOND_FOLLOWUP',  NEWBORN_FLG),
      THIRD_FOLLOWUP_SLA_DAYS       = GET_SLA_DAYS('THIRD_FOLLOWUP',  NEWBORN_FLG),
      THIRD_FOLLOWUP_SLA_DAYS_TYPE  = GET_SLA_DAYS_TYPE('THIRD_FOLLOWUP',  NEWBORN_FLG),
      FOURTH_FOLLOWUP_SLA_DAYS      = GET_SLA_DAYS('FOURTH_FOLLOWUP',  NEWBORN_FLG),
      FOURTH_FOLLOWUP_SLA_DAYS_TYPE = GET_SLA_DAYS_TYPE('FOURTH_FOLLOWUP',  NEWBORN_FLG),
      ENROLLMENT_FEE_REQUIRED       = GET_ENRL_FEE_REQ( ENROLL_FEE_AMNT_DUE),
      DAYS_TO_AUTO_ASSIGNMENT       = GET_Days_to_AA( AUTO_ASSIGNMENT_DUE_DATE, CREATE_DT)
    where COMPLETE_DATE is null
      and CANCEL_ENROLL_ACTIVITY_DATE is null;

    v_num_rows_updated := sql%rowcount;

 commit;

     v_log_message := v_num_rows_updated  || ' D_ME_CURRENT rows updated with calculated attributes by CALC_DMECUR.';
     BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,null);

   exception

     when others then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);

  end CALC_DMECUR;


  -- Get dimension ID for BPM Semantic model - Manage Enrollment Activity - Enrollment Status Code.
  procedure GET_DMESC_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_enroll_status_code in varchar2,
      p_DMESC_ID out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DMESC_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin

     select DMESC_ID
     into p_DMESC_ID
     from D_ME_ENRL_STATUS_CODE
     where
       Enrollment_Status_Code = p_enroll_status_code
       or (Enrollment_Status_Code is null and p_enroll_status_code is null);

   exception

     when NO_DATA_FOUND then

       p_DMESC_ID := SEQ_DMESC_ID.nextval;
       begin
         insert into D_ME_ENRL_STATUS_CODE (DMESC_ID, Enrollment_Status_Code)
         values (p_DMESC_ID,p_enroll_status_code);
         commit;

       exception

         when DUP_VAL_ON_INDEX then
           select DMESC_ID into p_DMESC_ID
           from D_ME_ENRL_STATUS_CODE
           where
             Enrollment_Status_Code = p_enroll_status_code
             or (Enrollment_Status_Code is null and p_enroll_status_code is null);

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

  end GET_DMESC_ID;

-- Get record for Manage Enroll insert XML.
  procedure GET_INS_ME_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_ME_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_ME_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
/*
select '      extractValue(p_data_xml,''/ROWSET/ROW/CEME_ID'') "' || 'CEME_ID'|| '",' attr_element from dual
    union
    select '      extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
    union
    select '      extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
    from BPM_ATTRIBUTE_STAGING_TABLE bast
    inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
    where
      BAST.BSL_ID = 14
      and atc.TABLE_NAME = 'CORP_ETL_MANAGE_ENROLL'
      order by attr_element asc;
*/
    select
      extractValue(p_data_xml,'/ROWSET/ROW/AA_DUE_DT') "AA_DUE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_BUSINESS_DAYS') "AGE_IN_BUSINESS_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_CALENDAR_DAYS') "AGE_IN_CALENDAR_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_AUTO_ASSIGN') "ASED_AUTO_ASSIGN",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_FIRST_FOLLOWUP') "ASED_FIRST_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_FOURTH_FOLLOWUP') "ASED_FOURTH_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_SECOND_FOLLOWUP') "ASED_SECOND_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_SELECTION_RECD') "ASED_SELECTION_RECD",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_SEND_ENROLL_PACKET') "ASED_SEND_ENROLL_PACKET",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_THIRD_FOLLOWUP') "ASED_THIRD_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_WAIT_FOR_FEE') "ASED_WAIT_FOR_FEE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_AUTO_ASSIGN') "ASF_AUTO_ASSIGN",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CANCEL_ENRL_ACTIVITY') "ASF_CANCEL_ENRL_ACTIVITY",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_FIRST_FOLLOWUP') "ASF_FIRST_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_FOURTH_FOLLOWUP') "ASF_FOURTH_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_SECOND_FOLLOWUP') "ASF_SECOND_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_SELECTION_RECD') "ASF_SELECTION_RECD",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_SEND_ENROLL_PACKET') "ASF_SEND_ENROLL_PACKET",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_THIRD_FOLLOWUP') "ASF_THIRD_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_WAIT_FOR_FEE') "ASF_WAIT_FOR_FEE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_AUTO_ASSIGN') "ASSD_AUTO_ASSIGN",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_FIRST_FOLLOWUP') "ASSD_FIRST_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_FOURTH_FOLLOWUP') "ASSD_FOURTH_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_SECOND_FOLLOWUP') "ASSD_SECOND_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_SELECTION_RECD') "ASSD_SELECTION_RECD",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_SEND_ENROLL_PACKET') "ASSD_SEND_ENROLL_PACKET",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_THIRD_FOLLOWUP') "ASSD_THIRD_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_WAIT_FOR_FEE') "ASSD_WAIT_FOR_FEE",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CEME_ID') "CEME_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHIP_EMI_ID') "CHIP_EMI_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHIP_EMI_MAILED_DT') "CHIP_EMI_MAILED_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CHIP_HPC_ID') "CHIP_HPC_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHIP_HPC_MAILED_DT') "CHIP_HPC_MAILED_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_CIN') "CLIENT_CIN",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ENROLL_STATUS_ID') "CLIENT_ENROLL_STATUS_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/COUNTY_CODE') "COUNTY_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/ENRL_PACK_ID') "ENRL_PACK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ENRL_PACK_REQUEST_DT') "ENRL_PACK_REQUEST_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLLMENT_STATUS_CODE') "ENROLLMENT_STATUS_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLLMENT_STATUS_DT') "ENROLLMENT_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLL_FEE_AMNT_DUE') "ENROLL_FEE_AMNT_DUE",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLL_FEE_AMNT_PAID') "ENROLL_FEE_AMNT_PAID",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLL_FEE_PAID_DT') "ENROLL_FEE_PAID_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/FEE_PAID_FLG') "FEE_PAID_FLG",
      extractValue(p_data_xml,'/ROWSET/ROW/FIRST_FOLLOWUP_ID') "FIRST_FOLLOWUP_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/FIRST_FOLLOWUP_TYPE_CODE') "FIRST_FOLLOWUP_TYPE_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/FOURTH_FOLLOWUP_ID') "FOURTH_FOLLOWUP_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/FOURTH_FOLLOWUP_TYPE_CODE') "FOURTH_FOLLOWUP_TYPE_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD_1') "GENERIC_FIELD_1",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD_2') "GENERIC_FIELD_2",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD_3') "GENERIC_FIELD_3",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD_4') "GENERIC_FIELD_4",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD_5') "GENERIC_FIELD_5",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_ENRL_PACK_REQ') "GWF_ENRL_PACK_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_FIRST_FOLLOWUP_REQ') "GWF_FIRST_FOLLOWUP_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_FOURTH_FOLLOWUP_REQ') "GWF_FOURTH_FOLLOWUP_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_REQUIRED_FEE_PAID') "GWF_REQUIRED_FEE_PAID",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_SECOND_FOLLOWUP_REQ') "GWF_SECOND_FOLLOWUP_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_THIRD_FOLLOWUP_REQ') "GWF_THIRD_FOLLOWUP_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/NEWBORN_FLG') "NEWBORN_FLG",
      extractValue(p_data_xml,'/ROWSET/ROW/PLAN_TYPE') "PLAN_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PROGRAM_TYPE') "PROGRAM_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/SECOND_FOLLOWUP_ID') "SECOND_FOLLOWUP_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/SECOND_FOLLOWUP_TYPE_CODE') "SECOND_FOLLOWUP_TYPE_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/SERVICE_AREA') "SERVICE_AREA",
      extractValue(p_data_xml,'/ROWSET/ROW/SLCT_AUTO_PROC') "SLCT_AUTO_PROC",
      extractValue(p_data_xml,'/ROWSET/ROW/SLCT_CREATE_BY_NAME') "SLCT_CREATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/SLCT_CREATE_DT') "SLCT_CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SLCT_LAST_UPDATE_BY_NAME') "SLCT_LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/SLCT_LAST_UPDATE_DT') "SLCT_LAST_UPDATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SLCT_METHOD') "SLCT_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/SUBPROGRAM_TYPE') "SUBPROGRAM_TYPE",      
      extractValue(p_data_xml,'/ROWSET/ROW/THIRD_FOLLOWUP_ID') "THIRD_FOLLOWUP_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/THIRD_FOLLOWUP_TYPE_CODE') "THIRD_FOLLOWUP_TYPE_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/ZIP_CODE') "ZIP_CODE"
       into p_data_record
       from dual;

     exception

       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
         raise;

  end GET_INS_ME_XML;

 -- Get record for Manage Enroll update XML.
  procedure GET_UPD_ME_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_ME_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_ME_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
/*
select '      extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
    union
    select '      extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
    from BPM_ATTRIBUTE_STAGING_TABLE bast
    inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
    where
      BAST.BSL_ID = 14
      and atc.TABLE_NAME = 'CORP_ETL_MANAGE_ENROLL'
    order by attr_element asc;
*/
     select
      extractValue(p_data_xml,'/ROWSET/ROW/AA_DUE_DT') "AA_DUE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_BUSINESS_DAYS') "AGE_IN_BUSINESS_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_CALENDAR_DAYS') "AGE_IN_CALENDAR_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_AUTO_ASSIGN') "ASED_AUTO_ASSIGN",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_FIRST_FOLLOWUP') "ASED_FIRST_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_FOURTH_FOLLOWUP') "ASED_FOURTH_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_SECOND_FOLLOWUP') "ASED_SECOND_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_SELECTION_RECD') "ASED_SELECTION_RECD",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_SEND_ENROLL_PACKET') "ASED_SEND_ENROLL_PACKET",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_THIRD_FOLLOWUP') "ASED_THIRD_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_WAIT_FOR_FEE') "ASED_WAIT_FOR_FEE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_AUTO_ASSIGN') "ASF_AUTO_ASSIGN",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CANCEL_ENRL_ACTIVITY') "ASF_CANCEL_ENRL_ACTIVITY",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_FIRST_FOLLOWUP') "ASF_FIRST_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_FOURTH_FOLLOWUP') "ASF_FOURTH_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_SECOND_FOLLOWUP') "ASF_SECOND_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_SELECTION_RECD') "ASF_SELECTION_RECD",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_SEND_ENROLL_PACKET') "ASF_SEND_ENROLL_PACKET",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_THIRD_FOLLOWUP') "ASF_THIRD_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_WAIT_FOR_FEE') "ASF_WAIT_FOR_FEE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_AUTO_ASSIGN') "ASSD_AUTO_ASSIGN",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_FIRST_FOLLOWUP') "ASSD_FIRST_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_FOURTH_FOLLOWUP') "ASSD_FOURTH_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_SECOND_FOLLOWUP') "ASSD_SECOND_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_SELECTION_RECD') "ASSD_SELECTION_RECD",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_SEND_ENROLL_PACKET') "ASSD_SEND_ENROLL_PACKET",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_THIRD_FOLLOWUP') "ASSD_THIRD_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_WAIT_FOR_FEE') "ASSD_WAIT_FOR_FEE",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHIP_EMI_ID') "CHIP_EMI_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHIP_EMI_MAILED_DT') "CHIP_EMI_MAILED_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CHIP_HPC_ID') "CHIP_HPC_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHIP_HPC_MAILED_DT') "CHIP_HPC_MAILED_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_CIN') "CLIENT_CIN",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ENROLL_STATUS_ID') "CLIENT_ENROLL_STATUS_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/COUNTY_CODE') "COUNTY_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/ENRL_PACK_ID') "ENRL_PACK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ENRL_PACK_REQUEST_DT') "ENRL_PACK_REQUEST_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLLMENT_STATUS_CODE') "ENROLLMENT_STATUS_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLLMENT_STATUS_DT') "ENROLLMENT_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLL_FEE_AMNT_DUE') "ENROLL_FEE_AMNT_DUE",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLL_FEE_AMNT_PAID') "ENROLL_FEE_AMNT_PAID",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLL_FEE_PAID_DT') "ENROLL_FEE_PAID_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/FEE_PAID_FLG') "FEE_PAID_FLG",
      extractValue(p_data_xml,'/ROWSET/ROW/FIRST_FOLLOWUP_ID') "FIRST_FOLLOWUP_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/FIRST_FOLLOWUP_TYPE_CODE') "FIRST_FOLLOWUP_TYPE_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/FOURTH_FOLLOWUP_ID') "FOURTH_FOLLOWUP_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/FOURTH_FOLLOWUP_TYPE_CODE') "FOURTH_FOLLOWUP_TYPE_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD_1') "GENERIC_FIELD_1",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD_2') "GENERIC_FIELD_2",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD_3') "GENERIC_FIELD_3",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD_4') "GENERIC_FIELD_4",
      extractValue(p_data_xml,'/ROWSET/ROW/GENERIC_FIELD_5') "GENERIC_FIELD_5",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_ENRL_PACK_REQ') "GWF_ENRL_PACK_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_FIRST_FOLLOWUP_REQ') "GWF_FIRST_FOLLOWUP_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_FOURTH_FOLLOWUP_REQ') "GWF_FOURTH_FOLLOWUP_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_REQUIRED_FEE_PAID') "GWF_REQUIRED_FEE_PAID",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_SECOND_FOLLOWUP_REQ') "GWF_SECOND_FOLLOWUP_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_THIRD_FOLLOWUP_REQ') "GWF_THIRD_FOLLOWUP_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/NEWBORN_FLG') "NEWBORN_FLG",
      extractValue(p_data_xml,'/ROWSET/ROW/PLAN_TYPE') "PLAN_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/PROGRAM_TYPE') "PROGRAM_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/SECOND_FOLLOWUP_ID') "SECOND_FOLLOWUP_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/SECOND_FOLLOWUP_TYPE_CODE') "SECOND_FOLLOWUP_TYPE_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/SERVICE_AREA') "SERVICE_AREA",
      extractValue(p_data_xml,'/ROWSET/ROW/SLCT_AUTO_PROC') "SLCT_AUTO_PROC",
      extractValue(p_data_xml,'/ROWSET/ROW/SLCT_CREATE_BY_NAME') "SLCT_CREATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/SLCT_CREATE_DT') "SLCT_CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SLCT_LAST_UPDATE_BY_NAME') "SLCT_LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/SLCT_LAST_UPDATE_DT') "SLCT_LAST_UPDATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/SLCT_METHOD') "SLCT_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/SUBPROGRAM_TYPE') "SUBPROGRAM_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/THIRD_FOLLOWUP_ID') "THIRD_FOLLOWUP_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/THIRD_FOLLOWUP_TYPE_CODE') "THIRD_FOLLOWUP_TYPE_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/ZIP_CODE') "ZIP_CODE"
     into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
      raise;

  end GET_UPD_ME_XML;

 -- Insert fact for BPM Semantic model - Manage Enroll process.
    procedure INS_FMEBD
    (p_identifier in varchar2,
     p_start_date in date,
     p_end_date in date,
     p_bi_id in number,
     p_DMESC_ID  in number,
     p_enrollment_status_date in varchar2,
     p_fmebd_id out number)
   as
         v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FMEBD';
         v_sql_code number := null;
         v_log_message clob := null;
         v_bucket_start_date date := null;
         v_bucket_end_date date := null;
         v_enrollment_status_date date := null;
    begin

      v_enrollment_status_date := to_date(p_enrollment_status_date, BPM_COMMON.DATE_FMT);
      p_fmebd_id := SEQ_FMEBD_ID.nextval;

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

       insert into F_ME_BY_DATE
        (
    FMEBD_ID,
	  D_DATE,
	  BUCKET_START_DATE,
	  BUCKET_END_DATE,
    ME_BI_ID,
	  DMESC_ID,
	  INVENTORY_COUNT,
	  CREATION_COUNT,
	  COMPLETION_COUNT,
	  Enrollment_Status_Date)
	values
	( p_fmebd_id,
	  p_start_date,
	  v_bucket_start_date,
	  v_bucket_end_date,
	  p_bi_id,
	  p_DMESC_ID,
	  case
	  when p_end_date is null then 1
	  else 0
	  end,
	  1,
	  case
	    when p_end_date is null then 0
	    else 1
	    end,
	 v_enrollment_status_date
	 );
      exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      raise;

  end INS_FMEBD;

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

    v_new_data T_INS_ME_XML := null;

  begin

  if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for ILEB DPY Manage Enrollment Activity in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;

    GET_INS_ME_XML(p_new_data_xml,v_new_data);

    v_bi_id := SEQ_BI_ID.nextval;
    v_identifier := v_new_data.CLIENT_ENROLL_STATUS_ID ;
    v_start_date := to_date(v_new_data.CREATE_DT, BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

  insert into BPM_INSTANCE
      (BI_ID,BEM_ID,IDENTIFIER,BIL_ID,BSL_ID,
       START_DATE,END_DATE,SOURCE_ID,CREATION_DATE,LAST_UPDATE_DATE)
    values
      (v_bi_id,v_bem_id,v_identifier,v_bil_id,v_bsl_id,
       v_start_date,v_end_date,to_char(v_new_data.CEME_ID),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT));

    commit;
  v_bue_id := SEQ_BUE_ID.nextval;

    insert into BPM_UPDATE_EVENT
      (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
    values
      (v_bue_id,v_bi_id,v_butl_id,to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),'N');

BPM_EVENT.INSERT_BIA(v_bi_id,1773,1,v_new_data.CLIENT_ENROLL_STATUS_ID,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1741,1,v_new_data.CLIENT_ID,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1742,3,v_new_data.CREATE_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1743,1,v_new_data.CASE_ID,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1774,2,v_new_data.CLIENT_CIN,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1744,2,v_new_data.NEWBORN_FLG,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1775,2,v_new_data.SERVICE_AREA,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1747,2,v_new_data.COUNTY_CODE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1776,2,v_new_data.ZIP_CODE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1777,2,v_new_data.ENROLLMENT_STATUS_CODE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1778,3,v_new_data.ENROLLMENT_STATUS_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1779,3,v_new_data.AA_DUE_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1693,1,v_new_data.ENRL_PACK_ID,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1694,3,v_new_data.ENRL_PACK_REQUEST_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1695,1,v_new_data.ENROLL_FEE_AMNT_DUE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1696,1,v_new_data.ENROLL_FEE_AMNT_PAID,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1697,3,v_new_data.ENROLL_FEE_PAID_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,2181,2,v_new_data.FEE_PAID_FLG,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1698,1,v_new_data.CHIP_HPC_ID,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1699,3,v_new_data.CHIP_HPC_MAILED_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1700,1,v_new_data.CHIP_EMI_ID,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1701,3,v_new_data.CHIP_EMI_MAILED_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1702,2,v_new_data.PLAN_TYPE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1703,2,v_new_data.PROGRAM_TYPE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,2182,2,v_new_data.SUBPROGRAM_TYPE,v_start_date,v_bue_id);

BPM_EVENT.INSERT_BIA(v_bi_id,1704,2,v_new_data.SLCT_METHOD,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1705,2,v_new_data.SLCT_CREATE_BY_NAME,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1706,3,v_new_data.SLCT_CREATE_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1707,2,v_new_data.SLCT_LAST_UPDATE_BY_NAME,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1708,3,v_new_data.SLCT_LAST_UPDATE_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1709,2,v_new_data.SLCT_AUTO_PROC,v_start_date,v_bue_id);

BPM_EVENT.INSERT_BIA(v_bi_id,1710,2,v_new_data.GENERIC_FIELD_1,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1711,2,v_new_data.GENERIC_FIELD_2,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1712,2,v_new_data.GENERIC_FIELD_3,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1713,2,v_new_data.GENERIC_FIELD_4,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1714,2,v_new_data.GENERIC_FIELD_5,v_start_date,v_bue_id);

BPM_EVENT.INSERT_BIA(v_bi_id,1715,3,v_new_data.ASSD_SELECTION_RECD,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1716,3,v_new_data.ASED_SELECTION_RECD,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1717,3,v_new_data.ASSD_SEND_ENROLL_PACKET,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1718,3,v_new_data.ASED_SEND_ENROLL_PACKET,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1719,2,v_new_data.FIRST_FOLLOWUP_ID,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1720,2,v_new_data.FIRST_FOLLOWUP_TYPE_CODE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1721,3,v_new_data.ASSD_FIRST_FOLLOWUP,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1722,3,v_new_data.ASED_FIRST_FOLLOWUP,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1723,2,v_new_data.SECOND_FOLLOWUP_ID,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1724,2,v_new_data.SECOND_FOLLOWUP_TYPE_CODE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1725,3,v_new_data.ASSD_SECOND_FOLLOWUP,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1726,3,v_new_data.ASED_SECOND_FOLLOWUP,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1727,2,v_new_data.THIRD_FOLLOWUP_ID,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1728,2,v_new_data.THIRD_FOLLOWUP_TYPE_CODE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1729,3,v_new_data.ASSD_THIRD_FOLLOWUP,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1730,3,v_new_data.ASED_THIRD_FOLLOWUP,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1731,2,v_new_data.FOURTH_FOLLOWUP_ID,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1732,2,v_new_data.FOURTH_FOLLOWUP_TYPE_CODE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1733,3,v_new_data.ASSD_FOURTH_FOLLOWUP,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1734,3,v_new_data.ASED_FOURTH_FOLLOWUP,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1735,3,v_new_data.ASSD_AUTO_ASSIGN,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1736,3,v_new_data.ASED_AUTO_ASSIGN,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1737,3,v_new_data.ASSD_WAIT_FOR_FEE,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1738,3,v_new_data.ASED_WAIT_FOR_FEE,v_start_date,v_bue_id);

BPM_EVENT.INSERT_BIA(v_bi_id,1748, 2,v_new_data.INSTANCE_STATUS,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1749,3,v_new_data.COMPLETE_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1739,3,v_new_data.CANCEL_DT,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1750,2,v_new_data.CANCEL_REASON,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1751,2,v_new_data.CANCEL_METHOD,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1740,2,v_new_data.CANCEL_BY,v_start_date,v_bue_id);
--BPM_EVENT.INSERT_BIA(v_bi_id,1746,1,v_new_data.AGE_IN_CALENDAR_DAYS,v_start_date,v_bue_id);
--BPM_EVENT.INSERT_BIA(v_bi_id,1745,1,v_new_data.AGE_IN_BUSINESS_DAYS,v_start_date,v_bue_id);

--ASF flags
BPM_EVENT.INSERT_BIA(v_bi_id,1752,2,v_new_data.asf_send_enroll_packet,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1753,2,v_new_data.asf_selection_recd,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1754,2,v_new_data.asf_first_followup,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1755,2,v_new_data.asf_second_followup,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1756,2,v_new_data.asf_third_followup,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1757,2,v_new_data.asf_fourth_followup,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1758,2,v_new_data.asf_auto_assign,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1759,2,v_new_data.asf_wait_for_fee,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1766,2,v_new_data.asf_cancel_enrl_activity,v_start_date,v_bue_id);

--GWF flags
BPM_EVENT.INSERT_BIA(v_bi_id,1760,2,v_new_data.gwf_enrl_pack_req,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1761,2,v_new_data.gwf_first_followup_req,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1762,2,v_new_data.gwf_second_followup_req,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1763,2,v_new_data.gwf_third_followup_req,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1764,2,v_new_data.gwf_fourth_followup_req,v_start_date,v_bue_id);
BPM_EVENT.INSERT_BIA(v_bi_id,1765,2,v_new_data.gwf_required_fee_paid,v_start_date,v_bue_id);

commit;

        p_bue_id := v_bue_id;

      exception

        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);

  end;

 -- Insert or update dimension for BPM Semantic model - Manage Enrollment Activity - Current.
  procedure SET_DMECUR
  (p_set_type 			 in     varchar2,
   p_identifier                  in     varchar2,
   p_bi_id                       in     number,
p_CLIENT_ENROLL_STATUS_ID    in  varchar2, --corp_etl_manage_enroll.CLIENT_ENROLL_STATUS_ID%type,
p_CLIENT_ID                  in  varchar2, --corp_etl_manage_enroll.CLIENT_ID%type,
p_CREATE_DT   		           in	 varchar2, --corp_etl_manage_enroll.CREATE_DT%type,
p_CASE_ID                    in	 varchar2, --corp_etl_manage_enroll.CASE_ID%type,
p_CLIENT_CIN   			         in  varchar2, --corp_etl_manage_enroll.CLIENT_CIN%type,
p_NEWBORN_FLG                in	 varchar2, --corp_etl_manage_enroll.NEWBORN_FLG%type,
p_SERVICE_AREA               in	 varchar2, --corp_etl_manage_enroll.SERVICE_AREA%type,
p_COUNTY_CODE                in	 varchar2, --corp_etl_manage_enroll.COUNTY_CODE%type,
p_ZIP_CODE                   in	 varchar2, --corp_etl_manage_enroll.ZIP_CODE%type,
p_ENROLLMENT_STATUS_CODE     in	 varchar2, --corp_etl_manage_enroll.ENROLLMENT_STATUS_CODE%type,
p_ENROLLMENT_STATUS_DT       in	 varchar2, --corp_etl_manage_enroll.ENROLLMENT_STATUS_DT%type,
p_AA_DUE_DT                  in	 varchar2, --corp_etl_manage_enroll.AA_DUE_DT%type,
p_ENRL_PACK_ID               in	 varchar2, --corp_etl_manage_enroll.ENRL_PACK_ID%type,
p_ENRL_PACK_REQUEST_DT       in	 varchar2, --corp_etl_manage_enroll.ENRL_PACK_REQUEST_DT%type,
p_ENROLL_FEE_AMNT_DUE        in	 varchar2, --corp_etl_manage_enroll.ENROLL_FEE_AMNT_DUE%type,
p_ENROLL_FEE_AMNT_PAID       in	 varchar2, --corp_etl_manage_enroll.ENROLL_FEE_AMNT_PAID%type,
p_ENROLL_FEE_PAID_DT         in	 varchar2, --corp_etl_manage_enroll.ENROLL_FEE_PAID_DT%type,
p_FEE_PAID_FLG               in	 varchar2, --corp_etl_manage_enroll.FEE_PAID_FLG%type,
p_CHIP_HPC_ID                in	 varchar2, --corp_etl_manage_enroll.CHIP_HPC_ID%type,
p_CHIP_HPC_MAILED_DT         in	 varchar2, --corp_etl_manage_enroll.CHIP_HPC_MAILED_DT%type,
p_CHIP_EMI_ID                in	 varchar2, --corp_etl_manage_enroll.CHIP_EMI_ID%type,
p_CHIP_EMI_MAILED_DT         in	 varchar2, --corp_etl_manage_enroll.CHIP_EMI_MAILED_DT%type,
p_PLAN_TYPE                  in	 varchar2, --corp_etl_manage_enroll.PLAN_TYPE%type,
p_PROGRAM_TYPE               in	 varchar2, --corp_etl_manage_enroll.PROGRAM_TYPE%type,
p_SUBPROGRAM_TYPE            in	 varchar2, --corp_etl_manage_enroll.SUBPROGRAM_TYPE%type,
p_SLCT_METHOD                in	 varchar2, --corp_etl_manage_enroll.SLCT_METHOD%type,
p_SLCT_CREATE_BY_NAME        in	 varchar2, --corp_etl_manage_enroll.SLCT_CREATE_BY_NAME%type,
p_SLCT_CREATE_DT             in	 varchar2, --corp_etl_manage_enroll.SLCT_CREATE_DT%type,
p_SLCT_LAST_UPDATE_BY_NAME   in	 varchar2, --corp_etl_manage_enroll.SLCT_LAST_UPDATE_BY_NAME%type,
p_SLCT_LAST_UPDATE_DT        in	 varchar2, --corp_etl_manage_enroll.SLCT_LAST_UPDATE_DT%type,
p_SLCT_AUTO_PROC             in	 varchar2, --corp_etl_manage_enroll.SLCT_AUTO_PROC%type,
--
p_ASSD_SELECTION_RECD       in		 varchar2, --corp_etl_manage_enroll.ASSD_SELECTION_RECD%type,
p_ASED_SELECTION_RECD       in		 varchar2, --corp_etl_manage_enroll.ASED_SELECTION_RECD%type,
p_ASSD_SEND_ENROLL_PACKET   in	   varchar2, --corp_etl_manage_enroll.ASSD_SEND_ENROLL_PACKET%type,
p_ASED_SEND_ENROLL_PACKET   in	   varchar2, --corp_etl_manage_enroll.ASED_SEND_ENROLL_PACKET%type,
p_FIRST_FOLLOWUP_ID         in		 varchar2, --corp_etl_manage_enroll.FIRST_FOLLOWUP_ID%type,
p_FIRST_FOLLOWUP_TYPE_CODE  in		 varchar2, --corp_etl_manage_enroll.FIRST_FOLLOWUP_TYPE_CODE%type,
p_ASSD_FIRST_FOLLOWUP       in		 varchar2, --corp_etl_manage_enroll.ASSD_FIRST_FOLLOWUP%type,
p_ASED_FIRST_FOLLOWUP       in		 varchar2, --corp_etl_manage_enroll.ASED_FIRST_FOLLOWUP%type,
p_SECOND_FOLLOWUP_ID        in		 varchar2, --corp_etl_manage_enroll.SECOND_FOLLOWUP_ID%type,
p_SECOND_FOLLOWUP_TYPE_CODE in		 varchar2, --corp_etl_manage_enroll.SECOND_FOLLOWUP_TYPE_CODE%type,
p_ASSD_SECOND_FOLLOWUP      in		 varchar2, --corp_etl_manage_enroll.ASSD_SECOND_FOLLOWUP%type,
p_ASED_SECOND_FOLLOWUP      in		 varchar2, --corp_etl_manage_enroll.ASED_SECOND_FOLLOWUP%type,
p_THIRD_FOLLOWUP_ID         in		 varchar2, --corp_etl_manage_enroll.THIRD_FOLLOWUP_ID%type,
p_THIRD_FOLLOWUP_TYPE_CODE  in		 varchar2, --corp_etl_manage_enroll.THIRD_FOLLOWUP_TYPE_CODE%type,
p_ASSD_THIRD_FOLLOWUP       in		 varchar2, --corp_etl_manage_enroll.ASSD_THIRD_FOLLOWUP%type,
p_ASED_THIRD_FOLLOWUP       in		 varchar2, --corp_etl_manage_enroll.ASED_THIRD_FOLLOWUP%type,
p_FOURTH_FOLLOWUP_ID        in		 varchar2, --corp_etl_manage_enroll.FOURTH_FOLLOWUP_ID%type,
p_FOURTH_FOLLOWUP_TYPE_CODE in		 varchar2, --corp_etl_manage_enroll.FOURTH_FOLLOWUP_TYPE_CODE%type,
p_ASSD_FOURTH_FOLLOWUP      in		 varchar2, --corp_etl_manage_enroll.ASSD_FOURTH_FOLLOWUP%type,
p_ASED_FOURTH_FOLLOWUP      in		 varchar2, --corp_etl_manage_enroll.ASED_FOURTH_FOLLOWUP%type,
p_ASSD_AUTO_ASSIGN          in		 varchar2, --corp_etl_manage_enroll.ASSD_AUTO_ASSIGN%type,
p_ASED_AUTO_ASSIGN          in		 varchar2, --corp_etl_manage_enroll.ASED_AUTO_ASSIGN%type,
p_ASSD_WAIT_FOR_FEE         in		 varchar2, --corp_etl_manage_enroll.ASSD_WAIT_FOR_FEE%type,
p_ASED_WAIT_FOR_FEE         in	   varchar2, --corp_etl_manage_enroll.ASED_WAIT_FOR_FEE%type,
---
p_ASF_CANCEL_ENRL_ACTIVITY in	 varchar2, --corp_etl_manage_enroll.ASF_CANCEL_ENRL_ACTIVITY%type,
p_ASF_SEND_ENROLL_PACKET   in	 varchar2, --corp_etl_manage_enroll.ASF_SEND_ENROLL_PACKET%type,
p_ASF_SELECTION_RECD       in	 varchar2, --corp_etl_manage_enroll.ASF_SELECTION_RECD%type,
p_ASF_FIRST_FOLLOWUP       in	 varchar2, --corp_etl_manage_enroll.ASF_FIRST_FOLLOWUP%type,
p_ASF_SECOND_FOLLOWUP      in	 varchar2, --corp_etl_manage_enroll.ASF_SECOND_FOLLOWUP%type,
p_ASF_THIRD_FOLLOWUP       in	 varchar2, --corp_etl_manage_enroll.ASF_THIRD_FOLLOWUP%type,
p_ASF_FOURTH_FOLLOWUP      in	 varchar2, --corp_etl_manage_enroll.ASF_FOURTH_FOLLOWUP%type,
p_ASF_AUTO_ASSIGN          in	 varchar2, --corp_etl_manage_enroll.ASF_AUTO_ASSIGN%type,
p_ASF_WAIT_FOR_FEE         in	 varchar2, --corp_etl_manage_enroll.ASF_WAIT_FOR_FEE%type,

p_GWF_ENRL_PACK_REQ       in	 varchar2, --corp_etl_manage_enroll.GWF_ENRL_PACK_REQ%type,
p_GWF_FIRST_FOLLOWUP_REQ  in	 varchar2, --corp_etl_manage_enroll.GWF_FIRST_FOLLOWUP_REQ%type,
p_GWF_SECOND_FOLLOWUP_REQ in	 varchar2, --corp_etl_manage_enroll.GWF_SECOND_FOLLOWUP_REQ%type,
p_GWF_THIRD_FOLLOWUP_REQ  in	 varchar2, --corp_etl_manage_enroll.GWF_THIRD_FOLLOWUP_REQ%type,
p_GWF_FOURTH_FOLLOWUP_REQ in	 varchar2, --corp_etl_manage_enroll.GWF_FOURTH_FOLLOWUP_REQ%type,
p_GWF_REQUIRED_FEE_PAID   in	 varchar2, --corp_etl_manage_enroll.GWF_REQUIRED_FEE_PAID%type,
---
p_GENERIC_FIELD_1   in		 varchar2, --corp_etl_manage_enroll.GENERIC_FIELD_1%type,
p_GENERIC_FIELD_2   in		 varchar2, --corp_etl_manage_enroll.GENERIC_FIELD_2%type,
p_GENERIC_FIELD_3   in		 varchar2, --corp_etl_manage_enroll.GENERIC_FIELD_3%type,
p_GENERIC_FIELD_4   in		 varchar2, --corp_etl_manage_enroll.GENERIC_FIELD_4%type,
p_GENERIC_FIELD_5   in		 varchar2, --corp_etl_manage_enroll.GENERIC_FIELD_5%type,
---
p_INSTANCE_STATUS        in		varchar2, --corp_etl_manage_enroll.INSTANCE_STATUS%type,
p_COMPLETE_DT            in		varchar2, --corp_etl_manage_enroll.COMPLETE_DT%type,
p_CANCEL_DT              in 	varchar2, --corp_etl_manage_enroll.CANCEL_DT%type,
p_CANCEL_REASON          in 	varchar2, --corp_etl_manage_enroll.CANCEL_REASON%type,
p_CANCEL_METHOD          in   varchar2, --corp_etl_manage_enroll.CANCEL_METHOD%type,
p_CANCEL_BY              in 	varchar2 --corp_etl_manage_enroll.CANCEL_BY%type,
 )
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DMECUR';
       v_sql_code number := null;
       v_log_message clob := null;
       r_dmecur D_ME_CURRENT%rowtype := null;
       v_jeopardy_flag varchar2(1) := null;
  begin

r_dmecur.ME_BI_ID                      := p_bi_id;
r_dmecur.CLIENT_ENROLL_STATUS_ID       := p_CLIENT_ENROLL_STATUS_ID;
r_dmecur.CLIENT_ID                     := p_CLIENT_ID;
r_dmecur.CREATE_DT                     := to_date(p_CREATE_DT,BPM_COMMON.DATE_FMT);
r_dmecur.CASE_ID                       := p_CASE_ID;
r_dmecur.CLIENT_CIN                    := p_CLIENT_CIN;
r_dmecur.NEWBORN_FLG                   := p_NEWBORN_FLG;
r_dmecur.SERVICE_AREA                  := p_SERVICE_AREA;
r_dmecur.COUNTY_CODE                   := p_COUNTY_CODE;
r_dmecur.ZIP_CODE                      := p_ZIP_CODE;
r_dmecur.CUR_ENROLLMENT_STATUS_CODE    := p_ENROLLMENT_STATUS_CODE;
r_dmecur.CUR_ENROLLMENT_STATUS_DATE    := to_date(p_ENROLLMENT_STATUS_DT,BPM_COMMON.DATE_FMT);
r_dmecur.AUTO_ASSIGNMENT_DUE_DATE      := to_date(p_AA_DUE_DT,BPM_COMMON.DATE_FMT);
r_dmecur.ENRL_PACKET_REQUEST_ID        := p_ENRL_PACK_ID;
r_dmecur.ENRL_PACKET_REQUEST_DATE      := to_date(p_ENRL_PACK_REQUEST_DT,BPM_COMMON.DATE_FMT);
r_dmecur.ENROLL_FEE_AMNT_DUE           := p_ENROLL_FEE_AMNT_DUE;
r_dmecur.ENROLL_FEE_AMNT_PAID          := p_ENROLL_FEE_AMNT_PAID;
r_dmecur.ENROLL_FEE_RECVD_DATE         := to_date(p_ENROLL_FEE_PAID_DT,BPM_COMMON.DATE_FMT);
r_dmecur.FEE_PAID_FLG                  := p_FEE_PAID_FLG;
r_dmecur.CHIP_PLAN_CHANGE_NOTICE_ID    := p_CHIP_HPC_ID;
r_dmecur.CHIP_PLAN_CHANGE_MAILED_DATE  := to_date(p_CHIP_HPC_MAILED_DT,BPM_COMMON.DATE_FMT);
r_dmecur.CHIP_ENROLL_MI_NOTICE_ID      := p_CHIP_EMI_ID;
r_dmecur.CHIP_ENROLL_MI_SENT_DATE      := to_date(p_CHIP_EMI_MAILED_DT,BPM_COMMON.DATE_FMT);
r_dmecur.PLAN_TYPE                     := p_PLAN_TYPE;
r_dmecur.PROGRAM_TYPE                  := p_PROGRAM_TYPE;
r_dmecur.SUBPROGRAM_TYPE               := p_SUBPROGRAM_TYPE;
r_dmecur.SELECTION_METHOD              := p_SLCT_METHOD;
r_dmecur.SELECTION_CREATED_BY_NAME     := p_SLCT_CREATE_BY_NAME;
r_dmecur.SELECTION_CREATE_DATE         := to_date(p_SLCT_CREATE_DT,BPM_COMMON.DATE_FMT);
r_dmecur.SELECTION_LAST_UPD_BY_NAME    := p_SLCT_LAST_UPDATE_BY_NAME;
r_dmecur.SELECTION_LAST_UPDATE_DATE    := to_date(p_SLCT_LAST_UPDATE_DT,BPM_COMMON.DATE_FMT);
r_dmecur.SELECTION_AUTO_PROCESSED      := p_SLCT_AUTO_PROC;
r_dmecur.GENERIC_FIELD_1                 :=  p_GENERIC_FIELD_1;
r_dmecur.GENERIC_FIELD_2                 :=  p_GENERIC_FIELD_2;
r_dmecur.GENERIC_FIELD_3                 :=  p_GENERIC_FIELD_3;
r_dmecur.GENERIC_FIELD_4                 :=  p_GENERIC_FIELD_4;
r_dmecur.GENERIC_FIELD_5                 :=  p_GENERIC_FIELD_5;
----
r_dmecur.VALID_SLCN_RECEIVED_START_DATE   := to_date(p_ASSD_SELECTION_RECD,BPM_COMMON.DATE_FMT);
r_dmecur.VALID_SLCN_RECEIVED_END_DATE     := to_date(p_ASED_SELECTION_RECD,BPM_COMMON.DATE_FMT);
r_dmecur.SEND_ENROLL_PKT_START_DATE       := to_date(p_ASSD_SEND_ENROLL_PACKET,BPM_COMMON.DATE_FMT);
r_dmecur.SEND_ENROLL_PKT_END_DATE         := to_date(p_ASED_SEND_ENROLL_PACKET,BPM_COMMON.DATE_FMT);
r_dmecur.FIRST_FOLLOW_UP_ID               := p_FIRST_FOLLOWUP_ID;
r_dmecur.FIRST_FOLLOW_UP_TYPE_CODE        := p_FIRST_FOLLOWUP_TYPE_CODE;
r_dmecur.FIRST_FOLLOW_UP_START_DATE       := to_date(p_ASSD_FIRST_FOLLOWUP,BPM_COMMON.DATE_FMT);
r_dmecur.FIRST_FOLLOW_UP_END_DATE         := to_date(p_ASED_FIRST_FOLLOWUP,BPM_COMMON.DATE_FMT);
r_dmecur.SECOND_FOLLOW_UP_ID              := p_SECOND_FOLLOWUP_ID;
r_dmecur.SECOND_FOLLOW_UP_TYPE_CODE       := p_SECOND_FOLLOWUP_TYPE_CODE;
r_dmecur.SECOND_FOLLOW_UP_START_DATE      := to_date(p_ASSD_SECOND_FOLLOWUP,BPM_COMMON.DATE_FMT);
r_dmecur.SECOND_FOLLOW_UP_END_DATE        := to_date(p_ASED_SECOND_FOLLOWUP,BPM_COMMON.DATE_FMT);
r_dmecur.THIRD_FOLLOW_UP_ID               := p_THIRD_FOLLOWUP_ID;
r_dmecur.THIRD_FOLLOW_UP_TYPE_CODE        := p_THIRD_FOLLOWUP_TYPE_CODE;
r_dmecur.THIRD_FOLLOW_UP_START_DATE       := to_date(p_ASSD_THIRD_FOLLOWUP,BPM_COMMON.DATE_FMT);
r_dmecur.THIRD_FOLLOW_UP_END_DATE         := to_date(p_ASED_THIRD_FOLLOWUP,BPM_COMMON.DATE_FMT);
r_dmecur.FOURTH_FOLLOW_UP_ID              := p_FOURTH_FOLLOWUP_ID;
r_dmecur.FOURTH_FOLLOW_UP_TYPE_CODE       := p_FOURTH_FOLLOWUP_TYPE_CODE;
r_dmecur.FOURTH_FOLLOW_UP_START_DATE      := to_date(p_ASSD_FOURTH_FOLLOWUP,BPM_COMMON.DATE_FMT);
r_dmecur.FOURTH_FOLLOW_UP_END_DATE        := to_date(p_ASED_FOURTH_FOLLOWUP,BPM_COMMON.DATE_FMT);
r_dmecur.AUTO_ASSIGN_START_DATE           := to_date(p_ASSD_AUTO_ASSIGN,BPM_COMMON.DATE_FMT);
r_dmecur.AUTO_ASSIGN_END_DATE             := to_date(p_ASED_AUTO_ASSIGN,BPM_COMMON.DATE_FMT);
r_dmecur.WAIT_ENROLL_FEE_START_DATE       := to_date(p_ASSD_WAIT_FOR_FEE,BPM_COMMON.DATE_FMT);
r_dmecur.WAIT_ENROLL_FEE_END_DATE         := to_date(p_ASED_WAIT_FOR_FEE,BPM_COMMON.DATE_FMT);
r_dmecur.INSTANCE_STATUS                   := p_INSTANCE_STATUS;
r_dmecur.COMPLETE_DATE                     := to_date(p_COMPLETE_DT,BPM_COMMON.DATE_FMT);
r_dmecur.CANCEL_ENROLL_ACTIVITY_DATE       := to_date(p_CANCEL_DT,BPM_COMMON.DATE_FMT);
r_dmecur.CANCEL_REASON                    := p_CANCEL_REASON;
r_dmecur.CANCEL_METHOD                    := p_CANCEL_METHOD;
r_dmecur.CANCELLED_BY   			            := p_CANCEL_BY;
-----ASF Flags (NINE)
r_dmecur.CANCEL_ENRL_ACTIVITY_FLAG   :=  p_asf_cancel_enrl_activity;
r_dmecur.SEND_ENROLL_PACKET_FLAG     :=  p_ASF_SEND_ENROLL_PACKET;
r_dmecur.SELECTIONS_RECEIVED_FLAG    :=  p_ASF_SELECTION_RECD;
r_dmecur.FIRST_FOLLOW_UP_COMP_FLAG   :=  p_ASF_FIRST_FOLLOWUP;
r_dmecur.SECOND_FOLLOW_UP_COMP_FLAG  :=  p_ASF_SECOND_FOLLOWUP;
r_dmecur.THIRD_FOLLOW_UP_COMP_FLAG   :=  p_ASF_THIRD_FOLLOWUP;
r_dmecur.FOURTH_FOLLOW_UP_COMP_FLAG  :=  p_ASF_FOURTH_FOLLOWUP;
r_dmecur.AUTO_ASSIGN_FLAG            :=  p_ASF_AUTO_ASSIGN;
r_dmecur.WAIT_FOR_FEE_FLAG           :=  p_ASF_WAIT_FOR_FEE;
-----GWF Flags(SIX)
r_dmecur.ENROLL_PACKET_REQUIRED_FLAG :=  p_GWF_ENRL_PACK_REQ;
r_dmecur.FIRST_FOLLOW_UP_REQ_FLAG    :=  p_GWF_FIRST_FOLLOWUP_REQ;
r_dmecur.SECOND_FOLLOW_UP_REQ_FLAG   :=  p_GWF_SECOND_FOLLOWUP_REQ;
r_dmecur.THIRD_FOLLOW_UP_REQ_FLAG    :=  p_GWF_THIRD_FOLLOWUP_REQ;
r_dmecur.FOURTH_FOLLOW_UP_REQ_FLAG   :=  p_GWF_FOURTH_FOLLOWUP_REQ;
r_dmecur.REQ_FEE_PAID_FLAG           :=  p_GWF_REQUIRED_FEE_PAID;
----Semantic Layer Attributes(25).
r_dmecur.AGE_IN_BUSINESS_DAYS          := GET_AGE_IN_BUSINESS_DAYS(to_date(p_create_dt,BPM_COMMON.DATE_FMT),to_date(p_COMPLETE_DT,BPM_COMMON.DATE_FMT));
r_dmecur.AGE_IN_CALENDAR_DAYS          := GET_AGE_IN_CALENDAR_DAYS(to_date(p_create_dt,BPM_COMMON.DATE_FMT),to_date(p_COMPLETE_DT,BPM_COMMON.DATE_FMT));
r_dmecur.AUTO_ASSIGN_SLA_DAYS               :=  GET_SLA_DAYS('AUTO_ASSIGNMENT', p_NEWBORN_FLG);
r_dmecur.AUTO_ASSIGN_SLA_DAYS_TYPE          :=  GET_SLA_DAYS_TYPE('AUTO_ASSIGNMENT', p_NEWBORN_FLG);
r_dmecur.ENROLL_PACKET_SLA_DAYS             :=  GET_SLA_DAYS('ENROLLMENT_PACKET', p_NEWBORN_FLG);
r_dmecur.ENROLL_PACKET_SLA_DAYS_TYPE        :=  GET_SLA_DAYS_TYPE('ENROLLMENT_PACKET', p_NEWBORN_FLG);
r_dmecur.FIRST_FOLLOWUP_SLA_DAYS            :=  GET_SLA_DAYS('FIRST_FOLLOWUP', p_NEWBORN_FLG);
r_dmecur.FIRST_FOLLOWUP_SLA_DAYS_TYPE       :=  GET_SLA_DAYS_TYPE('FIRST_FOLLOWUP', p_NEWBORN_FLG);
r_dmecur.SECOND_FOLLOWUP_SLA_DAYS           :=  GET_SLA_DAYS('SECOND_FOLLOWUP', p_NEWBORN_FLG);
r_dmecur.SECOND_FOLLOWUP_SLA_DAYS_TYPE      :=  GET_SLA_DAYS_TYPE('SECOND_FOLLOWUP', p_NEWBORN_FLG);
R_DMECUR.THIRD_FOLLOWUP_SLA_DAYS            :=  null; --GET_SLA_DAYS('THIRD_FOLLOWUP', p_NEWBORN_FLG);
r_dmecur.THIRD_FOLLOWUP_SLA_DAYS_TYPE       :=  null; --GET_SLA_DAYS_TYPE('THIRD_FOLLOWUP', p_NEWBORN_FLG);
R_DMECUR.FOURTH_FOLLOWUP_SLA_DAYS           :=  null; --GET_SLA_DAYS('FOURTH_FOLLOWUP', p_NEWBORN_FLG);
r_dmecur.FOURTH_FOLLOWUP_SLA_DAYS_TYPE      :=  null; --GET_SLA_DAYS_TYPE('FOURTH_FOLLOWUP', p_NEWBORN_FLG);
r_dmecur.ENROLLMENT_FEE_REQUIRED            :=  GET_ENRL_FEE_REQ(p_ENROLL_FEE_AMNT_DUE);
r_dmecur.DAYS_TO_AUTO_ASSIGNMENT            :=  GET_Days_to_AA(to_date(p_AA_DUE_DT,BPM_COMMON.DATE_FMT),to_date(p_CREATE_DT,BPM_COMMON.DATE_FMT));

r_dmecur.AUTO_ASSIGN_TIMELY_STATUS          :=  case when p_ASED_AUTO_ASSIGN <= p_AA_DUE_DT then 'Timely' else 'Untimely' end;
r_dmecur.ENROLL_PACKET_TIMELY_STATUS        :=  GET_TIMELY_STATUS(to_date(p_ASED_SEND_ENROLL_PACKET,BPM_COMMON.DATE_FMT),  to_date(p_CREATE_DT,BPM_COMMON.DATE_FMT),'ENROLLMENT_PACKET', p_NEWBORN_FLG);
r_dmecur.FIRST_FOLLOWUP_TIMELY_STATUS       :=  GET_TIMELY_STATUS(to_date(p_ASED_FIRST_FOLLOWUP,BPM_COMMON.DATE_FMT),  to_date(p_CREATE_DT,BPM_COMMON.DATE_FMT),'FIRST_FOLLOWUP', p_NEWBORN_FLG);
r_dmecur.SECOND_FOLLOWUP_TIMELY_STATUS      :=  GET_TIMELY_STATUS(to_date(p_ASED_SECOND_FOLLOWUP,BPM_COMMON.DATE_FMT),  to_date(p_CREATE_DT,BPM_COMMON.DATE_FMT),'SECOND_FOLLOWUP', p_NEWBORN_FLG);
R_DMECUR.THIRD_FOLLOWUP_TIMELY_STATUS       :=  null; --GET_TIMELY_STATUS(to_date(p_ASED_THIRD_FOLLOWUP,BPM_COMMON.DATE_FMT),  to_date(p_CREATE_DT,BPM_COMMON.DATE_FMT),'THIRD_FOLLOWUP', p_NEWBORN_FLG);
r_dmecur.FOURTH_FOLLOWUP_TIMELY_STATUS      :=  null; --GET_TIMELY_STATUS(to_date(p_ASED_FOURTH_FOLLOWUP,BPM_COMMON.DATE_FMT),  to_date(p_CREATE_DT,BPM_COMMON.DATE_FMT),'FOURTH_FOLLOWUP', p_NEWBORN_FLG);
r_dmecur.FIRST_FOLLOW_UP_TYPE               :=  GET_FOLLOWUP_TYPE(p_FIRST_FOLLOWUP_TYPE_CODE);
R_DMECUR.SECOND_FOLLOW_UP_TYPE              :=  GET_FOLLOWUP_TYPE(P_SECOND_FOLLOWUP_TYPE_CODE);
r_dmecur.THIRD_FOLLOW_UP_TYPE               :=  null; --GET_FOLLOWUP_TYPE(p_THIRD_FOLLOWUP_TYPE_CODE);
r_dmecur.FOURTH_FOLLOW_UP_TYPE              :=  null; --GET_FOLLOWUP_TYPE(p_FOURTH_FOLLOWUP_TYPE_CODE);
r_dmecur.ENROLLMENT_ACTIVITY_OUTCOME        :=  GET_ENRL_ACTIVITY_OUTCOME(to_date(p_cancel_dt,BPM_COMMON.DATE_FMT),
                                                          to_date(p_complete_dt,BPM_COMMON.DATE_FMT),
                                                          p_slct_method,
                                                          p_cancel_reason);

  if p_set_type = 'INSERT' then
       insert into D_ME_CURRENT
       values r_dmecur;

     elsif p_set_type = 'UPDATE' then
       begin
         update D_ME_CURRENT
         set row = r_dmecur
         where ME_BI_ID = p_bi_id;
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

  end SET_DMECUR;

   -- Insert BPM Semantic model data.
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_sql_code number := null;
    v_log_message clob := null;

    v_new_data T_INS_ME_XML := null;

    v_bi_id      number := null;
    v_identifier varchar2(35) := null;

    v_start_date date := null;
    v_end_date date := null;

    v_dmesc_id   number    := null;
    v_fmebd_id number := null;


    begin

        if p_data_version != 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for ILEB DPY Manage Enrollment Activity in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);
        end if;

        GET_INS_ME_XML(p_new_data_xml,v_new_data);

        v_identifier := v_new_data.CLIENT_ENROLL_STATUS_ID ;
        v_start_date := to_date(v_new_data.create_dt,BPM_COMMON.DATE_FMT);
        v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
        BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
        v_bi_id := SEQ_BI_ID.nextval;

     GET_DMESC_ID(v_identifier, v_bi_id, v_new_data.ENROLLMENT_STATUS_CODE, v_dmesc_id );

 -- Insert current dimension and fact as a single transaction.
    begin

      commit;
   SET_DMECUR
        ('INSERT',v_identifier,v_bi_id,
v_new_data.CLIENT_ENROLL_STATUS_ID,v_new_data.CLIENT_ID,v_new_data.CREATE_DT,v_new_data.CASE_ID,v_new_data.CLIENT_CIN,
v_new_data.NEWBORN_FLG,v_new_data.SERVICE_AREA,v_new_data.COUNTY_CODE,v_new_data.ZIP_CODE,v_new_data.ENROLLMENT_STATUS_CODE,
v_new_data.ENROLLMENT_STATUS_DT,v_new_data.AA_DUE_DT,v_new_data.ENRL_PACK_ID,v_new_data.ENRL_PACK_REQUEST_DT,
v_new_data.ENROLL_FEE_AMNT_DUE,v_new_data.ENROLL_FEE_AMNT_PAID,v_new_data.ENROLL_FEE_PAID_DT,v_new_data.FEE_PAID_FLG,v_new_data.CHIP_HPC_ID,
v_new_data.CHIP_HPC_MAILED_DT,v_new_data.CHIP_EMI_ID,v_new_data.CHIP_EMI_MAILED_DT,v_new_data.PLAN_TYPE,v_new_data.PROGRAM_TYPE,
v_new_data.SUBPROGRAM_TYPE,
v_new_data.SLCT_METHOD,v_new_data.SLCT_CREATE_BY_NAME,v_new_data.SLCT_CREATE_DT,v_new_data.SLCT_LAST_UPDATE_BY_NAME,
v_new_data.SLCT_LAST_UPDATE_DT, v_new_data.SLCT_AUTO_PROC,
v_new_data.ASSD_SELECTION_RECD,v_new_data.ASED_SELECTION_RECD,v_new_data.ASSD_SEND_ENROLL_PACKET,v_new_data.ASED_SEND_ENROLL_PACKET,
v_new_data.FIRST_FOLLOWUP_ID, v_new_data.first_followup_type_code ,v_new_data.ASSD_FIRST_FOLLOWUP,v_new_data.ASED_FIRST_FOLLOWUP,
v_new_data.SECOND_FOLLOWUP_ID,v_new_data.second_followup_type_code,v_new_data.ASSD_SECOND_FOLLOWUP,v_new_data.ASED_SECOND_FOLLOWUP,
v_new_data.THIRD_FOLLOWUP_ID,v_new_data.third_followup_type_code ,v_new_data.ASSD_THIRD_FOLLOWUP,v_new_data.ASED_THIRD_FOLLOWUP,
v_new_data.FOURTH_FOLLOWUP_ID,v_new_data.fourth_followup_type_code,v_new_data.ASSD_FOURTH_FOLLOWUP,v_new_data.ASED_FOURTH_FOLLOWUP,
v_new_data.ASSD_AUTO_ASSIGN,v_new_data.ASED_AUTO_ASSIGN,v_new_data.ASSD_WAIT_FOR_FEE,v_new_data.ASED_WAIT_FOR_FEE,
v_new_data.ASF_CANCEL_ENRL_ACTIVITY, v_new_data.ASF_SEND_ENROLL_PACKET,v_new_data.ASF_SELECTION_RECD,v_new_data.ASF_FIRST_FOLLOWUP,
v_new_data.ASF_SECOND_FOLLOWUP,v_new_data.ASF_THIRD_FOLLOWUP,v_new_data.ASF_FOURTH_FOLLOWUP,v_new_data.ASF_AUTO_ASSIGN,
v_new_data.ASF_WAIT_FOR_FEE,
v_new_data.GWF_ENRL_PACK_REQ,v_new_data.GWF_FIRST_FOLLOWUP_REQ,v_new_data.GWF_SECOND_FOLLOWUP_REQ,
v_new_data.GWF_THIRD_FOLLOWUP_REQ,v_new_data.GWF_FOURTH_FOLLOWUP_REQ,v_new_data.GWF_REQUIRED_FEE_PAID,
v_new_data.GENERIC_FIELD_1,v_new_data.GENERIC_FIELD_2,v_new_data.GENERIC_FIELD_3,v_new_data.GENERIC_FIELD_4,
v_new_data.GENERIC_FIELD_5,
v_new_data.INSTANCE_STATUS,v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT, v_new_data.CANCEL_REASON, v_new_data.CANCEL_METHOD,
v_new_data.CANCEL_BY
	);

   INS_FMEBD
        (v_identifier ,v_start_date ,v_end_date ,v_bi_id ,v_dmesc_id ,v_new_data.ENROLLMENT_STATUS_DT,v_fmebd_id
         );

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

  end INSERT_BPM_SEMANTIC;

  -- Update fact for BPM Semantic model - Manage Enrollment Activity.
    procedure UPD_FMEBD
      (p_identifier in varchar2,
       p_start_date in date,
       p_end_date in date,
       p_bi_id in number,
       p_DMESC_ID  in number,
       p_enrollment_status_date  in varchar2,
       p_stg_last_update_date   in varchar2,
       p_fmebd_id out number)
     as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FMEBD';
    v_sql_code number := null;
    v_log_message clob := null;

    v_fmebd_id_old number := null;
    v_d_date_old date := null;
    v_enrollment_status_date date := null;
    v_stg_last_update_date   date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;
    v_event_date date := null;

    v_DMESC_ID   number    := null;
    v_fmebd_id	 number    := null;

    r_fmebd F_ME_BY_DATE%rowtype := null;

  begin

      v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      v_event_date := v_stg_last_update_date;
      v_enrollment_status_date := to_date(p_enrollment_status_date,BPM_COMMON.DATE_FMT);


     v_DMESC_ID :=  p_DMESC_ID ;
     v_fmebd_id  := p_fmebd_id;

     with most_recent_fact_bi_id as
           (select
              max(FMEBD_ID) max_fmebd_id,
              max(D_DATE) max_d_date
            from F_ME_BY_DATE
            where ME_BI_ID = p_bi_id)
         select
           fmebd.FMEBD_ID,
           fmebd.D_DATE,
           fmebd.CREATION_COUNT,
           fmebd.COMPLETION_COUNT,
           most_recent_fact_bi_id.max_d_date
         into
           v_fmebd_id_old,
           v_d_date_old,
           v_creation_count_old,
           v_completion_count_old,
           v_max_d_date
         from
           F_ME_BY_DATE fmebd,
           most_recent_fact_bi_id
         where
           fmebd.FMEBD_ID = max_fmebd_id
      and fmebd.D_DATE = most_recent_fact_bi_id.max_d_date;

      -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;

    -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE.
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;

   if p_end_date is null then
      r_fmebd.D_DATE := v_event_date;
      r_fmebd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fmebd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fmebd.INVENTORY_COUNT := 1;
      r_fmebd.COMPLETION_COUNT := 0;
    else
         -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
          if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then

            delete from F_ME_BY_DATE
            where
              ME_BI_ID = p_bi_id
              and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);

            with most_recent_fact_bi_id as
              (select
                 max(FMEBD_ID) max_fmebd_id,
                 max(D_DATE) max_d_date
               from F_ME_BY_DATE
           where ME_BI_ID = p_bi_id)
           select
	             fmebd.FMEBD_ID,
	             fmebd.D_DATE,
	             fmebd.CREATION_COUNT,
	             fmebd.COMPLETION_COUNT,
	             most_recent_fact_bi_id.max_d_date,
	             fmebd.DMESC_ID,
	             fmebd.Enrollment_Status_Date
	           into
	             v_fmebd_id_old,
	             v_d_date_old,
	             v_creation_count_old,
	             v_completion_count_old,
	             v_max_d_date,
	             v_DMESC_ID,
	             v_enrollment_status_date
	           from
	             F_ME_BY_DATE fmebd,
	             most_recent_fact_bi_id
	           where
	             fmebd.FMEBD_ID = max_fmebd_id
          and fmebd.D_DATE = most_recent_fact_bi_id.max_d_date;

      end if;

      r_fmebd.D_DATE := p_end_date;
      r_fmebd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fmebd.BUCKET_END_DATE := r_fmebd.BUCKET_START_DATE;
      r_fmebd.INVENTORY_COUNT := 0;
      r_fmebd.COMPLETION_COUNT := 1;

    end if;

    p_fmebd_id := SEQ_FMEBD_ID.nextval;
    r_fmebd.FMEBD_ID := p_fmebd_id;
    r_fmebd.ME_BI_ID := p_bi_id;
    r_fmebd.DMESC_ID := v_DMESC_ID ;
    r_fmebd.Enrollment_Status_Date := v_enrollment_status_date;
    r_fmebd.CREATION_COUNT := 0;


 -- Validate fact date ranges.
     if r_fmebd.D_DATE < r_fmebd.BUCKET_START_DATE
       or to_date(to_char(r_fmebd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fmebd.BUCKET_END_DATE
       or r_fmebd.BUCKET_START_DATE > r_fmebd.BUCKET_END_DATE
       or r_fmebd.BUCKET_END_DATE < r_fmebd.BUCKET_START_DATE
     then
       v_sql_code := -20030;
       v_log_message := 'Attempted to insert invalid fact date range.  ' ||
         'D_DATE = ' || r_fmebd.D_DATE ||
         ' BUCKET_START_DATE = ' || to_char(r_fmebd.BUCKET_START_DATE,v_date_bucket_fmt) ||
         ' BUCKET_END_DATE = ' || to_char(r_fmebd.BUCKET_END_DATE,v_date_bucket_fmt);
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
       RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
     end if;

   if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fmebd.BUCKET_START_DATE then

      -- Same bucket time.

      if v_creation_count_old = 1 then
        r_fmebd.CREATION_COUNT := v_creation_count_old;
      end if;

      update F_ME_BY_DATE
      set row = r_fmebd
      where FMEBD_ID = v_fmebd_id_old;

    else

     -- Different bucket time.

          update F_ME_BY_DATE
          set BUCKET_END_DATE = r_fmebd.BUCKET_START_DATE
          where FMEBD_ID = v_fmebd_id_old;

          insert into F_ME_BY_DATE
          values r_fmebd;

        end if;

      exception

        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
          raise;

      end UPD_FMEBD;

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

    v_old_data T_UPD_ME_XML := null;
    v_new_data T_UPD_ME_XML := null;
  begin

 if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" with ILEB DPY Manage Enrollment Activity in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;

    GET_UPD_ME_XML(p_old_data_xml,v_old_data);
    GET_UPD_ME_XML(p_new_data_xml,v_new_data);

   v_identifier := v_new_data.CLIENT_ENROLL_STATUS_ID;
  v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
   v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
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

  insert into BPM_UPDATE_EVENT(BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
    values (v_bue_id,v_bi_id,v_butl_id,v_stg_last_update_date,'N');

BPM_EVENT.UPDATE_BIA(v_bi_id,1773,1,'N',v_new_data.CLIENT_ENROLL_STATUS_ID,     v_new_data.CLIENT_ENROLL_STATUS_ID,   v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1741,1,'N',v_new_data.CLIENT_ID,                  v_new_data.CLIENT_ID,                v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1742,3,'N',v_new_data.CREATE_DT,                  v_new_data.CREATE_DT,                v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1743,1,'N',v_new_data.CASE_ID,                    v_new_data.CASE_ID,                  v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1774,2,'N',v_new_data.CLIENT_CIN,                 v_new_data.CLIENT_CIN,               v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1744,2,'N',v_new_data.NEWBORN_FLG,                v_new_data.NEWBORN_FLG,              v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1775,2,'N',v_new_data.SERVICE_AREA,               v_new_data.SERVICE_AREA,             v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1747,2,'N',v_new_data.COUNTY_CODE,                v_new_data.COUNTY_CODE,              v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1776,2,'N',v_new_data.ZIP_CODE,                   v_new_data.ZIP_CODE,                 v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1777,2,'Y',v_new_data.ENROLLMENT_STATUS_CODE,     v_new_data.ENROLLMENT_STATUS_CODE,   v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1778,3,'Y',v_new_data.ENROLLMENT_STATUS_DT,       v_new_data.ENROLLMENT_STATUS_DT,     v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1779,3,'N',v_new_data.AA_DUE_DT,                  v_new_data.AA_DUE_DT,                v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1693,1,'N',v_new_data.ENRL_PACK_ID,               v_new_data.ENRL_PACK_ID,             v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1694,3,'N',v_new_data.ENRL_PACK_REQUEST_DT,       v_new_data.ENRL_PACK_REQUEST_DT,     v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1695,1,'N',v_new_data.ENROLL_FEE_AMNT_DUE,        v_new_data.ENROLL_FEE_AMNT_DUE,      v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1696,1,'N',v_new_data.ENROLL_FEE_AMNT_PAID,       v_new_data.ENROLL_FEE_AMNT_PAID,     v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1697,3,'N',v_new_data.ENROLL_FEE_PAID_DT,         v_new_data.ENROLL_FEE_PAID_DT,       v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,2181,2,'N',v_new_data.FEE_PAID_FLG,               v_new_data.FEE_PAID_FLG,             v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1698,1,'N',v_new_data.CHIP_HPC_ID,                v_new_data.CHIP_HPC_ID,              v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1699,3,'N',v_new_data.CHIP_HPC_MAILED_DT,         v_new_data.CHIP_HPC_MAILED_DT,       v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1700,1,'N',v_new_data.CHIP_EMI_ID,                v_new_data.CHIP_EMI_ID,              v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1701,3,'N',v_new_data.CHIP_EMI_MAILED_DT,         v_new_data.CHIP_EMI_MAILED_DT,       v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1702,2,'N',v_new_data.PLAN_TYPE,                  v_new_data.PLAN_TYPE,                v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1703,2,'N',v_new_data.PROGRAM_TYPE,               v_new_data.PROGRAM_TYPE,             v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,2182,2,'N',v_new_data.SUBPROGRAM_TYPE,            v_new_data.SUBPROGRAM_TYPE,          v_bue_id,v_stg_last_update_date);

BPM_EVENT.UPDATE_BIA(v_bi_id,1704,2,'N',v_old_data.SLCT_METHOD,                       v_new_data.SLCT_METHOD,                  v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1705,2,'N',v_old_data.SLCT_CREATE_BY_NAME,               v_new_data.SLCT_CREATE_BY_NAME,          v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1706,3,'N',v_old_data.SLCT_CREATE_DT,                    v_new_data.SLCT_CREATE_DT,               v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1707,2,'N',v_old_data.SLCT_LAST_UPDATE_BY_NAME,          v_new_data.SLCT_LAST_UPDATE_BY_NAME,     v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1708,3,'N',v_old_data.SLCT_LAST_UPDATE_DT,               v_new_data.SLCT_LAST_UPDATE_DT,          v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1709,2,'N',v_old_data.SLCT_AUTO_PROC,                    v_new_data.SLCT_AUTO_PROC,               v_bue_id,v_stg_last_update_date);

BPM_EVENT.UPDATE_BIA(v_bi_id,1710,2,'N',v_old_data.GENERIC_FIELD_1,  v_new_data.GENERIC_FIELD_1,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1711,2,'N',v_old_data.GENERIC_FIELD_2,  v_new_data.GENERIC_FIELD_2,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1712,2,'N',v_old_data.GENERIC_FIELD_3,  v_new_data.GENERIC_FIELD_3,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1713,2,'N',v_old_data.GENERIC_FIELD_4,  v_new_data.GENERIC_FIELD_4,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1714,2,'N',v_old_data.GENERIC_FIELD_5,  v_new_data.GENERIC_FIELD_5,v_bue_id,v_stg_last_update_date);

BPM_EVENT.UPDATE_BIA(v_bi_id,1715,3,'N',v_old_data.ASSD_SELECTION_RECD,        v_new_data.ASSD_SELECTION_RECD,       v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1716,3,'N',v_old_data.ASED_SELECTION_RECD,        v_new_data.ASED_SELECTION_RECD,       v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1717,3,'N',v_old_data.ASSD_SEND_ENROLL_PACKET,    v_new_data.ASSD_SEND_ENROLL_PACKET,   v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1718,3,'N',v_old_data.ASED_SEND_ENROLL_PACKET,    v_new_data.ASED_SEND_ENROLL_PACKET,   v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1719,2,'N',v_old_data.FIRST_FOLLOWUP_ID,          v_new_data.FIRST_FOLLOWUP_ID,         v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1720,2,'N',v_old_data.FIRST_FOLLOWUP_TYPE_CODE,   v_new_data.FIRST_FOLLOWUP_TYPE_CODE,  v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1721,3,'N',v_old_data.ASSD_FIRST_FOLLOWUP,        v_new_data.ASSD_FIRST_FOLLOWUP,       v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1722,3,'N',v_old_data.ASED_FIRST_FOLLOWUP,        v_new_data.ASED_FIRST_FOLLOWUP,       v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1723,2,'N',v_old_data.SECOND_FOLLOWUP_ID,         v_new_data.SECOND_FOLLOWUP_ID,        v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1724,2,'N',v_old_data.SECOND_FOLLOWUP_TYPE_CODE,  v_new_data.SECOND_FOLLOWUP_TYPE_CODE, v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1725,3,'N',v_old_data.ASSD_SECOND_FOLLOWUP,       v_new_data.ASSD_SECOND_FOLLOWUP,      v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1726,3,'N',v_old_data.ASED_SECOND_FOLLOWUP,       v_new_data.ASED_SECOND_FOLLOWUP,      v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1727,2,'N',v_old_data.THIRD_FOLLOWUP_ID,          v_new_data.THIRD_FOLLOWUP_ID,         v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1728,2,'N',v_old_data.THIRD_FOLLOWUP_TYPE_CODE,   v_new_data.THIRD_FOLLOWUP_TYPE_CODE,  v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1729,3,'N',v_old_data.ASSD_THIRD_FOLLOWUP,        v_new_data.ASSD_THIRD_FOLLOWUP,       v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1730,3,'N',v_old_data.ASED_THIRD_FOLLOWUP,        v_new_data.ASED_THIRD_FOLLOWUP,       v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1731,2,'N',v_old_data.FOURTH_FOLLOWUP_ID,         v_new_data.FOURTH_FOLLOWUP_ID,        v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1732,2,'N',v_old_data.FOURTH_FOLLOWUP_TYPE_CODE,  v_new_data.FOURTH_FOLLOWUP_TYPE_CODE, v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1733,3,'N',v_old_data.ASSD_FOURTH_FOLLOWUP,       v_new_data.ASSD_FOURTH_FOLLOWUP,      v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1734,3,'N',v_old_data.ASED_FOURTH_FOLLOWUP,       v_new_data.ASED_FOURTH_FOLLOWUP,      v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1735,3,'N',v_old_data.ASSD_AUTO_ASSIGN,           v_new_data.ASSD_AUTO_ASSIGN,          v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1736,3,'N',v_old_data.ASED_AUTO_ASSIGN,           v_new_data.ASED_AUTO_ASSIGN,          v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1737,3,'N',v_old_data.ASSD_WAIT_FOR_FEE,          v_new_data.ASSD_WAIT_FOR_FEE,         v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1738,3,'N',v_old_data.ASED_WAIT_FOR_FEE,          v_new_data.ASED_WAIT_FOR_FEE,         v_bue_id,v_stg_last_update_date);

BPM_EVENT.UPDATE_BIA(v_bi_id,1748,2,'N',v_old_data.INSTANCE_STATUS,          v_new_data.INSTANCE_STATUS,        v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1749,3,'N',v_old_data.COMPLETE_DT,              v_new_data.COMPLETE_DT,            v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1739,3,'N',v_old_data.CANCEL_DT,                v_new_data.CANCEL_DT,              v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1750,2,'N',v_old_data.CANCEL_REASON,            v_new_data.CANCEL_REASON,          v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1751,2,'N',v_old_data.CANCEL_METHOD,            v_new_data.CANCEL_METHOD,          v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1740,2,'N',v_old_data.CANCEL_BY,                v_new_data.CANCEL_BY,              v_bue_id,v_stg_last_update_date);
--BPM_EVENT.UPDATE_BIA(v_bi_id,1746,1,'N',v_old_data.AGE_IN_CALENDAR_DAYS,     v_new_data.AGE_IN_CALENDAR_DAYS,   v_bue_id,v_stg_last_update_date);
--BPM_EVENT.UPDATE_BIA(v_bi_id,1745,1,'N',v_old_data.AGE_IN_BUSINESS_DAYS,     v_new_data.AGE_IN_BUSINESS_DAYS,   v_bue_id,v_stg_last_update_date);

--ASF Flags
BPM_EVENT.UPDATE_BIA(v_bi_id,1752,2,'N',v_old_data.asf_send_enroll_packet,   v_new_data.asf_send_enroll_packet,  v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1753,2,'N',v_old_data.asf_selection_recd,       v_new_data.asf_selection_recd,      v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1754,2,'N',v_old_data.asf_first_followup,       v_new_data.asf_first_followup,      v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1755,2,'N',v_old_data.asf_second_followup,      v_new_data.asf_second_followup,     v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1756,2,'N',v_old_data.asf_third_followup,       v_new_data.asf_third_followup,      v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1757,2,'N',v_old_data.asf_fourth_followup,      v_new_data.asf_fourth_followup,     v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1758,2,'N',v_old_data.asf_auto_assign,          v_new_data.asf_auto_assign,         v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1759,2,'N',v_old_data.asf_wait_for_fee,         v_new_data.asf_wait_for_fee,        v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1766,2,'N',v_old_data.asf_cancel_enrl_activity, v_new_data.asf_cancel_enrl_activity,v_bue_id,v_stg_last_update_date);

--GWF flags
BPM_EVENT.UPDATE_BIA(v_bi_id,1760,2,'N',v_old_data.gwf_enrl_pack_req,       v_new_data.gwf_enrl_pack_req,       v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1761,2,'N',v_old_data.gwf_first_followup_req,  v_new_data.gwf_first_followup_req,  v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1762,2,'N',v_old_data.gwf_second_followup_req, v_new_data.gwf_second_followup_req, v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1763,2,'N',v_old_data.gwf_third_followup_req,  v_new_data.gwf_third_followup_req,  v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1764,2,'N',v_old_data.gwf_fourth_followup_req, v_new_data.gwf_fourth_followup_req, v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id,1765,2,'N',v_old_data.gwf_required_fee_paid,   v_new_data.gwf_required_fee_paid,   v_bue_id,v_stg_last_update_date);

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

  end UPDATE_BPM_EVENT;

  -- Update BPM Semantic model data.
  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype)
  as

      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';
      v_sql_code number := null;
      v_log_message clob := null;

      v_old_data T_UPD_ME_XML := null;
      v_new_data T_UPD_ME_XML := null;

      v_bi_id number := null;
      v_identifier varchar2(35) := null;

      v_start_date date := null;
      v_end_date date := null;

    v_dmesc_id   number    := null;
        v_fmebd_id number := null;


    begin

        if p_data_version != 1 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for ILEB Manage Enrollment Activity in procedure' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);
        end if;

        GET_UPD_ME_XML(p_old_data_xml,v_old_data);
        GET_UPD_ME_XML(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.CLIENT_ENROLL_STATUS_ID ;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

    select ME_BI_ID 
    into v_bi_id
    from D_ME_CURRENT
    where CLIENT_ENROLL_STATUS_ID = v_identifier;

    GET_DMESC_ID(v_identifier, v_bi_id, v_new_data.ENROLLMENT_STATUS_CODE, v_dmesc_id );

   -- Update current dimension and fact as a single transaction.
    begin

      commit;

  SET_DMECUR
        ('UPDATE',v_identifier,v_bi_id,
v_new_data.CLIENT_ENROLL_STATUS_ID,v_new_data.CLIENT_ID,v_new_data.CREATE_DT,v_new_data.CASE_ID,v_new_data.CLIENT_CIN,
v_new_data.NEWBORN_FLG,v_new_data.SERVICE_AREA,v_new_data.COUNTY_CODE,v_new_data.ZIP_CODE,v_new_data.ENROLLMENT_STATUS_CODE,
v_new_data.ENROLLMENT_STATUS_DT,v_new_data.AA_DUE_DT,v_new_data.ENRL_PACK_ID,v_new_data.ENRL_PACK_REQUEST_DT,
v_new_data.ENROLL_FEE_AMNT_DUE,v_new_data.ENROLL_FEE_AMNT_PAID,v_new_data.ENROLL_FEE_PAID_DT,v_new_data.FEE_PAID_FLG,v_new_data.CHIP_HPC_ID,
v_new_data.CHIP_HPC_MAILED_DT,v_new_data.CHIP_EMI_ID,v_new_data.CHIP_EMI_MAILED_DT,v_new_data.PLAN_TYPE,v_new_data.PROGRAM_TYPE,
v_new_data.SUBPROGRAM_TYPE,
v_new_data.SLCT_METHOD,v_new_data.SLCT_CREATE_BY_NAME,v_new_data.SLCT_CREATE_DT,v_new_data.SLCT_LAST_UPDATE_BY_NAME,
v_new_data.SLCT_LAST_UPDATE_DT, v_new_data.SLCT_AUTO_PROC,
v_new_data.ASSD_SELECTION_RECD,v_new_data.ASED_SELECTION_RECD,v_new_data.ASSD_SEND_ENROLL_PACKET,v_new_data.ASED_SEND_ENROLL_PACKET,
v_new_data.FIRST_FOLLOWUP_ID, v_new_data.first_followup_type_code ,v_new_data.ASSD_FIRST_FOLLOWUP,v_new_data.ASED_FIRST_FOLLOWUP,
v_new_data.SECOND_FOLLOWUP_ID,v_new_data.second_followup_type_code,v_new_data.ASSD_SECOND_FOLLOWUP,v_new_data.ASED_SECOND_FOLLOWUP,
v_new_data.THIRD_FOLLOWUP_ID,v_new_data.third_followup_type_code ,v_new_data.ASSD_THIRD_FOLLOWUP,v_new_data.ASED_THIRD_FOLLOWUP,
v_new_data.FOURTH_FOLLOWUP_ID,v_new_data.fourth_followup_type_code,v_new_data.ASSD_FOURTH_FOLLOWUP,v_new_data.ASED_FOURTH_FOLLOWUP,
v_new_data.ASSD_AUTO_ASSIGN,v_new_data.ASED_AUTO_ASSIGN,v_new_data.ASSD_WAIT_FOR_FEE,v_new_data.ASED_WAIT_FOR_FEE,
v_new_data.ASF_CANCEL_ENRL_ACTIVITY, v_new_data.ASF_SEND_ENROLL_PACKET,v_new_data.ASF_SELECTION_RECD,v_new_data.ASF_FIRST_FOLLOWUP,
v_new_data.ASF_SECOND_FOLLOWUP,v_new_data.ASF_THIRD_FOLLOWUP,v_new_data.ASF_FOURTH_FOLLOWUP,v_new_data.ASF_AUTO_ASSIGN,
v_new_data.ASF_WAIT_FOR_FEE,
v_new_data.GWF_ENRL_PACK_REQ,v_new_data.GWF_FIRST_FOLLOWUP_REQ,v_new_data.GWF_SECOND_FOLLOWUP_REQ,
v_new_data.GWF_THIRD_FOLLOWUP_REQ,v_new_data.GWF_FOURTH_FOLLOWUP_REQ,v_new_data.GWF_REQUIRED_FEE_PAID,
v_new_data.GENERIC_FIELD_1,v_new_data.GENERIC_FIELD_2,v_new_data.GENERIC_FIELD_3,v_new_data.GENERIC_FIELD_4,
v_new_data.GENERIC_FIELD_5,
v_new_data.INSTANCE_STATUS,v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT, v_new_data.CANCEL_REASON, v_new_data.CANCEL_METHOD,
v_new_data.CANCEL_BY
	);

  UPD_FMEBD
        (v_identifier ,v_start_date ,v_end_date ,v_bi_id ,v_dmesc_id, v_new_data.ENROLLMENT_STATUS_DT,
         v_new_data.stg_last_update_date,v_fmebd_id
         );

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

  end UPDATE_BPM_SEMANTIC;

end MANAGE_ENROLL;
/

  
alter session set plsql_code_type = interpreted;