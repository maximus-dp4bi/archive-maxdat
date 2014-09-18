-- add missing records in F_METRIC to fix blank cells showing up in dashboard

-- HI HIX FTE Count for w/e 05/10/2014
insert into f_metric (
  d_metric_project_id
  , d_reporting_period_id
) 
select d_metric_project_id
	, d_reporting_period_id 
from d_metric_project mp
inner join d_project p
	on mp.d_project_id = p.d_project_id
inner join d_metric_definition md 
	on mp.d_metric_definition_id = md.d_metric_definition_id
, d_reporting_period rp
where project_name = 'HI HIX'
and md.name = 'FTE Count'
and rp.type = 'WEEKLY' 
and end_date = to_date('10-MAY-2014', 'dd-mon-yyyy')
;

-- HI HIX FTE Count for w/e 05/17/2014
insert into f_metric (
  d_metric_project_id
  , d_reporting_period_id
) 
select d_metric_project_id
	, d_reporting_period_id 
from d_metric_project mp
inner join d_project p
	on mp.d_project_id = p.d_project_id
inner join d_metric_definition md 
	on mp.d_metric_definition_id = md.d_metric_definition_id
, d_reporting_period rp
where project_name = 'HI HIX'
and md.name = 'FTE Count'
and rp.type = 'WEEKLY' 
and end_date = to_date('17-MAY-2014', 'dd-mon-yyyy')
;

-- HI HIX FTE Count for w/e 05/24/2014
insert into f_metric (
  d_metric_project_id
  , d_reporting_period_id
) 
select d_metric_project_id
	, d_reporting_period_id 
from d_metric_project mp
inner join d_project p
	on mp.d_project_id = p.d_project_id
inner join d_metric_definition md 
	on mp.d_metric_definition_id = md.d_metric_definition_id
, d_reporting_period rp
where project_name = 'HI HIX'
and md.name = 'FTE Count'
and rp.type = 'WEEKLY' 
and end_date = to_date('24-MAY-2014', 'dd-mon-yyyy')
;

-- HI HIX FTE Count for w/e 05/31/2014
insert into f_metric (
  d_metric_project_id
  , d_reporting_period_id
) 
select d_metric_project_id
	, d_reporting_period_id 
from d_metric_project mp
inner join d_project p
	on mp.d_project_id = p.d_project_id
inner join d_metric_definition md 
	on mp.d_metric_definition_id = md.d_metric_definition_id
, d_reporting_period rp
where project_name = 'HI HIX'
and md.name = 'FTE Count'
and rp.type = 'WEEKLY' 
and end_date = to_date('31-MAY-2014', 'dd-mon-yyyy')
;

-- HI HIX AB Rate for w/e 05/24/2014
insert into f_metric (
  d_metric_project_id
  , d_reporting_period_id
) 
select d_metric_project_id
	, d_reporting_period_id 
from d_metric_project mp
inner join d_project p
	on mp.d_project_id = p.d_project_id
inner join d_metric_definition md 
	on mp.d_metric_definition_id = md.d_metric_definition_id
, d_reporting_period rp
where project_name = 'HI HIX'
and md.name = 'AB Rate'
and rp.type = 'WEEKLY' 
and end_date = to_date('24-MAY-2014', 'dd-mon-yyyy')
;

-- HI HIX AB Rate for w/e 05/31/2014
insert into f_metric (
  d_metric_project_id
  , d_reporting_period_id
) 
select d_metric_project_id
	, d_reporting_period_id 
from d_metric_project mp
inner join d_project p
	on mp.d_project_id = p.d_project_id
inner join d_metric_definition md 
	on mp.d_metric_definition_id = md.d_metric_definition_id
, d_reporting_period rp
where project_name = 'HI HIX'
and md.name = 'AB Rate'
and rp.type = 'WEEKLY' 
and end_date = to_date('31-MAY-2014', 'dd-mon-yyyy')
;

-- HI HIX AHT for w/e 05/24/2014
insert into f_metric (
  d_metric_project_id
  , d_reporting_period_id
) 
select d_metric_project_id
	, d_reporting_period_id 
from d_metric_project mp
inner join d_project p
	on mp.d_project_id = p.d_project_id
inner join d_metric_definition md 
	on mp.d_metric_definition_id = md.d_metric_definition_id
, d_reporting_period rp
where project_name = 'HI HIX'
and md.name = 'AHT'
and rp.type = 'WEEKLY' 
and end_date = to_date('24-MAY-2014', 'dd-mon-yyyy')
;

-- HI HIX AHT for w/e 05/31/2014
insert into f_metric (
  d_metric_project_id
  , d_reporting_period_id
) 
select d_metric_project_id
	, d_reporting_period_id 
from d_metric_project mp
inner join d_project p
	on mp.d_project_id = p.d_project_id
inner join d_metric_definition md 
	on mp.d_metric_definition_id = md.d_metric_definition_id
, d_reporting_period rp
where project_name = 'HI HIX'
and md.name = 'AHT'
and rp.type = 'WEEKLY' 
and end_date = to_date('31-MAY-2014', 'dd-mon-yyyy')
;

-- HI HIX ASA for w/e 05/24/2014
insert into f_metric (
  d_metric_project_id
  , d_reporting_period_id
) 
select d_metric_project_id
	, d_reporting_period_id 
from d_metric_project mp
inner join d_project p
	on mp.d_project_id = p.d_project_id
inner join d_metric_definition md 
	on mp.d_metric_definition_id = md.d_metric_definition_id
, d_reporting_period rp
where project_name = 'HI HIX'
and md.name = 'ASA'
and rp.type = 'WEEKLY' 
and end_date = to_date('24-MAY-2014', 'dd-mon-yyyy')
;

-- HI HIX ASA for w/e 05/31/2014
insert into f_metric (
  d_metric_project_id
  , d_reporting_period_id
) 
select d_metric_project_id
	, d_reporting_period_id 
from d_metric_project mp
inner join d_project p
	on mp.d_project_id = p.d_project_id
inner join d_metric_definition md 
	on mp.d_metric_definition_id = md.d_metric_definition_id
, d_reporting_period rp
where project_name = 'HI HIX'
and md.name = 'ASA'
and rp.type = 'WEEKLY' 
and end_date = to_date('31-MAY-2014', 'dd-mon-yyyy')
;

-- VT HIX FTE Count for w/e 05/24/2014
insert into f_metric (
  d_metric_project_id
  , d_reporting_period_id
) 
select d_metric_project_id
	, d_reporting_period_id 
from d_metric_project mp
inner join d_project p
	on mp.d_project_id = p.d_project_id
inner join d_metric_definition md 
	on mp.d_metric_definition_id = md.d_metric_definition_id
, d_reporting_period rp
where project_name = 'VT HIX'
and md.name = 'FTE Count'
and rp.type = 'WEEKLY' 
and end_date = to_date('24-MAY-2014', 'dd-mon-yyyy')
;

-- VT HIX FTE Count for w/e 05/31/2014
insert into f_metric (
  d_metric_project_id
  , d_reporting_period_id
) 
select d_metric_project_id
	, d_reporting_period_id 
from d_metric_project mp
inner join d_project p
	on mp.d_project_id = p.d_project_id
inner join d_metric_definition md 
	on mp.d_metric_definition_id = md.d_metric_definition_id
, d_reporting_period rp
where project_name = 'VT HIX'
and md.name = 'FTE Count'
and rp.type = 'WEEKLY' 
and end_date = to_date('31-MAY-2014', 'dd-mon-yyyy')
;

INSERT INTO CC_L_PATCH_LOG (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME) VALUES ('2.4', '011','011_INSERT_F_METRIC_RECORDS');

commit;
