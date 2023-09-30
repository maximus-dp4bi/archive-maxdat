INSERT INTO BPM_D_METRIC_DEFINITION (NAME ,LABEL, RECORD_EFF_DT ,RECORD_END_DT)
VALUES('BATCHES_COMPLETED_TIMELY','% of Batches Completed Timely',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy'));

commit;