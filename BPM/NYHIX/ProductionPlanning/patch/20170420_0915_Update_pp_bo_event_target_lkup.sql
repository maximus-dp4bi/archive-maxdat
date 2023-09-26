update maxdat.pp_bo_event_target_lkup set end_date = to_date('4/30/2017','mm/dd/yyyy') where event_id in (1068,
1099,
1101,
1104,
1105,
1107,
1109,
1110,
1111,
1134,
1138,
1144,
1147,
1156,
1159,
1169,
1171,
1172,
1173,
1178,
1179,
1180,
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
1459,
1462,
1463,
1464,
1465,
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

update maxdat.pp_bo_event_target_lkup set name = 'Logging Certified Mail', scorecard_group = 'Logging Certified Mail' where event_id = 1487 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set scorecard_group = 'Appeals Letters' where event_id = 1489 and end_date = to_date('4/30/2017','mm/dd/yyyy');
update maxdat.pp_bo_event_target_lkup set OPS_GROUP = 'Research' where scorecard_group in ('Appeals','Returned Mail') and OPS_GROUP = 'MULTIPLE';

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1068,'Special Project',2, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Special Project', 'Y', 'MULTIPLE');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1099,'Complaint',20, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Complaint', 'Y', 'Account Review');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1101,'Incident Open',3.5, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Incident Open', 'Y', 'Account Review');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1104,'Verification Document',8.5, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Verification Document', 'Y', 'Verification Document');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1105,'Application in Process',9, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Application in Process', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1109,'Wrong Program',20, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Wrong Program', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1110,'FM Returned Mail',20, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Other Research', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1111,'Other',20, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Other Research', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1134,'Free Form Follow-up',20, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Other Research', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1138,'Link Document Set - App',30, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Link Document Set - App', 'Y', 'Linking');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1144,'Awaiting Written Withdrawal',7, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Awaiting Written Withdrawal', 'Y', 'Account Review');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1147,'HSDE QC - Verification',40, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'HSDE QC - Verification', 'Y', 'Linking');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1156,'Link Doc Set QC - App',27, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Link Doc Set QC - App', 'Y', 'QC');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1159,'Orphan Document',21, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Orphan Document', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1169,'HSDE Verification',24.5, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'HSDE Verification', 'Y', 'HSDE');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1171,'HSDE NYSOH Application',3.75, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'HSDE NYSOH Application', 'Y', 'HSDE');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1172,'Authorized Rep',10, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Authorized Rep', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1173,'Reschedule Hearing',6, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Reschedule Hearing', 'Y', 'Account Review');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1178,'KOFAX Fax QC',100, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'KOFAX FAX QC', 'Y', 'HSDE');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1200,'Returned Mail',19, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Returned Mail', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1201,'Appeals',20, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Appeals', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1204,'Awaiting Validity Check',5, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Awaiting Validity Check', 'Y', 'Account Review');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1230,'Incarceration Proof',20, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Other Research', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1282,'ID Proof - Task',27, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'ID Proof - Task', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1283,'ID Proof - Calls',12, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'ID Proof - Calls', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1284,'Manual Notice QC',65, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Manual Notice QC', 'Y', 'QC');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1285,'Evidence Packet QC',3.5, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Evidence Packet QC', 'Y', 'QC');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1286,'HSDE QC - App',10, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'HSDE QC - App', 'Y', 'Linking');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1289,'Data Entry Research - Other',20, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Other Research', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1290,'Application - Missing Data',6, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Application - Missing Data', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1294,'Letter Resend',20, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Other Research', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1299,'Link Document Set QC - VDOC',36, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Link Document Set QC - Vdoc', 'Y', 'QC');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1300,'Link Document Set - Verification',38, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Link Document Set - Verification', 'Y', 'Linking');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1301,'HSDE Access Application',8, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'HSDE Access Application', 'Y', 'HSDE');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1302,'HSDE Nav/CAC Batches',40, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'HSDE Nav/CAC Batches', 'Y', 'HSDE');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1317,'Retro Verification Document',8.5, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Retro Verification Document', 'Y', 'Verification Document');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1345,'Data Entry Research - Immigration Docs',12, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'VLP', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1400,'Linking Issues',19, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Linking Issues', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1403,'Rescan',4.5, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Rescan', 'Y', 'HSDE');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1404,'G845',100, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'G845', 'Y', 'Mailroom');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1405,'Appeal Letters',100, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Appeal Letters', 'Y', 'Mailroom');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1407,'Printing Return Mail',300, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Purge', 'Y', 'Mailroom');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1408,'Printing Rescans',100, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Printing Rescans', 'Y', 'Mailroom');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1409,'Scanning',19, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Scanning', 'Y', 'Mailroom');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1415,'Storage',100, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Storage', 'Y', 'Mailroom');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1425,'Schedule Hearing Task',0.65, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Schedule Hearing', 'Y', 'Account Review');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1442,'Dismissal Failed to Attend Hearing',6, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Dismissal Failed to Attend Hearing', 'Y', 'Account Review');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1443,'Document Account Review',8, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Document Account Review', 'Y', 'Account Review');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1448,'Returned Mail Data Entry',7.25, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Returned Mail Data Entry', 'Y', 'HSDE');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1455,'Envelope Sorting',1000, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Envelope Sorting', 'Y', 'Mailroom');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1456,'Envelopes Prepped',30, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Envelopes Prepped', 'Y', 'Mailroom');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1462,'VLP 3 - G845',12, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'VLP', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1463,'VLP 4 - Override',12, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'VLP', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1464,'VLP 5 - PRUCOL',12, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'VLP', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1465,'VLP 6 - Follow up',12, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'VLP', 'Y', 'Research');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1483,'DSRIP Opt Out Survey',65, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'DSRIP Opt Out Survey', 'Y', 'Mailroom');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1484,'DSRIP Incident',35, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'DSRIP Incident', 'Y', 'Mailroom');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1485,'Sorting/Cutting Incoming Mail',650, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Sorting/Cutting Incoming Mail', 'Y', 'Mailroom');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1486,'Making Copies',100, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Making Copies', 'Y', 'Mailroom');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1488,'Posting Mail',1000, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Posting Mail', 'Y', 'Mailroom');
INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP (EVENT_ID, NAME , TARGET , SCORECARD_FLAG , START_DATE , END_DATE , CREATE_BY , CREATE_DATETIME , SCORECARD_GROUP , EE_ADHERENCE , OPS_GROUP ) VALUES  (1489,'K Drive Appeal QC',60, 'Y', to_date('5/1/2017','mm/dd/yyyy'), null,'script', sysdate, 'Appeals Letters', 'Y', 'Mailroom');

commit;
