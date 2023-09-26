  update  corp_etl_mailfaxdoc
  set asf_link_images_manual = null
    ,assd_classify_form_doc_manual =null
    ,ased_classify_form_doc_manual = null
    ,assd_link_images_manual = null
    ,ased_link_images_manual = null    
   where ased_create_ia_task is null
    and ((assd_classify_form_doc_manual is not null and ased_classify_form_doc_manual is null)
   or (assd_link_images_manual is not null and ased_link_images_manual is null)
   or ( assd_create_and_route_work is not null and  ased_create_and_route_work is null))   
    and instance_status = 'Complete'
    and gwf_channel_online = 'Y';
  
  update corp_etl_mailfaxdoc
  set assd_classify_form_doc_manual = null
      ,assd_link_images_manual = null
      ,asf_classify_form_doc_manual = 'N'
      ,ased_classify_form_doc_manual = null
      ,ased_link_images_manual = null
      ,asf_link_images_manual = 'N'
      ,assd_create_and_route_work = null
where    ased_create_ia_task is null
  and (assd_classify_form_doc_manual is not null or assd_link_images_manual is not null)
  and instance_status = 'Active'
  ;   

  update corp_etl_mailfaxdoc
  set gwf_channel_online = CASE WHEN batch_channel = 'ONLINE' THEN 'Y' ELSE 'N' END
  where gwf_channel_online is null;


commit;