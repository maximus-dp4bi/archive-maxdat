ALTER TABLE CC_S_CALL_DETAIL ADD (
  CALL_TYPE VARCHAR2(200)  NULL
  , DNIS VARCHAR2(30) NULL
  , DISPOSITION  VARCHAR2(200) NULL
  , CALL_ABANDONED_FLAG NUMBER NULL
  , VOICEMAIL_FLAG VARCHAR2(1) NULL
  , IVR_TIME_SECONDS NUMBER(7,2) NULL
);

COMMIT;