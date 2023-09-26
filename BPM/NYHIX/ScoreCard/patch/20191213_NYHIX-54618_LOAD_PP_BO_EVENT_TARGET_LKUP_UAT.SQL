 Alter session set current_schema=MAXDAT;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP
 set start_date='21-Dec-2019'
 where start_date='01-NOV-2019';   -------- 116 rows updated


 update MAXDAT.PP_BO_EVENT_TARGET_LKUP
 set end_date='20-Dec-2019'
 where end_date='31-OCT-2019' 
 AND EVENT_ID<>1486;  -------------165 ROWS Updated

UPDATE MAXDAT.PP_BO_EVENT_TARGET_LKUP
SET start_DATE='1-Jan-2020', CREATE_BY='CR 2441'
WHERE EVENT_ID IN ( 1109,1201,1284,1472,1473,1557,1585,1590,1591,1593,1594,1595,1597,1602,1604,1607,1609,1611,1612,1613,1614,1615,1616,
1618,1620,1621,1626,1627,1628,1629
	)
AND start_DATE ='21-Dec-2019'; ---- 30 rows 

UPDATE MAXDAT.PP_BO_EVENT_TARGET_LKUP
SET END_DATE='31-Dec-2019', CREATE_BY='CR 2441'
WHERE EVENT_ID IN ( 1109,1201,1284,1472,1473,1557,1585,1590,1591,1593,1594,1595,1597,1602,1604,1607,1609,1611,1612,1613,1614,1615,1616,
1618,1620,1621,1626,1627,1628,1629
	)
AND END_DATE ='20-Dec-2019';  ---- 30 rows 

delete from maxdat.PP_BO_EVENT_TARGET_LKUP where event_id in (
1641,
1642,
1643,
1644,
1645,
1646,
1647,
1648,
1649,
1650,
1651,
1652,
1653);

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1641,'Medicare Savings Applications - Mailroom',0,'N','21-DEC-2019','','CR 2441','','Medicare Savings Applications - Mailroom','N','Mailroom Clerk','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1642,'Link Document Set - LDS QC ',38,'Y','21-DEC-2019','','CR 2441','','Link Document Set - LDS QC ','N','QC Team','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1643,'Application Rejection - Research ',7.5,'Y','21-DEC-2019','','CR 2441','','Application Rejection - Research ','N','Research','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1644,'Appeal Prep - LDS QC ',0,'N','21-DEC-2019','','CR 2441','','Appeal Prep - LDS QC ','N','QC Team','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1645,'Appeal QC - LDS QC',11.25,'Y','21-DEC-2019','','CR 2441','','Appeal QC - LDS QC','N','QC Team','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1646,'Non-Sworn Cancellation - ARU Task',6,'Y','21-DEC-2019','','CR 2441','','Non-Sworn Cancellation - ARU Task','N','Account Review','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1647,'AOP - ARU Task',4,'Y','21-DEC-2019','','CR 2441','','AOP - ARU Task','N','Account Review','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1648,'Valid Appeal - ARU Task',12,'Y','21-DEC-2019','','CR 2441','','Valid Appeal - ARU Task','N','Account Review','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1649,'Expedited Denials - ARU Task',2,'Y','21-DEC-2019','','CR 2441','','Expedited Denials - ARU Task','N','Account Review','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1650,'NYSOH ARU Inbox - ARU Task',12,'Y','21-DEC-2019','','CR 2441','','NYSOH ARU Inbox - ARU Task','N','Account Review','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1651,'Expedite Spreadsheet - ARU Task',12,'Y','21-DEC-2019','','CR 2441','','Expedite Spreadsheet - ARU Task','N','Account Review','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1652,'DOH  Outbound - ARU Task',2,'Y','21-DEC-2019','','CR 2441','','DOH  Outbound - ARU Task','N','Account Review','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1653,'ATC Outreach - ARU Task',2,'Y','21-DEC-2019','','CR 2441','','ATC Outreach - ARU Task','N','Account Review','N','N','Y' );

commit;

update maxdat.PP_BO_EVENT_TARGET_LKUP
set end_date=null
where event_id in (1573,1575);  

commit;

update maxdat.PP_BO_EVENT_TARGET_LKUP
set scorecard_group='Returned Mail Prepping - Image Assembly'
where event_id=1605 and scorecard_group='Image Assembly Admin - Returned Mail Prepping';

update maxdat.PP_BO_EVENT_TARGET_LKUP  
set scorecard_group='Printing Rescans/Trashed Documents - Mailroom'
where event_id=1408
and (end_date='20-Dec-2019'  or start_date='21-Dec-2019');

update maxdat.PP_BO_EVENT_TARGET_LKUP  
set scorecard_group='Batch Scanning - Maillroom'
where event_id=1409
and (end_date='20-Dec-2019'  or start_date='21-Dec-2019');

update maxdat.PP_BO_EVENT_TARGET_LKUP  
set scorecard_group='Logging Tasks - Mailroom'
where event_id=1411
and (end_date='20-Dec-2019'  or start_date='21-Dec-2019');

update maxdat.PP_BO_EVENT_TARGET_LKUP  
set scorecard_group='Purge Review - Mailroom'
where event_id=1414
and (end_date='20-Dec-2019'  or start_date='21-Dec-2019');

update maxdat.PP_BO_EVENT_TARGET_LKUP  
set scorecard_group='Storage Room Reconciliation - Mailroom'
where event_id=1415
and (end_date='20-Dec-2019'  or start_date='21-Dec-2019');


update maxdat.PP_BO_EVENT_TARGET_LKUP  
set scorecard_group='Returned Mail Prepped - Mailroom'
where event_id=1454
and (end_date='20-Dec-2019'  or start_date='21-Dec-2019');


update maxdat.PP_BO_EVENT_TARGET_LKUP  
set scorecard_group='Account Correction - VDOCS'
where event_id=1457
and (end_date='20-Dec-2019'  or start_date='21-Dec-2019');

update maxdat.PP_BO_EVENT_TARGET_LKUP  
set scorecard_group='Folding Tasks - Mailroom'
where event_id=1472
and (end_date='31-Dec-2019'  or start_date='1-Jan-2020');

update maxdat.PP_BO_EVENT_TARGET_LKUP  
set scorecard_group='Printing Returned Mail - Mailroom'
where event_id=1473
and (end_date='31-Dec-2019'  or start_date='1-Jan-2020');

update maxdat.PP_BO_EVENT_TARGET_LKUP  
set scorecard_group='Sorting/Cutting Incoming Mail - Mailroom'
where event_id=1485
and (end_date='20-Dec-2019'  or start_date='21-Dec-2019');

update maxdat.PP_BO_EVENT_TARGET_LKUP  
set scorecard_group='Making Copies - Mailroom'
where event_id=1486
and (end_date='20-Dec-2019'  or start_date='21-Dec-2019');

update maxdat.PP_BO_EVENT_TARGET_LKUP  
set scorecard_group='Language Translation - VDOCS'
where event_id=1507
and (end_date='20-Dec-2019'  or start_date='21-Dec-2019');

update maxdat.PP_BO_EVENT_TARGET_LKUP  
set scorecard_group='Storage Room Sort/Re-File/Purge Destruction - Mailroom'
where event_id=1512
and (end_date='20-Dec-2019'  or start_date='21-Dec-2019');

update maxdat.PP_BO_EVENT_TARGET_LKUP  
set scorecard_group='BaSS Scan - Mailroom'
where event_id=1525
and (end_date='20-Dec-2019'  or start_date='21-Dec-2019');

COMMIT;


