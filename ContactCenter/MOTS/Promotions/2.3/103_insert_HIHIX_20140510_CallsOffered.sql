
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
and md.name = 'Calls Offered'
and rp.type = 'WEEKLY' 
and end_date = '10-MAY-2014'
;

INSERT INTO CC_L_PATCH_LOG (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME) VALUES ('2.3', '103','103_insert_HIHIX_20140510_CallsOffered');


commit;

