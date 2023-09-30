/*
Created on 13-Oct-2017 by Guy T.
Description: When ever the source has a null, MW will insert a zero value for Group_ID & Team_ID. This is done for Microstrategy's reports design. 

*/
insert into D_BUSINESS_UNITS values (0,null,null);

insert into d_teams values (0,null,null,0);
commit;