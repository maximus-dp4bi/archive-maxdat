use MAXDAT;

if exists(select 1 from sysobjects where name='Corp_ETL_Clean_table')
begin
drop table Corp_ETL_Clean_Table;
end;

if exists(select 1 from sysobjects where name='Corp_ETL_Clean_Table_HS')
begin
drop table Corp_ETL_Clean_Table_HS;
end;

if exists(select 1 from sysobjects where name='Corp_ETL_Control')
begin
drop table Corp_ETL_Control;
end;

if exists(select 1 from sysobjects where name='Corp_ETL_Error_Log')
begin
drop table Corp_ETL_Error_Log;
end;

if exists(select 1 from sysobjects where name='Corp_ETL_Job_Statistics')
begin
drop table Corp_ETL_Job_Statistics;
end;


if exists(select 1 from sysobjects where name='Corp_ETL_List_Lkup')
begin
drop table Corp_ETL_List_Lkup;
end;

if exists(select 1 from sysobjects where name='Corp_ETL_List_Lkup_Hist')
begin
drop table Corp_ETL_List_Lkup_Hist;
end;

if exists(select 1 from sysobjects where name='Corp_Instance_Cleanup_Table')
begin
drop table Corp_Instance_Cleanup_Table;
end;

if exists(select 1 from sysobjects where name='Holidays')
begin
drop table Holidays;
end;


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

if exists(select 1 from sysobjects where name='BPM_Activity_Event')
begin
drop table BPM_Activity_Event;
end;

if exists(select 1 from sysobjects where name='BPM_Activity_Event_Type_Lkup')
begin
drop table BPM_Activity_Event_Type_Lkup;
end;

if exists(select 1 from sysobjects where name='BPM_Activity_Lkup')
begin
drop table BPM_Activity_Lkup;
end;

if exists(select 1 from sysobjects where name='BPM_Activity_Type_Lkup')
begin
drop table BPM_Activity_Type_Lkup;
end;

if exists(select 1 from sysobjects where name='BPM_Attribute')
begin
drop table BPM_Attribute;
end;

if exists(select 1 from sysobjects where name='BPM_Attribute_Lkup')
begin
drop table BPM_Attribute_Lkup;
end;

if exists(select 1 from sysobjects where name='BPM_Data_Model')
begin
drop table BPM_Data_Model;
end;

if exists(select 1 from sysobjects where name='BPM_Attribute_Staging_Table')
begin
drop table BPM_Attribute_Staging_Table;
end;

if exists(select 1 from sysobjects where name='BPM_DataType_Lkup')
begin
drop table BPM_DataType_Lkup;
end;

if exists(select 1 from sysobjects where name='BPM_D_Hours')
begin
drop table BPM_D_Hours;
end;

if exists(select 1 from sysobjects where name='BPM_D_Ops_Group_Task')
begin
drop table BPM_D_Ops_Group_Task;
end;

if exists(select 1 from sysobjects where name='BPM_Event_Master')
begin
drop table BPM_Event_Master;
end;

if exists(select 1 from sysobjects where name='BPM_Identifier_Type_Lkup')
begin
drop table BPM_Identifier_Type_Lkup;
end;

if exists(select 1 from sysobjects where name='BPM_Logging')
begin
drop table BPM_Logging;
end;

if exists(select 1 from sysobjects where name='BPM_Process_Flow')
begin
drop table BPM_Process_Flow;
end;

if exists(select 1 from sysobjects where name='BPM_Process_Lkup')
begin
drop table BPM_Process_Lkup;
end;

if exists(select 1 from sysobjects where name='BPM_Program_Lkup')
begin
drop table BPM_Program_Lkup;
end;

if exists(select 1 from sysobjects where name='BPM_Project_Lkup')
begin
drop table BPM_Project_Lkup;
end;

if exists(select 1 from sysobjects where name='BPM_Region_Lkup')
begin
drop table BPM_Region_Lkup;
end;

if exists(select 1 from sysobjects where name='BPM_Source_Lkup')
begin
drop table BPM_Source_Lkup;
end;

if exists(select 1 from sysobjects where name='BPM_Source_Type_Lkup')
begin
drop table BPM_Source_Type_Lkup;
end;

if exists(select 1 from sysobjects where name='BPM_Update_Type_Lkup')
begin
drop table BPM_Update_Type_Lkup;
end;

