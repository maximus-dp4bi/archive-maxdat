/*
Created on 06-Oct-2014 by Raj A.
Description: When ever the source has a null, MW V2 will insert a zero value for Group_ID & Team_ID. This is done for Microstrategy's reports design. 

v2 11/06/2014 Raj A. Added D_BUSINESS_UNITS 
12/23/2014 Raj A. Dropped the following columns, D_BUSINESS_UNITS.Business_unit Sup_id, D_BUSINESS_UNITS.business_unti parent_id, D_teams.team_parent_id. Hence,
				  modifiying the below DMLs too.
*/
insert into D_BUSINESS_UNITS values (0,null,null);

insert into d_teams values (0,null,null,0);
commit;