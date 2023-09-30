/* Agents with non-null team on current ver 3 */

-- prev version has null teamid since 17-apr till 18-dec on ver 2
select * from cc_d_acd_agent_team
where agent_login_id in (
'1247673'
)
order by agent_login_id,version

/* Agents with non-null team on current ver 4 */

-- prev ver 3 of below agents have null team ids from eff dts between sep to dec. 
-- ver 3 of these agents can be updated to the most recent team id and record end dt updated to 31-dec-99
-- most recent ver 4 record can be deleted
select * from cc_d_acd_agent_team
where agent_login_id in (
'1275660','1312825','1323475','1323625','1324010','1324032','1324050','1324316','1328207','1331384','1331399','1332122','1332125','1332136','1332161','1332168','1332428','1334795','1334802','1335256','1336481','1336609','1336610','1336611','1336819','1336823','1336958','1336959','1336960','1337637','1337995','1337999','1338001','1338007','1338010','1338056'
)
order by agent_login_id,version

/* Agents with non-null team on current ver 5 */

--prev ver 4 of below agents have null teamid from eff dts between oct and dec
--prev prev ver3 of below agents have non-null teams
-- ver 4 of these agents can be updated to most recent team id and record end dt set to 31-dec-99
-- ver 5 of these agents can be deleted
select * from cc_d_acd_agent_team
where agent_login_id in (
'1266185','1270298','1280612','1281969','1286469','1309696','1312835','1323615','1323748','1324317','1324907','1329203','1332124','1332127','1332156','1332166'
)
and version = 4 and acd_team_id = 0
order by agent_login_id,version


/* Agents with non-null team on current ver 6 */

--prev ver 5 of below agents have null teamids from eff dts between oct & nov 
--prev ver 5 can be updated to most recent teamid and rec end dt to 31-dec-99
-- ver 6 record can be deleted
select * from cc_d_acd_agent_team
where agent_login_id in (
'1285387','1310541','1312833','1316152','1319661','1320120','1320309'
)
order by agent_login_id,version

--prev prev ver 4 of these agents should be updated to non=null teamid 
'1310541','1312833','1316152','1320120'

/* Agents with non-null team on current ver 7 */

--prev ver 6 of below agents should be updated to most recent teamid and rec end dt to 31-dec-99
--ver 7 can be deleted

select * from cc_d_acd_agent_team
where agent_login_id in (
'1004904','1203886','1247995','1320116','1323499'
)
--and version = 5 and acd_team_id = 0
order by agent_login_id,version


/* Agents with non-null team on current ver 8 */

--prev ver 7 of below agents should be updated to most recent teamid and rec end dt to 31-dec-99
--ver 8 can be deleted


select * from cc_d_acd_agent_team
where agent_login_id in (
'1253506','1257315','1312841','1320124'
)
order by agent_login_id,version


/* Agents with non-null team on current ver 20 */

--prev ver 19 of below agents should be updated to most recent teamid and rec end dt to 31-dec-99
--ver 20 can be deleted

select * from cc_d_acd_agent_team
where agent_login_id in (
'1078534'
)
order by agent_login_id,version