BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE (
   name                 => 'REFRESH_APPEAL_CUBE_MVIEWS',
   attribute            => 'start_date',
   value                => TO_TIMESTAMP_TZ('12-DEC-2019 01:05:00 -05:00' ,'DD-MON-YYYY HH24:MI:SS TZR'));
END;
/
