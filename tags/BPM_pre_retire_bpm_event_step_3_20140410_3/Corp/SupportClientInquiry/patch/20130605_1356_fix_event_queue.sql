-- 6/5 Per Randy, UAT fix for ILEB-1245 promotion
update BPM_UPDATE_EVENT_QUEUE set  PROCESS_BUEQ_ID = NULL
 where bsl_id = 13 and PROCESS_BUEQ_ID is not null;
COMMIT;
