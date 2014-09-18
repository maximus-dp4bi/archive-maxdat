create index DNMFDCUR_IX4 on D_NYHIX_MFD_CURRENT (DCN) online tablespace MAXDAT_INDX parallel compute statistics;

Declare
cursor s1 is select DCN, ASED_MAXE_CREATE_DOC  
             from NYHIX_ETL_MAIL_FAX_DOC;
begin
  for c1 in s1 
   loop

    update D_NYHIX_MFD_CURRENT
    set MAXE_CREATE_DOC_END = c1.ASED_MAXE_CREATE_DOC
    where dcn = c1.dcn;

    commit;

   end loop;
end;
/