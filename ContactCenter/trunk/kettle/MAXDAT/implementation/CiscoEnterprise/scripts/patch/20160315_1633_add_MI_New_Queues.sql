/* Adding new queue as per MAXDAT-3321 */

alter session set current_schema = CISCO_ENTERPRISE_CC;

update cc_c_filter
set filter_type = 'ACD_CALL_TYPE_ID_INC'
where value = 5281;

commit;

Insert into CC_C_CONTACT_QUEUE (QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,UNIT_OF_WORK_NAME,PROJECT_NAME,PROGRAM_NAME,REGION_NAME,STATE_NAME,PROVINCE_NAME,DISTRICT_NAME,COUNTRY_NAME,RECORD_EFF_DT,RECORD_END_DT,INTERVAL_MINUTES) 
values (5281,'MIEL_MIEB_5610_AFTR','Voicemail',80,30,'Beneficiary Helpline','MIEB','MIEB','Central','Michigan','Unknown','Unknown','USA',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),15);

commit;
