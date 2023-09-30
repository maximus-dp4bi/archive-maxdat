/*
Created on 11/21/2014 by Raj A.
Decsription: After exchanging many emails on 11/21, decided to remove this column.
*/
alter table d_teams drop column parent_team_id;

create or replace view D_TEAMS_SV as
select * from D_TEAMS
with read only;

grant select on D_TEAMS_SV to MAXDAT_READ_ONLY;