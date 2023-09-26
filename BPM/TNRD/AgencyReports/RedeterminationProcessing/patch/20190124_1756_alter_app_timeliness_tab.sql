alter table d_app_processing_timeliness
add (link_date_after_trm DATE
     ,trm_event_end_date DATE     
     ,mi_voided_date DATE
     ,modified_cycle_start DATE
     ,modified_cycle_stop DATE
     ,modified_mi_added_date DATE
     ,modified_fwd_to_state_dt DATE
     ,mi_added_dt_after_trm DATE
     ,modified_callback_date DATE
     ,modified_detask_stop_date DATE
     ,modified_refer_to_hcfa_date DATE
     ,modified_billable_outcome_date DATE 
     ,modified_excp_cycle_end_date DATE
     ,trm_event_start_date DATE);