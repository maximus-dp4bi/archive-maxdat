create table corp_etl_mailfaxdoc
(
CEMFD_ID				NUMBER	NOT NULL
,dcn					NUMBER	NOT NULL
,dcn_create_dt				DATE	NOT NULL
,instance_status			VARCHAR2(50)	NOT NULL
,instance_complete_dt			DATE
,batch_name				VARCHAR2(255)	NOT NULL
,batch_channel				VARCHAR2(15)	NOT NULL
,ecn					VARCHAR2(256)
,original_dcn				NUMBER
,rescanned				VARCHAR2(1)	NOT NULL
,document_page_count			NUMBER
,document_status			VARCHAR2(32)	NOT NULL
,document_status_dt			DATE		NOT NULL
,dcn_count				NUMBER
,gwf_document_barcoded			VARCHAR2(1)
,form_type				VARCHAR2(255)
,document_type				VARCHAR2(64)
,gwf_autolink_outcome			VARCHAR2(50)
,autolink_failure_reason		VARCHAR2(256)
,assd_create_ia_task			DATE
,ased_create_ia_task			DATE
,asf_create_ia_task			VARCHAR2(1)
,ia_manual_classify_task_id		NUMBER
,ia_manual_link_task_id			NUMBER
,gwf_rescan_required			VARCHAR2(1)
,gwf_doc_class_present			VARCHAR2(1)
,assd_link_images_manual		DATE
,ased_link_images_manual		DATE
,asf_link_images_manual			VARCHAR2(1)
,assd_classify_form_doc_manual		DATE
,ased_classify_form_doc_manual		DATE
,asf_classify_form_doc_manual		VARCHAR2(1)
,assd_create_and_route_work		DATE
,ased_create_and_route_work		DATE
,asf_create_and_route_work		VARCHAR2(1)
,gwf_work_identified			VARCHAR2(1)
,work_task_id				NUMBER
,work_task_type_created			VARCHAR2(50)
,cancel_dt				DATE
,link_method				VARCHAR2(15)
,link_via				VARCHAR2(32)
,link_number				NUMBER
,age_bus_days				NUMBER
,age_cal_days				NUMBER
,dcn_jeopardy_status			VARCHAR2(30)	NOT NULL
,dcn_jeopardy_status_dt			DATE		NOT NULL
,dcn_timeliness_status			VARCHAR2(30)	NOT NULL
,stage_done_dt				DATE
,stg_extract_date			DATE
,stg_last_update_date			DATE);

create  table corp_etl_mailfaxdoc_oltp
(
CEMFD_ID				NUMBER
,dcn					NUMBER
,dcn_create_dt				DATE
,instance_status			VARCHAR2(50)
,instance_complete_dt			DATE
,batch_name				VARCHAR2(255)
,batch_channel				VARCHAR2(15)
,ecn					VARCHAR2(256)
,original_dcn				NUMBER
,rescanned				VARCHAR2(1)
,document_page_count			NUMBER
,document_status			VARCHAR2(32)
,document_status_dt			DATE
,dcn_count				NUMBER
,gwf_document_barcoded			VARCHAR2(1)
,form_type				VARCHAR2(255)
,document_type				VARCHAR2(64)
,gwf_autolink_outcome			VARCHAR2(50)
,autolink_failure_reason		VARCHAR2(256)
,assd_create_ia_task			DATE
,ased_create_ia_task			DATE
,asf_create_ia_task			VARCHAR2(1)
,ia_manual_classify_task_id		NUMBER
,ia_manual_link_task_id			NUMBER
,gwf_rescan_required			VARCHAR2(1)
,gwf_doc_class_present			VARCHAR2(1)
,assd_link_images_manual		DATE
,ased_link_images_manual		DATE
,asf_link_images_manual			VARCHAR2(1)
,assd_classify_form_doc_manual		DATE
,ased_classify_form_doc_manual		DATE
,asf_classify_form_doc_manual		VARCHAR2(1)
,assd_create_and_route_work		DATE
,ased_create_and_route_work		DATE
,asf_create_and_route_work		VARCHAR2(1)
,gwf_work_identified			VARCHAR2(1)
,work_task_id				NUMBER
,work_task_type_created			VARCHAR2(50)
,cancel_dt				DATE
,link_method				VARCHAR2(15)
,link_via				VARCHAR2(32)
,link_number				NUMBER
,age_bus_days				NUMBER
,age_cal_days				NUMBER
,dcn_jeopardy_status			VARCHAR2(30)
,dcn_jeopardy_status_dt			DATE
,dcn_timeliness_status			VARCHAR2(30)
,document_set_id			NUMBER
,stage_done_dt				DATE
,stg_extract_date			DATE
,stg_last_update_date			DATE
,doc_autolink_date 			DATE
,doc_rescan_request_date 		DATE);

create  table corp_etl_mailfaxdoc_wip_bpm
(
CEMFD_ID				NUMBER
,dcn					NUMBER
,dcn_create_dt				DATE
,instance_status			VARCHAR2(50)
,instance_complete_dt			DATE
,batch_name				VARCHAR2(255)
,batch_channel				VARCHAR2(15)
,ecn					VARCHAR2(256)
,original_dcn				NUMBER
,rescanned				VARCHAR2(1)
,document_page_count			NUMBER
,document_status			VARCHAR2(64)
,document_status_dt			DATE
,dcn_count				NUMBER
,gwf_document_barcoded			VARCHAR2(1)
,form_type				VARCHAR2(255)
,document_type				VARCHAR2(64)
,gwf_autolink_outcome			VARCHAR2(50)
,autolink_failure_reason		VARCHAR2(256)
,assd_create_ia_task			DATE
,ased_create_ia_task			DATE
,asf_create_ia_task			VARCHAR2(1)
,ia_manual_classify_task_id		NUMBER
,ia_manual_link_task_id			NUMBER
,gwf_rescan_required			VARCHAR2(1)
,gwf_doc_class_present			VARCHAR2(1)
,assd_link_images_manual		DATE
,ased_link_images_manual		DATE
,asf_link_images_manual			VARCHAR2(1)
,assd_classify_form_doc_manual		DATE
,ased_classify_form_doc_manual		DATE
,asf_classify_form_doc_manual		VARCHAR2(1)
,assd_create_and_route_work		DATE
,ased_create_and_route_work		DATE
,asf_create_and_route_work		VARCHAR2(1)
,gwf_work_identified			VARCHAR2(1)
,work_task_id				NUMBER
,work_task_type_created			VARCHAR2(50)
,cancel_dt				DATE
,link_method				VARCHAR2(15)
,link_via				VARCHAR2(32)
,link_number				NUMBER
,age_bus_days				NUMBER
,age_cal_days				NUMBER
,dcn_jeopardy_status			VARCHAR2(30)
,dcn_jeopardy_status_dt			DATE
,dcn_timeliness_status			VARCHAR2(30)
,document_set_id			NUMBER
,stage_done_dt				DATE
,stg_extract_date			DATE
,stg_last_update_date			DATE
,updated				VARCHAR2(1)  );
