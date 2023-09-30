/*
Created on 16-Aug-2012 by Raj A.
*/
--------------------------------------------------------------------------
--Create Indexes for PROCESS_MI_STG table.
--------------------------------------------------------------------------
create index ix_PMS_instance_status on process_mi_stg (instance_status);
create index ix_PMS_insert_flg on process_mi_stg (insert_flg );
create index ix_PMS_update_flg on process_mi_stg (update_flg );
create index ix_PMS_GWF_CHANNEL on process_mi_stg (GWF_CHANNEL);
create index ix_PMS_CANCEL_DATE on process_mi_stg (CANCEL_DATE);
create index ix_PMS_GWF_QC_REQUIRED on process_mi_stg (GWF_QC_REQUIRED);
create index ix_PMS_GWF_QC_Outcome on process_mi_stg (GWF_QC_Outcome);
create index ix_PMS_GWF_MI_Outcome on process_mi_stg (GWF_MI_Outcome);
create index ix_PMS_ASF_RECEIVE_MI on process_mi_stg (ASF_RECEIVE_MI);
create index ix_PMS_ASF_STATE_ACCEPT on process_mi_stg (ASF_CREATE_STATE_ACCEPT);
create index ix_PMS_ASF_DET_MI_Outcome on process_mi_stg (ASF_DETERMINE_MI_OUTCOME);
create index ix_PMS_ASF_COMPL_MI_TASK on process_mi_stg (ASF_COMPLETE_MI_TASK);
create index ix_PMS_ASF_PERFORM_QC on process_mi_stg (ASF_PERFORM_QC);
create index ix_PMS_ASF_PERF_RSRCH on process_mi_stg (ASF_PERFORM_RESEARCH);
create index ix_PMS_ASF_SEND_MI_LETT on process_mi_stg (ASF_SEND_MI_LETTER);
create index ix_PMS_Age_Bus_days on process_mi_stg (AGE_IN_BUSINESS_DAYS);
create index ix_PMS_Age_Cal_days on process_mi_stg (AGE_IN_CALENDAR_DAYS);
create index ix_PMS_ALL_MI_SATIS on process_mi_stg (ALL_MI_SATISFIED);
create index ix_PMS_APP_ID on process_mi_stg (APP_ID);
create index ix_PMS_CURRENT_TASK_ID on process_mi_stg (CURRENT_TASK_ID);
create index ix_PMS_JEOPARDY_FLAG on process_mi_stg (JEOPARDY_FLAG);
create index ix_PMS_MI_RECEIPT_DT on process_mi_stg (MI_RECEIPT_DT);
create index ix_PMS_MI_DOC_LINKED_DATE on process_mi_stg (MI_DOC_LINKED_DATE);
create index ix_PMS_MI_DOC_LINKED_BY on process_mi_stg (MI_DOC_LINKED_BY);
create index ix_PMS_MI_TYPE on process_mi_stg (MI_TYPE);
create index ix_PMS_MI_CHANNEL on process_mi_stg (MI_CHANNEL);
create index ix_PMS_MI_TASK_TYPE on process_mi_stg (MI_TASK_TYPE);
--create index ix_PMS_MI_TASK_ID on process_mi_stg (MI_TASK_ID);
create index ix_PMS_MI_TASK_CREATE_DATE on process_mi_stg (MI_TASK_CREATE_DATE);
create index ix_PMS_MI_TASK_CREATED_BY on process_mi_stg (MI_TASK_CREATED_BY);
create index ix_PMS_MI_LETT_REQ_ID on process_mi_stg (MI_LETTER_REQUEST_ID);
create index ix_PMS_QC_TASK_ID on process_mi_stg (QC_TASK_ID);
create index ix_PMS_QC_task_clm_date on process_mi_stg (QC_task_claimed_date);
create index ix_PMS_QC_task_clm_dt on process_mi_stg (QC_task_completed_date);
create index ix_PMS_RESEARCH_TASK_ID on process_mi_stg (RESEARCH_TASK_ID);
create index ix_PMS_Rsrch_task_clm_dt on process_mi_stg (Rsrch_task_claimed_date);
create index ix_PMS_Rsrch_task_comp_dt on process_mi_stg (Rsrch_task_completed_date);
create index ix_PMS_ST_RV_TASK_ID on process_mi_stg (STATE_REVIEW_TASK_ID);
create index ix_PMS_StRw_clm_dt on process_mi_stg (StRw_task_claimed_date);
create index ix_PMS_StRw_comp_dt on process_mi_stg (StRw_task_completed_date);