alter table nyhx_etl_idr_incidents modify current_task_id number(38);
alter table nyhx_etl_idr_incidents_oltp modify current_task_id number(38);
alter table nyhx_etl_idr_incidents_wip modify current_task_id number(38);
alter table d_idr_current modify CUR_CURRENT_TASK_ID number(38);

alter table nyhx_etl_idr_incidents modify MAX_INCI_STAT_HIST_ID number(38);
alter table nyhx_etl_idr_incidents_oltp modify MAX_INCI_STAT_HIST_ID number(38);
alter table nyhx_etl_idr_incidents_wip modify MAX_INCI_STAT_HIST_ID number(38);

alter table nyhx_etl_idr_incidents modify case_id number(38);
alter table nyhx_etl_idr_incidents_oltp modify case_id number(38);
alter table nyhx_etl_idr_incidents_wip modify case_id number(38);
alter table d_idr_current modify case_id number(38);