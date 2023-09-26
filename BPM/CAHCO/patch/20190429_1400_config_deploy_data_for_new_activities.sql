--new task types for MAXDAT-9243
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (17,'DHCS-EDER Review','DHCS-EDER Review','Maximus Consultants',90,'B',90,89,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (18,'Process Retro Disenrollment','Process Retro Disenrollment','Enrollment Operations',1,'B',1,0,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (19,'DHCS-Exemption Review','DHCS-Exemption Review','Maximus Consultants',90,'B',90,89,null);
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (24,'Process Exemption Approval/Denial','Process Exemption Approval/Denial','Enrollment Operations',1,'B',1,0,null);

--New Entities for MAXDAT-9243
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5020,5,1,'DHCS_EXEMPTION_REVIEW_CRM','Activity ends when DHCS is finished reviewing','',90,'B','N','N','','DHCS');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5021,5,1,'PROCESS_APPROVAL_DENIAL_CRM','Activity ends when approvals or denials have been processed','',1,'B','N','N','','RESEARCH');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5022,5,1,'DHCS_EDER_REVIEW_CRM','Activity ends when DHCS is finished reviewing','',90,'B','N','N','','DHCS');
Insert into D_BPM_ENTITY (ENTITY_ID,ENTITY_TYPE_ID,PROCESS_ID,ENTITY_NAME,ENTITY_DESCRIPTION,SOURCE_REFERENCE_TYPE,TIMELINESS_THRESHOLD,TIMELINESS_DAYS_TYPE,IS_STARTING_ENTITY,IS_TERMINATING_ENTITY,ENTITY_SOURCE,BUSINESS_PROCESS_POOL) values (5023,5,1,'PROCESS_RETRO_DISENROLLMENT_CRM','Activity ends when retro disenrollments have been processed','',1,'B','N','N','','RESEARCH');

--update entity sort order for new entities for MAXDAT-9243
update  d_bpm_entity set entity_sort_order = 123 where entity_id = 5022;
update  d_bpm_entity set entity_sort_order = 126 where entity_id = 5023;
update  d_bpm_entity set entity_sort_order = 133 where entity_id = 5020;
update  d_bpm_entity set entity_sort_order = 136 where entity_id = 5021;

--new for MAXDAT-9243
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (17,5022);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (18,5023);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (19,5020);
Insert into D_BPM_TASK_TYPE_ENTITY (TASK_TYPE_ID,ENTITY_ID) values (24,5021);

--new flows for MAXDAT-9243
Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) 
values (31,1,'PROCESS_EXEMPTION_CRM_TO_DHCS_EXEMPTION_REVIEW_CRM','Process Exemption CRM to DHCS Exemption Review CRM',5009,5020);

Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) 
values (32,1,'PROCESS_EDER_CRM_TO_DHS_EDER_REVIEW_CRM','Process EDER CRM to DHS EDER Review CRM',5008,5022);

Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) 
values (33,1,'DHCS_EXEMPTION_REVIEW_CRM_TO_PROCESS_APPROVAL_DENIAL_CRM','DHCS Exemption Review CRM to Process Approval Denial CRM',5020,5021);

Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) 
values (34,1,'DHCS_EXEMPTION_REVIEW_CRM_TO_E2E_MODEL_PACKET_LETTER_TO_KP','DHCS Exemption Review CRM to E2E Model Packet Letter to KP',5020,5013);

Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) 
values (35,1,'DHS_EDER_REVIEW_CRM_TO_PROCESS_RETRO_DISENROLLMENT_CRM','DHS EDER Review CRM to Process Retro Disenrollment CRM',5022,5023);

Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) 
values (36,1,'DHS_EDER_REVIEW_CRM_TO_E2E_MODEL_PACKET_LETTER_TO_KP','DHS EDER Review CRM to E2E Model Packet Letter to KP',5022,5013);

Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) 
values (37,1,'PROCESS_APPROVAL_DENIAL_CRM_TO_E2E_MODEL_PACKET_LETTER_TO_KP','Process Approval Denial CRM to E2E Model Packet Letter to KP',5021,5013);

Insert into D_BPM_FLOW (FLOW_ID,PROCESS_ID,FLOW_NAME,FLOW_DESCRIPTION,FLOW_SOURCE_ENTITY_ID,FLOW_DESTINATION_ENTITY_ID) 
values (38,1,'PROCESS_RETRO_DISENROLLMENT_CRM_TO_E2E_MODEL_PACKET_LETTER_TO_KP','DHS EDER Review CRM to E2E Model Packet Letter to KP',5023,5013);


--new step definitions for MAXDAT-9243
   insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   17,                     'VIRTUAL_HUMAN_TASK',   'DHCS-EDER Review',                                            'DHCS-EDER Review',                                                 'DHCS-EDER Review'   );   

   insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   18,                     'VIRTUAL_HUMAN_TASK',   'Process Retro Disenrollment',                                  'Process Retro Disenrollment',                                  'Process Retro Disenrollment'   );   

    
    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   19,                     'VIRTUAL_HUMAN_TASK',   'DHCS-Exemption Review',                                        'DHCS-Exemption Review',                                        'DHCS-Exemption Review'   );   

    insert 
      into  STEP_DEFINITION     (   STEP_DEFINITION_ID,     STEP_TYPE_CD,           NAME,                                                           DESCRIPTION,                                                    DISPLAY_NAME    )
    values                      (   24,                     'VIRTUAL_HUMAN_TASK',   'Process Exemption Approval/Denial',                            'Process Exemption Approval/Denial',                            'Process Exemption Approval/Denial'   );   


--new ops groups MAXDAT-9243
insert into bpm_d_ops_group_task (OPS_GROUP, TASK_TYPE) values ('Maximus Consultants','DHCS-EDER Review');
insert into bpm_d_ops_group_task (OPS_GROUP, TASK_TYPE) values ('Maximus Consultants','DHCS-Exemption Review');

commit;
