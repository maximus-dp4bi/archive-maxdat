-- Create ETL Sequences.
use MAXDAT;
if exists(select 1 from sysobjects where name='CELL_History_Seq')
begin
drop Sequence CELL_History_Seq
end;
if exists(select 1 from sysobjects where name='Seq_CEC')
begin
drop Sequence Seq_CEC
end;
if exists(select 1 from sysobjects where name='Seq_CECT_ID')
begin
drop Sequence Seq_CECT_ID
end;
if exists(select 1 from sysobjects where name='Seq_CECT_HS_ID')
begin
drop Sequence Seq_CECT_HS_ID
end;
if exists(select 1 from sysobjects where name='Seq_CEEL_ID')
begin
drop Sequence Seq_CEEL_ID
end;
if exists(select 1 from sysobjects where name='Seq_CELL_ID')
begin
drop Sequence Seq_CELL_ID
end;
if exists(select 1 from sysobjects where name='Seq_CICT_ID')
begin
drop Sequence Seq_CICT_ID
end;
if exists(select 1 from sysobjects where name='Seq_HOLIDAY_ID')
begin
drop Sequence Seq_HOLIDAY_ID
end;
if exists(select 1 from sysobjects where name='Seq_JOB_ID')
begin
drop Sequence Seq_JOB_ID
end;


create Sequence CELL_History_Seq as int increment by 1;
grant update, references on CELL_History_Seq to MAXDAT_READ_ONLY; 

create Sequence Seq_CEC as int increment by 1;
grant update, references on Seq_CEC to MAXDAT_READ_ONLY; 

create Sequence Seq_CECT_ID as int increment by 1;
grant update, references on Seq_CECT_ID to MAXDAT_READ_ONLY; 

create Sequence Seq_CECT_HS_ID as int increment by 1;
grant update, references on Seq_CECT_HS_ID to MAXDAT_READ_ONLY; 

create Sequence Seq_CEEL_ID as int increment by 1;
grant update, references on Seq_CEEL_ID to MAXDAT_READ_ONLY; 

create Sequence Seq_CELL_ID as int increment by 1;
grant update, references on Seq_CELL_ID to MAXDAT_READ_ONLY; 

create Sequence Seq_CICT_ID as int increment by 1;
grant update, references on Seq_CICT_ID to MAXDAT_READ_ONLY; 

create Sequence Seq_Holiday_ID as int increment by 1;
grant update, references on Seq_Holiday_ID to MAXDAT_READ_ONLY; 

create Sequence Seq_Job_ID as int increment by 1;
grant update, references on Seq_Job_ID to MAXDAT_READ_ONLY; 
