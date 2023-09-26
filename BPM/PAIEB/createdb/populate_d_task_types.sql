REM INSERTING into D_TASK_TYPES
SET DEFINE OFF;
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (3003,'Document Problem Resolution','APS - Document Research','Research Unit',1,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (3005,'Link Document Set','APS - Link Documents to Individuals','Mailroom / Image Assembly',1,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (3007,'State Data Entry','APS - State Data Entry Task','Data Entry Unit',1,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (3040,'Alternate Document VHT','Alternate Document VHT','Data Entry Unit',10,'C',7,7,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (3035,'Alternate Document Processing','Alternate Document Processing','Data Entry Unit',2,'C',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32212,'Appointment Outreach Task - Assessor Missed Apt','Follow-up manual task for Appointment-Assessor Conflict campaign. Could not reach out client by phone ','Call Center',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32213,'Application Outreach','Follow-up manual task for Referral campaign. Could not reach out client by phone ','Call Center',1,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32220,'CSR General Reminder Task','General Manual Tasks for CSRs only - since they should have limited forwarding rights','Call Center',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32241,'Manual Task - General','General Manual Task','Data Entry Unit',5,'C',4,4,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32331,'Finalize SC Agency - Delay','Manual Task for Plan Info Data Entry - Delay','Call Center',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32461,'Appointment Outreach Task – No Show (Consumer)','Appointment Outreach Task – No Show (Consumer)','Assessors Unit',1,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32462,'Appointment Outreach Task – Interrupted','Appointment Outreach Task – Interrupted','Assessors Unit',1,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32481,'BHA - Mailing Appeal','Manual task for mailing appeal documentation to BHA upon initiation of appeal request in MAXeATS.','Mailroom / Image Assembly',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32482,'Schedule Pre-Hearing','Manual task to prompt scheduling of Pre-Hearing upon initiation of appeal request in MAXeATS.','Appeals Unit',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32483,'Appeal Scheduled - Notify','Manual task to prompt notification of appeal hearing scheduled after completion of Hearing Scheduled task in MAXeATS.','Mailroom / Image Assembly',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32484,'Appeal Follow-up - Actions Needed','Manual task generated if completion of Appeal Resolution Follow-up task results in re-fax or other follow-up action in order to prompt acceptance/denial of Stipulated Settlement or final decision by judge.','Mailroom / Image Assembly',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32485,'Create Appeal','Task to create an appeal when a document with type = Appeal Request is linked to the case.','Data Entry Unit',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32486,'Schedule Hearing','Task to schedule hearing when document with type = Hearing Notice is linked to the case.','Appeals Unit',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32487,'Final Adjudication','Task created when document with type = Adjudication is linked to the case.','Appeals Unit',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32488,'Appeal Resolution Follow-up','Task created every 30 days as long as the appeal remains in a status of Stipulated Settlement or Waiting for Judge''s Decision.','Appeals Unit',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32489,'Process Remand','Task created when document with type = Remand Notice is linked to the case.','Appeals Unit',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32501,'PC Data Entry','When a Physician''s Request is received for a case which does not have an In process application, this task is created; ','Data Entry Unit',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32502,'LCD Data Entry','When a Level of Care Determination is received for a case which does not have an In process application, this task is created; ','Data Entry Unit',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32503,'HCBS Denial Task','The HCBS Denial Task is created when the OLTL sends us the HCBS Denial letter that was created for a case which was Denied due to ineligibility. ','Mailroom / Image Assembly',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (32504,'COMPASS Data Entry','COMPASS Data Entry task is created when the PA600 or PA600L application is received from the client and the worker has to perform data entry into COMPASS','Data Entry Unit',2,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (60001,'Application Data Entry','Application Data Entry','Data Entry Unit',1,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (60002,'Application Review','Application Review','Data Entry Unit',1,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (60003,'Verify Missing Information','Verify Missing Information','Data Entry Unit',1,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (60004,'Plan Info Data Entry - No Delay','Plan Info Data Entry - No Delay','Data Entry Unit',1,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (60005,'Close Application Task','Close Application Task','Data Entry Unit',1,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (60006,'Discharge Confirmation Outreach Task','Discharge Confirmation Outreach Task','Call Center',1,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (60007,'Finalize SC Agency Task','Finalize SC Agency Task','Call Center',1,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (60008,'Complete Application Task','Complete Application Task','Data Entry Unit',1,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (60009,'Waiver Mistmatch Task','Waiver Mistmatch Task','Data Entry Unit',1,'B',1,1,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (60010,'PC Outreach Task','PC Outreach Task','Call Center',3,'B',2,2,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (71000,'Appointment Outreach Task - Assessor Conflict','Appointment Outreach Task - Assessor Conflict','Assessors Unit',3,'B',2,2,'PA IEB Tasks');

Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (60017,'Outbound FAX Research','Manual Task for Outbound FAX Research','Mailroom / Image Assembly',5,'B',4,4,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (40137216,'Update SC Agency','Update SC Agency','Data Entry Unit',5,'B',4,4,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK)
values (31000,'Liaison','Liaison Task - Repurposed to track State Escalations.','Research Unit',5,'B',4,4,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (40137223,'Update Delayed Enrollment Information','Manual Task created by Call Center/EBS to tell Enrollment to update Discharge date, Facility info, etc','Data Entry Unit',5,'B',4,4,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (40137221,'Resend PC / LCD','This manual task will be created for resending PC and LCD for applicants.','Mailroom / Image Assembly',5,'B',4,4,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (60013,'COMPASS Data Entry','COMPASS Data Entry','Mailroom / Image Assembly',5,'B',4,4,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (40137214,'Send OLTL HCBS Denial Notice','Send OLTL HCBS Denial Notice','Mailroom / Image Assembly',5,'B',4,4,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (40137217,'Special Case Alert','Special Case Alert','Research Unit',5,'B',4,4,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (40137222,'Reapplication','Reapplication - Call center reps are going to create it and send to the call center supervisors','Mailroom / Image Assembly',5,'B',4,4,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (110,'Manual Human Task','Manual Task - Virtual Human Task','Data Entry Unit',5,'B',4,4,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (60015,'Finalize Eligibility Task','Finalize Eligibility Task','Mailroom / Image Assembly',5,'B',4,4,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (32544,'Retrieve LCD from SAMS','Manual task created by worker to check SAMS for LCD documentation','Mailroom / Image Assembly',5,'B',4,4,'PA IEB Tasks');
Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) 
values (60016,'Check SAMS Documentation Task','Manual Task for Check SAMS Documentation','Mailroom / Image Assembly',5,'B',4,4,'PA IEB Tasks');

insert into d_task_types(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work)
values(32211,'Appointment Outreach','Appointment Outreach','Research Unit',1,'B',1,1,'PA IEB Tasks');

insert into d_task_types(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work)
values(32496,'Appeal Resolution Follow Up','Appeal Resolution Follow Up','Appeals Unit',3,'B',2,2,'PA IEB Tasks');

insert into d_task_types(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work)
values(40137254,'CHC Enrollment Form Outreach','CHC Enrollment Form Outreach','CHC Data Entry',2,'B',1,1,'PA CHC Manual Tasks');

insert into d_task_types(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work)
values(40137255,'CHC Manual Packet Request','CHC Manual Packet Request','CHC Data Entry',2,'B',1,1,'PA CHC Manual Tasks');

insert into d_task_types(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work)
values(32546,'CHC Enrollment Data Entry','CHC Enrollment Data Entry','CHC Data Entry',2,'B',1,1,'PA CHC Manual Tasks');

insert into d_task_types(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work)
values(40137234,'Fair Hearing Request','Fair Hearing Request','Appeals Unit',2,'B',1,1,'PA IEB Tasks');

commit;