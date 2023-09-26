drop view MAXDAT.D_INCIDENT_STATUS_HISTORY_SV;
drop table MAXDAT.INCIDENT_STATUS_HISTORY;

declare
  procedure run(p_sql varchar2) as
  begin
    execute immediate p_sql;
  end;
begin		
 run('rename "D_INCIDENT_STATUS_HISTORY_OLD_SV" to D_INCIDENT_STATUS_HISTORY_SV');
 run('alter view  "MAXDAT".D_INCIDENT_STATUS_HISTORY_SV compile');
end;

