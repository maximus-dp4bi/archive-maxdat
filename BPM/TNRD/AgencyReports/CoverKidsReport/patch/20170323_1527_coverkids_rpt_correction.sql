UPDATE corp_etl_control
  SET value =  '2016/12/20 00:00:00'
  WHERE name = 'COVERKIDS_RPT_START_DATE'; 

DELETE FROM coverkids_approval_stg
where client_id in(select client_id from app_individual_stg
where client_cin in('11046532360',
'11039502366',
'11039711631',
'11039711640',
'97040943092',
'55600456641',
'97013253637'
))
and cumulative_ind = 'N';

commit;