/* Agents on curr ver 4 */


update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 4 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 3  
and a.acd_team_id = 0
and a.agent_login_id in (
'1275660','1312825','1323475','1323625','1324010','1324032','1324050','1324316','1328207','1331384','1331399','1332122','1332125','1332136','1332161','1332168','1332428','1334795','1334802','1335256','1336481','1336609','1336610','1336611','1336819','1336823','1336958','1336959','1336960','1337637','1337995','1337999','1338001','1338007','1338010','1338056'
);


commit;


/* Agents on curr ver 5 */

update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 5 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 4  
and a.acd_team_id = 0
and a.agent_login_id in (
'1266185','1270298','1280612','1281969','1286469','1309696','1312835','1323615','1323748','1324317','1324907','1329203','1332124','1332127','1332156','1332166'
);

commit;


/* Agents on curr ver 6 */

update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 6 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 5  
and a.acd_team_id = 0
and a.agent_login_id in (
'1285387','1310541','1312833','1316152','1319661','1320120','1320309'
);


update cc_d_acd_agent_team
  acd_team_id = 5461
where agent_login_id in (
'1310541','1312833','1316152','1320120'
)
and vesion = 4;

commit;


/* Agents on curr ver 7 */

update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 7 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 6  
and a.acd_team_id = 0
and a.agent_login_id in (
'1004904','1203886','1247995','1320116','1323499'
);

commit;


/* Agents on curr ver 8 */

update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 8 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 7  
and a.acd_team_id = 0
and a.agent_login_id in (
'1253506','1257315','1312841','1320124'
);

commit;


/* Agents on curr ver 20 */

update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 20 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 19  
and a.acd_team_id = 0
and a.agent_login_id in (
'1078534'
);

commit;


-----Added by Lavanya

update cc_d_acd_agent_team
set acd_team_id = 5154
where version = 4
and agent_login_id = '1319186'
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5431
where version = 4
and agent_login_id in ('1324045','1324643')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5430
where version = 3
and agent_login_id = '1324052'
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5429
where version in (6)
and agent_login_id in ('1316093','1316148')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5429
where version in (4)
and agent_login_id in ('1278415', '1324488')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5429
where version in (4,5)
and agent_login_id in ('1316017')
and acd_team_id = 0;


update cc_d_acd_agent_team
set acd_team_id = 5429
where version in (3)
and agent_login_id in ('1324423', '1330528', '1332158','1323689', '1323996' )
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5395
where version in (1)
and agent_login_id in ('1278415', '1316017', '1316093', '1316148', '1323689', '1323996', '1324423', '1324488', '1330528', '1332158')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5429
where version in (1)
and agent_login_id in ('1332162' )
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5395
where version in (1)
and agent_login_id in ('1324051', '1324418')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5427
where version in (3)
and agent_login_id in ('1324051', '1324418')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5426
where version in (4)
and agent_login_id in ('1322348', '1323572')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5395
where version in (1)
and agent_login_id in ('1322348', '1323572')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5425
where version in (4,5)
and agent_login_id in ('1316019', '1316090')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5395
where version in (1)
and agent_login_id in ('1316019', '1316090', '1320114')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5425
where version in (5)
and agent_login_id in ('1320114')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5396
where version in (1)
and agent_login_id in ('1329965')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5395
where version in (1)
and agent_login_id in ('1338010')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5426
where version in (6,7)
and agent_login_id in ('1073435')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5369
where version in (1)
and agent_login_id in ('1319747',
'1324004',
'1324027',
'1324379',
'1324384',
'1324403',
'1123244',
'1329212')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5154
where version in (1)
and agent_login_id in ('1328345')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5427
where version in (4)
and agent_login_id in ('1309993')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5431
where version in (8)
and agent_login_id in ('1299172')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5422
where version in (6,5)
and agent_login_id in ('1299172')
and acd_team_id = 0;

commit;
