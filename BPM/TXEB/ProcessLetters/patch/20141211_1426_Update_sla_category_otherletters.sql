update d_pl_current
set sla_category = 'Other Letter'
where program is null
and sla_category != 'Other Letter'; 

commit;