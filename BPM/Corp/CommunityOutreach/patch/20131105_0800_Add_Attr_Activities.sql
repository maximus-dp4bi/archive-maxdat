truncate table COMMUNITY_ACTIVITIES;

ALTER TABLE COMMUNITY_ACTIVITIES
  ADD (ACTIVITY_COUNTY varchar2(60),
       ACTIVITY_REGION varchar2(60),
       ACTIVITY_SERVICE_AREA varchar2(60) );

create or replace view D_CMOR_ACTIVITIES_SV as
select * from COMMUNITY_ACTIVITIES
with read only;