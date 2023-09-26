-- Create  Common tables for run initialization 

create table MAXDAT.D_STAFF
  (STAFF_ID               int not null,
   EXT_STAFF_NUMBER       varchar(80),
   DOB                    date,
   SSN                    varchar(30),
   FIRST_NAME             varchar(50),
   FIRST_NAME_CANON       varchar(50),
   FIRST_NAME_SOUND_LIKE  varchar(64),
   GENDER_CD              varchar(32),
   START_DATE             date,
   END_DATE               date,
   PHONE_NUMBER           varchar(20),
   LAST_NAME              varchar(50),
   LAST_NAME_CANON        varchar(50),
   LAST_NAME_SOUND_LIKE   varchar(64),
   CREATED_BY             varchar(80),
   CREATE_TS              datetime,
   UPDATED_BY             varchar(80),
   UPDATE_TS              datetime,
   MIDDLE_NAME            varchar(25),
   MIDDLE_NAME_CANON      varchar(20),
   MIDDLE_NAME_SOUND_LIKE varchar(64),
   EMAIL                  varchar(80),
   FAX_NUMBER             varchar(32),
   NOTE_REFID             int,
   DEPLOYMENT_STAFF_NUM   varchar(80),
   DEFAULT_GROUP_ID       int,
   STAFF_TYPE_CD          varchar(20),
   UNIQUE_STAFF_ID        varchar(80),
   VOID_IND               int default 0);
  
alter table MAXDAT.D_STAFF add constraint D_STAFF_PK primary key (STAFF_ID);
go

grant select on MAXDAT.D_STAFF to MAXDAT_READ_ONLY;
go
  
