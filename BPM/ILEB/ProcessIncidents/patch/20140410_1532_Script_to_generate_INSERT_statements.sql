/*
Created by Raj A. on 10-Apr-2014.
Description:
IL Process Incidents has 19 missing instances. This script was created to immediately fix the bug. Permanent fix will be deployed soon.
20140410_1532_Script_to_generate_INSERT_statements.sql generates the insert statements in the script, 20140410_1532_Insert_script_for_missing_19_recs.sql
*/
begin
for cur_rec in ( select * from corp_etl_process_incidents
                  where incident_id in (
                          302,
                          3972,
                          101788,
                          182032,
                          282774,
                          325639,
                          361425,
                          370277,
                          537726,
                          579289,
                          828699,
                          898355,
                          898386,
                          898453,
                          909317,
                          923422,
                          923455,
                          930968,
                          934228
                          )
                    )
loop

dbms_output.put_line('insert into corp_etl_process_incidents (
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
('||cur_rec.incident_id||','
||cur_rec.tracking_number||','
||'to_date('''||to_char(cur_rec.receipt_dt,'dd-mon-yyyy hh:mi:ss PM')||''', ''dd-mon-yyyy hh:mi:ss PM'')'||','
||'to_date('''||to_char(cur_rec.create_dt,'dd-mon-yyyy hh:mi:ss PM')||''', ''dd-mon-yyyy hh:mi:ss PM'')'||','
||''''||cur_rec.created_by_name||''''||','
||''''||cur_rec.created_by_group||''''||','
||''''||cur_rec.channel||''''||','
||''''||cur_rec.instance_status||''''||','
||''''||cur_rec.incident_type||''''||','
||''''||cur_rec.incident_status||''''||','
||'to_date('''||to_char(cur_rec.incident_status_dt,'dd-mon-yyyy hh:mi:ss PM')||''', ''dd-mon-yyyy hh:mi:ss PM'')'||','
||''''||cur_rec.reported_by||''''||','
||''''||cur_rec.reporter_relationship||''''||','
||''''||cur_rec.program_type||''''||','
||''''||cur_rec.program_subtype||''''||','
||'to_date('''||to_char(cur_rec.last_update_by_dt,'dd-mon-yyyy hh:mi:ss PM')||''', ''dd-mon-yyyy hh:mi:ss PM'')'||','
||''''||cur_rec.last_update_by_name||''''||','
||'to_date('''||to_char(sysdate,'dd-mon-yyyy hh:mi:ss PM')||''', ''dd-mon-yyyy hh:mi:ss PM'')'||','
||'to_date('''||to_char(sysdate,'dd-mon-yyyy hh:mi:ss PM')||''', ''dd-mon-yyyy hh:mi:ss PM'')'||','
||'to_date('''||to_char(cur_rec.assd_identify_rsrch_incident,'dd-mon-yyyy hh:mi:ss PM')||''', ''dd-mon-yyyy hh:mi:ss PM'')'||','
||''''||cur_rec.asf_identify_rsrch_incident||''''||','
||''''||cur_rec.asf_resolve_cmplt_incident||''''||','
||''''||cur_rec.enrollee_rin||''''||','
||''''||cur_rec.reporter_name||''''||','
||''''||cur_rec.county_code||''''||','
||''''||cur_rec.county_name||''''||
');'
);

end loop;

end;
