/*
Script to remove wrongly loaded metrics due to AE1 to AE2 shift - Maxdat 3854
*/
declare
vcount number(10);
begin
    dbms_output.put_line ('SMetric - project_name , program_name , geography_name , reporting_period_type , end_date , name , actual_value , create_date , created_by ');
for metcur in (
select 
dpa.project_name, spra.report_type, dpra.program_name , dga.geography_name, spra.functional_area, drp.type reporting_period_type, drp.end_date, dm.name, smet.actual_value, smet.comments, smet.actual_value_not_supplied, spra.status, dmp.actual_value_provided_by, smet.last_modified_date, smet.create_date, smet.created_by, smet.s_metric_id
from mots.s_metric smet, mots.d_metric_Definition dm, mots.s_project_report spra, mots.d_reporting_period drp
, mots.d_project dpa, mots.d_program dpra, mots.d_geography_master dga, mots.d_metric_project dmp
where dm.d_metric_definition_id = smet.d_metric_definition_id
and spra.s_project_report_id = smet.s_actuals_project_report_id
and dpa.d_project_id = spra.d_project_id
and dpra.d_program_id = spra.d_program_id
and dga.d_geography_master_id = spra.d_geography_master_id
and drp.d_reporting_period_id = spra.d_reporting_period_id
and dmp.d_project_id = spra.d_project_id
and dmp.d_program_id = spra.d_program_id
and dmp.d_geography_master_id = spra.d_geography_master_id
and dmp.d_metric_definition_id = smet.d_metric_definition_id
and (trunc(smet.create_date) >= to_date('4/30/2016','mm/dd/yyyy') or trunc(smet.last_modified_date) >= to_date('4/30/2016','mm/dd/yyyy'))
and ((project_name = 'IL EEV' and end_date >= to_date('04/30/2016','mm/dd/yyyy')) OR (project_name = 'IL EB' and end_date >= to_date('05/21/2016','mm/dd/yyyy')))
and end_date <= to_date('05/31/2016','mm/dd/yyyy')
and name in ('AT_WORK_NOT_HANDLING_CONTACTS_PERCENTAGE','NUMBER_OF_SKILLED_AGENTS_ATTRITTED', 'Utilization')
--and smet.created_by = 'AUTO_LOAD'
order by trunc(smet.last_modified_date) desc, end_date desc 
)
loop
    dbms_output.put_line (metcur.project_name|| ',' || metcur.program_name || ',' || metcur.geography_name || ',' || metcur.reporting_period_type || ',' || metcur.end_date || ',' || metcur.name || ',' || metcur.actual_value || ',' || metcur.create_date || ',' || metcur.created_by  || ',- deleting ');
    delete s_metric smt where smt.s_metric_id = metcur.s_metric_id;                 
end loop;

dbms_output.put_line ('FMetric - project_name , program_name , geography_name , reporting_period_type , end_date , name , actual_value , create_date , created_by ');
for metcur in (
  select 
dpa.project_name, dpra.program_name , dga.geography_name, drp.type reporting_period_type, drp.end_date, dm.name, fmet.actual_value, fmet.comments, dmp.actual_value_provided_by, fmet.last_modified_date, fmet.create_date, fmet.created_by, fmet.f_metric_id
from mots.f_metric fmet, mots.d_metric_Definition dm, mots.d_metric_project dmp, mots.d_reporting_period drp
, mots.d_project dpa, mots.d_program dpra, mots.d_geography_master dga
where dm.d_metric_definition_id = dmp.d_metric_definition_id
and dmp.d_metric_project_id = fmet.d_metric_project_id
and dpa.d_project_id = dmp.d_project_id
and dpra.d_program_id = dmp.d_program_id
and dga.d_geography_master_id = dmp.d_geography_master_id
and drp.d_reporting_period_id = fmet.d_reporting_period_id
and (trunc(fmet.create_date) >= to_date('4/30/2016','mm/dd/yyyy') or trunc(fmet.last_modified_date) >= to_date('4/30/2016','mm/dd/yyyy'))
and ((project_name = 'IL EEV' and end_date >= to_date('04/30/2016','mm/dd/yyyy')) OR (project_name = 'IL EB' and end_date >= to_date('05/21/2016','mm/dd/yyyy')))
and end_date <= to_date('05/31/2016','mm/dd/yyyy')
and name in ('AT_WORK_NOT_HANDLING_CONTACTS_PERCENTAGE','NUMBER_OF_SKILLED_AGENTS_ATTRITTED', 'Utilization')
--and fmet.created_by = 'AUTO_LOAD'
order by  trunc(fmet.last_modified_date) desc, end_date desc
)
loop
    dbms_output.put_line (metcur.project_name|| ',' || metcur.program_name || ',' || metcur.geography_name || ',' || metcur.reporting_period_type || ',' || metcur.end_date || ',' || metcur.name || ',' || metcur.actual_value || ',' || metcur.create_date || ',' || metcur.created_by  || ',' || metcur.f_metric_id || ',- deleting ');
    delete f_metric fmt where fmt.f_metric_id = metcur.f_metric_id;                 
end loop;
end;
/
