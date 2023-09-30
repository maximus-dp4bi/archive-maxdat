declare 
cursor s1 is select DCN, DOC_COMPLETE_DT  
             from MFD_DOC_COMPLETE_DT_TMP;
begin
  for c1 in s1 
   loop

    update NYHIX_ETL_MAIL_FAX_DOC
    set DOC_COMPLETE_DT = c1.DOC_COMPLETE_DT
    where DCN = c1.DCN and DOC_COMPLETE_DT <> c1.DOC_COMPLETE_DT ;

    commit;

   end loop;
end;
/