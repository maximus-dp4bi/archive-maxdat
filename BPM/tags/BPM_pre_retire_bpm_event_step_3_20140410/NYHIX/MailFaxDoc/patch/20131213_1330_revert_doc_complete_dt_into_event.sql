declare 
cursor s1 is select NYHIX_MFD_BI_ID,DOC_COMPLETE_DT  
             from D_NYHIX_MFD_CURRENT;
    
begin
  for c1 in s1 
   loop
   
    update BPM_INSTANCE_ATTRIBUTE 
    set VALUE_DATE = c1.DOC_COMPLETE_DT
    where BI_ID = c1.NYHIX_MFD_BI_ID  and BA_ID = 2481;
    
    commit;

   end loop;
end;
/

ALTER TRIGGER TRG_AU_NYHIX_ETL_MFD_Q ENABLE;
ALTER TRIGGER TRG_BIU_NYHIX_ETL_MFD ENABLE;
ALTER TRIGGER TRG_AI_NYHIX_ETL_MFD_Q ENABLE;


Drop table MFD_DOC_COMPLETE_DT_TMP;