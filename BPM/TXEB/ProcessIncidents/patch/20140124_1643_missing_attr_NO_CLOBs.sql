/*
Created on 24-Jan-2014 by Raj A.
Description:
While working on the TX process Incidents changes realized these are missing in TX.
*/
alter table d_pi_current
add (
"COUNTY_CODE"    Varchar2(32),
"COUNTY_NAME"    Varchar2(64),
"ACTION_COMMENTS"  Varchar2(4000),
"INCIDENT_DESCRIPTION" Varchar2(4000),
"RESOLUTION_DESCRIPTION" Varchar2(4000)
);

alter table corp_etl_process_incidents
 modify (
 action_comments varchar2(4000)
 );
 
alter table PROCESS_INCIDENTS_OLTP
 modify (
 action_comments varchar2(4000)
 );

alter table PROCESS_INCIDENTS_WIP_BPM
 modify (
 action_comments varchar2(4000)
 ); 