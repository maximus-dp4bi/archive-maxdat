use maxdat;

if exists(select 1 from sysobjects where name='BPM_Update_Event_Queue_Archive')
begin
drop table BPM_Update_Event_Queue_Archive;
end;

if exists(select 1 from sysobjects where name='BPM_Update_Event_Queue')
begin
drop table BPM_Update_Event_Queue;
end;

if exists(select 1 from sysobjects where name='D_BPM_Update_Event_Queue_SV')
begin
drop view D_BPM_Update_Event_Queue_SV;
end;

if exists(select 1 from sysobjects where name='Seq_BUEQ_ID')
begin
drop Sequence Seq_BUEQ_ID;
end;

if exists(select 1 from sysobjects where name='Seq_Process_BUEQ_ID')
begin
drop Sequence Seq_Process_BUEQ_ID;
end;

create Sequence Seq_BUEQ_ID as int start with 265 increment by 1;
grant update, references on Seq_BUEQ_ID to MAXDAT_READ_ONLY; 

create Sequence Seq_Process_BUEQ_ID as int start with 265 increment by 1;
grant update, references on Seq_Process_BUEQ_ID to MAXDAT_READ_ONLY; 

create table BPM_Update_Event_Queue
  (BUEQ_ID integer not null constraint DK_BPM_Update_Event_Queue default next value for Seq_BUEQ_ID,
   BSL_ID integer not null,
   BIL_ID integer not null,
   Identifier varchar(100) not null,
   Event_Date date not null,
   Queue_Date date not null,
   Process_BUEQ_ID integer  constraint DK_BPM_Update_Event_Queue2 default next value for Seq_Process_BUEQ_ID,
   Wrote_BPM_Semantic_Date date, 
   Data_Version integer not null,
   Old_Data xml,
   New_Data xml not null)
--xml column Old_Data store as binary xml
--xml column New_Data store as binary xml
--partition by range (BSL_ID) interval (1) (partition PT_BUEQ_LT_0 values less than (0)) 
--tablespace MAXDat_Data parallel
;

alter table BPM_Update_Event_Queue add constraint BUEQ_PK primary key (BUEQ_ID); -- using index tablespace MAXDat_INDX;

create index BUEQ_IX1 on BPM_Update_Event_Queue (BSL_ID,Event_Date); -- tablespace MAXDAT_INDX parallel compute statistics;

create index BUEQ_LX1 on BPM_Update_Event_Queue (Event_Date); -- local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX2 on BPM_Update_Event_Queue (Process_BUEQ_ID); -- local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX3 on BPM_Update_Event_Queue (Identifier); -- local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX5 on BPM_Update_Event_Queue (Wrote_BPM_Semantic_Date); -- local online tablespace MAXDAT_INDX parallel compute statistics;

alter table BPM_Update_Event_Queue add constraint BUEQ_BSL_ID_FK foreign key (BSL_ID) references BPM_Source_Lkup (BSL_ID);
alter table BPM_Update_Event_Queue add constraint BUEQ_BIL_ID_FK foreign key (BIL_ID) references BPM_Identifier_Type_Lkup (BIL_ID);

grant select on BPM_Update_Event_Queue to MAXDat_Read_Only;

create table BPM_Update_Event_Queue_Archive
  (BUEQ_ID integer not null,
   BSL_ID integer not null,
   BIL_ID integer not null,
   Identifier varchar(100) not null,
   Event_Date date not null,
   Queue_Date date not null,
   Process_BUEQ_ID integer,
   Wrote_BPM_Semantic_Date date, 
   Data_Version integer not null,
   Old_Data xml,
   New_Data xml not null)
--xmltype column OLD_DATA store as binary xml
--xmltype column NEW_DATA store as binary xml
--partition by range (BSL_ID) interval (1) (partition PT_BUEQ_LT_0 values less than (0)) tablespace MAXDAT_DATA parallel
;

alter table BPM_Update_Event_Queue_Archive add constraint BUEQA_PK primary key (BUEQ_ID); -- using index tablespace MAXDAT_INDX;

grant select on BPM_Update_Event_Queue_Archive to MAXDat_Read_Only;

go

-- For MicroStrategy MASH reporting.
create view D_BPM_Update_Event_Queue_SV as 
select *
from BPM_Update_Event_Queue
--with read only
;

go

grant select on D_BPM_Update_Event_Queue_SV to MAXDat_Read_Only;

go