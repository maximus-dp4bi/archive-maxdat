alter session set plsql_code_type = native;

declare

  cursor c_wrong_d_date
  is
  select
    coalesce(cur."Complete Date",cur."Cancel Work Date") end_date,
    facts.FMWBD_ID
  from
    F_MW_BY_DATE facts,
    D_MW_CURRENT cur
  where 
    (trunc(facts.D_DATE) < facts.BUCKET_START_DATE
    or trunc(facts.D_DATE) > facts.BUCKET_END_DATE)
    and facts.MW_BI_ID = cur.MW_BI_ID
    and coalesce(cur."Complete Date",cur."Cancel Work Date") is not null
  order by facts.MW_BI_ID asc;
  
begin

  for r_wrong_d_date in c_wrong_d_date
  loop
  
    update F_MW_BY_DATE
    set D_DATE = r_wrong_d_date.end_date
    where FMWBD_ID = r_wrong_d_date.FMWBD_ID;
    
    dbms_output.put_line(r_wrong_d_date.FMWBD_ID || ' ' || r_wrong_d_date.end_date);
    
  end loop;
  
  commit;
  
end;
/

alter session set plsql_code_type = interpreted;