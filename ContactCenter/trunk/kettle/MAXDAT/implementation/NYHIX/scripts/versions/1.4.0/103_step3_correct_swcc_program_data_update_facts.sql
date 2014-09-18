delete from cc_f_agent_by_date where f_agent_by_date_id in(
select f_agent_by_date_id from cc_f_agent_by_date f where d_program_id=2
and d_date_id<>(select d_date_id from cc_d_dates where d_date='15-Jul-2014')
and exists(select 1 from cc_f_agent_by_date f2 where f2.d_agent_id=f.d_agent_id and f.d_date_id=f2.d_date_id and f2.d_program_id<>2));

update cc_f_agent_by_date set d_program_id=(select program_id from cc_d_program where program_name='SWCC')
where f_agent_by_date_id in(
SELECT F.F_AGENT_BY_DATE_ID
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_C_PROJECT_CONFIG CPC ON SA.PROJECT_CONFIG_ID = CPC.PROJECT_CONFIG_ID
where cpc.program_name='SWCC'
)
and d_program_id<>(select program_id from cc_d_program where program_name='SWCC')
and d_date_id<>(select d_date_id from cc_d_dates where d_date='15-Jul-2014');
commit;

update cc_f_agent_activity_by_date set d_program_id=(select program_id from cc_d_program where program_name='SWCC')
where f_agent_activity_by_date_id in(
SELECT F.F_AGENT_ACTIVITY_BY_DATE_ID
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_C_PROJECT_CONFIG CPC ON SA.PROJECT_CONFIG_ID = CPC.PROJECT_CONFIG_ID
where cpc.program_name='SWCC')
and d_program_id<>(select program_id from cc_d_program where program_name='SWCC')
and d_date_id<>(select d_date_id from cc_d_dates where d_date='15-Jul-2014');
commit;

