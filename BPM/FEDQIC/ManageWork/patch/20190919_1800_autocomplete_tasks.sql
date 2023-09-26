update maxdat.corp_etl_mw ti set ti.complete_date = trunc(sysdate,'hh24') 
where ti.complete_date is null and ti.cancel_work_date is null
and exists (select 1 from maxdat.d_mw_appeal_instance ap where ti.source_reference_id = ap.appeal_id
and ap.appeal_status in (47,49));

commit;