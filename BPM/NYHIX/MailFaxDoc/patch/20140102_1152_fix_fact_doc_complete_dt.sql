declare 
cursor s1 is select NYHIX_MFD_BI_ID, DOC_COMPLETE_DT  
             from D_NYHIX_MFD_CURRENT;
begin
  for c1 in s1 
   loop

    update F_NYHIX_MFD_BY_DATE
    set DOC_COMPLETE_DT = c1.DOC_COMPLETE_DT
    where NYHIX_MFD_BI_ID = c1.NYHIX_MFD_BI_ID;

    commit;

   end loop;
end;
/