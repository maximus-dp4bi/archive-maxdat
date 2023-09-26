--CVIU Intake cleanup
DELETE FROM coverva_dmas.cviu_intake_data_full_load
WHERE filename IN('CVIU_Intake_20221125','CVIU_Intake_20221118');

DELETE FROM coverva_dmas.dmas_file_log
WHERE filename IN('CVIU_INTAKE_20221125','CVIU_INTAKE_20221118');

--Daily Inventory cleanup
create table coverva_dmas.dmas_app_current_dups as
select tracking_number
from(
select regexp_replace(tracking_number,'[^A-Za-z0-9 ]','') tracking_number,count(*)
from coverva_dmas.dmas_application_current
group by regexp_replace(tracking_number,'[^A-Za-z0-9 ]','')
having count(*) > 1  );

create table coverva_dmas.dmas_application_dups_bak
as 
select * from coverva_dmas.dmas_application da
  where cast(fp_create_dt as date) >= cast('11/21/2022' as date)
  and tracking_number in(select tracking_number from coverva_dmas.dmas_application_current d
where exists(select 1 from coverva_dmas.dmas_application_current e where regexp_replace(d.tracking_number,'[^A-Za-z0-9 ]','') = e.tracking_number and d.dmas_application_current_id > e.dmas_application_current_id));

insert into coverva_dmas.dmas_application_dups_bak
select * from coverva_dmas.dmas_application
where dmas_application_id in(66943770,66944441,66943771,66944468,66944049,66943958,66914942,66944044,66914910,66943441,66914535,66943817,66915098,66886031,66943473,66914746,66885861,
                            66943590,66914756,66885590,66944462,66914992,66886050,66943630,66914544,66886127,66943608,66915103,66886061,66886061,66943846,66915042,66886243,66944867,
                            66916038,66886729,66914958,66886371,66943862,66915158,66885901,66857562,66721501,66943678,66915265,66885851,66857443,66722057,66943924,66914654,66885784,
                            66858496,66721955,66943341,66914569,66885938,66857592,66722129,66694324,66943969,66915249,66885738,66857987,66721372,66694664,66666833,66944034,66914752,
                            66886402,66857707,66721894,66694903,66666329,66943872);
                            
delete from coverva_dmas.dmas_application
where dmas_application_id in(66943872);

create table coverva_dmas.dmas_application_current_dups_bak
as
select * from coverva_dmas.dmas_application_current d
where exists(select 1 from coverva_dmas.dmas_application_current e where regexp_replace(d.tracking_number,'[^A-Za-z0-9 ]','') = e.tracking_number and d.dmas_application_current_id > e.dmas_application_current_id);

insert into coverva_dmas.dmas_application_current_dups_bak
select * from coverva_dmas.dmas_application_current
where dmas_application_current_id in(1444496,1444645,1445488,1445998,1445982,1446193,1448530,1448346,1448428,1448356,1448279,1448541,
                                     1448614,1448288,1448506,1449217,1449130,1449182,1450022,1449859,1449953,1449961,1449861);

create table coverva_dmas.dmas_application_event_dups_bak
as
select * from coverva_dmas.dmas_application_event 
where cast(event_date as date) >= cast('11/21/2022' as date)
and tracking_number in(SELECT tracking_number FROM coverva_dmas.dmas_app_current_dups);

select * from coverva_dmas.dmas_app_current_dups;
select * from coverva_dmas.dmas_application_dups_bak;
select * from coverva_dmas.dmas_application_current_dups_bak;
select * from coverva_dmas.dmas_application_event_dups_bak;

update coverva_dmas.cviu_data_full_load 
set tracking_number =  regexp_replace(tracking_number,'[^A-Za-z0-9 ]','');

update coverva_dmas.cpu_incarcerated_full_load 
set tracking_number =  regexp_replace(tracking_number,'[^A-Za-z0-9 ]','');

delete from coverva_dmas.dmas_application_event 
where cast(event_date as date) >= cast('11/21/2022' as date)
and tracking_number in(SELECT tracking_number FROM coverva_dmas.dmas_app_current_dups);

delete from coverva_dmas.dmas_application da
  where cast(fp_create_dt as date) >= cast('11/21/2022' as date)
  and tracking_number in(select tracking_number from coverva_dmas.dmas_application_current d
where exists(select 1 from coverva_dmas.dmas_application_current e where regexp_replace(d.tracking_number,'[^A-Za-z0-9 ]','') = e.tracking_number and d.dmas_application_current_id > e.dmas_application_current_id));

delete from coverva_dmas.dmas_application
where dmas_application_id in(66943770,66944441,66943771,66944468,66944049,66943958,66914942,66944044,66914910,66943441,66914535,66943817,66915098,66886031,66943473,66914746,66885861,
                            66943590,66914756,66885590,66944462,66914992,66886050,66943630,66914544,66886127,66943608,66915103,66886061,66886061,66943846,66915042,66886243,66944867,
                            66916038,66886729,66914958,66886371,66943862,66915158,66885901,66857562,66721501,66943678,66915265,66885851,66857443,66722057,66943924,66914654,66885784,
                            66858496,66721955,66943341,66914569,66885938,66857592,66722129,66694324,66943969,66915249,66885738,66857987,66721372,66694664,66666833,66944034,66914752,
                            66886402,66857707,66721894,66694903,66666329,66943872);
                            
delete from coverva_dmas.dmas_application_current d
where exists(select 1 from coverva_dmas.dmas_application_current e where regexp_replace(d.tracking_number,'[^A-Za-z0-9 ]','') = e.tracking_number and d.dmas_application_current_id > e.dmas_application_current_id);

delete from coverva_dmas.dmas_application_current
where dmas_application_current_id in(1444496,1444645,1445488,1445998,1445982,1446193,1448530,1448346,1448428,1448356,1448279,1448541,
                                     1448614,1448288,1448506,1449217,1449130,1449182,1450022,1449859,1449953,1449961,1449861);

INSERT INTO coverva_dmas.dmas_application_event(tracking_number,event_date,in_app_metric,in_app_metric_pw,in_ppit,in_cm043,in_cm044,in_cviu,in_cpu_incarcerated, 
                           in_cpu,cpu_status,cpu_app_received_date,cpu_worker,cm044_status,cm044_authorized_date,override_status,cviu_processing_status,cpui_processing_status,pending_due_vcl_pw, 
                           pending_due_vcl_am,ppit_worker,cpui_worker,cviu_worker,am_worker,pw_worker,in_app_override,cm044_worker,vcl_due_date_am,vcl_due_date_pw,override_last_employee,
                           override_app_end_date,cm043_status,prev_current_state,prev_app_end_date,running_cpu_status,running_cpu_app_received_date, 
                           cp_inv_action_taken,cp_inv_ldss_create_date,cp_inv_ldss_status_date,cp_inv_ldss_end_date,cp_inv_ldss_worker, 
                           cp_iar_action_taken,cp_iar_ldss_created_on,cp_iar_ldss_end_date,               
                           cp_inv_ad_disposition,cp_inv_ad_create_date,cp_inv_ad_status_date,cp_inv_ad_complete_date,cp_inv_ad_worker, 
                           cp_iar_ad_disposition,cp_iar_ad_created_on,cp_iar_ad_status_date, 
                           cp_inv_pend_disposition,cp_inv_pend_create_date,cp_inv_pend_status_date,cp_inv_pend_complete_date,cp_inv_pend_worker, 
                           cp_iar_pend_disposition,cp_iar_pend_created_on,cp_iar_pend_status_date, 
                           manual_cpu_status,mcpu_activity_date,mcpu_last_employee, 
                           manual_cviu_status,mcviu_activity_date, 
                           manual_prod_status,mpt_orig_status,mpt_complete_date,mpt_last_employee,event_create_date,event_update_date, 
                           running_cpu_worker,running_cpu_file_date,mpt_vcl_due_date,cp_vcl_due_date,iar_vcl_due_date, 
                           running_am_worker,running_ppit_worker,running_cviu_worker,running_cviu_status, 
                           running_cpui_worker,running_cpui_status,in_running_am,in_running_ppit,in_running_pw, 
                           in_running_cm043,in_running_cviu,in_running_cpui,in_running_cpu, 
                           mio_prod_status,mio_orig_status,mio_complete_date ,mio_last_employee,mio_vcl_due_date)            
            SELECT tracking_number,event_date,in_app_metric,in_app_metric_pw,in_ppit,in_cm043,in_cm044,in_cviu,in_cpui, 
                           in_cpu,cpu_status,cpu_app_received_date,cpu_worker, 
                           cm044_status,cm044_authorized_date,override_current_state,cviu_processing_status,cpui_processing_status,pending_due_vcl_pw, 
                           pending_due_vcl_am,ppit_worker_id,cpui_worker,cviu_worker,worker_id am_worker,pw_worker,in_override, 
                           cm044_worker,vcl_due_date_am,vcl_due_date_pw,override_last_employee, 
                           override_app_end_date,processing_status cm043_status,prev_current_state,prev_end_date,running_cpu_status,running_cpu_app_received_date,  
                           cp_inv_action_taken,cp_inv_ldss_create_date,cp_inv_ldss_status_date,cp_inv_ldss_end_date,cp_inv_ldss_worker, 
                           cp_iar_action_taken,cp_iar_ldss_created_on,cp_iar_ldss_end_date,                
                           cp_inv_ad_disposition,cp_inv_ad_create_date,cp_inv_ad_status_date,cp_inv_ad_complete_date,cp_inv_ad_worker, 
                           cp_iar_ad_disposition,cp_iar_ad_created_on,cp_iar_ad_status_date, 
                           cp_inv_pend_disposition,cp_inv_pend_create_date,cp_inv_pend_status_date,cp_inv_pend_complete_date,cp_inv_pend_worker, 
                           cp_iar_pend_disposition,cp_iar_pend_created_on,cp_iar_pend_status_date, 
                           manual_cpu_status,mcpu_activity_date,mcpu_last_employee, 
                           manual_cviu_status,mcviu_activity_date, 
                           manual_prod_status,mpt_orig_status,mpt_complete_date,mpt_last_employee,current_timestamp(),current_timestamp(), 
                           running_cpu_worker,running_cpu_file_date,mpt_vcl_due_date,cp_vcl_due_date,iar_vcl_due_date, 
                           running_am_worker,running_ppit_worker,running_cviu_worker,running_cviu_status, 
                           running_cpui_worker,running_cpui_status,in_running_am,in_running_ppit,in_running_pw, 
                           in_running_cm043,in_running_cviu,in_running_cpui,in_running_cpu, 
                           mio_prod_status,mio_orig_status,mio_complete_date ,mio_last_employee,mio_vcl_due_date 
            FROM coverva_dmas.dmas_raw_application_event_vw v 
            WHERE event_date >= cast('11/21/2022' as date)        
            AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_event e WHERE e.tracking_number = v.tracking_number AND e.event_date = v.event_date)
            AND v.tracking_number IN(SELECT tracking_number FROM coverva_dmas.dmas_app_current_dups);

delete from coverva_dmas.dmas_application
where tracking_number in('T25566572',                         
'T25557062',
'T25536746',
'T25556665',
'T25576885',
'T25551878',
'T25557300',
'T25535359',
'T25554898',
'T25584085',
'T25556436',
'T25577627',
'T25554797',
'T25556477',
'T25573171',
'T25555752',
'T25555055',
'T25555946',
'T25584698',
'T25557168')
and cast(fp_create_dt as date) = current_date()
and file_id = 9675;

delete from coverva_dmas.dmas_application_current
where tracking_number in('T25566572',                         
'T25557062',
'T25536746',
'T25556665',
'T25576885',
'T25551878',
'T25557300',
'T25535359',
'T25554898',
'T25584085',
'T25556436',
'T25577627',
'T25554797',
'T25556477',
'T25573171',
'T25555752',
'T25555055',
'T25555946',
'T25584698',
'T25557168')
and file_id = 9675;

update coverva_dmas.dmas_application
set tracking_number = regexp_replace(tracking_number,'[^A-Za-z0-9 ]','')
where regexp_replace(tracking_number,'[^A-Za-z0-9 ]','') in('T25566572',                         
'T25557062',
'T25536746',
'T25556665',
'T25576885',
'T25551878',
'T25557300',
'T25535359',
'T25554898',
'T25584085',
'T25556436',
'T25577627',
'T25554797',
'T25556477',
'T25573171',
'T25555752',
'T25555055',
'T25555946',
'T25584698',
'T25557168');            

update coverva_dmas.application_override_full_load
set tracking_number = regexp_replace(tracking_number,'[^A-Za-z0-9 ]','')
where regexp_instr(tracking_number,'[^A-Za-z0-9 ]') > 0;

update coverva_dmas.dmas_application_current
set tracking_number = regexp_replace(tracking_number,'[^A-Za-z0-9 ]','')
where regexp_instr(tracking_number,'[^A-Za-z0-9 ]') > 0;