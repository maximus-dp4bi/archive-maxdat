create or replace PROCEDURE "PURGE_OLD_DOCS_V2" as
---- Before running this be sure to disable triggers and re-enable after it completes.
  v_count number :=0;
  cursor find_rows_to_delete is
	select EDDB_ID, dcn, stg_done_dt from flhk_etl_documents_v2 
	where instance_status='Complete' and stg_done_dt < sysdate-180;
    
  begin
    for row_to_delete in find_rows_to_delete
    loop
        delete from flhk_etl_documents_v2 where EDDB_ID = row_to_delete.EDDB_ID;
        v_count := v_count + 1; 
        if v_count = 100 then
           v_count := 0;
           commit;
        end if;
    end loop;    
  end;