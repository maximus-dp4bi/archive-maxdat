delete from f_metric
where d_metric_project_id in
(
select d_metric_project_id from d_metric_project
WHERE d_project_id in
(
select d_project_id from d_project
where project_name like '%TX%'
)
);

delete from  S_METRIC
where S_ACTUALS_PROJECT_REPORT_ID in
(
select s_project_report_id from S_PROJECT_REPORT
where d_project_id in
(
select d_project_id from d_project
where project_name like '%TX%'
)
);

delete from S_PROJECT_REPORT
where d_project_id in
(
select d_project_id from d_project
where project_name like '%TX%'
);

commit