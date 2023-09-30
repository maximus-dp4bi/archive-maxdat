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

--BPM_ACTIVITY_EVENTS
create sequence Seq_BACE_ID as int increment by 1;
grant update, references on Seq_BACE_ID to MAXDAT_READ_ONLY; 

--BPM_ATTRIBUTE
create sequence Seq_BA_ID as int increment by 1;
grant update, references on Seq_BA_ID to MAXDAT_READ_ONLY; 

--BPM_ATTRIBUTE_STAGING_TABLE
create sequence Seq_BAST_ID as int increment by 1;
grant update, references on Seq_BA_ID to MAXDAT_READ_ONLY; 

--BPM_INSTANCE
create sequence Seq_BI_ID as int increment by 1;
grant update, references on Seq_BI_ID to MAXDAT_READ_ONLY; 

--BPM_INSTANCE_ATTRIBUTE
create sequence Seq_BIA_ID as int increment by 1;
grant update, references on Seq_BIA_ID to MAXDAT_READ_ONLY; 

-- BPM_LOGGING
create sequence Seq_BL_ID as int increment by 1;
grant update, references on Seq_BL_ID to MAXDAT_READ_ONLY; 

--BPM_UPDATE_EVENT
create sequence Seq_BUE_ID as int increment by 1;
grant update, references on Seq_BUE_ID to MAXDAT_READ_ONLY; 
