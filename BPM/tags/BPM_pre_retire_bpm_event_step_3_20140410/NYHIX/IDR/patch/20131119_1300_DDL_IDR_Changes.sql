alter table nyhx_etl_idr_incidents_oltp modify forwarded VARCHAR2(1) default 'N' not null;
alter table nyhx_etl_idr_incidents_wip modify forwarded VARCHAR2(1) default 'N' not null;
alter table nyhx_etl_idr_incidents modify forwarded VARCHAR2(1) default 'N' not null;