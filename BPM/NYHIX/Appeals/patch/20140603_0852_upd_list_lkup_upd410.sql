UPDATE corp_etl_list_lkup
SET out_var =  out_var||',''SHOP Desk Review'''
WHERE name = 'PA_UPD4_10';

commit;