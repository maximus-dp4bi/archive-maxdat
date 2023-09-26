update cc_c_contact_queue
set queue_type = 'Unknown'
, unit_of_work_name = 'Unknown'
, project_name = 'Unknown'
, program_name = 'Unknown'
, region_name = 'Unknown'
, state_name = 'Uknown'
, province_name = 'Unknown'
, district_name = 'Unknown'
where queue_number in
(
 5338
,5343
,5345
,5347
,5348
,5349
,5350
,5351
,5352
,5353
,5354
,5358
,5365
,5369
,5371
,5372
,5373
,5374
,5375
,5376
,5377
,5378
,5379
,5380
,5381
,5426
,5427
);

commit;

Insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,RECORD_EFF_DT,RECORD_END_DT,UNIT_OF_WORK_CATEGORY) values ('Main IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),'CONTACTS_CREATED');

Insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY) values ('Main IVR',1,'N','Seconds','CONTACTS_CREATED');

commit;

update cc_c_contact_queue
set queue_type = 'After Hours', unit_of_work_name = 'VOICEMAIL'
where queue_number in (5335, 5362);

update cc_c_contact_queue
set queue_type = 'Voicemail from IVR'
where queue_number in (5336,5337,5346,5355,5363,5364);

update cc_c_contact_queue
set queue_type = 'Voicemail from Queue'
where queue_number in (5356,5357,5382,5383);

update cc_c_contact_queue
set unit_of_work_name = 'FAMILY MEDICAL'
where queue_number in (5356, 5382);

update cc_c_contact_queue
set unit_of_work_name = 'E'||'&'||'D'
where queue_number in (5357, 5383);

update cc_c_contact_queue
set queue_type = 'Main IVR', unit_of_work_name = 'Main IVR'
where queue_number = 5398;

update cc_c_contact_queue
set queue_type = 'Escalation', unit_of_work_name = 'Escalation'
where queue_number in (5342, 5368);

update cc_c_contact_queue
set queue_type = 'Transfer'
where queue_number = 5359;

update cc_c_contact_queue
set unit_of_work_name = 'FAMILY MEDICAL'
where queue_number = 5361;

update cc_c_contact_queue
set unit_of_work_name = 'FAMILY MEDICAL - SPA'
where queue_number = 5385;

update cc_c_contact_queue
set unit_of_work_name = 'E'||'&'||'D - SPA'
where queue_number = 5384;

update cc_c_contact_queue
set queue_name = 'MNSP_FIDM_0200_SM1'
where queue_number = 5334;

commit;

