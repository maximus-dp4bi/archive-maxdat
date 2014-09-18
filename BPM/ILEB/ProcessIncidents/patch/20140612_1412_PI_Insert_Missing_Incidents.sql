/*
Created by Raj A. on 12-Jun-2014.
Description:
IL Process Incidents has TWO missing instances. This script was created to immediately fix the bug. Permanent fix will be deployed today or tomorrow to UAT & PRD.
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
(1168739,1168739,to_date('09-jun-2014 12:46:01 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('09-jun-2014 12:49:02 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Castrejon,Martha ','Call Center Team 2','Phone','Active','Complaint','Complaint Open',to_date('09-jun-2014 12:46:01 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','Self','MEDICAID','MMAI',to_date('09-jun-2014 12:49:02 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Castrejon,Martha ',to_date('12-jun-2014 11:46:45 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('12-jun-2014 11:46:45 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('09-jun-2014 12:46:01 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','171336662','JORGE PEREZ','200','Cook');

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
(1172909,1172909,to_date('10-jun-2014 02:42:17 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-jun-2014 02:50:44 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Cole,Sonya ','Call Center Team 1','Phone','Active','Complaint','Complaint Open',to_date('10-jun-2014 02:42:17 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','Self','MEDICAID','MMAI',to_date('10-jun-2014 02:50:44 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Cole,Sonya ',to_date('12-jun-2014 11:46:45 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('12-jun-2014 11:46:45 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-jun-2014 02:42:17 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','188399166','MARIYA BELUSHKOVA','200','Cook');

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
(1175850,1175850,to_date('11-jun-2014 03:42:59 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('11-jun-2014 03:47:02 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Raiford,Terra ','Call Center Team 2','Phone','Active','Complaint','Complaint Open',to_date('11-jun-2014 04:29:40 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','Self','MEDICAID','ICP',to_date('11-jun-2014 03:47:02 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Raiford,Terra ',to_date('12-jun-2014 11:46:45 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('12-jun-2014 11:46:45 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('11-jun-2014 04:29:40 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','107925794','VIRGINIA CARTER','054','Kankakee');

commit;