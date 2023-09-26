select incident_id Before from maxdat.nyhbe_process_appeals_oltp
where incident_id in (27182724,27182656);

select incident_id Before from maxdat.nyhbe_process_appeals_wip_bpm
where incident_id in (27182724,27182656);

select incident_id Before from maxdat.nyhbe_etl_process_appeals_rsn
where incident_id in (27182724,27182656);

select incident_id Before from maxdat.nyhbe_etl_process_appeals
where incident_id in (27182724,27182656);

select incident_tracking_number Before from maxdat.d_appeals_current 
where incident_tracking_number in (28639756,28639931);

select apl_bi_id Before from maxdat.f_appeals_by_date
where apl_bi_id in (38721910,38719013);

delete from maxdat.nyhbe_process_appeals_oltp
where incident_id in (27182724,27182656);

delete from maxdat.nyhbe_process_appeals_wip_bpm
where incident_id in (27182724,27182656);

delete from maxdat.nyhbe_etl_process_appeals_rsn
where incident_id in (27182724,27182656);

delete from maxdat.nyhbe_etl_process_appeals
where incident_id in (27182724,27182656);

delete from maxdat.d_appeals_current 
where incident_tracking_number in (28639756,28639931);

delete from maxdat.f_appeals_by_date
where apl_bi_id in (38721910,38719013);

commit;

select incident_id After from maxdat.nyhbe_process_appeals_oltp
where incident_id in (27182724,27182656);

select incident_id After from maxdat.nyhbe_process_appeals_wip_bpm
where incident_id in (27182724,27182656);

select incident_id After from maxdat.nyhbe_etl_process_appeals_rsn
where incident_id in (27182724,27182656);

select incident_id After from maxdat.nyhbe_etl_process_appeals
where incident_id in (27182724,27182656);

select incident_tracking_number After from maxdat.d_appeals_current 
where incident_tracking_number in (28639756,28639931);

select apl_bi_id After from maxdat.f_appeals_by_date
where apl_bi_id in (38721910,38719013);

