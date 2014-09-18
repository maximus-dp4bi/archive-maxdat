alter session set plsql_code_type = native;

declare

  cursor c_missing_creation
  is
  select MW_BI_ID
  from F_MW_BY_DATE
  group by MW_BI_ID
  having 
    sum(CREATION_COUNT) = 0
    and sum(COMPLETION_COUNT) = 1
    and count(*) = 1
  order by MW_BI_ID asc;
  
begin

  for r_missing_creation in c_missing_creation
  loop
  
    update F_MW_BY_DATE
    set CREATION_COUNT = 1
    where MW_BI_ID = r_missing_creation.MW_BI_ID;
    
  end loop;
  
  commit;
  
end;
/

alter session set plsql_code_type = interpreted;