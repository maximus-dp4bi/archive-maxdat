create or replace PROCEDURE "PURGE_OLD_CLOSED_DOCS_V2" as
---- Before running this be sure to shutdown the BPM layer and start after it completes.
---- disable foreign keys and all constraints on the d_flhk_documents_history_v2 
---- run it and set all constaints on and foreign keys active 
  v_count number :=0;
  cursor find_rows_to_delete is
	select FLHK_DOC_BI_ID from d_flhk_documents_current_v2 
	where instance_status='Complete' and stg_done_dt < sysdate-730;

  begin
    for rows_to_delete in find_rows_to_delete
    loop
	    delete from d_flhk_documents_history_v2 where FLHK_DOC_BI_ID = rows_to_delete.FLHK_DOC_BI_ID;
        delete from d_flhk_documents_current_v2 where FLHK_DOC_BI_ID = rows_to_delete.FLHK_DOC_BI_ID;
        v_count := v_count + 1;
        if v_count = 100 then
           v_count := 0;
           commit;
        end if;
    end loop;    
  end;