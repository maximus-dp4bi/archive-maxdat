--CVIU cleanup
CREATE OR REPLACE sequence coverva_dmas.seq_cviu_data_id;

create table COVERVA_DMAS.CVIU_DATA_FULL_LOAD_BAK
as
select * from COVERVA_DMAS.CVIU_DATA_FULL_LOAD;

select * from COVERVA_DMAS.CVIU_DATA_FULL_LOAD_BAK;

ALTER TABLE coverva_dmas.cviu_data_full_load drop primary key;

truncate table COVERVA_DMAS.CVIU_DATA_FULL_LOAD;

alter table coverva_dmas.CVIU_DATA_FULL_LOAD add (cviu_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_cviu_data_id.nextval);
alter table coverva_dmas.CVIU_DATA_FULL_LOAD rename column t_number to tracking_number;
alter table COVERVA_DMAS.CVIU_DATA_FULL_LOAD add primary key (cviu_data_id);

insert into COVERVA_DMAS.CVIU_DATA_FULL_LOAD (date_received,tracking_number,switch,source,applicant_name,processing_unit,program,assigned_to,locality,processing_status,filename)
select date_received,t_number tracking_number,switch,source,applicant_name,processing_unit,program,assigned_to,locality,processing_status,filename
from(select *
     from(select c.*,row_number() over (partition by t_number, filename order by t_number,filename,processing_status) rnk 
          from coverva_dmas.CVIU_DATA_FULL_LOAD_BAK c
         )
     order by t_number,filename,rnk);

update coverva_dmas.dmas_file_load_lkup
set insert_fields = 'Date_Received,Tracking_Number,Switch,Source,Applicant_Name,Processing_Unit,Program,Assigned_To,Locality,Processing_Status,Filename'
where filename_prefix = 'CVIU_INVENTORY';

drop table coverva_dmas.CVIU_DATA_FULL_LOAD_BAK;

--CPU I cleanup
create or replace sequence coverva_dmas.seq_cpu_incarcerated_id;

create table COVERVA_DMAS.CPU_INCARCERATED_FULL_LOAD_BAK
as
select * from COVERVA_DMAS.CPU_INCARCERATED_FULL_LOAD;

select * from COVERVA_DMAS.CPU_INCARCERATED_FULL_LOAD_BAK;

ALTER TABLE coverva_dmas.cpu_incarcerated_full_load drop primary key;

truncate table COVERVA_DMAS.CPU_INCARCERATED_FULL_LOAD;

alter table coverva_dmas.CPU_INCARCERATED_FULL_LOAD add (cpu_incarcerated_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_cpu_incarcerated_id.nextval);
alter table coverva_dmas.CPU_INCARCERATED_FULL_LOAD rename column t_number to tracking_number;
alter table COVERVA_DMAS.CPU_INCARCERATED_FULL_LOAD add primary key (cpu_incarcerated_id);

insert into COVERVA_DMAS.CPU_INCARCERATED_FULL_LOAD (date_received,tracking_number,switch,source,applicant_name,processing_unit,program,assigned_to,locality,processing_status,filename)
select date_received,t_number tracking_number,switch,source,applicant_name,processing_unit,program,assigned_to,locality,processing_status,filename
from(select *
     from(select distinct date_received,t_number,switch,source,applicant_name,processing_unit,program,assigned_to,locality,processing_status,filename
             ,row_number() over (partition by t_number, filename order by t_number,filename,processing_status) rnk 
          from coverva_dmas.CPU_INCARCERATED_FULL_LOAD_BAK c
         where filename not in('CPU_I_Inventory_20210510_172007','CPU_I_Inventory_20210507_171906'))
     order by t_number,upper(filename),rnk);

update coverva_dmas.dmas_file_load_lkup
set insert_fields = 'Date_Received,Tracking_Number,Switch,Source,Applicant_Name,Processing_Unit,Program,Assigned_To,Locality,Processing_Status,Filename'
where filename_prefix = 'CPU_I_INVENTORY';

drop table coverva_dmas.CPU_INCARCERATED_FULL_LOAD_BAK;

--cm043
create or replace sequence coverva_dmas.seq_cm043_data_id;
alter table coverva_dmas.cm043_data_full_load drop primary key;
truncate table COVERVA_DMAS.cm043_data_full_load;
alter table coverva_dmas.cm043_data_full_load add (cm043_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_cm043_data_id.nextval);
alter table COVERVA_DMAS.cm043_data_full_load add primary key (cm043_data_id);

--cm044
create or replace sequence coverva_dmas.seq_cm044_data_id;

create table COVERVA_DMAS.CM044_DATA_FULL_LOAD_BAK
as
select * from COVERVA_DMAS.CM044_DATA_FULL_LOAD;

select * from COVERVA_DMAS.CM044_DATA_FULL_LOAD_BAK;

ALTER TABLE coverva_dmas.cm044_data_full_load drop primary key;

truncate table COVERVA_DMAS.CM044_DATA_FULL_LOAD;

alter table coverva_dmas.CM044_DATA_FULL_LOAD add (cm044_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_cm044_data_id.nextval);
alter table COVERVA_DMAS.CM044_DATA_FULL_LOAD add primary key (cm044_data_id);

insert into COVERVA_DMAS.CM044_DATA_FULL_LOAD (Tracking_Number,Case_Number,Source,Locality,Status,Application_Date,Authorized_Date,Potential_Pregnancy,Number_of_Days,Authorized_Worker_ID,Authorized_Office,Processing_Unit,Filename)
select Tracking_Number,Case_Number,Source,Locality,Status,Application_Date,Authorized_Date,Potential_Pregnancy,Number_of_Days,Authorized_Worker_ID,Authorized_Office,Processing_Unit,Filename
from(select *
     from(select c.*
             ,row_number() over (partition by Tracking_Number, filename order by Tracking_Number,filename,UPPER(LEFT(c.status,1)) DESC) rnk 
          from coverva_dmas.CM044_DATA_FULL_LOAD_BAK c )
     order by Tracking_Number,upper(filename),rnk);

drop table coverva_dmas.CM044_DATA_FULL_LOAD_BAK;

--cpureport
create or replace sequence coverva_dmas.seq_cpu_data_id;

create table COVERVA_DMAS.CPU_DATA_FULL_LOAD_BAK
as
select * from COVERVA_DMAS.CPU_DATA_FULL_LOAD;

select * from COVERVA_DMAS.CPU_DATA_FULL_LOAD_BAK;

ALTER TABLE coverva_dmas.cpu_data_full_load drop primary key;

truncate table COVERVA_DMAS.CPU_DATA_FULL_LOAD;

alter table coverva_dmas.CPU_DATA_FULL_LOAD add (cpu_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_cpu_data_id.nextval);
alter table COVERVA_DMAS.CPU_DATA_FULL_LOAD add primary key (cpu_data_id);

insert into COVERVA_DMAS.CPU_DATA_FULL_LOAD (App_Received_Date,Tracking_Number,Preg_Switch,Doc_App_Switch,Application_Source,Cname,Processing_Unit,Assigned_To,Locality,Status,Filename,Disab_Switch,TrnFerDate,RunDate)
select App_Received_Date,Tracking_Number,Preg_Switch,Doc_App_Switch,Application_Source,Cname,Processing_Unit,Assigned_To,Locality,Status,Filename,Disab_Switch,TrnFerDate,RunDate
     from(select c.*
             ,row_number() over (partition by Tracking_Number, filename order by Tracking_Number,filename) rnk 
          from coverva_dmas.CPU_DATA_FULL_LOAD_BAK c )
     order by upper(filename),Tracking_Number,rnk;
     
drop table coverva_dmas.CPU_DATA_FULL_LOAD_BAK;

--ppit
create or replace sequence coverva_dmas.seq_ppit_data_id;

create table COVERVA_DMAS.PPIT_DATA_FULL_LOAD_BAK
as
select * from COVERVA_DMAS.PPIT_DATA_FULL_LOAD;

select * from COVERVA_DMAS.PPIT_DATA_FULL_LOAD_BAK;

ALTER TABLE coverva_dmas.ppit_data_full_load drop primary key;

truncate table COVERVA_DMAS.PPIT_DATA_FULL_LOAD;

alter table coverva_dmas.PPIT_DATA_FULL_LOAD add (ppit_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_ppit_data_id.nextval);
alter table coverva_dmas.PPIT_DATA_FULL_LOAD rename column t_number to tracking_number;
alter table COVERVA_DMAS.PPIT_DATA_FULL_LOAD add primary key (ppit_data_id);

insert into COVERVA_DMAS.PPIT_DATA_FULL_LOAD (Tracking_Number,Case_Number,Applicant,App_Received_Date,Worker_LDSS,Locality,Program,Delay,Number_of_Days_Pending,Worker_ID,Filename)
select T_Number tracking_number,Case_Number,Applicant,App_Received_Date,Worker_LDSS,Locality,Program,Delay,Number_of_Days_Pending,Worker_ID,Filename
     from(select  T_Number,Case_Number,Applicant,App_Received_Date,Worker_LDSS,Locality,Program,Delay,Number_of_Days_Pending,Worker_ID,Filename
          from coverva_dmas.PPIT_DATA_FULL_LOAD_BAK c 
          order by filename);
     
update coverva_dmas.dmas_file_load_lkup
set insert_fields = 'Tracking_Number,Case_Number,Applicant,App_Received_Date,Worker_LDSS,Locality,Program,Delay,Number_of_Days_Pending,Worker_ID,Filename'
where filename_prefix = 'PPIT';

drop table coverva_dmas.PPIT_DATA_FULL_LOAD_BAK;

--app metric

create or replace sequence coverva_dmas.seq_appmetric_data_id;

create table COVERVA_DMAS.APP_METRIC_FULL_LOAD_BAK
as
select * from COVERVA_DMAS.APP_METRIC_FULL_LOAD;

select * from COVERVA_DMAS.APP_METRIC_FULL_LOAD_BAK;

ALTER TABLE coverva_dmas.app_metric_full_load drop primary key;

truncate table COVERVA_DMAS.APP_METRIC_FULL_LOAD;

alter table coverva_dmas.APP_METRIC_FULL_LOAD add (appmetric_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_appmetric_data_id.nextval);
alter table coverva_dmas.APP_METRIC_FULL_LOAD rename column app_number to tracking_number;
alter table COVERVA_DMAS.APP_METRIC_FULL_LOAD add primary key (appmetric_data_id);

insert into COVERVA_DMAS.APP_METRIC_FULL_LOAD (Tracking_Number,Locality,App_Received_Date,FFM_Transfer_Date,FFM_Application_Type,Case_Number,Application_Status,Application_Source,Worker_ID,Worker_Name,Stage,Range,Pending_due_to_VCL,VCL_Due_Date,Applicant_Last_Name,Applicant_First_Name,Disability_Verification_Pending,Application_ABD_Indicator,Case_ABD_Indicator,ABD,Application_LTC_Indicator,Case_LTC_Indicator,LTC,CPU_Assigned,Filename)
select App_Number,Locality,App_Received_Date,FFM_Transfer_Date,FFM_Application_Type,Case_Number,Application_Status,Application_Source,Worker_ID,Worker_Name,Stage,Range,Pending_due_to_VCL,VCL_Due_Date,Applicant_Last_Name,Applicant_First_Name,Disability_Verification_Pending,Application_ABD_Indicator,Case_ABD_Indicator,ABD,Application_LTC_Indicator,Case_LTC_Indicator,LTC,CPU_Assigned,Filename
     from(select * from(select c.*, ROW_NUMBER() OVER(ORDER BY UPPER(filename),app_number) rnk
          from(select  DISTINCT c.*
               from coverva_dmas.APP_METRIC_FULL_LOAD_BAK c) c
          ) order by rnk);
     
update coverva_dmas.dmas_file_load_lkup
set insert_fields = 'Tracking_Number,Locality,App_Received_Date,FFM_Transfer_Date,FFM_Application_Type,Case_Number,Application_Status,Application_Source,Worker_ID,Worker_Name,Stage,Range,Pending_due_to_VCL,VCL_Due_Date,Applicant_Last_Name,Applicant_First_Name,Disability_Verification_Pending,Application_ABD_Indicator,Case_ABD_Indicator,ABD,Application_LTC_Indicator,Case_LTC_Indicator,LTC,CPU_Assigned,Filename'
where filename_prefix = 'APPMETRIC';

update coverva_dmas.dmas_file_log
set row_count = 21893
where filename_prefix = 'APPMETRIC'
and filename like '%0714%';

drop table coverva_dmas.APP_METRIC_FULL_LOAD_BAK;

--app metric pw
create or replace sequence coverva_dmas.seq_appmetric_pw_data_id;

create table COVERVA_DMAS.APP_METRIC_PW_FULL_LOAD_BAK
as
select * from COVERVA_DMAS.APP_METRIC_PW_FULL_LOAD;

select * from COVERVA_DMAS.APP_METRIC_PW_FULL_LOAD_BAK;

ALTER TABLE coverva_dmas.app_metric_pw_full_load drop primary key;

truncate table COVERVA_DMAS.APP_METRIC_PW_FULL_LOAD;

alter table coverva_dmas.APP_METRIC_PW_FULL_LOAD add (appmetric_pw_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_appmetric_pw_data_id.nextval);
alter table coverva_dmas.APP_METRIC_PW_FULL_LOAD rename column application_number to tracking_number;
alter table COVERVA_DMAS.APP_METRIC_PW_FULL_LOAD add primary key (appmetric_pw_data_id);

insert into COVERVA_DMAS.APP_METRIC_PW_FULL_LOAD (Tracking_Number,Locality,Application_Received_Date,Worker,Stage,Range,Application_Source,Pending_due_to_VCL,VCL_Due_Date,Applicant_Last_Name,Applicant_First_Name,Filename)
select Application_Number,Locality,Application_Received_Date,Worker,Stage,Range,Application_Source,Pending_due_to_VCL,VCL_Due_Date,Applicant_Last_Name,Applicant_First_Name,Filename
     from(select *
          from(select  c.*, ROW_NUMBER() OVER (ORDER BY UPPER(filename),application_number) rnk
               from coverva_dmas.APP_METRIC_PW_FULL_LOAD_BAK c )
          order by rnk);
     
update coverva_dmas.dmas_file_load_lkup
set insert_fields = 'Tracking_Number,Locality,Application_Received_Date,Worker,Stage,Range,Application_Source,Pending_due_to_VCL,VCL_Due_Date,Applicant_Last_Name,Applicant_First_Name,Filename'
where filename_prefix = 'APPMETRIC_PW';

update coverva_dmas.dmas_file_log
set row_count = 1267
where filename_prefix = 'APPMETRIC_PW'
and filename like '%0714%';

delete from coverva_dmas.app_metric_pw_full_load c
where filename = 'APPMETRIC_PW_07142021_140102'
and exists(select 1 from coverva_dmas.app_metric_pw_full_load d where c.tracking_number = d.tracking_number and c.filename = d.filename and c.appmetric_pw_data_id > d.appmetric_pw_data_id);

drop table coverva_dmas.APP_METRIC_PW_FULL_LOAD_BAK;

--app override
create or replace sequence coverva_dmas.seq_app_override_id;

create table COVERVA_DMAS.APPLICATION_OVERRIDE_FULL_LOAD_BAK
as
select * from COVERVA_DMAS.APPLICATION_OVERRIDE_FULL_LOAD;

select * from COVERVA_DMAS.APPLICATION_OVERRIDE_FULL_LOAD_BAK;

ALTER TABLE coverva_dmas.application_override_full_load drop primary key;

truncate table COVERVA_DMAS.APPLICATION_OVERRIDE_FULL_LOAD;

alter table coverva_dmas.APPLICATION_OVERRIDE_FULL_LOAD add (app_override_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_app_override_id.nextval);
alter table COVERVA_DMAS.APPLICATION_OVERRIDE_FULL_LOAD add primary key (app_override_id);

insert into COVERVA_DMAS.APPLICATION_OVERRIDE_FULL_LOAD (Tracking_Number,Source,App_Received_Date,Processing_Unit,Type,In_CP,Current_State,Initial_Review_Complete_Date,End_Date,Last_Employee,Recent_Submission_date,Submitter,Filename)
select Tracking_Number,Source,App_Received_Date,Processing_Unit,Type,In_CP,Current_State,Initial_Review_Complete_Date,End_Date,Last_Employee,Recent_Submission_date,Submitter,Filename
     from(select *
          from(select  c.*, ROW_NUMBER() OVER (ORDER BY UPPER(filename),tracking_number) rnk
               from coverva_dmas.APPLICATION_OVERRIDE_FULL_LOAD_BAK c )
          order by rnk);

drop table coverva_dmas.APPLICATION_OVERRIDE_FULL_LOAD_BAK;

