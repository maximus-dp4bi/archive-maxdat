--This will populate ased date for sup for the process path where sup forwards to state and then it completes,1247 rows

declare
cursor csr_ee_state is
select *
from CORP_ETL_COMPLAINTS_INCIDENTS stg
where --incident_id = 26075484
incident_status in ('Incident Closed','Referral Closed')
and 
ased_resolve_incident_sup is  null
and assd_resolve_incident_sup is not null
--and gwf_escalate_to_state = 'Y'
and  exists (select incident_header_id from incident_header_stat_hist_stg where incident_header_id = stg.incident_id and  status_cd in ( 'REFERRED_TO_SUPERVISOR'))
and exists (select incident_header_id from incident_header_stat_hist_stg where incident_header_id = stg.incident_id and  status_cd like '%STATE%');

r_csr_ee_state csr_ee_state%ROWTYPE;
v_state_create_dt  date  := null;
v_closed_dt date := null;

begin
open csr_ee_state;
fetch csr_ee_state into r_csr_ee_state;
while csr_ee_state%found
loop
select max(create_ts) into v_state_create_dt from incident_header_stat_hist_stg where status_cd  like '%STATE%' and incident_header_id = r_csr_ee_state.incident_id;
select max(create_ts) into v_closed_dt from incident_header_stat_hist_stg where status_cd  in( 'CLOSED','INCIDENT_CLOSED','REFERRAL CLOSED') and incident_header_id = r_csr_ee_state.incident_id;

update corp_etl_complaints_incidents set 
 ASED_RESOLVE_INCIDENT_SUP = v_state_create_dt,
 ASSD_RESOLVE_INCIDENT_DOH = v_state_create_dt,
 ASED_RESOLVE_INCIDENT_DOH =  v_closed_dt
where incident_id = r_csr_ee_state.incident_id;

fetch csr_ee_state into r_csr_ee_state;
end loop;
close csr_ee_state;

commit;
end;
/