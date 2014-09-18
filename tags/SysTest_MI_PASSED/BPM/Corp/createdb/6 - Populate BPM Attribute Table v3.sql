--delete BPM_ATTRIBUTE
--NY Manage Work
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	1	,	1	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Age in Business Days','Number of days from the Create Date to the Complete Date, or to the Current Date for instances that are not yet complete, excluding weekends and project holidays.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	2	,	2	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Age in Calendar Days','Number of days from the Create Date to the Complete Date, or to the current date for instances that are not yet complete.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	3	,	3	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Cancel Work Date','Indicates the date the ETL discovered that the task was no longer available to be worked.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	4	,	4	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Cancel Work Flag','Indicates if the task is no longer available to be worked (deleted or disregarded).');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	5	,	5	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Complete Date','The date the instances is first set to a completed status.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	6	,	6	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Complete Flag','Indicates if the instance is determined to be in a completed state');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	7	,	7	, 1, 'CREATE',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Create Date','This is the date that the instance was created in the MAXe system');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	8	, 8	, 1, 'CREATE',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Created By Name','Name of the staff member that created the instance in MAXe. This name should be formatted as:Last, First MI or when no middle initial exists then Last, First');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	9	,	9	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Escalated Flag','Indicates if the instance is currently escalated.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	10	,	10	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Escalated To Name','Name of the staff member in MAXe to whom the instance has been escalated. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	11	, 11	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Forwarded By Name','Name of the staff member in MAXe who forwarded the instance. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	12	,	12	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Forwarded Flag','Indicates if the task was forwarded to the current location.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	13	,	13	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Group Name','Name of the MAXe Group to which a task is assigned.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	14	,	14	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Group Parent Name','Name of the MAXe Group identified as the parent group of the MAXe Group to which a task is assigned.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	15	,	15	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Group Supervisor Name','Name of the staff member in MAXe identified as the supervisor of the group. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	16	,	16	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Jeopardy Flag','Indicates if the application is in jeopardy based on the SLA Days Type and SLA Jeopardy Days. Default value is "N"');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	17	,	17	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Last Update By Name','Name of the staff member that last updated the instance in MAXe. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	18	,	18	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Last Update Date','Date the instance was last updated in MAXe');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	19	,	19	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Owner Name','Name of the staff member that is considered to be the owner of the instance.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	20	,	20	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'SLA Days','Age at which time the measured cycle is determined to be untimely. If no SLA applies then this value is null');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	21	,	21	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'SLA Days Type','Indicates if the SLA Days is based on Business Days or Calendar Days. If no SLA applies then this value is null. ');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	22	,	22	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'SLA Jeopardy Days','Age at which time the measured cycle is determined to be in Jeopardy. If no SLA applies then this value is null. This value should be easily configured and will initially be set to 2 for all instances.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	23	,	23	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'SLA Target Days','Age at which time the measured cycle is determined to be untimely based on target goals set by the business. If no target has been defined then this value is null.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	24	,	24	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Source Reference ID','Unique identifier for the item to which this instance is associated (Application ID, Document ID, etc). This is useful for looking up more details in the source system.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	25	,	25	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Source Reference Type','Indicates the type of Source Reference ID that is being provided.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	26	,	26	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Status Age in Business Days','Number of days from the Status Date to the current date excluding weekends and project holidays for instances that are not yet complete. Once an instance is complete, this value should be 0.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	27	,	27	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Status Age in Calendar Days','Number of days from the Status Date to the current date for instances that are not yet complete. Once an instance is complete, this value should be 0.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	28	,	28	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Status Date','Date the instance Status was set in MAXe');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	29	,	29	, 1, 'CREATE',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Task ID','Unique identifier for the task in MAXe');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	30	,	30	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Task Status','Current status of the task in MAXe indicating if the task is claimed or unclaimed.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	31	,	31	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Task Type','Indicates the type of work.');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	32	,	32	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Team Name','Name of the MAXe Group identified as the team');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	33	,	33	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Team Parent Name','Name of the MAXe Group identified as the parent group of the MAXe Group identified');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	34	,	34	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Team Supervisor Name','Name of the staff member in MAXe identified as the supervisor of the team');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	35	,	35	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Timeliness Status','Indicates if the instance was processed timely or untimely based on the SLA Days Type, SLA Days, and age or cycle days. Default value is Not Required');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	36	,	36	, 1, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD')); 
--'Unit of Work','Indicates the Production Planning Unit of Work.');
--NY Process Application

Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	37	,	37	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	38	,	38	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	39	,	39	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	40	,	40	, 2, 'CREATE',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	41	,	41	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	42	,	42	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	43	,	43	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	44	,	44	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	45	,	45	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	46	,	46	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	47	,	47	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	48	,	48	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	49	,	49	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	50	,	50	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	51	,	51	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	52	,	52	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	53	,	53	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	54	,	54	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	55	,	55	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	56	,	56	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	57	,	57	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	58	,	58	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	59	,	59	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	60	,	60	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	61	,	61	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	62	,	62	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	63	,	63	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	64	,	64	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	65	,	65	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	66	,	66	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	67	,	67	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	68	,	68	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	69	,	69	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	70	,	70	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	71	,	71	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	72	,	72	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	73	,	73	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	74	,	74	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	75	,	75	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	76	,	76	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	77	,	77	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	78	,	78	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	79	,	79	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	80	,	80	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	81	,	81	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	82	,	82	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	83	,	83	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	84	,	84	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	85	,	85	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	86	,	86	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	87	,	87	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	88	,	88	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	89	,	89	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	90	,	90	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	91	,	91	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	92	,	92	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	93	,	93	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	94	,	94	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	95	,	95	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	96	,	96	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	97	,	97	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	98	,	98	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	99	,	99	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	100	,	100	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	101	,	101	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	102	,	102	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	103	,	103	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	104	,	104	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	105	,	105	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	106	,	106	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	107	,	107	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	108	,	108	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	109	,	109	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	110	,	110	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	111	,	111	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	112	,	112	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	113	,	113	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	114	,	114	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	115	,	115	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	116	,	116	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	117	,	117	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	118	,	118	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	119	,	119	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	120	,	120	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	121	,	121	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	122	,	122	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	123	,	123	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	124	,	124	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	125	,	125	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	126	,	126	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	127	,	127	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	128	,	128	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	129	,	129	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	130	,	130	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	131	,	1	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	132	,	2	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	133	,	5	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	134	,	7	, 2, 'CREATE',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	135	,	16	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	136	,	20	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	137	,	21	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	138	,	22	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	139	,	23	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE) values (	140	,	35	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));

