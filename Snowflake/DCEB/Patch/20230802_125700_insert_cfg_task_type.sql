INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16277,'Auto Assignment SR','SR Outreach To Member Who Are Eligible And Have Not Made A Plan Selection','Call Center',2,'B',2,1,'Outreach',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16402,'HRA/CAHMI Survey SR','SR Outreach to members who have completed their plan selection but have not completed the HRA CAHMI Survey','Call Center' ,10, 'B', 10, 8, 'Outreach',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16431,'Survey Outbound Call','Place an outbound call to members who have completed their plan selection but have not completed the Survey','Call Center', 1, 'B',
1,1,'Outreach',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16519, 'Review Complaint','Review Complaint and Call recordings and Escalate to State if needed to resolve the issue','Quality Assurance',3,'B',3,2,'Complaint',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16565,'For Cause SR','This SR is for processing a For Cause Request for a member from MAXIMUS to District','Call Center',7,'B',7,5,'ForCause',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16574,'FC Review','This task is created for qa manager to review the for cause request created for a case member','Quality Assurance',1,'B',1,1,'ForCause',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16575,'FC Missing Information','to work and edit a missing information outbound call task to perform member outreach for missing information','Call Center',1,'B',1,1,	'Outreach',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16576,'FC District Outreach','created for qA Manager to reach out to district  to get the for cause request update for the case members','Quality Assurance',1,'B',1,	1,'ForCause',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16577,'FC Member Notification','This task is created for CSR or QA Manager to reach out to member and notify them if their For Cause Request has been approved or denied','Call Center',1,'B',1,1,'Outreach',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16578,'FC Cancellation Request Confirmation','This task is created for csr and qa managers to reach out to member and notify them that their cancellation request has been approved or denied','Call Center',1,'B',1,1,'Outreach',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16579,'Invalid FC Member Notification','This task is created for CSR to reach out to member and notify them the FC request submitted is invalid','Call Center',1,'B',1,1,'Outreach',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16581,'District Outreach - Cancel SR','Created For QA Manager To Reach Out To District To Get The Approval For The Cancellation Request Submitted By The Member','Quality Assurance',1,'B',1,1,'ForCause',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16582,'New Address Correspondence Request','Review Correspondence Request For New Address Not In System Resend Correspondence If Applicable Create New Correspondence Request Document The Action','Data Entry',3,'B',3,2,'Review Correspondence',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16583,'Member Outbound Call','This Task Is Created For Member Outreach','Call Center',1,'B',1,1,'Outreach',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16584,'FC District 2nd Outreach','Created For QA Manager To Reach Out To District To Get The For Cause Request Update For The Case Members','Quality Assurance',1,'B',1,1,'ForCause',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16585,'Process Enrollment Form','This Task Is Created For CP User To process an inbound enrollment form packet','Data Entry',5,'B',5,4,'Data Entry',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16586,'Process An Unknown Inbound Correspondence','This Task Is Created For CP User To Process An Unknown Inbound Correspondence Document Received By The Project','Data Entry',5,'B',5,4,'Data Entry',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16587,'Return Mail Outbound Call','This Task Is Created For CSR To Make An OB Call When A Returned Mail Doc is Received By The Project','Call Center',2,'B',2,1,'Outreach',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16601,'Enrollment Rejection','This Task Is Created For CP User To Research and Resolve An Enrollment Selection Rejected By The MMIS','Data Entry',7,'B',7,5,'Outreach',120);

INSERT INTO marsdb.cfg_task_type(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work,project_id)
VALUES(16612,'Outreach OB Call','This Task Is Created For DC Project When A User Is Trying To Work On An Outreach Request Is Received BY The Project','Call Center',2,'B',2,1,'Outreach',120);

INSERT INTO marsdb.cfg_entity_types_map(project_id,type_type,from_value,to_value)
SELECT project_id,'COMPLAINT',value,report_label
FROM marsdb.marsdb_enum_complaint_type_vw
WHERE project_id = 120;