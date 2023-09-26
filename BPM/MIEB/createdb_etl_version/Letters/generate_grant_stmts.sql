select 
case when object_type = 'TABLE' then 'grant select, insert, update, delete on ' || object_name || ' to MAXDAT_MIEB_OLTP_SIUD;'
when object_type = 'VIEW' then 'grant select on ' || object_name || ' to MAXDAT_MIEB_OLTP_SIUD ;'
when object_type in ('FUNCTION','PROCEDURE','PACKAGE') then 'grant execute on ' || object_name || ' to MAXDAT_MIEB_PFP_E ;'
end stmt  
from dba_objects where object_type in ('TABLE','VIEW','FUNCTION','PROCEDURE','PACKAGE') and owner = 'MAXDAT_MIEB'
and created >= trunc(sysdate-1)
union
select
case when object_type = 'TABLE' then 'grant select, insert, update on ' || object_name || ' to MAXDAT_MIEB_OLTP_SIU;'
when object_type = 'VIEW' then 'grant select on ' || object_name || ' to MAXDAT_MIEB_OLTP_SIU ;'
end stmt  
from dba_objects where object_type in ('TABLE','VIEW','FUNCTION','PROCEDURE','PACKAGE') and owner = 'MAXDAT_MIEB'
and created >= trunc(sysdate-1)
