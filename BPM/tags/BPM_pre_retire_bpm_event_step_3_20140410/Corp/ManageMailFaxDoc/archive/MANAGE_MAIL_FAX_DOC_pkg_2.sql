create or replace package MANAGE_MAIL_FAX_DOC as

  procedure CALC_DMFDOCCUR;
  procedure CREATE_CALC_DMFDOCCUR_JOB;
  procedure STOP_CALC_DMFDOCCUR_JOB;
  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number;

  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number;

  function GET_DCN_JEOPARDY_STATUS
    (p_dcn_create_dt in date,
     p_document_type in varchar2
 )
    return varchar2;

  function GET_TIMELINESS_STATUS
    (p_dcn_create_dt in date,
     p_document_type in varchar2
)
    return varchar2;
  /*
  select '     '|| 'CEMFD_ID varchar2(100),' attr_element from dual
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
    bast.BSL_ID = 9
    and atc.TABLE_NAME = 'CORP_ETL_MAILFAXDOC'
  order by attr_element asc;
  */
  type T_INS_PD_XML is record
    (
     ASED_CLASSIFY_FORM_DOC_MANUAL varchar2(19),
     ASED_CREATE_AND_ROUTE_WORK varchar2(19),
     ASED_CREATE_IA_TASK varchar2(19),
     ASED_LINK_IMAGES_MANUAL varchar2(19),
     ASF_CLASSIFY_FORM_DOC_MANUAL varchar2(1),
     ASF_CREATE_AND_ROUTE_WORK varchar2(1),
     ASF_CREATE_IA_TASK varchar2(1),
     ASF_LINK_IMAGES_MANUAL varchar2(1),
     ASSD_CLASSIFY_FORM_DOC_MANUAL varchar2(19),
     ASSD_CREATE_AND_ROUTE_WORK varchar2(19),
     ASSD_CREATE_IA_TASK varchar2(19),
     ASSD_LINK_IMAGES_MANUAL varchar2(19),
     AUTOLINK_FAILURE_REASON varchar2(256),
     BATCH_CHANNEL varchar2(15),
     BATCH_NAME varchar2(255),
     CANCEL_BY varchar2(50),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(50),
     CANCEL_REASON varchar2(256),
     CEMFD_ID varchar2(100),
     DCN varchar2(256),
     DCN_COUNT varchar2(100),
     DCN_CREATE_DT varchar2(19),
     DCN_TIMELINESS_STATUS varchar2(30),
     DOCUMENT_PAGE_COUNT varchar2(100),
     DOCUMENT_STATUS varchar2(32),
     DOCUMENT_STATUS_DT varchar2(19),
     DOCUMENT_TYPE varchar2(64),
     ECN varchar2(256),
     FORM_TYPE varchar2(255),
     GWF_AUTOLINK_OUTCOME varchar2(50),
     GWF_DOCUMENT_BARCODED varchar2(1),
     GWF_DOC_CLASS_PRESENT varchar2(1),
     GWF_RESCAN_REQUIRED varchar2(1),
     GWF_WORK_IDENTIFIED varchar2(1),
     IA_MANUAL_CLASSIFY_TASK_ID varchar2(100),
     IA_MANUAL_LINK_TASK_ID varchar2(100),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(50),
     LINK_METHOD varchar2(15),
     LINK_NUMBER varchar2(100),
     LINK_VIA varchar2(32),
     ORIGINAL_DCN varchar2(100),
     RESCANNED varchar2(1),
     STG_LAST_UPDATE_DATE varchar2(19),
     WORK_TASK_ID varchar2(100),
     WORK_TASK_TYPE_CREATED varchar2(50)
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
     bast.BSL_ID = 9
     and atc.TABLE_NAME = 'CORP_ETL_MAILFAXDOC'
  order by attr_element asc;
  */
  type T_UPD_PD_XML is record
    (
          ASED_CLASSIFY_FORM_DOC_MANUAL varchar2(19),
     ASED_CREATE_AND_ROUTE_WORK varchar2(19),
     ASED_CREATE_IA_TASK varchar2(19),
     ASED_LINK_IMAGES_MANUAL varchar2(19),
     ASF_CLASSIFY_FORM_DOC_MANUAL varchar2(1),
     ASF_CREATE_AND_ROUTE_WORK varchar2(1),
     ASF_CREATE_IA_TASK varchar2(1),
     ASF_LINK_IMAGES_MANUAL varchar2(1),
     ASSD_CLASSIFY_FORM_DOC_MANUAL varchar2(19),
     ASSD_CREATE_AND_ROUTE_WORK varchar2(19),
     ASSD_CREATE_IA_TASK varchar2(19),
     ASSD_LINK_IMAGES_MANUAL varchar2(19),
     AUTOLINK_FAILURE_REASON varchar2(256),
     BATCH_CHANNEL varchar2(15),
     BATCH_NAME varchar2(255),
     CANCEL_BY varchar2(50),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(50),
     CANCEL_REASON varchar2(256),
     DCN varchar2(256),
     DCN_COUNT varchar2(100),
     DCN_CREATE_DT varchar2(19),
     DCN_TIMELINESS_STATUS varchar2(30),
     DOCUMENT_PAGE_COUNT varchar2(100),
     DOCUMENT_STATUS varchar2(32),
     DOCUMENT_STATUS_DT varchar2(19),
     DOCUMENT_TYPE varchar2(64),
     ECN varchar2(256),
     FORM_TYPE varchar2(255),
     GWF_AUTOLINK_OUTCOME varchar2(50),
     GWF_DOCUMENT_BARCODED varchar2(1),
     GWF_DOC_CLASS_PRESENT varchar2(1),
     GWF_RESCAN_REQUIRED varchar2(1),
     GWF_WORK_IDENTIFIED varchar2(1),
     IA_MANUAL_CLASSIFY_TASK_ID varchar2(100),
     IA_MANUAL_LINK_TASK_ID varchar2(100),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(50),
     LINK_METHOD varchar2(15),
     LINK_NUMBER varchar2(100),
     LINK_VIA varchar2(32),
     ORIGINAL_DCN varchar2(100),
     RESCANNED varchar2(1),
     STG_LAST_UPDATE_DATE varchar2(19),
     WORK_TASK_ID varchar2(100),
     WORK_TASK_TYPE_CREATED varchar2(50)
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


create or replace package body MANAGE_MAIL_FAX_DOC as
  v_bem_id number := 9; -- 'Manage Mail Fax Doc'
  v_bil_id number := 1; -- 'Document ID'
  v_bsl_id number := 9; -- 'CORP_ETL_MAILFAXDOC'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  v_calc_DMFDOCCUR_job_name varchar2(30) := 'CALC_DMFDOCCUR';
  v_jeopardy_hours number ;
  v_timeliness_hours number;
  v_step  varchar2(100);

  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date)
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
  
  
  function GET_DCN_JEOPARDY_STATUS
    (p_dcn_create_dt in date,
     p_document_type in varchar2
  )
    return varchar2
      as
  begin
  if p_document_type is not null then
    select  to_number(out_var)
    into    v_jeopardy_hours
    from    corp_etl_list_lkup
    where   name = 'ProcessMail_jeop_threshold'
    and     list_type = 'DOC_TYPE'
    and     value = p_document_type;
    if (p_dcn_create_dt + v_jeopardy_hours/24) < SYSDATE then
       return 'Y';
    else
       return 'N';
     end if;
  else
       return 'N';
  end if;
  end;
  
  
  function GET_TIMELINESS_STATUS
    (p_dcn_create_dt in date,
     p_document_type in varchar2
)
    return varchar2
  as
  begin
 if p_document_type is not null then
    select  to_number(out_var)
    into    v_timeliness_hours
    from    corp_etl_list_lkup
    where   name = 'ProcessMail_timeli_threshold'
    and     list_type = 'DOC_TYPE'
    and     value = p_document_type;
    if (p_dcn_create_dt + v_timeliness_hours/24) < SYSDATE then
       return 'Processed Untimely';
    else
       return 'Processed Timely';
     end if;
  else
      return 'Not Processed';
  end if;
  end;
  
  
   -- Calculate column values in BPM Semantic table D_MFDOC_CURRENT.
  procedure CALC_DMFDOCCUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DMFDOCCUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin
    update D_MFDOC_CURRENT
    set
      "Age in Business Days" = GET_AGE_IN_BUSINESS_DAYS("DCN Create Date",SYSDATE),
      "Age in Calendar Days" = GET_AGE_IN_CALENDAR_DAYS("DCN Create Date",SYSDATE),
      "DCN Jeopardy Status" = GET_DCN_JEOPARDY_STATUS("DCN Create Date","Document Type"),
      "DCN Jeopardy Status Date" = sysdate,
      "DCN Timeliness Status" = GET_TIMELINESS_STATUS("DCN Create Date","Document Type")
    where
      "Instance Complete Date" is null ;
    --  and "Cancel Date" is null;
    v_num_rows_updated := sql%rowcount;
    commit;
    v_log_message := v_num_rows_updated  || ' D_MFDOC_CURRENT rows updated with calculated attributes by CALC_DMFDOCCUR.';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,null);
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
  end;
  
  
  -- Create and start scheduler job for CALC_DNPACUR job.
  procedure CREATE_CALC_DMFDOCCUR_JOB
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CREATE_CALC_DMFDOCCUR_JOB';
    v_log_message clob := null;
    v_sql_code number := null;
    v_job_action varchar2(200) := null;
  begin
    -- Run now.
    CALC_DMFDOCCUR;
    -- Create job to run daily.
    v_job_action := 'begin MANAGE_MAIL_FAX_DOC.CALC_DMFDOCCUR; end;';
    dbms_scheduler.create_job (
      job_name   => v_calc_DMFDOCCUR_job_name,
      job_type   => 'PLSQL_BLOCK',
      job_action => v_job_action,
      start_date => trunc(sysdate + 1),
      repeat_interval=> 'FREQ=DAILY; BYHOUR=0;',
      enabled    =>  TRUE,
      comments   => 'Calculate column values in BPM Semantic table D_MFDOC_CURRENT');
    dbms_scheduler.set_attribute(
      name => v_calc_DMFDOCCUR_job_name,
      attribute => 'RESTARTABLE',
      value => TRUE);
    v_log_message := 'Created dbms_scheduler job "' || v_calc_DMFDOCCUR_job_name || '".';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,null);
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to start job "' || v_calc_DMFDOCCUR_job_name || '".  '  || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
  end;
  
  
  -- Gracefully stop CALC_DNPACUR job.
  procedure STOP_CALC_DMFDOCCUR_JOB
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'STOP_CALC_DMFDOCCUR_JOB';
    v_log_message clob := null;
    v_sql_code number := null;
  begin
    dbms_scheduler.drop_job(v_calc_DMFDOCCUR_job_name,TRUE);
    v_log_message := 'Stopped dbms_scheduler job "' || v_calc_DMFDOCCUR_job_name || '".';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,null);
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to stop job "' || v_calc_DMFDOCCUR_job_name || '".  '  || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
  end;
  
  
  -- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - Instance Status.
  procedure GET_DMFDOCIS_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_ins_status in varchar2,
      p_dmfdocis_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DMFDOCIS_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DMFDOCIS_ID into p_dmfdocis_id
     from D_MFDOC_INSTANCE_STATUS
     where
       "Instance Status" = p_ins_status
       or ("Instance Status" is null and p_ins_status is null);
   exception
     when NO_DATA_FOUND then
       p_dmfdocis_id := SEQ_DMFDOCIS_ID.nextval;
       begin
         insert into D_MFDOC_INSTANCE_STATUS (DMFDOCIS_ID,"Instance Status")
         values (p_dmfdocis_id,p_ins_status);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DMFDOCIS_ID into p_dmfdocis_id
           from D_MFDOC_INSTANCE_STATUS
           where
             "Instance Status" = p_ins_status
             or ("Instance Status" is null and p_ins_status is null);
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
  
  
  -- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - Document Status.
  procedure GET_DMFDOCDS_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_doc_status in varchar2,
     p_dmfdocds_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DMFDOCDS_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DMFDOCDS_ID into p_dmfdocds_id
    from D_MFDOC_DOCUMENT_STATUS
    where
      "Document Status" = p_doc_status
      or ("Document Status" is null and p_doc_status is null);
  exception
    when NO_DATA_FOUND then
      p_dmfdocds_id := SEQ_DMFDOCDS_ID.nextval;
      begin
        insert into D_MFDOC_DOCUMENT_STATUS (DMFDOCDS_ID,"Document Status")
        values (p_dmfdocds_id,p_doc_status);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DMFDOCDS_ID into p_dmfdocds_id
          from D_MFDOC_DOCUMENT_STATUS
          where
            "Document Status" = p_doc_status
            or ("Document Status" is null and p_doc_status is null);
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
  
  
  -- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - Timeliness Status
  procedure GET_DMFDOCTS_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_dcn_timely_status in varchar2,
     p_dmfdocts_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNPAHS_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DMFDOCTS_ID into p_dmfdocts_id
    from D_MFDOC_TIMELINESS_STATUS
    where
      "DCN Timeliness Status" = p_dcn_timely_status
      or ("DCN Timeliness Status" is null and p_dcn_timely_status is null);
  exception
    when NO_DATA_FOUND then
      p_dmfdocts_id := SEQ_DMFDOCTS_ID.nextval;
      begin
        insert into D_MFDOC_TIMELINESS_STATUS (DMFDOCTS_ID,"DCN Timeliness Status")
        values (p_dmfdocts_id,p_dcn_timely_status);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DMFDOCTS_ID into p_dmfdocts_id
          from D_MFDOC_TIMELINESS_STATUS
          where
            "DCN Timeliness Status" = p_dcn_timely_status
            or ("DCN Timeliness Status" is null and p_dcn_timely_status is null);
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
  
  
  -- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - Batch,channel
  procedure GET_DMFDOCB_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_batch_name in varchar2,
     p_channel in varchar2,
     p_dmfdocb_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DMFDOCB_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
      select DMFDOCB_ID into p_dmfdocb_id
      from D_MFDOC_BATCH
      where
        ("Batch Name" = p_batch_name or ("Batch Name" is null and p_batch_name is null))
        and (CHANNEL = p_channel or (CHANNEL is null and p_channel is null));
  exception
    when NO_DATA_FOUND then
      p_dmfdocb_id := SEQ_DMFDOCB_ID.nextval;
      begin
        insert into D_MFDOC_BATCH
          (DMFDOCB_ID,"Batch Name",CHANNEL)
        values
          (p_dmfdocb_id,p_batch_name,p_channel);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
        select DMFDOCB_ID into p_dmfdocb_id
        from D_MFDOC_BATCH
        where
        ("Batch Name" = p_batch_name or ("Batch Name" is null and p_batch_name is null))
        and (CHANNEL = p_channel or (CHANNEL is null and p_channel is null));
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
  
  
  -- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - Document type.
  procedure GET_DMFDOCDT_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_doc_type in varchar2,
     p_dmfdocdt_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DMFDOCDT_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DMFDOCDT_ID into p_dmfdocdt_id
    from D_MFDOC_DOC_TYPE
    where
      "Document Type" = p_doc_type
      or ("Document Type" is null and p_doc_type is null);
  exception
    when NO_DATA_FOUND then
      p_dmfdocdt_id := SEQ_DMFDOCDT_ID.nextval;
      begin
        insert into D_MFDOC_DOC_TYPE (DMFDOCDT_ID,"Document Type")
        values (p_dmfdocdt_id,p_doc_type);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DMFDOCDT_ID into p_dmfdocdt_id
          from D_MFDOC_DOC_TYPE
          where
            "Document Type" = p_doc_type
            or ("Document Type" is null and p_doc_type is null);
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
  
  
  -- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - DCN Jeopardy status.
  procedure GET_DMFDOCDCNJS_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_jeopardy_status in varchar2,
     p_dmfdocdcnjs_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DMFDOCDCNJS_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DMFDOCDCNJS_ID into p_dmfdocdcnjs_id
    from D_MFDOC_DCN_JEOPARDY_STATUS
    where
      "DCN Jeopardy Status" = p_jeopardy_status
      or ("DCN Jeopardy Status" is null and p_jeopardy_status is null);
  exception
    when NO_DATA_FOUND then
      p_dmfdocdcnjs_id := SEQ_DMFDOCDCNJS_ID.nextval;
      begin
        insert into D_MFDOC_DCN_JEOPARDY_STATUS  (DMFDOCDCNJS_ID,"DCN Jeopardy Status")
        values (p_dmfdocdcnjs_id,p_jeopardy_status);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DMFDOCDCNJS_ID into p_dmfdocdcnjs_id
          from D_MFDOC_DCN_JEOPARDY_STATUS
          where
            "DCN Jeopardy Status" = p_jeopardy_status
            or ("DCN Jeopardy Status" is null and p_jeopardy_status is null);
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
  
  
  -- Get record for Process Document insert XML.
  procedure GET_INS_PD_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_PD_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_PD_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    /*
    select '      extractValue(p_data_xml,''/ROWSET/ROW/CEMFD_ID'') "' || 'CEMFD_ID'|| '",' attr_element from dual
    union
    select '      extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
    union
    select '      extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
    from BPM_ATTRIBUTE_STAGING_TABLE bast
    inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
    where
      bast.BSL_ID = 9
      and atc.TABLE_NAME = 'CORP_ETL_MAILFAXDOC'
    order by attr_element asc;
    */
    select
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CLASSIFY_FORM_DOC_MANUAL') "ASED_CLASSIFY_FORM_DOC_MANUAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_AND_ROUTE_WORK') "ASED_CREATE_AND_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_IA_TASK') "ASED_CREATE_IA_TASK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_LINK_IMAGES_MANUAL') "ASED_LINK_IMAGES_MANUAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CLASSIFY_FORM_DOC_MANUAL') "ASF_CLASSIFY_FORM_DOC_MANUAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_AND_ROUTE_WORK') "ASF_CREATE_AND_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_IA_TASK') "ASF_CREATE_IA_TASK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_LINK_IMAGES_MANUAL') "ASF_LINK_IMAGES_MANUAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CLASSIFY_FORM_DOC_MANUAL') "ASSD_CLASSIFY_FORM_DOC_MANUAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_AND_ROUTE_WORK') "ASSD_CREATE_AND_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_IA_TASK') "ASSD_CREATE_IA_TASK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_LINK_IMAGES_MANUAL') "ASSD_LINK_IMAGES_MANUAL",
      extractValue(p_data_xml,'/ROWSET/ROW/AUTOLINK_FAILURE_REASON') "AUTOLINK_FAILURE_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_CHANNEL') "BATCH_CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_NAME') "BATCH_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CEMFD_ID') "CEMFD_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/DCN') "DCN",
      extractValue(p_data_xml,'/ROWSET/ROW/DCN_COUNT') "DCN_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/DCN_CREATE_DT') "DCN_CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/DCN_TIMELINESS_STATUS') "DCN_TIMELINESS_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_PAGE_COUNT') "DOCUMENT_PAGE_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_STATUS') "DOCUMENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_STATUS_DT') "DOCUMENT_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_TYPE') "DOCUMENT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/ECN') "ECN",
      extractValue(p_data_xml,'/ROWSET/ROW/FORM_TYPE') "FORM_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_AUTOLINK_OUTCOME') "GWF_AUTOLINK_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_DOCUMENT_BARCODED') "GWF_DOCUMENT_BARCODED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_DOC_CLASS_PRESENT') "GWF_DOC_CLASS_PRESENT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESCAN_REQUIRED') "GWF_RESCAN_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_WORK_IDENTIFIED') "GWF_WORK_IDENTIFIED",
      extractValue(p_data_xml,'/ROWSET/ROW/IA_MANUAL_CLASSIFY_TASK_ID') "IA_MANUAL_CLASSIFY_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/IA_MANUAL_LINK_TASK_ID') "IA_MANUAL_LINK_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LINK_METHOD') "LINK_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/LINK_NUMBER') "LINK_NUMBER",
      extractValue(p_data_xml,'/ROWSET/ROW/LINK_VIA') "LINK_VIA",
      extractValue(p_data_xml,'/ROWSET/ROW/ORIGINAL_DCN') "ORIGINAL_DCN",
      extractValue(p_data_xml,'/ROWSET/ROW/RESCANNED') "RESCANNED",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/WORK_TASK_ID') "WORK_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/WORK_TASK_TYPE_CREATED') "WORK_TASK_TYPE_CREATED"
    into p_data_record
    from dual;
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
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
    /*
    select '      extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
    union
    select '      extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
    from BPM_ATTRIBUTE_STAGING_TABLE bast
    inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
    where
      bast.BSL_ID = 9
      and atc.TABLE_NAME = 'CORP_ETL_MAILFAXDOC'
    order by attr_element asc;
    */
    select
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CLASSIFY_FORM_DOC_MANUAL') "ASED_CLASSIFY_FORM_DOC_MANUAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_AND_ROUTE_WORK') "ASED_CREATE_AND_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_IA_TASK') "ASED_CREATE_IA_TASK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_LINK_IMAGES_MANUAL') "ASED_LINK_IMAGES_MANUAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CLASSIFY_FORM_DOC_MANUAL') "ASF_CLASSIFY_FORM_DOC_MANUAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_AND_ROUTE_WORK') "ASF_CREATE_AND_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_IA_TASK') "ASF_CREATE_IA_TASK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_LINK_IMAGES_MANUAL') "ASF_LINK_IMAGES_MANUAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CLASSIFY_FORM_DOC_MANUAL') "ASSD_CLASSIFY_FORM_DOC_MANUAL",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_AND_ROUTE_WORK') "ASSD_CREATE_AND_ROUTE_WORK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_IA_TASK') "ASSD_CREATE_IA_TASK",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_LINK_IMAGES_MANUAL') "ASSD_LINK_IMAGES_MANUAL",
      extractValue(p_data_xml,'/ROWSET/ROW/AUTOLINK_FAILURE_REASON') "AUTOLINK_FAILURE_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_CHANNEL') "BATCH_CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/BATCH_NAME') "BATCH_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/DCN') "DCN",
      extractValue(p_data_xml,'/ROWSET/ROW/DCN_COUNT') "DCN_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/DCN_CREATE_DT') "DCN_CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/DCN_TIMELINESS_STATUS') "DCN_TIMELINESS_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_PAGE_COUNT') "DOCUMENT_PAGE_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_STATUS') "DOCUMENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_STATUS_DT') "DOCUMENT_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_TYPE') "DOCUMENT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/ECN') "ECN",
      extractValue(p_data_xml,'/ROWSET/ROW/FORM_TYPE') "FORM_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_AUTOLINK_OUTCOME') "GWF_AUTOLINK_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_DOCUMENT_BARCODED') "GWF_DOCUMENT_BARCODED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_DOC_CLASS_PRESENT') "GWF_DOC_CLASS_PRESENT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESCAN_REQUIRED') "GWF_RESCAN_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_WORK_IDENTIFIED') "GWF_WORK_IDENTIFIED",
      extractValue(p_data_xml,'/ROWSET/ROW/IA_MANUAL_CLASSIFY_TASK_ID') "IA_MANUAL_CLASSIFY_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/IA_MANUAL_LINK_TASK_ID') "IA_MANUAL_LINK_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LINK_METHOD') "LINK_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/LINK_NUMBER') "LINK_NUMBER",
      extractValue(p_data_xml,'/ROWSET/ROW/LINK_VIA') "LINK_VIA",
      extractValue(p_data_xml,'/ROWSET/ROW/ORIGINAL_DCN') "ORIGINAL_DCN",
      extractValue(p_data_xml,'/ROWSET/ROW/RESCANNED') "RESCANNED",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/WORK_TASK_ID') "WORK_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/WORK_TASK_TYPE_CREATED') "WORK_TASK_TYPE_CREATED"
      into p_data_record
    from dual;
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
      raise;
  end;
  
  
  -- Insert fact for BPM Semantic model - Process Mail Fax Doc.
    procedure INS_FPDBD
      (p_identifier in varchar2,
       p_start_date in date,
       p_end_date in date,
       p_bi_id in number,
       p_dmfdocdt_id in number,
       p_dmfdocb_id in number,
       p_dmfdocts_id in number,
       p_stg_last_update_date in varchar2,
       p_dmfdocds_id in number,
       p_dmfdocis_id in number,
       p_dmfdocdcnjs_id in number,
       p_document_status_dt in varchar2,
       p_fmfdocbd_id out number  )
    as
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FPDBD';
      v_sql_code number := null;
      v_log_message clob := null;
      v_bucket_start_date date := null;
      v_bucket_end_date date := null;
      v_stg_last_update_date date := null;
      v_receipt_date date := null;
      v_invoiceable_date date := null;
      v_document_status_dt date := null;
      v_dcn_jeopardy_status_dt date := null;
    begin
      v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      v_document_status_dt := to_date(p_document_status_dt,BPM_COMMON.DATE_FMT);
      v_dcn_jeopardy_status_dt := sysdate;
      p_fmfdocbd_id := SEQ_FMFDOCBD_ID.nextval;
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
      
      insert into F_MFDOC_BY_DATE
        (FMFDOCBD_ID,
         D_DATE,
         BUCKET_START_DATE,
         BUCKET_END_DATE,
         MFDOC_BI_ID,
         DMFDOCDT_ID,
         DMFDOCB_ID,
         DMFDOCTS_ID,
         CREATION_COUNT,
         INVENTORY_COUNT,
         COMPLETION_COUNT,
         DMFDOCDS_ID,
         DMFDOCIS_ID,
         DMFDOCDCNJS_ID,
         "Document Status Date" ,
          "DCN Jeopardy Status Date"
          )
      values
        (p_fmfdocbd_id,
         p_start_date,
         v_bucket_start_date,
         v_bucket_end_date,
         p_bi_id,
         p_dmfdocdt_id,
         p_dmfdocb_id,
         p_dmfdocts_id,
         1,
         case
         when p_end_date is null then 1
         else 0
         end,
         case
           when p_end_date is null then 0
           else 1
           end,
         p_dmfdocds_id,
         p_dmfdocis_id,
         p_dmfdocdcnjs_id,
         v_document_status_dt,
         v_dcn_jeopardy_status_dt
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
    v_new_data T_INS_PD_XML := null;
  begin
    if p_data_version > 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for ILEB process mail fax doc in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;
    GET_INS_PD_XML(p_new_data_xml,v_new_data);
    v_bi_id := SEQ_BI_ID.nextval;
    v_step := 'In bpm insert '|| v_bi_id;
    v_identifier := v_new_data.DCN;
    v_start_date := to_date(v_new_data.DCN_CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    insert into BPM_INSTANCE
      (BI_ID,BEM_ID,IDENTIFIER,BIL_ID,BSL_ID,
       START_DATE,END_DATE,SOURCE_ID,CREATION_DATE,LAST_UPDATE_DATE)
    values
      (v_bi_id,v_bem_id,v_identifier,v_bil_id,v_bsl_id,
       v_start_date,v_end_date,to_char(v_new_data.CEMFD_ID),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT));
    commit;
    v_bue_id := SEQ_BUE_ID.nextval;
    insert into BPM_UPDATE_EVENT
      (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
    values
      (v_bue_id,v_bi_id,v_butl_id,to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),'N');
 /*   select 'BPM_EVENT.INSERT_BIA(v_bi_id, '||b.ba_id || ','||bl.bdl_id || ',v_new_data.'|| stg.staging_table_column || ',v_start_date,v_bue_id);'
      from bpm_attribute b, bpm_attribute_lkup bl,MAXDAT.bpm_attribute_staging_table stg
      where b.bal_id = bl.bal_id
      and stg.ba_id = b.ba_id
      and b.when_populated in ('CREATE','BOTH')
      and b.bem_id = 9
      and bsl_id = 9
      order by b.ba_id*/
    BPM_EVENT.INSERT_BIA(v_bi_id, 522,1,v_new_data.DCN,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 523,3,v_new_data.DCN_CREATE_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 524,2,v_new_data.BATCH_NAME,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 525,2,v_new_data.BATCH_CHANNEL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 526,2,v_new_data.ECN,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 527,1,v_new_data.ORIGINAL_DCN,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 528,2,v_new_data.RESCANNED,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 529,1,v_new_data.DOCUMENT_PAGE_COUNT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 530,2,v_new_data.DOCUMENT_STATUS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 531,3,v_new_data.DOCUMENT_STATUS_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 532,1,v_new_data.DCN_COUNT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 533,2,v_new_data.FORM_TYPE,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 534,2,v_new_data.DOCUMENT_TYPE,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 535,2,v_new_data.AUTOLINK_FAILURE_REASON,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 536,3,v_new_data.ASSD_CREATE_IA_TASK,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 537,3,v_new_data.ASED_CREATE_IA_TASK,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 538,1,v_new_data.IA_MANUAL_CLASSIFY_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 539,1,v_new_data.IA_MANUAL_LINK_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 540,3,v_new_data.ASSD_LINK_IMAGES_MANUAL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 541,3,v_new_data.ASED_LINK_IMAGES_MANUAL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 542,3,v_new_data.ASSD_CLASSIFY_FORM_DOC_MANUAL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 543,3,v_new_data.ASED_CLASSIFY_FORM_DOC_MANUAL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 544,3,v_new_data.ASSD_CREATE_AND_ROUTE_WORK,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 545,3,v_new_data.ASED_CREATE_AND_ROUTE_WORK,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 546,1,v_new_data.WORK_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 547,2,v_new_data.WORK_TASK_TYPE_CREATED,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 548,3,v_new_data.CANCEL_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 549,2,v_new_data.LINK_METHOD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 550,2,v_new_data.LINK_VIA,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 551,1,v_new_data.LINK_NUMBER,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 552,2,v_new_data.GWF_DOCUMENT_BARCODED,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 553,2,v_new_data.ASF_CREATE_IA_TASK,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 554,2,v_new_data.ASF_CLASSIFY_FORM_DOC_MANUAL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 555,2,v_new_data.ASF_LINK_IMAGES_MANUAL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 556,2,v_new_data.ASF_CREATE_AND_ROUTE_WORK,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 557,2,v_new_data.GWF_AUTOLINK_OUTCOME,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 558,2,v_new_data.GWF_RESCAN_REQUIRED,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 559,2,v_new_data.GWF_DOC_CLASS_PRESENT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 560,2,v_new_data.GWF_WORK_IDENTIFIED,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 561,2,v_new_data.DCN_TIMELINESS_STATUS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 563,3,v_new_data.INSTANCE_COMPLETE_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 562,2,v_new_data.INSTANCE_STATUS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 1683,2,v_new_data.CANCEL_METHOD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 1684,2,v_new_data.CANCEL_REASON,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 1685,2,v_new_data.CANCEL_BY,v_start_date,v_bue_id);
    commit;
    p_bue_id := v_bue_id;
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM || v_step;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
  end;
  
  
  -- Insert or update dimension for BPM Semantic model - Process Mail Fax Doc - Current.
  procedure SET_DPDCUR
    (p_set_type in varchar2,
     p_identifier in varchar2,
     p_bi_id in number,
     p_DCN in varchar2,
     p_dcn_create_date in varchar2,
     p_instance_status in varchar2,
     p_instance_complete_date in varchar2,
     p_batch_name in varchar2,
     p_channel in varchar2,
     p_ECN in varchar2,
     p_original_dcn in varchar2,
     p_rescanned in varchar2,
     p_document_page_count in varchar2,
     p_document_status in varchar2,
     p_document_status_date in varchar2,
     p_dcn_count in varchar2,
     p_document_barcode_flag in varchar2,
     p_document_form_type in varchar2,
     p_document_type in varchar2,
     p_autolink_outcome_flag in varchar2,
     p_autolink_failure_reason in varchar2,
     p_create_ia_task_start in varchar2,
     p_create_ia_task_end in varchar2,
     p_create_ia_task_end_flag in varchar2,
     p_ia_manual_classify_task_id in varchar2,
     p_ia_manual_link_task_id in varchar2,
     p_rescan_required_flag in varchar2,
     p_doc_class_Present_flag in varchar2,
     p_manual_link_image_start in varchar2,
     p_manual_link_image_end in varchar2,
     p_manual_link_image_end_flag in varchar2,
     p_classify_form_doc_start in varchar2,
     p_classify_form_doc_end in varchar2,
     p_classify_form_doc_flag in varchar2,
     p_create_and_route_work_start in varchar2,
     p_create_and_route_work_end in varchar2,
     p_create_route_work_flag in varchar2,
     p_work_identified_flag in varchar2,
     p_work_task_id in varchar2,
     p_work_task_type in varchar2,
     p_cancel_dt in varchar2,
     p_link_method in varchar2,
     p_link_via in varchar2,
     p_link_number in varchar2,
     p_cancel_method in varchar2,
     p_cancel_reason in varchar2,
     p_cancel_by in varchar2
     )
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DPDCUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dpdcur D_MFDOC_CURRENT%rowtype := null;
    v_jeopardy_flag varchar2(1) := null;
  begin
  
      
   r_dpdcur."DCN" := p_DCN;
    r_dpdcur.MFDOC_BI_ID := p_bi_id;
    r_dpdcur."DCN Create Date" :=to_date( p_dcn_create_date,BPM_COMMON.DATE_FMT);
    r_dpdcur."Instance Status" := p_instance_status;
    r_dpdcur."Instance Complete Date" := to_date( p_instance_complete_date,BPM_COMMON.DATE_FMT);
    r_dpdcur."Batch Name" := p_batch_name;
    r_dpdcur.CHANNEL := p_channel;
    r_dpdcur."Age in Business Days" := GET_AGE_IN_BUSINESS_DAYS(to_date(p_dcn_create_date,BPM_COMMON.DATE_FMT),sysdate);
    r_dpdcur."Age in Calendar Days" := GET_AGE_IN_CALENDAR_DAYS(to_date(p_dcn_create_date,BPM_COMMON.DATE_FMT),sysdate);
    r_dpdcur."DCN Jeopardy Status" := GET_DCN_JEOPARDY_STATUS(to_date(p_dcn_create_date,BPM_COMMON.DATE_FMT),p_document_type);
    r_dpdcur."DCN Jeopardy Status Date" := sysdate;
    r_dpdcur."DCN Timeliness Status" := GET_TIMELINESS_STATUS(to_date(p_dcn_create_date,BPM_COMMON.DATE_FMT),p_document_type);
    r_dpdcur."ECN" := p_ECN;
	  r_dpdcur."Original DCN" := p_original_dcn;
	  r_dpdcur.RESCANNED := p_rescanned;
	  r_dpdcur."Document Page Count" := p_document_page_count;
	  r_dpdcur."Document Status" := p_document_status;
    r_dpdcur."Document Status Date" := to_date(p_document_status_date,BPM_COMMON.DATE_FMT);
    r_dpdcur."DCN Count" := p_dcn_count;
    r_dpdcur."Document Barcode Flag" := p_document_barcode_flag;
    r_dpdcur."Document Form Type" := p_document_form_type;
    r_dpdcur."Document Type" := p_document_type;
    r_dpdcur."Autolink Outcome Flag" := p_autolink_outcome_flag;
    r_dpdcur."Autolink Failure Reason" := p_autolink_failure_reason;
    r_dpdcur."Create IA Task Start" := to_date( p_create_ia_task_start,BPM_COMMON.DATE_FMT);
    r_dpdcur."Create IA Task End" := to_date( p_create_ia_task_end,BPM_COMMON.DATE_FMT);
    r_dpdcur."Create IA Task End Flag" := p_create_ia_task_end_flag;
    r_dpdcur."IA Manual Classify Task ID" := p_ia_manual_classify_task_id;
    r_dpdcur."IA Manual Link Task ID" := p_ia_manual_link_task_id;
    r_dpdcur."Rescan Required Flag" := p_rescan_required_flag;
    r_dpdcur."Doc Class Present Flag" := p_doc_class_Present_flag;
    r_dpdcur."Manual Link Image Start" := to_date(p_manual_link_image_start,BPM_COMMON.DATE_FMT);
    r_dpdcur."Manual Link Image End" := to_date(p_manual_link_image_end,BPM_COMMON.DATE_FMT);
    r_dpdcur."Manual Link Image End Flag" := p_manual_link_image_end_flag;
    r_dpdcur."Manual Classify Form Doc Start" := to_date(p_classify_form_doc_start,BPM_COMMON.DATE_FMT);
    r_dpdcur."Manual Classify Form Doc End" := to_date(p_classify_form_doc_end,BPM_COMMON.DATE_FMT);
    r_dpdcur."Manual Classify Form Doc Flag" := p_classify_form_doc_flag;
    r_dpdcur."Create and Route Work Start" := to_date(p_create_and_route_work_start,BPM_COMMON.DATE_FMT);
    r_dpdcur."Create and Route Work End" := to_date(p_create_and_route_work_end,BPM_COMMON.DATE_FMT);
    r_dpdcur."Create Route Work Flag" := p_create_route_work_flag;
    r_dpdcur."Work Identified Flag" := p_work_identified_flag;
    r_dpdcur."Work Task ID" := p_work_task_id;
    r_dpdcur."Work Task Type" := p_work_task_type;
    r_dpdcur."Cancel Document Processing End" := to_date(p_cancel_dt,BPM_COMMON.DATE_FMT);
    r_dpdcur."Link Method" := p_link_method;
    r_dpdcur."Link Via" := p_link_via;
    r_dpdcur."Link Number" := p_link_number;
    r_dpdcur."Cancel Method"  := p_cancel_method;
    r_dpdcur."Cancel Reason"  := p_cancel_reason;
    r_dpdcur."Cancel By"      := p_cancel_by;
    
    if p_set_type = 'INSERT' then
      insert into D_MFDOC_CURRENT
      values r_dpdcur;
    elsif p_set_type = 'UPDATE' then
      begin
        update D_MFDOC_CURRENT
        set row = r_dpdcur
        where MFDOC_BI_ID = p_bi_id;
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
    v_new_data T_INS_PD_XML := null;
    v_bi_id number := null;
    v_identifier varchar2(35) := null;
    v_start_date date := null;
    v_end_date date := null;
    v_dmfdocdt_id number := null;
    v_dmfdocb_id number := null;
    v_dmfdocts_id number := null;
    v_dmfdocds_id number := null;
    v_dmfdocis_id number:= null;
    v_dmfdocdcnjs_id number:=null;
    v_fmfdocbd_id number := null;
  begin
    if p_data_version > 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for ILEB Process Mail Fax Doc in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;
    GET_INS_PD_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.DCN;
    v_start_date := to_date(v_new_data.DCN_CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    select BI_ID
    into v_bi_id
    from BPM_INSTANCE
    where
      IDENTIFIER = v_identifier
      and BEM_ID = v_bem_id
      and BSL_ID = v_bsl_id;
    GET_DMFDOCDT_ID(v_identifier,v_bi_id,v_new_data.document_type,v_dmfdocdt_id);
    GET_DMFDOCB_ID(v_identifier,v_bi_id,v_new_data.batch_name,v_new_data.batch_channel,v_dmfdocb_id);
    GET_DMFDOCTS_ID(v_identifier,v_bi_id,GET_TIMELINESS_STATUS(to_date(v_new_data.dcn_create_dt,BPM_COMMON.DATE_FMT),v_new_data.document_type),v_dmfdocts_id);
    GET_DMFDOCDS_ID(v_identifier,v_bi_id,v_new_data.document_status,v_dmfdocds_id );
    GET_DMFDOCIS_ID(v_identifier,v_bi_id,v_new_data.instance_status,v_dmfdocis_id );
    GET_DMFDOCDCNJS_ID(v_identifier,v_bi_id,GET_DCN_JEOPARDY_STATUS(to_date(v_new_data.dcn_create_dt,BPM_COMMON.DATE_FMT),v_new_data.document_type),v_dmfdocdcnjs_id);
   
    -- Insert current dimension and fact as a single transaction.
    begin
      commit;
      SET_DPDCUR
        ('INSERT',v_identifier,v_bi_id
          ,v_new_data.dcn	,v_new_data.dcn_create_dt,v_new_data.instance_status,v_new_data.instance_complete_dt,v_new_data.batch_name
          ,v_new_data.batch_channel,v_new_data.ecn,v_new_data.original_dcn,v_new_data.rescanned	,v_new_data.document_page_count
          ,v_new_data.document_status,v_new_data.document_status_dt,v_new_data.dcn_count,v_new_data.gwf_document_barcoded
          ,v_new_data.form_type,v_new_data.document_type,v_new_data.gwf_autolink_outcome
          ,v_new_data.autolink_failure_reason,v_new_data.assd_create_ia_task,v_new_data.ased_create_ia_task,v_new_data.asf_create_ia_task
          ,v_new_data.ia_manual_classify_task_id,v_new_data.ia_manual_link_task_id,v_new_data.gwf_rescan_required	,v_new_data.gwf_doc_class_present
          ,v_new_data.assd_link_images_manual,v_new_data.ased_link_images_manual,v_new_data.asf_link_images_manual,v_new_data.assd_classify_form_doc_manual
          ,v_new_data.ased_classify_form_doc_manual,v_new_data.asf_classify_form_doc_manual,v_new_data.assd_create_and_route_work
          ,v_new_data.ased_create_and_route_work,v_new_data.asf_create_and_route_work,v_new_data.gwf_work_identified,v_new_data.work_task_id
          ,v_new_data.work_task_type_created	,v_new_data.cancel_dt,v_new_data.link_method,v_new_data.link_via,v_new_data.link_number
          ,v_new_data.cancel_method,v_new_data.cancel_reason,v_new_data.cancel_by
        );
      INS_FPDBD
        (v_identifier,v_start_date,v_end_date,v_bi_id,
          v_dmfdocdt_id,v_dmfdocb_id,v_dmfdocts_id,v_new_data.stg_last_update_date,
          v_dmfdocds_id,v_dmfdocis_id,v_dmfdocdcnjs_id,v_new_data.document_status_dt,v_fmfdocbd_id);
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
  
  
  -- Update fact for BPM Semantic model -ILEB Process Mail fax doc process.
  procedure UPD_FPDBD
    (p_identifier in varchar2,
     p_end_date in date,
     p_bi_id in number,
     p_dmfdocdt_id in number,
     p_dmfdocb_id in number,
     p_dmfdocts_id in number,
     p_dmfdocds_id in number,
     p_dmfdocis_id in number,
     p_dmfdocdcnjs_id in number,
     p_stg_last_update_date in varchar2,
     p_document_status_date in varchar2,
     p_fmfdocbd_id out number
 )
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FPDBD';
    v_sql_code number := null;
    v_log_message clob := null;
    v_fmfdocbd_id_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;
    v_invoiceable_date date := null;
    v_event_date date := null;
    v_dmfdocdt_id number := null;
    v_dmfdocb_id number := null;
    v_dmfdocts_id number := null;
    v_dmfdocds_id number := null;
    v_dmfdocis_id number := null;
    v_dmfdocdcnjs_id number := null;
    v_fmfdocbd_id number := null;
    v_document_status_date date:= null;
    v_document_jeop_status_dt date:= null;
    r_fnpdbd F_MFDOC_BY_DATE%rowtype := null;
  begin
    v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
    v_event_date := v_stg_last_update_date;
    v_document_status_date := to_date(p_document_status_date,BPM_COMMON.DATE_FMT);
    v_document_jeop_status_dt := sysdate;
    v_dmfdocdt_id := p_dmfdocdt_id;
    v_dmfdocb_id  := p_dmfdocb_id;
    v_dmfdocts_id := p_dmfdocts_id;
    v_dmfdocds_id := p_dmfdocds_id;
    v_dmfdocis_id := p_dmfdocis_id;
    v_dmfdocdcnjs_id := p_dmfdocdcnjs_id;
    with most_recent_fact_bi_id as
      (select
         max(FMFDOCBD_ID) max_fmfdocbd_id,
         max(D_DATE) max_d_date
       from F_MFDOC_BY_DATE
       where MFDOC_BI_ID = p_bi_id)
    select
      fnpdbd.FMFDOCBD_ID,
      fnpdbd.D_DATE,
      fnpdbd.CREATION_COUNT,
      fnpdbd.COMPLETION_COUNT,
      most_recent_fact_bi_id.max_d_date
    into
      v_fmfdocbd_id_old,
      v_d_date_old,
      v_creation_count_old,
      v_completion_count_old,
      v_max_d_date
    from
      F_MFDOC_BY_DATE fnpdbd,
      most_recent_fact_bi_id
    where
      fnpdbd.FMFDOCBD_ID = max_fmfdocbd_id
      and fnpdbd.D_DATE = most_recent_fact_bi_id.max_d_date;
    -- Do not modify fact table further once an instance has completed ever before.
    
    if v_completion_count_old >= 1 then
      return;
    end if;
    -- Handle case were update to staging table incorrectly has older LAST_UPDATE_DATE.
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
        delete from F_MFDOC_BY_DATE
        where
          MFDOC_BI_ID = p_bi_id
          and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
    with most_recent_fact_bi_id as
      (select
         max(FMFDOCBD_ID) max_fmfdocbd_id,
         max(D_DATE) max_d_date
         from F_MFDOC_BY_DATE
         where MFDOC_BI_ID = p_bi_id)
        select
          fnpdbd.FMFDOCBD_ID,
          fnpdbd.D_DATE,
          fnpdbd.CREATION_COUNT,
          fnpdbd.COMPLETION_COUNT,
          most_recent_fact_bi_id.max_d_date,
          fnpdbd.DMFDOCDT_ID,
          fnpdbd.DMFDOCB_ID,
          fnpdbd.DMFDOCTS_ID,
          fnpdbd.DMFDOCDS_ID,
          fnpdbd.DMFDOCIS_ID,
          fnpdbd.DMFDOCDCNJS_ID
          into
          v_fmfdocbd_id_old,
          v_d_date_old,
          v_creation_count_old,
          v_completion_count_old,
          v_max_d_date,
          v_dmfdocdt_id,
          v_dmfdocb_id,
          v_dmfdocts_id,
          v_dmfdocds_id,
          v_dmfdocis_id,
          v_dmfdocdcnjs_id
         from
          F_MFDOC_BY_DATE fnpdbd,
          most_recent_fact_bi_id
        where
          fnpdbd.FMFDOCBD_ID = max_fmfdocbd_id
          and fnpdbd.D_DATE = most_recent_fact_bi_id.max_d_date;
      end if;
      r_fnpdbd.D_DATE := p_end_date;
      r_fnpdbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpdbd.BUCKET_END_DATE := r_fnpdbd.BUCKET_START_DATE;
      r_fnpdbd.INVENTORY_COUNT := 0;
      r_fnpdbd.COMPLETION_COUNT := 1;
    end if;


    p_fmfdocbd_id := SEQ_FMFDOCBD_ID.nextval;
    r_fnpdbd.FMFDOCBD_ID := p_fmfdocbd_id;
    r_fnpdbd.MFDOC_BI_ID := p_bi_id;
    r_fnpdbd.DMFDOCDT_ID := v_dmfdocdt_id;
    r_fnpdbd.DMFDOCB_ID := v_dmfdocb_id;
    r_fnpdbd.DMFDOCTS_ID := v_dmfdocts_id;
    r_fnpdbd.CREATION_COUNT := 0;
    r_fnpdbd.DMFDOCDS_ID := v_dmfdocds_id;
    r_fnpdbd.DMFDOCIS_ID := v_dmfdocis_id;
    r_fnpdbd.DMFDOCDCNJS_ID := v_dmfdocdcnjs_id;
    r_fnpdbd."Document Status Date" := v_document_status_date;
    r_fnpdbd."DCN Jeopardy Status Date" := v_document_jeop_status_dt;
    
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
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
    
    if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fnpdbd.BUCKET_START_DATE then
      -- Same bucket time.
        if v_creation_count_old = 1 then
          r_fnpdbd.CREATION_COUNT := v_creation_count_old;
        end if;
        update F_MFDOC_BY_DATE
        set row = r_fnpdbd
        where FMFDOCBD_ID = v_fmfdocbd_id_old;
    else
      -- Different bucket time.

      update F_MFDOC_BY_DATE
      set BUCKET_END_DATE = r_fnpdbd.BUCKET_START_DATE
      where FMFDOCBD_ID = v_fmfdocbd_id_old;
      insert into F_MFDOC_BY_DATE
      values r_fnpdbd;
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
    v_old_data T_UPD_PD_XML := null;
    v_new_data T_UPD_PD_XML := null;
  begin
    if p_data_version > 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" with ILEB Process mail fax doc in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;
    GET_UPD_PD_XML(p_old_data_xml,v_old_data);
    GET_UPD_PD_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.DCN;
    v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
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
    /*select 'BPM_EVENT.UPDATE_BIA(v_bi_id, ' ||b.ba_id || ','||bl.bdl_id || ','||''''||b.retain_history_flag||''''||',v_old_data.'|| stg.staging_table_column ||
        ',v_new_data.'|| stg.staging_table_column ||
      ','||'v_bue_id,v_stg_last_update_date);'
    from bpm_attribute b, bpm_attribute_lkup bl,MAXDAT.bpm_attribute_staging_table stg
    where b.bal_id = bl.bal_id
    and stg.ba_id = b.ba_id
    and b.when_populated in ('UPDATE','BOTH')
    and b.bem_id = 9
    and bsl_id = 9
    order by b.ba_id*/
   BPM_EVENT.UPDATE_BIA(v_bi_id, 530,2,'Y',v_old_data.DOCUMENT_STATUS,v_new_data.DOCUMENT_STATUS,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 531,3,'Y',v_old_data.DOCUMENT_STATUS_DT,v_new_data.DOCUMENT_STATUS_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 532,1,'N',v_old_data.DCN_COUNT,v_new_data.DCN_COUNT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 533,2,'N',v_old_data.FORM_TYPE,v_new_data.FORM_TYPE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 534,2,'N',v_old_data.DOCUMENT_TYPE,v_new_data.DOCUMENT_TYPE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 535,2,'N',v_old_data.AUTOLINK_FAILURE_REASON,v_new_data.AUTOLINK_FAILURE_REASON,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 536,3,'N',v_old_data.ASSD_CREATE_IA_TASK,v_new_data.ASSD_CREATE_IA_TASK,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 537,3,'N',v_old_data.ASED_CREATE_IA_TASK,v_new_data.ASED_CREATE_IA_TASK,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 538,1,'N',v_old_data.IA_MANUAL_CLASSIFY_TASK_ID,v_new_data.IA_MANUAL_CLASSIFY_TASK_ID,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 539,1,'N',v_old_data.IA_MANUAL_LINK_TASK_ID,v_new_data.IA_MANUAL_LINK_TASK_ID,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 540,3,'N',v_old_data.ASSD_LINK_IMAGES_MANUAL,v_new_data.ASSD_LINK_IMAGES_MANUAL,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 541,3,'N',v_old_data.ASED_LINK_IMAGES_MANUAL,v_new_data.ASED_LINK_IMAGES_MANUAL,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 542,3,'N',v_old_data.ASSD_CLASSIFY_FORM_DOC_MANUAL,v_new_data.ASSD_CLASSIFY_FORM_DOC_MANUAL,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 543,3,'N',v_old_data.ASED_CLASSIFY_FORM_DOC_MANUAL,v_new_data.ASED_CLASSIFY_FORM_DOC_MANUAL,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 544,3,'N',v_old_data.ASSD_CREATE_AND_ROUTE_WORK,v_new_data.ASSD_CREATE_AND_ROUTE_WORK,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 545,3,'N',v_old_data.ASED_CREATE_AND_ROUTE_WORK,v_new_data.ASED_CREATE_AND_ROUTE_WORK,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 546,1,'N',v_old_data.WORK_TASK_ID,v_new_data.WORK_TASK_ID,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 547,2,'N',v_old_data.WORK_TASK_TYPE_CREATED,v_new_data.WORK_TASK_TYPE_CREATED,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 548,3,'N',v_old_data.CANCEL_DT,v_new_data.CANCEL_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 549,2,'N',v_old_data.LINK_METHOD,v_new_data.LINK_METHOD,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 550,2,'N',v_old_data.LINK_VIA,v_new_data.LINK_VIA,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 551,1,'N',v_old_data.LINK_NUMBER,v_new_data.LINK_NUMBER,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 552,2,'N',v_old_data.GWF_DOCUMENT_BARCODED,v_new_data.GWF_DOCUMENT_BARCODED,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 553,2,'N',v_old_data.ASF_CREATE_IA_TASK,v_new_data.ASF_CREATE_IA_TASK,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 554,2,'N',v_old_data.ASF_CLASSIFY_FORM_DOC_MANUAL,v_new_data.ASF_CLASSIFY_FORM_DOC_MANUAL,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 555,2,'N',v_old_data.ASF_LINK_IMAGES_MANUAL,v_new_data.ASF_LINK_IMAGES_MANUAL,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 556,2,'N',v_old_data.ASF_CREATE_AND_ROUTE_WORK,v_new_data.ASF_CREATE_AND_ROUTE_WORK,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 557,2,'N',v_old_data.GWF_AUTOLINK_OUTCOME,v_new_data.GWF_AUTOLINK_OUTCOME,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 558,2,'N',v_old_data.GWF_RESCAN_REQUIRED,v_new_data.GWF_RESCAN_REQUIRED,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 559,2,'N',v_old_data.GWF_DOC_CLASS_PRESENT,v_new_data.GWF_DOC_CLASS_PRESENT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 560,2,'N',v_old_data.GWF_WORK_IDENTIFIED,v_new_data.GWF_WORK_IDENTIFIED,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 561,2,'Y',v_old_data.DCN_TIMELINESS_STATUS,v_new_data.DCN_TIMELINESS_STATUS,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 563,3,'Y',v_old_data.INSTANCE_COMPLETE_DT,v_new_data.INSTANCE_COMPLETE_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 562,2,'Y',v_old_data.INSTANCE_STATUS,v_new_data.INSTANCE_STATUS,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 1683,2,'N',v_old_data.CANCEL_METHOD,v_new_data.CANCEL_METHOD,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 1684,2,'N',v_old_data.CANCEL_REASON,v_new_data.CANCEL_REASON,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 1685,2,'N',v_old_data.CANCEL_BY,v_new_data.CANCEL_BY,v_bue_id,v_stg_last_update_date);

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
    v_old_data T_UPD_PD_XML := null;
    v_new_data T_UPD_PD_XML := null;
    v_bi_id number := null;
    v_identifier varchar2(35) := null;
    v_start_date date := null;
    v_end_date date := null;
    v_dmfdocdt_id number := null;
    v_dmfdocb_id number := null;
    v_dmfdocts_id number := null;
    v_dmfdocds_id number := null;
    v_dmfdocis_id number := null;
    v_dmfdocdcnjs_id number := null;
    v_fmfdocbd_id number := null;
  begin
    if p_data_version > 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for ILEB Process Mail fax doc in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;
    GET_UPD_PD_XML(p_old_data_xml,v_old_data);
    GET_UPD_PD_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.DCN;
    v_start_date := to_date(v_new_data.DCN_CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    select BI_ID into v_bi_id
    from BPM_INSTANCE
    where
      IDENTIFIER = v_identifier
      and BEM_ID = v_bem_id
      and BSL_ID = v_bsl_id;
    GET_DMFDOCDT_ID(v_identifier,v_bi_id,v_new_data.document_type,v_dmfdocdt_id);
    GET_DMFDOCB_ID(v_identifier,v_bi_id,v_new_data.batch_name,v_new_data.batch_channel,v_dmfdocb_id);
    GET_DMFDOCTS_ID(v_identifier,v_bi_id,GET_TIMELINESS_STATUS(to_date(v_new_data.dcn_create_dt,BPM_COMMON.DATE_FMT),v_new_data.document_type),v_dmfdocts_id);
    GET_DMFDOCDS_ID(v_identifier,v_bi_id,v_new_data.document_status,v_dmfdocds_id );
    GET_DMFDOCIS_ID(v_identifier,v_bi_id,v_new_data.instance_status,v_dmfdocis_id );
    GET_DMFDOCDCNJS_ID(v_identifier,v_bi_id,GET_DCN_JEOPARDY_STATUS(to_date(v_new_data.dcn_create_dt,BPM_COMMON.DATE_FMT),v_new_data.document_type),v_dmfdocdcnjs_id);

    -- Update current dimension and fact as a single transaction.
    begin
      commit;
      SET_DPDCUR
        ('UPDATE',v_identifier,v_bi_id
         ,v_new_data.dcn	,v_new_data.dcn_create_dt,v_new_data.instance_status,v_new_data.instance_complete_dt,v_new_data.batch_name
          ,v_new_data.batch_channel,v_new_data.ecn,v_new_data.original_dcn,v_new_data.rescanned	,v_new_data.document_page_count
          ,v_new_data.document_status,v_new_data.document_status_dt,v_new_data.dcn_count,v_new_data.gwf_document_barcoded
          ,v_new_data.form_type,v_new_data.document_type,v_new_data.gwf_autolink_outcome
          ,v_new_data.autolink_failure_reason,v_new_data.assd_create_ia_task,v_new_data.ased_create_ia_task,v_new_data.asf_create_ia_task
          ,v_new_data.ia_manual_classify_task_id,v_new_data.ia_manual_link_task_id,v_new_data.gwf_rescan_required	,v_new_data.gwf_doc_class_present
          ,v_new_data.assd_link_images_manual,v_new_data.ased_link_images_manual,v_new_data.asf_link_images_manual,v_new_data.assd_classify_form_doc_manual
          ,v_new_data.ased_classify_form_doc_manual,v_new_data.asf_classify_form_doc_manual,v_new_data.assd_create_and_route_work
          ,v_new_data.ased_create_and_route_work,v_new_data.asf_create_and_route_work,v_new_data.gwf_work_identified,v_new_data.work_task_id
          ,v_new_data.work_task_type_created	,v_new_data.cancel_dt,v_new_data.link_method,v_new_data.link_via,v_new_data.link_number
          ,v_new_data.cancel_method,v_new_data.cancel_reason,v_new_data.cancel_by
         );
      UPD_FPDBD
        (v_identifier,v_end_date,v_bi_id,v_dmfdocdt_id,v_dmfdocb_id,v_dmfdocts_id,
          v_dmfdocds_id,v_dmfdocis_id,v_dmfdocdcnjs_id,v_new_data.stg_last_update_date,
          v_new_data.document_status_dt,v_fmfdocbd_id);
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