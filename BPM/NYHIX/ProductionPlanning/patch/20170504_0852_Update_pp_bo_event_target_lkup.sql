update maxdat.pp_bo_event_target_lkup set end_date = to_date('4/30/2017','mm/dd/yyyy') where event_id in (1068,
1099,
1101,
1103,
1104,
1105,
1107,
1109,
1110,
1111,
1131,
1132,
1133,
1134,
1138,
1144,
1147,
1156,
1157,
1159,
1161,
1169,
1171,
1172,
1173,
1176,
1177,
1178,
1179,
1180,
1197,
1200,
1201,
1204,
1230,
1282,
1283,
1284,
1285,
1286,
1287,
1289,
1290,
1294,
1299,
1300,
1301,
1302,
1317,
1342,
1343,
1344,
1345,
1400,
1403,
1404,
1405,
1407,
1408,
1409,
1410,
1411,
1412,
1413,
1414,
1415,
1425,
1442,
1443,
1448,
1454,
1455,
1456,
1457,
1458,
1459,
1462,
1463,
1464,
1465,
1466,
1467,
1468,
1472,
1473,
1483,
1484,
1485,
1486,
1487,
1488,
1489)
and end_date is null;

update maxdat.pp_bo_event_target_lkup set scorecard_group = 'NON-PRODUCTIVE' where event_id = 1081 and end_date is null;
update maxdat.pp_bo_event_target_lkup set scorecard_group = 'NON-PRODUCTIVE' where event_id = 1102 and end_date is null;
update maxdat.pp_bo_event_target_lkup set name = 'Returned Mail Application', scorecard_group = 'Returned Mail', OPS_GROUP = 'Research' where event_id = 1107 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set name = 'KOFAX Mail QC', scorecard_group = 'KOFAX FAX QC', OPS_GROUP = 'HSDE' where event_id = 1179 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set name = 'Mailroom', scorecard_group = 'NON-PRODUCTIVE', OPS_GROUP = 'NOT IN SCORECARD' where event_id = 1180 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set name = 'HSDE QC - V Doc w/Engage', scorecard_group = 'HSDE QC - Verification', OPS_GROUP = 'Linking' where event_id = 1287 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set scorecard_flag = 'Y' where event_id = 1406 and end_date = to_date('10/31/2016','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set name = 'Logging Live Checks', scorecard_group = 'Logging Task', OPS_GROUP = 'Mailroom' where event_id = 1410 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set name = 'Logging Voter Registration', scorecard_group = 'Logging Task', OPS_GROUP = 'Mailroom' where event_id = 1411 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set name = 'Logging NYSOH Apps', scorecard_group = 'Logging Task', OPS_GROUP = 'Mailroom' where event_id = 1412 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set name = 'Logging Good Cause / Med Reimbursments', scorecard_group = 'Logging Task', OPS_GROUP = 'Mailroom' where event_id = 1413 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set name = 'Purge', scorecard_group = 'Returned Mail Prepping', OPS_GROUP = 'MULTIPLE' where event_id = 1414 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set scorecard_group = 'NON-PRODUCTIVE' where event_id = 1426 and end_date is null;
update maxdat.pp_bo_event_target_lkup set scorecard_group = 'NON-PRODUCTIVE' where event_id = 1446 and end_date is null;
update maxdat.pp_bo_event_target_lkup set name = 'Returned Mail Prepping', scorecard_group = 'Returned Mail Prepping', OPS_GROUP = 'MULTIPLE' where event_id = 1454 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set name = 'Account Correction (VDOCS)', scorecard_group = 'Account Correction (VDOCS)', OPS_GROUP = 'Verification Document' where event_id = 1457 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set name = 'Escalations', scorecard_group = 'Escalations', OPS_GROUP = 'Verification Document' where event_id = 1459 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set name = 'Return Mail Folding', scorecard_group = 'Return Mail Folding', OPS_GROUP = 'MULTIPLE' where event_id = 1472 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set name = 'Return Mail Printing', scorecard_group = 'Return Mail Printing', OPS_GROUP = 'MULTIPLE' where event_id = 1473 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set scorecard_group = 'NON-PRODUCTIVE' where event_id = 1484 and end_date = to_date('10/08/2016','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set scorecard_group = 'NON-PRODUCTIVE' where event_id = 1486 and end_date = to_date('10/08/2016','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set name = 'Logging Certified Mail', scorecard_group = 'Logging Certified Mail', OPS_GROUP = 'Mailroom' where event_id = 1487 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set scorecard_group = 'NON-PRODUCTIVE' where event_id = 1488 and end_date = to_date('10/08/2016','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set scorecard_group = 'Appeals Letters' where event_id = 1489 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set OPS_GROUP = 'Research' where scorecard_group in ('Appeals','Returned Mail') and OPS_GROUP != 'Research';

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1068,'Special Project',2,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Special Project', 'Y', 'MULTIPLE','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1099,'Complaint',20,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Complaint', 'Y', 'Account Review','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1101,'Incident Open',3.5,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Incident Open', 'Y', 'Account Review','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1103,'Schedule Hearing',0.65,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Schedule Hearing', 'Y', 'Account Review','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1104,'Verification Document',8.5,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Verification Document', 'Y', 'Verification Document','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1105,'Application in Process',9,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Application in Process', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1109,'Wrong Program',20,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Wrong Program', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1110,'FM Returned Mail',20,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Other Research', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1111,'Other',20,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Other Research', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1131,'Document Problem Resolution',20,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Other Research', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1132,'Doc/Form Type Mismatch Task',20,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Other Research', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1133,'Financial Management',20,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Other Research', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1134,'Free Form Follow-up',20,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Other Research', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1138,'Link Document Set - App',30,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Link Document Set - App', 'Y', 'Linking','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1144,'Awaiting Written Withdrawal',7,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Awaiting Written Withdrawal', 'Y', 'Account Review','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1147,'HSDE QC - Verification',40,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'HSDE QC - Verification', 'Y', 'Linking','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1156,'Link Doc Set QC - App',27,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Link Doc Set QC - App', 'Y', 'QC','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1157,'Multiple Applications',19,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Linking Issues', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1159,'Orphan Document',21,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Orphan Document', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1161,'Account Correction',19,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Linking Issues', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1169,'HSDE Verification',24.5,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'HSDE Verification', 'Y', 'HSDE','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1171,'HSDE NYSOH Application',3.75,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'HSDE NYSOH Application', 'Y', 'HSDE','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1172,'Authorized Rep',10,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Authorized Rep', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1173,'Reschedule Hearing',6,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Reschedule Hearing', 'Y', 'Account Review','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1176,'VLP - G845',12,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'VLP', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1177,'TPHI',20,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Other Research', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1178,'KOFAX Fax QC',100,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'KOFAX FAX QC', 'Y', 'HSDE','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1197,'Application Missing Information',6,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Application - Missing Data', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1200,'Returned Mail',19,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Returned Mail', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1201,'Appeals',20,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Appeals', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1204,'Awaiting Validity Check',5,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Awaiting Validity Check', 'Y', 'Account Review','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1230,'Incarceration Proof',20,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Other Research', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1282,'ID Proof - Task',27,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'ID Proof - Task', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1283,'ID Proof - Calls',12,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'ID Proof - Calls', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1284,'Manual Notice QC',65,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Manual Notice QC', 'Y', 'QC','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1285,'Evidence Packet QC',3.5,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Evidence Packet QC', 'Y', 'QC','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1286,'HSDE QC - App',10,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'HSDE QC - App', 'Y', 'Linking','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1289,'Data Entry Research - Other',20,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Other Research', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1290,'Application - Missing Data',6,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Application - Missing Data', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1294,'Letter Resend',20,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Other Research', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1299,'Link Document Set QC - VDOC',36,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Link Document Set QC - Vdoc', 'Y', 'QC','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1300,'Link Document Set - Verification',38,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Link Document Set - Verification', 'Y', 'Linking','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1301,'HSDE Access Application',8,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'HSDE Access Application', 'Y', 'HSDE','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1302,'HSDE Nav/CAC Batches',40,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'HSDE Nav/CAC Batches', 'Y', 'HSDE','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1317,'Retro Verification Document',8.5,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Retro Verification Document', 'Y', 'Verification Document','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1342,'VLP - Override',12,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'VLP', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1343,'VLP - PRUCOL',12,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'VLP', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1344,'VLP - Follow Up',12,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'VLP', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1345,'Data Entry Research - Immigration Docs',12,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'VLP', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1400,'Linking Issues',19,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Linking Issues', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1403,'Rescan',4.5,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Rescan', 'Y', 'HSDE','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1404,'G845',100,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'G845', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1405,'Appeal Letters',100,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Appeal Letters', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1407,'Printing Return Mail',300,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Purge', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1408,'Printing Rescans',100,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Printing Rescans', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1409,'Scanning',19,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Scanning', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1415,'Storage',100,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Storage', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1425,'Schedule Hearing Task',0.65,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Schedule Hearing', 'Y', 'Account Review','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1442,'Dismissal Failed to Attend Hearing',6,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Dismissal Failed to Attend Hearing', 'Y', 'Account Review','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1443,'Document Account Review',8,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Document Account Review', 'Y', 'Account Review','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1448,'Returned Mail Data Entry',7.25,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Returned Mail Data Entry', 'Y', 'HSDE','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1455,'Envelope Sorting',1000,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Envelope Sorting', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1456,'Envelopes Prepped',30,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Envelopes Prepped', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1458,'Complaint (DPR)',20,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Other Research', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1462,'VLP 3 - G845',12,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'VLP', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1463,'VLP 4 - Override',12,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'VLP', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1464,'VLP 5 - PRUCOL',12,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'VLP', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1465,'VLP 6 - Follow up',12,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'VLP', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1466,'VLP Holding',12,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'VLP', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1467,'Application In Process',9,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Application in Process', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1468,'Application Missing Data',6,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Application - Missing Data', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1483,'DSRIP Opt Out Survey',65,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'DSRIP Opt Out Survey', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1484,'DSRIP Incident',35,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'DSRIP Incident', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1485,'Sorting/Cutting Incoming Mail',650,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Sorting/Cutting Incoming Mail', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1486,'Making Copies',100,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Making Copies', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1488,'Posting Mail',1000,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Posting Mail', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1489,'K Drive Appeal QC',60,'Y', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Appeals Letters', 'Y', 'Mailroom','N');

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1124,'Missing Data',0,'N', to_date('11/1/2016','mm/dd/yyyy'), null, 'script', sysdate, 'Application - Missing Data', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1406,'Evidence Packets',0,'N', to_date('11/1/2016','mm/dd/yyyy'), null, 'script', sysdate, 'Evidence Packets', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1179,'KOFAX Mail QC',0,'N', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'KOFAX FAX QC', 'Y', 'HSDE','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1287,'HSDE QC - V Doc w/Engage',0,'N', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'HSDE QC - Verification', 'Y', 'Linking','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1410,'Logging Live Checks',0,'N', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Logging Task', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1411,'Logging Voter Registration',0,'N', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Logging Task', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1412,'Logging NYSOH Apps',0,'N', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Logging Task', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1413,'Logging Good Cause / Med Reimbursments',0,'N', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Logging Task', 'Y', 'Mailroom','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1414,'Purge',0,'N', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Returned Mail Prepping', 'Y', 'MULTIPLE','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1454,'Returned Mail Prepping',0,'N', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Returned Mail Prepping', 'Y', 'MULTIPLE','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1457,'Account Correction (VDOCS)',0,'N', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Account Correction (VDOCS)', 'Y', 'Verification Document','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1459,'Escalations',0,'N', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Escalations', 'Y', 'Verification Document','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1472,'Return Mail Folding',0,'N', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Return Mail Folding', 'Y', 'MULTIPLE','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1473,'Return Mail Printing',0,'N', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Return Mail Printing', 'Y', 'MULTIPLE','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1107,'Returned Mail Application',0,'N', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Returned Mail', 'Y', 'Research','N');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP, WORKSUBACTIVITY_FLAG ) VALUES  (1487,'Logging Certified Mail',0,'N', to_date('5/1/2017','mm/dd/yyyy'), null, 'script', sysdate, 'Logging Certified Mail', 'Y', 'Mailroom','N');

commit;
