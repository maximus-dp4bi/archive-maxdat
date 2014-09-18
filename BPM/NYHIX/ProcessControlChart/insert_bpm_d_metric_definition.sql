INSERT INTO BPM_D_METRIC_DEFINITION (NAME ,LABEL,RECORD_EFF_DT ,RECORD_END_DT)
VALUES('TASK_COMPLETED_TIMELY','% of Tasks Completed Timely',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy'));

INSERT INTO BPM_D_METRIC_DEFINITION (NAME ,LABEL,RECORD_EFF_DT ,RECORD_END_DT)
VALUES('MEDIAN_CYCLE_TIME_BUSDAYS','Median Cycle Time in Business Days',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy'));

INSERT INTO BPM_D_METRIC_DEFINITION (NAME ,LABEL,RECORD_EFF_DT ,RECORD_END_DT)
VALUES('MAX_CYCLE_TIME_BUSDAYS','Maximum Cycle Time in Business Days',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy'));

INSERT INTO BPM_D_METRIC_DEFINITION (NAME ,LABEL,RECORD_EFF_DT ,RECORD_END_DT)
VALUES('AVG_CYCLE_TIME_BUSDAYS','Average Cycle Time in Business Days',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy'));

INSERT INTO BPM_D_METRIC_DEFINITION (NAME ,LABEL,RECORD_EFF_DT ,RECORD_END_DT)
VALUES('MEDIAN_CYCLE_TIME_CALDAYS','Median Cycle Time in Calendar Days',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy'));

INSERT INTO BPM_D_METRIC_DEFINITION (NAME ,LABEL,RECORD_EFF_DT ,RECORD_END_DT)
VALUES('MAX_CYCLE_TIME_CALDAYS','Maximum Cycle Time in Calendar Days',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy'));

INSERT INTO BPM_D_METRIC_DEFINITION (NAME ,LABEL,RECORD_EFF_DT ,RECORD_END_DT)
VALUES('AVG_CYCLE_TIME_CALDAYS','Average Cycle Time in Calendar Days',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy'));

INSERT INTO BPM_D_METRIC_DEFINITION (NAME ,LABEL,RECORD_EFF_DT ,RECORD_END_DT)
VALUES('MEDIAN_AGE_UNCLAIMED','Median Age of Unclaimed Tasks',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy'));

INSERT INTO BPM_D_METRIC_DEFINITION (NAME ,LABEL,RECORD_EFF_DT ,RECORD_END_DT)
VALUES('MAX_AGE_UNCLAIMED','Maximum Age of Unclaimed Tasks',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy'));

INSERT INTO BPM_D_METRIC_DEFINITION (NAME ,LABEL,RECORD_EFF_DT ,RECORD_END_DT)
VALUES('AVG_AGE_UNCLAIMED','Average Age of Unclaimed Tasks',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy'));

commit;