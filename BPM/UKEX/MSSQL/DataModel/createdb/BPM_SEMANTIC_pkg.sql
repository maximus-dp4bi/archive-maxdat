/*use maxdat;
create type MAXDat_p_BUEQ_RowType as table
(BUEQ_ID integer not null,
   BSL_ID integer not null,
   BIL_ID integer not null,
   Identifier varchar(100) not null,
   Event_Date date not null,
   Queue_Date date not null,
   Process_BUEQ_ID integer,
   Wrote_BPM_Semantic_Date date, 
   Data_Version integer not null,
   Old_Data xml,
   New_Data xml not null);

   */

create procedure BPM_SEMANTIC_INSERT_BPM_SEMANTIC
    (@p_bueq_row MAXDat_p_BUEQ_RowType Readonly)
  as begin
  set nocount on
    declare @v_procedure_name varchar(61) = OBJECT_NAME(@@PROCID) + '.' + 'INSERT_BPM_SEMANTIC',
    @v_log_message varchar= null,
    @v_error_number varchar= null;
    if @p_bueq_row.WROTE_BPM_SEMANTIC_DATE is not null 
    	return;
    if @p_bueq_row.NEW_DATA is null 
	begin
      select @v_log_message = 'Cannot process from queue.  Null BPM_UPDATE_EVENT_QUEUE.NEW_DATA record for IDENTIFIER value "' + @p_bueq_row.IDENTIFIER + '".';
      select @v_error_number = -20015;
      exec dbo.BPM_COMMON_LOGGER
        (select dbo.BPM_COMMON_LOG_LEVEL_SEVERE(),null,@v_procedure_name,@p_bueq_row.BSL_ID,@p_bueq_row.BIL_ID,
         @p_bueq_row.Identifier,null,@v_log_message,null);
      RAISERROR(@v_error_number ,@v_log_message,1,1);   
    end;

    exec dbo.BPM_SEMANTIC_PROJECT_INSERT_BPM_SEMANTIC(select @p_bueq_row);
    exec dbo.BPM_SEMANTIC_PROJECT_UPDATE_BPM_QUEUE(select @p_bueq_row.BUEQ_ID);
    
  end;

  
  
  -- Update BPM Semantic records.
  procedure UPDATE_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';
    v_log_message clob := null;
  begin
  
    if p_bueq_row.WROTE_BPM_SEMANTIC_DATE is not null then
      return;
    end if;
  
    if p_bueq_row.OLD_DATA is null or p_bueq_row.NEW_DATA is null then
      v_log_message := 'Cannot process update from queue.  Null BPM_UPDATE_EVENT_QUEUE .OLD_DATA or .NEW_DATA record(s).';
      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bueq_row.BSL_ID,p_bueq_row.BIL_ID,
         p_bueq_row.IDENTIFIER,null,v_log_message,null);
      return;
    end if;

    BPM_SEMANTIC_PROJECT.UPDATE_BPM_SEMANTIC(p_bueq_row);
    UPDATE_BPM_QUEUE(p_bueq_row.BUEQ_ID);
    
    commit;

  end;
  
  
  -- Update queue with date data added to data model.
  procedure UPDATE_BPM_QUEUE
    (p_bueq_id number)
  as
    
  begin
    
    update BPM_UPDATE_EVENT_QUEUE
    set WROTE_BPM_SEMANTIC_DATE = sysdate
    where BUEQ_ID = p_bueq_id;
    
  end;

end;
/

alter session set plsql_code_type = interpreted;