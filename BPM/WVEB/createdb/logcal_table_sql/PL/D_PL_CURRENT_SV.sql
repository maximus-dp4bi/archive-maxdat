select 
  letter_request_id
  ,CREATE_DATE
  ,CREATED_BY
  ,request_date
  ,instance_status 
  ,letter_type
  ,letter_type_code
  ,program
  ,CASE_ID
  ,county_code
  ,zip_code
  ,language
  ,reprint
  ,request_driver_type
  ,request_driver_table
  ,letter_status
  ,letter_status_date
  ,sent_date
  ,print_date
  ,MAILED_DATE
  ,RETURN_DATE
  ,return_reason
  ,rejection_reason
  ,request_error_reason
  ,transmitted_file_name
  ,transmitted_file_date
  ,letter_response_file_name
  ,letter_response_file_date
  ,last_update_date
  ,last_updated_by_name
  ,task_id
  ,cancel_date
  ,cancel_by
  ,complete_date 
  ,send_to_mail_house_end_date
  ,receive_confirm_end_date
  ,(case 
     when CREATE_DATE is not null and complete_date is not null then 
      (select case when (count(*)-1) < 0 then 0 else count(*)-1 end 
       from MAXDAT_LOOKUP.D_DATES
       where 
         BUSINESS_DAY_FLAG = 'Y'
         and D_DATE between CREATE_DATE and complete_date) 
     else 0 
     end ) age_in_business_days
  ,trunc(complete_date) - trunc(CREATE_DATE) age_in_calendar_days
  ,case
     when sla_category = 'Other' then 'NA'
     when
       sla_category in ('New Enrollment','Newly Eligible Newborn')
       and
       (select case when (count(*) -1 ) < 0 then 0 else count(*) - 1 end 
        from MAXDAT_LOOKUP.D_DATES
        where 
          BUSINESS_DAY_FLAG = 'Y'
          and D_DATE between create_date and coalesce(complete_date,sysdate))
        <= 
       (select /*+ RESULT_CACHE +*/ OUT_VAR
        from MAXDAT_LOOKUP.CORP_ETL_LIST_LKUP
        where 
          REF_TYPE = 'LETTER_TYPE'
          and NAME = 'ProcLetters_SLA_Days'
          and VALUE = sla_category) 
       then 'Timely'
     else 'Untimely'
     end timeliness_status
   ,case
     when
       complete_date is null
       and
       (select case when (count(*) -1 ) < 0 then 0 else count(*) - 1 end 
        from MAXDAT_LOOKUP.D_DATES
        where 
          BUSINESS_DAY_FLAG = 'Y'
          and D_DATE between create_date and sysdate)
        > 
       (select /*+ RESULT_CACHE +*/ OUT_VAR
        from MAXDAT_LOOKUP.CORP_ETL_LIST_LKUP
        where 
          REF_TYPE = 'LETTER_TYPE'
          and NAME = 'ProcLetters_SLA_Jeopardy_Days'
          and VALUE = sla_category) 
       then 'Y'
     else 'N'
     end jeopardy_status
  ,sla_category
  ,(select /*+ RESULT_CACHE +*/ OUT_VAR
    from MAXDAT_LOOKUP.CORP_ETL_LIST_LKUP
    where 
      REF_TYPE = 'LETTER_TYPE'
      and NAME = 'ProcLetters_SLA_Days'
      and VALUE = sla_category) sla_days
  ,(select /*+ RESULT_CACHE +*/ OUT_VAR
    from MAXDAT_LOOKUP.CORP_ETL_LIST_LKUP
    where 
      REF_TYPE = 'LETTER_TYPE'
      and NAME = 'ProcLetters_SLA_Days_Type'
      and VALUE = sla_category) sla_days_type
  ,(select /*+ RESULT_CACHE +*/ to_number(OUT_VAR)
    from MAXDAT_LOOKUP.CORP_ETL_LIST_LKUP
    where 
      REF_TYPE = 'LETTER_TYPE'
      and NAME = 'ProcLetters_SLA_Jeopardy_Days'
      and VALUE = sla_category) sla_jeopardy_days
  ,pl_bi_id
from 
  (select 
     letter_request_id
     ,CREATE_DATE
     ,CREATED_BY
     ,request_date
     ,case 
        when MAILED_DATE is not null then 'Complete'
        when sent_date is null and request_error_reason is not null then 'Complete'               
        when rejection_reason is not null then 'Complete'    
        when STATUS_CD in ('CANC','VOID','OBE','COMBND') then 'Complete'
        else 'Active' 
        end instance_status 
     ,letter_type
     ,letter_type_code
     ,CASE_ID
     ,program
     ,county_code
     ,zip_code
     ,language
     ,reprint
     ,request_driver_type
     ,request_driver_table
     ,letter_status
     ,letter_status_date
     ,sent_date
     ,print_date
     ,MAILED_DATE
     ,RETURN_DATE
     ,return_reason
     ,rejection_reason
     ,request_error_reason
     ,transmit_file_name transmitted_file_name
     ,transmit_file_dt transmitted_file_date
     ,response_file_name letter_response_file_name
     ,response_file_dt letter_response_file_date
     ,last_update_date
     ,last_updated_by_name
     ,task_id 
     ,case 
        when STATUS_CD in ('CANC','VOID','OBE','COMBND') then coalesce((select CREATE_TS from EB.LETTER_REQ_STATUS_HISTORY lrsh where lrsh.LRSHISTORY_ID = tmp_ltr_tab.CANCEL_HISTORY_ID),LAST_UPDATE_DATE) 
        else null 
        end cancel_date
     ,case 
        when STATUS_CD in ('CANC','VOID','OBE','COMBND') then coalesce((select CREATED_BY from EB.LETTER_REQ_STATUS_HISTORY lrsh where lrsh.LRSHISTORY_ID = tmp_ltr_tab.CANCEL_HISTORY_ID),LAST_UPDATED_BY_NAME) 
        else null 
        end cancel_by
     ,case 
        when MAILED_DATE is not null then MAILED_DATE
        when sent_date is null and request_error_reason is not null then err_date 
        when rejection_reason is not null and task_id is null then response_file_dt 
        when rejection_reason is not null and task_id is not null then (select CREATE_TS from EB.STEP_INSTANCE where STEP_INSTANCE_ID = task_id) 
        when STATUS_CD in ('CANC','VOID','OBE','COMBND') then coalesce((select CREATE_TS from EB.LETTER_REQ_STATUS_HISTORY lrsh where lrsh.LRSHISTORY_ID = tmp_ltr_tab.CANCEL_HISTORY_ID),LAST_UPDATE_DATE)
        else null 
        end complete_date
     ,case when transmit_file_dt is not null then transmit_file_dt else null end send_to_mail_house_end_date
     ,case when MAILED_DATE is not null or rejection_reason is not null then response_file_dt else null end receive_confirm_end_date
     ,case 
        when substr(letter_type,1,2) <> 'IA' then 'Other'
        when substr(letter_type,1,2) = 'IA' and coalesce(newborn_flag,'N') = 'N' then 'New Enrollment'
        when substr(letter_type,1,2) = 'IA' and coalesce(newborn_flag,'N') = 'Y' then 'Newly Eligible Newborn'
        else 'Other'
        end sla_category
     ,letter_request_id pl_bi_id 
   from
     (select 
        lr.LMREQ_ID letter_request_id
        ,lr.CREATE_TS create_date
        ,lr.CREATED_BY
        ,lr.REQUESTED_ON request_date
        ,ld.DESCRIPTION letter_type
        ,ld.NAME letter_type_code
        ,ept.DESCRIPTION program
        ,lr.CASE_ID
        ,(select REPORT_LABEL from ENUM_COUNTY ec where ec.VALUE = loh.RESIDENCE_COUNTY) county_code
        ,loh.RESIDENCE_ZIP_CODE zip_code
        ,el.DESCRIPTION language
        ,case when lr.REQUEST_TYPE = 'R' then 'Y' else 'N' end reprint
        ,case 
           when lr.DRIVER_TYPE = 'CASE' then 'CASE'
           when lr.DRIVER_TYPE = 'CLNT' then 'CLNT'
           else null 
           end request_driver_type
        ,ld.DRIVER_TABLE_NAME request_driver_table
        ,els.DESCRIPTION letter_status
        ,coalesce(lr.UPDATE_TS,lr.CREATE_TS) letter_status_date
        ,lr.SENT_ON sent_date
        ,lr.PRINTED_ON print_date
        ,lr.MAILED_DATE
        ,lr.RETURN_DATE
        ,enrr.DESCRIPTION return_reason
        ,emer.DESCRIPTION rejection_reason
        ,lr.ERROR_CODES request_error_reason
        ,lr.UPDATE_TS last_update_date
        ,lr.UPDATED_BY last_updated_by_name
        ,case when lr.REQUESTED_ON - 
           (select max(cl.CLNT_DOB) 
            from EB.LETTER_REQUEST_LINK ll
            inner join EB.CLIENT cl on ll.CLIENT_ID = cl.CLNT_CLIENT_ID 
            where ll.LMREQ_ID = lr.LMREQ_ID
            group by ll.LMREQ_ID)
           <= 60 then 'Y' else 'N' end newborn_flag
        ,(select max(STEP_INSTANCE_ID) from EB.STEP_INSTANCE si where si.CASE_ID = lr.CASE_ID and si.STEP_DEFINITION_ID in (26,22,27)) task_id 
        ,(select max(CREATE_TS) from EB.LETTER_REQ_STATUS_HISTORY lrsh where lrsh.LMREQ_ID = lr.LMREQ_ID and lr.STATUS_CD = 'ERR') err_date
        ,(select max(LRSHISTORY_ID) from EB.LETTER_REQ_STATUS_HISTORY lrsh where lrsh.LMREQ_ID = lr.LMREQ_ID and lr.STATUS_CD in ('CANC','VOID','OBE','COMBND')) cancel_history_id
        ,(select substr(FILENAME,instr(FILENAME,'/',-1) + 1) from EB.JOB_RUN_DATA where JOB_RUN_DATA_ID = (select max(JOB_ID) from EB.LETTER_OUT_DATA_CONTENT lodc where lodc.LETTER_REQ_ID = lr.LMREQ_ID)) transmit_file_name
        ,(select CREATE_TS from JOB_RUN_DATA where JOB_RUN_DATA_ID = (select max(JOB_ID)from EB.LETTER_OUT_DATA_CONTENT lodc where lodc.LETTER_REQ_ID = lr.LMREQ_ID)) transmit_file_dt
        ,(select substr(FILENAME,instr(FILENAME,'/',-1) + 1) from EB.JOB_RUN_DATA where JOB_RUN_DATA_ID = (select max(JOB_ID) from ETL_L_MAILHOUSE elm where elm.LMREQ_ID = lr.LMREQ_ID)) response_file_name
        ,(select CREATE_TS from EB.JOB_RUN_DATA where JOB_RUN_DATA_ID = (select max(JOB_ID) from EB.ETL_L_MAILHOUSE elm where elm.LMREQ_ID = lr.LMREQ_ID)) response_file_dt
        ,lr.STATUS_CD
     from EB.LETTER_REQUEST lr
     left outer join EB.LETTER_OUT_HEADER loh on lr.LMREQ_ID = loh.LETTER_REQ_ID
     left outer join EB.LETTER_DEFINITION ld on lr.LMDEF_ID = ld.LMDEF_ID
     left outer join EB.ENUM_LM_STATUS els on lr.STATUS_CD = els.VALUE
     left outer join EB.ENUM_LANGUAGE el on lr.LANGUAGE_CD = el.VALUE
     left outer join EB.ENUM_MAILHOUSE_ERROR_REASONS emer on lr.REJECT_REASON_CD = emer.VALUE
     left outer join EB.ENUM_RETURN_REASON enrr on lr.RETURN_REASON_CD = enrr.VALUE
     left outer join EB.ENUM_PROGRAM_TYPE ept on lr.PROGRAM_TYPE_CD = ept.VALUE 
     where 
       (lr.CREATE_TS >= (add_months(trunc(sysdate,'MM'),-2))  
       or els.DESCRIPTION not in ('Mailed','Combined similar Requests','Rejected','Voided','Errored'))
    ) tmp_ltr_tab
  ) a 
