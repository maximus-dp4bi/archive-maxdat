BEGIN
  dbms_scheduler.drop_job(job_name => 'RECOMPILE_SCHEMA');
END;
/

BEGIN
DBMS_SCHEDULER.CREATE_JOB (
job_name => '"MAXDAT_SUPPORT"."RECOMPILE_SCHEMA"',
job_type => 'PLSQL_BLOCK',
job_action => 'BEGIN
FOR cur_rec IN (SELECT owner,
object_name,
object_type
FROM all_objects
WHERE object_type IN (''VIEW'')
AND status != ''VALID''
AND owner=''MAXDAT_SUPPORT''
ORDER BY 3)
LOOP
BEGIN
IF cur_rec.object_type = ''VIEW'' THEN
EXECUTE IMMEDIATE ''ALTER '' || cur_rec.object_type ||
'' "'' || cur_rec.owner || ''"."'' || cur_rec.object_name || ''" COMPILE'';
END IF;
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(cur_rec.object_type || '' : '' || cur_rec.owner ||
'' : '' || cur_rec.object_name);
END;
END LOOP;
END;
',
number_of_arguments => 0,
start_date => NULL,
repeat_interval => 'FREQ=DAILY;BYTIME=150000;BYDAY=MON,TUE,WED,THU,FRI,SAT,SUN',
end_date => NULL,
enabled => FALSE,
auto_drop => FALSE,
comments => '');

 DBMS_SCHEDULER.SET_ATTRIBUTE(
name => '"MAXDAT_SUPPORT"."RECOMPILE_SCHEMA"',
attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_OFF);
DBMS_SCHEDULER.enable(
name => '"MAXDAT_SUPPORT"."RECOMPILE_SCHEMA"');
END;
/