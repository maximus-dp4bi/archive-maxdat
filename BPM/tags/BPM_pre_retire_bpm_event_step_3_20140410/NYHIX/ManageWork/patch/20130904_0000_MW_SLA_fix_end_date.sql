update corp_etl_list_lkup 
set end_date = to_date('07/07/7777','mm/dd/yyyy')
where  end_date =  to_date('07/07/0777','mm/dd/yyyy');
commit;
