drop index maxdat.corp_etl_mfb_form_wip_ix2 force;
drop index maxdat.corp_etl_mfb_batch_env_wip_ix2 force;
drop index maxdat.IDX_CEMFB_FORM_WIP_COVERED force;
drop index maxdat.IDX_CEMFB_BEVENTS_WIP_COVERED force;

create index maxdat.corp_etl_mfb_form_wip_ix2 on maxdat.corp_etl_mfb_form_wip (batch_guid, batch_module_id, doc_count) tablespace MAXDAT_INDX; 
create index maxdat.corp_etl_mfb_batch_env_wip_ix2 on maxdat.corp_etl_mfb_batch_events_wip (batch_guid, module_end_dt)  tablespace MAXDAT_INDX; 
create index maxdat.corp_etl_mfb_batch_wip_ix2 on maxdat.corp_etl_mfb_batch_wip (batch_guid) tablespace MAXDAT_INDX; 