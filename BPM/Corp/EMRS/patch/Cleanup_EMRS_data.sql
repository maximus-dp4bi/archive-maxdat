delete from emrs_d_enrollment_notification;

delete from emrs_d_notification;

delete from emrs_d_enrollment_rejection;

delete from emrs_d_selection_missing_info;

delete from emrs_d_selection_trans_history;

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'ENABLED' AND constraint_name LIKE '%SLCTTRANS%') LOOP
execute immediate 'alter table '||i.table_name||' disable constraint '||i.constraint_name||'';
end loop;
end;
/
truncate table emrs_d_selection_transaction;

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'DISABLED' AND constraint_name LIKE '%SLCTTRANS%') LOOP
execute immediate 'alter table '||i.table_name||' enable constraint '||i.constraint_name||'';
end loop;
end;
/

truncate table emrs_d_address;

truncate table emrs_s_enrollment_stg;

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'ENABLED' AND constraint_name LIKE 'ENROLLMENT%') LOOP
execute immediate 'alter table '||i.table_name||' disable constraint '||i.constraint_name||'';
end loop;
end;
/
truncate table emrs_f_enrollment;

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'DISABLED' AND constraint_name LIKE 'ENROLLMENT%') LOOP
execute immediate 'alter table '||i.table_name||' enable constraint '||i.constraint_name||'';
end loop;
end;
/

truncate table emrs_d_client_plan_eligibility;

truncate table emrs_d_client_plan_enrl_status;

delete from emrs_d_sub_program;

delete from emrs_d_program;

delete from emrs_d_aid_category;

delete from emrs_d_coverage_category;

delete from emrs_d_status_in_group;

delete from emrs_d_risk_group;

delete from emrs_d_change_reason;

delete from emrs_d_rejection_error_reason;

delete from emrs_d_termination_reason;

delete from emrs_d_selection_reason;

delete from emrs_d_selection_source;

delete from emrs_d_citizenship_status;

delete from emrs_d_enrollment_action_statu;

delete from emrs_d_language;

delete from emrs_d_race;

delete from emrs_d_provider_type;

delete from emrs_d_county;

delete from emrs_d_care_serv_deliv_area
--where csda_id != 0
;

delete from emrs_d_federal_poverty_level;

delete from emrs_d_provider_specialty;

delete from emrs_d_provider_specialty_code;

delete from emrs_d_plan;

delete from emrs_d_plan_percentage;

delete from emrs_d_aa_countycontract;

delete from emrs_d_aa_contract;

delete from emrs_d_plan_type;

delete from emrs_d_enrollment_status;
  
delete from emrs_d_selection_status;
  
delete from emrs_d_enrollment_error_code;
  
delete from emrs_d_zipcode;
  
--delete from emrs_f_enrollment;
begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'ENABLED' AND constraint_name LIKE '%CLIENT%') LOOP
execute immediate 'alter table '||i.table_name||' disable constraint '||i.constraint_name||'';
end loop;
end;
/
truncate table emrs_d_client;

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'DISABLED' AND constraint_name LIKE '%CLIENT%') LOOP
execute immediate 'alter table '||i.table_name||' enable constraint '||i.constraint_name||'';
end loop;
end;
/

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'ENABLED' AND constraint_name LIKE '%CASES%') LOOP
execute immediate 'alter table '||i.table_name||' disable constraint '||i.constraint_name||'';
end loop;
end;
/
truncate table emrs_d_case
--where case_id != 0
;

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'DISABLED' AND constraint_name LIKE '%CASES%') LOOP
execute immediate 'alter table '||i.table_name||' enable constraint '||i.constraint_name||'';
end loop;
end;
/

truncate table emrs_d_provider;


begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'ENABLED' AND constraint_name LIKE '%PROVIDERNUM_FK%') LOOP
execute immediate 'alter table '||i.table_name||' disable constraint '||i.constraint_name||'';
end loop;
end;
/
truncate table emrs_d_provider_ref;

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'DISABLED' AND constraint_name LIKE '%PROVIDERNUM_FK%') LOOP
execute immediate 'alter table '||i.table_name||' enable constraint '||i.constraint_name||'';
end loop;
end;
/

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'ENABLED' AND constraint_name LIKE '%CLIENTNUM_FK%') LOOP
execute immediate 'alter table '||i.table_name||' disable constraint '||i.constraint_name||'';
end loop;
end;
/
truncate table emrs_d_client_ref;

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'DISABLED' AND constraint_name LIKE '%CLIENTNUM_FK%') LOOP
execute immediate 'alter table '||i.table_name||' enable constraint '||i.constraint_name||'';
end loop;
end;
/

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'ENABLED' AND constraint_name LIKE '%CASENUM_FK%') LOOP
execute immediate 'alter table '||i.table_name||' disable constraint '||i.constraint_name||'';
end loop;
end;
/
truncate table emrs_d_case_ref;

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'DISABLED' AND constraint_name LIKE '%CASENUM_FK%') LOOP
execute immediate 'alter table '||i.table_name||' enable constraint '||i.constraint_name||'';
end loop;
end;
/


delete from emrs_d_date_period;

delete from emrs_d_time_period;

COMMIT;
