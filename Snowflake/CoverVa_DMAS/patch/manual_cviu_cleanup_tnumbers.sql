
update coverva_dmas.manual_cviu_tracking c
set application_number = t.nwapp
from(
select coalesce(t_search,t) app_number,
  case when t_search is not null then 
     case when regexp_instr(t_search,'/') > 0 then left(t_search,regexp_instr(t_search,'/')-1) 
          when regexp_instr(t_search,';') > 0 then left(t_search,regexp_instr(t_search,';')-1) 
          when regexp_instr(t_search,'-') > 0 then left(t_search,regexp_instr(t_search,'-')-1) 
   else t_search end
  else  case when t like '%+08' or t like '%+09' then null 
             when regexp_instr(t,'/') > 0 then left(t,regexp_instr(t,'/')-1) 
          else t end end nwapp
from coverva_dmas.manual_cviu_tracking) t
where coalesce(c.t_search,c.t) = t.app_number;

select t,t_search,application_number
from coverva_dmas.manual_cviu_tracking
where upper(application_number) not like 'T%';

update coverva_dmas.manual_cviu_tracking
set application_number = concat('T',application_number)
where upper(application_number) not like 'T%';

update coverva_dmas.manual_cviu_tracking
set application_number = null
where application_number in('https:','654654','6454654','900376');

update coverva_dmas.manual_cviu_tracking
set application_number = 'T114431547'
where application_number = '114431547v';

select t,t_search,application_number
from coverva_dmas.manual_cviu_tracking
where application_number like 't%';

update coverva_dmas.manual_cviu_tracking
set application_number = UPPER(application_number)
where application_number like 't%';

select t,t_search,application_number
from coverva_dmas.manual_cviu_tracking
where application_number like 'TASK%';

update coverva_dmas.manual_cviu_tracking
set application_number = null
where application_number like 'TASK%';

select t, LEFT(t,regexp_instr(t,'/')-1) from coverva_dmas.manual_cpu_Tracking
where t like 'T%'
and regexp_instr(t,'/') > 0
;

select * from coverva_dmas.manual_cpu_Tracking
where application_number is null
;

update coverva_dmas.manual_cpu_Tracking
set application_number = t
where t like 'T%'
and regexp_instr(t,'/') = 0;

update coverva_dmas.manual_cpu_Tracking
set application_number = LEFT(t,regexp_instr(t,'/')-1)
where t like 'T%'
and regexp_instr(t,'/') > 0;

update coverva_dmas.manual_cpu_Tracking
set application_number = TRIM(REPLACE(t,'?',''))
where application_number is null
and t like '?%';


update coverva_dmas.manual_cpu_Tracking
set application_number = TRIM(REPLACE(t,':',''))
where application_number is null
and t like ':%';

update coverva_dmas.manual_cpu_Tracking
set application_number = TRIM(REPLACE(t,'#',''))
where application_number is null
and t like '#%';

update coverva_dmas.manual_cpu_Tracking
set application_number = 'T22778804'
where application_number is null
and t = '(T)22778804';

select t,right(t,9)
from coverva_dmas.manual_cpu_Tracking
where application_number is null
and regexp_instr(t,'/') > 0;

update coverva_dmas.manual_cpu_Tracking
set application_number = right(t,9)
where application_number is null
and regexp_instr(t,'/') > 0;

update coverva_dmas.manual_cpu_Tracking
set application_number = concat('T',t)
where application_number is null
and t not in('shankar','Ruiz Pellachini');