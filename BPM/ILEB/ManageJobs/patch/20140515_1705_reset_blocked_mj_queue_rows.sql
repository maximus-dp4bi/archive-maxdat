DECLARE
  v_bi_id NUMBER := NULL;
  
  CURSOR c_identifiers_to_remove
  IS
    SELECT IDENTIFIER
    FROM BPM_UPDATE_EVENT_QUEUE
    WHERE BSL_ID        = 11
    AND PROCESS_BUEQ_ID = 4397948;
	
BEGIN
  FOR r_identifiers_to_remove IN c_identifiers_to_remove
  LOOP
  
    UPDATE BPM_UPDATE_EVENT_QUEUE
    SET PROCESS_BUEQ_ID = NULL ,
      old_data          = NULL
    WHERE BSL_ID        = 11
    AND IDENTIFIER      = r_identifiers_to_remove.IDENTIFIER;
    COMMIT;
    
    update BPM_UPDATE_EVENT_QUEUE_ARCHIVE
    set 
    WROTE_BPM_SEMANTIC_DATE = null,
    old_data          = NULL    
    where BSL_ID = 11
    and IDENTIFIER = r_identifiers_to_remove.IDENTIFIER;
   commit;
 
    BEGIN
      SELECT MJ_BI_ID
      INTO v_bi_id
      FROM D_MJ_CURRENT
      WHERE JOB_ID = r_identifiers_to_remove.IDENTIFIER;
	  
      DELETE FROM f_mj_by_date WHERE MJ_BI_ID = v_bi_id;
	  
      DELETE FROM d_mj_current WHERE MJ_BI_ID = v_bi_id;
	  
      COMMIT;
	  
    END;
  END LOOP;
END;
/