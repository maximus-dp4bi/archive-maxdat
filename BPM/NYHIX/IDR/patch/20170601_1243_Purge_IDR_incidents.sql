alter session set current_schema = MAXDAT;

begin
  for cur0 in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'F_IDR_BY_DATE') loop
     execute immediate 'ALTER TABLE '||cur0.owner||'.'||cur0.table_name||' MODIFY CONSTRAINT "'||cur0.constraint_name||'" DISABLE ';
  end loop;
end;
/
truncate table MAXDAT.F_IDR_BY_DATE;
begin
  for cur in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'F_IDR_BY_DATE') loop
     execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE ';
  end loop;
end;
/

begin
  for cur1 in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'D_IDR_CURRENT') loop
     execute immediate 'ALTER TABLE '||cur1.owner||'.'||cur1.table_name||' MODIFY CONSTRAINT "'||cur1.constraint_name||'" DISABLE ';
  end loop;
end;
/
truncate table MAXDAT.D_IDR_CURRENT;
begin
  for cur2 in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'D_IDR_CURRENT') loop
     execute immediate 'ALTER TABLE '||cur2.owner||'.'||cur2.table_name||' MODIFY CONSTRAINT "'||cur2.constraint_name||'" ENABLE ';
  end loop;
end;
/