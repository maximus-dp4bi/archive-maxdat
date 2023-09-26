insert into CORP_ETL_CONTROL
values ('EMRS_SELECTIONSEGMENT_RELOAD_DAY','V','9','Day to run the truncate and reload for Selection Segments data. Set to any number between 0 and 7 for Sun to Sat or set to a bigger number if reload is not needed', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_SELECTION_SEGMENT_SOURCE_COUNT','N','0','Selection segment source count', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_SELECTION_SEGMENT_TRUNC_INS_YN','V','Y','Switch to enable or disable truncate/insert logic for Selection Segments data', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_SELECTION_SEGMENT_LOOKBACK_DAYS','N','3','This is the number of lookback days used to get the selection segments records in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_SELECTION_TXN_LOOKBACK_DAYS','N','3','This is the number of lookback days used to get the selection transaction records in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_RUN_NEW_ELIGSEGMENT_DTL','V','Y','This is the switch to turn on the new Elig Segment and Detail ETL job.  Set to N to disable and Y to enable.', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_RUN_OLD_ELIGSEGMENT_DTL','V','Y','This is the switch to turn off the old Elig Segment and Detail ETL job.  Set to N to disable and Y to enable.', sysdate, sysdate);


COMMIT;