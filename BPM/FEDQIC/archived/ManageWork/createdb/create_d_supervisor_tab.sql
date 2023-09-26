create table  D_SUPERVISOR
   (PERSON_ID NUMBER, 
	EMPLOYEE_ID NUMBER, 
	SUPERVISOR_PERSON_ID NUMBER, 
	LAST_UPDATE_TS DATE, 
	CREATE_TS DATE
   )
  tablespace MAXDAT_DATA ;


--Create primary key, foreign key
alter table D_SUPERVISOR add primary key (PERSON_ID) 
using index tablespace MAXDAT_INDX;

alter table D_SUPERVISOR add constraint SUPERVISOR_PERSON_FK foreign key (SUPERVISOR_PERSON_ID ) references D_PERSON(PERSON_ID);
