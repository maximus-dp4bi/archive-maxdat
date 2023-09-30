alter session set current_schema = cisco_enterprise_cc;

update cc_d_acd_agent_team
set acd_team_id = 5485
where agent_login_id = '1153351'
and version = 2;

update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 3 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 2      
and a.acd_team_id = 0
and a.agent_login_id in ('1127762','1153351','1202366','1202399','1318002','1318079','1318091','1325123','1325128','1325657','1331570','1331616','1331621','1331625','1331634','1332091','1332647','1333362','1335590','1335784','1338296',
'1338299','1338300','1338301','1338302','1338304','1338305','1338311','1338312','1338321','1338324','1338331','1338333','1338334','1338336','1338340','1338351','1338354','1338356','1338357','1338364','1338369','1338376','1338378','1338384','1338385','1338386','1338472','1338474','1338476','1338477','1338478','1338480','1338482','1338483','1338484','1338487','1338488','1338490','1338491','1338605','1338763')
;


update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 2 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 1      
and a.acd_team_id = 0
and a.agent_login_id in ('1127762','1153351','1202366','1202399','1318002','1318079','1318091','1325123','1325128','1325657','1331570','1331616','1331621','1331625','1331634','1332091','1332647','1333362','1335590','1335784','1338296',
'1338299','1338300','1338301','1338302','1338304','1338305','1338311','1338312','1338321','1338324','1338331','1338333','1338334','1338336','1338340','1338351','1338354','1338356','1338357','1338364','1338369','1338376','1338378','1338384','1338385','1338386','1338472','1338474','1338476','1338477','1338478','1338480','1338482','1338483','1338484','1338487','1338488','1338490','1338491','1338605','1338763')
;


update cc_d_acd_agent_team
set acd_team_id = 5361
where version in (4,5)
and agent_login_id like '%277268%';

update cc_d_acd_agent_team
set acd_team_id = 5485
where version in (7)
and agent_login_id like '%277268%';


update cc_d_Acd_agent_team
set acd_team_id = 5470
where agent_login_id in (
'1324736'
)
and version < 5 ;


update cc_d_acd_agent_team
set acd_team_id = 5455
where agent_login_id in ('1318002',
'1318079',
'1318091')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5473
where agent_login_id in ('1338329', '1338485')
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5466
where agent_login_id = '1338345'
and acd_team_id = 0;

update cc_d_acd_agent_team
set acd_team_id = 5444
where agent_login_id in ('0136760',
'1298812',
'1318005')
and 
version in (1,2);

update cc_d_acd_agent_team
set acd_team_id = 5444
where agent_login_id in (
'1318005')
and 
version in (3);

update cc_d_acd_agent_team
set acd_team_id = 5457
where agent_login_id in ('1298812')
and 
version in (3);


update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.agent_login_id = a.agent_login_id
                          and b.version = 6 and b.acd_team_id != 0)
where a.version = 5
and a.acd_team_id = 0
and a.agent_login_id in ('1331640',
'1337021',
'1337022',
'1337023',
'1337030',
'1337035',
'1337038',
'1337039',
'1337048',
'1337051',
'1337053',
'1337055',
'1337175',
'1337181',
'1337183',
'1337184',
'1337186',
'1337396',
'1337399',
'1337401',
'1337404',
'1337413',
--'1337421',
'1337423',
'1337451',
'1337452',
'1337491',
'1337498',
'1337526',
'1337624',
'1337625',
'1337627',
'1337634',
'1337724',
'1337726',
'1337738',
'1337742',
'1337743',
'1337750',
'1337764',
'1337765',
'1337767',
'1337775',
'1200313',
'1279694',
--'1298812',
'1300416'
--'1298812'
);


update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.agent_login_id = a.agent_login_id
                          and b.version = 5 and b.acd_team_id != 0)
where a.version = 4
and a.acd_team_id = 0
and a.agent_login_id in ('1331640',
'1337021',
'1337022',
'1337023',
'1337030',
'1337035',
'1337038',
'1337039',
'1337048',
'1337051',
'1337053',
'1337055',
'1337175',
'1337181',
'1337183',
'1337184',
'1337186',
'1337396',
'1337399',
'1337401',
'1337404',
'1337413',
--'1337421',
'1337423',
'1337451',
'1337452',
'1337491',
'1337498',
'1337526',
'1337624',
'1337625',
'1337627',
'1337634',
'1337724',
'1337726',
'1337738',
'1337742',
'1337743',
'1337750',
'1337764',
'1337765',
'1337767',
'1337775',
'1200313',
'1279694',
--'1298812',
'1300416'
--'1298812'
);

update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.agent_login_id = a.agent_login_id
                          and b.version = 4 and b.acd_team_id != 0)
where a.version = 3
and a.acd_team_id = 0
and a.agent_login_id in ('1331640',
'1337021',
'1337022',
'1337023',
'1337030',
'1337035',
'1337038',
'1337039',
'1337048',
'1337051',
'1337053',
'1337055',
'1337175',
'1337181',
'1337183',
'1337184',
'1337186',
'1337396',
'1337399',
'1337401',
'1337404',
'1337413',
--'1337421',
'1337423',
'1337451',
'1337452',
'1337491',
'1337498',
'1337526',
'1337624',
'1337625',
'1337627',
'1337634',
'1337724',
'1337726',
'1337738',
'1337742',
'1337743',
'1337750',
'1337764',
'1337765',
'1337767',
'1337775',
'1200313',
'1279694',
--'1298812',
'1300416'
--'1298812'
);

update cc_d_acd_agent_team
set acd_team_id = 5457
where version = 3
and agent_login_id = '1298812';

update cc_d_acd_agent_team
set acd_team_id = 5457
where version in (3,4)
and agent_login_id = '1337421';


update cc_d_acd_agent_team
set acd_team_id = 5387
where version in (1)
and agent_login_id = '1337634';

update cc_d_acd_agent_team
set acd_team_id = 5485
where acd_team_id = 0 and version = 3
and agent_login_id in ('1143524', '1247430');

update cc_d_acd_agent_team
set acd_team_id = 5455
where acd_team_id = 0 
and agent_login_id in ('1332004');

update cc_d_acd_agent_team
set acd_team_id = 5470
where acd_team_id = 0 
and agent_login_id in ('1338381');

update cc_d_acd_agent_team
set acd_team_id = 5485
where agent_login_id = '1110614'
and acd_team_id = 0
and version in (6,7,8);

update cc_d_acd_agent_team
set acd_team_id = 5485
where agent_login_id = '1272268'
and acd_team_id = 0
and version in (7,6,5);

update cc_d_acd_agent_team
set acd_team_id = 5485
where agent_login_id = '1269227'
and acd_team_id = 0
and version in (6);

update cc_d_acd_agent_team
set acd_team_id = 5485
where agent_login_id in ('1326150','1326171','1326200')
and acd_team_id = 0
;

update cc_d_acd_agent_team
set acd_team_id = 5466
where agent_login_id in ('1326149')
and acd_team_id = 0
;

update cc_d_acd_agent_team
set acd_team_id = 5470
where agent_login_id in ('1326154')
and acd_team_id = 0
;

update cc_d_acd_agent_team
set acd_team_id = 5473
where agent_login_id in ('1326193')
and acd_team_id = 0
;

update cc_d_acd_agent_team
set acd_team_id = 5485
where agent_login_id in ('1146801')
and acd_team_id = 0 and version = 4
;

update cc_d_acd_agent_team
set acd_team_id = 5473
where agent_login_id in ('1326146', '1326184', '1326186')
and acd_team_id = 0 --and version = 4
;

update cc_d_acd_agent_team
set acd_team_id = 5470
where agent_login_id in ('1326148')
and acd_team_id = 0 --and version = 4
;

update cc_d_acd_agent_team
set acd_team_id = 5474
where agent_login_id in ('1326151')
and acd_team_id = 0 --and version = 4
;

update cc_d_acd_agent_team
set acd_team_id = 5466
where agent_login_id in ('1326155', '1326199')
and acd_team_id = 0 --and version = 4
;

update cc_d_acd_agent_team
set acd_team_id = 5470
where agent_login_id in ('1326157', '1326182')
and acd_team_id = 0 --and version = 4
;

update cc_d_acd_agent_team
set acd_team_id = 5474
where agent_login_id in ('1326158')
and acd_team_id = 0 --and version = 4
;


update cc_d_acd_agent_team
set acd_team_id = 5471
where agent_login_id in ('1326161', '1326164')
and acd_team_id = 0 --and version = 4
;

update cc_d_acd_agent_team
set acd_team_id = 5466
where agent_login_id in ('1326163')
and acd_team_id = 0 --and version = 4
;

update cc_d_acd_agent_team
set acd_team_id = 5465
where agent_login_id in ('1326169', '1326180')
and acd_team_id = 0 --and version = 4
;

update cc_d_acd_agent_team
set acd_team_id = 5474
where agent_login_id in ('1326172', '1326181')
and acd_team_id = 0 --and version = 4
;

commit;
