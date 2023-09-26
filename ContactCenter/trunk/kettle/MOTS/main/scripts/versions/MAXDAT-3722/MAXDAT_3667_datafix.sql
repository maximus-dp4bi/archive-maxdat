/*
Script will unlink autoloaded s_metric records from Back Office reports and relink to proper Autoload report or delete if one already exists
*/

declare
vcount number(10);
begin
for metcur in (
  select dp.project_name, dpg.program_name, dgm.geography_name, drp.start_date, drp.end_date, drp.type, md.name metric_name, md.functional_area, sm.s_metric_id, sm.d_metric_definition_id,  sm.s_actuals_project_report_id, spr.functional_area old_fc, sprc.s_project_report_id, sprc.functional_area new_fc
--spr.functional_area, sm.*, spr.*
from s_metric sm, d_metric_definition md , s_project_report spr, s_project_report sprc
, d_project dp, d_program dpg, d_geography_master dgm, d_reporting_period drp
where sm.d_metric_definition_id = md.d_metric_definition_id
and spr.s_project_report_id = sm.s_actuals_project_report_id
and spr.functional_area = 'Back Office'
and md.functional_area = 'Contact Center'
and dp.d_project_id = spr.d_project_id
and dpg.d_program_id = spr.d_program_id
and dgm.d_geography_master_id = spr.d_geography_master_id
and drp.d_reporting_period_id = spr.d_reporting_period_id
and sprc.d_project_id(+) = spr.d_project_id
and sprc.d_program_id(+) = spr.d_program_id
and sprc.d_geography_master_id(+) = spr.d_geography_master_id
and sprc.d_reporting_period_id(+) = spr.d_reporting_period_id
and sprc.report_type(+) = spr.report_type
and sprc.functional_area(+) = 'Contact Center'
--and spr.functional_area <> md.functional_area
)
loop
  if metcur.s_project_report_id is not null then
     begin
       select count(1) into vcount
       from s_metric smt1
       where smt1.d_metric_definition_id = metcur.d_metric_definition_id
       and smt1.s_actuals_project_report_id = metcur.s_project_report_id;
       if vcount = 0 then
                 dbms_output.put_line (metcur.project_name|| ',' || metcur.program_name || ',' || metcur.geography_name || ',' || metcur.start_date || ',' || metcur.end_date || ',' || metcur.type || ',' || metcur.s_metric_id || ',' || metcur.s_actuals_project_report_id || ',' || metcur.s_project_report_id || ' ,- Can update ');
                 update s_metric smt set s_actuals_project_report_id = metcur.s_project_report_id
                 where smt.s_metric_id = metcur.s_metric_id;
        end if;
        if vcount > 0 then
                 dbms_output.put_line (metcur.project_name|| ',' || metcur.program_name || ',' || metcur.geography_name || ',' || metcur.start_date || ',' || metcur.end_date || ',' || metcur.type || ',' || metcur.s_metric_id || ',' || metcur.s_actuals_project_report_id || ',' || metcur.s_project_report_id  || ',- Cannot update Unique key violated');
                 delete s_metric smt where smt.s_metric_id = metcur.s_metric_id;                 
        end if;
     end;
  end if;
end loop;
end;
/