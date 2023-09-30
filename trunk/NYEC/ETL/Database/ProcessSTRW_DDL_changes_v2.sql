alter table state_review_stg add new_mi_satisfied_date date;
alter table state_review_stg_tmp add new_mi_satisfied_date date;
alter table nyec_etl_state_review add new_mi_satisfied_date date;

alter table state_review_stg add app_status_date date;
alter table state_review_stg_tmp add app_status_date date;
alter table nyec_etl_state_review add app_status_date date;
