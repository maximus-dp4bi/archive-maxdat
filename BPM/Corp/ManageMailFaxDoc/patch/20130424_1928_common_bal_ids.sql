--------------------------------------------------------
--  File created - Wednesday-April-24-2013   
--------------------------------------------------------
REM INSERTING into BPM_ATTRIBUTE_LKUP
SET DEFINE OFF;
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (49,2,'Channel','This is the channel through which the instance was received by Maximus');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (65,3,'Instance Complete Date','Date the instance reached a terminal point in the process.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (66,2,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (131,2,'Batch Name','The Batch Name is a unique identifier assigned to each batch.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (172,1,'Work Task ID','The Task ID is the ID of the task created AFTER all proximal match tasks are completed. This TASK ID does not represent the HSDE-QC, Link Document Set, or Document Problem Resolution task.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (194,2,'Document Type','The Document Type is the high level description of a document in an envelope.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (197,2,'Document Form Type','The Document Form type is the description of the form returned by the client.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (200,1,'Document Page Count','The document page count is the count of individual pages in a document.');



Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (524,131,9,'CREATE',to_date('2013-04-17 15:44:54','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'N');
Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (525,49,9,'CREATE',to_date('2013-04-17 15:44:54','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'N');
Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (529,200,9,'CREATE',to_date('2013-04-17 15:44:54','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'N');
Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (533,197,9,'BOTH',to_date('2013-04-17 15:44:54','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'N');
Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (534,194,9,'BOTH',to_date('2013-04-17 15:44:54','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'N');
Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (546,172,9,'BOTH',to_date('2013-04-17 15:44:54','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'N');
Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (562,66,9,'BOTH',to_date('2013-04-17 15:44:54','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Y');
Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (563,65,9,'BOTH',to_date('2013-04-17 15:44:54','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),null);


commit;
