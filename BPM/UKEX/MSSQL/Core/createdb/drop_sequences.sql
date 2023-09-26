use MAXDAT;
if exists(select 1 from sysobjects where name='Seq_BACE_ID')
begin
drop Sequence Seq_BACE_ID
end;
if exists(select 1 from sysobjects where name='Seq_BA_ID')
begin
drop Sequence Seq_BA_ID
end;
if exists(select 1 from sysobjects where name='Seq_BAST_ID')
begin
drop Sequence Seq_BAST_ID
end;
if exists(select 1 from sysobjects where name='Seq_BI_ID')
begin
drop Sequence Seq_BI_ID
end;
if exists(select 1 from sysobjects where name='Seq_BIA_ID')
begin
drop Sequence Seq_BIA_ID
end;
if exists(select 1 from sysobjects where name='Seq_BL_ID')
begin
drop Sequence Seq_BL_ID
end;
if exists(select 1 from sysobjects where name='Seq_BUE_ID')
begin
drop Sequence Seq_BUE_ID
end;
