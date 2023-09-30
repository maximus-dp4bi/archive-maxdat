--- Purge Process Letters - NYHIX-30270
truncate table maxdat.CORP_ETL_PROC_LETTERS;
commit;
truncate table maxdat.CORP_ETL_PROC_LETTERS_WIP_BPM;
commit;
truncate table maxdat.CORP_ETL_PROC_LETTERS_OLTP;
commit;
truncate table maxdat.CORP_ETL_PROC_LET_MATERIAL_CHD;
commit;
truncate table maxdat.CORP_ETL_PROC_LETTERS_CHD;
commit;

begin
  for cur1 in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'D_PL_CURRENT') loop
     execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE ';
  end loop;
end;

truncate table maxdat.d_pl_current;
commit;
begin
  for cur2 in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'D_PL_CURRENT') loop
     execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE ';
  end loop;
end;

begin
  for cur3 in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'd_pl_letter_status') loop
     execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE ';
  end loop;
end;
truncate table maxdat.d_pl_letter_status;
commit;
begin
  for cur4 in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'd_pl_letter_status') loop
     execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE ';
  end loop;
end;
