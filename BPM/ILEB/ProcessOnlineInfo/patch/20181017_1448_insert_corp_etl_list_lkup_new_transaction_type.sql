insert into corp_etl_list_lkup(name,list_type,value,out_var,ref_type,ref_id,start_date,end_date)
select name,list_type,'PCPMCPTransfer',out_var,ref_type,11,trunc(sysdate,'mm'),to_date('07/07/7777','mm/dd/yyyy')
from corp_etl_list_lkup
where value = 'PCPMMCTransfer'
;

execute MAXDAT_ADMIN. RESET_BPM_QUEUE_ROWS_BY_BSL_ID(19);

commit;