-- Update HX_ACCOUNT_ID_LINK 

DECLARE  
CURSOR stage_cur IS
SELECT distinct C.CASE_CIN, v.APP_DOC_INDV_ID 
	FROM APP_DOC_DATA_STG A 
	INNER JOIN DOC_LINK_STG D 
		ON A.DOCUMENT_ID = D.DOCUMENT_ID 
	LEFT JOIN CASES_STG C 
		ON D.CASE_ID = C.CASE_ID 
	inner join nyhix_etl_mail_fax_doc_app_v2 v 
		on v.app_doc_data_id = a.app_doc_data_id
	where v.LINK_CREATE_DT < to_date('12/24/2015 14:00:00','mm/dd/yyyy hh24:mi:ss')
	and C.CASE_CIN is not null
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
		update nyhix_etl_mail_fax_doc_app_v2 v
		set HX_ACCOUNT_ID_LINK = stage_tab(indx).CASE_CIN
		WHERE v.APP_DOC_INDV_ID = stage_tab(indx).APP_DOC_INDV_ID
		;
	 END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE stage_cur;
END;
/
