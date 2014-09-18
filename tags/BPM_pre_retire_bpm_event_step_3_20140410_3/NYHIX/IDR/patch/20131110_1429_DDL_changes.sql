alter table nyhx_etl_idr_incidents_oltp modify ACTION_COMMENTS varchar2(4000);
alter table nyhx_etl_idr_incidents_oltp modify RESOLUTION_DESCRIPTION varchar2(4000);

alter table nyhx_etl_idr_incidents_wip modify ACTION_COMMENTS varchar2(4000);
alter table nyhx_etl_idr_incidents_wip modify RESOLUTION_DESCRIPTION varchar2(4000);