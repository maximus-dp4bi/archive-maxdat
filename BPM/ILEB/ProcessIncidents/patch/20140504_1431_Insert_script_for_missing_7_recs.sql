/*
Created by Raj A. on 04-May-2014.
Description:
IL Process Incidents has 07 missing instances. This script was created to immediately fix the bug. Permanent fix will be deployed soon.
20140410_1532_Script_to_generate_INSERT_statements.sql generates the insert statements in the script, 20140410_1532_Insert_script_for_missing_19_recs.sql

Original ticket was ILEB-3009, 3011 (deployment tickets to UAT & PRD).
Next ticket: ILEB-3113 (bug reported ticket)
*/
insert into corp_etl_process_incidents (
incident_id,
tracking_number,
receipt_dt,
create_dt,
created_by_name,
created_by_group,
channel,
instance_status,
incident_type,
incident_status,
incident_status_dt,
reported_by,
reporter_relationship,
program_type,
program_subtype,
last_update_by_dt,
last_update_by_name,
stg_extract_date,
stg_last_update_date,
assd_identify_rsrch_incident,
asf_identify_rsrch_incident,
asf_resolve_cmplt_incident,
enrollee_rin,
reporter_name,
county_code,
county_name
)
values
(982747,982747,to_date('14-apr-2014 01:03:43 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('14-apr-2014 01:12:18 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Morales,Yolanda ','Call Center Team 4','Phone','Active','Complaint','Complaint Open',to_date('29-apr-2014 09:56:47 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','Self','','',to_date('14-apr-2014 01:12:18 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Morales,Yolanda ',to_date('04-may-2014 12:24:06 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('04-may-2014 12:24:06 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('29-apr-2014 09:56:47 AM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','','ANTONIA RECENDIZ','200','Cook');

insert into corp_etl_process_incidents (
incident_id,
tracking_number,
receipt_dt,
create_dt,
created_by_name,
created_by_group,
channel,
instance_status,
incident_type,
incident_status,
incident_status_dt,
reported_by,
reporter_relationship,
program_type,
program_subtype,
last_update_by_dt,
last_update_by_name,
stg_extract_date,
stg_last_update_date,
assd_identify_rsrch_incident,
asf_identify_rsrch_incident,
asf_resolve_cmplt_incident,
enrollee_rin,
reporter_name,
county_code,
county_name
)
values
(982947,982947,to_date('15-apr-2014 06:38:26 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('15-apr-2014 06:44:07 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Barrera,Araly ','Call Center Team 2','Phone','Active','Complaint','Complaint Open',to_date('30-apr-2014 04:37:44 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','','MEDICAID','VMC',to_date('15-apr-2014 06:44:07 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Barrera,Araly ',to_date('04-may-2014 12:24:06 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('04-may-2014 12:24:06 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('30-apr-2014 04:37:44 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','084347459','TAYANA GARDNER','200','Cook');

insert into corp_etl_process_incidents (
incident_id,
tracking_number,
receipt_dt,
create_dt,
created_by_name,
created_by_group,
channel,
instance_status,
incident_type,
incident_status,
incident_status_dt,
reported_by,
reporter_relationship,
program_type,
program_subtype,
last_update_by_dt,
last_update_by_name,
stg_extract_date,
stg_last_update_date,
assd_identify_rsrch_incident,
asf_identify_rsrch_incident,
asf_resolve_cmplt_incident,
enrollee_rin,
reporter_name,
county_code,
county_name
)
values
(986007,986007,to_date('16-apr-2014 09:57:16 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('16-apr-2014 09:58:32 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Randall,Khadijah ','Call Center Team 4','Phone','Active','Complaint','Complaint Open',to_date('23-apr-2014 11:40:27 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','','','',to_date('16-apr-2014 09:58:32 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Randall,Khadijah ',to_date('04-may-2014 12:24:06 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('04-may-2014 12:24:06 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('23-apr-2014 11:40:27 AM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','',' GILMORE','200','Cook');

insert into corp_etl_process_incidents (
incident_id,
tracking_number,
receipt_dt,
create_dt,
created_by_name,
created_by_group,
channel,
instance_status,
incident_type,
incident_status,
incident_status_dt,
reported_by,
reporter_relationship,
program_type,
program_subtype,
last_update_by_dt,
last_update_by_name,
stg_extract_date,
stg_last_update_date,
assd_identify_rsrch_incident,
asf_identify_rsrch_incident,
asf_resolve_cmplt_incident,
enrollee_rin,
reporter_name,
county_code,
county_name
)
values
(992230,992230,to_date('18-apr-2014 11:28:59 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('18-apr-2014 11:32:44 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Britton,Adrianna ','Data EntryTeam 1','Mail','Active','Complaint','Complaint Open',to_date('29-apr-2014 02:35:48 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Other','Self','MEDICAID','VMC',to_date('18-apr-2014 11:32:44 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Britton,Adrianna ',to_date('04-may-2014 12:24:06 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('04-may-2014 12:24:06 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('29-apr-2014 02:35:48 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','228416517','ASHLEY COLE','200','Cook');

insert into corp_etl_process_incidents (
incident_id,
tracking_number,
receipt_dt,
create_dt,
created_by_name,
created_by_group,
channel,
instance_status,
incident_type,
incident_status,
incident_status_dt,
reported_by,
reporter_relationship,
program_type,
program_subtype,
last_update_by_dt,
last_update_by_name,
stg_extract_date,
stg_last_update_date,
assd_identify_rsrch_incident,
asf_identify_rsrch_incident,
asf_resolve_cmplt_incident,
enrollee_rin,
reporter_name,
county_code,
county_name
)
values
(992260,992260,to_date('18-apr-2014 02:34:59 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('18-apr-2014 02:42:15 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Wood,Ruth ','Call Center Team 4','Phone','Active','Complaint','Complaint Open',to_date('29-apr-2014 02:55:08 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','Self','MEDICAID','VMC',to_date('18-apr-2014 02:42:15 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Wood,Ruth ',to_date('04-may-2014 12:24:06 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('04-may-2014 12:24:06 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('29-apr-2014 02:55:08 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','980774210','SASHA MITCHELL','200','Cook');

insert into corp_etl_process_incidents (
incident_id,
tracking_number,
receipt_dt,
create_dt,
created_by_name,
created_by_group,
channel,
instance_status,
incident_type,
incident_status,
incident_status_dt,
reported_by,
reporter_relationship,
program_type,
program_subtype,
last_update_by_dt,
last_update_by_name,
stg_extract_date,
stg_last_update_date,
assd_identify_rsrch_incident,
asf_identify_rsrch_incident,
asf_resolve_cmplt_incident,
enrollee_rin,
reporter_name,
county_code,
county_name
)
values
(1001311,1001311,to_date('22-apr-2014 03:32:00 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('22-apr-2014 03:34:32 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Randall,Khadijah ','Call Center Team 4','Phone','Active','Complaint','Complaint Open',to_date('29-apr-2014 03:52:00 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','','','',to_date('22-apr-2014 03:34:32 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Randall,Khadijah ',to_date('04-may-2014 12:24:06 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('04-may-2014 12:24:06 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('29-apr-2014 03:52:00 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','',' DOTE','013','Boone');

insert into corp_etl_process_incidents (
incident_id,
tracking_number,
receipt_dt,
create_dt,
created_by_name,
created_by_group,
channel,
instance_status,
incident_type,
incident_status,
incident_status_dt,
reported_by,
reporter_relationship,
program_type,
program_subtype,
last_update_by_dt,
last_update_by_name,
stg_extract_date,
stg_last_update_date,
assd_identify_rsrch_incident,
asf_identify_rsrch_incident,
asf_resolve_cmplt_incident,
enrollee_rin,
reporter_name,
county_code,
county_name
)
values
(1021182,1021182,to_date('29-apr-2014 03:49:49 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('29-apr-2014 03:55:34 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Osborne,Charlotte ','Call Center Team 5','Phone','Active','Complaint','Complaint Open',to_date('01-may-2014 08:16:44 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','Self','','',to_date('29-apr-2014 03:55:34 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Osborne,Charlotte ',to_date('04-may-2014 12:24:06 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('04-may-2014 12:24:06 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('01-may-2014 08:16:44 AM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','','LISA WHITE','070','McDonough');

commit;