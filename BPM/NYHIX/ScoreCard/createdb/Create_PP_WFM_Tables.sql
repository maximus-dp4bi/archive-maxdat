show errors;

--============================================================================================
-- Create PP_WFM_OFFICE in DP_SCORECARD
--============================================================================================
declare  c int;
begin
   select count(*) into c from user_tables where table_name ='PP_WFM_OFFICE';
   if c = 1 then
      execute immediate 'drop table PP_WFM_OFFICE cascade constraints';
   end if;
end;
/

CREATE TABLE PP_WFM_OFFICE 
(
OFFICE_ID NUMBER(22,0) NOT NULL
,LOCALE_ID NUMBER(22,0)
,TIMEZONE_ID NUMBER(22,0) NOT NULL
,NAME VARCHAR2(50)
,DESCRIPTION VARCHAR2(250)
,DELETE_DATE DATE
,OWNER_USER NUMBER(22,0) NOT NULL
,MODIFY_USER NUMBER(22,0)
,OWNER_DATE DATE NOT NULL
,MODIFY_DATE DATE
,  CONSTRAINT pp_wfm_office_pk primary key
  (
    OFFICE_ID
  )
enable
)
tablespace MAXDAT_DATA;

grant select on PP_WFM_OFFICE to MAXDAT_READ_ONLY; 
grant select, insert, update, delete  on PP_WFM_OFFICE to MAXDAT; 

--execute MAXDAT_ADMIN.GATHER_TABLE_STATS('DP_SCORECARD','PP_WFM_OFFICE',4);

--create view PP_WFM_OFFICE_SV

CREATE OR REPLACE FORCE VIEW PP_WFM_OFFICE_SV
(OFFICE_ID
,LOCALE_ID
,TIMEZONE_ID
,NAME
,DESCRIPTION
,DELETE_DATE
,OWNER_USER
,MODIFY_USER
,OWNER_DATE
,MODIFY_DATE
) 
as
select 
OFFICE_ID
,LOCALE_ID
,TIMEZONE_ID
,NAME
,DESCRIPTION
,DELETE_DATE
,OWNER_USER
,MODIFY_USER
,OWNER_DATE
,MODIFY_DATE
from PP_WFM_OFFICE
WITH READ ONLY;

grant select on PP_WFM_OFFICE_SV to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on PP_WFM_OFFICE_SV to MAXDAT; 

--============================================================================================
-- Create PP_WFM_STAFF_TO_OFFICE in DP_SCORECARD
--============================================================================================
declare  c int;
begin
   select count(*) into c from user_tables where table_name ='PP_WFM_STAFF_TO_OFFICE';
   if c = 1 then
      execute immediate 'drop table PP_WFM_STAFF_TO_OFFICE cascade constraints';
   end if;
end;
/

CREATE TABLE PP_WFM_STAFF_TO_OFFICE 
(
EFFECTIVE_DATE	DATE NOT NULL
,STAFF_ID	NUMBER(22,0)	 NOT NULL
,OFFICE_ID	NUMBER(22,0)	 NOT NULL
,END_DATE	DATE
,DELETE_FLAG VARCHAR2(1)	
,  CONSTRAINT PP_WFM_STAFF_TO_OFFICE_pk primary key
  (
    EFFECTIVE_DATE
	,STAFF_ID
	,OFFICE_ID
  )
enable
)
tablespace MAXDAT_DATA;

grant select on PP_WFM_STAFF_TO_OFFICE to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on PP_WFM_STAFF_TO_OFFICE to MAXDAT; 

--execute MAXDAT_ADMIN.GATHER_TABLE_STATS('DP_SCORECARD','PP_WFM_STAFF_TO_OFFICE',4);

--create view PP_WFM_STAFF_TO_OFFICE_SV

CREATE OR REPLACE FORCE VIEW PP_WFM_STAFF_TO_OFFICE_SV
(EFFECTIVE_DATE
,STAFF_ID
,OFFICE_ID
,END_DATE
,DELETE_FLAG
) 
as
select 
EFFECTIVE_DATE
,STAFF_ID
,OFFICE_ID
,END_DATE
,DELETE_FLAG
from PP_WFM_STAFF_TO_OFFICE
WITH READ ONLY;

grant select on PP_WFM_STAFF_TO_OFFICE_SV to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on PP_WFM_STAFF_TO_OFFICE_SV to MAXDAT; 


--============================================================================================
-- Create PP_WFM_JOB_CLASSIFICATION in DP_SCORECARD
--============================================================================================
declare  c int;
begin
   select count(*) into c from user_tables where table_name ='PP_WFM_JOB_CLASSIFICATION';
   if c = 1 then
      execute immediate 'drop table PP_WFM_JOB_CLASSIFICATION cascade constraints';
   end if;
end;
/

CREATE TABLE PP_WFM_JOB_CLASSIFICATION 
(
STAFF_ID	NUMBER(22,0) NOT NULL
,START_DATE	DATE NOT NULL
,CATEGORY_OF_CLASSIFICATION_ID	NUMBER(22,0) NOT NULL
,JOB_CLASSIFICATION_CODE_ID	NUMBER(22,0) NOT NULL
,END_DATE	DATE
,DELETE_FLAG varchar2(1) Default 'N'
,  CONSTRAINT PP_WFM_JOB_CLASSIFICATION_pk primary key
  (
    STAFF_ID
	,START_DATE
	,CATEGORY_OF_CLASSIFICATION_ID
	,JOB_CLASSIFICATION_CODE_ID
  )
enable
)
tablespace MAXDAT_DATA;

grant select on PP_WFM_JOB_CLASSIFICATION to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on PP_WFM_JOB_CLASSIFICATION to MAXDAT; 

--execute MAXDAT_ADMIN.GATHER_TABLE_STATS('DP_SCORECARD','PP_WFM_JOB_CLASSIFICATION',4);

--create view PP_WFM_JOB_CLASSIFICATION_SV

CREATE OR REPLACE FORCE VIEW PP_WFM_JOB_CLASSIFICATION_SV
(STAFF_ID
,START_DATE
,CATEGORY_OF_CLASSIFICATION_ID
,JOB_CLASSIFICATION_CODE_ID
,END_DATE
,DELETE_FLAG
) 
as
select 
STAFF_ID
,START_DATE
,CATEGORY_OF_CLASSIFICATION_ID
,JOB_CLASSIFICATION_CODE_ID
,END_DATE
,DELETE_FLAG
from PP_WFM_JOB_CLASSIFICATION
WITH READ ONLY;

grant select on PP_WFM_JOB_CLASSIFICATION_SV to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on PP_WFM_JOB_CLASSIFICATION_SV to MAXDAT; 

--============================================================================================
-- Create PP_WFM_JOB_CLASSIFICATION_CODE in DP_SCORECARD
--============================================================================================
declare  c int;
begin
   select count(*) into c from user_tables where table_name ='PP_WFM_JOB_CLASSIFICATION_CODE';
   if c = 1 then
      execute immediate 'drop table PP_WFM_JOB_CLASSIFICATION_CODE cascade constraints';
   end if;
end;
/

CREATE TABLE PP_WFM_JOB_CLASSIFICATION_CODE 
(
JOB_CLASSIFICATION_CODE_ID	NUMBER(22,0) NOT NULL
,CODE	VARCHAR2(50) NOT NULL
,DESCRIPTION	VARCHAR2(250)
,OWNER_USER	NUMBER(22,0) NOT NULL
,MODIFY_USER	NUMBER(22,0)
,OWNER_DATE	DATE NOT NULL
,MODIFY_DATE	DATE
,DELETE_DATE	DATE
,  CONSTRAINT PP_WFM_JOB_CLASS_CODE_pk primary key
  (
    JOB_CLASSIFICATION_CODE_ID
	,CODE
  )
enable
)
tablespace MAXDAT_DATA;

grant select on PP_WFM_JOB_CLASSIFICATION_CODE to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on PP_WFM_JOB_CLASSIFICATION_CODE to MAXDAT; 

--execute MAXDAT_ADMIN.GATHER_TABLE_STATS('DP_SCORECARD','PP_WFM_JOB_CLASSIFICATION_CODE',4);

--create view PP_WFM_JOB_CLASSIFICATION_CODE_SV

CREATE OR REPLACE FORCE VIEW PP_WFM_JOB_CLASS_CODE_SV
(JOB_CLASSIFICATION_CODE_ID
,CODE
,DESCRIPTION
,OWNER_USER
,MODIFY_USER
,OWNER_DATE
,MODIFY_DATE
,DELETE_DATE
) 
as
select 
JOB_CLASSIFICATION_CODE_ID
,CODE
,DESCRIPTION
,OWNER_USER
,MODIFY_USER
,OWNER_DATE
,MODIFY_DATE
,DELETE_DATE
from PP_WFM_JOB_CLASSIFICATION_CODE
WITH READ ONLY;

grant select on PP_WFM_JOB_CLASS_CODE_SV to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on PP_WFM_JOB_CLASS_CODE_SV to MAXDAT; 

--============================================================================================
-- Create PP_WFM_STAFF_TO_DEPARTMENT in DP_SCORECARD
--============================================================================================
declare  c int;
begin
   select count(*) into c from user_tables where table_name ='PP_WFM_STAFF_TO_DEPARTMENT';
   if c = 1 then
      execute immediate 'drop table PP_WFM_STAFF_TO_DEPARTMENT cascade constraints';
   end if;
end;
/

CREATE TABLE PP_WFM_STAFF_TO_DEPARTMENT 
(
STAFF_ID	NUMBER(22,0) NOT NULL
,EFFECTIVE_DATE	DATE NOT NULL
,DEPARTMENT_ID	NUMBER(22,0) NOT NULL
,END_DATE	DATE
,  CONSTRAINT PP_WFM_STAFF_TO_DEPARTMENT_pk primary key
  (
    STAFF_ID
	,EFFECTIVE_DATE
	,DEPARTMENT_ID
  )
enable
)
tablespace MAXDAT_DATA;

grant select on PP_WFM_STAFF_TO_DEPARTMENT to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on PP_WFM_STAFF_TO_DEPARTMENT to MAXDAT; 

--execute MAXDAT_ADMIN.GATHER_TABLE_STATS('DP_SCORECARD','PP_WFM_STAFF_TO_DEPARTMENT',4);

--create view PP_WFM_STAFF_TO_DEPARTMENT_SV

CREATE OR REPLACE FORCE VIEW PP_WFM_STAFF_TO_DEPARTMENT_SV
(STAFF_ID
,EFFECTIVE_DATE
,DEPARTMENT_ID
,END_DATE
) 
as
select 
STAFF_ID
,EFFECTIVE_DATE
,DEPARTMENT_ID
,END_DATE
from PP_WFM_STAFF_TO_DEPARTMENT
WITH READ ONLY;

grant select on PP_WFM_STAFF_TO_DEPARTMENT_SV to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on PP_WFM_STAFF_TO_DEPARTMENT_SV to MAXDAT; 

--============================================================================================
-- Create PP_WFM_DEPARTMENT in DP_SCORECARD
--============================================================================================
declare  c int;
begin
   select count(*) into c from user_tables where table_name ='PP_WFM_DEPARTMENT';
   if c = 1 then
      execute immediate 'drop table PP_WFM_DEPARTMENT cascade constraints';
   end if;
end;
/

CREATE TABLE PP_WFM_DEPARTMENT 
(
DEPARTMENT_ID	NUMBER(22,0) NOT NULL
,ORGANIZATION_ID	NUMBER(22,0)
,NAME	VARCHAR2(50) NOT NULL
,DESCRIPTION	VARCHAR2(250)
,DELETE_DATE	DATE
,OWNER_USER	NUMBER(22,0) NOT NULL
,MODIFY_USER	NUMBER(22,0)
,OWNER_DATE	DATE NOT NULL
,MODIFY_DATE	DATE
,  CONSTRAINT PP_WFM_DEPARTMENT_pk primary key
  (
    DEPARTMENT_ID
  )
enable
)
tablespace MAXDAT_DATA;

grant select on PP_WFM_DEPARTMENT to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on PP_WFM_DEPARTMENT to MAXDAT; 

--execute MAXDAT_ADMIN.GATHER_TABLE_STATS('DP_SCORECARD','PP_WFM_DEPARTMENT',4);

--create view PP_WFM_DEPARTMENT_SV

CREATE OR REPLACE FORCE VIEW PP_WFM_DEPARTMENT_SV
(DEPARTMENT_ID
,ORGANIZATION_ID
,NAME
,DESCRIPTION
,DELETE_DATE
,OWNER_USER
,MODIFY_USER
,OWNER_DATE
,MODIFY_DATE
) 
as
select 
DEPARTMENT_ID
,ORGANIZATION_ID
,NAME
,DESCRIPTION
,DELETE_DATE
,OWNER_USER
,MODIFY_USER
,OWNER_DATE
,MODIFY_DATE
from PP_WFM_DEPARTMENT
WITH READ ONLY;

grant select on PP_WFM_DEPARTMENT_SV to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on PP_WFM_DEPARTMENT_SV to MAXDAT; 
