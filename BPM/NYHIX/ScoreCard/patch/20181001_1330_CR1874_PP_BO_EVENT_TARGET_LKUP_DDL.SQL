###################################################
# Insert statement into Event target lookup table. 
###################################################

insert into maxdat.PP_BO_EVENT_TARGET_LKUP
( EVENT_ID,NAME,TARGET,SCORECARD_FLAG,START_DATE,END_DATE,CREATE_BY,CREATE_DATETIME,SCORECARD_GROUP,EE_ADHERENCE,OPS_GROUP,WORKSUBACTIVITY_FLAG,QC_FLAG,EE_ADHERENCE_V2)
values ( 1559,'MENTOR',0,'N',to_date('05/01/2018','mm/dd/yyyy'),NULL,'CR1874',sysdate,'MENTOR','N','MULTIPLE','N','N','Y');

commit;