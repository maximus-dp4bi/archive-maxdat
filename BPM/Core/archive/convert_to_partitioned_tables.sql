-- Convert BPM_ERRORS into a partitioned table.

-- Drop old error data.
drop table BPM_ERRORS;

-- Create partitioned table.
create table BPM_ERRORS
  (BE_ID           number,
   ERROR_DATE      date not null,
   RUN_DATA_OBJECT varchar2(61),
   SOURCE_ID       varchar2(100), -- usually holds IDENTIFIER, rename after all direct triggers replaced with queue model
   BI_ID           number,
   BIA_ID          number, -- actually holds BA_ID, rename after all direct triggers replaced with queue model
   ERROR_NUMBER    number,
   ERROR_MESSAGE   clob,
   BACKTRACE       clob)
partition by range (ERROR_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BE_ERROR_DATE_LT_2012 values less than (to_date('20120101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;

-- Add indexes to partitioned table.
alter table BPM_ERRORS add constraint BPM_ERRORS_PK primary key (BE_ID);
alter index BPM_ERRORS_PK rebuild tablespace MAXDAT_INDX parallel;

create index BPM_ERRORS_IXL1 on BPM_ERRORS (ERROR_DATE) online tablespace MAXDAT_INDX parallel compute statistics;


-- Convert BPM_INSTANCE_ATTRIBUTE into a partitioned table.

-- Copy data into partitioned table.
create table P_BPM_INSTANCE_ATTRIBUTE
  (BIA_ID       number not null,
   BI_ID        number not null,
   BA_ID        number not null,
   VALUE_NUMBER number,
   VALUE_DATE   date,
   VALUE_CHAR   varchar2(100),
   START_DATE   date not null,
   END_DATE     date,
   BUE_ID       number not null)
partition by range (BA_ID)
interval(1)
  (partition PT_BIA_BA_LT_0 values less than (0))
tablespace MAXDAT_DATA parallel;

-- Remove constraints and indexes and backup orginal, non-partitioned table.
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BPM_INSTANCE_ATTRIBUTE_PK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BPM_INSTANCE_ATTRIBUTE_UNK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BA_BIA_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BI_BIA_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BUE_BIA_FK;
drop index BPM_INSTANCE_ATTRIBUTE_IX1;
drop index BPM_INSTANCE_ATTRIBUTE_IX4;
drop index BPM_INSTANCE_ATTRIBUTE_IX5;
drop index BPM_INSTANCE_ATTRIBUTE_IX6;
drop index BPM_INSTANCE_ATTRIBUTE_IX7;
drop materialized view log on BPM_INSTANCE_ATTRIBUTE;

-- Copy data into partitioned table.
insert into P_BPM_INSTANCE_ATTRIBUTE
select * from BPM_INSTANCE_ATTRIBUTE;
commit;

-- Rename tables.
alter table BPM_INSTANCE_ATTRIBUTE rename to BPM_INSTANCE_ATTRIBUTE_BACKUP;
alter table P_BPM_INSTANCE_ATTRIBUTE rename to BPM_INSTANCE_ATTRIBUTE;

-- Restore triggers.
drop trigger TRG_R_BIU_BPM_INSTANCE_ATTR;

CREATE OR REPLACE TRIGGER TRG_R_BIU_BPM_INSTANCE_ATTR
 BEFORE INSERT OR UPDATE
 ON BPM_INSTANCE_ATTRIBUTE
 FOR EACH ROW
Begin
        If Inserting Then
                If :new.BIA_ID Is Null Then
                        Select SEQ_BIA_ID.Nextval
                          Into :new.BIA_ID
                          From Dual;
                End If;
                IF :NEW.START_DATE IS NULL THEN
                   SELECT SYSDATE INTO :NEW.START_DATE FROM dual;
                END IF;
                IF :NEW.END_DATE IS NULL THEN
                   SELECT TO_DATE('20770707','YYYYMMDD') INTO :NEW.END_DATE FROM dual;
                END IF;
        End If;
End;
/

update BPM_INSTANCE set END_DATE = to_date('20770707','YYYYMMDD') where END_DATE is null;
commit;

-- Add indexes to partitioned table.
alter table BPM_INSTANCE_ATTRIBUTE add constraint BPM_INSTANCE_ATTRIBUTE_PK primary key (BIA_ID);
alter index BPM_INSTANCE_ATTRIBUTE_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index BPM_INSTANCE_ATTRIBUTE_UNK1 on BPM_INSTANCE_ATTRIBUTE (BI_ID,BA_ID,START_DATE,END_DATE,BUE_ID) online tablespace MAXDAT_INDX parallel compute statistics; 
create index BPM_INSTANCE_ATTRIBUTE_IX1 on BPM_INSTANCE_ATTRIBUTE (BI_ID,BA_ID,END_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create index BPM_INSTANCE_ATTRIBUTE_IX2 on BPM_INSTANCE_ATTRIBUTE (BUE_ID) online tablespace MAXDAT_INDX parallel compute statistics; 

-- Convert BPM_INSTANCE into a partitioned table.

create table P_BPM_INSTANCE
  (BI_ID            number not null,
   BEM_ID           number not null,
   IDENTIFIER       varchar2(35),
   BIL_ID           number not null,
   BSL_ID           number not null,
   START_DATE       date not null,
   END_DATE         date,
   SOURCE_ID        varchar2(100),
   CREATION_DATE    date,
   LAST_UPDATE_DATE date not null)
partition by range (BEM_ID)
interval(1)
  (partition PT_BI_BEM_LT_0 values less than (0))
tablespace MAXDAT_DATA parallel;

-- Remove constraints and indexes and backup orginal, non-partitioned table.
alter table BPM_INSTANCE drop constraint PK_BPM_INSTANCE;
alter table BPM_INSTANCE drop constraint BPM_INSTANCE_UNK;
alter table BPM_INSTANCE drop constraint BPM_INSTANCE_UNK2;
alter table BPM_INSTANCE drop constraint BEM_BI_FK;
alter table BPM_INSTANCE drop constraint BITL_BI_FK;
alter table BPM_INSTANCE drop constraint BSL_BI_FK;
alter table BPM_UPDATE_EVENT drop constraint BI_BUE_FK ;
drop index BPM_INSTANCE_IX1;
drop index BPM_INSTANCE_UNK3;
drop index BPM_INSTANCE_UNK4;
drop index VBI_UBK4;
drop materialized view log on BPM_INSTANCE;

-- Copy data into partitioned table.
insert into P_BPM_INSTANCE
select * from BPM_INSTANCE;
commit;

-- Rename tables.
alter table BPM_INSTANCE rename to BPM_INSTANCE_BACKUP;
alter table P_BPM_INSTANCE rename to BPM_INSTANCE;

-- Restore triggers.
drop trigger TRG_R_BIU_BPM_INSTANCE;

CREATE OR REPLACE TRIGGER TRG_R_BIU_BPM_INSTANCE
 BEFORE INSERT OR UPDATE
 ON BPM_INSTANCE
 FOR EACH ROW
Begin
        If Inserting Then
                If :new.BI_ID Is Null Then
                        Select SEQ_BI_ID.Nextval
                          Into :new.BI_ID
                          From Dual;
                End If;
                If :new.END_DATE is null then
                  :new.END_DATE := TO_DATE('20770707','YYYYMMDD');
                END IF;
        End If;
End;
/

-- Add indexes to partitioned table.
alter table BPM_INSTANCE add constraint BPM_INSTANCE_PK primary key (BI_ID);
alter index BPM_INSTANCE_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index BPM_INSTANCE_UNK1 on BPM_INSTANCE (IDENTIFIER,BEM_ID,BIL_ID,BSL_ID) online tablespace MAXDAT_INDX parallel compute statistics;


-- Add foreign keys for partitioned tables.

alter table BPM_UPDATE_EVENT add constraint BEM_BI_FK
foreign key (BI_ID) references BPM_INSTANCE (BI_ID);

alter table BPM_INSTANCE add constraint BI_BEM_FK
foreign key (BEM_ID) references BPM_EVENT_MASTER (BEM_ID);

alter table BPM_INSTANCE add constraint BI_BIL_FK
foreign key (BIL_ID) references BPM_IDENTIFIER_TYPE_LKUP (BIL_ID);

alter table BPM_INSTANCE add constraint BI_BSL_FK
foreign key (BSL_ID) references BPM_SOURCE_LKUP (BSL_ID);

alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BA_FK
foreign key (BA_ID) references BPM_ATTRIBUTE (BA_ID);

alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BI_FK
foreign key (BI_ID) references BPM_INSTANCE (BI_ID);

alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BUE_FK
foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);


-- Analyze tables.
analyze table BPM_ERRORS compute statistics;
analyze table BPM_INSTANCE compute statistics;
analyze table BPM_INSTANCE_ATTRIBUTE compute statistics;