UPDATE corp_etl_mailfaxdoc
SET instance_status = 'Complete'
    ,instance_complete_dt = TO_DATE('06/08/2017','mm/dd/yyyy')
    ,ased_classify_form_doc_manual = assd_classify_form_doc_manual
    ,asf_classify_form_doc_manual = 'Y'
    ,ased_link_images_manual = assd_link_images_manual
    ,asf_link_images_manual = 'Y'
    ,cancel_by =  'TXEB-9766'
    ,cancel_reason = 'Per Business, work completed timely by SSU' 
    ,cancel_method = 'Normal'
    ,stage_done_dt = sysdate - 18
    ,dcn_timeliness_status = 'Processed Timely'
    ,age_bus_days = 0
    ,age_cal_days = 0
WHERE dcn = '1866751';    

commit;