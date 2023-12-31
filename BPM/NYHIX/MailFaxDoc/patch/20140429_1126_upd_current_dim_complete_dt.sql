--Complete in ETL, Fact table shows complete but are still active in current dimension, exists in queue archive
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
    WROTE_BPM_EVENT_DATE,
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
  null,
  WROTE_BPM_EVENT_DATE,
  NULL,
  DATA_VERSION,
  OLD_DATA,
  NEW_DATA
FROM bpm_update_event_queue_archive
WHERE
BSL_ID = 18 and 
OLD_DATA is not null and
identifier IN ('10073859','10074421','10074423','U141053778330','U141053781454','U141053789521','U141053778193','U141053782909',
'U141053778128','U141053778455','U141053778210','U141053789327','U141053778537','U141053778683','U141053789529','U141073830350',
'U141073830405','U141073830408','U141073830411','U141063793302','U141063793446','U141073831038','U141063793037','U141063793040',
'U141053778047','U141053778335','U141053783037','U141053788645','U141053788680','U141063793448','U141063793451','U141063796043',
'10073867','U141053789511','U141053783047','U141053778457','U141053781577','U141063793450','U141053788683','U141053783287',
'U141053789236','U141053788765','U141073829971');



delete FROM bpm_update_event_queue_archive
WHERE
BSL_ID = 18 and 
OLD_DATA is not null and
identifier IN ('10073859','10074421','10074423','U141053778330','U141053781454','U141053789521','U141053778193','U141053782909',
'U141053778128','U141053778455','U141053778210','U141053789327','U141053778537','U141053778683','U141053789529','U141073830350',
'U141073830405','U141073830408','U141073830411','U141063793302','U141063793446','U141073831038','U141063793037','U141063793040',
'U141053778047','U141053778335','U141053783037','U141053788645','U141053788680','U141063793448','U141063793451','U141063796043',
'10073867','U141053789511','U141053783047','U141053778457','U141053781577','U141063793450','U141053788683','U141053783287',
'U141053789236','U141053788765','U141073829971');


--Complete in ETL, Fact table shows complete but are still active in current dimension, exists in queue archive
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
--    WROTE_BPM_EVENT_DATE,
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
  null,
--  WROTE_BPM_EVENT_DATE,
  NULL,
  DATA_VERSION,
  OLD_DATA,
  NEW_DATA
FROM bpm_update_event_queue_archive
WHERE
BSL_ID = 18 and 
OLD_DATA is not null and
identifier IN ('U141123985883',
'U141123985706',
'U141134028060',
'U141134028093',
'U141123985698',
'U141113951752',
'U141113951729',
'U141113951485',
'U141113952099',
'U141113951558',
'U141113951726',
'U141134027437',
'U141134027445',
'U141134027512',
'U141134027514',
'U141134027818',
'U141134027824',
'U141134027832',
'U141134027839',
'U141134027849',
'U141134027856',
'U141134028076',
'U141134028360',
'U141144066242',
'U141144066253',
'U141144066266',
'U141144066398',
'U141113951758',
'U141113952103',
'U141113952107',
'U141113952110',
'U141113952217',
'U141113952558',
'U141113952900',
'U141113953910',
'U141123985347',
'U141123985390',
'U141123985703',
'U141123985826',
'U141123985854',
'U141123985995',
'U141123986010',
'U141123986146',
'U141123987156',
'U141123987161',
'U141123987701',
'U141144066257',
'U141144066389',
'U141144066236');



delete FROM bpm_update_event_queue_archive
WHERE
BSL_ID = 18 and 
OLD_DATA is not null and
identifier IN ('U141123985883',
'U141123985706',
'U141134028060',
'U141134028093',
'U141123985698',
'U141113951752',
'U141113951729',
'U141113951485',
'U141113952099',
'U141113951558',
'U141113951726',
'U141134027437',
'U141134027445',
'U141134027512',
'U141134027514',
'U141134027818',
'U141134027824',
'U141134027832',
'U141134027839',
'U141134027849',
'U141134027856',
'U141134028076',
'U141134028360',
'U141144066242',
'U141144066253',
'U141144066266',
'U141144066398',
'U141113951758',
'U141113952103',
'U141113952107',
'U141113952110',
'U141113952217',
'U141113952558',
'U141113952900',
'U141113953910',
'U141123985347',
'U141123985390',
'U141123985703',
'U141123985826',
'U141123985854',
'U141123985995',
'U141123986010',
'U141123986146',
'U141123987156',
'U141123987161',
'U141123987701',
'U141144066257',
'U141144066389',
'U141144066236');

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
    WROTE_BPM_EVENT_DATE,
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
  null,
  WROTE_BPM_EVENT_DATE,
  NULL,
  DATA_VERSION,
  OLD_DATA,
  NEW_DATA
FROM bpm_update_event_queue_archive
WHERE
BSL_ID = 18 and 
OLD_DATA is not null and
identifier IN ('U141154102042',
'U141174130034',
'U141174130035',
'U141184132259',
'U141184132354',
'U141184132825',
'U141194205943');

delete FROM bpm_update_event_queue_archive
WHERE
BSL_ID = 18 and 
OLD_DATA is not null and
identifier IN ('U141154102042',
'U141174130034',
'U141174130035',
'U141184132259',
'U141184132354',
'U141184132825',
'U141194205943');


commit;
