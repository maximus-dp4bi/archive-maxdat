create or replace
trigger TRG_AU_CORP_ETL_MANAGE_WORK 
after update on CORP_ETL_MANAGE_WORK
for each row

declare
  pragma autonomous_transaction;
  
  v_be_id number := null;
  v_bem_id number := 1; -- 'NYEC OPS Manage Work'
  v_bi_id number := null;
  v_bia_id number := null;
  v_bsl_id number := 1; -- 'CORP_ETL_MANAGE_WORK'
  v_bue_id number := null;
  v_butl_id number := 1; -- 'ETL'
  
  v_current_sysdate date := null;
  v_max_date date := to_date('2077-07-07','YYYY-MM-DD');
  
  v_sql_code number := null;
  v_error_message varchar2(500) := null;
  
begin

  -- Get new BI_ID
  --select SEQ_BI_ID.nextval into v_bi_id from dual;

  -- Get new BUE_ID
  v_bue_id := SEQ_BUE_ID.nextval;
  
  -- req 2.1 - Insert new record into BPM_UPDATE_EVENT
  
  select BI_ID into v_bi_id
  from BPM_INSTANCE
  where 
    BEM_ID = v_bem_id
    and BSL_ID = v_bsl_id
    and SOURCE_ID = :new.CEMW_ID;
  
  insert into BPM_UPDATE_EVENT
    (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
  values
    (v_bue_id,v_bi_id,v_butl_id,sysdate,'N');
    
  -- req 2.2 - Update records in BPM_INSTANCE_ATTRIBUTE when changed
  
  if (:old.AGE_IN_BUSINESS_DAYS is null and :new.AGE_IN_BUSINESS_DAYS is not null)
    or (:old.AGE_IN_BUSINESS_DAYS is not null and :new.AGE_IN_BUSINESS_DAYS is null)
    or :old.AGE_IN_BUSINESS_DAYS != :new.AGE_IN_BUSINESS_DAYS then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 1;
  
    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,1,:new.AGE_IN_BUSINESS_DAYS,null,
       null,v_current_sysdate,v_max_date,v_bue_id);
  
  end if;

  if (:old.AGE_IN_CALENDAR_DAYS is null and :new.AGE_IN_CALENDAR_DAYS is not null)
    or (:old.AGE_IN_CALENDAR_DAYS is not null and :new.AGE_IN_CALENDAR_DAYS is null)
    or :old.AGE_IN_CALENDAR_DAYS != :new.AGE_IN_CALENDAR_DAYS then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 2;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,2,:new.AGE_IN_CALENDAR_DAYS,null,
       null,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.CANCEL_WORK_DATE is null and :new.CANCEL_WORK_DATE is not null)
    or (:old.CANCEL_WORK_DATE is not null and :new.CANCEL_WORK_DATE is null)
    or :old.CANCEL_WORK_DATE != :new.CANCEL_WORK_DATE then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 3;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,3,null,:new.CANCEL_WORK_DATE,
       null,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.CANCEL_WORK_FLAG is null and :new.CANCEL_WORK_FLAG is not null)
    or (:old.CANCEL_WORK_FLAG is not null and :new.CANCEL_WORK_FLAG is null)
    or :old.CANCEL_WORK_FLAG != :new.CANCEL_WORK_FLAG then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 4;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,4,null,null,
       :new.CANCEL_WORK_FLAG,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.COMPLETE_DATE is null and :new.COMPLETE_DATE is not null)
    or (:old.COMPLETE_DATE is not null and :new.COMPLETE_DATE is null)
    or :old.COMPLETE_DATE != :new.COMPLETE_DATE then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 5;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,5,null,:new.COMPLETE_DATE,
       null,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.COMPLETE_FLAG is null and :new.COMPLETE_FLAG is not null)
    or (:old.COMPLETE_FLAG is not null and :new.COMPLETE_FLAG is null)
    or :old.COMPLETE_FLAG != :new.COMPLETE_FLAG then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 6;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,6,null,null,
       :new.COMPLETE_FLAG,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.CREATE_DATE is null and :new.CREATE_DATE is not null)
    or (:old.CREATE_DATE is not null and :new.CREATE_DATE is null)
    or :old.CREATE_DATE != :new.CREATE_DATE then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 7;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,7,null,v_current_sysdate,
       null,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.ESCALATED_TO_NAME is null and :new.ESCALATED_TO_NAME is not null)
    or (:old.ESCALATED_TO_NAME is not null and :new.ESCALATED_TO_NAME is null)
    or :old.ESCALATED_TO_NAME != :new.ESCALATED_TO_NAME then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 10;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,10,null,null,
       :new.ESCALATED_TO_NAME,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.FORWARDED_BY_NAME is null and :new.FORWARDED_BY_NAME is not null)
    or (:old.FORWARDED_BY_NAME is not null and :new.FORWARDED_BY_NAME is null)
    or :old.FORWARDED_BY_NAME != :new.FORWARDED_BY_NAME then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 11;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,11,null,null,
       :new.FORWARDED_BY_NAME,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.FORWARDED_FLAG is null and :new.FORWARDED_FLAG is not null)
    or (:old.FORWARDED_FLAG is not null and :new.FORWARDED_FLAG is null)
    or :old.FORWARDED_FLAG != :new.FORWARDED_FLAG then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 12;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,12,null,null,
       :new.FORWARDED_FLAG,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.GROUP_NAME is null and :new.GROUP_NAME is not null)
    or (:old.GROUP_NAME is not null and :new.GROUP_NAME is null)
    or :old.GROUP_NAME != :new.GROUP_NAME then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 13;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,13,null,null,
       :new.GROUP_NAME,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.GROUP_PARENT_NAME is null and :new.GROUP_PARENT_NAME is not null)
    or (:old.GROUP_PARENT_NAME is not null and :new.GROUP_PARENT_NAME is null)
    or :old.GROUP_PARENT_NAME != :new.GROUP_PARENT_NAME then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 14;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,14,null,null,
       :new.GROUP_PARENT_NAME,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.GROUP_SUPERVISOR_NAME is null and :new.GROUP_SUPERVISOR_NAME is not null)
    or (:old.GROUP_SUPERVISOR_NAME is not null and :new.GROUP_SUPERVISOR_NAME is null)
    or :old.GROUP_SUPERVISOR_NAME != :new.GROUP_SUPERVISOR_NAME then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 15;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,15,null,null,
       :new.GROUP_SUPERVISOR_NAME,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.JEOPARDY_FLAG is null and :new.JEOPARDY_FLAG is not null)
    or (:old.JEOPARDY_FLAG is not null and :new.JEOPARDY_FLAG is null)
    or :old.JEOPARDY_FLAG != :new.JEOPARDY_FLAG then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 16;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,16,null,null,
       :new.JEOPARDY_FLAG,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.LAST_UPDATE_BY_NAME is null and :new.LAST_UPDATE_BY_NAME is not null)
    or (:old.LAST_UPDATE_BY_NAME is not null and :new.LAST_UPDATE_BY_NAME is null)
    or :old.LAST_UPDATE_BY_NAME != :new.LAST_UPDATE_BY_NAME then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 17;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,17,null,null,
       :new.LAST_UPDATE_BY_NAME,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.LAST_UPDATE_DATE is null and :new.LAST_UPDATE_DATE is not null)
    or (:old.LAST_UPDATE_DATE is not null and :new.LAST_UPDATE_DATE is null)
    or :old.LAST_UPDATE_DATE != :new.LAST_UPDATE_DATE then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 18;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,18,null,:new.LAST_UPDATE_DATE,
       null,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.OWNER_NAME is null and :new.OWNER_NAME is not null)
    or (:old.OWNER_NAME is not null and :new.OWNER_NAME is null)
    or :old.OWNER_NAME != :new.OWNER_NAME then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 19;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,19,null,null,
       :new.OWNER_NAME,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.SLA_DAYS is null and :new.SLA_DAYS is not null)
    or (:old.SLA_DAYS is not null and :new.SLA_DAYS is null)
    or :old.SLA_DAYS != :new.SLA_DAYS then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 20;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,20,:new.SLA_DAYS,null,
       null,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.SLA_DAYS_TYPE is null and :new.SLA_DAYS_TYPE is not null)
    or (:old.SLA_DAYS_TYPE is not null and :new.SLA_DAYS_TYPE is null)
    or :old.SLA_DAYS_TYPE != :new.SLA_DAYS_TYPE then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 21;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,21,null,null,
       :new.SLA_DAYS_TYPE,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.SLA_JEOPARDY_DAYS is null and :new.SLA_JEOPARDY_DAYS is not null)
    or (:old.SLA_JEOPARDY_DAYS is not null and :new.SLA_JEOPARDY_DAYS is null)
    or :old.SLA_JEOPARDY_DAYS != :new.SLA_JEOPARDY_DAYS then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 22;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,22,:new.SLA_JEOPARDY_DAYS,null,
       null,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.SLA_TARGET_DAYS is null and :new.SLA_TARGET_DAYS is not null)
    or (:old.SLA_TARGET_DAYS is not null and :new.SLA_TARGET_DAYS is null)
    or :old.SLA_TARGET_DAYS != :new.SLA_TARGET_DAYS then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 23;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,23,:new.SLA_TARGET_DAYS,null,
       null,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.SOURCE_REFERENCE_ID is null and :new.SOURCE_REFERENCE_ID is not null)
    or (:old.SOURCE_REFERENCE_ID is not null and :new.SOURCE_REFERENCE_ID is null)
    or :old.SOURCE_REFERENCE_ID != :new.SOURCE_REFERENCE_ID then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 24;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,24,:new.SOURCE_REFERENCE_ID,null,
       null,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.SOURCE_REFERENCE_TYPE is null and :new.SOURCE_REFERENCE_TYPE is not null)
    or (:old.SOURCE_REFERENCE_TYPE is not null and :new.SOURCE_REFERENCE_TYPE is null)
    or :old.SOURCE_REFERENCE_TYPE != :new.SOURCE_REFERENCE_TYPE then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 25;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,25,null,null,
       :new.SOURCE_REFERENCE_TYPE,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.STATUS_AGE_IN_BUS_DAYS is null and :new.STATUS_AGE_IN_BUS_DAYS is not null)
    or (:old.STATUS_AGE_IN_BUS_DAYS is not null and :new.STATUS_AGE_IN_BUS_DAYS is null)
    or :old.STATUS_AGE_IN_BUS_DAYS != :new.STATUS_AGE_IN_BUS_DAYS then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 26;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,26,:new.STATUS_AGE_IN_BUS_DAYS,null,
       null,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.STATUS_AGE_IN_CAL_DAYS is null and :new.STATUS_AGE_IN_CAL_DAYS is not null)
    or (:old.STATUS_AGE_IN_CAL_DAYS is not null and :new.STATUS_AGE_IN_CAL_DAYS is null)
    or :old.STATUS_AGE_IN_CAL_DAYS != :new.STATUS_AGE_IN_CAL_DAYS then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 27;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,27,:new.STATUS_AGE_IN_CAL_DAYS,null,
       null,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.STATUS_DATE is null and :new.STATUS_DATE is not null)
    or (:old.STATUS_DATE is not null and :new.STATUS_DATE is null)
    or :old.STATUS_DATE != :new.STATUS_DATE then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 28;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,28,null,:new.STATUS_DATE,
       null,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.TASK_STATUS is null and :new.TASK_STATUS is not null)
    or (:old.TASK_STATUS is not null and :new.TASK_STATUS is null)
    or :old.TASK_STATUS != :new.TASK_STATUS then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 30;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,30,null,null,
       :new.TASK_STATUS,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.TASK_TYPE is null and :new.TASK_TYPE is not null)
    or (:old.TASK_TYPE is not null and :new.TASK_TYPE is null)
    or :old.TASK_TYPE != :new.TASK_TYPE then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 31;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,31,null,null,
       :new.TASK_TYPE,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.TEAM_NAME is null and :new.TEAM_NAME is not null)
    or (:old.TEAM_NAME is not null and :new.TEAM_NAME is null)
    or :old.TEAM_NAME != :new.TEAM_NAME then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 32;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,32,null,null,
       :new.TEAM_NAME,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.TEAM_PARENT_NAME is null and :new.TEAM_PARENT_NAME is not null)
    or (:old.TEAM_PARENT_NAME is not null and :new.TEAM_PARENT_NAME is null)
    or :old.TEAM_PARENT_NAME != :new.TEAM_PARENT_NAME then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 33;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,33,null,null,
       :new.TEAM_PARENT_NAME,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.TEAM_SUPERVISOR_NAME is null and :new.TEAM_SUPERVISOR_NAME is not null)
    or (:old.TEAM_SUPERVISOR_NAME is not null and :new.TEAM_SUPERVISOR_NAME is null)
    or :old.TEAM_SUPERVISOR_NAME != :new.TEAM_SUPERVISOR_NAME then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 34;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,34,null,null,
       :new.TEAM_SUPERVISOR_NAME,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
  if (:old.TIMELINESS_STATUS is null and :new.TIMELINESS_STATUS is not null)
    or (:old.TIMELINESS_STATUS is not null and :new.TIMELINESS_STATUS is null)
    or :old.TIMELINESS_STATUS != :new.TIMELINESS_STATUS then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 35;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,35,null,null,
       :new.TIMELINESS_STATUS,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
  
 if (:old.UNIT_OF_WORK is null and :new.UNIT_OF_WORK is not null)
    or (:old.UNIT_OF_WORK is not null and :new.UNIT_OF_WORK is null)
    or :old.UNIT_OF_WORK != :new.UNIT_OF_WORK then
    
    select SEQ_BIA_ID.nextval into v_bia_id from dual;
    
    v_current_sysdate := sysdate;
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      END_DATE = v_max_date
      and BI_ID = v_bi_id
      and BA_ID = 36;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,v_bi_id,35,null,null,
       :new.UNIT_OF_WORK,v_current_sysdate,v_max_date,v_bue_id);
       
  end if;
 
  -- Instance Date
  if :new.COMPLETE_DATE is not null then
    
    update BPM_INSTANCE
    set END_DATE = :new.COMPLETE_DATE
    where BI_ID = v_bi_id;
    
  end if;
  
  commit;
  
exception

  when others then
    rollback;
    
    v_sql_code := SQLCODE;
    v_error_message := substr(SQLERRM,1,500);
    v_be_id := SEQ_BE_ID.nextval;
    
    insert into BPM_ERRORS 
      (BE_ID,ERROR_DATE,RUN_DATA_OBJECT,SOURCE_ID,BI_ID,BIA_ID,
       ERROR_NUMBER,ERROR_MESSAGE) 
    values 
      (v_be_id,sysdate,'TRG_AU_CORP_ETL_MANAGE_WORK',to_char(:new.CEMW_ID),v_bi_id,v_bia_id,
       v_sql_code,v_error_message);

    commit;
    
    dbms_output.put_line('Exception: ' || v_error_message || ' See BPM_ERRORS.BE_ID = ' || v_be_id || ' for more details.');

end;
/