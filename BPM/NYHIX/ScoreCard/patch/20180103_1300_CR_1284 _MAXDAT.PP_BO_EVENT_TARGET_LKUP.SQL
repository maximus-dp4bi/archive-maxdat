-- CR 1284 - MAXDAT.PP_BO_EVENT_TARGET_LKUP
insert into MAXDAT.PP_BO_EVENT_TARGET_LKUP(
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
WORKSUBACTIVITY_FLAG
)
VALUES (
1525, 						-- EVENT_ID 	
'Undeliverable RM Scan', 	-- NAME	
27, 						-- TARGET	
'Y', 						-- SCORECARD_FLAG	
to_date('1-Dec-2017','dd-mon-yyyy'), -- START_DATE
null, 						-- END_DATE, 
'CR 1284 script',			--	CREATE_BY, 
sysdate, 					-- CREATE_DATETIME,				
'Undeliverable RM Scan', 	-- SCORECARD_GROUP	
'Y', 						--	EE_ADHERENCE
'Mailroom', 				-- OPS_GROUP	
'N'  						-- WORKSUBACTIVITY_FLAG
);

commit;
