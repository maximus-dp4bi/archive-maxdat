use HWSInternal;
go

/*
select 'create user ' + upper(NAME) + ' for login ' + upper(NAME) + ';'
from UK_HWS.SYS.DATABASE_PRINCIPALS 
where 
  TYPE_DESC = 'SQL_USER'
  and NAME not in ('DBO','GUEST','INFORMATION_SCHEMA','SYS')
order by NAME asc;
*/
create user AA24065 for login AA24065;
create user DD73742 for login DD73742;
create user DH24064 for login DH24064;
create user GR52181 for login GR52181;
create user JH44463  for login JH44463 ;
create user JK82367 for login JK82367;
create user LG74078 for login LG74078;
create user MAXDAT_REPORTS  for login MAXDAT_REPORTS ;
create user MH73572 for login MH73572;
create user PA28085 for login PA28085;
create user PK34601 for login PK34601;
create user PS55775 for login PS55775;
create user RK50472 for login RK50472;
create user RO38606  for login RO38606 ;
create user SA82368 for login SA82368;
create user SD25802 for login SD25802;
create user SK51922 for login SK51922;
create user SK83026 for login SK83026;
create user SN73555 for login SN73555;
create user SP57859 for login SP57859;
go

/*
select 'execute sp_addrolemember ''MAXDAT_READ_ONLY'',''' + upper(NAME) + ''';'
from UK_HWS.SYS.DATABASE_PRINCIPALS 
where 
  TYPE_DESC = 'SQL_USER'
  and NAME not in ('DBO','GUEST','INFORMATION_SCHEMA','SYS')
order by NAME asc;
*/
execute sp_addrolemember 'MAXDAT_READ_ONLY','AA24065';
execute sp_addrolemember 'MAXDAT_READ_ONLY','DD73742';
execute sp_addrolemember 'MAXDAT_READ_ONLY','DH24064';
execute sp_addrolemember 'MAXDAT_READ_ONLY','GR52181';
execute sp_addrolemember 'MAXDAT_READ_ONLY','JH44463 ';
execute sp_addrolemember 'MAXDAT_READ_ONLY','JK82367';
execute sp_addrolemember 'MAXDAT_READ_ONLY','LG74078';
execute sp_addrolemember 'MAXDAT_READ_ONLY','MAXDAT_REPORTS ';
execute sp_addrolemember 'MAXDAT_READ_ONLY','MH73572';
execute sp_addrolemember 'MAXDAT_READ_ONLY','PA28085';
execute sp_addrolemember 'MAXDAT_READ_ONLY','PK34601';
execute sp_addrolemember 'MAXDAT_READ_ONLY','PS55775';
execute sp_addrolemember 'MAXDAT_READ_ONLY','RK50472';
execute sp_addrolemember 'MAXDAT_READ_ONLY','RO38606 ';
execute sp_addrolemember 'MAXDAT_READ_ONLY','SA82368';
execute sp_addrolemember 'MAXDAT_READ_ONLY','SD25802';
execute sp_addrolemember 'MAXDAT_READ_ONLY','SK51922';
execute sp_addrolemember 'MAXDAT_READ_ONLY','SK83026';
execute sp_addrolemember 'MAXDAT_READ_ONLY','SN73555';
execute sp_addrolemember 'MAXDAT_READ_ONLY','SP57859';