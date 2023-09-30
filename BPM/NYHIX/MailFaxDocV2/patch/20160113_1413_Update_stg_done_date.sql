

Update d_nyhix_mfd_current_v2
set stg_done_date = instance_end_date
where cancel_dt is not null and Cancel_by like '%NYHIX%'
and instance_end_date is not null
and instance_status = 'Complete';

commit;