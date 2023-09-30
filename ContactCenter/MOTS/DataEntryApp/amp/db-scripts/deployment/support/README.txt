
These scripts are to be used to synchronize the metric definition tables across the DEV/UAT/PROD environments:
	GEN_INSERT_D_METRIC_DEFINITION.sql
	GEN_UPDATE_D_METRIC_DEFINITION.sql
	GEN_INSERT_D_METRIC_VALIDATION_RULE.sql
	GEN_INSERT_D_COMPARISON_METRIC.sql

Steps to execute:

1.  Execute GEN_UPDATE_D_METRIC_DEFINITION.sql in the baseline environment.
2.  Copy the results into a .sql file, e.g. UPDATE_D_METRIC_DEFINITION_YYYYMMMDD.sql
4.  If new metric definitions have been created, execute GEN_INSERT_D_METRIC_DEFINITION.sql in the baseline environment after updating the WHERE clause as appropriate.
5.  Copy the results into a .sql file, e.g. INSERT_D_METRIC_DEFINITION_YYYYMMMDD.sql
6.  Execute GEN_INSERT_D_METRIC_VALIDATION_RULE.sql in the baseline environment.
7.  Copy the results into a .sql file, e.g. INSERT_D_METRIC_VALIDATION_RULE_YYYYMMMDD.sql.
8.  Add the following statement to the beginning of the file:  
		DELETE D_METRIC_VALIDATION_RULE;
9.  Execute GEN_INSERT_D_COMPARISON_METRIC.sql in the baseline environment.
10.  Copy the results into a .sql file, e.g. INSERT_D_COMPARISON_METRIC_YYYYMMMDD.sql.
11.  Add the following statement to the beginning of the file:		
		DELETE D_COMPARISON_METRIC;
12.  Execute the resulting .sql files in the target environment.

The following script is used to migrate metric data provided by the spreadsheet templates to the AMP Data Capture staging tables:

	migrate_F_METRIC_to_AMP_staging_tables.sql
	
This script should be run as a part of the transition of a project from the templates to the web.  Prior to running the script,
the appropriate metrics should be configured to be provided by "Web" in D_METRIC_PROJECT.

