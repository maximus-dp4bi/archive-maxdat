insert into CORP_ETL_CONTROL
values ('EMRS_SYNCH_SELECTIONSEGMENT_RUN_JOB','V','Y','Flag to enable/disable the Selection Segments Synchronize job', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_SELECTION_SEGMENT_RELOAD','V','N','Switch to enable reloading selection segment data', sysdate, sysdate);


COMMIT;