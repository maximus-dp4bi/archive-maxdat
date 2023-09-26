update D_PL_CURRENT
set SLA_CATEGORY = 'Other'
where SLA_CATEGORY = 'Others';

commit;