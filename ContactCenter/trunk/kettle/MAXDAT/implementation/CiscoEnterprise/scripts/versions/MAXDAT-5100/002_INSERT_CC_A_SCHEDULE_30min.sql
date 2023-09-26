alter session set current_schema = cisco_enterprise_cc;

alter table CC_A_SCHEDULE disable constraint REGEX_CHECK_EXECUTION_TIME;

Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','00:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','01:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','02:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','03:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','04:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','05:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','06:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','07:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','08:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','09:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','10:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','11:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','12:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','13:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','14:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','15:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','16:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','17:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','18:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','19:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','20:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','21:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','22:30:00');
Insert into CC_A_SCHEDULE (JOB_TYPE,EXECUTION_TIME) values ('load_production_planning','23:30:00');

commit;