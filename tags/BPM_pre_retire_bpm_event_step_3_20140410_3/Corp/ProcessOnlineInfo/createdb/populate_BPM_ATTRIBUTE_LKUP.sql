insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1286,	1,	'Transaction ID', 'The unique identifier of the online transaction.'); 
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1287,	2,	'Transaction Type','Indicates the specific type of transaction submitted.'); 
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (7,	3,	  'Create Date','Date online transaction was created in the source system.');   
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (8,	2,	  'Create By Name',  
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (479,	1,	'Case ID',
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (593,	1,	'Client ID',
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (171,	2,	'Work Required Flag',
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (66,	2,	  'Instance Status',  
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1294,	2,	'Source Record Type','Source Record Type describes the type of information in the source system that houses the online transaction.'); 
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1295,	1,	'Source Record ID','The Source Record ID is the distinct record identifer from the source system.'); 
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (18,	3,	  'Last Update Date',  
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (17,	2,	  'Last Updated by Name',  
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (559,	2,	'Language',
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1299,	3,	'Process New Info Start Date', 'The date and time that the activity step began.  This is the date/time that the MAXeb system detected new information received from the SSA Portal and should be the the transactions create date.'); 
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1300,	3,	'Process New Info End Date','The date and time that the activity step is completed.  This is the date and time that the MAXeb system completed processing of the new information received from the SSA Portal.'); 
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1301,	3,	'Create and Route Work Start Date','The date/time the activity step begins.  This is equivalent to the end date of the process new information activity.'); 
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1302,	3,	'Create and Route Work End Date','The date and time that the activity step is completed.  This is the date and time that the MAXeb system completed processing of the new information received from the SSA Portal.'); 
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (547,		  'Cancel Reason',  
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (722,		  'Cancel Method',  
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (576,		  'Cancel By',  
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (47,		  'Cancel Date',  
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (5,		  'Complete Date',  
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1308,	2,	'Process New Info flag','Process New Info Activity step flag'); 
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (588,	2,	'Create and Route Work flag','Create and Route Work Activity Step flag'); 
--insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (450,	2,	'Work Identified flag','Work Identified Gateway flag'); 

COMMIT;