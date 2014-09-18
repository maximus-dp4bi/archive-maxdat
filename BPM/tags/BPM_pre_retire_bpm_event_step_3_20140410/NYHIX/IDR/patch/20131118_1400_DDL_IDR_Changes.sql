alter table nyhx_etl_idr_incidents_oltp modify ASPB_IDR_REVIEW_DOCS VARCHAR2(150);
alter table nyhx_etl_idr_incidents_oltp modify ASPB_GATHER_MISS_INFO VARCHAR2(150);

alter table nyhx_etl_idr_incidents_wip modify ASPB_IDR_REVIEW_DOCS VARCHAR2(150);
alter table nyhx_etl_idr_incidents_wip modify ASPB_GATHER_MISS_INFO VARCHAR2(150);

alter table nyhx_etl_idr_incidents modify ASPB_IDR_REVIEW_DOCS VARCHAR2(150);
alter table nyhx_etl_idr_incidents modify ASPB_GATHER_MISS_INFO VARCHAR2(150);