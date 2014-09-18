
UPDATE f_metric
SET forecast_value = null
WHERE f_metric_id = 1475;

insert into f_metric (
  d_metric_project_id
  , d_reporting_period_id
) 
select d_metric_project_id, d_reporting_period_id 
from d_metric_project mp
inner join d_project p on mp.d_project_id = p.d_project_id
inner join d_metric_definition md on mp.d_metric_definition_id = md.d_metric_definition_id
, d_reporting_period rp
where project_name = 'VT HIX'
and md.name = 'FTE Count'
and rp.type = 'WEEKLY' 
and end_date between '08-MAR-2014' and '17-MAY-2014'
;

insert into f_metric (
  d_metric_project_id
  , d_reporting_period_id
) 
select d_metric_project_id, d_reporting_period_id 
from d_metric_project mp
inner join d_project p on mp.d_project_id = p.d_project_id
inner join d_metric_definition md on mp.d_metric_definition_id = md.d_metric_definition_id
, d_reporting_period rp
where project_name = 'HI HIX'
and md.name in ('AB Rate', 'ASA', 'AHT')
and rp.type = 'WEEKLY' 
and end_date between '10-MAY-2014' and '17-MAY-2014'
;


INSERT INTO CC_L_PATCH_LOG (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME) VALUES ('2.3.1', '003','003_insert_update_f_metric');

COMMIT;