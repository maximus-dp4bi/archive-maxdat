--This will populate ased date for ees_css for the new process path where ees css forwards to supervisor and then to state
--14 rows will be updated

declare
cursor csr_ee_state is
select * from corp_etl_complaints_incidents stg
where incident_status in ('Incident Closed','Referral Closed')
and  exists (select incident_header_id from incident_header_stat_hist_stg where incident_header_id = stg.incident_id and  status_cd in ( 'REFERRED_TO_SUPERVISOR'))
and exists (select incident_header_id from incident_header_stat_hist_stg where incident_header_id = stg.incident_id and  status_cd like '%STATE%')
and ased_resolve_incident_EES_CSS is  null
and assd_resolve_incident_EES_CSS is not null;

r_csr_ee_state csr_ee_state%ROWTYPE;
v_state_create_dt  date  := null;
v_sup_create_dt date := null;
v_closed_dt date := null;

begin
open csr_ee_state;
fetch csr_ee_state into r_csr_ee_state;
while csr_ee_state%found
loop
select max(create_ts) into v_sup_create_dt from incident_header_stat_hist_stg where status_cd  = 'REFERRED_TO_SUPERVISOR' and incident_header_id = r_csr_ee_state.incident_id;

select max(create_ts) into v_state_create_dt from incident_header_stat_hist_stg where status_cd  like '%STATE%' and incident_header_id = r_csr_ee_state.incident_id;
select max(create_ts) into v_closed_dt from incident_header_stat_hist_stg where status_cd  in( 'CLOSED','INCIDENT_CLOSED','REFERRAL CLOSED') and incident_header_id = r_csr_ee_state.incident_id;

update corp_etl_complaints_incidents set ased_resolve_incident_EES_CSS = v_sup_create_dt,
ASSD_RESOLVE_INCIDENT_SUP = v_sup_create_dt,
ASED_RESOLVE_INCIDENT_SUP = v_state_create_dt,
ASSD_RESOLVE_INCIDENT_DOH = v_state_create_dt,
ASED_RESOLVE_INCIDENT_DOH = v_closed_dt
where incident_id = r_csr_ee_state.incident_id;

fetch csr_ee_state into r_csr_ee_state;
end loop;
close csr_ee_state;

commit;
end;
/