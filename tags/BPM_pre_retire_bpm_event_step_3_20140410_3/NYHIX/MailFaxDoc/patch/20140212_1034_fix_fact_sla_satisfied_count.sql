--Update sla_satisfied_count in UAT

update f_nyhix_mfd_by_date
set sla_satisfied_count = 1
where dnmfdes_id = (select dnmfdes_id 
                                from d_nyhix_mfd_env_status 
                                where envelope_status = 'COMPLETEDRELEASED');

commit;