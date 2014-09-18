create table CORP_ETL_CONTROL
  (NAME        varchar2(50) not null,
   VALUE_TYPE  varchar2(1) not null,
   VALUE       varchar2(100) not null,
   DESCRIPTION varchar2(400),
   CREATED_TS  date not null,
   UPDATED_TS  date not null);

     
comment on column  CORP_ETL_CONTROL.NAME is 'Named Variable which will have a value stored';
comment on column  CORP_ETL_CONTROL.VALUE_TYPE is 'Type of the named variable';
comment on column  CORP_ETL_CONTROL.VALUE is 'Holds the value for the named variable identifier - secondary lookup value';
comment on column  CORP_ETL_CONTROL.DESCRIPTION is 'Description of named variable';
comment on column  CORP_ETL_CONTROL.CREATED_TS is 'Date variable created';
comment on column  CORP_ETL_CONTROL.UPDATED_TS is 'Date Variable updated';

alter table CORP_ETL_CONTROL add constraint CECTL_PK primary key (NAME);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.9','001','001_ADD_CORP_ETL_CONTROL');

COMMIT;