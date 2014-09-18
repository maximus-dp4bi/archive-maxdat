/*
Created by Raj A. on 13-May-2014.
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
(1077034,1077034,to_date('12-may-2014 11:38:23 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('12-may-2014 11:55:04 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Lewis,Curtis ','Call Center Team 4','Phone','Active','Complaint','Complaint Open',to_date('12-may-2014 11:38:23 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Authorized Representative','Authorized Representative','','',to_date('12-may-2014 11:55:04 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Lewis,Curtis ',to_date('13-may-2014 02:24:22 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('13-may-2014 02:24:22 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('12-may-2014 11:38:23 AM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','','LUCY CHIRAYIL','100','Vermilion');
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
(1077097,1077097,to_date('12-may-2014 06:56:59 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('12-may-2014 07:03:25 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Castrejon,Martha ','Call Center Team 2','Phone','Active','Complaint','Complaint Open',to_date('12-may-2014 06:56:59 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','','MEDICAID','PCCM',to_date('12-may-2014 07:03:25 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Castrejon,Martha ',to_date('13-may-2014 02:24:22 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('13-may-2014 02:24:22 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('12-may-2014 06:56:59 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','139978845','JAMIE WALKER-CLARK','057','Lake');

commit;