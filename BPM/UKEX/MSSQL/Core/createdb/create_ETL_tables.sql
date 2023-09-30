use MAXDAT;

--create role MAXDat_Read_Only;
-- Create ETL tables.

if exists(select 1 from sysobjects where name='Corp_ETL_Clean_table')
begin
drop table Corp_ETL_Clean_Table;
end;
create table Corp_ETL_Clean_Table
  (CECT_ID int not null primary key constraint DK_Corp_ETL_Clean_Table default next value for Seq_CECT_ID, 
   Table_Name varchar(100) not null, 
   Column_Name varchar(100), 
   Delete_Where_Clause varchar(4000), 
   Days_Till_Delete numeric, 
   Start_Date datetime not null, 
   End_Date datetime not null, 
   Created_TS datetime not null, 
   Last_Update_TS datetime not null,
   Arc_Flag	varchar(1),
   Arc_Table	varchar(100))
--tablespace MAXDAT_DATA
;

--alter table Corp_ETL_CLEAN_TABLE add constraint CECT_PK primary key (CECT_ID)
--using index tablespace MAXDAT_INDX
--;

grant select on Corp_ETL_Clean_Table to MAXDat_Read_Only;


if exists(select 1 from sysobjects where name='Corp_ETL_Clean_Table_HS')
begin
drop table Corp_ETL_Clean_Table_HS;
end;

create table Corp_ETL_Clean_Table_HS 
  (CECT_HS_ID int not null constraint DK_Corp_ETL_Clean_Table_HS default next value for Seq_CECT_HS_ID, 
   CECT_ID numeric(5,0), 
   Table_Name varchar(100) not null, 
   Column_Name varchar(100), 
   Delete_Where_Clause varchar(4000), 
   Days_Till_Delete numeric, 
   Start_Date datetime not null, 
   End_date datetime not null, 
   Created_TS datetime not null, 
   Last_Update_TS datetime not null,
   Arc_Flag varchar(1), 
   Arc_table varchar(100), 
   HS_Created_TS datetime not null, 
   HS_Last_Update_TS datetime not null, 
   HS_Action varchar(10))
--tablespace MAXDAT_DATA 
;
  
alter table Corp_ETL_CLEAN_TABLE_HS add constraint CECT_HS_PK primary key (CECT_HS_ID)
--using index tablespace MAXDAT_INDX;

grant select on Corp_ETL_Clean_Table_HS to MAXDat_Read_Only;


if exists(select 1 from sysobjects where name='Corp_ETL_Control')
begin
drop table Corp_ETL_Control;
end;

create table Corp_ETL_Control
  (Name        varchar(50) not null,
   Value_Type  varchar(1) not null,
   Value       varchar(100) not null,
   Description varchar(400),
   Created_TS  datetime not null,
   Updated_TS  datetime not null)
--tablespace MAXDAT_DATA
;
     
--comment on column  Corp_ETL_CONTROL.NAME is 'Named Variable which will have a value stored';
--comment on column  Corp_ETL_CONTROL.VALUE_TYPE is 'Type of the named variable';
--comment on column  Corp_ETL_CONTROL.VALUE is 'Holds the value for the named variable identifier - secondary lookup value';
--comment on column  Corp_ETL_CONTROL.DESCRIPTION is 'Description of named variable';
--comment on column  Corp_ETL_CONTROL.CREATED_TS is 'Date variable created';
--comment on column  Corp_ETL_CONTROL.UPDATED_TS is 'Date Variable updated';

alter table Corp_ETL_Control add constraint CECTL_PK primary key (Name)
--using index tablespace MAXDAT_INDX;
      
grant select on Corp_ETL_Control to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='Corp_ETL_Error_Log')
begin
drop table Corp_ETL_Error_Log;
end;

create table Corp_ETL_Error_Log
  (CEEL_ID      int not null constraint DK_Corp_ETL_Error_Log default next value for Seq_CEEL_ID,
   Err_Date     datetime default getdate() not null,
   Err_Level    varchar(20) default 'CRITICAL' not null,
   Process_Name varchar(120) not null,
   Job_Name     varchar(120) not null,
   Nr_Of_Error  numeric,
   Error_Desc   varchar(4000),
   Error_Field  varchar(400),
   Error_Codes  varchar(400),
   Create_TS    datetime not null,
   Update_TS    datetime not null,
   Driver_Table_Name varchar(100), 
   Driver_Key_Number varchar(100))
--tablespace MAXDAT_DATA
;

--comment on column Corp_ETL_ERROR_LOG.ERR_DATE is 'Date of Error, Defaults to System date' ;
--comment on column Corp_ETL_ERROR_LOG.ERR_LEVEL is 'Level or error - ABORT,CRITICAL,LOG Defaults to CRITICAL' ;
--comment on column Corp_ETL_ERROR_LOG.PROCESS_NAME is 'Name of process, this should identify what workbook the error came from';  
--comment on column Corp_ETL_ERROR_LOG.JOB_NAME is 'Name of Job or Transformation';  
--comment on column Corp_ETL_ERROR_LOG.NR_OF_ERROR is 'Corresponds to the Kettle Error filed of the same name';
--comment on column Corp_ETL_ERROR_LOG.ERROR_DESC is 'Corresponds to the Kettle Error filed of the same name';
--comment on column Corp_ETL_ERROR_LOG.ERROR_CODES is 'Corresponds to the Kettle Error field of the same name';
--comment on column Corp_ETL_ERROR_LOG.ERROR_FIELD is 'Corresponds to the Kettle Error field of the same name';
--comment on column Corp_ETL_ERROR_LOG.DRIVER_TABLE_NAME is 'Corresponds to the source table that the record is from';
--comment on column Corp_ETL_ERROR_LOG.DRIVER_KEY_numeric is 'Corresponds to the Record ID causing the error';
   
alter table Corp_ETL_Error_Log add constraint Corp_ETL_Error_Log_PK primary key (CEEL_ID)
--using index tablespace MAXDAT_INDX
;

alter table Corp_ETL_Error_Log add constraint Err_Level_Chk check (Err_Level in ('ABORT','CRITICAL','LOG'));

grant select on Corp_ETL_Error_Log to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='Corp_ETL_Job_Statistics')
begin
drop table Corp_ETL_Job_Statistics;
end;

create table Corp_ETL_Job_Statistics 
  (Job_ID int not null constraint DK_Corp_ETL_Job_Statistics default next value for Seq_Job_ID, 
   Job_Name varchar(80) not null, 
   Job_Status_Cd varchar(20) not null, 
   File_Name varchar(512), 
   Record_Count numeric, 
   Processed_Count numeric, 
   Error_Count numeric,
   Warning_Count numeric, 
   Record_Inserted_Count numeric, 
   Record_Updated_Count numeric, 
   Job_Start_Date datetime, 
   Job_End_Date datetime)
--tablespace MAXDAT_DATA
;

alter table Corp_ETL_Job_Statistics add constraint Corp_ETL_Job_Statistics_PK primary key (Job_ID)
--using index tablespace MAXDAT_INDX
;

grant select on Corp_ETL_Job_Statistics to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='Corp_ETL_List_Lkup')
begin
drop table Corp_ETL_List_Lkup;
end;

create table Corp_ETL_List_Lkup
  (CELL_ID    int not null constraint DK_Corp_ETL_List_Lkup default next value for Seq_CELL_ID,
   Name       varchar(30) not null,
   List_Type  varchar(30) not null,
   Value      varchar(100) not null,
   Out_Var    varchar(500),
   Ref_Type   varchar(100),
   Ref_ID     numeric(38),
   Start_Date datetime,
   End_Date   datetime,
   Comments   varchar(4000),
   Created_TS datetime not null,
   Updated_TS datetime not null)
--tablespace MAXDAT_DATA
;

--comment on table Corp_ETL_LIST_LKUP is 'Used to create list of values to used when pulling data for savvion';

--comment on column Corp_ETL_LIST_LKUP.NAME is 'LIST(lookup rule name for list of values)/IFTHEN(IF VALUE THEN OUT_VAR)/ID(REFERENCE AND ID)';
--comment on column Corp_ETL_LIST_LKUP.VALUE is 'Either a list or reference value - Secondary lookup value';
--comment on column Corp_ETL_LIST_LKUP.OUT_VAR is 'Value to be extacted from table';
--comment on column Corp_ETL_LIST_LKUP.REF_TYPE is 'Table name if ref id is prim key';
--comment on column Corp_ETL_LIST_LKUP.REF_ID is 'Prim key when ref_type has table name';
--comment on column Corp_ETL_LIST_LKUP.START_DATE is 'used to turn on value';
--comment on column Corp_ETL_LIST_LKUP.END_DATE is 'Used to turn off value';

alter table Corp_ETL_List_Lkup add constraint Corp_ETL_List_Lkup_PK primary key (CELL_ID)
--using index tablespace MAXDAT_INDX
;

alter table Corp_ETL_List_Lkup add constraint Corp_ETL_List_Lkup_UK unique (Name,List_Type,Value)
--using index tablespace MAXDAT_INDX
;

grant select on Corp_ETL_List_Lkup to MAXDat_Read_Only; 


if exists(select 1 from sysobjects where name='Corp_ETL_List_Lkup_Hist')
begin
drop table Corp_ETL_List_Lkup_Hist;
end;

create table Corp_ETL_List_Lkup_Hist
  (CELL_History_ID int not null,
   Hist_Type       varchar(100),
   CELL_ID         numeric not null,
   Name            varchar(30) not null,
   List_Type       varchar(30) not null,
   Value           varchar(100) not null,
   Out_Var         varchar(500),
   Ref_Type        varchar(100),
   Ref_ID          numeric(38),
   Start_Date      datetime,
   End_Date        datetime,
   --Comments        varchar(4000),
   Created_TS      datetime not null,
   Updated_TS      datetime not null,
   Hist_Created_TS datetime not null,
   Hist_User       varchar(4000),
   Hist_Updated_TS datetime not null)
--tablespace MAXDAT_DATA
;

alter table Corp_ETL_List_Lkup_Hist add constraint Corp_ETL_List_Lkup_Hist_PK primary key (CELL_HISTORY_ID)
--using index tablespace MAXDAT_INDX
;

grant select on Corp_ETL_List_Lkup_Hist to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='Corp_Instance_Cleanup_Table')
begin
drop table Corp_Instance_Cleanup_Table;
end;

create table Corp_Instance_Cleanup_Table 
  (CICT_ID int not null constraint DK_Corp_Instance_Cleanup_Table default next value for Seq_CICT_ID, 
   System_Name varchar(32), 
   Cleanup_Name varchar(100), 
   Run varchar(1), 
   Start_Date datetime, 
   Start_Time varchar(10), 
   End_Date datetime, 
   End_Time varchar(10), 
   Statement varchar(4000), 
   Created_TS datetime not null, 
   Last_Update_TS datetime not null)
--tablespace MAXDAT_DATA 
;

create unique index Corp_Instance_Cleanup_IX1 on Corp_Instance_Cleanup_Table (CICT_ID) 
--tablespace MAXDAT_INDX 
;

grant select on Corp_Instance_Cleanup_Table to MAXDat_Read_Only;

if exists(select 1 from sysobjects where name='Holidays')
begin
drop table Holidays;
end;

create table Holidays
  (Holiday_ID   int not null constraint DK_Holidays default next value for Seq_Holiday_ID,
   Holiday_Year numeric(4),
   Holiday_Date date,
   Description  varchar(128),
   Created_By   varchar(80),
   Create_TS    datetime,
   Updated_By   varchar(80),
   Update_TS    datetime)
--tablespace MAXDAT_DATA
;

alter table Holidays add constraint Holidays_PK primary key (Holiday_ID)
--using index tablespace MAXDAT_INDX
;

alter table Holidays add constraint Holidays_UK1 unique (Holiday_Year,Holiday_Date)
--using index tablespace MAXDAT_INDX
;

grant select on Holidays to MAXDat_Read_Only; 