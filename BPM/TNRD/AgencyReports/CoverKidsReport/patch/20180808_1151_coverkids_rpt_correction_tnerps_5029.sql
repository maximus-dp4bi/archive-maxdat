delete from coverkids_approval_stg
where trunc(create_date) = trunc(sysdate-1)
and cumulative_ind = 'N';

commit;