insert into d_staff(staff_id,first_name,last_name,middle_name)
select staff_id,trim(first_name),trim(last_name),trim(mi)
from arena_staff_stg;

insert into d_staff(staff_id,first_name,last_name)
values(0,'Unknown Staff','Unknown');

insert into d_teams(team_id,team_description,team_name,team_supervisor_staff_id)
values(0,'Unknown Team','Unknown Team',0);

insert into d_teams(team_id,team_description,team_name,team_supervisor_staff_id)
select rownum, d.*
from (
select distinct 
      'Team '||sup_staff_id team_name
      ,'Team '||sup_staff_id team_desc
      ,sup_staff_id
from arena_staff_stg )d;


commit;