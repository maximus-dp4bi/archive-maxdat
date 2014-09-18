/*
Created on 17-Sep-2013 by Raj A. 
Process: NYHIX IDR Incidents process.

Description:
Populate BPM_ATTRIBUTE table used to map attribute definitions to a process.

This script populates the BPM_ATTRIBUTE table for the NYHIX IDR Incidents process.
*/
--Incident ID
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2356,451,21,'CREATE',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
--Created By Group
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2357,453,21,'CREATE',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
--Created By Name
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2358,8,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
--Incident Tracking Number
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2359,452,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
--Create Date
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2360,7,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
--Incident Type
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2361,462,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
--Client ID
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2362,593,21,'CREATE',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
--Review Documentation Start
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2363,1334,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
--Review Documentation End
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2364,1335,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
--Review Documentation Performed By
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2365,1336,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
--Gather Missing Information Start
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2366,1337,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
--Gather Missing Information End
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2367,1338,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Gather Missing Information Performed By
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2368,1339,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- About Plan Code
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2369,467,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- About Provider ID
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2370,466,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Action Comments
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2371,459,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Action Type
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2372,458,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Cancel By
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2373,777,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Cancel Date
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2374,47,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Cancel Method
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2375,722,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
--Cancel Reason
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2376,547,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Current Task ID
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2377,60,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
-- Enrollment Status
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2378,475,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
-- Incident About
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2379,463,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
-- Incident Reason
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2380,464,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
-- Incident Status
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2381,456,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
-- Incident Status Date
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2382,457,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
-- Instance Complete Date
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2383,65,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Instance Status
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2384,66,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
-- Last Update By Name
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2385,17,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
-- Last Update Date
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2386,18,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
-- Last Updated By
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2387,884,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
-- Other Party Name 
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2388,474,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Priority
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2389,455,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Reported By
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2390,468,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Reporter Relationship
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2391,469,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Resolution Type
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2392,460,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
-- Case ID
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2393,479,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Forwarded 
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2394,1340,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Forwarded To
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2395,1341,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Jeopardy Date
--insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2396,1268,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Jeopardy Days
--insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2397,1269,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Target Days
--insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2398,1283,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Age in business days 
--insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2399,1,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Age in calendar days
--insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2400,2,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Jeopardy Flag
--insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2401,16,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
-- IDR Timeliness Status
--insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2402,1342,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
-- Jeopardy Days Type
--insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2403,1270,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Rev IDR Docs Flag
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2396,1343,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Docs Received Flag
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2397,1344,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Continue Appeal Flag
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2398,1345,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
-- Incident Description
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2399,1499,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
-- Resolution Description
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2400,461,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y'); 
--Current Step
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2597,178,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
--Complete Date
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2584,5,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');
--Appellant Type
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2599,1597,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2600,1598,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
--Reporter Fields
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2605,505,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2606,1606,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 

commit;
