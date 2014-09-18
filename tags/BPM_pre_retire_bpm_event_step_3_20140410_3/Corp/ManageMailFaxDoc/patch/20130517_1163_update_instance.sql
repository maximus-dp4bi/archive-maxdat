declare
cursor csr_mailfaxdoc is
select * from corp_etl_mailfaxdoc_wip_bpm;

r_csr_mailfaxdoc csr_mailfaxdoc%rowtype;
v_count number :=0;
begin
open  csr_mailfaxdoc;
fetch csr_mailfaxdoc  INTO r_csr_mailfaxdoc;
while csr_mailfaxdoc%found
loop
update corp_etl_mailfaxdoc 
set instance_status = r_csr_mailfaxdoc.instance_status,
instance_complete_dt = r_csr_mailfaxdoc.instance_complete_dt
where cemfd_id = r_csr_mailfaxdoc.cemfd_id;

fetch csr_mailfaxdoc  INTO r_csr_mailfaxdoc;
v_count := v_count + 1 ;
end loop;
close csr_mailfaxdoc;
if v_count = 1000 then
commit;
end if;
commit;
end;
