
DELETE F_METRIC WHERE F_METRIC_ID < 100;

--  advance F_METRIC sequence so that no collisions occur
select SEQ_F_METRIC.nextval from f_metric;

alter sequence seq_f_metric increment by 100;
select SEQ_F_METRIC.nextval from dual;

alter sequence seq_f_metric increment by 1;
select SEQ_F_METRIC.nextval from dual;

