--- Patch for BPM_ATTRIBUTE_LKUP

Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	331	,	2	,'CIN ','The CIN is the unique ID associated to the applicants.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	332	,	3	,'CIN  Date','The CIN  Date is the date that the HOH CIN is created or updated, and the saved in MAXe.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	333	,	2	,'Provider Name','The Provider name is the name of the company that submitted the FPBP PE application on behalf of the client.');
--Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	334	,	2	,'Provider Agency','The Provider ageny is the Provider group listed on the FPBP application.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	335	,	2	,'FPBP Sub-type','The FPBP sub-type indicates whether the PE application only has been received (PE App), the FPBP application only has been received (FPBP App), both the PE and FPBP applications have been received (FPBP/PE), or that the type is not required because the application is for a different program type (N/A).');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	336	,	2	,'Reverse Clearance Indicator','The Reverse Clearance Indicator notifies users whether the clearance is required or not, based on information on the application.  Reverse Clearance is not required is the application if for a program type other than FPBP');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	337	,	3	,'Reverse Clearance Indicator Date','The Reverse Clearance Indicator Date is the date that the indicator value is saved in MAXe.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	338	,	2	,'Reverse Clearance Outcome','The Reverse Cleareance Outcome indicates whether running the clearance provided enough information to move the application forward or not.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	339	,	2	,'Upstate/Downstate Indicator','The Upstate/Downstate Indicator groups FPBP applications based on the residential zip code.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	340	,	3	,'Invoiceable Date','The Invoiceable Date is the date the SDE task is complete. Does not apply to FPBP app type');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	341	,	2	,'HEART Incomplete App Indicator','The HEART Incomplete App Indicator is to inform HEART not to close when there is missing data in MAXe.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	342	,	1	,'Days To Timeout','This field displays the number of calendar days between the system date and the application time out date for all applications with unsatisfied MI and a RFE status of Awaiting MI.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	343	,	2	,'WMS Reason','The WMS Reason provides the application result detail for FPBP applications. The detail includes the acceptance reason or the denial reason');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	344	,	2	,'HEART Reprocess Status','The HEART Reprocess Status is the status in HEART at the time of auto-reprocessing');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (	345	,	3	,'HEART Reprocess Status Date','The HEART Reprocess Status date is the date in HEART the auto-reprocessing was performed');

commit;

-- Patch for BPM_ATTRIBUTE

Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	405	,	331	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'Y');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	406	,	332	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'N');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	407	,	333	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'N');
--Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	408	,	334	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'N');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	409	,	335	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'Y');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	410	,	336	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'N');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	411	,	337	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'N');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	412	,	338	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'N');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	413	,	339	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'N');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	414	,	340	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'Y');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	415	,	341	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'Y');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	416	,	342	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'N');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	417	,	343	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'Y');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	418	,	344	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'Y');
Insert into BPM_ATTRIBUTE (BA_ID, BAL_ID,BEM_ID,WHEN_POPULATED, EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	419	,	345	, 2, 'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'Y');

commit;



