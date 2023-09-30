delete from coverkids_approval_stg
where cumulative_ind = 'N'
and trunc(create_date) = trunc(sysdate)
and client_id != 262171;

commit;