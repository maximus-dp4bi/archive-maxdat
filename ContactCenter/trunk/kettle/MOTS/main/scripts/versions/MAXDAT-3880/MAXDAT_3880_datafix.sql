
begin
  for metcur in (
select
  dpj.PROJECT_NAME,
  dpg.PROGRAM_NAME,
  dmd.LABEL,
  drp.type reporting_period_type,
  to_char(drp.END_DATE,'YYYY-MM-DD') enddate,
  sm.ACTUAL_VALUE s_metric_actual_value,
  fm.ACTUAL_VALUE f_metric_actual_value,
  sm.actual_received_date s_metric_actual_date,
  fm.actual_received_date f_metric_actual_date,
  sm.s_metric_id,
  fm.f_metric_id,
  sm.actual_value_not_supplied s_actual_not_supplied,
  fm.actual_value_not_supplied f_actual_not_supplied,
  sm.last_modified_date s_last_mod_date,
  fm.last_modified_date f_last_mod_date,
  sm.updated_by s_last_mod_by,
  fm.updated_by f_last_mod_by
-- dmp.LAST_MODIFIED_DATE metric_proj_last_mod_date
from F_METRIC fm
inner join mots.D_METRIC_PROJECT dmp on fm.D_METRIC_PROJECT_ID = dmp.D_METRIC_PROJECT_ID
inner join mots.D_METRIC_DEFINITION dmd on dmp.D_METRIC_DEFINITION_ID = dmd.D_METRIC_DEFINITION_ID
inner join mots.S_METRIC sm on dmp.D_METRIC_DEFINITION_ID = sm.D_METRIC_DEFINITION_ID
inner join mots.D_PROJECT dpj on dmp.D_PROJECT_ID = dpj.D_PROJECT_ID
inner join mots.D_PROGRAM dpg on dmp.D_PROGRAM_ID = dpg.D_PROGRAM_ID
inner join mots.S_PROJECT_REPORT spr on
  sm.S_ACTUALS_PROJECT_REPORT_ID = spr.S_PROJECT_REPORT_ID
  and dmp.D_PROJECT_ID = spr.D_PROJECT_ID
  and dmp.D_PROGRAM_ID = spr.D_PROGRAM_ID
  and dmp.D_GEOGRAPHY_MASTER_ID = spr.D_GEOGRAPHY_MASTER_ID
  and fm.D_REPORTING_PERIOD_ID = spr.D_REPORTING_PERIOD_ID
inner join D_REPORTING_PERIOD drp on fm.D_REPORTING_PERIOD_ID = drp.D_REPORTING_PERIOD_ID
where
  spr.APPROVED = '1'
  and (fm.ACTUAL_VALUE != sm.ACTUAL_VALUE or (fm.ACTUAL_VALUE is null and sm.ACTUAL_VALUE is not null) or (fm.ACTUAL_VALUE is not null and sm.ACTUAL_VALUE is null)
        or (sm.actual_value_not_supplied is null and fm.actual_value_not_supplied = 'Y') or (sm.actual_value_not_supplied = 'Y' and fm.actual_value_not_supplied is null))
order by
  dpj.PROJECT_NAME,
  dpg.PROGRAM_NAME,
  dmd.LABEL,
  drp.END_DATE
  )
 loop
 DBMS_OUTPUT.ENABLE (buffer_size => NULL); 
 if nvl(metcur.s_metric_actual_value,-1) <> nvl(metcur.f_metric_actual_value,-1) then
   if  metcur.s_last_mod_date < metcur.f_last_mod_date  then
       dbms_output.put_line('Updating s_METRIC ' || metcur.PROJECT_NAME ||'/'|| metcur.PROGRAM_NAME||'/'|| metcur.LABEL||'/'|| metcur.reporting_period_type || '/'||metcur.ENDDATE || '  ' || metcur.s_metric_id || ' old_value = ' || metcur.s_metric_actual_value || '  new value = ' || metcur.f_metric_actual_value );
       update s_metric smet set smet.actual_value = metcur.f_metric_actual_value, smet.actual_received_date = metcur.f_metric_actual_date
       where smet.s_metric_id = metcur.s_metric_id;
   elsif metcur.s_last_mod_date > metcur.f_last_mod_date then
       dbms_output.put_line('Updating f_METRIC ' || metcur.PROJECT_NAME ||'/'|| metcur.PROGRAM_NAME||'/'|| metcur.LABEL||'/'|| metcur.reporting_period_type || '/'|| metcur.ENDDATE || '  ' || metcur.f_metric_id || ' old_value = ' || metcur.f_metric_actual_value || '  new value = ' || metcur.s_metric_actual_value );
       update f_metric fmet set fmet.actual_value = metcur.s_metric_actual_value, fmet.actual_received_date = metcur.s_metric_actual_date
       where fmet.f_metric_id = metcur.f_metric_id;
   end if;   
 end if;     
 end loop;

 end;
 
