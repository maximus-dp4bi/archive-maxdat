column plan_name format a35
column source format a30 
column prior_plan format a35
select trunc(status_date) Record_date, p.plan_name, substr(sou.report_label,1,20) Source, count(distinct selection_txn_id) count
from selection_txn st, eb.plan p, enum_enrollment_trans_source sou
where p.plan_id = case when st.transaction_type_cd = 'Disenrollment' and st.disenroll_reason_cd_1 = 'NFPHPCR13' then 601 else st.plan_id end
and st.create_ts >= to_date('6/28/2019','mm/dd/yyyy')
and st.status_cd = 'acceptedByState'
and sou.value = st.selection_source_cd
and (st.transaction_type_cd in ('NewEnrollment','Transfer') or (st.transaction_type_cd = 'Disenrollment' and st.disenroll_reason_cd_1 = 'NFPHPCR13'))
group by trunc(status_date) ,  p.plan_name , substr(sou.report_label,1,20) 
order by trunc(status_date) desc ,  p.plan_name , substr(sou.report_label,1,20) 
;

column TO_plan format a30
column FROM_plan format a30
select 'Disenrollment' Transaction_type, trunc(status_date) Record_date, pp.plan_name FROM_Plan, p.plan_name TO_plan, substr(sou.report_label,1,20) Source, count(distinct selection_txn_id) count
from selection_txn st, eb.plan p, eb.plan pp, enum_enrollment_trans_source sou
where p.plan_id = case when st.transaction_type_cd = 'Disenrollment' and st.disenroll_reason_cd_1 = 'NFPHPCR13' then 601 else st.plan_id end
and pp.plan_id = case when st.transaction_type_cd = 'Disenrollment' and st.disenroll_reason_cd_1 = 'NFPHPCR13' then st.plan_id else st.prior_plan_id end
and st.transaction_type_cd in ( 'Transfer', 'Disenrollment')
and st.create_ts >= to_date('6/28/2019','mm/dd/yyyy')
and st.status_cd = 'acceptedByState'
and sou.value = st.selection_source_cd
group by trunc(status_date) , pp.plan_name,  p.plan_name  , substr(sou.report_label,1,20) 
order by trunc(status_date) desc , pp.plan_name,  p.plan_name  , substr(sou.report_label,1,20) 
;

