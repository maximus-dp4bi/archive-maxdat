--This will populate assd date for doh 
--1505 rows will be updated

declare
cursor csr_ee_state is
select *
from corp_etl_complaints_incidents stg
where forwarded = 'Y'
and GWF_ESCALATE_TO_STATE = 'Y'
and ASSD_RESOLVE_INCIDENT_DOH is null
and GWF_RESOLVED_EES_CSS = 'N'
and forwarded = 'Y'
--and exists (select incident_header_id from incident_header_stat_hist_stg where incident_header_id = stg.incident_id and  status_cd in ( 'REFERRED_TO_SUPERVISOR'))
and instance_status = 'Active';

r_csr_ee_state csr_ee_state%ROWTYPE;
v_state_create_dt  date  := null;
v_sup_create_dt date := null;
v_closed_dt date := null;

begin
open csr_ee_state;
fetch csr_ee_state into r_csr_ee_state;
while csr_ee_state%found
loop
--select max(create_ts) into v_sup_create_dt from incident_header_stat_hist_stg where status_cd  = 'REFERRED_TO_SUPERVISOR' and incident_header_id = r_csr_ee_state.incident_id;

select min(create_ts) into v_state_create_dt from incident_header_stat_hist_stg where status_cd  like '%STATE%' and incident_header_id = r_csr_ee_state.incident_id;
--select max(create_ts) into v_closed_dt from incident_header_stat_hist_stg where status_cd  in( 'CLOSED','INCIDENT_CLOSED','REFERRAL CLOSED') and incident_header_id = r_csr_ee_state.incident_id;

update corp_etl_complaints_incidents set 
ASSD_RESOLVE_INCIDENT_DOH = v_state_create_dt
where incident_id = r_csr_ee_state.incident_id;

fetch csr_ee_state into r_csr_ee_state;
end loop;
close csr_ee_state;

commit;
end;
/