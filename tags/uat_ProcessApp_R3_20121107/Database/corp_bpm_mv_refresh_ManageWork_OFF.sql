update corp_bpm_mv_refresh
set process = 'ManageWork_stop'
where process = 'ManageWork';

commit;
