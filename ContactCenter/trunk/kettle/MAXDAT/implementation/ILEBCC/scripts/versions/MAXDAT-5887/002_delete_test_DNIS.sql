alter session set current_schema = maxdat_cc;

-- UAT
delete from cc_f_ivr_self_service_usage
where d_unit_of_work_id in (select uow_id from cc_d_unit_of_work
                                      where unit_of_work_name = 'PA CHC IVR');
                                      
delete from cc_f_actuals_ivr_interval
where d_unit_of_work_id in (select uow_id from cc_d_unit_of_work
                                      where unit_of_work_name = 'PA CHC IVR');
                                      
delete from cc_s_ivr_response
where destination_dnis = 4082;   

commit;

-- PRD

delete from cc_f_ivr_self_service_usage
where d_unit_of_work_id in (select uow_id from cc_d_unit_of_work
                                      where unit_of_work_name = 'PA CHC IVR')
                                       and trunc(create_date) = '21-SEP-17';
                                      
delete from cc_f_actuals_ivr_interval
where d_unit_of_work_id in (select uow_id from cc_d_unit_of_work
                                      where unit_of_work_name = 'PA CHC IVR')
                                      and trunc(create_date) = '21-SEP-17';
                                      
delete from cc_s_ivr_response
where destination_dnis = 4082
and trunc(row_inserted_dt) = '21-SEP-17';   

commit;

--PRD -- delete data prior to go live date of 9/25


delete from cc_f_ivr_self_service_usage
where d_project_id in (select project_id from cc_d_project where project_name = 'PA IEB')
and d_unit_of_work_id in (select uow_id from cc_d_unit_of_work
                                      where unit_of_work_name = 'PA CHC IVR')
and d_date_id < (select d_date_id from cc_d_dates where d_date = '25-SEP-17');


delete from cc_f_actuals_ivr_interval
where d_project_id in (select project_id from cc_d_project where project_name = 'PA IEB')
and d_unit_of_work_id in (select uow_id from cc_d_unit_of_work
                                      where unit_of_work_name = 'PA CHC IVR')
and d_date_id < (select d_date_id from cc_d_dates where d_date = '25-SEP-17') ;



delete from cc_s_ivr_response
where destination_dnis = 4082
and trunc(row_inserted_dt) < '25-SEP-17'; 

commit;