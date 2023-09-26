-- remove the unique constraints to the metric table

alter table s_metric_template disable constraint s_metric_template_un;

-- add column functional area

alter table s_metric_template add (functional_area varchar2(50));

