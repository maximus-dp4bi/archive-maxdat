/* Agents on curr ver 2 */

--'0126499','0143505' these 2 agents have null teams from 09-april till 18-dec

update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 2 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 1  
and a.acd_team_id = 0
and a.agent_login_id in (
'0333209','0333210','0333211','0333212','0333286','0333287','0333288','0333289','0333409','0333410','0333411','0333412','0333413','0333414','0333415','0333416','0333417'
);

commit;


/* Agents on curr ver 3 */

update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 3 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 2  
and a.acd_team_id = 0
and a.agent_login_id in (
'0067725','0102881','0102885','0102890','0204044','0204050'
);


--'0102881','0102885','0102890' ver=1 of these agents have null team from 09-apr-19 till 19-oct-20
update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 2 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 1  
and a.acd_team_id = 0
and a.agent_login_id in (
'0067725'
);


commit;


/* Agents on curr ver 4 */


update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 4 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 3  
and a.acd_team_id = 0
and a.agent_login_id in (
'0204027','0204048','0204053','0204065','0277740','0277749','0277754','0277755','0277764','0300979','0327895','0327900','0333358','0333375','0333488','0333489'
);

--'0204027','0204048','0204053','0204065' agents have null teams on ver=2 between 22-oct-19 and 19-oct-20

commit;


/* Agents on curr ver 5 */

update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 5 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 4  
and a.acd_team_id = 0
and a.agent_login_id in (
'0080969','0202744','0203822','0204060','0277747','0277760','0302639','0302735','0321059','0321065','0321749','0322146','0322190','114517','57039'
);

update cc_d_acd_agent_team 
 set acd_team_id = 5463
 where agent_login_id = '0204060'
 and acd_team_id=0
 and version in (2,3);

-- '0204060' this agent has null team on ver=2 between 22-oct-19 and 02-nov-20

commit;


/* Agents on curr ver 6 */

update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 6 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 5  
and a.acd_team_id = 0
and a.agent_login_id in (
'0277763','0278161','0278370'
);

commit;


/* Agents on curr ver 7 */

update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 7 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 6  
and a.acd_team_id = 0
and a.agent_login_id in (
'0203811','59404'
);

update cc_d_acd_agent_team 
 set acd_team_id = 5472
 where agent_login_id = '59404'
 and acd_team_id=0
 and version =5;

commit;


/* Agents on curr ver 8 */

update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 8 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 7  
and a.acd_team_id = 0
and a.agent_login_id in (
'124986'
);

commit;


/* Agents on curr ver 9 */

update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 9 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 8  
and a.acd_team_id = 0
and a.agent_login_id in (
'0269417'
);

commit;



/* Agents on curr ver 14 */

update cc_d_acd_agent_team a
set a.acd_team_id = (select b.acd_team_id from cc_d_acd_agent_team b
                          where b.version = 14 and b.agent_login_id = a.agent_login_id and b.acd_team_id != 0)
where a.version = 13  
and a.acd_team_id = 0
and a.agent_login_id in (
'0059669'
);

update cc_d_acd_agent_team 
 set acd_team_id = 5463
 where agent_login_id = '0059669'
 and acd_team_id=0
 and version=12;
 
 -- '0059669' agent has null team on ver=11 between 11-jun-20 and 27-sep-20
 
update cc_d_acd_agent_team
 set acd_team_id = 5169
 where agent_login_id in (
  '0080969','0321059','0321065','0321749','0322146','0322190','0327895','0327900','0333358','0333375','0333488','0333489'
)
 and acd_team_id=0
 and version=1;

commit;



/* Agents that have null teams between 01-sep-20 and 18-dec-20 with most recent version having existing teams before data fix */

update cc_d_acd_agent_team 
 set acd_team_id = 5358
 where agent_login_id = '0276738'
 and acd_team_id=0
 and version=9;
 
update cc_d_acd_agent_team 
 set acd_team_id = 5387
 where agent_login_id = '1281187'
 and acd_team_id=0
 and version=8;
 
update cc_d_acd_agent_team 
 set acd_team_id = 5387
 where agent_login_id in ('1294101','1305989')
 and acd_team_id=0
 and version=8;
 
update cc_d_acd_agent_team 
 set acd_team_id = 5387
 where agent_login_id in ('1308801','1308807')
 and acd_team_id=0
 and version=3;
 
update cc_d_acd_agent_team 
 set acd_team_id = 5387
 where agent_login_id in ('1336698','1336706','1336746','1336747','1336748','1336950','1336955')
 and acd_team_id=0
 and version=1;

update cc_d_acd_agent_team 
 set acd_team_id = 5286
 where agent_login_id in ('0114560')
 and acd_team_id=0
 and version=1; 
 
 update cc_d_acd_agent_team 
 set acd_team_id = 5018
 where agent_login_id in ('0078469')
 and acd_team_id=0
 and version=1; 

update cc_d_acd_agent_team 
 set acd_team_id = 5064
 where agent_login_id in ('0153751')
 and acd_team_id=0
 and version=4; 

update cc_d_acd_agent_team 
 set acd_team_id = 5169
 where agent_login_id in ('0085244','0301957','0321058','0321063','0321064','0321067','0321069','0321752','0321754','0321881','0322135','0322153','0322160','0322173','0322194','0322209','0322213','0322222','0323997','0324015','0324019','0324021','0324024','0327783','0327785','0327786','0327787','0327788','0327790','0327791','0327792','0327896','0327897','0327899','0327902','0328114','0328117','0328118','0328120','0328122','0328127','0328131','0328151','0328152','0328153','0328163','0328170','0328179','0328188','0328191','0328202','0328203','0328213','0328214','0328215','0328316','0333331','0333342','0333343','0333344','0333345','0333355','0333372','0333374','0333385','0333391','0333399','0333401','0333402','0333406','0333482','0333483','0333484','0333485','0333486','0333487','0333490','0333491','0333492','0333493','0333494','0333496','0333497','0333623','0333627','0333629','0333635','0333794','0337725','0337729','0337734','0337744','0337746','0337751','0337753','0337754','0337757','0337760','0337769','0337773','0337867','0337869','0337870','0337872','0337875','0337876','0337877','0337878','0337879','0337880','0337881','0337882','0337883','0337939','0337941','0337944','0337949','0337953','0337956','0337957','0337959','0337960','0337962','0337965','0337977','0337983','0337985','0337986','0337992','0338167'
)
 and acd_team_id=0
 and version=1; 
 
 update cc_d_acd_agent_team 
 set acd_team_id = 5321
 where agent_login_id in ('78462')
 and acd_team_id=0
 and version=1; 
 
commit;