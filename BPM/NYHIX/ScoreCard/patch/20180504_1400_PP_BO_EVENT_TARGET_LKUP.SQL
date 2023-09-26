update maxdat.PP_BO_EVENT_TARGET_LKUP
set end_date = to_date('20180430','yyyymmdd')
where event_id = 1070
and end_date is null;

insert into maxdat.PP_BO_EVENT_TARGET_LKUP
(	
	EVENT_ID, 
	NAME, 
	TARGET, 
	SCORECARD_FLAG, 
	START_DATE, 
	END_DATE, 
	CREATE_BY, 
	CREATE_DATETIME, 
	SCORECARD_GROUP, 
	EE_ADHERENCE, 
	OPS_GROUP, 
	WORKSUBACTIVITY_FLAG, 
	QC_FLAG
	)
 VALUES(
1070,								--EVENT_ID, 
'E-Chat',              				--NAME, 
0,                   				--TARGET, 
'N',                  				--SCORECARD_FLAG, 
TO_DATE('05/01/2018','MM/DD/YYYY'),	--START_DATE, 
TO_DATE(NULL),                		--END_DATE, 
'CR 1937',                   		--CREATE_BY, 
SYSDATE,                   			--CREATE_DATETIME, 
'UNUSED_BY_EE',        				--SCORECARD_GROUP, 
'Y',                   				--EE_ADHERENCE, 
'Webchat',             				--OPS_GROUP, 
'N',                   				--WORKSUBACTIVITY_FLAG, 
'N'                   				--QC_FLAG 
);

Commit;  

