begin
  for cur in (select fk.owner, fk.constraint_name, fk.table_name 
    from all_constraints fk, all_constraints pk 
     where fk.CONSTRAINT_TYPE = 'R' and 
           pk.owner = 'MAXDAT' and
           fk.r_owner = pk.owner and
           fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME and 
           pk.TABLE_NAME = 'NYHBE_ETL_PROCESS_APPEALS') loop
    execute immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE';
  end loop;
end;
/
begin
  for cur in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'NYHBE_ETL_PROCESS_APPEALS') loop
     execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE ';
  end loop;
end;
/

delete from maxdat.NYHBE_ETL_PROCESS_APPEALS where NEPA_ID=55495;

begin
  for cur in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'NYHBE_ETL_PROCESS_APPEALS') loop
     execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE ';
  end loop;
end;
/
begin
  for cur in (select fk.owner, fk.constraint_name , fk.table_name 
   from all_constraints fk, all_constraints pk 
    where fk.CONSTRAINT_TYPE = 'R' and 
          pk.owner = 'MAXDAT' and
          fk.r_owner = pk.owner and
          fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME and 
          pk.TABLE_NAME = 'NYHBE_ETL_PROCESS_APPEALS') loop
    execute immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE';
  end loop;
end;
/

execute MAXDAT_ADMIN.RESET_BPM_QUEUE_ROWS_BY_BSL_ID(23);
execute MAXDAT_ADMIN.STARTUP_JOBS;


Insert into NYHBE_ETL_PROCESS_APPEALS 
(NEPA_ID,INCIDENT_ID,INCIDENT_TYPE,CREATE_DT,
CREATED_BY_NAME,CREATED_BY_GROUP,CHANNEL,TRACKING_NUMBER,APPEAL_DT,RECEIPT_DT,INCIDENT_ABOUT,
INCIDENT_STATUS_DT,LAST_UPDATE_BY_NAME,LAST_UPDATE_BY_DT,REPORTED_BY,REPORTER_RELATIONSHIP,
LINKED_CLIENT,CASE_ID,OTHER_PARTY_NAME,INSTANCE_STATUS,INCIDENT_DESCRIPTION,INCIDENT_STATUS,
PRIORITY,APPELLANT_TYPE,APPELLANT_TYPE_DESC,ABOUT_PLAN_CODE,ABOUT_PLAN_NAME,
ABOUT_PROVIDER_ID,ABOUT_PROVIDER_NAME,ACTION_TYPE,REQUESTED_DAY,REQUESTED_TIME,
APPEAL_HEARING_TIME,APPEAL_HEARING_DT,APPEAL_HEARING_LOCATION,AID_TO_CONTINUE,
EXPECTED_REQUEST,CURRENT_TASK_ID,RESOLUTION_DESCRIPTION,RESOLUTION_TYPE,CANCEL_BY,
CANCEL_DT,CANCEL_REASON,CANCEL_METHOD,ASSD_REVIEW_APPEAL,ASED_REVIEW_APPEAL,
ASPB_REVIEW_APPEAL,ASF_REVIEW_APPEAL,ASSD_DETERMINE_VALID,ASED_DETERMINE_VALID,
ASPB_DETERMINE_VALID,ASF_DETERMINE_VALID,ASSD_PROC_VALID_AMEND,ASED_PROC_VALID_AMEND,
ASPB_PROC_VALID_AMEND,ASF_PROC_VALID_AMEND,ASSD_GATHER_MISS_INFO,ASED_GATHER_MISS_INFO,
ASPB_GATHER_MISS_INFO,ASF_GATHER_MISS_INFO,ASSD_SHOP_REVIEW,ASED_SHOP_REVIEW,
ASPB_SHOP_REVIEW,ASF_SHOP_REVIEW,ASSD_SCHEDULE_HEARING,ASED_SCHEDULE_HEARING,
ASPB_SCHEDULE_HEARING,ASF_SCHEDULE_HEARING,ASSD_CON_HEARING_PROC,ASED_CON_HEARING_PROC,
ASPB_CON_HEARING_PROC,ASF_CON_HEARING_PROC,ASSD_CONDUCT_ST_REV,ASED_CONDUCT_ST_REV,
ASPB_CONDUCT_ST_REV,ASF_CONDUCT_ST_REV,ASSD_CANCEL_HEARING,ASED_CANCEL_HEARING,
ASPB_CANCEL_HEARING,ASF_CANCEL_HEARING,ASSD_ADVISE_WITHDRAW,ASED_ADVISE_WITHDRAW,
ASPB_ADVISE_WITHDRAW,ASF_ADVISE_WITHDRAW,STG_EXTRACT_DATE,STG_LAST_UPDATE_DATE,
GWF_CHANNEL,GWF_APPEAL_INVALID,GWF_CHANGE_ELIGIBILITY,GWF_VALID,GWF_SHOP_REVIEW,
GWF_RESOLVED,GWF_WITHDRAWN_IN_WRITING,STAGE_DONE_DT,INSTANCE_COMPLETE_DT,COMPLETE_DT,
MAX_INCI_STAT_HIST_ID,RECEIVED_DT,CURRENT_STEP,ACTION_COMMENTS,FAIR_HEARING_TRACKING_NBR,
APL_PRIMARY_MEMBER_ID,ACCOUNT_ID,NYHIX_ID,PREF_LANGUAGE,DECISION_DETAILS) 
values (SEQ_NEPA_ID.nextval,27275408,'APPEAL',to_date('31-OCT-17','DD-MON-RR'),'NYSOH, ',null,'WEB',
'28920028','10/31/2017',to_date('31-OCT-17','DD-MON-RR'),'Individual',
to_date('31-OCT-17','DD-MON-RR'),null,to_date('31-OCT-17','DD-MON-RR'),
null,'Self',15239661,3076446,null,'Active',null,'Appeal Open','5','0',
'INDIVIDUAL APPEAL',null,null,null,null,null,'FRIDAY','PM',null,null,null,'N',0,36298905,
null,null,null,null,null,null,to_date('31-OCT-17','DD-MON-RR'),null,null,'N',null,null,null,
'N',null,null,null,'N',null,null,null,'N',null,null,null,'N',null,null,null,'N',null,null,
null,'N',null,null,null,'N',null,null,null,'N',null,null,null,'N',
to_date('31-OCT-17','DD-MON-RR'),to_date('31-OCT-17','DD-MON-RR'),null,null,null,null,
null,null,null,null,null,null,7819430,null,'Start - Review Appeal',null,
'AP000000023864',30649,'AC0003575596','HX0004725181',null,null);
commit;




