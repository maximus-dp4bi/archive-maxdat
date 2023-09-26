create or replace view D_METRIC_VALIDATION_RULE_SV  as select * from D_METRIC_VALIDATION_RULE; 
create or replace view D_COMPARISON_METRIC_SV  as select * from D_COMPARISON_METRIC; 
create or replace view S_PROJECT_REPORT_SV  as select * from S_PROJECT_REPORT; 
create or replace view S_PROJECT_REPORT_ACTUALS_SV  as select * from S_PROJECT_REPORT where report_type = 'actuals';
create or replace view S_PROJECT_REPORT_FORECASTS_SV  as select * from S_PROJECT_REPORT where report_type = 'forecasts';
create or replace view S_METRIC_SV  as select * from S_METRIC; 
create or replace view D_METRIC_DEFINITION_AUD_SV  as select * from D_METRIC_DEFINITION_AUD; 
create or replace view D_METRIC_PROJECT_AUD_SV  as select * from D_METRIC_PROJECT_AUD; 
create or replace view D_METRIC_VAL_RULE_AUD_SV  as select * from D_METRIC_VALIDATION_RULE_AUD; 
create or replace view S_METRIC_AUD_SV  as select * from S_METRIC_AUD; 
create or replace view S_PROJECT_REPORT_AUD_SV  as select * from S_PROJECT_REPORT_AUD; 

grant select, references on D_METRIC_VALIDATION_RULE_SV to MAXDAT_REPORTS;
grant select, references on D_COMPARISON_METRIC_SV to MAXDAT_REPORTS;
grant select, references on S_PROJECT_REPORT_SV to MAXDAT_REPORTS;
grant select, references on S_PROJECT_REPORT_ACTUALS_SV to MAXDAT_REPORTS;
grant select, references on S_PROJECT_REPORT_FORECASTS_SV to MAXDAT_REPORTS;
grant select, references on S_METRIC_SV to MAXDAT_REPORTS;
grant select, references on D_METRIC_DEFINITION_AUD_SV to MAXDAT_REPORTS;
grant select, references on D_METRIC_PROJECT_AUD_SV to MAXDAT_REPORTS;
grant select, references on D_METRIC_VAL_RULE_AUD_SV to MAXDAT_REPORTS;
grant select, references on S_METRIC_AUD_SV to MAXDAT_REPORTS;
grant select, references on S_PROJECT_REPORT_AUD_SV to MAXDAT_REPORTS;


grant select, references on D_METRIC_VALIDATION_RULE_SV to MOTS_READ_ONLY;
grant select, references on D_COMPARISON_METRIC_SV to MOTS_READ_ONLY;
grant select, references on S_PROJECT_REPORT_SV to MOTS_READ_ONLY;
grant select, references on S_PROJECT_REPORT_ACTUALS_SV to MOTS_READ_ONLY;
grant select, references on S_PROJECT_REPORT_FORECASTS_SV to MOTS_READ_ONLY;
grant select, references on S_METRIC_SV to MOTS_READ_ONLY;
grant select, references on D_METRIC_DEFINITION_AUD_SV to MOTS_READ_ONLY;
grant select, references on D_METRIC_PROJECT_AUD_SV to MOTS_READ_ONLY;
grant select, references on D_METRIC_VAL_RULE_AUD_SV to MOTS_READ_ONLY;
grant select, references on S_METRIC_AUD_SV to MOTS_READ_ONLY;
grant select, references on S_PROJECT_REPORT_AUD_SV to MOTS_READ_ONLY;


