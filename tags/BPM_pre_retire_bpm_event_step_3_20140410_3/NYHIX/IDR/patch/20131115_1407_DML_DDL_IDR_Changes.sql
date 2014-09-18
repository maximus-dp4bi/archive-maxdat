alter table nyhx_etl_idr_incidents_oltp modify incident_type varchar2(80);
alter table nyhx_etl_idr_incidents_wip modify incident_type varchar2(80);
alter table nyhx_etl_idr_incidents modify incident_type varchar2(80);


alter table nyhx_etl_idr_incidents_oltp modify RESOLUTION_TYPE varchar2(64);
alter table nyhx_etl_idr_incidents_wip modify RESOLUTION_TYPE varchar2(64);
alter table nyhx_etl_idr_incidents modify RESOLUTION_TYPE varchar2(64);


alter table nyhx_etl_idr_incidents_oltp modify REPORTER_RELATIONSHIP varchar2(64);
alter table nyhx_etl_idr_incidents_wip modify REPORTER_RELATIONSHIP varchar2(64);
alter table nyhx_etl_idr_incidents modify REPORTER_RELATIONSHIP varchar2(64);


update corp_etl_control
   set value = 90
where name = 'IDR_LOOK_BACK_DAYS';
commit;