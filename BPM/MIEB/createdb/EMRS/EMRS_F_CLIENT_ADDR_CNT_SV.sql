CREATE OR REPLACE VIEW EMRS_F_CLIENT_ADDR_CNT_SV AS 
select report_date, sum(cr_addr_count) cr_addr_count, sum(cm_addr_count) cm_addr_count from (
select trunc(ad.creation_date) report_date
,sum(case when ad.addr_type_cd = 'CR' then 1 else 0 end) CR_addr_count
,sum(case when ad.addr_type_cd = 'CM' then 1 else 0 end) CM_addr_count
 from EB.address ad
  where addr_type_Cd in ('CR','CM') 
  and ad.addr_id >= 16564814
--and ( trunc(addr_end_date) > trunc(addr_begin_date) or addr_end_Date is null)
group by trunc(ad.creation_date)
union
select d_date report_date, 0 CR_addr_count, 0 CM_addr_count
from maxdat_support.d_dates d
where d.d_date >= to_date('1/1/2023','mm/dd/yyyy')
)
group by report_date
;


GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_CLIENT_ADDR_CNT_SV TO MAXDAT_REPORTS;
