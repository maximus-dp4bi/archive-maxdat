alter session set current_schema = MAXDAT;

/*Staging tables*/
TRUNCATE TABLE CORP_ETL_MANAGE_JOBS;
TRUNCATE TABLE CORP_ETL_MANAGE_JOBS_OLTP;
TRUNCATE TABLE CORP_ETL_MANAGE_JOBS_WIP_BPM;


/*Semantic tables*/
ALTER TABLE F_MJ_BY_DATE DISABLE CONSTRAINT FMJBD_DMJCUR_FK;
TRUNCATE TABLE F_MJ_BY_DATE;
TRUNCATE TABLE D_MJ_CURRENT;
ALTER TABLE F_MJ_BY_DATE ENABLE CONSTRAINT FMJBD_DMJCUR_FK;

DELETE FROM D_MJ_LAST_UPDATE_BY;


/*Update global controls*/
update corp_etl_control
set value = '121625'
where name = 'LAST_JOB_ID';


commit;