---Purge MW2 - NYHIX-30270
truncate table maxdat.CORP_ETL_MW_V2;
commit;

truncate table maxdat.CORP_ETL_MW_V2_WIP;
commit;

begin
  for cur in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'd_mw_v2_current') loop
     execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE ';
  end loop;
end;
truncate table maxdat.d_mw_v2_current;
commit;

begin
  for cur1 in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'd_mw_v2_current') loop
     execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE ';
  end loop;
end;
