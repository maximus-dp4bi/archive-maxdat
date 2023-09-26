
select * from cc_c_ivr_menu_group
where ivr_menu_name = 'MDHIX_ENT_NEW_18'
and ivr_sub_menu_name in 
(
'FLG_CARRIER_CareFirst'
, 'FLG_CARRIER_Kaiser'
, 'FLG_SHOP_MENU'
);


update cc_c_ivr_menu_group
set project_name = 'MD HBE'
, program_name = 'CSC'
where ivr_menu_name = 'MDHIX_ENT_NEW_18'
and ivr_sub_menu_name in 
(
'FLG_CARRIER_CareFirst'
, 'FLG_CARRIER_Kaiser'
, 'FLG_SHOP_MENU'
);

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'FLG_CARRIER_CareFirst'
where ivr_menu_name = 'MDHIX_ENT_NEW_18'
and ivr_sub_menu_name = 'FLG_CARRIER_CareFirst';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'FLG_CARRIER_Kaiser'
where ivr_menu_name = 'MDHIX_ENT_NEW_18'
and ivr_sub_menu_name = 'FLG_CARRIER_Kaiser';

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'FLG_SHOP_MENU'
where ivr_menu_name = 'MDHIX_ENT_NEW_18'
and ivr_sub_menu_name = 'FLG_SHOP_MENU';


commit;

select count(*) from cc_f_ivr_menu_group_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d_month = 'Feb'


delete from cc_f_ivr_menu_group_date
where f_ivr_menu_group_id in (select f_ivr_menu_group_id from cc_f_ivr_menu_group_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d_month = 'Feb');

select distinct d_date from cc_f_ivr_menu_group_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
order by d_date desc;

commit;

delete from cc_s_ivr_menu_group_date
where ivr_menu_group_id in (select ivr_menu_group_id from cc_s_ivr_menu_group_date 
where call_date between '01-FEB-18' and '08-FEB-18');

select distinct call_date from cc_s_ivr_menu_group_date f, cc_d_dates d
order by call_date desc;

commit;




insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_ivr_menu_group','2018-02-01 00:00:00','2018-02-02 00:00:00',1, 'CISCO', 'NA');

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_ivr_menu_group','2018-02-02 00:00:00','2018-02-03 00:00:00',1, 'CISCO', 'NA');

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_ivr_menu_group','2018-02-03 00:00:00','2018-02-04 00:00:00',1, 'CISCO', 'NA');

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_ivr_menu_group','2018-02-04 00:00:00','2018-02-05 00:00:00',1, 'CISCO', 'NA');

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_ivr_menu_group','2018-02-05 00:00:00','2018-02-06 00:00:00',1, 'CISCO', 'NA');

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_ivr_menu_group','2018-02-06 00:00:00','2018-02-07 00:00:00',1, 'CISCO', 'NA');

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_ivr_menu_group','2018-02-07 00:00:00','2018-02-08 00:00:00',1, 'CISCO', 'NA');

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_ivr_menu_group','2018-02-08 00:00:00','2018-02-09 00:00:00',1, 'CISCO', 'NA');

commit;