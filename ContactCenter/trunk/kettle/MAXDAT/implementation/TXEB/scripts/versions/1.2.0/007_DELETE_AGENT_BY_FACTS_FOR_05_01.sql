delete from CC_F_AGENT_BY_DATE F
where f.d_date_id in (
select f.d_date_id from CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_DATES D ON F.D_DATE_ID = D.D_DATE_ID
where d.d_date='01-MAY-14');

delete from CC_F_AGENT_ACTIVITY_BY_DATE F
where f.d_date_id in (
select f.d_date_id from CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_DATES D ON F.D_DATE_ID = D.D_DATE_ID
where d.d_date='01-MAY-14');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.2.0','007','007_DELETE_AGENT_BY_FACTS_FOR_05_01');

commit;