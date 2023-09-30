create or replace PROCEDURE "purge_mailfaxbatch_V1" as
v_count number :=0;
cursor c_find_rows is
    select CEMFBB_ID, BATCH_GUID, rownum 
      from CORP_ETL_MFB_BATCH
       where batch_guid > 40492 and batch_guid < 271474;
    
  begin
  
    for rows_to_delete in c_find_rows
    loop
      delete from CORP_ETL_MFB_BATCH 
        where rownum = rows_to_delete.rownum;
	  v_count := v_count + 1; 
      if v_count = 100 then
         v_count := 0;
           commit;
      end if;
    end loop;
    commit;
  end;