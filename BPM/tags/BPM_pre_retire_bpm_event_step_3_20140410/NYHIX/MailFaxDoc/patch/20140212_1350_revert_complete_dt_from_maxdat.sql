Declare
cursor s1 is select DCN, COMPLETE_DT  
             from MFD_COMPLETE_DT_TMP;
begin
  for c1 in s1 
   loop

    update F_NYHIX_MFD_BY_DATE
    set COMPLETION_COUNT = 0
    where 
      COMPLETION_COUNT = 1
      and NYHIX_MFD_BI_ID = 
        (select NYHIX_MFD_BI_ID 
         from D_NYHIX_MFD_CURRENT
         where DCN = c1.DCN);

    commit;

    update NYHIX_ETL_MAIL_FAX_DOC
    set COMPLETE_DT = c1.COMPLETE_DT
    where DCN = c1.DCN;

    commit;

   end loop;
end;
/