
delete from coverkids_approval_stg
where trunc(create_date) >= trunc(sysdate)
and cumulative_ind = 'N'
and client_id != 206159;

commit;