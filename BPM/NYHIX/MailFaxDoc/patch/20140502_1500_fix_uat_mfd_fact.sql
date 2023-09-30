DELETE FROM D_NYHIX_MFD_CURRENT
where nyhix_mfd_bi_id = 3890282;

DELETE FROM F_NYHIX_MFD_BY_DATE
where nyhix_mfd_bi_id = 3890282;

INSERT
INTO bpm_update_event_queue
  (
    BUEQ_ID,
    BSL_ID,
    BIL_ID,
    IDENTIFIER,
    EVENT_DATE,
    QUEUE_DATE,
    PROCESS_BUEQ_ID,
  --  WROTE_BPM_EVENT_DATE,
    WROTE_BPM_SEMANTIC_DATE,
    DATA_VERSION,
    OLD_DATA,
    NEW_DATA
  )
SELECT BUEQ_ID,
  BSL_ID,
  BIL_ID,
  IDENTIFIER,
  EVENT_DATE,
  QUEUE_DATE,
  NULL,
 -- WROTE_BPM_EVENT_DATE,
  NULL,
  DATA_VERSION,
  OLD_DATA,
  NEW_DATA
FROM bpm_update_event_queue_archive
WHERE BSL_ID    = 18
AND identifier = '10003795';

DELETE FROM bpm_update_event_queue_archive
WHERE BSL_ID    = 18
AND identifier = '10003795';

COMMIT;