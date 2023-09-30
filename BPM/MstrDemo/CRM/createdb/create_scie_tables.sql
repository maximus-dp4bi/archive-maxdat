
CREATE TABLE d_sci_contact_reason(contact_reason_cd VARCHAR2(32), contact_reason VARCHAR2(256),contact_type_cd VARCHAR2(32));

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('INFORMATION_REQ', 'Information Request','INBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('UPDATE_INFO_REQ', 'Update Information Request','INBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('MATERIALS_REQ', 'Materials Request','INBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('OTHER', 'Other','INBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('INFORMATION_REQ', 'Information Request','OUTBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('UPDATE_INFO_REQ', 'Update Information Request','OUTBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('MATERIALS_REQ', 'Materials Request','OUTBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('MISSING_INFO_REQ', 'Missing Information Request','OUTBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('OTHER', 'Other','OUTBOUND');


CREATE TABLE d_sci_contact_action(contact_action_cd VARCHAR2(32), contact_action VARCHAR2(256), contact_reason_cd VARCHAR2(32));
--truncate table d_sci_contact_action
INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('CASE_STATUS_INFO','Provided Case Status/Information','INFORMATION_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('ELIG_STATUS_INFO','Provided Eligibility Status/Information','INFORMATION_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('ENROLL_STATUS_INFO','Provided Enrollment Status/Information','INFORMATION_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('FINANCIAL_INFO','Provided Financial Information','INFORMATION_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('UPDATE_DEMOGRAPHIC','Updated Demographic Information','UPDATE_INFO_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('UPDATE_ELIG_INFO','Updated Eligibility Information','UPDATE_INFO_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('UPDATE_ENROLL_INFO','Updated Enrollment Information','UPDATE_INFO_REQ');


INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('PROGRAM_MATERIAL','Sent Program Materials','MATERIALS_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('RESENT_NOTICE','Re-Sent Notice','MATERIALS_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('REQ_UPDATE_CASE','Requested and Updated Case Member Information','MISSING_INFO_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('REQ_UPDATE_DEMO','Requested and Updated Demographic Information','MISSING_INFO_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('REQ_UPDATE_AR','Requested and Updated Authorized Representative Information','MISSING_INFO_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('OTHER','Other','OTHER');