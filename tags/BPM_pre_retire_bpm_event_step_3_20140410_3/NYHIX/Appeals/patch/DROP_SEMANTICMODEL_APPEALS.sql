
--F_APPEALS_BY_DATE
--Drop references
alter table F_APPEALS_BY_DATE drop constraint FAPLBD_DAPPEALSCUR_FK;
alter table F_APPEALS_BY_DATE drop constraint FAPLBD_DAPLAC_FK;
alter table F_APPEALS_BY_DATE drop constraint FAPLBD_DAPLIA_FK;
alter table F_APPEALS_BY_DATE drop constraint FAPLBD_DAPLID_FK;
alter table F_APPEALS_BY_DATE drop constraint FAPLBD_DAPLIR_FK;
alter table F_APPEALS_BY_DATE drop constraint FAPLBD_DAPLIS_FK;
alter table F_APPEALS_BY_DATE drop constraint FAPLBD_DAPLIN_FK;
alter table F_APPEALS_BY_DATE drop constraint FAPLBD_DAPLCVPB_FK;

--Drop primary key
alter table F_APPEALS_BY_DATE drop primary key;

--Drop table & view
drop table F_APPEALS_BY_DATE;
drop view F_APPEALS_BY_DATE_SV;

--Drop sequence 
drop sequence SEQ_FAPLBD_ID;



--D_APPEALS_ACTION_COMMENTS


--Drop primary key
alter table D_APPEALS_ACTION_COMMENTS drop primary key;

--Drop table & view
drop table D_APPEALS_ACTION_COMMENTS;
drop view D_APPEALS_ACTION_COMMENTS_SV;

--Drop sequence 
drop sequence SEQ_DAPLAC_ID;

--D_APPEALS_INCIDENT_ABOUT 


--Drop primary key
alter table D_APPEALS_INCIDENT_ABOUT drop primary key;

--Drop table & view
drop table D_APPEALS_INCIDENT_ABOUT;
drop view D_APPEALS_INCIDENT_ABOUT_SV;

--Drop sequence 
drop sequence SEQ_DAPLIA_ID;

--D_APPEALS_INCIDENT_DESC


--Drop primary key
alter table D_APPEALS_INCIDENT_DESC drop primary key;

--Drop table & view
drop table D_APPEALS_INCIDENT_DESC;
drop view D_APPEALS_INCIDENT_DESC_SV;

--Drop sequence 
drop sequence SEQ_DAPLID_ID;

--D_APPEALS_INCIDENT_REASON


--Drop primary key
alter table D_APPEALS_INCIDENT_REASON drop primary key;

--Drop table & view
drop table D_APPEALS_INCIDENT_REASON;
drop view D_APPEALS_INCIDENT_REASON_SV;

--Drop sequence 
drop sequence SEQ_DAPLIR_ID;

--D_APPEALS_INCIDENT_STATUS


--Drop primary key
alter table D_APPEALS_INCIDENT_STATUS drop primary key;

--Drop table & view
drop table D_APPEALS_INCIDENT_STATUS;
drop view D_APPEALS_INCIDENT_STATUS_SV;

--Drop sequence 
drop sequence SEQ_DAPLIS_ID;


--D_APPEALS_INSTANCE_STATUS


--Drop primary key
alter table D_APPEALS_INSTANCE_STATUS drop primary key;

--Drop table & view
drop table D_APPEALS_INSTANCE_STATUS;
drop view D_APPEALS_INSTANCE_STATUS_SV;

--Drop sequence 
drop sequence SEQ_DAPLIN_ID;

--D_APPEALS_CVPB


--Drop primary key
alter table D_APPEALS_CVPB drop primary key;

--Drop table & view
drop table D_APPEALS_CVPB;
drop view D_APPEALS_CVPB_SV;

--Drop sequence 
drop sequence SEQ_DAPLCVPB_ID;


drop table D_APPEALS_CURRENT;
drop view D_APPEALS_CURRENT_SV;