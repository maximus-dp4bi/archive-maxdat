prompt PL/SQL Developer import file
prompt Created on Monday, August 14, 2017 by m18957
set feedback off
set define off
prompt Loading HCO_TRACK_DOWNTIME...
insert into HCO_TRACK_DOWNTIME (track_id, sys_id, incident_date, scheduled, ticket_id, actual_downtime_in_mins, comments)
values (1, 10, to_date('17-03-2017', 'dd-mm-yyyy'), 'Y', 0, 2, 'MS WINDOWS PATCHING');
insert into HCO_TRACK_DOWNTIME (track_id, sys_id, incident_date, scheduled, ticket_id, actual_downtime_in_mins, comments)
values (2, 10, to_date('17-03-2017', 'dd-mm-yyyy'), 'Y', 0, 3, 'MELISSA DATA UPDATES');
commit;
prompt 2 records loaded
set feedback on
set define on
prompt Done.
