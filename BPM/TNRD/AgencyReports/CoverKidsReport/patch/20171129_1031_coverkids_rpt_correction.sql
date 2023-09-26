delete from coverkids_approval_stg
where trunc(create_date) = to_date('11/28/2017','mm/dd/yyyy')
and cumulative_ind = 'N'
and client_id in(757428,986744);

commit;
