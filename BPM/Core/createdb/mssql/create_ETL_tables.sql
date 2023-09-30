create table MAXDAT.CORP_ETL_LIST_LKUP
  (CELL_ID    int not null,
   NAME       varchar(30) not null,
   LIST_TYPE  varchar(30) not null,
   VALUE      varchar(100) not null,
   OUT_VAR    varchar(500),
   REF_TYPE   varchar(100),
   REF_ID     int,
   START_DATE datetime,
   END_DATE   datetime,
   COMMENTS   varchar(MAX),
   CREATED_TS datetime not null,
   UPDATED_TS datetime not null);

/*
comment on table CORP_ETL_LIST_LKUP is 'Used to create list of values to used when pulling data for savvion';
comment on column CORP_ETL_LIST_LKUP.NAME is 'LIST(lookup rule name for list of values)/IFTHEN(IF VALUE THEN OUT_VAR)/ID(REFERENCE AND ID)';
comment on column CORP_ETL_LIST_LKUP.VALUE is 'Either a list or reference value - Secondary lookup value';
comment on column CORP_ETL_LIST_LKUP.OUT_VAR is 'Value to be extracted from table';
comment on column CORP_ETL_LIST_LKUP.REF_TYPE is 'Table name if ref id is prim key';
comment on column CORP_ETL_LIST_LKUP.REF_ID is 'Prim key when ref_type has table name';
comment on column CORP_ETL_LIST_LKUP.START_DATE is 'used to turn on value';
comment on column CORP_ETL_LIST_LKUP.END_DATE is 'Used to turn off value';
*/

alter table MAXDAT.CORP_ETL_LIST_LKUP add constraint CORP_ETL_LIST_LKUP_PK primary key (CELL_ID);
alter table MAXDAT.CORP_ETL_LIST_LKUP add constraint CORP_ETL_LIST_LKUP_UK unique (NAME,LIST_TYPE,VALUE);

grant select on MAXDAT.CORP_ETL_LIST_LKUP to MAXDAT_READ_ONLY;
go

create table MAXDAT.HOLIDAYS
  (HOLIDAY_ID   int not null default next value for MAXDAT.SEQ_HOLIDAY_ID,
   HOLIDAY_YEAR int,
   HOLIDAY_DATE datetime,
   DESCRIPTION  varchar(128),
   CREATED_BY   varchar(80),
   CREATE_TS    datetime,
   UPDATED_BY   varchar(80),
   UPDATE_TS    datetime);

alter table MAXDAT.HOLIDAYS add constraint HOLIDAYS_PK primary key (HOLIDAY_ID);
alter table MAXDAT.HOLIDAYS add constraint HOLIDAYS_UK1 unique (HOLIDAY_YEAR,HOLIDAY_DATE);

grant select on MAXDAT.HOLIDAYS to MAXDAT_READ_ONLY;
go