 create table D_PERSON 
   (	PERSON_ID NUMBER , 
	FIRST_NAME VARCHAR2(50), 
	LAST_NAME VARCHAR2(50), 
	MIDDLE_NAME VARCHAR2(50), 
	NAME_TITLE VARCHAR2(50), 
	NAME_SUFFIX VARCHAR2(50)
   ) tablespace MAXDAT_DATA;

--Create primary & foreign keys 
alter table D_PERSON add primary key (PERSON_ID)
using index  tablespace MAXDAT_INDX;



