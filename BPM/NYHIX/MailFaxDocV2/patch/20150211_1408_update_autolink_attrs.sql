DECLARE  
CURSOR mfd_cur IS
   SELECT	
		o.DCN,
 		DL.DOC_LINK_ID 											LINK_ID,
 		DL.CLIENT_ID 											LINKED_CLIENT,
    CASE WHEN DL.AUTO_LINKED_IND = 1 THEN 'Y' 
         WHEN DL.AUTO_LINKED_IND = 0 THEN 'N'
       ELSE null END           AUTO_LINKED_IND,
    DL.CREATE_TS 											LINK_DT
    ,o.complete_dt
  FROM	NYHIX_ETL_MAIL_FAX_DOC_V2 o, DOC_LINK_STG DL, DOCUMENT_STG ds
  WHERE	o.dcn = ds.dcn
  and ds.DOCUMENT_ID = DL.DOCUMENT_ID
  and instance_status = 'Complete'
  and o.auto_linked_ind is null
  --and trunc(o.complete_dt) >= add_months(trunc(sysdate,'mm'),-8)  --update only 2 mos back? 
  --and trunc(o.complete_dt) <= add_months(trunc(sysdate,'mm'),-6)
  ;  
   
   TYPE t_mfd_tab IS TABLE OF mfd_cur%ROWTYPE INDEX BY PLS_INTEGER;
   mfd_tab t_mfd_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN mfd_cur;
   LOOP
     FETCH mfd_cur BULK COLLECT INTO mfd_tab LIMIT v_bulk_limit;
     EXIT WHEN mfd_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..mfd_tab.COUNT
        UPDATE NYHIX_ETL_MAIL_FAX_DOC_V2
        SET auto_linked_ind = mfd_tab(indx).auto_linked_ind
            ,linked_client = mfd_tab(indx).linked_client
            ,link_dt = mfd_tab(indx).link_dt
            ,link_id = mfd_tab(indx).link_id
        WHERE dcn = mfd_tab(indx).dcn;       
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE mfd_cur;
END;
/
commit;