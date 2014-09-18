ALTER TABLE nyec_etl_monitor_renewal
Modify (AGE_IN_BUSINESS_DAYS NUMBER(10) DEFAULT 0 
      , AGE_IN_CALENDAR_DAYS NUMBER(10) DEFAULT 0 );

ALTER TABLE nyec_etl_monitor_renewal
ADD (APP_STATUS_DT         DATE
   , APP_STATUS            VARCHAR2(40)
   , APP_IN_PROCESS        VARCHAR2(1)
   , STG_LAST_PROCESSED_DT DATE);      

