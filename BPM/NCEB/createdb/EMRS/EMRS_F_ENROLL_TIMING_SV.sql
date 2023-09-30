drop view EMRS_F_ENROLL_TIMING_SV;
CREATE OR REPLACE VIEW EMRS_F_ENROLL_TIMING_SV AS 
with sl as    
(   
select * from (   
select slct.selection_txn_id, slct.transaction_type_cd, slct.selection_source_cd, sts.description, slct.status_cd, slct.status_date, slcth.selection_txn_status_hist_id accepted_id,
          slcth.create_ts accepted_ts, COALESCE(slct.Selection_Generic_Field5_Txt, elig.segment_detail_value_2) MANAGED_CARE_STATUS, row_number() over(partition by slct.selection_txn_id order by slcth.selection_txn_status_hist_id desc) rown   
from selection_txn slct   
join selection_txn_status_history slcth on slcth.selection_txn_id = slct.selection_txn_id and slcth.status_cd in ('acceptedByState','denied') and slcth.create_ts >= to_date('3/1/2021','mm/dd/yyyy')   
join enum_enrollment_trans_source sts on sts.value = slct.selection_source_cd   
left join elig_segment_and_details elig on (elig.segment_type_cd = 'ME'
                                                 and elig.client_id = slct.client_id
                                                 and elig.start_nd <= nvl(slct.start_nd, to_number(to_char(slct.status_date,'YYYYMMDD')))
                                                 and elig.end_nd >= nvl(slct.start_nd, to_number(to_char(slct.status_date,'YYYYMMDD')))
                                                 )
where slct.transaction_type_cd in ('NewEnrollment','Transfer')
and selection_source_cd in ('W','M','P')   
) where rown = 1   
)   
, sl1 as    
(   
select * from (   
select sl.*, slcthr.selection_txn_status_hist_id ready_id, slcthr.create_ts ready_ts, row_number() over(partition by sl.selection_txn_id order by slcthr.selection_txn_status_hist_id desc) rownr   
from sl sl   
join selection_txn_status_history slcthr on slcthr.selection_txn_id = sl.selection_txn_id and slcthr.status_cd = 'readyToUpload' and slcthr.selection_txn_status_hist_id < sl.accepted_id   
)   
where rownr = 1   
), slc as (
select * from (  
select slct.selection_txn_id, slct.transaction_type_cd, slct.selection_source_cd, sts.description, slct.status_cd, slct.status_date, slcth.selection_txn_status_hist_id accepted_id,
          slcth.create_ts accepted_ts, COALESCE(slct.Selection_Generic_Field5_Txt, elig.segment_detail_value_2) MANAGED_CARE_STATUS, row_number() over(partition by slct.selection_txn_id order by slcth.selection_txn_status_hist_id desc) rown  
from selection_txn slct  
join selection_txn_status_history slcth on slcth.selection_txn_id = slct.selection_txn_id and slcth.status_cd in ('acceptedByState','denied') and slcth.create_ts >= to_date('3/1/2021','mm/dd/yyyy')  
join enum_enrollment_trans_source sts on sts.value = slct.selection_source_cd  
left join elig_segment_and_details elig on (elig.segment_type_cd = 'ME'
                                                 and elig.client_id = slct.client_id
                                                 and elig.start_nd <= nvl(slct.start_nd, to_number(to_char(slct.status_date,'YYYYMMDD')))
                                                 and elig.end_nd >= nvl(slct.start_nd, to_number(to_char(slct.status_date,'YYYYMMDD')))
                                                 )
where slct.transaction_type_cd in ('NewEnrollment','Transfer')
and selection_source_cd in ('C')  
) where rown = 1  
)  
, sl1c as   
(
select * from (  
select sl.*, slcthr.selection_txn_status_hist_id ready_id, slcthr.create_ts ready_ts, doc.scan_date, row_number() over(partition by sl.selection_txn_id order by slcthr.selection_txn_status_hist_id desc) rownr  
from slc sl  
join selection_txn_status_history slcthr on slcthr.selection_txn_id = sl.selection_txn_id --and slcthr.status_cd = 'readyToUpload'
                                                                                            and slcthr.selection_txn_status_hist_id < sl.accepted_id
LEFT JOIN eb.doc_link dl on dl.link_type_cd = 'SELECTION_TXN' and dl.link_ref_id = sl.selection_txn_id
left join eb.document doc on doc.document_id = dl.document_id
)  
where rownr = 1  
)    
SELECT * FROM (
select
  trunc(sl1.accepted_ts) Report_Day   
, trunc(sl1.accepted_ts,'MM') Report_month   
, sl1.transaction_type_cd   
, sl1.selection_source_cd   
, sl1.description   
, sl1.status_cd   
, sl1.MANAGED_CARE_STATUS
, count(sl1.selection_txn_id) count_txns
, round(sum((sl1.accepted_ts - sl1.ready_ts))) total_days   
, round(sum((sl1.accepted_ts - sl1.ready_ts))/count(sl1.selection_txn_id),1) avg_days   
, round(sum((sl1.accepted_ts - sl1.ready_ts) * 1440*60),2) total_accepted_secs   
, round(sum((sl1.accepted_ts - sl1.ready_ts) * 1440*60)/count(sl1.selection_txn_id),1) avg_accepted_secs   
from sl1
group by trunc(sl1.accepted_ts)    
, trunc(sl1.accepted_ts,'MM')    
, sl1.transaction_type_cd   
, sl1.selection_source_cd   
, sl1.description   
, sl1.status_cd
, sl1.MANAGED_CARE_STATUS   
UNION
SELECT
  trunc(sl1c.accepted_ts) Report_Day   
, trunc(sl1c.accepted_ts,'MM') Report_month   
, sl1c.transaction_type_cd   
, sl1c.selection_source_cd   
, CASE WHEN sl1c.scan_date IS null THEN 'Phone into the MAXIMUS contact center' ELSE sl1c.description END description   
, sl1c.status_cd   
, sl1c.MANAGED_CARE_STATUS
, count(sl1c.selection_txn_id) count_txns   
, CASE WHEN TRUNC(sl1c.scan_date,'YY') IS NULL THEN round(sum((sl1c.accepted_ts - sl1c.ready_ts))) ELSE round(sum((sl1c.accepted_ts - sl1c.scan_date))) end
, CASE WHEN TRUNC(sl1c.scan_date,'YY') IS null THEN round(sum((sl1c.accepted_ts - sl1c.ready_ts))/count(sl1c.selection_txn_id),1) ELSE round(sum((sl1c.accepted_ts - sl1c.scan_date))/count(sl1c.selection_txn_id),1) end   
, CASE WHEN TRUNC(sl1c.scan_date,'YY') IS null THEN round(sum((sl1c.accepted_ts - sl1c.ready_ts) * 1440*60),2) ELSE round(sum((sl1c.accepted_ts - sl1c.scan_date) * 1440*60),2) end   
, CASE WHEN TRUNC(sl1c.scan_date,'YY') IS null THEN round(sum((sl1c.accepted_ts - sl1c.ready_ts) * 1440*60)/count(sl1c.selection_txn_id),1) ELSE round(sum((sl1c.accepted_ts - sl1c.scan_date) * 1440*60)/count(sl1c.selection_txn_id),1) end   
from sl1c
group by trunc(sl1c.accepted_ts)    
, trunc(sl1c.accepted_ts,'MM')    
, sl1c.transaction_type_cd   
, sl1c.selection_source_cd   
, CASE WHEN sl1c.scan_date IS null THEN 'Phone into the MAXIMUS contact center' ELSE sl1c.description END   
, sl1c.status_cd
, sl1c.MANAGED_CARE_STATUS
, TRUNC(sl1c.scan_date,'YY')   
)
order by Report_Day    
, Report_month     
, transaction_type_cd   
, selection_source_cd   
, description   
, status_cd
  
;

GRANT SELECT ON EMRS_F_ENROLL_TIMING_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON EMRS_F_ENROLL_TIMING_SV TO MAXDAT_REPORTS;

