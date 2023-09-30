-- cc_c_unit_of_work and cc_d_unit_of_work

alter table cc_c_unit_of_work add (UNIT_OF_WORK_CATEGORY varchar2(25));

alter table cc_d_unit_of_work add (UNIT_OF_WORK_CATEGORY varchar2(25));

update cc_c_unit_of_work set UNIT_OF_WORK_CATEGORY = 'CALL' where UNIT_OF_WORK_NAME = 'HILanguage';
update cc_c_unit_of_work set UNIT_OF_WORK_CATEGORY = 'CALL' where UNIT_OF_WORK_NAME = 'OtherLanguage';
update cc_c_unit_of_work set UNIT_OF_WORK_CATEGORY = 'CALL' where UNIT_OF_WORK_NAME = 'EngLanguage';
update cc_c_unit_of_work set UNIT_OF_WORK_CATEGORY = 'CALL' where UNIT_OF_WORK_NAME = 'Individual';
update cc_c_unit_of_work set UNIT_OF_WORK_CATEGORY = 'CALL' where UNIT_OF_WORK_NAME = 'SHOP';
update cc_c_unit_of_work set UNIT_OF_WORK_CATEGORY = 'WEB CHAT' where UNIT_OF_WORK_NAME = 'WebChat';
update cc_c_unit_of_work set UNIT_OF_WORK_CATEGORY = 'Unknown' where UNIT_OF_WORK_NAME = 'Unknown';
update cc_c_unit_of_work set UNIT_OF_WORK_CATEGORY = 'IVR' where UNIT_OF_WORK_NAME = 'IVR';
update cc_c_unit_of_work set UNIT_OF_WORK_CATEGORY = 'CALL' where UNIT_OF_WORK_NAME = 'Kokua';
update cc_c_unit_of_work set UNIT_OF_WORK_CATEGORY = 'VOICE MAIL' where UNIT_OF_WORK_NAME = 'Voice Mail';
update cc_c_unit_of_work set UNIT_OF_WORK_CATEGORY = 'WEB CHAT' where UNIT_OF_WORK_NAME = 'WebChat Kokua';


update cc_d_unit_of_work set UNIT_OF_WORK_CATEGORY = 'CALL' where UNIT_OF_WORK_NAME = 'Kokua';
update cc_d_unit_of_work set UNIT_OF_WORK_CATEGORY = 'VOICE MAIL' where UNIT_OF_WORK_NAME = 'Voice Mail';
update cc_d_unit_of_work set UNIT_OF_WORK_CATEGORY = 'WEB CHAT' where UNIT_OF_WORK_NAME = 'WebChat Kokua';
update cc_d_unit_of_work set UNIT_OF_WORK_CATEGORY = 'Unknown' where UNIT_OF_WORK_NAME = 'Unknown';
update cc_d_unit_of_work set UNIT_OF_WORK_CATEGORY = 'CALL' where UNIT_OF_WORK_NAME = 'HILanguage';
update cc_d_unit_of_work set UNIT_OF_WORK_CATEGORY = 'CALL' where UNIT_OF_WORK_NAME = 'OtherLanguage';
update cc_d_unit_of_work set UNIT_OF_WORK_CATEGORY = 'CALL' where UNIT_OF_WORK_NAME = 'EngLanguage';
update cc_d_unit_of_work set UNIT_OF_WORK_CATEGORY = 'CALL' where UNIT_OF_WORK_NAME = 'Individual';
update cc_d_unit_of_work set UNIT_OF_WORK_CATEGORY = 'CALL' where UNIT_OF_WORK_NAME = 'SHOP';
update cc_d_unit_of_work set UNIT_OF_WORK_CATEGORY = 'WEB CHAT' where UNIT_OF_WORK_NAME = 'WebChat';
update cc_d_unit_of_work set UNIT_OF_WORK_CATEGORY = 'IVR' where UNIT_OF_WORK_NAME = 'IVR';

commit;