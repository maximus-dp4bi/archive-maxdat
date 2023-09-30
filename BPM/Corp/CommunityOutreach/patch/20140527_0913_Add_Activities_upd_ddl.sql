Alter table CORP_ETL_COMMUNITY_ACTIVITIES add 
(
DELETED_FROM_SOURCE VARCHAR2(1 BYTE) DEFAULT 'N'
);


--DROP TABLE CORP_ETL_COMMUNITY_ACT_OLTP 
CREATE TABLE CORP_ETL_COMMUNITY_ACT_OLTP 
(
COMMUNITY_ACTIVITY_ID NUMBER
,STAFF_NAME VARCHAR2(60 BYTE)
,ACTIVITY_DATE DATE
,LOCATION_NAME VARCHAR2(100 BYTE)
,ACTIVITY_ADDRESS VARCHAR2(55 BYTE)
,NBR_KITS_PROVIDED NUMBER
,NBR_RECIPIENT_ATTENDEES NUMBER
,OUTCOME VARCHAR2(1000 BYTE)
,NBR_STAFF_ATTENDEES NUMBER
,CREATED_BY VARCHAR2(60 BYTE)
,CREATE_DT DATE
,UPDATED_BY VARCHAR2(60 BYTE)
,UPDATE_DT DATE
,ACTIVITY_CITY VARCHAR2(30 BYTE)
,ACTIVITY_STATE VARCHAR2(2 BYTE)
,ACTIVITY_ZIP VARCHAR2(15 BYTE)
,CONTACT_TYPE VARCHAR2(32 BYTE)
,LNG_VALUE VARCHAR2(32 BYTE)
,OBS_VALUE VARCHAR2(100 BYTE)
,END_DATE DATE
,NBR_OF_ENROLLMENTS NUMBER
,OUTREACH_SESSION_ID NUMBER
,ACTIVITY_COUNTY varchar2(60)
,ACTIVITY_REGION varchar2(60)
,ACTIVITY_SERVICE_AREA varchar2(60)
,DELETED_FROM_SOURCE VARCHAR2(1 BYTE) DEFAULT 'N'
,CONSTRAINT CORP_ETL_COMM_ACT_OLTP_PK PRIMARY KEY(COMMUNITY_ACTIVITY_ID)
)  TABLESPACE MAXDAT_DATA;

--DROP TABLE CORP_ETL_COMMUNITY_ACT_WIP
CREATE TABLE CORP_ETL_COMMUNITY_ACT_WIP 
(
COMMUNITY_ACTIVITY_ID NUMBER
,STAFF_NAME VARCHAR2(60 BYTE)
,ACTIVITY_DATE DATE
,LOCATION_NAME VARCHAR2(100 BYTE)
,ACTIVITY_ADDRESS VARCHAR2(55 BYTE)
,NBR_KITS_PROVIDED NUMBER
,NBR_RECIPIENT_ATTENDEES NUMBER
,OUTCOME VARCHAR2(1000 BYTE)
,NBR_STAFF_ATTENDEES NUMBER
,CREATED_BY VARCHAR2(60 BYTE)
,CREATE_DT DATE
,UPDATED_BY VARCHAR2(60 BYTE)
,UPDATE_DT DATE
,ACTIVITY_CITY VARCHAR2(30 BYTE)
,ACTIVITY_STATE VARCHAR2(2 BYTE)
,ACTIVITY_ZIP VARCHAR2(15 BYTE)
,CONTACT_TYPE VARCHAR2(32 BYTE)
,LNG_VALUE VARCHAR2(32 BYTE)
,OBS_VALUE VARCHAR2(100 BYTE)
,END_DATE DATE
,NBR_OF_ENROLLMENTS NUMBER
,OUTREACH_SESSION_ID NUMBER
,ACTIVITY_COUNTY varchar2(60)
,ACTIVITY_REGION varchar2(60)
,ACTIVITY_SERVICE_AREA varchar2(60)
,DELETED_FROM_SOURCE VARCHAR2(1 BYTE) DEFAULT 'N'
,UPDATED VARCHAR2(1)
,CONSTRAINT CORP_ETL_COMMUNITY_ACT_WIP_PK PRIMARY KEY(COMMUNITY_ACTIVITY_ID)
)  TABLESPACE MAXDAT_DATA;





Alter table CORP_ETL_COMM_ACTY_DETAIL_CHLD add 
(
DELETED_FROM_SOURCE VARCHAR2(1 BYTE) DEFAULT 'N'
);

--DROP TABLE COMMUNITY_ACTVTY_DET_CHLD_OLTP;
CREATE TABLE COMMUNITY_ACTVTY_DET_CHLD_OLTP 
(
acty_det_rec_id NUMBER
,acty_det_rec_type VARCHAR2(60 BYTE)
,acty_det_rec_value VARCHAR2(100 BYTE)
,acty_det_rec_create_dt DATE
,acty_det_rec_create_by VARCHAR2(60 BYTE)
,acty_det_rec_update_dt DATE
,acty_det_rec_update_by VARCHAR2(60 BYTE)
,community_activity_id NUMBER
,outreach_session_id NUMBER
,DELETED_FROM_SOURCE VARCHAR2(1 BYTE) DEFAULT 'N'
,CONSTRAINT COMM_ACT_DCHLD_OLTP_PK PRIMARY KEY(acty_det_rec_id,acty_det_rec_type)
) TABLESPACE MAXDAT_DATA;

--DROP TABLE COMMUNITY_ACTVTY_DET_CHLD_WIP;
CREATE TABLE COMMUNITY_ACTVTY_DET_CHLD_WIP 
(
acty_det_rec_id NUMBER
,acty_det_rec_type VARCHAR2(60 BYTE)
,acty_det_rec_value VARCHAR2(100 BYTE)
,acty_det_rec_create_dt DATE
,acty_det_rec_create_by VARCHAR2(60 BYTE)
,acty_det_rec_update_dt DATE
,acty_det_rec_update_by VARCHAR2(60 BYTE)
,community_activity_id NUMBER
,outreach_session_id NUMBER
,DELETED_FROM_SOURCE VARCHAR2(1 BYTE) DEFAULT 'N'
,CONSTRAINT COMM_ACT_DCHLD_WIP_PK PRIMARY KEY(acty_det_rec_id,acty_det_rec_type)
,UPDATED VARCHAR2(1)
) TABLESPACE MAXDAT_DATA;




create or replace view D_CMOR_ACTIVITIES_SV as
select * from CORP_ETL_COMMUNITY_ACTIVITIES
with read only;


create or replace view D_CMOR_ACTIVITIES_DETAILS_SV as
select * from CORP_ETL_COMM_ACTY_DETAIL_CHLD
with read only;
