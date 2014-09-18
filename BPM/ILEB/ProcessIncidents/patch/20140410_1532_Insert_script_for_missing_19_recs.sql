/*
Created by Raj A. on 10-Apr-2014.
Description:
IL Process Incidents has 19 missing instances. This script was created to immediately fix the bug. Permanent fix will be deployed soon.
20140410_1532_Script_to_generate_INSERT_statements.sql generates the insert statements in the script, 20140410_1532_Insert_script_for_missing_19_recs.sql
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
(302,302,to_date('17-feb-2013 04:52:14 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('17-feb-2013 04:53:59 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Noble,David ','Call Center Test','Mail','Active','Complaint','Complaint Open',to_date('17-feb-2013 04:53:59 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','Self','','',to_date('17-feb-2013 04:53:59 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Noble,David ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('17-feb-2013 04:53:59 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','','PRODUCTION PTEST','','');

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
(3972,3972,to_date('04-mar-2013 12:37:57 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('04-mar-2013 12:42:01 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Scuefield,Markita ','Call Center Team 4','Phone','Active','Complaint','Complaint Open',to_date('04-mar-2013 12:42:02 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','','','',to_date('04-mar-2013 12:42:01 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Scuefield,Markita ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('04-mar-2013 12:42:02 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','','EFANI TILLIS','','');

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
(101788,101788,to_date('03-apr-2013 11:09:45 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('03-apr-2013 11:21:49 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Smith,Teresa ','Call Center Team 5','Phone','Active','Complaint','Complaint Open',to_date('03-apr-2013 11:21:49 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','','','',to_date('03-apr-2013 11:21:49 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Smith,Teresa ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('03-apr-2013 11:21:49 AM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','',' HARRIS','','');

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
(182032,182032,to_date('10-may-2013 02:54:42 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-may-2013 03:03:16 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Cauley,Donna ','Call Center Team 3','Phone','Active','Complaint','Complaint Open',to_date('10-may-2013 03:03:16 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','','','',to_date('10-may-2013 03:03:16 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Cauley,Donna ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-may-2013 03:03:16 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','',' CAULEY','','');

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
(282774,282774,to_date('22-jul-2013 10:51:10 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('22-jul-2013 10:55:34 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Boyd,Donnesha ','Call Center Team 5','Phone','Active','Complaint','Complaint Open',to_date('22-jul-2013 10:55:34 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','','','',to_date('22-jul-2013 10:55:34 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Boyd,Donnesha ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('22-jul-2013 10:55:34 AM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','','SHEWONA JOHNSON','','');

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
(325639,325639,to_date('05-aug-2013 04:46:35 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('05-aug-2013 04:49:11 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Moore,Antonia ','Call Center Team 2','Phone','Active','Complaint','Complaint Open',to_date('05-aug-2013 04:49:11 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','','','',to_date('05-aug-2013 04:49:11 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Moore,Antonia ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('05-aug-2013 04:49:11 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','',' GORDON','','');

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
(361425,361425,to_date('28-aug-2013 01:02:07 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('28-aug-2013 01:05:58 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Scuefield,Markita ','Call Center Team 4','Phone','Active','Complaint','Complaint Open',to_date('28-aug-2013 01:05:58 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','Self','','',to_date('28-aug-2013 01:05:58 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Scuefield,Markita ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('28-aug-2013 01:05:58 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','','MOLLY WARREN','','');

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
(370277,370277,to_date('03-sep-2013 04:20:41 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('03-sep-2013 04:24:24 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Lewis,Curtis ','Call Center Team 2','Phone','Active','Complaint','Complaint Open',to_date('03-sep-2013 04:24:24 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','','','',to_date('03-sep-2013 04:24:24 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Lewis,Curtis ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('03-sep-2013 04:24:24 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','','DOROTA GRACA','','');

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
(537726,537726,to_date('18-nov-2013 09:27:30 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('18-nov-2013 09:28:33 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Reynozo,Sandra ','Call Center Team 4','Phone','Active','Complaint','Complaint Open',to_date('18-nov-2013 09:28:33 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','Self','','',to_date('18-nov-2013 09:28:33 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Reynozo,Sandra ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('18-nov-2013 09:28:33 AM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','','LOURIE CARTER','','');

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
(579289,579289,to_date('09-dec-2013 01:16:53 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('09-dec-2013 01:22:57 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Bryant,Camilla ','Call Center Team 2','Phone','Active','Complaint','Complaint Open',to_date('09-dec-2013 01:22:57 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','','','',to_date('09-dec-2013 01:22:57 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Bryant,Camilla ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('09-dec-2013 01:22:57 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','','CHEYENN E DELOSSANTOS','','');

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
(828699,828699,to_date('03-mar-2014 09:56:46 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('03-mar-2014 09:59:07 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Deline,Jason ','Call Center Team 2','Phone','Active','Complaint','Complaint Open',to_date('03-mar-2014 09:59:07 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','Self','','',to_date('03-mar-2014 09:59:07 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Deline,Jason ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('03-mar-2014 09:59:07 AM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','','ANDREW STEPANSKY','063','Macon');

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
(898355,898355,to_date('24-mar-2014 04:23:44 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('24-mar-2014 04:26:45 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Poole,Tekeyina ','Call Center Team 2','Phone','Active','Complaint','Complaint Open',to_date('24-mar-2014 04:26:45 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Other','Other Unrelated Adult','MEDICAID','MMAI',to_date('24-mar-2014 04:26:45 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Poole,Tekeyina ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('24-mar-2014 04:26:45 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','202610580',' FEMALE','062','Logan');

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
(898386,898386,to_date('25-mar-2014 10:07:16 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('25-mar-2014 10:16:02 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Aguirre,Sylvia ','Call Center Team 1','Phone','Active','Complaint','Complaint Open',to_date('25-mar-2014 10:16:02 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','Self','MEDICAID','',to_date('25-mar-2014 10:16:02 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Aguirre,Sylvia ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('25-mar-2014 10:16:02 AM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','167644145','JUVENCIO ANTONIO','200','Cook');

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
(898453,898453,to_date('25-mar-2014 02:12:57 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('25-mar-2014 02:17:35 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Aguirre,Sylvia ','Call Center Team 1','Phone','Active','Complaint','Complaint Open',to_date('25-mar-2014 02:17:35 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','Self','MEDICAID','VMC',to_date('25-mar-2014 02:17:35 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Aguirre,Sylvia ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('25-mar-2014 02:17:35 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','135969103','MARIA MARTINEZ','200','Cook');

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
(909317,909317,to_date('26-mar-2014 09:11:26 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('26-mar-2014 09:14:01 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Cole,Sonya ','Call Center Team 1','Phone','Active','Complaint','Complaint Open',to_date('26-mar-2014 09:14:01 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','Self','MEDICAID','VMC',to_date('26-mar-2014 09:14:01 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Cole,Sonya ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('26-mar-2014 09:14:01 AM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','097274849','LATONYIA MCCURRY','200','Cook');

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
(923422,923422,to_date('01-apr-2014 10:33:01 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('01-apr-2014 10:35:51 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Zamora,Maribel ','Call Center Team 5','Phone','Active','Complaint','Complaint Open',to_date('01-apr-2014 10:33:01 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Authorized Representative','Other Related Adult','MEDICAID','ICP',to_date('01-apr-2014 10:35:51 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Zamora,Maribel ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('01-apr-2014 10:33:01 AM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','205468036','ROSS MEDOW','200','Cook');

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
(923455,923455,to_date('01-apr-2014 05:33:37 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('01-apr-2014 05:35:36 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Randall,Khadijah ','Call Center Team 4','Phone','Active','Complaint','Complaint Open',to_date('01-apr-2014 05:35:36 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Authorized Representative','Spouse','','',to_date('01-apr-2014 05:35:36 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Randall,Khadijah ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('01-apr-2014 05:35:36 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','','MOHAMMAD AHMAD','200','Cook');

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
(930968,930968,to_date('03-apr-2014 04:04:50 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('03-apr-2014 04:08:35 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Payne,Stephnie ','Call Center Team 1','Phone','Active','Complaint','Complaint Open',to_date('03-apr-2014 04:08:35 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Head of Case','Self','MEDICAID','VMC',to_date('03-apr-2014 04:08:35 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Payne,Stephnie ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('03-apr-2014 04:08:35 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','150174142','BRITTANY HOLLEY','200','Cook');

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
(934228,934228,to_date('07-apr-2014 01:45:42 PM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('07-apr-2014 01:49:33 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Mendez,Francisco ','Call Center Team 2','Phone','Active','Complaint','Complaint Open',to_date('07-apr-2014 01:45:42 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Other','Other Related Adult','MEDICAID','MMAI',to_date('07-apr-2014 01:49:33 PM', 'dd-mon-yyyy hh:mi:ss PM'),'Mendez,Francisco ',to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('10-apr-2014 11:34:18 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('07-apr-2014 01:45:42 PM', 'dd-mon-yyyy hh:mi:ss PM'),'N','N','130046386','PORFIRIA MARQUINA','200','Cook');

commit;