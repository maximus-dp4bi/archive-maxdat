-- Update completed records in semantic table

DECLARE  
CURSOR stage_cur IS
select distinct d.TR_DOC_STATUS_CD, v.NYHIX_MFD_BI_ID  
	from document_stg D 
	inner join D_NYHIX_MFD_CURRENT_V2 v
	on v.DCN = d.DCN
WHERE v.TR_DOC_STATUS_CD IS NULL
and v.instance_status = 'Complete'
;   
   TYPE t_stage_tab IS TABLE OF stage_cur%ROWTYPE INDEX BY PLS_INTEGER;
    stage_tab t_stage_tab;
    v_bulk_limit NUMBER := 1000;
   
BEGIN  
   OPEN stage_cur;
   LOOP
     FETCH stage_cur BULK COLLECT INTO stage_tab LIMIT v_bulk_limit;
     EXIT WHEN stage_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..stage_tab.COUNT
		update D_NYHIX_MFD_CURRENT_V2 v
		set tr_doc_status_cd = stage_tab(indx).tr_doc_status_cd     
		WHERE v.NYHIX_MFD_BI_ID = stage_tab(indx).NYHIX_MFD_BI_ID
		;
	 END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE stage_cur;
END;
/
