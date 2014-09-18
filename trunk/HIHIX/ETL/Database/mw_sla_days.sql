create table D_MW_SLA
(
task_type varchar2(100) not null
, sla_days_type varchar2(1) not null
, sla_days number
, sla_target_days number
, sla_jeopardy_days number
);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Outbound email other','C',	2,	0,	1);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Oubound fax other','C',	2	,0,	1);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Incoming email application','C',2	,0,	1);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Incoming email complaint','C',2	,0,	1);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Incoming email appeal','C',2,	0	,1);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Incoming email other','C',2	,0,	1);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Outbound email form','C',2	,0	,1);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Incoming fax application','C',2	,0,	1);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Incoming fax complaint','C',2	,0,	1);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Incoming fax appeal','C',2,	0	,1);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Incoming fax other','C',2	,0,	1);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Outbound fax application','C',2	,0	,1);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Voicemail','C',3	,1,	2);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Outgoing USPS other','C',45,	30,	27);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Incoming USPS application','C',	45,	30,	27);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Incoming USPS complaint','C',45,	30,	27);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Incoming USPS appeal','C',45	,30	,27);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Incoming USPS other','C',45	,30,	27);
insert into d_mw_sla (task_type, sla_days_type, sla_days, sla_target_days, sla_jeopardy_days) values('Outgoing USPS form','C',45	,30,	27);
commit;

create or replace view d_mw_sla_sv as
select w."Task ID", s.sla_days "SLA Days", s.sla_days_type "SLA Days Type"
, s.sla_jeopardy_days "SLA Jeopardy Days", s.sla_target_days "SLA Target Days"
, case when w."Complete Date" is null and w."Cancel Work Date" is null then 'Not Complete'
  when w."Cancel Work Date" is not null then 'Not Required'
  when s.sla_days_type = 'C' and "Age in Calendar Days" > s.sla_days then 'Untimely'
  when s.sla_days_type = 'B' and "Age in Business Days" > s.sla_days then 'Untimely'
  else 'Timely' end as "Timeliness Status"
, case when w."Complete Date" is not null then 'N'
  when w."Cancel Work Date" is not null then 'N'
  when s.sla_days_type = 'C' and "Age in Calendar Days" >= s.sla_jeopardy_days then 'Y'
  when s.sla_days_type = 'B' and "Age in Business Days" > s.sla_jeopardy_days then 'Y'
  else 'N' end as "Jeopardy Flag"
from d_mw_current_sv w
inner join d_mw_sla s on w."Current Task Type" = s.task_type;
grant select on d_mw_sla to maxdat_read_only;
grant select on d_mw_sla_sv to maxdat_read_only;