update corp_etl_list_lkup
set out_var = 16
where name = 'ProcessMail_jeop_threshold'
and list_type = 'DOC_TYPE';

update corp_etl_list_lkup
set out_var = 40
where name = 'ProcessMail_timeli_threshold'
and list_type = 'DOC_TYPE';

update D_MFDOC_CURRENT set 
"Instance Status" = 'Active' ,
"Instance Complete Date" = null, 
"Cancel By" = null, 
"Cancel Reason" = null , 
"Cancel Method" = null
where DCN in (select substr(dcn,1,35)
from corp_etl_mailfaxdoc d								
where d.instance_status = 'Active'	
and  trunc(d.dcn_create_dt ) in ( '12-APR-2013','10-JUN-2013','11-JUN-2013')
minus
select   substr(dcn,1,35)
from      D_MFDOC_CURRENT_SV a11						
where     a11."Instance Status" = 'Active'		
and  trunc("DCN Create Date" ) in ( '12-APR-2013','10-JUN-2013','11-JUN-2013'));

commit;