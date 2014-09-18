--CORP_OPS_MANAGE_WORK
--delete BPM_ATTRIBUTE_LKUP
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	1	,	1	,'Age in Business Days','Number of days from the Create Date to the Complete Date, or to the Current Date for instances that are not yet complete, excluding weekends and project holidays.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	2	,	1	,'Age in Calendar Days','Number of days from the Create Date to the Complete Date, or to the current date for instances that are not yet complete.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	3	,	3	,'Cancel Work Date','Indicates the date the ETL discovered that the task was no longer available to be worked.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	4	,	2	,'Cancel Work Flag','Indicates if the task is no longer available to be worked (deleted or disregarded).');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	5	,	3	,'Complete Date','The date the instances is first set to a completed status.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	6	,	2	,'Complete Flag','Indicates if the instance is determined to be in a completed state');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	7	,	3	,'Create Date','This is the date that the instance was created in the MAXe system');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	8	,	2	,'Created By Name','Name of the staff member that created the instance in MAXe. This name should be formatted as:Last, First MI or when no middle initial exists then Last, First');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	9	,	2	,'Escalated Flag','Indicates if the instance is currently escalated.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	10	,	2	,'Escalated To Name','Name of the staff member in MAXe to whom the instance has been escalated. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	11	,	2	,'Forwarded By Name','Name of the staff member in MAXe who forwarded the instance. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	12	,	2	,'Forwarded Flag','Indicates if the task was forwarded to the current location.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	13	,	2	,'Group Name','Name of the MAXe Group to which a task is assigned.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	14	,	2	,'Group Parent Name','Name of the MAXe Group identified as the parent group of the MAXe Group to which a task is assigned.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	15	,	2	,'Group Supervisor Name','Name of the staff member in MAXe identified as the supervisor of the group. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	16	,	2	,'Jeopardy Flag','Indicates if the application is in jeopardy based on the SLA Days Type and SLA Jeopardy Days. Default value is "N"');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	17	,	2	,'Last Update By Name','Name of the staff member that last updated the instance in MAXe. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	18	,	3	,'Last Update Date','Date the instance was last updated in MAXe');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	19	,	2	,'Owner Name','Name of the staff member that is considered to be the owner of the instance.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	20	,	1	,'SLA Days','Age at which time the measured cycle is determined to be untimely. If no SLA applies then this value is null');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	21	,	2	,'SLA Days Type','Indicates if the SLA Days is based on Business Days or Calendar Days. If no SLA applies then this value is null. ');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	22	,	1	,'SLA Jeopardy Days','Age at which time the measured cycle is determined to be in Jeopardy. If no SLA applies then this value is null. This value should be easily configured and will initially be set to 2 for all instances.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	23	,	1	,'SLA Target Days','Age at which time the measured cycle is determined to be untimely based on target goals set by the business. If no target has been defined then this value is null.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	24	,	2	,'Source Reference ID','Unique identifier for the item to which this instance is associated (Application ID, Document ID, etc). This is useful for looking up more details in the source system.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	25	,	2	,'Source Reference Type','Indicates the type of Source Reference ID that is being provided.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	26	,	1	,'Status Age in Business Days','Number of days from the Status Date to the current date excluding weekends and project holidays for instances that are not yet complete. Once an instance is complete, this value should be 0.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	27	,	1	,'Status Age in Calendar Days','Number of days from the Status Date to the current date for instances that are not yet complete. Once an instance is complete, this value should be 0.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	28	,	3	,'Status Date','Date the instance Status was set in MAXe');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	29	,	1	,'Task ID','Unique identifier for the task in MAXe');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	30	,	2	,'Task Status','Current status of the task in MAXe indicating if the task is claimed or unclaimed.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	31	,	2	,'Task Type','Indicates the type of work.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	32	,	2	,'Team Name','Name of the MAXe Group identified as the team');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	33	,	2	,'Team Parent Name','Name of the MAXe Group identified as the parent group of the MAXe Group identified');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	34	,	2	,'Team Supervisor Name','Name of the staff member in MAXe identified as the supervisor of the team');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	35	,	2	,'Timeliness Status','Indicates if the instance was processed timely or untimely based on the SLA Days Type, SLA Days, and age or cycle days. Default value is Not Required');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	36	,	2	,'Unit of Work','Indicates the Production Planning Unit of Work.');

Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	37	,	2	,'App Complete Result','For completed applications, this categorizes the end result of the application processing (what happened to this application).');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	38	,	2	,'App Status','Current status of application in MAXe');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	39	,	2	,'App Status Group','Hierarchical grouping of MAXe App Statuses and Request for Eligibility Statuses');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	40	,	1	,'Application ID','Unique identifier for the application in the source system.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	41	,	2	,'Application Type','The type of application being processed.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	42	,	2	,'Auto Reprocess Flag','Indicates the instance was automatically reprocessed by the system after MI was not returned.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	43	,	3	,'Cancel App End Date','Date work ended for the Cancel App activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	44	,	2	,'Cancel App Flag','Cancel App Activity Step');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	45	,	2	,'Cancel App Performed By','Name of the staff member that completed the "Cancel App" activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	46	,	3	,'Cancel App Start Date','Date work started for the Cancel App activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	47	,	3	,'Cancel Date','Indicates the date the ETL discovered that the instance was no longer available to be worked.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	48	,	2	,'Cancel Flag','Indicates if the instance is no longer available to be worked');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	49	,	2	,'Channel','This is the channel through which the instance was received by Maximus');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	50	,	2	,'Clockdown Indicator','If the application has not been received, 15 days prior to Authorization date, the state sends letter to client. Application is moved to clockdown');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	51	,	3	,'Close App End Date','Date work ended for the Close App activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	52	,	2	,'Close App Flag','Close App  Activity Step');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	53	,	2	,'Close App Performed By','Name of the staff member that completed the "Close App" activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	54	,	3	,'Close App Start Date','Date work started for the Close App activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	55	,	3	,'Complete App End Date','Date work ended for the Complete App activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	56	,	2	,'Complete App Flag','Complete App Activity Step');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	57	,	2	,'Complete App Performed By','Name of the staff member that completed the "Complete App" activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	58	,	3	,'Complete App Start Date','Date work started for the Complete App activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	59	,	2	,'County','County associated with the instance');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	60	,	1	,'Current Task ID','Task ID identifying the current task for the instance');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	61	,	1	,'Data Entry Task ID','Task ID identifying the Data Entry task created for the instance');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	62	,	2	,'Eligibility Action','Eligibility action taken during application processing');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	63	,	2	,'HEART App Status','This is the application status in HEART. ');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	64	,	2	,'HEART Synch Flag','Indicates if MAXe is in-synch with the HEART system.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	65	,	3	,'Instance Complete Date','Date the instance reached a terminal point in the process.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	66	,	2	,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	67	,	1	,'KPR App Cycle Business Days','This is the number of days excluding weekends and project holidays from the KPR App Cycle Start Dt to the KPR App Cycle End Dt for applications that have completed the App Cycle.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	68	,	1	,'KPR App Cycle Calendar Days','This is the number of calendar days from the App Cycle Start Date to the App Cycle End Date for applications that have completed the App Cycle.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	69	,	3	,'KPR App Cycle End Date','End date for measuring KPR App Cycle timeliness');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	70	,	3	,'KPR App Cycle Start Date','Start date for measuring KPR App Cycle timeliness');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	71	,	3	,'Last Mail Date','This is used to identify the "batch" for renewals');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	72	,	1	,'MI Received Task Count','This is used to monitor how many MI Received tasks were created for an instance');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	73	,	2	,'Missing Information Flag','Missing Information Gateway');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	74	,	2	,'New MI Flag','New MI Flag');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	75	,	3	,'Notify Client Pended App Date','Date the notification of MI was sent');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	76	,	3	,'Notify Client Pended App End Date','Date work ended for the Notify Client Pended App activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	77	,	2	,'Notify Client Pended App Flag','Notify Client Pended App Activity Step');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	78	,	2	,'Notify Client Pended App Performed By','Name of the staff member that completed the "Notify Client Pended App" activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	79	,	3	,'Notify Client Pended App Start Date','Date work started for the Notify Client Pended App activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	80	,	2	,'Outcome Notification Required Flag','Outcome Notification Required Flag');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	81	,	2	,'Pend Notification Required Flag','Pend Notification Required Gateway');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	82	,	3	,'Perform QC Date','Date the QC task was completed and the app status group changed to either "Awaiting Missing Information" or "Done"');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	83	,	3	,'Perform QC End Date','Date work ended for the Perform QC activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	84	,	2	,'Perform QC Flag','Perform QC Activity Step');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	85	,	2	,'Perform QC Performed By','Name of the staff member that completed the "Perform QC" activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	86	,	3	,'Perform QC Start Date','Date work started for the Perform QC activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	87	,	3	,'Perform Research Date','Date the Research task was completed');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	88	,	3	,'Perform Research End Date','Date work ended for the Perform Research activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	89	,	2	,'Perform Research Flag','Perform Research Activity Step');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	90	,	2	,'Perform Research Performed By','Name of the staff member that completed the "Perform Research" activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	91	,	3	,'Perform Research Start Date','Date work started for the Perform Research activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	92	,	3	,'Process App Info Date','Date initial app processing was completed');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	93	,	3	,'Process App Info End Date','Date work ended for the Process App Info activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	94	,	2	,'Process App Info Flag','Process App Info  Activity Step');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	95	,	2	,'Process App Info Performed By','Name of the staff member that completed the "Process App Info" activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	96	,	3	,'Process App Info Start Date','Date work started for the Process App Info activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	97	,	2	,'QC Outcome Flag','QC Outcome Flag');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	98	,	2	,'QC Required Flag','QC Required Gateway');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	99	,	1	,'QC Task ID','Task ID identifying the QC task created for the instance');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	100	,	3	,'Receipt Date','The receipt date is set when the instance is received by Maximus');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	101	,	3	,'Receive and Process MI End Date','Date work ended for the Receive and Process MI activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	102	,	2	,'Receive and Process MI Flag','Receive and Process MI Activity Step');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	103	,	2	,'Receive and Process MI Performed By','Name of the staff member that completed the "Receive and Process MI" activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	104	,	3	,'Receive and Process MI Start Date','Date work started for the Receive and Process MI activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	105	,	3	,'Receive App End Date','Date work ended for the Receive App activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	106	,	2	,'Receive App Flag','Receive App  Activity Step');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	107	,	2	,'Receive App Performed By','Name of the staff member that completed the "Receive App" activity step');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	108	,	3	,'Receive App Start Date','Date work started for the Receive App activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	109	,	2	,'Refer to LDSS Flag','Indicates if the instance should be referred to LDSS');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	110	,	2	,'Research Flag','Research Flag');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	111	,	2	,'Research Reason','This indicates the reason work was sent to Research. ');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	112	,	1	,'Research Task ID','Task ID identifying the Research task created for the instance');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	113	,	3	,'Review and Enter Data Date','This is the date the data entry task was completed.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	114	,	3	,'Review and Enter Data End Date','Date work ended for the Review and Enter Data App activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	115	,	2	,'Review and Enter Data Flag','Review and Enter Data  Activity Step');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	116	,	2	,'Review and Enter Data Performed By','Name of the staff member that completed the "Review and Enter Data" activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	117	,	3	,'Review and Enter Data Start Date','Date work started for the Review and Enter Data App activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	118	,	3	,'Send Outcome Notification Date','Date the notification of Outcome was sent');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	119	,	3	,'Send Outcome Notification End Date','Date work ended for the Send Outcome Notification activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	120	,	2	,'Send Outcome Notification Flag','Send Outcome Notification Activity Step');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	121	,	3	,'Send Outcome Notification Start Date','Date work started for the Send Outcome Notification activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	122	,	2	,'Send to LDSS Flag','Send to LDSS Flag');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	123	,	3	,'SLA Jeopardy Date','First date on which application is considered in Jeopardy, this is the date that the Jeopardy Flag was or will be set to "Y"');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	124	,	1	,'State Review Task Count','This is used to monitor how many state review tasks were created for the instance');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	125	,	1	,'State Review Task ID','Task ID identifying the State Review task created for the instance');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	126	,	3	,'Wait for State Approval Date','Date the State Approval task was completed');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	127	,	3	,'Wait for State Approval End Date','Date work ended for the Wait for State Approval activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	128	,	2	,'Wait for State Approval Performed By','Name of the staff member that completed the "Wait for State Approval" activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	129	,	3	,'Wait for State Approval Start Date','Date work started for the Wait for State Approval activity step.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	130	,	2	,'Wait State Approval Flag','Wait State Approval Activity Step');
