declare 
cursor s1 is select NYHIX_MFD_BI_ID,COMPLETE_DT  
             from D_NYHIX_MFD_CURRENT;
    
begin
  for c1 in s1 
   loop
   
    update BPM_INSTANCE_ATTRIBUTE 
    set VALUE_DATE = c1.COMPLETE_DT
    where BI_ID = c1.NYHIX_MFD_BI_ID  and BA_ID = 5;
    
    commit;

   end loop;
end;
/
