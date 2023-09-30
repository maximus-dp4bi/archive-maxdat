declare

  cursor c_pmi
  is
  select BI_ID
  from BPM_INSTANCE 
  where BEM_ID = 5;
     
begin
  
  for r_pmi in c_pmi
  loop
 
    delete from BPM_INSTANCE_ATTRIBUTE
    where BI_ID = r_pmi.BI_ID;
    
    delete from BPM_UPDATE_EVENT
    where BI_ID = r_pmi.BI_ID;
    
    commit;
    
  end loop;

end;
/

delete from BPM_INSTANCE
where BEM_ID = 5;

commit;
