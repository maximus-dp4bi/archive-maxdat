select * from maxdat.pp_bo_event_target_lkup where event_id = 1180;

update maxdat.pp_bo_event_target_lkup set end_date = to_date('20180331','yyyymmdd')
where event_id = 1180 and start_date = to_date('20160101','yyyymmdd');

insert into MAXDAT.PP_BO_EVENT_TARGET_LKUP
(
    EVENT_ID, NAME, TARGET, 
    SCORECARD_FLAG, START_DATE, END_DATE, 
    CREATE_BY, CREATE_DATETIME, SCORECARD_GROUP, 
    EE_ADHERENCE, OPS_GROUP, WORKSUBACTIVITY_FLAG, 
    QC_FLAG, EE_ADHERENCE_V2
)
values(
1180,    						-- EVENT_ID, 
'Mailroom',						-- NAME, 
0,								-- TARGET, 
'N',    						-- SCORECARD_FLAG, 
to_date('20180401','yyyymmdd'),	-- START_DATE, 
to_date(null),					-- END_DATE, 
'NYHIX-44092',    				-- CREATE_BY, 
sysdate,						-- CREATE_DATETIME, 
'NON-PRODUCTIVE', 				-- SCORECARD_GROUP, 
'N',    						-- EE_ADHERENCE, 
'NOT IN SCORECARD',				-- OPS_GROUP, 
'N',							-- WORKSUBACTIVITY_FLAG, 
'N',    						-- QC_FLAG, 
'Y'								-- EE_ADHERENCE_V2
);

commit;

select * from maxdat.pp_bo_event_target_lkup where event_id = 1180;
