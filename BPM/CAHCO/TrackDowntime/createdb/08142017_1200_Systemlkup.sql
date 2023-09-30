prompt PL/SQL Developer import file
prompt Created on Monday, August 14, 2017 by m18957
set feedback off
set define off
prompt Loading HCO_SYSTEM_LKUP...
insert into HCO_SYSTEM_LKUP (sys_id, system_name, bus_avail_starttime, bus_avail_endtime, total_bus_avail_in_mins, downtime_allowed_in_mins, active)
values (1, 'HPE PHONE SYSTEM', '07:00', '18:00', 660, 30, 'Y');
insert into HCO_SYSTEM_LKUP (sys_id, system_name, bus_avail_starttime, bus_avail_endtime, total_bus_avail_in_mins, downtime_allowed_in_mins, active)
values (2, 'BIZ TALK SYSTEM', '07:00', '18:00', 660, 30, 'Y');
insert into HCO_SYSTEM_LKUP (sys_id, system_name, bus_avail_starttime, bus_avail_endtime, total_bus_avail_in_mins, downtime_allowed_in_mins, active)
values (3, 'CRM SYSTEM', '07:00', '18:00', 660, 30, 'Y');
insert into HCO_SYSTEM_LKUP (sys_id, system_name, bus_avail_starttime, bus_avail_endtime, total_bus_avail_in_mins, downtime_allowed_in_mins, active)
values (4, 'NAVISION SYSTEM', '07:00', '18:00', 660, 30, 'Y');
insert into HCO_SYSTEM_LKUP (sys_id, system_name, bus_avail_starttime, bus_avail_endtime, total_bus_avail_in_mins, downtime_allowed_in_mins, active)
values (5, 'HYLAND SYSTEM', '07:00', '18:00', 660, 30, 'Y');
insert into HCO_SYSTEM_LKUP (sys_id, system_name, bus_avail_starttime, bus_avail_endtime, total_bus_avail_in_mins, downtime_allowed_in_mins, active)
values (6, 'DIALOGUE SYSTEM', '07:00', '18:00', 660, 30, 'Y');
insert into HCO_SYSTEM_LKUP (sys_id, system_name, bus_avail_starttime, bus_avail_endtime, total_bus_avail_in_mins, downtime_allowed_in_mins, active)
values (7, 'SQL SERVER REPORTING SERVICES', '07:00', '18:00', 660, 30, 'Y');
insert into HCO_SYSTEM_LKUP (sys_id, system_name, bus_avail_starttime, bus_avail_endtime, total_bus_avail_in_mins, downtime_allowed_in_mins, active)
values (8, 'PROBLEM CORRECTION PROCESS', '07:00', '18:00', 660, 30, 'Y');
insert into HCO_SYSTEM_LKUP (sys_id, system_name, bus_avail_starttime, bus_avail_endtime, total_bus_avail_in_mins, downtime_allowed_in_mins, active)
values (9, 'DATA WAREHOUSE', '07:00', '18:00', 660, 30, 'Y');
insert into HCO_SYSTEM_LKUP (sys_id, system_name, bus_avail_starttime, bus_avail_endtime, total_bus_avail_in_mins, downtime_allowed_in_mins, active)
values (10, 'CUSTOMER SERVICE PORTAL (CSP)', '04:00', '02:00', 1320, 30, 'Y');
insert into HCO_SYSTEM_LKUP (sys_id, system_name, bus_avail_starttime, bus_avail_endtime, total_bus_avail_in_mins, downtime_allowed_in_mins, active)
values (11, 'SECURE DATA EXCHANGE SERVICE (SDES)', '04:00', '02:00', 1320, 30, 'Y');
commit;
prompt 11 records loaded
set feedback on
set define on
prompt Done.
