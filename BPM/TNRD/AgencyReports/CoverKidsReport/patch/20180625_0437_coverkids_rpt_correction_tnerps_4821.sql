delete from coverkids_approval_stg
where application_id in
(879668,
894110,
898469,
972216) 
and cumulative_ind = 'N'
;

commit;

select * from coverkids_approval_stg
where application_id in
(879668,
894110,
898469,
972216) ;