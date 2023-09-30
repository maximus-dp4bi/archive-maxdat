--------------------------------------------------------
--  DDL for Index TIMEPERI_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "TIMEPERI_PK" ON "EMRS_D_TIME_PERIOD" ("TIME_PERIOD_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;

CREATE INDEX IDX_TIMEPERIOD1 ON emrs_d_time_period(hour_minute_military) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX_TIMEPERIOD2 ON emrs_d_time_period(second) TABLESPACE MAXDAT_INDX;