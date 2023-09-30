use maxdat;

if exists(select 1 from sysobjects where name='MAXDat_Admin_Audit_Logging')
begin
drop table MAXDat_Admin_Audit_Logging;
end;

if exists(select 1 from sysobjects where name='Seq_MAAL_ID')
begin
drop Sequence Seq_MAAL_ID;
end;

create Sequence Seq_MAAL_ID as int increment by 1;
grant update, references on Seq_MAAL_ID to MAXDAT_READ_ONLY; 

create table MAXDat_Admin_Audit_Logging
  (MAAL_ID int not null constraint DK_MAXDat_Admin_Audit_Logging default next value for Seq_MAAL_ID,
   User_Name varchar(30) not null,
   Log_Date date not null,
   Run_Dat_Object varchar(61),
   BSL_ID int,
   Message varchar)
;

alter table MAXDat_Admin_Audit_Logging add constraint MAXDat_Admin_Audit_Logging_PK primary key (MAAL_ID);

create index MAXDat_Admin_Audit_Logging_IX1 on MAXDat_Admin_Audit_Logging (Log_Date);

grant select on MAXDat_Admin_Audit_Logging to MAXDat_Read_Only;



