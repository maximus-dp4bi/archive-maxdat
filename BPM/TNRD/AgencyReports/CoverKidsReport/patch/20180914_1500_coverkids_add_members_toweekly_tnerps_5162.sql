update coverkids_approval_stg
set create_date = sysdate
where application_id in(832186,
832169,
873122,
873463)
and cumulative_ind = 'N'
and directive = 'START'
and trunc(create_date) = to_date('09/05/2018','mm/dd/yyyy');

delete from coverkids_approval_stg
where application_id in(832186,
832169,
873122,
873463)
and cumulative_ind in('W','Y')
and directive = 'START';

commit;