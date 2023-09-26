alter session set current_schema=MAXDAT;




UPDATE MAXDAT.PP_BO_EVENT_TARGET_LKUP
SET END_DATE='20-Dec-2019', CREATE_BY='CR 2441'
WHERE EVENT_ID IN ( 1068,1099,1101,1102,1104,1105,1107,1110,1111,1120,1131,1132,1133,1134,1143,
1147,1156,1159,1160,1169,1171,1172,1173,1174,1175,1177,1178,1179,1180,1182,1198,1204,1205,
1230,1239,1282,1283,1286,1287,1289,1290,1294,1299,1300,1301,1302,1317,1345,1346,
1347,1348,1349,1350,1351,1352,1353,1354,1355,1356,1403,1404,1405,1406,1408,1409,1411,1414,1415,1422,
1424,1426,1428,1429,1430,1436,1442,1443,1444,1445,1446,1447,1448,1454,1456,1457,1458,1459,1460,1461,1462,
1463,1464,1465,1466,1467,1483	,1484	,1485	,1486	,1488	,1507	,1510	,
1512	,1513	,1525	,1554	,1556	,1559		,1586	,1587			,
1592				,1596		,1599	,1600	,1601			,1605		,1608	,
1610	,1617	,1619		,1622	,
1623	,1624	,1625					,1630	,1631	,1632	,1633	,1634	,1635	,1636	,1637	,1638	)
AND END_DATE IS NULL;

commit;

UPDATE MAXDAT.PP_BO_EVENT_TARGET_LKUP
SET END_DATE='31-Dec-2019', CREATE_BY='CR 2441'
WHERE EVENT_ID IN ( 1109,1201,1284,1425, 1472,1473,1552, 1553,1557,1585,1590,1591,1593,1594,1595,1597,1602,1604,1607,1609,1611,1612,1613,1614,1615,1616,
1618,1620,1621,1626,1627,1628,1629
	)
AND END_DATE IS NULL;

commit;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Verification Document - VDOCS'  where event_id= 1104   and END_DATE='20-Dec-2019' ;


update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Application in Process -Research'  where event_id= 1105   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Wrong Program - Research'  where event_id= 1109   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Link Doc Set QC - App - LDS QC'  where event_id= 1156   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Authorized Rep - Research'  where event_id= 1172   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Manual Notice QC Task - LDS QC'  where event_id= 1174   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Manual Notice QC - Research'  where event_id= 1284   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Link Document Set QC - VDOC -LDS QC'  where event_id= 1299   and END_DATE='20-Dec-2019' ;

commit;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Retro Verification Document - VDOCS'  where event_id= 1317   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Immigration Docs (DER) - Research'  where event_id= 1345   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='FPBP Kofax QC - FPBP Doc Management '  where event_id= 1350   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='FPBP Kofax VAL  - FPBP Doc Management '  where event_id= 1352   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='FPBP HSDE QC - FPBP Doc Management '  where event_id= 1354   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='FPBP Proximal Linking - FPBP Doc Management '  where event_id= 1355   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Printing K Drive Appeal Letters - Mailroom'  where event_id= 1405   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Printing K Drive Appeal Evidence Packets - Mailroom '  where event_id= 1406   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Printing Rescans/Trashed Documents - Mailroom'  where event_id= 1408   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Batch Scanning - Maillroom'  where event_id= 1409   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Logging Tasks - Mailroom'  where event_id= 1411   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Purge Review - Mailroom'  where event_id= 1414   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Storage Room Reconciliation - Mailroom'  where event_id= 1415   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Schedule Hearing Task - ARU Task'  where event_id= 1425   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Dismissal Failed to Attend Hearing - ARU Task'  where event_id= 1442   and END_DATE='20-Dec-2019' ;

commit;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Returned Mail Prepped - Mailroom'  where event_id= 1454   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Account Correction - VDOCS'  where event_id= 1457   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Folding Tasks - Mailroom', OPS_GROUP='Mailroom'   where event_id= 1472   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Printing Returned Mail - Mailroom', OPS_GROUP='Mailroom'   where event_id= 1473   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Sorting/Cutting Incoming Mail - Mailroom', OPS_GROUP='Mailroom'   where event_id= 1485   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Making Copies - Mailroom', OPS_GROUP='Mailroom'   where event_id= 1486   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Language Translation - VDOCS', OPS_GROUP='Verification Document'   where event_id= 1507   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Storage Room Sort/Re-File/Purge Destruction - Mailroom'  where event_id= 1512   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='BaSS Scan - Mailroom'  where event_id= 1525   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='FPBP Scanning - FPBP Doc Management'  where event_id= 1552   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='FPBP Mail Sort - FPBP Doc Management'  where event_id= 1553   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='FPBP Mail Prep - FPBP Doc Management'  where event_id= 1554   and END_DATE='20-Dec-2019' ;

UPDATE MAXDAT.PP_BO_EVENT_TARGET_LKUP
SET END_DATE='31-Dec-2019'
where target=75
and EVENT_ID=1557;

update maxdat.PP_BO_EVENT_TARGET_LKUP
set end_date=null
where event_id in (1573,1575);  

commit;

update maxdat.PP_BO_EVENT_TARGET_LKUP set EE_ADHERENCE_V2='Y'  where EVENT_ID=1573 AND END_DATE IS NULL;

update maxdat.PP_BO_EVENT_TARGET_LKUP set EE_ADHERENCE_V2='Y'  where EVENT_ID=1575 AND END_DATE IS NULL;




update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Kofax Application - Image Assembly'  where event_id= 1590   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Kofax Nav/CAC Batches - Image Assembly'  where event_id= 1591   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='MAXe Application - Image Assembly'  where event_id= 1592   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='MAXe Non-Application - Image Assembly'  where event_id= 1593   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Kofax Non-Application - Image Assembly'  where event_id= 1594   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='KOFAX Fax QC - Image Assembly'  where event_id= 1595   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Link Document Set - Image Assembly'  where event_id= 1597   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Printing Returned Mail - Image Assembly'  where event_id= 1599   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Purge Review - Image Assembly'  where event_id= 1600   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Kofax Rescan - Image Assembly'  where event_id= 1602   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Kofax Returned Mail Data Entry - Image Assembly'  where event_id= 1604   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Kofax Non-Application 25+ - Image Assembly'  where event_id= 1607   and END_DATE='31-Dec-2019' ;

COMMIT;


update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Appeal Open - ARU Task'  where event_id= 1609   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Appeal Outreach Project - ARU Task'  where event_id= 1610   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Awaiting Validity Amendment - ARU Task'  where event_id= 1611   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Data Entry Research - Existing Appeal - ARU Task'  where event_id= 1612   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Invalid Right To Cure - ARU Task'  where event_id= 1613   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Non-Sworn AOP Cancellation - ARU Task'  where event_id= 1614   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Notice of Dismissal - ARU Task'  where event_id= 1615   and END_DATE='31-Dec-2019' ;

COMMIT;


update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Pending Withdrawal / Cancellation - ARU Task '  where event_id= 1616   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Return - Action Requried - ARU Task'  where event_id= 1618   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Spreadsheet Processing - ARU Task'  where event_id= 1620   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Written Withdrawal - ARU Task'  where event_id= 1621   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Appeal Evidence Packets Prepped - Mailroom' , OPS_GROUP='Mailroom'  where event_id= 1624   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Appeal Letters Prepped - Mailroom'  where event_id= 1625   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Applications Prepped - Mailroom'  where event_id= 1626   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='BaSS Prepped - Mailroom'  where event_id= 1627   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Rescans/Trashed Documents Prepped - Mailroom'  where event_id= 1628   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Non-Applications and Consumer Appeals Prepped - Mailroom'  where event_id= 1629   and END_DATE='31-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Needs Verification - Research'  where event_id= 1630   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Relink - Research'  where event_id= 1632   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Defect - VDOCS'  where event_id= 1634   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='DOH Tasks - VDOCS'  where event_id= 1635   and END_DATE='20-Dec-2019' ;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP set 
SCORECARD_GROUP='Verification Document - Research'  where event_id= 1638   and END_DATE='20-Dec-2019' ;

 

COMMIT;


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1068,'Special Project',0,'N','21-DEC-2019','','CR 2441','17-JUL-2018','NON-PRODUCTIVE','N','NOT IN SCORECARD','N','N','N' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1104,'Verification Document - VDOCS',8.5,'Y','21-DEC-2019','','CR 2441','','Verification Document - VDOCS','N','Verification Document','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1105,'Application in Process -Research',9,'Y','21-DEC-2019','','CR 2441','','Application in Process -Research','N','Research','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1109,'Wrong Program - Research',8,'Y','1-Jan-2020','','CR 2441','','Wrong Program - Research','N','Research','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1111,'DPR Other - Research',20,'Y','21-DEC-2019','','CR 2441','','Other Research','N','Research','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1120,'Problem Case',0,'N','21-DEC-2019','','CR 2441','','NON-PRODUCTIVE','N','NOT IN SCORECARD','N','N','N' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1131,'Document Problem Resolution - Research',20,'Y','21-DEC-2019','','script','','Other Research','N','Research','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1132,'Doc/Form Type Mismatch Task - Research',20,'Y','21-DEC-2019','','CR 2441','','Other Research','N','Research','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1133,'Financial Management - Research',20,'Y','21-DEC-2019','','CR 2441','','Other Research','N','Research','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1134,'Data Matching Issues - Research',20,'Y','21-DEC-2019','','CR 2441','','Data Matching Issues','N','Research Admin','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1156,'Link Doc Set QC - App - LDS QC',27,'Y','21-DEC-2019','','CR 2441','','Link Doc Set QC - App - LDS QC','N','QC','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1159,'Orphan Document - Research',21,'Y','21-DEC-2019','','CR 2441','','Orphan Document','N','Research','N','N','Y' );


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1172,'Authorized Rep - Research',10,'Y','21-DEC-2019','','CR 2441','','Authorized Rep - Research','N','Research','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1173,'Reschedule Hearing - ARU Task',6,'Y','21-DEC-2019','','CR 2441','','Reschedule Hearing','N','Account Review','N','N','Y' );

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1174,'Manual Notice QC Task - LDS QC',62,'N','21-DEC-2019','','CR 2441','','Manual Notice QC Task - LDS QC','Y','Quality Control Admin','Y','N','Y' );

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1201,'Research - Appeals',17,'Y','1-Jan-2020','','CR 2441','','Research - Appeals','N','Research Admin','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1230,'Incarceration Proof',20,'Y','21-DEC-2019','','CR 2441','','Other Research','N','Research','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1282,'ID Proof - Task - Research',27,'Y','21-DEC-2019','','CR 2441','','ID Proof - Task','N','Research','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1283,'ID Proof - Calls - Research',12,'Y','21-DEC-2019','','CR 2441','','ID Proof - Calls','N','Research','N','N','Y' );


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1284,'Manual Notice QC - Research',24,'Y','1-Jan-2020','','CR 2441','','Manual Notice QC - Research','N','Research Admin','N','N','Y' );

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1289,'DER Other - Research',20,'Y','21-DEC-2019','','CR 2441','','Other Research','N','Research','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1290,'Application - Missing Data - Research',6,'Y','21-DEC-2019','','CR 2441','','Application - Missing Data','N','Research','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1294,'Letter Resend',20,'Y','21-DEC-2019','','CR 2441','','Other Research','N','Research','N','N','Y' );


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1299,'Link Document Set QC - VDOC -LDS QC',36,'Y','21-DEC-2019','','CR 2441','','Link Document Set QC - VDOC -LDS QC','N','QC','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1317,'Retro Verification Document - VDOCS',9,'Y','21-DEC-2019','','CR 2441','','Retro Verification Document - VDOCS','N','Verification Documents Ad','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1345,'Immigration Docs (DER) - Research',12,'Y','21-DEC-2019','','CR 2441','','Immigration Docs (DER) - Research','N','Research','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1350,'FPBP Kofax QC - FPBP Doc Management',29,'Y','21-DEC-2019','','CR 2441','','FPBP Kofax QC - FPBP Doc Management ','N','FPBP - Imaging Admin','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1352,'FPBP Kofax VAL - FPBP Doc Management',15,'Y','21-DEC-2019','','CR 2441','','FPBP Kofax VAL  - FPBP Doc Management ','N','FPBP - Imaging Admin','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1354,'FPBP HSDE QC - FPBP Doc Management ',170,'Y','21-DEC-2019','','CR 2441','','FPBP HSDE QC - FPBP Doc Management ','N','FPBP  - Imaging Admin','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1355,'FPBP Proximal Linking - FPBP Doc Management',57,'Y','21-DEC-2019','','CR 2441','','FPBP Proximal Linking - FPBP Doc Management ','N','FPBP - Imaging Admin','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1405,'Printing K Drive Appeal Letters - Mailroom',70,'Y','21-DEC-2019','','CR 2441','','Printing K Drive Appeal Letters - Mailroom','N','Mailroom','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1406,'Printing K Drive Appeal Evidence Packets - Mailroom ',10,'Y','21-DEC-2019','','CR 2441','','Printing K Drive Appeal Evidence Packets - Mailroom ','N','Mailroom','Y','N','Y' );

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1408,'Printing Rescans/Trashed Documents - Mailroom',100,'Y','21-DEC-2019','','CR 2441','','Printing Rescans/Trashed Documents - Mailroom','N','Mailroom Clerk','Y','N','Y' );

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1409,'Batch Scanning - Maillroom',19,'Y','21-DEC-2019','','CR 2441','','Batch Scanning - Maillroom','N','Mailroom','N','N','Y' );


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1411,'Logging Tasks - Mailroom',30,'Y','21-DEC-2019','','CR 2441','','Logging Tasks - Mailroom','N','Mailroom Clerk','Y','N','Y' );


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1414,'Purge Review - Mailroom',65,'Y','21-DEC-2019','','CR 2441','','Purge Review - Mailroom','N','Mailroom Clerk','N','N','Y' );


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1415,'Storage Room Reconciliation - Mailroom',100,'Y','21-DEC-2019','','CR 2441','','Storage Room Reconciliation - Mailroom','N','Mailroom','Y','N','Y' );

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1422,'Team Lead - Desk Time',0,'N','21-DEC-2019','','CR 2441','','UNUSED_BY_EE','N','NOT IN SCORECARD','N','N','Y' );


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1425,'Schedule Hearing Task - ARU Task',1.5,'Y','1-JAN-2020','','CR 2441','','Schedule Hearing Task - ARU Task','N','Account Review','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1442,'Dismissal Failed to Attend Hearing - ARU Task',6,'Y','21-DEC-2019','','CR 2441','','Dismissal Failed to Attend Hearing - ARU Task','N','Account Review','N','N','Y' );

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1443,'Document Account Review - ARU Task',8,'Y','21-DEC-2019','','CR 2441','','Document Account Review','N','Account Review','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1445,'Expired Clock Document - ARU Task',4,'Y','21-DEC-2019','','CR 2441','','Expired Clock Document','N','Account Review','N','N','Y' );


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1454,'Returned Mail Prepped - Mailroom',65,'Y','21-DEC-2019','','CR 2441','','Returned Mail Prepped - Mailroom','N','Mailroom Clerk','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1457,'Account Correction - VDOCS',0,'N','21-DEC-2019','','CR 2441','','Account Correction - VDOCS','N','Verification Document','N','N','Y' );

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1458,'Complaint (DPR) - Research',20,'Y','21-DEC-2019','','CR 2441','','Other Research','N','Research','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1460,'Refer To Account Review QC -  ARU Task',30,'Y','21-DEC-2019','','CR 2441','','Refer to Account Review QC','N','Account Review Admin - Ta','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1463,'VLP - Research',12,'Y','21-DEC-2019','','CR 2441','','VLP','N','Research','N','N','Y' );



insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1472,'Folding Tasks - Mailroom',126,'Y','1-Jan-2020','','CR 2441','','Folding Tasks - Mailroom','N','Mailroom','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1473,'Printing Returned Mail - Mailroom',300,'Y','1-Jan-2020','','CR 2441','','Printing Returned Mail - Mailroom','N','Mailroom','Y','N','Y' );

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1483,'DSRIP Opt Out Survey - Mailroom',65,'Y','21-DEC-2019','','CR 2441','','DSRIP Opt Out Survey','N','Mailroom','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1484,'DSRIP Incident - Mailroom',35,'Y','21-DEC-2019','','CR 2441','','DSRIP Incident','N','Mailroom','Y','N','Y' );


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1485,'Sorting/Cutting Incoming Mail - Mailroom',1000,'Y','21-DEC-2019','','CR 2441','','Sorting/Cutting Incoming Mail - Mailroom','N','Mailroom','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1486,'Making Copies - Mailroom',120,'Y','21-DEC-2019','','CR 2441','','Making Copies - Mailroom','N','Mailroom','Y','N','Y' );

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1488,'Posting Mail - Mailroom',1000,'Y','21-DEC-2019','','CR 2441','','Posting Mail','N','Mailroom','Y','N','Y' );


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1507,'Language Translation - VDOCS',8,'Y','21-DEC-2019','','CR 2441','','Language Translation - VDOCS','N','Verification Document','N','N','Y' );

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1510,'Printing 1095 Tax Documents - Mailroom',70,'Y','21-DEC-2019','','CR 2441','','Printing 1095 Tax Documents','N','Mailroom','Y','N','Y' );


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1512,'Storage Room Sort/Re-File/Purge Destruction - Mailroom',0,'N','21-DEC-2019','','CR 2441','','Storage Room Sort/Re-File/Purge Destruction - Mailroom','N','Mailroom','Y','N','Y' );

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1513,'Voter Registration Preparation - Mailiroom',12,'Y','21-DEC-2019','','CR 2441','','Voter Registration Preparation','N','Mailroom','Y','N','Y' );


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1525,'BaSS Scan - Mailroom',27,'Y','21-DEC-2019','','CR 2441','','BaSS Scan - Mailroom','N','Mailroom Clerk','N','N','Y' );

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1552,'FPBP Scanning - FPBP Doc Management',22,'Y','1-Jan-2020','','CR 2441','','FPBP Scanning - FPBP Doc Management','N','FPBP - Imaging Admin','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1553,'FPBP Mail Sort - FPBP Doc Management',550,'Y','1-Jan-2020','','CR 2441','','FPBP Mail Sort - FPBP Doc Management','N','FPBP - Imaging Admin','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1554,'FPBP Mail Prep - FPBP Doc Management',12,'Y','21-DEC-2019','','CR 2441','','FPBP Mail Prep - FPBP Doc Management','N','FPBP- Imaging Admin','Y','N','Y' );

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1557,'FPBP Mail -  Batch Storage',60,'Y','1-Jan-2020','','CR 2441','','FPBP Mail - Batch Storage','N','FPBP - Imaging Admin','Y','N','Y' );


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1559,'MENTOR',0,'N','21-DEC-2019','','CR 2441','','MENTOR','N','MULTIPLE','N','N','N' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1585,'Application Assessment - Research',13,'Y','1-Jan-2020','','CR 2441','','Research - Application Assessment','N','Research Admin','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1586,'Nesting Assist',0,'N','21-DEC-2019','','CR 2441','','NON-PRODUCTIVE','N','NOT IN SCORECARD','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1587,'QPP',0,'N','21-DEC-2019','','CR 2441','','NON-PRODUCTIVE','N','NOT IN SCORECARD','N','N','Y' );


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1590,'Kofax Application - Image Assembly Admin',7,'Y','1-Jan-2020','','CR 2441','','Kofax Application - Image Assembly','N','Image Assembly Team','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1591,'Kofax Nav/CAC Batches - Image Assembly Admin',50,'Y','1-Jan-2020','','CR 2441','','Kofax Nav/CAC Batches - Image Assembly','N','Image Assembly Team','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1592,'MAXe Application - Image Assembly Admin',5.25,'Y','21-DEC-2019','','CR 2441','','MAXe Application - Image Assembly','N','Image Assembly Team','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1593,'MAXe Non-Application - Image Assembly Admin',35,'Y','1-Jan-2020','','CR 2441','','MAXe Non-Application - Image Assembly','N','Image Assembly Team','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1594,'Kofax Non-Application - Image Assembly Admin',25,'Y','1-Jan-2020','','CR 2441','','Kofax Non-Application - Image Assembly','N','Image Assembly Team','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1595,'KOFAX Fax QC - Image Assembly Admin',115,'Y','1-Jan-2020','','CR 2441','','KOFAX Fax QC - Image Assembly','N','Image Assembly Team','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1597,'Link Document Set - Image Assembly Admin',34,'Y','1-Jan-2020','','CR 2441','','Link Document Set - Image Assembly','N','Image Assembly Team','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1599,'Printing Returned Mail - Image Assembly Admin',300,'Y','21-DEC-2019','','CR 2441','','Printing Returned Mail - Image Assembly','N','Image Assembly Team','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1600,'Purge Review - Image Assembly Admin',65,'Y','21-DEC-2019','','CR 2441','','Purge Review - Image Assembly','N','Image Assembly Team','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1602,'Kofax Rescan - Image Assembly Admin',7,'Y','1-Jan-2020','','CR 2441','','Kofax Rescan - Image Assembly','N','Image Assembly Team','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1604,'Kofax Returned Mail Data Entry - Image Assembly Admin',8,'Y','1-Jan-2020','','CR 2441','','Kofax Returned Mail Data Entry - Image Assembly','N','Image Assembly Team','N','N','Y' );

insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1605,'Returned Mail Prepping - Image Assembly Admin',30,'Y','21-DEC-2019','','CR 2441','','Returned Mail Prepping - Image Assembly','N','Image Assembly Team','Y','N','Y' );


insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1607,'Kofax Non-Application 25+ - Image Assembly Admin',4,'Y','1-Jan-2020','','CR 2441','','Kofax Non-Application 25+ - Image Assembly','N','Data Entry Admin, Image A','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1609,'Appeal Open - ARU Task',2.5,'Y','1-Jan-2020','','CR 2441','','Appeal Open - ARU Task','N','Account Review Admin - Ta','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1610,'Appeal Outreach Project - ARU Task',4,'Y','21-DEC-2019','','CR 2441','','Appeal Outreach Project - ARU Task','N','Account Review Admin - Ta','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1611,'Awaiting Validity Amendment - ARU Task',8,'Y','1-Jan-2020','','CR 2441','','Awaiting Validity Amendment - ARU Task','N','Account Review Admin - Ta','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1612,'Data Entry Research - Existing Appeal - ARU Task',7,'Y','1-Jan-2020','','CR 2441','','Data Entry Research - Existing Appeal - ARU Task','N','Account Review Admin - Ta','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1613,'Invalid Right To Cure - ARU Task',4,'Y','1-Jan-2020','','CR 2441','','Invalid Right To Cure - ARU Task','N','Account Review Admin - Ta','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1614,'Non-Sworn AOP Cancellation - ARU Task',14,'Y','1-Jan-2020','','CR 2441','','Non-Sworn AOP Cancellation - ARU Task','N','Account Review Admin - Ta','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1615,'Notice of Dismissal - ARU Task',20,'Y','1-Jan-2020','','CR 2441','','Notice of Dismissal - ARU Task','N','Account Review Admin - Ta','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1616,'Pending Withdrawal / Cancellation - ARU Task ',14,'Y','1-Jan-2020','','CR 2441','','Pending Withdrawal / Cancellation - ARU Task ','N','Account Review Admin - Ta','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1618,'Return - Action Requried - ARU Task',5,'Y','1-Jan-2020','','CR 2441','','Return - Action Requried - ARU Task','N','Account Review Admin - Ta','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1620,'Spreadsheet Processing - ARU Task',0.25,'Y','1-Jan-2020','','CR 2441','','Spreadsheet Processing - ARU Task','N','Account Review Admin - Ta','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1621,'Written Withdrawal - ARU Task',10,'Y','1-Jan-2020','','CR 2441','','Written Withdrawal - ARU Task','N','Account Review Admin - Ta','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1624,'Appeal Evidence Packets Prepped - Mailroom',10,'Y','21-DEC-2019','','CR 2441','','Appeal Evidence Packets Prepped - Mailroom','N','Mailroom','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1625,'Appeal Letters Prepped - Mailroom',52,'Y','21-DEC-2019','','CR 2441','','Appeal Letters Prepped - Mailroom','N','Mailroom Clerk','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1626,'Applications Prepped - Mailroom',21,'Y','1-Jan-2020','','CR 2441','','Applications Prepped - Mailroom','N','Mailroom Clerk','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1627,'BaSS Prepped - Mailroom',40,'Y','1-Jan-2020','','CR 2441','','BaSS Prepped - Mailroom','N','Mailroom Clerk','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1628,'Rescans/Trashed Documents Prepped - Mailroom',21,'Y','1-Jan-2020','','CR 2441','','Rescans/Trashed Documents Prepped - Mailroom','N','Mailroom Clerk','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1629,'Non-Applications and Consumer Appeals Prepped - Mailroom',21,'Y','1-Jan-2020','','CR 2441','','Non-Applications and Consumer Appeals Prepped - Mailroom','N','Mailroom Clerk','Y','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1630,'Needs Verification - Research',8,'Y','21-DEC-2019','','CR 2441','','Needs Verification - Research','N','Research Admin','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1632,'Relink - Research',6,'Y','21-DEC-2019','','CR 2441','','Relink - Research','N','Research Admin','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1634,'Defect - VDOCS',8.5,'Y','21-DEC-2019','','CR 2441','','Defect - VDOCS','N','Verification Document Adm','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1635,'DOH Tasks - VDOCS',8.5,'Y','21-DEC-2019','','CR 2441','','DOH Tasks - VDOCS','N','Verification Document Adm','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1638,'Verification Document - Research',8.5,'Y','21-DEC-2019','','CR 2441','','Verification Document - Research','N','Research Admin','N','N','Y' );
insert into maxdat.PP_BO_EVENT_TARGET_LKUP  values (1640,'Returned Mail - Research',19,'Y','21-DEC-2019','','CR 2441','','Returned Mail - Research','N','Research Admin','N','N','Y' );


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

COMMIT;






