create table D_SCI_CURRENT
  (
   SCI_BI_ID                      number,
   CONTACT_RECORD_ID 				      number not null,
	 CONTACT_TYPE					          varchar2(64), 
	 PARENT_RECORD_ID 				      number,
	 TRACKING_NUMBER 				        varchar2(32),
	 CREATED_BY_NAME					      varchar2(32), 
         CREATED_BY_UNIT					      varchar2(256),
         CREATED_BY_TEAM					      varchar2(256),
         CREATED_BY_ROLE					      varchar2(50),
	 CREATE_DATE						        date, 
	 COMPLETE_DATE					        date, 
	 CONTACT_START_TIME				      date, 
	 CONTACT_END_TIME				        date, 
	 HANDLE_TIME						        number, 
	 CONTACT_GROUP					        varchar2(256), 
	 LANGUAGE						            varchar2(256), 
	 TRANSLATION_REQUIRED			      varchar2(1), 
	 EXT_TELEPHONY_REF      				varchar2(32), -- 5/14 Replacing contact phone
	 PARTICIPANT_STATUS				      varchar2(15), 
	 NOTE_CATEGORY					        varchar2(32), 
	 NOTE_TYPE						          varchar2(32), 
	 NOTE_SOURCE						        varchar2(80), 
   NOTE_PRESENT                   varchar2(1),  -- 5/14 added
	 CONTACT_RECORD_FIELD_1			    varchar2(80), 
	 CONTACT_RECORD_FIELD_2			    varchar2(80), 
	 CONTACT_RECORD_FIELD_3			    varchar2(80), 
	 CONTACT_RECORD_FIELD_4	        varchar2(80), 
	 CONTACT_RECORD_FIELD_5			    varchar2(80),
	 HANDLE_CALL_WEBCHAT_START_DATE	date, 
	 HANDLE_CALL_WEBCHAT_END_DATE	  date, 
	 HANDLE_CALL_WEBCHAT_PERF_BY	  varchar2(100), 
	 CREATE_ROUTE_WORK_START_DATE	  date, 
	 CREATE_ROUTE_WORK_END_DATE	    date, 
	 INSTANCE_STATUS					      varchar2(10), 
	 CANCEL_DATE						        date, 
	 LAST_UPDATE_BY_NAME 			      varchar2(100), 
	 LAST_UPDATE_DATE 				      date,
	 HANDLE_CONTACT_FLAG 			      varchar2(1),
	 CREATE_ROUTE_WORK_FLAG 			  varchar2(100),
	 CANCEL_CONTACT_FLAG 			      varchar2(100),
	 WORK_IDENTIFIED_FLAG 			    varchar2(1),   -- 5/16 added
         CANCEL_METHOD                              varchar2(50), 
         CANCEL_REASON                              varchar2(256),
         CANCEL_BY                                  varchar2(50)
  );
  
alter table D_SCI_CURRENT add constraint DSCICUR_PK primary key (SCI_BI_ID);
alter index DSCICUR_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DSCICUR_UIX1 on D_SCI_CURRENT (CONTACT_RECORD_ID) online tablespace MAXDAT_INDX parallel compute statistics; 

