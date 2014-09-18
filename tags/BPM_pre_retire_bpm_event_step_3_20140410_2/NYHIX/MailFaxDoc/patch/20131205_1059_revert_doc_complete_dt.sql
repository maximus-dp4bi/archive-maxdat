declare 
cursor s1 is select bia.BI_ID,bia.START_DATE,bi.identifier  
             from BPM_INSTANCE_ATTRIBUTE bia
             inner join BPM_INSTANCE bi on bia.BI_ID = bi.BI_ID
             where BA_ID = 2211 and VALUE_CHAR = 'VERIF_COMPLETE';
begin
  for c1 in s1 
   loop

    update D_NYHIX_MFD_CURRENT 
    set DOC_COMPLETE_DT = c1.START_DATE
    where NYHIX_MFD_BI_ID = c1.BI_ID;

    update BPM_INSTANCE_ATTRIBUTE 
    set VALUE_DATE = c1.START_DATE
    where BI_ID = c1.BI_ID and BA_ID = 2481;
    
    update NYHIX_ETL_MAIL_FAX_DOC
    set DOC_COMPLETE_DT = c1.START_DATE
    where DCN = c1.identifier;

    commit;

   end loop;
end;