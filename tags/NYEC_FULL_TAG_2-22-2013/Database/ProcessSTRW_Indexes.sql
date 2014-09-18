/*
Created on 05-Dec-2012 by Raj A.
*/
--------------------------------------------------------------------------
--Create Indexes for STATE_REVIEW_STG table.
--------------------------------------------------------------------------
create index ix_SRS_app_id on state_review_stg (app_id);
create index ix_SRS_strw_task_id on state_review_stg (state_review_task_id );
create index ix_SRS_curr_task_id on state_review_stg (current_task_id);
create index ix_SRS_letter_id on state_review_stg (letter_req_id);
create index ix_SRS_new_strw_task_id on state_review_stg (new_state_review_task_id);
create index ix_SRS_dc_task_id on state_review_stg (data_correction_task_id);
create index ix_SRS_rsrch_task_id on state_review_stg (research_task_id);

create index ix_SRS_stg_done_dt on state_review_stg (stage_done_date );
create index ix_SRS_instance_status on state_review_stg (instance_status);
--GWFs
create index ix_SRS_gwf_task_worked_by on state_review_stg (gwf_task_worked_by);
create index ix_SRS_gwf_state_result on state_review_stg (gwf_state_result);
create index ix_SRS_gwf_research on state_review_stg (gwf_research);
create index ix_SRS_gwf_mi_required on state_review_stg (gwf_mi_required);
create index ix_SRS_gwf_new_mi_satisfied on state_review_stg (gwf_new_mi_satisfied);
--ASFs
create index ix_SRS_asf_Rec_strw on state_review_stg (asf_receive_state_review);
create index ix_SRS_asf_pro_dc on state_review_stg (asf_process_dc);
create index ix_SRS_asf_rsrch on state_review_stg (asf_research);
create index ix_SRS_asf_req_mi_not on state_review_stg (asf_request_mi_notice);
--Attr.
create index ix_SRS_age_bus_days on state_review_stg (age_in_business_days);
create index ix_SRS_all_mi_satisfied on state_review_stg (all_mi_satisfied);
create index ix_SRS_auto_close_flag on state_review_stg (auto_close_flag);
create index ix_SRS_cancel_dt on state_review_stg (cancel_dt);
create index ix_SRS_letter_status on state_review_stg (letter_status);
create index ix_SRS_state_rw_outc on state_review_stg (state_review_outcome);
create index ix_SRS_new_mi_creation_dt on state_review_stg (new_mi_creation_date);
create index ix_SRS_new_mi_satisfied on state_review_stg (new_mi_satisfied);
create index ix_SRS_letter_sent_flag on state_review_stg (letter_sent_flag);
create index ix_SRS_assd_receive_strw on state_review_stg (assd_receive_state_review);


---------------------------------------------------------------------------------------
--Indexes for STATE_REVIEW_STG_TMP
----------------------------------------------------------------------------------------
create index ix_srst_app_id           on STATE_REVIEW_STG_TMP (app_id);
create index ix_srst_strw_task_id     on STATE_REVIEW_STG_TMP (state_review_task_id );
create index ix_srst_curr_task_id     on STATE_REVIEW_STG_TMP (current_task_id);
create index ix_srst_letter_id        on STATE_REVIEW_STG_TMP (letter_req_id);
create index ix_srst_new_strw_task_id on STATE_REVIEW_STG_TMP (new_state_review_task_id);
create index ix_srst_dc_task_id       on STATE_REVIEW_STG_TMP (data_correction_task_id);
create index ix_srst_rsrch_task_id    on STATE_REVIEW_STG_TMP (research_task_id);



----------------------------------------------------------------------------------------
--Indexes for NYEC_ETL_STATE_REVIEW
----------------------------------------------------------------------------------------
create index ix_NESR_app_id on nyec_etl_state_review (app_id);
create index ix_NESR_strw_task_id on nyec_etl_state_review (state_review_task_id );
create index ix_NESR_curr_task_id on nyec_etl_state_review (current_task_id);
create index ix_NESR_letter_id on nyec_etl_state_review (letter_req_id);
create index ix_NESR_new_strw_task_id on nyec_etl_state_review (new_state_review_task_id);
create index ix_NESR_dc_task_id on nyec_etl_state_review (data_correction_task_id);
create index ix_NESR_rsrch_task_id on nyec_etl_state_review (research_task_id);

create index ix_NESR_stg_done_dt on nyec_etl_state_review (stage_done_date );
create index ix_NESR_instance_status on nyec_etl_state_review (instance_status);
--GWFs
create index ix_NESR_gwf_task_worked_by on nyec_etl_state_review (gwf_task_worked_by);
create index ix_NESR_gwf_state_result on nyec_etl_state_review (gwf_state_result);
create index ix_NESR_gwf_research on nyec_etl_state_review (gwf_research);
create index ix_NESR_gwf_mi_required on nyec_etl_state_review (gwf_mi_required);
create index ix_NESR_gwf_new_mi_satisfied on nyec_etl_state_review (gwf_new_mi_satisfied);
--ASFs
create index ix_NESR_asf_Rec_strw on nyec_etl_state_review (asf_receive_state_review);
create index ix_NESR_asf_pro_dc on nyec_etl_state_review (asf_process_dc);
create index ix_NESR_asf_rsrch on nyec_etl_state_review (asf_research);
create index ix_NESR_asf_req_mi_not on nyec_etl_state_review (asf_request_mi_notice);
--Attr.
create index ix_NESR_age_bus_days on nyec_etl_state_review (age_in_business_days);
create index ix_NESR_all_mi_satisfied on nyec_etl_state_review (all_mi_satisfied);
create index ix_NESR_auto_close_flag on nyec_etl_state_review (auto_close_flag);
create index ix_NESR_cancel_dt on nyec_etl_state_review (cancel_dt);
create index ix_NESR_letter_status on nyec_etl_state_review (letter_status);
create index ix_NESR_state_rw_outc on nyec_etl_state_review (state_review_outcome);
create index ix_NESR_new_mi_creation_dt on nyec_etl_state_review (new_mi_creation_date);
create index ix_NESR_new_mi_satisfied on nyec_etl_state_review (new_mi_satisfied);
create index ix_NESR_letter_sent_flag on nyec_etl_state_review (letter_sent_flag);

