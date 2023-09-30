SELECT * FROM METRIC;

SELECT * FROM SEGMENT;

SELECT * FROM PROJECT;

SELECT * FROM GEOGRAPHY_MASTER;

SELECT GEOGRAPHY_NAME, PROJECT_NAME, M.NAME METRIC_NAME
FROM METRIC_USAGE MU
INNER JOIN GEOGRAPHY_MASTER GM ON MU.GEOGRAPHY_MASTER_ID = GM.GEOGRAPHY_MASTER_ID
INNER JOIN PROJECT P ON MU.PROJECT_ID = P.PROJECT_ID
INNER JOIN METRIC M ON MU.METRIC_ID = M.METRIC_ID
ORDER BY GEOGRAPHY_NAME, PROJECT_NAME, M.NAME;


select end_date, project_name, m.name metric_name, actual_value, forecast_value
from metric_value_decimal mvd
inner join metric_usage mu on mvd.metric_usage_id = mu.metric_usage_id
inner join reporting_period rp on mvd.reporting_period_id = rp.reporting_period_id
inner join project p on mu.project_id = p.project_id
inner join metric m on mu.metric_id = m.metric_id
--where project_name = 'VT HIX'
order by end_date, project_name, m.name;

select count(*) from metric_value_decimal;

SELECT project_id, geography_master_id 
FROM METRIC_USAGE
order by project_id;

select * from metric_value_decimal
order by id desc;

truncate table metric_value_decimal;

select * from metric_value_decimal
where forecast_value = 0;

update metric_value_decimal
set forecast_value = null
where forecast_value = 0;
