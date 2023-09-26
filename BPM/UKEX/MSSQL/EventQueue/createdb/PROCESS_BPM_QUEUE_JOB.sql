use maxdat;

if exists(select 1 from sysobjects where name='Process_BPM_Calc_Job_Config')
begin
drop table Process_BPM_Calc_Job_Config;
end;

if exists(select 1 from sysobjects where name='Seq_PBCJC_ID')
begin
drop Sequence Seq_PBCJC_ID
end;

if exists(select 1 from sysobjects where name='Process_BPM_Queue_Job_Config')
begin
drop table Process_BPM_Queue_Job_Config;
end;

if exists(select 1 from sysobjects where name='Seq_PBQJC_ID')
begin
drop Sequence Seq_PBQJC_ID
end;

if exists(select 1 from sysobjects where name='Process_BPM_Queue_Job_Ctrl_Cfg')
begin
drop table Process_BPM_Queue_Job_Ctrl_Cfg;
end;

if exists(select 1 from sysobjects where name='Process_BPM_Queue_Job_Batch')
begin
drop table Process_BPM_Queue_Job_Batch;
end;

if exists(select 1 from sysobjects where name='Seq_PBQJB_ID')
begin
drop Sequence Seq_PBQJB_ID
end;

if exists(select 1 from sysobjects where name='Process_BPM_Queue_Job')
begin
drop table Process_BPM_Queue_Job;
end;

if exists(select 1 from sysobjects where name='Seq_PBQJ_ID')
begin
drop Sequence Seq_PBQJ_ID
end;

if exists(select 1 from sysobjects where name='PBQJ_Adjust_Reason_Lkup')
begin
drop table PBQJ_Adjust_Reason_Lkup;
end;

if exists(select 1 from sysobjects where name='D_Process_BPM_Queue_Job_SV')
begin
drop view D_Process_BPM_Queue_Job_SV;
end;

if exists(select 1 from sysobjects where name='D_Process_BPM_Queue_Job_Bat_SV')
begin
drop view D_Process_BPM_Queue_Job_Bat_SV;
end;

if exists(select 1 from sysobjects where name='PBQJ_Adjust_Reason_Lkup')
begin
drop table PBQJ_Adjust_Reason_Lkup;
end;

create table PBQJ_Adjust_Reason_Lkup
  (PBQJ_Adjust_Reason_ID integer not null,
   Adjust_Type varchar(5) not null,
   Reason_Name varchar(30) not null,
   Description varchar(100) not null)
;

alter table PBQJ_Adjust_Reason_Lkup add constraint PBQJ_Adjust_Reason_Lkup_PK primary key (PBQJ_Adjust_Reason_ID);

create unique index PBQJ_Adjust_Reason_Lkup on PBQJ_Adjust_Reason_Lkup (Reason_Name);

insert into PBQJ_Adjust_Reason_Lkup (PBQJ_Adjust_Reason_ID,Adjust_Type,Reason_Name,Description) 
values (101,'START','ALL_PROC_ENABLED','PROCESS_BPM_QUEUE_JOB_CTRL_CFG.PROCESSING_ENABLED = Y setting.');
insert into PBQJ_Adjust_Reason_Lkup (PBQJ_Adjust_Reason_ID,Adjust_Type,Reason_Name,Description) 
values (102,'START','BSL_BDM_PROC_ENABLED','PROCESS_BPM_QUEUE_JOB_CTRL_CFG.PROCESSING_ENABLED = Y setting.');
insert into PBQJ_Adjust_Reason_Lkup (PBQJ_Adjust_Reason_ID,Adjust_Type,Reason_Name,Description) 
values (103,'START','MANUAL_START','Manual creation of job via procedure execute.');
insert into PBQJ_Adjust_Reason_Lkup (PBQJ_Adjust_Reason_ID,Adjust_Type,Reason_Name,Description) 
values (111,'START','TOO_FEW_JOBS','Number of running jobs less than PROCESS_BPM_QUEUE_JOB_CONFIG.MIN_NUM_JOBS.');
insert into PBQJ_Adjust_Reason_Lkup (PBQJ_Adjust_Reason_ID,Adjust_Type,Reason_Name,Description) 
values (130,'START','WORK_BACKLOG','Number of queue rows left to process is enough to need more jobs.');

insert into PBQJ_Adjust_Reason_Lkup (PBQJ_Adjust_Reason_ID,Adjust_Type,Reason_Name,Description) 
values (201,'STOP','ALL_PROC_DISABLED','PROCESS_BPM_QUEUE_JOB_CTRL_CFG.PROCESSING_ENABLED = N setting.');
insert into PBQJ_Adjust_Reason_Lkup (PBQJ_Adjust_Reason_ID,Adjust_Type,Reason_Name,Description) 
values (202,'STOP','BSL_BDM_PROC_DISABLED','PROCESS_BPM_QUEUE_JOB_CTRL_CFG.PROCESSING_ENABLED = N setting.');
insert into PBQJ_Adjust_Reason_Lkup (PBQJ_Adjust_Reason_ID,Adjust_Type,Reason_Name,Description) 
values (203,'STOP','MANUAL_STOP','Manual stop of specific jobs via procedure execute.');
insert into PBQJ_Adjust_Reason_Lkup (PBQJ_Adjust_Reason_ID,Adjust_Type,Reason_Name,Description) 
values (210,'STOP','TOO_MANY_TOTAL_JOBS','Number of running jobs exceeds PROCESS_BPM_QUEUE_JOB_CTRL_CFG.MAX_TOTAL_NUM_JOBS.');
insert into PBQJ_Adjust_Reason_Lkup (PBQJ_Adjust_Reason_ID,Adjust_Type,Reason_Name,Description) 
values (211,'STOP','TOO_MANY_JOBS','Number of running jobs exceeds PROCESS_BPM_QUEUE_JOB_CONFIG.MAX_NUM_JOBS.');
insert into PBQJ_Adjust_Reason_Lkup (PBQJ_Adjust_Reason_ID,Adjust_Type,Reason_Name,Description) 
values (220,'STOP','SLEEPING','Job was sleeping.');
insert into PBQJ_Adjust_Reason_Lkup (PBQJ_Adjust_Reason_ID,Adjust_Type,Reason_Name,Description) 
values (240,'STOP','BAD_METADATA','Job had bad metadata.');
insert into PBQJ_Adjust_Reason_Lkup (PBQJ_Adjust_Reason_ID,Adjust_Type,Reason_Name,Description) 
values (241,'STOP','STARTED','Job was started but not running.');

if exists(select 1 from sysobjects where name='Process_BPM_Queue_Job')
begin
drop table Process_BPM_Queue_Job;
end;

if exists(select 1 from sysobjects where name='Seq_PBQJ_ID')
begin
drop Sequence Seq_PBQJ_ID
end;
create Sequence Seq_PBQJ_ID as int increment by 1;
grant update, references on Seq_PBQJ_ID to MAXDAT_READ_ONLY; 

create table Process_BPM_Queue_Job
  (PBQJ_ID integer not null constraint DK_Process_BPM_Queue_Job default next value for Seq_PBQJ_ID,
   Job_Name varchar(30) not null,
   BSL_ID integer,
   BDM_ID integer,
   Batch_Size integer,
   Start_Date date not null,
   End_Date date,
   Status varchar(10) not null,
   Status_Date date not null,
   Job_Adjust_Reason_ID integer,
   Enabled varchar(1) not null,
   Start_Reason_ID integer,
   Stop_Reason_ID integer)
;

alter table Process_BPM_Queue_Job add constraint PBQJ_PK primary key (PBQJ_ID);

create index PBQJ_IX1 on Process_BPM_Queue_Job (BSL_ID);
create index PBQJ_IX2 on Process_BPM_Queue_Job (Status);
create index PBQJ_UX1 on Process_BPM_Queue_Job (Job_Name);

alter table Process_BPM_Queue_Job add constraint PBQJ_BSL_ID_FK
foreign key (BSL_ID) references BPM_Source_Lkup (BSL_ID);

alter table Process_BPM_Queue_Job add constraint PBQJ_BDM_ID_CK 
foreign key (BDM_ID) references BPM_Data_Model (BDM_ID);

alter table Process_BPM_Queue_Job add constraint PBQJ_Status_CK 
check (Status in ('FAILED','LOCKING','PROCESSING','RESERVING','SLEEPING','STARTED','STOPPED'));

alter table Process_BPM_Queue_Job add constraint PBQJ_Enabled_CK 
check (Enabled in ('N','Y'));

alter table Process_BPM_Queue_Job add constraint PBQJ_Start_Reason_ID_FK
foreign key (Start_Reason_ID) references PBQJ_Adjust_Reason_Lkup (PBQJ_Adjust_Reason_ID);

alter table Process_BPM_Queue_Job add constraint PBQJ_Stop_Reason_ID_FK
foreign key (Stop_Reason_ID) references PBQJ_Adjust_Reason_Lkup (PBQJ_Adjust_Reason_ID);



if exists(select 1 from sysobjects where name='Process_BPM_Queue_Job_Batch')
begin
drop table Process_BPM_Queue_Job_Batch;
end;

if exists(select 1 from sysobjects where name='Seq_PBQJB_ID')
begin
drop Sequence Seq_PBQJB_ID
end;
create Sequence Seq_PBQJB_ID as int increment by 1;
grant update, references on Seq_PBQJB_ID to MAXDAT_READ_ONLY; 

create table Process_BPM_Queue_Job_Batch
  (PBQJB_ID integer not null constraint DK_Process_BPM_Queue_Job_Batch default next value for Seq_PBQJB_ID,
   PBQJ_ID  integer not null,
   Batch_ID integer,
   Process_BUEQ_ID integer,
   Batch_Start_Date date not null,
   Batch_End_Date date,
   Locking_Start_Date date,
   Locking_End_Date date,
   Reserve_Start_Date date,
   Reserve_End_Date date,
   Proc_XML_Start_Date date,
   Proc_XML_End_Date date,
   Num_Sleep_Seconds integer default(0) not null,
   Num_Queue_Rows_In_Batch integer default(0) not null,
   Num_BPM_Event_Insert integer default(0) not null,
   Num_BPM_Event_Update integer default(0) not null,
   Num_BPM_Semantic_Insert integer default(0) not null,
   Num_BPM_Semantic_Update integer default(0) not null,
   Status_Date date not null)
;

alter table Process_BPM_Queue_Job_Batch add constraint PBQJB_PK primary key (PBQJB_ID);

create index PBQJB_LX1 on Process_BPM_Queue_Job_Batch (PBQJ_ID);
create index PBQJB_LX2 on Process_BPM_Queue_Job_Batch (Batch_Start_Date);

alter table Process_BPM_Queue_Job_Batch add constraint PBQJB_PBQJ_ID_FK 
foreign key (PBQJ_ID) references Process_BPM_Queue_Job(PBQJ_ID);

if exists(select 1 from sysobjects where name='Process_BPM_Queue_Job_Ctrl_Cfg')
begin
drop table Process_BPM_Queue_Job_Ctrl_Cfg;
end;

create table Process_BPM_Queue_Job_Ctrl_Cfg
  (Max_Total_Num_Jobs integer not null,
   Num_Jobs_To_Del_During_Adjust integer not null,
   Num_Jobs_To_Add_During_Adjust integer not null,
   Num_Group_Cycles_Before_Add integer not null,
   Control_Job_Sleep_Seconds integer not null,
   Lock_Timeout_Seconds integer not null,
   Process_Sleep_Seconds integer not null,
   Process_Batch_Seconds integer not null,
   Start_Delay_Seconds integer not null,
   Stop_Delay_Seconds integer not null,
   Processing_Enabled varchar(1) not null)
;

alter table Process_BPM_Queue_Job_Ctrl_Cfg add constraint PBQJCC_Total_Max_Num_Jobs_CK 
check (Max_Total_Num_Jobs >= 0);

alter table Process_BPM_Queue_Job_Ctrl_Cfg add constraint PBQJCC_Num_Jobs_To_Del_Adj_CK
check (Num_Jobs_To_Del_During_Adjust >= 0);

alter table Process_BPM_Queue_Job_Ctrl_Cfg add constraint PBQJCC_Num_Jobs_To_Add_Adj_CK
check (Num_Jobs_To_Add_During_Adjust >= 0);

alter table Process_BPM_Queue_Job_Ctrl_Cfg add constraint PBQJCC_Num_GC_Before_Add_CK
check (Num_Group_Cycles_Before_Add >= 0);

alter table Process_BPM_Queue_Job_Ctrl_Cfg add constraint PBQJCC_Lock_Timeout_Seconds_CK 
check (Lock_Timeout_Seconds >= 0);

alter table Process_BPM_Queue_Job_Ctrl_Cfg add constraint PBQJCC_Proc_Sleep_Seconds_CK 
check (Process_Sleep_Seconds >= 0);

alter table Process_BPM_Queue_Job_Ctrl_Cfg add constraint PBQJCC_Proc_Batch_Seconds_CK 
check (Process_Batch_Seconds >= 0);

alter table Process_BPM_Queue_Job_Ctrl_Cfg add constraint PBQJCC_Start_Delay_Seconds_CK 
check (Start_Delay_Seconds >= 0);

alter table Process_BPM_Queue_Job_Ctrl_Cfg add constraint PBQJCC_Stop_Delay_Seconds_CK 
check (Stop_Delay_Seconds >= 0);

insert into Process_BPM_Queue_Job_Ctrl_Cfg 
  (Max_Total_Num_Jobs,
   Num_Jobs_To_Del_During_Adjust,
   Num_Jobs_To_Add_During_Adjust,
   Num_Group_Cycles_Before_Add,
   Control_Job_Sleep_Seconds,
   Lock_Timeout_Seconds,
   Process_Sleep_Seconds,
   Process_Batch_Seconds,
   Start_Delay_Seconds,
   Stop_Delay_Seconds,
   Processing_Enabled) 
values (64,1,4,2,30,300,120,10,10,5,'Y');

if exists(select 1 from sysobjects where name='Process_BPM_Queue_Job_Config')
begin
drop table Process_BPM_Queue_Job_Config;
end;

if exists(select 1 from sysobjects where name='Seq_PBQJC_ID')
begin
drop Sequence Seq_PBQJC_ID
end;
create Sequence Seq_PBQJC_ID as int increment by 1;
grant update, references on Seq_PBQJC_ID to MAXDAT_READ_ONLY; 

create table Process_BPM_Queue_Job_Config
  (PBQJC_ID integer not null constraint DK_Process_BPM_Queue_Job_Config default next value for Seq_PBQJC_ID,
   BSL_ID integer not null,
   BDM_ID integer not null,
   Min_Num_Jobs integer,
   Init_Num_Jobs integer,
   Max_Num_Jobs integer,
   Batch_Size integer,
   Enabled varchar(1) not null)
;

alter table Process_BPM_Queue_Job_Config add constraint PBQJC_PK primary key (PBQJC_ID);

alter table Process_BPM_Queue_Job_Config add constraint PBQJC_Min_Num_Jobs_CK 
check (Min_Num_Jobs is null or Min_Num_Jobs >= 0);

alter table Process_BPM_Queue_Job_Config add constraint PBQJC_Init_Num_Jobs_CK 
check (Init_Num_Jobs is null or (Init_Num_Jobs >= 0 and (Min_Num_Jobs is null or Init_Num_Jobs >= Min_Num_Jobs)));

alter table Process_BPM_Queue_Job_Config add constraint PBQJC_Max_Num_Jobs_CK 
check (Max_Num_Jobs is null or (Max_Num_Jobs >= 0 
  and (Min_Num_Jobs is null or Max_Num_Jobs >= Min_Num_Jobs)
  and (Init_Num_Jobs is null or Max_Num_Jobs >= Init_Num_Jobs)));
  
alter table Process_BPM_Queue_Job_Config add constraint PBQJC_Batch_Size_CK 
check (Batch_Size is null or Batch_Size >= 0);

alter table Process_BPM_Queue_Job_Config add constraint PBQJC_Enabled_CK 
check (Enabled in ('N','Y'));

create unique index PBQJC_UX1 on Process_BPM_Queue_Job_Config (BSL_ID,BDM_ID);

insert into Process_BPM_Queue_Job_Config 
  (BSL_ID,BDM_ID,Min_Num_Jobs,Init_Num_Jobs,Max_Num_Jobs,Batch_Size,Enabled)
values (0,0,1,2,24,100,'Y');


if exists(select 1 from sysobjects where name='Process_BPM_Calc_Job_Config')
begin
drop table Process_BPM_Calc_Job_Config;
end;
if exists(select 1 from sysobjects where name='Seq_PBCJC_ID')
begin
drop Sequence Seq_PBCJC_ID
end;
create Sequence Seq_PBCJC_ID as int increment by 1;
grant update, references on Seq_PBCJC_ID to MAXDAT_READ_ONLY; 

create table Process_BPM_Calc_Job_Config
  (PBCJC_ID integer not null constraint DK_Process_BPM_Calc_Job_Config default next value for Seq_PBCJC_ID,
   Package_Name varchar(30) not null,
   Procedure_Name varchar(30) not null,
   Process_Enabled varchar(1) not null)
;

alter table Process_BPM_Calc_Job_Config add constraint PBCJC_PK primary key (PBCJC_ID);

create unique index PBCJC_UX1 on Process_BPM_Calc_Job_Config (Package_Name,Procedure_Name);


go
-- For MicroStrategy MASH reporting.
create view D_Process_BPM_Queue_Job_SV 
  (PBQJ_ID,
   Job_Name,
   BSL_ID,
   BDM_ID,
   Batch_Size,
   Start_Date,
   End_Date,
   Status,
   Status_Date,
   Enabled,
   Start_Reason_ID,
   Stop_Reason_ID) as 
select
  PBQJ_ID,
   Job_Name,
   BSL_ID,
   BDM_ID,
   Batch_Size,
   Start_Date,
   End_Date,
   Status,
   Status_Date,
   Enabled,
   Start_Reason_ID,
   Stop_Reason_ID
from Process_BPM_Queue_Job
;
go

-- For MicroStrategy MASH reporting.
create view D_Process_BPM_Queue_Job_Bat_SV as 
select PBQJB_ID,
   PBQJ_ID,
   Batch_ID,
   Process_BUEQ_ID,
   Batch_Start_Date,
   Batch_End_Date,
   Locking_Start_Date,
   Locking_End_Date,
   Reserve_Start_Date,
   Reserve_End_Date,
   Proc_XML_Start_Date,
   Proc_XML_End_Date,
   Num_Sleep_Seconds,
   Num_Queue_Rows_In_Batch,
   Num_BPM_Event_Insert,
   Num_BPM_Event_Update,
   Num_BPM_Semantic_Insert,
   Num_BPM_Semantic_Update,
   Status_Date
from Process_BPM_Queue_Job_Batch
;
go
