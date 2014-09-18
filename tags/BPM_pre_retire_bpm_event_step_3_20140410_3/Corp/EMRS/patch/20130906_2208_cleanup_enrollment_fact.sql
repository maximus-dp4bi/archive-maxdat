begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'ENABLED' AND constraint_name LIKE 'ENROLLMENT%') LOOP
execute immediate 'alter table '||i.table_name||' disable constraint '||i.constraint_name||'';
end loop;
end;
/
truncate table emrs_f_enrollment;

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'DISABLED' AND constraint_name LIKE 'ENROLLMENT%') LOOP
execute immediate 'alter table '||i.table_name||' enable constraint '||i.constraint_name||'';
end loop;
end;
/