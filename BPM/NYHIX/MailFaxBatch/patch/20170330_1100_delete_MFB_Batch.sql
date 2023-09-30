-- Purge MailFaxBatch - NYHIX-30270

begin
  for cur1 in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'corp_etl_mfb_batch') loop
     execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE ';
  end loop;
end;
truncate table maxdat.corp_etl_mfb_batch;
commit;
begin
  for cur1 in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'corp_etl_mfb_batch') loop
     execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE ';
  end loop;
end;