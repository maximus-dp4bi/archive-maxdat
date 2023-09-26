 DECLARE  
  CURSOR temp_cur IS
   SELECT *
   FROM (
    SELECT	CEMFD_ID
		,DCN
		,document_id
		,ased_classify_form_doc_manual
		,ased_link_images_manual
    ,doc_autolink_date
    ,assd_create_and_route_work
    ,work_task_id
    ,work_Task_type_created
		,case when doc_autolink_date is not null then doc_autolink_date
			when doc_autolink_date is  null and (ased_classify_form_doc_manual is null and ased_link_images_manual is not null) then ased_link_images_manual 
            when doc_autolink_date is  null and (ased_classify_form_doc_manual is not null and ased_link_images_manual is  null) then ased_classify_form_doc_manual 
		  when doc_autolink_date is  null and (ased_classify_form_doc_manual is not null and ased_link_images_manual is  not null) then greatest (ased_classify_form_doc_manual,ased_link_images_manual)
			end as assd_create_and_route_work_d
   FROM	corp_etl_mailfaxdoc
   WHERE	instance_status = 'Active'
   AND gwf_work_identified = 'Y'
   AND assd_create_and_route_work is null
   )
  WHERE assd_create_and_route_work_d is not null;  

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_mailfaxdoc
           set assd_create_and_route_work = temp_tab(indx).assd_create_and_route_work_d               
		     where CEMFD_ID = temp_tab(indx).CEMFD_ID;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/
commit;