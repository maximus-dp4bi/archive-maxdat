alter session set current_schema = cisco_enterprise_cc;


-- CC_C_UNIT_OF_WORK

insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,UNIT_OF_WORK_CATEGORY,ACD,IVR,RECORD_EFF_DT, RECORD_END_DT)
values ('Question 1',	'IVR SURVEY',	0,	1, to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));

insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,UNIT_OF_WORK_CATEGORY,ACD,IVR,RECORD_EFF_DT, RECORD_END_DT)
values ('1 - Strongly Agree',	'IVR SURVEY',	0,	1, to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));

insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,UNIT_OF_WORK_CATEGORY,ACD,IVR,RECORD_EFF_DT, RECORD_END_DT)
values ('2 - Agree',	'IVR SURVEY',	0,	1,to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,UNIT_OF_WORK_CATEGORY,ACD,IVR,RECORD_EFF_DT, RECORD_END_DT)
values ('3 - Neutral', 'IVR SURVEY',	0,	1,to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,UNIT_OF_WORK_CATEGORY,ACD,IVR,RECORD_EFF_DT, RECORD_END_DT)
values ('4 - Disagree',	'IVR SURVEY',	0,	1,to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,UNIT_OF_WORK_CATEGORY,ACD,IVR,RECORD_EFF_DT, RECORD_END_DT)
values ('5 - Strongly Disagree', 'IVR SURVEY',	0,	1,to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,UNIT_OF_WORK_CATEGORY,ACD,IVR,RECORD_EFF_DT, RECORD_END_DT)
values ('Question 2',	'IVR SURVEY',	0,	1,to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,UNIT_OF_WORK_CATEGORY,ACD,IVR,RECORD_EFF_DT, RECORD_END_DT)
values ('Question 3',	'IVR SURVEY',	0,	1,to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,UNIT_OF_WORK_CATEGORY,ACD,IVR,RECORD_EFF_DT, RECORD_END_DT)
values ('Question 4',	'IVR SURVEY',	0,	1,to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,UNIT_OF_WORK_CATEGORY,ACD,IVR,RECORD_EFF_DT, RECORD_END_DT)
values ('Question 5','IVR SURVEY',	0,	1,to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,UNIT_OF_WORK_CATEGORY,ACD,IVR,RECORD_EFF_DT, RECORD_END_DT)
values ('Question 6','IVR SURVEY',	0,	1,to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,UNIT_OF_WORK_CATEGORY,ACD,IVR,RECORD_EFF_DT, RECORD_END_DT)
values ('Survey End',	'IVR SURVEY',	0,	1,to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,UNIT_OF_WORK_CATEGORY,ACD,IVR,RECORD_EFF_DT, RECORD_END_DT)
values ('English FAQ', 'IVR FAQ',	0,	1,to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,UNIT_OF_WORK_CATEGORY,ACD,IVR,RECORD_EFF_DT, RECORD_END_DT)
values ('Spanish FAQ','IVR FAQ',	0,	1,to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

-- CC_D_UNIT_OF_WORK

insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY,ACD,IVR)
values ('Question 1',	1,	'N',	'Seconds',	'IVR SURVEY',0,1);

insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY,ACD,IVR)
values ('1 - Strongly Agree',	1,	'N',	'Seconds',	'IVR SURVEY',0,1);

insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY,ACD,IVR)
values ('2 - Agree',	1,	'N',	'Seconds',	'IVR SURVEY',0,1);

insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY,ACD,IVR)
values ('3 - Neutral',	1,	'N',	'Seconds',	'IVR SURVEY',0,1);

insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY,ACD,IVR)
values ('4 - Disagree',	1,	'N',	'Seconds',	'IVR SURVEY',0,1);

insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY,ACD,IVR)
values ('5 - Strongly Disagree',	1,	'N',	'Seconds',	'IVR SURVEY',0,1);

insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY,ACD,IVR)
values ('Question 2',	1,	'N',	'Seconds',	'IVR SURVEY',0,1);

insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY,ACD,IVR)
values ('Question 3',	1,	'N',	'Seconds',	'IVR SURVEY',0,1);

insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY,ACD,IVR)
values ('Question 4',	1,	'N',	'Seconds',	'IVR SURVEY',0,1);

insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY,ACD,IVR)
values ('Question 5',	1,	'N',	'Seconds',	'IVR SURVEY',0,1);

insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY,ACD,IVR)
values ('Question 6',	1,	'N',	'Seconds',	'IVR SURVEY',0,1);

insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY,ACD,IVR)
values ('Survey End',	1,	'N',	'Seconds',	'IVR SURVEY',0,1);

insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY,ACD,IVR)
values ('English FAQ',	1,	'N',	'Seconds',	'IVR FAQ',0,1);

insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY,ACD,IVR)
values ('Spanish FAQ',	1,	'N',	'Seconds',	'IVR FAQ',0,1);

COMMIT;

