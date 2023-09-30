-----------------------------
-- IN MAXDAT SCHEMA
-----------------------------

alter table maxdat.PP_BO_EVENT_TARGET_LKUP
add QC_FLAG varchar2(1);

update maxdat.PP_BO_EVENT_TARGET_LKUP
set QC_FLAG = 'N';

commit;

-- insert the new event 1522

INSERT INTO maxdat.PP_BO_EVENT_TARGET_LKUP(
EVENT_ID,NAME,TARGET,SCORECARD_FLAG,START_DATE,
END_DATE,CREATE_BY,CREATE_DATETIME,SCORECARD_GROUP,
EE_ADHERENCE,OPS_GROUP,WORKSUBACTIVITY_FLAG,QC_FLAG
)
values(
1522,										--EVENT_ID,
'QC- Web Chat',	    						--NAME,
15,		            						--TARGET,
'Y',				    					--SCORECARD_FLAG,
to_date('01/01/2018','mm/dd/yyyy'), 		--START_DATE,			
null,                						--END_DATE,
'script',			    					--CREATE_BY,
sysdate,			    					--CREATE_DATETIME,
'Web Chat',		    						--SCORECARD_GROUP,
'Y',				    					--EE_ADHERENCE,
'QC Team',		        					--OPS_GROUP,
'Y',										--WORKSUBACTIVITY_FLAG,	
'Y'                   						--QC_FLAG
);
 
commit;

update maxdat.PP_BO_EVENT_TARGET_LKUP
set QC_FLAG = 'Y', WORKSUBACTIVITY_FLAG = 'Y' 
where event_id in 
(1490, 1491, 1492, 1493, 1494, 1495, 1496, 1497, 
1498, 1499, 1500, 1501, 1502, 1503, 1522);

COMMIT;


