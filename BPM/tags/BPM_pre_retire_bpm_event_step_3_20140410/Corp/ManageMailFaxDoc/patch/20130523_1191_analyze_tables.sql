
analyze table bpm_update_event_queue compute statistics;
analyze table bpm_update_event_queue_archive compute statistics;
analyze table process_bpm_queue_job compute statistics;
analyze table D_MFDOC_CURRENT  compute statistics;
analyze table D_MFDOC_BATCH  compute statistics;
analyze table D_MFDOC_DCN_JEOPARDY_STATUS  compute statistics;
analyze table D_MFDOC_DOCUMENT_STATUS  compute statistics;
analyze table D_MFDOC_INSTANCE_STATUS  compute statistics;
analyze table D_MFDOC_TIMELINESS_STATUS  compute statistics;
analyze table F_MFDOC_BY_DATE compute statistics;

-- Reset queue.
update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where
  BSL_ID in (9)
  and PROCESS_BUEQ_ID is not null;
  
commit;