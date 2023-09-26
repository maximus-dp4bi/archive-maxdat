grant MAXDAT_MIEB_OLTP_SIU to sr18956;
grant MAXDAT_MIEB_OLTP_SIUD to sr18956;


declare
cursor c1 is select table_name name from dba_tables where owner = 'MAXDAT_MIEB';
cursor c2 is select view_name name from dba_views where owner = 'MAXDAT_MIEB';
cursor c3 is select object_name name from dba_objects where object_type in ('FUNCTION','PROCEDURE','PACKAGE') and owner = 'MAXDAT_MIEB';
cmd varchar2(1000);
begin
dbms_output.enable;
for c in c1 loop
cmd := 'GRANT SELECT, insert, update ON '||c.name|| ' to MAXDAT_MIEB_OLTP_SIU';
dbms_output.put_line(cmd);
execute immediate cmd;
cmd := 'GRANT SELECT, insert, update, delete ON '||c.name|| ' to MAXDAT_MIEB_OLTP_SIUD';
dbms_output.put_line(cmd);
execute immediate cmd;
end loop;
for c in c2 loop
cmd := 'GRANT SELECT on '||c.name|| ' to MAXDAT_MIEB_OLTP_SIU, MAXDAT_MIEB_OLTP_SIUD';
dbms_output.put_line(cmd);
execute immediate cmd;
end loop;
for c in c3 loop
cmd := 'GRANT execute on '||c.name|| ' to MAXDAT_MIEB_OLTP_SIU, MAXDAT_MIEB_OLTP_SIUD';
dbms_output.put_line(cmd);
execute immediate cmd;
end loop;
end;


