declare
cursor csr_main is with driver as (select incident_id 
,count(*)
,max(incident_status_dt ) max_incident_status_dt
from MAXDAT.corp_etl_compl_incidents_oltp
group by incident_id having count(*) > 1) 

select m.incident_id,m.incident_status_dt,d.max_incident_status_dt from corp_etl_complaints_incidents m,driver d
where m.incident_status_dt <> d.max_incident_status_dt
and m.incident_id = d.incident_id 
order by incident_id;

r_csr_main csr_main%rowtype;
v_count number:=0;

begin
open csr_main;
fetch csr_main into r_csr_main;
while csr_main%found
loop
  update nyhx_etl_complaints_incidents
  set incident_status_dt = r_csr_main.max_incident_status_dt
  where incident_id = r_csr_main.incident_id;
  fetch csr_main into r_csr_main;
  v_count:= v_count + 1;
  if v_count = 100 then
    commit;
    v_count := 0;
  end if;
end loop;
close csr_main;
commit;
end;