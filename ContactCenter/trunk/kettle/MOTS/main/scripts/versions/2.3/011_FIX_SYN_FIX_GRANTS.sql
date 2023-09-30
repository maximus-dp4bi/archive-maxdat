declare
sql_stmt varchar2(2000);

begin

for fix_syn in
(
SELECT ' create public synonym '||object_name||' for MOTS.'||object_name||' ' txt
FROM dba_objects WHERE owner='MOTS' AND object_type IN ('TABLE','VIEW','SEQUENCE','PROCEDURE','FUNCTION','PACKAGE','TYPE','TRIGGER')
AND object_name NOT IN (SELECT table_name FROM dba_synonyms WHERE table_owner='MOTS')
)
loop
--sql_stmt := ' begin '||fix_syn.txt||' exception when others then null; end;';
sql_stmt := fix_syn.txt ;
dbms_output.put_line (sql_stmt);
begin
execute immediate (sql_stmt);
exception
when others then
null;
end;
end loop;

for fix_grants_read_only in
(
SELECT ' grant select on MOTS.'||object_name||' to MAXDAT_READ_ONLY ' txt
FROM dba_objects WHERE owner='MOTS' AND object_type IN ('TABLE','VIEW','SEQUENCE')
AND object_name NOT IN (SELECT table_name FROM dba_tab_privs WHERE owner='MOTS' AND grantee='MAXDAT_READ_ONLY'))
loop
sql_stmt := fix_grants_read_only.txt ;
dbms_output.put_line (sql_stmt);
begin
execute immediate (sql_stmt);
exception
when others then
null;
end;
end loop;
end;
commit;
/