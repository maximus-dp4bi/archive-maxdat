use MAXDAT;

if exists(select 1 from sysobjects where name='BAA_BEM_FK')
begin
alter table BPM_Activity_Attribute drop constraint BAA_BEM_FK
end;
if exists(select 1 from sysobjects where name='BACA_BACL_FK')
begin
alter table BPM_Activity_Attribute drop constraint BACA_BACL_FK
end;
if exists(select 1 from sysobjects where name='BACE_BACA_FK')
begin
alter table BPM_Activity_Event drop constraint BACE_BACA_FK
end;
if exists(select 1 from sysobjects where name='BACE_BACETL_FK')
begin
alter table BPM_Activity_Event drop constraint BACE_BACETL_FK
end;

if exists(select 1 from sysobjects where name='BACL_BACTL_FK')
begin
alter table BPM_Activity_Lkup drop constraint BACL_BACTL_FK
end;
if exists(select 1 from sysobjects where name='BA_BAL_FK')
begin
alter table BPM_Attribute drop constraint BA_BAL_FK
end;
if exists(select 1 from sysobjects where name='BA_BEM_FK')
begin
alter table BPM_Attribute drop constraint BA_BEM_FK
end;
if exists(select 1 from sysobjects where name='BAL_BDL_FK')
begin
alter table BPM_Attribute_Lkup drop constraint BAL_BDL_FK
end;
--if exists(select 1 from sysobjects where name='BAST_BA_FK')
--begin
--alter table BPM_Attribute_Staging_Table drop constraint BAST_BA_FK
--end;
if exists(select 1 from sysobjects where name='BAST_BSL_FK')
begin
alter table BPM_Attribute_Staging_Table drop constraint BAST_BSL_FK
end;

if exists(select 1 from sysobjects where name='BEM_BPRG_FK')
begin
alter table BPM_Event_Master drop constraint BEM_BPRG_FK
end;
if exists(select 1 from sysobjects where name='BEM_BPRJ_FK')
begin
alter table BPM_Event_Master drop constraint BEM_BPRJ_FK
end;
if exists(select 1 from sysobjects where name='BEM_BPROL_FK')
begin
alter table BPM_Event_Master drop constraint BEM_BPROL_FK
end;
if exists(select 1 from sysobjects where name='BEM_BRL_FK')
begin
alter table BPM_Event_Master drop constraint BEM_BRL_FK
end;

if exists(select 1 from sysobjects where name='BPF_Cur_BACA_FK')
begin
alter table BPM_PROCESS_FLOW drop constraint BPF_Cur_BACA_FK
end;
if exists(select 1 from sysobjects where name='BPF_Conp_Req_BACA_FK')
begin
alter table BPM_PROCESS_FLOW drop constraint BPF_Conp_Req_BACA_FK
end;
if exists(select 1 from sysobjects where name='BSL_BSTL_FK')
begin
alter table BPM_SOURCE_Lkup drop constraint BSL_BSTL_FK
end;


if exists(select 1 from sysobjects where name='BPM_Activity_Attribute')
begin
drop table BPM_Activity_Attribute;
end;

create table BPM_Activity_Attribute 
  (BACA_ID int not null, 
   BEM_ID int not null, 
   BACL_ID int not null, 
   Activity_Flag_Name varchar(30), 
   Value_On_Complete varchar(30) not null , 
   Flow_Order int not null)
; -- tablespace MAXDat_Data;

alter table BPM_Activity_Attribute add constraint BPM_Activity_Attribute_PK primary key (BACA_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_Activity_Attribute add constraint BACA_UNK unique (BEM_ID , BACL_ID); -- using index tablespace MAXDat_INDX;
    
grant select on BPM_Activity_Attribute to MAXDat_Read_Only;
    
if exists(select 1 from sysobjects where name='BPM_Activity_Event')
begin
drop table BPM_Activity_Event;
end;
create table BPM_Activity_Event 
  (BACE_ID int not null constraint DK_BPM_Activity_Event default next value for Seq_BACE_ID, 
   BI_ID int not null, 
   BETL_ID int not null, 
   BACA_ID int not null, 
   Event_Date datetime not null, 
   BPMS_Processed varchar(1))
; -- tablespace MAXDat_Data;

alter table BPM_Activity_Event add constraint BPM_Activity_Event_PK primary key (BACE_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_Activity_Event add constraint BAE_UNK unique (BI_ID , BETL_ID , BACA_ID); -- using index tablespace MAXDat_INDX;
    
grant select on BPM_Activity_Event to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Activity_Event_Type_Lkup')
begin
drop table BPM_Activity_Event_Type_Lkup;
end;
create table BPM_Activity_Event_Type_Lkup 
  (BACETL_ID int not null, 
   Event_Type_Name varchar(20) not null, 
   Event_Type_Order int not null)
; -- tablespace MAXDat_Data;



alter table BPM_Activity_Event_Type_Lkup add constraint BPM_Activity_Event_Type_Lkup_PK primary key (BACETL_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_Activity_Event_Type_Lkup add constraint BAETL_UNK unique (Event_Type_Name);-- using index tablespace MAXDat_INDX ;

grant select on BPM_Activity_Event_Type_Lkup to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Activity_Lkup')
begin
drop table BPM_Activity_Lkup;
end;
create table BPM_Activity_Lkup 
  (BACL_ID int not null, 
   BACTL_ID int not null, 
   Activity_Name varchar(50) not null)
; -- tablespace MAXDat_Data;

alter table BPM_Activity_Lkup add constraint BPM_Activity_Lkup_PK primary key (BACL_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_Activity_Lkup add constraint BACL_UNK unique (BACTL_ID , Activity_Name); -- using index tablespace MAXDat_INDX;
    
grant select on BPM_Activity_Lkup to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Activity_Type_Lkup')
begin
drop table BPM_Activity_Type_Lkup;
end;
create table BPM_Activity_Type_Lkup 
  (BACTL_ID int not null, 
   Activity_Type_Cd varchar(1) not null, 
   Activity_Type_Desc varchar(35) not null)
; -- tablespace MAXDat_Data;

alter table BPM_Activity_Type_Lkup add constraint BPM_Activity_Type_Lkup_PK primary key (BACTL_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_Activity_Type_Lkup add constraint BATL_UNK unique (Activity_Type_Cd); -- using index tablespace MAXDat_INDX;

grant select on BPM_Activity_Type_Lkup to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Attribute')
begin
drop table BPM_Attribute;
end;
create table BPM_Attribute 
  (BA_ID int not null constraint DK_BPM_Attribute default next value for Seq_BA_ID, 
   BAL_ID int not null, 
   BEM_ID int not null, 
   When_Populated varchar(30) not null, 
   Effective_Date datetime not null, 
   End_Date datetime not null,
   Retain_History_Flag varchar(1))
; -- tablespace MAXDat_Data;

alter table BPM_Attribute add constraint BPM_Attribute_PK primary key (BA_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_Attribute add constraint BPM_Attribute_CK check (When_Populated in ('CREATE','UPDate','BOTH'));
alter table BPM_Attribute add constraint BA_Retain_History_Flag_CK check (Retain_History_Flag in ('Y', 'N'));
alter table BPM_Attribute add constraint BPM_Attribute_UNK unique (BAL_ID,BEM_ID,Effective_Date); -- using index tablespace MAXDat_INDX;

grant select on BPM_Attribute to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Attribute_Lkup')
begin
drop table BPM_Attribute_Lkup;
end;
create table BPM_Attribute_Lkup 
  (BAL_ID int not null, 
   BDL_ID int not null, 
   Name varchar(50) not null, 
   Purpose varchar(1000) not null)
; -- tablespace MAXDat_Data;

alter table BPM_Attribute_Lkup add constraint BPM_Attribute_Lkup_PK primary key (BAL_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_Attribute_Lkup add constraint BPM_Attribute_Lkup_UNK unique (Name , BDL_ID); -- using index tablespace MAXDat_INDX;   
   
grant select on BPM_Attribute_Lkup to MAXDat_Read_Only;
    
if exists(select 1 from sysobjects where name='BPM_Data_Model')
begin
drop table BPM_Data_Model;
end;
create table BPM_Data_Model
  (BDM_ID int not null,
   Code varchar(12) not null,
   Name varchar(12) not null)
; -- tablespace MAXDat_Data;


alter table BPM_Data_Model add constraint BPM_Data_Model_PK primary key (BDM_ID); -- using index tablespace MAXDat_INDX;

grant select on BPM_Data_Model to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Attribute_Staging_Table')
begin
drop table BPM_Attribute_Staging_Table;
end;
create table BPM_Attribute_Staging_Table
  (BAST_ID int not null constraint DK_BPM_Attribute_Staging_Table default next value for Seq_BAST_ID,
   BA_ID int not null,  
   BSL_ID int not null, 
   Staging_Table_Column varchar(30) not null)
; -- tablespace MAXDat_Data;

alter table BPM_Attribute_Staging_Table add constraint BAST_PK primary key (BAST_ID); -- using index tablespace MAXDat_INDX;
create index BAST_BA_ID_IX1 on BPM_Attribute_Staging_Table (BA_ID);-- tablespace MAXDat_INDX parallel compute statistics;  

grant select on BPM_Attribute_Staging_Table to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_DataType_Lkup')
begin
drop table BPM_DataType_Lkup;
end;
create table BPM_DataType_Lkup 
  (BDL_ID int not null, 
   DataType varchar(35) not null) 
; -- tablespace MAXDat_Data;

alter table BPM_DataType_Lkup add constraint BPM_DataType_Lkup_PK primary key (BDL_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_DataType_Lkup add constraint BD_UNK unique (DataType); -- using index tablespace MAXDat_INDX;   

grant select on BPM_DataType_Lkup to MAXDat_Read_Only;


if exists(select 1 from sysobjects where name='BPM_D_Hours')
begin
drop table BPM_D_Hours;
end;
create table BPM_D_Hours
    (D_HOUR numeric(2) not null
     ) ; -- tablespace MAXDat_Data;

alter table BPM_D_Hours add constraint BPM_D_Hours_PK primary key (D_HOUR); -- using index tablespace MAXDat_INDX;

grant select on BPM_D_Hours to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_D_Ops_Group_Task')
begin
drop table BPM_D_Ops_Group_Task;
end;
create table BPM_D_Ops_Group_Task 
  (Ops_Group varchar(50) not null, 
   Task_Type varchar(100) not null)
; -- tablespace MAXDat_Data;

alter table BPM_D_Ops_Group_Task add constraint BPM_D_Ops_Group_Task_PK primary key (Ops_Group,Task_Type);
--alter index BPM_D_Ops_Group_Task_PK rebuild tablespace MAXDat_INDX parallel;

grant select on BPM_D_Ops_Group_Task to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Event_Master')
begin
drop table BPM_Event_Master;
end;
create table BPM_Event_Master 
  (BEM_ID int not null, 
   BRL_ID int not null, 
   BPRJ_ID int not null, 
   BPRG_ID int not null, 
   BPROL_ID int not null, 
   Name varchar(50) , 
   DescRIPTION varchar(1000) not null, 
   Effective_Date datetime not null, 
   End_Date datetime not null)
; -- tablespace MAXDat_Data;

--comment on column BPM_Event_Master.BEM_ID is 'Surrogate ID populated by Sequence value.';

alter table BPM_Event_Master add constraint BPM_Event_Master_PK primary key (BEM_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_Event_Master add constraint BPM_Event_Master_UK unique (BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID); -- using index tablespace MAXDat_INDX;
    
grant select on BPM_Event_Master to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Identifier_Type_Lkup')
begin
drop table BPM_Identifier_Type_Lkup;
end;
create table BPM_Identifier_Type_Lkup 
  (BIL_ID int not null, 
   Name varchar(35) not null) 
; -- tablespace MAXDat_Data;

alter table BPM_Identifier_Type_Lkup add constraint BPM_Identifier_Lkup_PK primary key (BIL_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_Identifier_Type_Lkup add constraint BPM_Identifier_Lkup_UNK unique (Name); -- using index tablespace MAXDat_INDX;

grant select on BPM_Identifier_Type_Lkup to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Logging')
begin
drop table BPM_Logging;
end;
create table BPM_Logging
  (BL_ID           int not null constraint DK_BPM_Logging default next value for Seq_BL_ID,
   Log_Date        datetime not null,
   Log_Level       varchar(7) not null,
   PBQJ_ID         int,
   Run_Data_Object varchar(61),
   BSL_ID          int,
   BIL_ID          int,
   Identifier      varchar(100), 
   BI_ID           int,
   Message	       varchar(max),
   Error_Number    int,
   Backtrace       varchar(max))
--storage (initial 64K) partition by range (LOG_Date) interval (NUMTODSINTERVAL(1,'day')) (partition PT_BL_LOG_Date_LT_2012 values less than (TO_Date('20120101','YYYYMMDD'))) tablespace MAXDat_Data parallel
;

alter table BPM_Logging add constraint BPM_Logging_PK primary key (BL_ID); -- using index tablespace MAXDat_INDX;

create index BPM_Logging_LX1 on BPM_Logging (Log_Date); -- local online tablespace MAXDat_INDX parallel compute statistics;
create index BPM_Logging_LX2 on BPM_Logging (BSL_ID); -- local online tablespace MAXDat_INDX parallel compute statistics;

alter table BPM_Logging add constraint BPM_Logging_Log_Level_CK 
check (Log_Level in ('SEVERE','WARNING','INFO','CONFIG','FINE','FINER','FINEST'));

grant select on BPM_Logging to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Process_Flow')
begin
drop table BPM_Process_Flow;
end;
create table BPM_Process_Flow 
  (BPF_ID int not null, 
   Current_BACA_ID int not null, 
   Completion_Required_BACA_ID int not null)
; -- tablespace MAXDat_Data;

alter table BPM_Process_Flow add constraint BPM_Process_Flow_PK primary key (BPF_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_Process_Flow add constraint BPF_UNK unique (Current_BACA_ID,Completion_Required_BACA_ID); -- using index tablespace MAXDat_INDX;  

grant select on BPM_Process_Flow to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Process_Lkup')
begin
drop table BPM_Process_Lkup;
end;
create table BPM_Process_Lkup 
  (BPROL_ID int not null, 
   Name varchar(50) not null, 
   DescRIPTION varchar(250))
; -- tablespace MAXDat_Data;

alter table BPM_Process_Lkup add constraint BPM_Process_Lkup_PK primary key (BPROL_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_Process_Lkup add constraint BPM_Process_Lkup_UNK unique (Name); -- using index tablespace MAXDat_INDX;
    
grant select on BPM_Process_Lkup to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Program_Lkup')
begin
drop table BPM_Program_Lkup;
end;
create table BPM_Program_Lkup 
  (BPRG_ID int not null, 
   Name varchar(35) not null) 
; -- tablespace MAXDat_Data;

alter table BPM_Program_Lkup add constraint BPM_Program_Lkup_PK primary key (BPRG_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_Program_Lkup add constraint BPM_Program_UNK unique (Name); -- using index tablespace MAXDat_INDX;

grant select on BPM_Program_Lkup to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Project_Lkup')
begin
drop table BPM_Project_Lkup;
end;
create table BPM_Project_Lkup 
  (BPRJ_ID int not null, 
   Name varchar(35) not null)
; -- tablespace MAXDat_Data;

alter table BPM_Project_Lkup add constraint PK_BPM_Project_Lkup primary key (BPRJ_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_Project_Lkup add constraint BPM_Project_UNK unique (Name); -- using index tablespace MAXDat_INDX;

grant select on BPM_Project_Lkup to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Region_Lkup')
begin
drop table BPM_Region_Lkup;
end;
create table BPM_Region_Lkup 
  (BRL_ID int not null, 
   Name varchar(35) not null) 
; -- tablespace MAXDat_Data;

--comment on table BPM_REGION_Lkup is 'List of regions in MAXIMUS Health Services.';

alter table BPM_Region_Lkup add constraint BPM_Region_Lkup_PK primary key (BRL_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_Region_Lkup add constraint BPM_Region_UNK unique (Name); -- using index tablespace MAXDat_INDX;

grant select on BPM_Region_Lkup to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Source_Lkup')
begin
drop table BPM_Source_Lkup;
end;
create table BPM_Source_Lkup 
  (BSL_ID int not null, 
   Name varchar(35) not null, 
   BSTL_ID int not null) 
; -- tablespace MAXDat_Data;

alter table BPM_Source_Lkup add constraint BPM_Source_Lkup_PK primary key (BSL_ID); -- using index tablespace MAXDat_INDX;
alter table BPM_Source_Lkup add constraint BPM_Source_Lkup_UNK unique (Name); -- using index tablespace MAXDat_INDX;  

grant select on BPM_Source_Lkup to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Source_Type_Lkup')
begin
drop table BPM_Source_Type_Lkup;
end;
create table BPM_Source_Type_Lkup 
  (BSTL_ID int not null, 
   Name varchar(35) not null) 
; -- tablespace MAXDat_Data;
	
alter table BPM_Source_Type_Lkup add constraint BPM_Source_Type_Lkup_PK primary key (BSTL_ID); -- using index tablespace MAXDat_INDX;

grant select on BPM_Source_Type_Lkup to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='BPM_Update_Type_Lkup')
begin
drop table BPM_Update_Type_Lkup;
end;
create table BPM_Update_Type_Lkup 
  (BUTL_ID int not null, 
   Name varchar(35) not null) 
; -- tablespace MAXDat_Data;

alter table BPM_Update_Type_Lkup add constraint BPM_Update_Type_Lkup_PK primary key (BUTL_ID); -- using index tablespace MAXDat_INDX;

alter table BPM_Update_Type_Lkup add constraint BUTL_UNK unique (Name); -- using index tablespace MAXDat_INDX;

grant select on BPM_Update_Type_Lkup to MAXDat_Read_Only;

-- Foreign Keys.
alter table BPM_Activity_Attribute add constraint BAA_BEM_FK foreign key(BEM_ID) references BPM_Event_Master(BEM_ID);
alter table BPM_Activity_Attribute add constraint BACA_BACL_FK foreign key(BACL_ID) references BPM_Activity_Lkup(BACL_ID);
alter table BPM_Activity_Event add constraint BACE_BACA_FK foreign key(BACA_ID) references BPM_Activity_Attribute(BACA_ID);
alter table BPM_Activity_Event add constraint BACE_BACETL_FK foreign key(BETL_ID) references BPM_Activity_Event_Type_Lkup(BACETL_ID);
alter table BPM_Activity_Lkup add constraint BACL_BACTL_FK foreign key(BACTL_ID) references BPM_Activity_Type_Lkup(BACTL_ID);
alter table BPM_Attribute add constraint BA_BAL_FK foreign key (BAL_ID) references BPM_Attribute_Lkup (BAL_ID);
alter table BPM_Attribute add constraint BA_BEM_FK foreign key (BEM_ID) references BPM_Event_Master (BEM_ID);
alter table BPM_Attribute_Lkup add constraint BAL_BDL_FK foreign key(BDL_ID) references BPM_DataType_Lkup(BDL_ID);
--alter table BPM_Attribute_Staging_Table add constraint BAST_BA_FK foreign key(BA_ID) references BPM_Attribute(BA_ID);
alter table BPM_Attribute_Staging_Table add constraint BAST_BSL_FK foreign key(BSL_ID) references BPM_SOURCE_Lkup(BSL_ID);
alter table BPM_Event_Master add constraint BEM_BPRG_FK foreign key(BPRG_ID) references BPM_Program_Lkup(BPRG_ID);
alter table BPM_Event_Master add constraint BEM_BPRJ_FK foreign key(BPRJ_ID) references BPM_Project_Lkup(BPRJ_ID);
alter table BPM_Event_Master add constraint BEM_BPROL_FK foreign key(BPROL_ID) references BPM_Process_Lkup(BPROL_ID);
alter table BPM_Event_Master add constraint BEM_BRL_FK foreign key(BRL_ID) references BPM_Region_Lkup(BRL_ID);
alter table BPM_PROCESS_FLOW add constraint BPF_Cur_BACA_FK foreign key(CURRENT_BACA_ID) references BPM_Activity_Attribute(BACA_ID);
alter table BPM_PROCESS_FLOW add constraint BPF_Conp_Req_BACA_FK foreign key(Completion_Required_BACA_ID) references BPM_Activity_Attribute(BACA_ID);
alter table BPM_SOURCE_Lkup add constraint BSL_BSTL_FK foreign key(BSTL_ID) references BPM_Source_Type_Lkup(BSTL_ID);


/*

-- For MicroStrategy MASH reporting.
create view D_BPM_Data_Model_SV
as 
select 
  BDM_ID,
  Code,
  Name
from BPM_Data_Model;

grant select on D_BPM_Data_Model_SV to MAXDat_Read_Only;


create view D_Ops_Group_Task as
select 
  Ops_Group, 
  Task_Type "Task Type"
from BPM_D_Ops_Group_Task
;

grant select on D_Ops_Group_Task to MAXDat_Read_Only;


-- For MicroStrategy MASH reporting.
create or replace view D_BPM_Source_Lkup_SV as 
select 
  BSL_ID,
  Name,
  BSTL_ID
from BPM_Source_Lkup
with read only;

grant select on D_BPM_Source_Lkup_SV to MAXDat_Read_Only;
*/