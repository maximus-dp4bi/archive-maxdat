----  UAT clean up for Process letters User Story 13794

DELETE from maxdat.bpm_update_event_queue where BSL_id =12;
UPDATE maxdat.corp_etl_proc_letters SET COMPLETE_DT = SYSDATE-92,PRINT_DT= SYSDATE-92   WHERE COMPLETE_DT < SYSDATE-100000;
Commit;
