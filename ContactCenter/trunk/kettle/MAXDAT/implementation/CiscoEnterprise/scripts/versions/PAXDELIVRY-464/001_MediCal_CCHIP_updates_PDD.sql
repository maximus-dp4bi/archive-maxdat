alter session set current_schema = cisco_enterprise_cc;

--Campaigns

update cc_c_campaign
set project_name = 'Medi-Cal For Families', Program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California'
where campaign_id in (5128,
5129,
5130,
5131,
5132,
5133,
5134,
5135,
5136,
5137,
5138,
5139,
5140,
5141,
5142,
5143,
5144,
5145,
5146,
5147,
5148,
5149
);

update cc_c_campaign set campaign_desc = 'English Predictive Dialer Non Payment' where campaign_id = 5128;
update cc_c_campaign set campaign_desc = 'Spanish Predictive Dialer Non Payment' where campaign_id = 5129;
update cc_c_campaign set campaign_desc = 'Armenian Predictive Dialer Non Payment' where campaign_id = 5130;
update cc_c_campaign set campaign_desc = 'Cambodian Predictive Dialer Non Payment' where campaign_id = 5131;
update cc_c_campaign set campaign_desc = 'Cantonese Predictive Dialer Non Payment' where campaign_id = 5132;
update cc_c_campaign set campaign_desc = 'Farsi Predictive Dialer Non Payment' where campaign_id = 5133;
update cc_c_campaign set campaign_desc = 'Hmong Predictive Dialer Non Payment' where campaign_id = 5134;
update cc_c_campaign set campaign_desc = 'Korean Predictive Dialer Non Payment' where campaign_id = 5135;
update cc_c_campaign set campaign_desc = 'Laotian Predictive Dialer Non Payment' where campaign_id = 5136;
update cc_c_campaign set campaign_desc = 'Russian Predictive Dialer Non Payment' where campaign_id = 5137;
update cc_c_campaign set campaign_desc = 'Vietnamese Predictive Dialer Non Payment' where campaign_id = 5138;
update cc_c_campaign set campaign_desc = 'English Predictive Dialer Missing Information' where campaign_id = 5139;
update cc_c_campaign set campaign_desc = 'Spanish Predictive Dialer Missing Information' where campaign_id = 5140;
update cc_c_campaign set campaign_desc = 'Armenian Predictive Dialer Missing Information' where campaign_id = 5141;
update cc_c_campaign set campaign_desc = 'Cambodian Predictive Dialer Missing Information' where campaign_id = 5142;
update cc_c_campaign set campaign_desc = 'Cantonese Predictive Dialer Missing Information' where campaign_id = 5143;
update cc_c_campaign set campaign_desc = 'Farsi Predictive Dialer Missing Information' where campaign_id = 5144;
update cc_c_campaign set campaign_desc = 'Hmong Predictive Dialer Missing Information' where campaign_id = 5145;
update cc_c_campaign set campaign_desc = 'Korean Predictive Dialer Missing Information' where campaign_id = 5146;
update cc_c_campaign set campaign_desc = 'Laotian Predictive Dialer Missing Information' where campaign_id = 5147;
update cc_c_campaign set campaign_desc = 'Russian Predictive Dialer Missing Information' where campaign_id = 5148;
update cc_c_campaign set campaign_desc = 'Vietnamese Predictive Dialer Missing Information' where campaign_id = 5149;

commit;

--Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('One Time Payment Transfer','Transfer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Main Predictive Dialer','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('English Predictive Dialer Non Payment','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Spanish Predictive Dialer Non Payment','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Armenian Predictive Dialer Non Payment','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Cambodian Predictive Dialer Non Payment','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Cantonese Predictive Dialer Non Payment','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Farsi Predictive Dialer Non Payment','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Hmong Predictive Dialer Non Payment','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Korean Predictive Dialer Non Payment','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Laotian Predictive Dialer Non Payment','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Russian Predictive Dialer Non Payment','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Vietnamese Predictive Dialer Non Payment','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('English Predictive Dialer Missing Information','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Spanish Predictive Dialer Missing Information','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Armenian Predictive Dialer Missing Information','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Cambodian Predictive Dialer Missing Information','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Cantonese Predictive Dialer Missing Information','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Farsi Predictive Dialer Missing Information','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Hmong Predictive Dialer Missing Information','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Korean Predictive Dialer Missing Information','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Laotian Predictive Dialer Missing Information','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Russian Predictive Dialer Missing Information','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Vietnamese Predictive Dialer Missing Information','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('English Predictive Dialer NP Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('English Predictive Dialer NP Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Spanish Predictive Dialer NP Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Spanish Predictive Dialer NP Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('English Predictive Dialer MI Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('English Predictive Dialer MI Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Spanish Predictive Dialer MI Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Spanish Predictive Dialer MI Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Armenian Predictive Dialer MI Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Armenian Predictive Dialer MI Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Cambodian Predictive Dialer MI Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Cambodian Predictive Dialer MI Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Cantonese Predictive Dialer MI Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Cantonese Predictive Dialer MI Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Farsi Predictive Dialer MI Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Farsi Predictive Dialer MI Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Hmong Predictive Dialer MI Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Hmong Predictive Dialer MI Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Korean Predictive Dialer MI Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Korean Predictive Dialer MI Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Laotian Predictive Dialer MI Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Laotian Predictive Dialer MI Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Russian Predictive Dialer MI Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Russian Predictive Dialer MI Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Vietnamese Predictive Dialer MI Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Vietnamese Predictive Dialer MI Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Armenian Predictive Dialer NP Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Armenian Predictive Dialer NP Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Cambodian Predictive Dialer NP Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Cambodian Predictive Dialer NP Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Cantonese Predictive Dialer NP Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Cantonese Predictive Dialer NP Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Farsi Predictive Dialer NP Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Farsi Predictive Dialer NP Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Hmong Predictive Dialer NP Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Hmong Predictive Dialer NP Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Korean Predictive Dialer NP Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Korean Predictive Dialer NP Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Laotian Predictive Dialer NP Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Laotian Predictive Dialer NP Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Russian Predictive Dialer NP Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Russian Predictive Dialer NP Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Vietnamese Predictive Dialer NP Queue','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Vietnamese Predictive Dialer NP Voicemail','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('One Time Payment Transfer','Transfer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Main Predictive Dialer','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('English Predictive Dialer Non Payment','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Spanish Predictive Dialer Non Payment','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Armenian Predictive Dialer Non Payment','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Cambodian Predictive Dialer Non Payment','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Cantonese Predictive Dialer Non Payment','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Farsi Predictive Dialer Non Payment','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Hmong Predictive Dialer Non Payment','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Korean Predictive Dialer Non Payment','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Laotian Predictive Dialer Non Payment','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Russian Predictive Dialer Non Payment','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Vietnamese Predictive Dialer Non Payment','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('English Predictive Dialer Missing Information','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Spanish Predictive Dialer Missing Information','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Armenian Predictive Dialer Missing Information','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Cambodian Predictive Dialer Missing Information','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Cantonese Predictive Dialer Missing Information','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Farsi Predictive Dialer Missing Information','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Hmong Predictive Dialer Missing Information','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Korean Predictive Dialer Missing Information','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Laotian Predictive Dialer Missing Information','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Russian Predictive Dialer Missing Information','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Vietnamese Predictive Dialer Missing Information','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('English Predictive Dialer NP Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('English Predictive Dialer NP Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Spanish Predictive Dialer NP Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Spanish Predictive Dialer NP Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('English Predictive Dialer MI Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('English Predictive Dialer MI Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Spanish Predictive Dialer MI Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Spanish Predictive Dialer MI Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Armenian Predictive Dialer MI Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Armenian Predictive Dialer MI Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Cambodian Predictive Dialer MI Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Cambodian Predictive Dialer MI Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Cantonese Predictive Dialer MI Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Cantonese Predictive Dialer MI Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Farsi Predictive Dialer MI Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Farsi Predictive Dialer MI Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Hmong Predictive Dialer MI Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Hmong Predictive Dialer MI Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Korean Predictive Dialer MI Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Korean Predictive Dialer MI Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Laotian Predictive Dialer MI Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Laotian Predictive Dialer MI Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Russian Predictive Dialer MI Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Russian Predictive Dialer MI Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Vietnamese Predictive Dialer MI Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Vietnamese Predictive Dialer MI Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Armenian Predictive Dialer NP Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Armenian Predictive Dialer NP Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Cambodian Predictive Dialer NP Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Cambodian Predictive Dialer NP Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Cantonese Predictive Dialer NP Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Cantonese Predictive Dialer NP Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Farsi Predictive Dialer NP Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Farsi Predictive Dialer NP Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Hmong Predictive Dialer NP Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Hmong Predictive Dialer NP Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Korean Predictive Dialer NP Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Korean Predictive Dialer NP Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Laotian Predictive Dialer NP Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Laotian Predictive Dialer NP Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Russian Predictive Dialer NP Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Russian Predictive Dialer NP Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Vietnamese Predictive Dialer NP Queue','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Vietnamese Predictive Dialer NP Voicemail','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
	   
commit;

--Contact Queues

update cc_c_contact_queue
set queue_type = 'Transfer', interval_minutes = 15, project_name = 'Medi-Cal For Families', Program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California' 
where queue_number = 8038;

update cc_c_contact_queue
set queue_type = 'Predictive Dialer', interval_minutes = 15, project_name = 'Medi-Cal For Families', Program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California' 
where queue_number in (8101,
8102,
8103,
8104,
8105,
8106,
8107,
8108,
8109,
8110,
8111,
8112,
8113,
8114,
8115,
8116,
8117,
8118,
8119,
8120,
8121,
8122,
8123,
8124,
8125,
8126,
8127,
8128,
8138,
8139,
8140,
8141,
8143,
8144,
8145,
8146,
8147,
8148,
8149,
8150,
8151,
8152,
8153,
8154,
8155,
8156,
8157,
8158,
8159,
8160,
8161,
8162,
8163,
8164,
8165,
8166,
8167,
8168,
8169,
8170,
8171,
8172,
8173,
8174,
8175,
8176,
8177,
8178
);

update cc_c_contact_queue set unit_of_work_name = 'One Time Payment Transfer' where queue_number = 8038;
update cc_c_contact_queue set unit_of_work_name = 'Main Predictive Dialer' where queue_number = 8101;
update cc_c_contact_queue set unit_of_work_name = 'Main Predictive Dialer' where queue_number = 8102;
update cc_c_contact_queue set unit_of_work_name = 'English Predictive Dialer Non Payment' where queue_number = 8103;
update cc_c_contact_queue set unit_of_work_name = 'Spanish Predictive Dialer Non Payment' where queue_number = 8104;
update cc_c_contact_queue set unit_of_work_name = 'Armenian Predictive Dialer Non Payment' where queue_number = 8105;
update cc_c_contact_queue set unit_of_work_name = 'Cambodian Predictive Dialer Non Payment' where queue_number = 8106;
update cc_c_contact_queue set unit_of_work_name = 'Cantonese Predictive Dialer Non Payment' where queue_number = 8107;
update cc_c_contact_queue set unit_of_work_name = 'Farsi Predictive Dialer Non Payment' where queue_number = 8108;
update cc_c_contact_queue set unit_of_work_name = 'Hmong Predictive Dialer Non Payment' where queue_number = 8109;
update cc_c_contact_queue set unit_of_work_name = 'Korean Predictive Dialer Non Payment' where queue_number = 8110;
update cc_c_contact_queue set unit_of_work_name = 'Laotian Predictive Dialer Non Payment' where queue_number = 8111;
update cc_c_contact_queue set unit_of_work_name = 'Russian Predictive Dialer Non Payment' where queue_number = 8112;
update cc_c_contact_queue set unit_of_work_name = 'Vietnamese Predictive Dialer Non Payment' where queue_number = 8113;
update cc_c_contact_queue set unit_of_work_name = 'English Predictive Dialer Missing Information' where queue_number = 8114;
update cc_c_contact_queue set unit_of_work_name = 'Spanish Predictive Dialer Missing Information' where queue_number = 8115;
update cc_c_contact_queue set unit_of_work_name = 'Armenian Predictive Dialer Missing Information' where queue_number = 8116;
update cc_c_contact_queue set unit_of_work_name = 'Cambodian Predictive Dialer Missing Information' where queue_number = 8117;
update cc_c_contact_queue set unit_of_work_name = 'Cantonese Predictive Dialer Missing Information' where queue_number = 8118;
update cc_c_contact_queue set unit_of_work_name = 'Farsi Predictive Dialer Missing Information' where queue_number = 8119;
update cc_c_contact_queue set unit_of_work_name = 'Hmong Predictive Dialer Missing Information' where queue_number = 8120;
update cc_c_contact_queue set unit_of_work_name = 'Korean Predictive Dialer Missing Information' where queue_number = 8121;
update cc_c_contact_queue set unit_of_work_name = 'Laotian Predictive Dialer Missing Information' where queue_number = 8122;
update cc_c_contact_queue set unit_of_work_name = 'Russian Predictive Dialer Missing Information' where queue_number = 8123;
update cc_c_contact_queue set unit_of_work_name = 'Vietnamese Predictive Dialer Missing Information' where queue_number = 8124;
update cc_c_contact_queue set unit_of_work_name = 'English Predictive Dialer NP Queue' where queue_number = 8125;
update cc_c_contact_queue set unit_of_work_name = 'English Predictive Dialer NP Voicemail' where queue_number = 8126;
update cc_c_contact_queue set unit_of_work_name = 'Spanish Predictive Dialer NP Queue' where queue_number = 8127;
update cc_c_contact_queue set unit_of_work_name = 'Spanish Predictive Dialer NP Voicemail' where queue_number = 8128;
update cc_c_contact_queue set unit_of_work_name = 'English Predictive Dialer MI Queue' where queue_number = 8138;
update cc_c_contact_queue set unit_of_work_name = 'English Predictive Dialer MI Voicemail' where queue_number = 8139;
update cc_c_contact_queue set unit_of_work_name = 'Spanish Predictive Dialer MI Queue' where queue_number = 8140;
update cc_c_contact_queue set unit_of_work_name = 'Spanish Predictive Dialer MI Voicemail' where queue_number = 8141;
update cc_c_contact_queue set unit_of_work_name = 'Armenian Predictive Dialer MI Queue' where queue_number = 8143;
update cc_c_contact_queue set unit_of_work_name = 'Armenian Predictive Dialer MI Voicemail' where queue_number = 8144;
update cc_c_contact_queue set unit_of_work_name = 'Cambodian Predictive Dialer MI Queue' where queue_number = 8145;
update cc_c_contact_queue set unit_of_work_name = 'Cambodian Predictive Dialer MI Voicemail' where queue_number = 8146;
update cc_c_contact_queue set unit_of_work_name = 'Cantonese Predictive Dialer MI Queue' where queue_number = 8147;
update cc_c_contact_queue set unit_of_work_name = 'Cantonese Predictive Dialer MI Voicemail' where queue_number = 8148;
update cc_c_contact_queue set unit_of_work_name = 'Farsi Predictive Dialer MI Queue' where queue_number = 8149;
update cc_c_contact_queue set unit_of_work_name = 'Farsi Predictive Dialer MI Voicemail' where queue_number = 8150;
update cc_c_contact_queue set unit_of_work_name = 'Hmong Predictive Dialer MI Queue' where queue_number = 8151;
update cc_c_contact_queue set unit_of_work_name = 'Hmong Predictive Dialer MI Voicemail' where queue_number = 8152;
update cc_c_contact_queue set unit_of_work_name = 'Korean Predictive Dialer MI Queue' where queue_number = 8153;
update cc_c_contact_queue set unit_of_work_name = 'Korean Predictive Dialer MI Voicemail' where queue_number = 8154;
update cc_c_contact_queue set unit_of_work_name = 'Laotian Predictive Dialer MI Queue' where queue_number = 8155;
update cc_c_contact_queue set unit_of_work_name = 'Laotian Predictive Dialer MI Voicemail' where queue_number = 8156;
update cc_c_contact_queue set unit_of_work_name = 'Russian Predictive Dialer MI Queue' where queue_number = 8157;
update cc_c_contact_queue set unit_of_work_name = 'Russian Predictive Dialer MI Voicemail' where queue_number = 8158;
update cc_c_contact_queue set unit_of_work_name = 'Vietnamese Predictive Dialer MI Queue' where queue_number = 8159;
update cc_c_contact_queue set unit_of_work_name = 'Vietnamese Predictive Dialer MI Voicemail' where queue_number = 8160;
update cc_c_contact_queue set unit_of_work_name = 'Armenian Predictive Dialer NP Queue' where queue_number = 8161;
update cc_c_contact_queue set unit_of_work_name = 'Armenian Predictive Dialer NP Voicemail' where queue_number = 8162;
update cc_c_contact_queue set unit_of_work_name = 'Cambodian Predictive Dialer NP Queue' where queue_number = 8163;
update cc_c_contact_queue set unit_of_work_name = 'Cambodian Predictive Dialer NP Voicemail' where queue_number = 8164;
update cc_c_contact_queue set unit_of_work_name = 'Cantonese Predictive Dialer NP Queue' where queue_number = 8165;
update cc_c_contact_queue set unit_of_work_name = 'Cantonese Predictive Dialer NP Voicemail' where queue_number = 8166;
update cc_c_contact_queue set unit_of_work_name = 'Farsi Predictive Dialer NP Queue' where queue_number = 8167;
update cc_c_contact_queue set unit_of_work_name = 'Farsi Predictive Dialer NP Voicemail' where queue_number = 8168;
update cc_c_contact_queue set unit_of_work_name = 'Hmong Predictive Dialer NP Queue' where queue_number = 8169;
update cc_c_contact_queue set unit_of_work_name = 'Hmong Predictive Dialer NP Voicemail' where queue_number = 8170;
update cc_c_contact_queue set unit_of_work_name = 'Korean Predictive Dialer NP Queue' where queue_number = 8171;
update cc_c_contact_queue set unit_of_work_name = 'Korean Predictive Dialer NP Voicemail' where queue_number = 8172;
update cc_c_contact_queue set unit_of_work_name = 'Laotian Predictive Dialer NP Queue' where queue_number = 8173;
update cc_c_contact_queue set unit_of_work_name = 'Laotian Predictive Dialer NP Voicemail' where queue_number = 8174;
update cc_c_contact_queue set unit_of_work_name = 'Russian Predictive Dialer NP Queue' where queue_number = 8175;
update cc_c_contact_queue set unit_of_work_name = 'Russian Predictive Dialer NP Voicemail' where queue_number = 8176;
update cc_c_contact_queue set unit_of_work_name = 'Vietnamese Predictive Dialer NP Queue' where queue_number = 8177;
update cc_c_contact_queue set unit_of_work_name = 'Vietnamese Predictive Dialer NP Voicemail' where queue_number = 8178;

commit;

-- Agent Routing groups

update cc_c_agent_rtg_grp
set project_name = 'Medi-Cal For Families', Program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California'
where agent_routing_Group_number in (20366,
20367,
20368,
20369,
20370,
20371,
20372,
20373,
20374,
20375,
20376,
20492,
20493,
20494,
20495,
20496,
20497,
20498,
20499,
20500,
20501,
20502
);

insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20366);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20367);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20368);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20369);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20370);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20371);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20372);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20373);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20374);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20375);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20376);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20492);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20493);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20494);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20495);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20496);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20497);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20498);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20499);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20500);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20501);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 20502);

commit;