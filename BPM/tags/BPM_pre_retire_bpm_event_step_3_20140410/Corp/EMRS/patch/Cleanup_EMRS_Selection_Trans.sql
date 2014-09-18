truncate table emrs_d_selection_trans_history;

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'ENABLED' AND constraint_name LIKE '%SLCTTRANS%') LOOP
execute immediate 'alter table '||i.table_name||' disable constraint '||i.constraint_name||'';
end loop;
end;
/
truncate table emrs_d_selection_transaction;

begin
for i in (select constraint_name, table_name from user_constraints where constraint_type ='R'
and status = 'DISABLED' AND constraint_name LIKE '%SLCTTRANS%') LOOP
execute immediate 'alter table '||i.table_name||' enable constraint '||i.constraint_name||'';
end loop;
end;
/