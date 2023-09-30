GRANT SELECT, UPDATE ON CORP_ETL_CONTROL TO DP_SCORECARD WITH GRANT OPTION;

delete from maxdat.CORP_ETL_CONTROL
where name = 'PP_WFM_AGENT_CLOCKING_WORK_DAY';

commit;

insert into maxdat.corp_etl_control(NAME, value_type, value, description)
values('PP_WFM_AGENT_CLOCKING_WORK_DAY','V','2018/12/16','This is the LAST sucessfull WORK_DAY ( EST ) format YYYY/MM/DD for the PP_WFM_AGENT_CLOCKING_HISTORY');


COMMIT;