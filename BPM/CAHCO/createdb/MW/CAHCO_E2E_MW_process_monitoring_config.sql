delete from d_task_types;
delete from d_bpm_process_segment;
delete from d_bpm_flow;
delete from d_bpm_task_type_entity;
delete from d_bpm_entity;
delete from d_bpm_entity_type;
delete from d_bpm_process;

-- D_TASK_TYPES

Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (1,'Sort, Batch','Sort, Batch','Enrollment Operations',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (2,'OCR Process [OCR],  Scan Mail','OCR Process [OCR],  Scan Mail','Enrollment Operations',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (3,'Create Enrollment/Disenrollment Transaction','Create Enrollment/Disenrollment Transaction','Enrollment Operations',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (4,'Create Daily Transaction File for upload to MEDS','Create Daily Transaction File for upload to MEDS','Information Systems',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (5,'Process Daily Transaction file from MEDS','Process Daily Transaction file from MEDS','Information Systems',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (6,'E2E Model- Packet Letter to KP','E2E Model- Packet Letter to KP','Information Systems',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (7,'Classify Documents [CRM] (manual process)','Classify Documents [CRM] (manual process)','Enrollment Operations',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (8,'EDER Process (manual)','EDER Process (manual)','Enrollment Operations',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (9,'Exemption Process (manual)','Exemption Process (manual)','Enrollment Operations',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (10,'Return mail hand scan and upload into HPE','Return mail hand scan and upload into HPE','Enrollment Operations',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (11,'Generate outbound campaign','Generate outbound campaign','Information Systems',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (12,'Release to work queue','Release to work queue','Enrollment Operations',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (13,'Documents go to queue type','Documents go to queue type',null,null,null,null,null,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (14,'Process Choice Form (manual)','Process Choice Form (manual)','Enrollment Operations',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (15,'Correct rejected transactions','Correct rejected transactions','Information Systems',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (16,'Pend Enrollment 120 days (HPE)','Pend Enrollment 120 days (HPE)','Information Systems',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (20,'Run Daily Letter/Packet Batch jobs','Run Daily Letter/Packet Batch jobs','Information Systems',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (21,'Generate Letter/Packet PDF''s','Generate Letter/Packet PDF''s','Information Systems',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (22,'Load Manifest files to HCODB','Load Manifest files to HCODB','Information Systems',1,'B',1,1,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (23,'Load Response file from KP to DW','Load Response file from KP to DW','Data Analysis and Special Studies (DASS)',1,'B',1,1,null);


-- D_BPM_PROCESS

Insert into D_BPM_PROCESS (PROCESS_ID,PROCESS_NAME,PROCESS_DESCRIPTION,SOURCE_REFERENCE_TYPE,PARENT_PROCESS_ID,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE) values (1,'E2EModel-MailReceptProcessing','HCO End-To-End Mail Receipt Process','',0,15,'B');
Insert into D_BPM_PROCESS (PROCESS_ID,PROCESS_NAME,PROCESS_DESCRIPTION,SOURCE_REFERENCE_TYPE,PARENT_PROCESS_ID,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE) values (2,'E2EModel-PacketLetterToKP','HCO End-To-End Packet Letter to KP Process','',0,15,'B');

-- D_BPM_ENTITY_TYPE

Insert into D_BPM_ENTITY_TYPE (ENTITY_TYPE_ID,ENTITY_TYPE_NAME,ENTITY_TYPE_DESCRIPTION) values (1,'EXCLUSIVE_GATEWAY','Connects only two entities');
Insert into D_BPM_ENTITY_TYPE (ENTITY_TYPE_ID,ENTITY_TYPE_NAME,ENTITY_TYPE_DESCRIPTION) values (2,'PARALLEL_GATEWAY','Connects multiple entities');
Insert into D_BPM_ENTITY_TYPE (ENTITY_TYPE_ID,ENTITY_TYPE_NAME,ENTITY_TYPE_DESCRIPTION) values (3,'PROCESS_ACTIVITY','Process activity');
Insert into D_BPM_ENTITY_TYPE (ENTITY_TYPE_ID,ENTITY_TYPE_NAME,ENTITY_TYPE_DESCRIPTION) values (4,'SUBPROCESS_ACTIVITY','Sub-Process activity');
Insert into D_BPM_ENTITY_TYPE (ENTITY_TYPE_ID,ENTITY_TYPE_NAME,ENTITY_TYPE_DESCRIPTION) values (5,'TASK_ACTIVITY','Task activity');
Insert into D_BPM_ENTITY_TYPE (ENTITY_TYPE_ID,ENTITY_TYPE_NAME,ENTITY_TYPE_DESCRIPTION) values (6,'PROCESS_COMPLETE','Process completion entity, marks end of process');
Insert into D_BPM_ENTITY_TYPE (ENTITY_TYPE_ID,ENTITY_TYPE_NAME,ENTITY_TYPE_DESCRIPTION) values (7,'PROCESS_START','Process start entity, marks the start of a process');
Insert into D_BPM_ENTITY_TYPE (ENTITY_TYPE_ID,ENTITY_TYPE_NAME,ENTITY_TYPE_DESCRIPTION) values (8,'PROCESS_ERROR','Process error handling step');

-- D_BPM_ENTITY

Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL ) values (5000,5,1,'SORT_BATCH_SCAN_MAIL','Activity Ends when mail has been imageD','',1,'B','N','N','','MAILROOM');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5001,5,1,'RETURN_MAIL_HAND_SCAN_AND_UPLOAD_TO_HPE','Activity ends when returned mail data has been uploaded to HPE','',1,'B','N','N','','MAILROOM');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5002,5,1,'GENERATE_OUTBOUND_CAMPAIGN_DATA_FILE_EXTRACTED_AND_SEND_TO_FOLSOM','Activity ends after files have been run and transferred','',1,'B','N','N','','INFORMATION SYSTEMS');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5003,5,1,'REVIEW_STORE_SHRED_RETURNED_MAIL','Activity ends when Returned Mail has been stored in Warehouse','',1,'B','N','N','','MAILROOM');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5004,5,1,'OCR_PROCESS','Activity ends when OCR has finished reading the scanned image','',1,'B','N','N','','MAILROOM');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5005,5,1,'RELEASE_TO_WORK_QUEUE','Activity ends when all batches have been released','',1,'B','N','N','','MAILROOM');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5006,5,1,'PROCESS_CHOICE_FORM','Activity ends when Choice Form has been processed','',1,'B','N','N','','FORMS PROCESSING');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5007,5,1,'CLASSIFY_DOCUMENTS_CRM','Activity ends when all EDERs and Exemptions have been classified','',1,'B','N','N','','RESEARCH');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5008,5,1,'PROCESS_EXEMPTION_CRM','Activity ends when all exemptions processed','',1,'B','N','N','','RESEARCH');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5009,5,1,'PROCESS_EDER_CRM','Activity ends when all EDERs processed','',1,'B','N','N','','RESEARCH');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5010,5,1,'CREATE_ENROLLMENTS_DISENROLLMENT_TRANSACTION','Activity ends when Enrollment/Disenrollment Transaction have been created','',1,'B','N','N','','MAILROOM');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5011,5,1,'CREATE_DAILY_TRANSCATION_FILE_OFR_UPLOAD_TO_MEDS','Activity ends when file has been extracted','',1,'B','N','N','','INFORMATION SYSTEMS');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5012,5,1,'PROCESS_DAILY_TRANSACTION_FILE_FROM_MEDS','Activity ends when results file from MEDS is loaded','',1,'B','N','N','','INFORMATION SYSTEMS');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5013,5,1,'E2E_MODEL_PACKET_LETTER_TO_KP','Activity ends after job has run','',1,'B','N','N','','INFORMATION SYSTEMS');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5014,5,1,'CORRECT_REJECTED_TRANSACTIONS_CORRECTED_BY_SYSTEM_AND_WORK_QUEUE','Activity ends when rejected transactions have been disregarded or reprocessed','',1,'B','N','N','','INFORMATION SYSTEMS');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5015,5,1,'PEND_ENROLLMENT_FOR_UP_TO_120_DAYS_HPE','Activity ends after 120 day pend period','',1,'B','N','N','','INFORMATION SYSTEMS');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5016,5,2,'RUN_DAILY_LETTER_PACKET_BATCH_JOBS','Activity ends when all batch jobs have been run','',1,'B','N','N','','SYSTEMS');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5017,5,2,'GENERATE_LETTER_PACKET_PDFS','Activity ends when all PDFs have been generated','',1,'B','N','N','','SYSTEMS');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5018,5,2,'PREPARE_FOR_SFTP_TRANSMISSION_TO_KP','Activity ends when files are ready to transmit to KP','',1,'B','N','N','','SYSTEMS');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5019,5,2,'LOAD_RESPONSE_FILE','Actifity ends when manifest form KP has been loaded','',1,'B','N','N','','SYSTEMS');

-- D_BPM_TASK_TYPE_ENTITY

Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (1,5000);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (10,5001);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (11,5002);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (2,5004);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (12,5005);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (14,5006);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (7,5007);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (8,5008);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (9,5009);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (3,5010);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (4,5011);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (5,5012);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (6,5013);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (15,5014);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (16,5015);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (20,5016);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (21,5017);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (22,5018);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (23,5019);

-- D_BPM_FLOW

Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (2,1,'SORT_BATCH_SCAN_MAIL_TO_RETURN_MAIL_HAND_SCAN_AND_UPLOAD_TO_HPE','Sort, Batch Scan Mail to Return Mail Hand Scan and Upload to HPE',5000,5001);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (4,1,'RETN_MAIL_HAND_SCN_AND_UPLD_TO_HPE_TO_GEN_OUTBND_CAMPAIGN_FILE_EXTRTD_TO_FOLSOM','Return mail hand scan and upload to HPE to Generate outbound campaign data file extracted and send to Folsom',5001,5002);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (5,1,'GEN_OUTBND_CAMPAIGN_FILE_EXTRTD_TO_FOLSOM_TO_REVIEW_STORE_SHRED_RETURNED_MAIL','Generate outbound campaign data file extracted and send to Folsom to Review, Store, Shred Main ',5002,5003);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (6,1,'RETN_MAIL_HAND_SCN_AND_UPLD_TO_HPE_TO_REVIEW_STORE_SHRED_RETURNED_MAIL','Return mail hand scan and upload to HPE to  Review, Store, Shred Returned Mail',5001,5003);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (7,1,'SORT_BATCH_SCAN_MAIL_TO_OCR_PROCESS','Sort,  Batch Scan Mail to OCR Process',5000,5004);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (8,1,'OCR_PROCESS_TO_CREATE_ENROLLMENTS_DISENROLLMENT_TRANSACTION','OCR Process to Create Enrollmen/Disenrollment Transaction',5004,5010);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (9,1,'OCR_PROCESS_TO_RELEASE_TO_WORK_QUEUE','OCR Process to Release to Work Queue',5004,5005);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (10,1,'RELEASE_TO_WORK_QUEUE_TO_PROCESS_CHOICE_FORM','Release to Work Queue to Process Choice Form',5005,5006);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (11,1,'RELEASE_TO_WORK_QUEUE_TO_CLASSIFY_DOCUMENTS_CRM','Release to Work Queue to Classify Documents CRM',5005,5007);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (12,1,'CLASSIFY_DOCUMENTS_CRM_TO_PROCESS_EXEMPTION_CRM','Classify Documents CRM to Process Exemption CRM',5007,5008);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (13,1,'CLASSIFY_DOCUMENTS_CRM_TO_PROCESS_EDER_CRM','Classify Documents CRM to Process EDER CRM',5007,5009);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (14,1,'PROCESS_CHOICE_FORM_TO_CREATE_DAILY_TRANSCATION_FILE_FOR_UPLOAD_TO_MEDS','Process Choice Form to Create Daily Transaction File for Upload to MEDS',5006,5011);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (15,1,'PROCESS_CHOICE_FORM_TO_PEND_ENROLLMENT_FOR_UP_TO_120_DAYS_HPE','Process Choice Form to Pend Enrollment for up to 120 days HPE',5006,5015);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (16,1,'PROCESS_CHOICE_FORM_TO_E2E_MODEL_PACKET_LETTER_TO_KP','Process Choice Form to E2E Model-Packet Letter to KP',5006,5013);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (17,1,'CREATE_ENROLLMENTS_DISENROLLMENT_TRANSACTION_TO_CREATE_DAILY_TRANSCATION_FILE_FOR_UPLOAD_TO_MEDS','Create Enrollmen/Disenrollment Transaction TO Create Daily Transaction File for Upload to MEDS',5010,5011);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (18,1,'CREATE_DAILY_TRANSCATION_FILE_FOR_UPLOAD_TO_MEDS_TO_PROCESS_DAILY_TRANSACTION_FILE_FROM_MEDS','Create Daily Transaction File for Upload to MEDS to Process Daily Transaction file from MEDS',5011,5012);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (19,1,'PROCESS_DAILY_TRANSACTION_FILE_FROM_MEDS_TO_CORRECT_REJECTED_TRANSACTIONS_CORRECTED_BY_SYSTEM_AND_WORK_QUEUE','Process Daily Transaction file from MEDS to Correct Rejected Transactions Corrected by system and work Queue',5012,5014);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (20,1,'PROCESS_DAILY_TRANSACTION_FILE_FROM_MEDS_TO_E2E_MODEL_PACKET_LETTER_TO_KP','Process Daily Transaction file from MEDS to E2E Model-Packet Letter to KP',5012,5013);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (22,1,'PROCESS_EXEMPTION_CRM_TO_E2E_MODEL_PACKET_LETTER_TO_KP','Process Exemption CRM to E2E Model-Packet Letter to KP',5008,5013);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (23,1,'PROCESS_EDER_CRM_TO_E2E_MODEL_PACKET_LETTER_TO_KP','Process EDER CRM to E2E Model-Packet Letter to KP',5009,5013);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (24,1,'PEND_ENROLLMENT_FOR_UP_TO_120_DAYS_HPE_TO_E2E_MODEL_PACKET_LETTER_TO_KP','Pend Enrollment for up to 120 days HPE to E2E Model-Packet Letter to KP',5015,5013);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (25,1,'PEND_ENROLLMENT_FOR_UP_TO_120_DAYS_HPE_TO_CREATE_DAILY_TRANSCATION_FILE_FOR_UPLOAD_TO_MEDS','Pend Enrollment for up to 120 days HPE to Create Daily Transaction File for Upload to MEDS',5015,5011);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (27,2,'RUN_DAILY_LETTER_PACKET_BATCH_JOBS_TO_GENERATE_LETTER_PACKET_PDFS','Run Daily Letter Packet Batch Jobs to Generate Letter Packet PDFs',5016,5017);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (28,2,'GENERATE_LETTER_PACKET_PDFS_TO_PREPARE_FOR_SFTP_TRANSMISSION_TO_KP','Generate Letter Packet PDFs to Prepare for SFTP Transmission to KP',5017,5018);
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) values (29,2,'PREPARE_FOR_SFTP_TRANSMISSION_TO_KP_TO_LOAD_RESPONSE_FILE','Prepare for SFTP Transmission to KP to Load Response File',5018,5019);

-- D_BPM_PROCESS_SEGMENT

Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (1,1,'OCR_PROCESS','Sort,  Batch Scan Mail to OCR Process',1,'B',5000,5004);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (2,1,'CREATE_ENROLLMENTS_DISENROLLMENT_TRANSACTION','OCR Process to Create Enrollmen/Disenrollment Transaction',2,'B',5004,5010);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (3,1,'RELEASE_TO_WORK_QUEUE','Release to Work Queue to Queue Type Research or Forms to Process Choice Form',1,'B',5004,5005);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (4,1,'PROCESS_CHOICE_FORM','Release to Work Queue to Process Choice Form',2,'B',5005,5006);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (5,1,'CREATE_DAILY_TRANSCATION_FILE_OFR_UPLOAD_TO_MEDS (OCR Process,Activity-3)','To Create Daily Transaction File for Upload to MEDS from OCR Process',1,'B',5010,5011);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (6,1,'CREATE_DAILY_TRANSCATION_FILE_OFR_UPLOAD_TO_MEDS (Process Choice Form, Activity-14)','To Create Daily Transaction File for Upload to MEDS from  Process Choice Form',1,'B',5006,5011);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (7,1,'PROCESS_DAILY_TRANSACTION_FILE_FROM_MEDS','Create Daily Transaction File for Upload to MEDS to Process Daily Transaction file from MEDS',1,'B',5011,5012);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (8,1,'CORRECT_REJECTED_TRANSACTIONS_CORRECTED_BY_SYSTEM_AND_WORK_QUEUE','Process Daily Transaction file from MEDS to Correct Rejected Transactions Corrected by system and work Queue',1,'B',5012,5014);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (9,1,'PROCESS_EXEMPTION_CRM','Classify Documents CRM to Process Exemption CRM',2,'B',5007,5008);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (10,1,'PROCESS_EDER_CRM','Classify Documents CRM to Process EDER CRM',2,'B',5007,5009);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (11,1,'PEND_ENROLLMENT_FOR_UP_TO_120_DAYS_HPE','Process Choice Form to Pend Enrollment for up to 120 days HPE',120,'B',5006,5015);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (12,1,'PROCESS_CHOICE_FORM_TO_E2E_MODEL_PACKET_LETTER_TO_KP','Process Choice Form to E2E Model-Packet Letter to KP',1,'B',5006,5016);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (13,1,'PROCESS_DAILY_TRANSACTION_FILE_FROM_MEDS_TO_E2E_MODEL_PACKET_LETTER_TO_KP','Process Daily Transaction file from MEDS to E2E Model-Packet Letter to KP',1,'B',5012,5016);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (14,1,'PROCESS_EXEMPTION_CRM_TO_E2E_MODEL_PACKET_LETTER_TO_KP','Process Exemption CRM to E2E Model-Packet Letter to KP',1,'B',5008,5016);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (15,1,'PROCESS_EDER_CRM_TO_E2E_MODEL_PACKET_LETTER_TO_KP','Process EDER CRM to E2E Model-Packet Letter to KP',1,'B',5009,5016);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (16,1,'PEND_ENROLLMENT_FOR_UP_TO_120_DAYS_HPE_TO_E2E_MODEL_PACKET_LETTER_TO_KP','Pend Enrollment for up to 120 days HPE to E2E Model-Packet Letter to KP',120,'B',5015,5016);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (17,1,'RETURN_MAIL_HAND_SCAN_AND_UPLOAD_TO_HPE','Sort, Batch Scan Mail to Return Mail Hand Scan and Upload to HPE',1,'B',5000,5001);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (18,1,'GENERATE_OUTBOUND_CAMPAIGN_DATA_FILE_EXTRACTED_AND_SEND_TO_FOLSOM','Return mail hand scan and upload to HPE to Generate outbound campaign data file extracted and send to Folsom',1,'B',5001,5002);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (19,2,'GENERATE_LETTER_PACKET_PDFS','Run Daily Letter Packet Batch Jobs to Generate Letter Packet PDFs',1,'B',5016,5017);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (20,2,'PREPARE_FOR_SFTP_TRANSMISSION_TO_KP','Generate Letter Packet PDFs to Prepare for SFTP Transmission to KP',1,'B',5017,5018);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (21,2,'LOAD_RESPONSE_FILE','Prepare for SFTP Transmission to KP to Load Response File',1,'B',5018,5019);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (22,1,'SORT_BATCH_SCAN_MAIL_TO_CREATE_ENROLLMENTS_DISENROLLMENT_TRANSACTION','Sort,  Batch Scan Mail to  Create Enrollmen/Disenrollment Transaction',3,'B',5001,5010);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (23,1,'SORT_BATCH_SCAN_MAIL_TO_PROCESS_CHOICE_FORM','Sort,  Batch Scan Mail to Process Choice Form',3,'B',5001,5006);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (24,1,'SORT_BATCH_SCAN_MAIL_TO_PROCESS_EXEMPTION_CRM','Sort,  Batch Scan Mail to Process Exemption CRM',3,'B',5001,5008);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (25,1,'SORT_BATCH_SCAN_MAIL_TO_PROCESS_EDER_CRM','Sort,  Batch Scan Mail to Process EDER CRM',3,'B',5001,5009);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (26,1,'SORT_BATCH_SCAN_MAIL_TO_PEND_ENROLLMENT_FOR_UP_TO_120_DAYS_HPE','Sort,  Batch Scan Mail to Pend Enrollment for up to 120 days HPE',121,'B',5001,5015);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (27,1,'SORT_BATCH_SCAN_MAIL_TO_E2E_MODEL_PACKET_LETTER_TO_KP','Sort,  Batch Scan Mail to  E2E Model-Packet Letter to KP',3,'B',5001,5016);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (28,1,'SORT_BATCH_SCAN_MAIL_TO_GENERATE_LETTER_PACKET_PDFS','Sort,  Batch Scan Mail to  Generate Letter Packet PDFs',3,'B',5001,5017);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (29,1,'SORT_BATCH_SCAN_MAIL_TO_LOAD_RESPONSE_FILE','Sort,  Batch Scan Mail to Load Response File',1,'B',5001,5019);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (30,1,'PROCESS_CHOICE_FORM_TO_GENERATE_LETTER_PACKET_PDFS','Process Choice Form to Generate Letter Packet PDFs',1,'B',5006,5017);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (31,1,'PROCESS_DAILY_TRANSACTION_FILE_FROM_MEDS_TO_GENERATE_LETTER_PACKET_PDFS','Process Daily Transaction file from MEDS  to  Generate Letter Packet PDFs',1,'B',5012,5017);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (32,1,'PROCESS_EXEMPTION_CRM_TO_GENERATE_LETTER_PACKET_PDFS','Process Exemption CRM  to  Generate Letter Packet PDFs',1,'B',5008,5017);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (33,1,'PROCESS_EDER_CRM_TO_GENERATE_LETTER_PACKET_PDFS','Process EDER CRM  to  Generate Letter Packet PDFs',1,'B',5009,5017);
Insert into D_BPM_PROCESS_SEGMENT (PROCESS_SEGMENT_ID,PROCESS_ID,PROCESS_SEGMENT_NAME,PROCESS_SEGMENT_DESCRIPTION,PROCESS_TIMELINESS_THRESHOLD,PROCESS_TIMELINESS_DAYS_TYPE,SEGMENT_START_ENTITY_ID,SEGMENT_FINISH_ENTITY_ID) values (34,1,'PEND_ENROLLMENT_FOR_UP_TO_120_DAYS_HPE_TO_GENERATE_LETTER_PACKET_PDFS','Pend Enrollment for up to 120 days HPE to  to  Generate Letter Packet PDFs',1,'B',5015,5017);

-- D_TASK_TYPES

update d_task_types tt set sla_days = (select timeliness_threshold from d_bpm_entity e where e.entity_id in (select tte.entity_id from d_bpm_task_type_entity tte where tte.task_type_id = tt.task_type_id));
update d_task_types tt set sla_days_type = (select timeliness_days_type from d_bpm_entity e where e.entity_id in (select tte.entity_id from d_bpm_task_type_entity tte where tte.task_type_id = tt.task_type_id));
update d_task_types tt set sla_target_days = (select timeliness_threshold from d_bpm_entity e where e.entity_id in (select tte.entity_id from d_bpm_task_type_entity tte where tte.task_type_id = tt.task_type_id));
update d_task_types tt set sla_jeopardy_days = (select timeliness_threshold from d_bpm_entity e where e.entity_id in (select tte.entity_id from d_bpm_task_type_entity tte where tte.task_type_id = tt.task_type_id));
update d_task_types tt set operations_group = (select business_process_pool from d_bpm_entity e where e.entity_id in (select tte.entity_id from d_bpm_task_type_entity tte where tte.task_type_id = tt.task_type_id));

-- MAXDAT-9210 (Doc Recept Process)
update d_bpm_entity set is_starting_entity = 'Y' where entity_id in (5000, 5007);
update d_bpm_entity set is_terminating_entity = 'Y' where entity_id = 5013;

-- MAXDAT-9210 (Packet Letter to KP)
update d_bpm_entity set is_starting_entity = 'Y' where entity_id = 5016;
update d_bpm_entity set is_terminating_entity = 'Y' where entity_id = 5019;

-- MAXDAT-9211
update d_bpm_entity set timeliness_threshold = 120 where entity_id = 5015;

-- Entity Sort Order

update  d_bpm_entity set entity_sort_order = 10	where entity_id = 5000;
update  d_bpm_entity set entity_sort_order = 20	where entity_id = 5004;
update  d_bpm_entity set entity_sort_order = 30	where entity_id = 5010;
update  d_bpm_entity set entity_sort_order = 40	where entity_id = 5005;
update  d_bpm_entity set entity_sort_order = 50	where entity_id = 5006;
update  d_bpm_entity set entity_sort_order = 60	where entity_id = 5011;
update  d_bpm_entity set entity_sort_order = 70	where entity_id = 5012;
update  d_bpm_entity set entity_sort_order = 80	where entity_id = 5014;
update  d_bpm_entity set entity_sort_order = 90	where entity_id = 5015;
update  d_bpm_entity set entity_sort_order = 100 where entity_id = 5013;
update  d_bpm_entity set entity_sort_order = 110 where entity_id = 5007;
update  d_bpm_entity set entity_sort_order = 120 where entity_id = 5008;
update  d_bpm_entity set entity_sort_order = 130 where entity_id = 5009;
update  d_bpm_entity set entity_sort_order = 140 where entity_id = 5001;
update  d_bpm_entity set entity_sort_order = 150 where entity_id = 5002;
update  d_bpm_entity set entity_sort_order = 160 where entity_id = 5003;
update  d_bpm_entity set entity_sort_order = 170 where entity_id = 5016;
update  d_bpm_entity set entity_sort_order = 180 where entity_id = 5017;
update  d_bpm_entity set entity_sort_order = 190 where entity_id = 5018;
update  d_bpm_entity set entity_sort_order = 200 where entity_id = 5019;

commit;

