create table F_MW_BY_DATE_BCK
as
select * from F_MW_BY_DATE;

commit;

alter session set plsql_code_type = native;

-- Allow rows to move between partitions
alter table F_MW_BY_DATE enable row movement;

declare

  -- Staging table updated after instance completed.
  cursor c_bad_fact_bi_ids
  is 
  select 
    distinct facts.MW_BI_ID,
    coalesce(cur."Complete Date",cur."Cancel Work Date") end_date
  from F_MW_BY_DATE facts
  inner join D_MW_CURRENT cur on (facts.MW_BI_ID = cur.MW_BI_ID)
  where facts.BUCKET_END_DATE < facts.BUCKET_START_DATE
  order by facts.MW_BI_ID asc;
    
  cursor c_last_two_facts (p_mw_bi_id number)
  is
  select facts.*
  from F_MW_BY_DATE facts
  where facts.MW_BI_ID = p_mw_bi_id
  order by facts.FMWBD_ID desc;
    
  r_last_fact F_MW_BY_DATE%rowtype := null;
  r_next_to_last_fact F_MW_BY_DATE%rowtype := null;

begin

 for r_bad_fact_bi_id in c_bad_fact_bi_ids
 loop

   if r_bad_fact_bi_id.end_date is not null then
   
     open c_last_two_facts(r_bad_fact_bi_id.MW_BI_ID);
     fetch c_last_two_facts into r_last_fact;
     fetch c_last_two_facts into r_next_to_last_fact;
     close c_last_two_facts;
     
     -- Instance completed on same day as it was created but staging table updated on later day.
     if r_next_to_last_fact.BUCKET_START_DATE = trunc(r_bad_fact_bi_id.end_date) then
     
       --dbms_output.put_line(r_bad_fact_bi_id.MW_BI_ID || ' compl same day');
     
       delete from F_MW_BY_DATE
       where FMWBD_ID = r_next_to_last_fact.FMWBD_ID;
       --dbms_output.put_line('Dropping FMWBD_ID = ' || r_next_to_last_fact.FMWBD_ID);
       
       update F_MW_BY_DATE
       set
         D_DATE = r_bad_fact_bi_id.end_date,
         BUCKET_START_DATE = r_next_to_last_fact.BUCKET_START_DATE,
         CREATION_COUNT = r_next_to_last_fact.CREATION_COUNT
       where FMWBD_ID = r_last_fact.FMWBD_ID;
       
       commit;
       --dbms_output.put_line('Updating FMWBD_ID = ' || r_last_fact.FMWBD_ID || ' with ' || r_bad_fact_bi_id.end_date || ' ' || r_next_to_last_fact.BUCKET_START_DATE);
       
     else
     
       --dbms_output.put_line(r_bad_fact_bi_id.MW_BI_ID || ' compl later day');
       
       update F_MW_BY_DATE
       set BUCKET_END_DATE = trunc(r_bad_fact_bi_id.end_date)
       where FMWBD_ID = r_next_to_last_fact.FMWBD_ID;
       
       update F_MW_BY_DATE
       set 
         D_DATE = r_bad_fact_bi_id.end_date,
         BUCKET_START_DATE = trunc(r_bad_fact_bi_id.end_date),
         BUCKET_END_DATE = trunc(r_bad_fact_bi_id.end_date)
       where FMWBD_ID = r_last_fact.FMWBD_ID;
       
       commit;
       --dbms_output.put_line('Updating FMWBD_ID = ' || r_next_to_last_fact.FMWBD_ID || ' with ' || trunc(r_bad_fact_bi_id.end_date));
       --dbms_output.put_line('Updating FMWBD_ID = ' || r_last_fact.FMWBD_ID || ' with ' || trunc(r_bad_fact_bi_id.end_date));
      
      end if;

    else
    
      dbms_output.put_line('Warning: Unexpected null end_date for ' || r_bad_fact_bi_id.MW_BI_ID);
      
    end if;
      
  end loop;

end;
/

-- Disallow rows to move between partitions
alter table F_MW_BY_DATE disable row movement;

alter session set plsql_code_type = interpreted;