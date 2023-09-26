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
if exists(select 1 from sysobjects where name='Seq_Holiday_ID')
begin
drop Sequence Seq_Holiday_ID
end;
if exists(select 1 from sysobjects where name='Seq_Job_ID')
begin
drop Sequence Seq_Job_ID
end;
