-- Creating Semantic Views  
-- dwd 9/19/2014
CREATE OR REPLACE VIEW BPM_D_CONTROL_CHART_PARAMS_SV AS  --name too long to use "parmeters"
SELECT
    D_CONTROL_CHART_ID
,   D_PROCESS_GROUP_METRIC_ID
,   REPORT_TYPE
,   MU
,   SIGMA
,   UCL_OF_SIGMA
,   LCL_OF_SIGMA
,   UPPER_CONTROL_LIMIT
,   LOWER_CONTROL_LIMIT
,   CENTER_LINE
,   UPPER_SPECIFICATION_LIMIT
,   LOWER_SPECIFICATION_LIMIT
,   UPPER_WARNING_LIMIT
,   LOWER_WARNING_LIMIT
,   CP
,   CPK
,   NUMBER_OF_OBSERVATIONS
,   PARAMETER_EFF_DT
,   PARAMETER_END_DT
,   CREATE_DATE
,   LAST_MODIFIED_DATE
,   CREATED_BY
,   UPDATED_BY
FROM BPM_D_CONTROL_CHART_PARAMETERS;

CREATE OR REPLACE PUBLIC SYNONYM BPM_D_CONTROL_CHART_PARAMS_SV FOR MAXDAT.BPM_D_CONTROL_CHART_PARAMS_SV;

GRANT SELECT ON BPM_D_CONTROL_CHART_PARAMS_SV TO MAXDAT_READ_ONLY;
--------------  
CREATE OR REPLACE VIEW BPM_D_REPORTING_PERIOD_SV AS
SELECT
    D_REPORTING_PERIOD_ID
,   TYPE
,   START_DATE
,   END_DATE
,   MONTH
,   YEAR
,   CREATE_DATE
,   CREATED_BY
,   LAST_MODIFIED_DATE
,   UPDATED_BY
FROM BPM_D_REPORTING_PERIOD;
  
CREATE OR REPLACE PUBLIC SYNONYM BPM_D_REPORTING_PERIOD_SV FOR MAXDAT.BPM_D_REPORTING_PERIOD_SV;

GRANT SELECT ON BPM_D_REPORTING_PERIOD_SV TO MAXDAT_READ_ONLY;
--------------  
CREATE OR REPLACE VIEW BPM_D_METRIC_DEFINITION_SV AS
SELECT
    D_METRIC_DEFINITION_ID
,   NAME
,   LABEL
,   RECORD_EFF_DT
,   RECORD_END_DT
,   CREATE_DATE
,   CREATED_BY
,   LAST_MODIFIED_DATE
,   UPDATED_BY
FROM BPM_D_METRIC_DEFINITION;
  
CREATE OR REPLACE PUBLIC SYNONYM BPM_D_METRIC_DEFINITION_SV FOR MAXDAT.BPM_D_METRIC_DEFINITION_SV;

GRANT SELECT ON BPM_D_METRIC_DEFINITION_SV TO MAXDAT_READ_ONLY;
--------------  
CREATE OR REPLACE VIEW BPM_D_PROCESS_DEFINITION_SV AS
SELECT
    D_PROCESS_DEFINITION_ID
,   PROCESS_NAME
,   LABEL
,   RECORD_EFF_DT
,   RECORD_END_DT
,   CREATE_DATE
,   CREATED_BY
,   LAST_MODIFIED_DATE
,   UPDATED_BY
FROM BPM_D_PROCESS_DEFINITION;

CREATE OR REPLACE PUBLIC SYNONYM BPM_D_PROCESS_DEFINITION_SV FOR MAXDAT.BPM_D_PROCESS_DEFINITION_SV;

GRANT SELECT ON BPM_D_PROCESS_DEFINITION_SV TO MAXDAT_READ_ONLY;
--------------  
CREATE OR REPLACE VIEW BPM_D_PROCESS_GROUP_SV AS
SELECT
    D_PROCESS_GROUP_ID
,   GROUP_NAME
,   LABEL
,   RECORD_EFF_DT
,   RECORD_END_DT
,   CREATE_DATE
,   CREATED_BY
,   LAST_MODIFIED_DATE
,   UPDATED_BY
FROM BPM_D_PROCESS_GROUP;

CREATE OR REPLACE PUBLIC SYNONYM BPM_D_PROCESS_GROUP_SV FOR MAXDAT.BPM_D_PROCESS_GROUP_SV;

GRANT SELECT ON BPM_D_PROCESS_GROUP_SV TO MAXDAT_READ_ONLY;
--------------  
CREATE OR REPLACE VIEW BPM_D_PROCESS_GROUP_DETAIL_SV AS
SELECT
    D_PROCESS_GROUP_DETAIL_ID
,   D_PROCESS_DEFINITION_ID
,   D_PROCESS_GROUP_ID
,   NAME
,   LABEL
,   RECORD_EFF_DT
,   RECORD_END_DT
,   CREATE_DATE
,   CREATED_BY
,   LAST_MODIFIED_DATE
,   UPDATED_BY
FROM BPM_D_PROCESS_GROUP_DETAIL;

CREATE OR REPLACE PUBLIC SYNONYM BPM_D_PROCESS_GROUP_DETAIL_SV FOR MAXDAT.BPM_D_PROCESS_GROUP_DETAIL_SV;

GRANT SELECT ON BPM_D_PROCESS_GROUP_DETAIL_SV TO MAXDAT_READ_ONLY;
--------------  
CREATE OR REPLACE VIEW BPM_D_PROCESS_GROUP_METRIC_SV AS
SELECT
    D_PROCESS_GROUP_METRIC_ID
,   D_METRIC_DEFINITION_ID
,   D_PROCESS_GROUP_DETAIL_ID
,   UPPER_SPECIFICATION_LIMIT
,   LOWER_SPECIFICATION_LIMIT
,   CALCULATE_CONTROL_CHART_IND
,   TREND_INDICATOR_CALCULATION
,   RECORD_EFF_DT
,   RECORD_END_DT
,   CREATE_DATE
,   CREATED_BY
,   LAST_MODIFIED_DATE
,   UPDATED_BY
FROM BPM_D_PROCESS_GROUP_METRIC;

CREATE OR REPLACE PUBLIC SYNONYM BPM_D_PROCESS_GROUP_METRIC_SV FOR MAXDAT.BPM_D_PROCESS_GROUP_METRIC_SV;

GRANT SELECT ON BPM_D_PROCESS_GROUP_METRIC_SV TO MAXDAT_READ_ONLY;
--------------  
CREATE OR REPLACE VIEW BPM_F_PROCESS_METRIC_SV AS
SELECT
    F_PROCESS_METRIC_ID
,   D_PROCESS_GROUP_METRIC_ID
,   D_REPORTING_PERIOD_ID
,   ACTUAL_VALUE
,   ACTUAL_TREND_INDICATOR
,   IS_TREND_INDICATOR_CALCULATED
,   CREATE_DATE
,   CREATED_BY
,   LAST_MODIFIED_DATE
,   UPDATED_BY
FROM BPM_F_PROCESS_METRIC;
  
CREATE OR REPLACE PUBLIC SYNONYM BPM_F_PROCESS_METRIC_SV FOR MAXDAT.BPM_F_PROCESS_METRIC_SV;

GRANT SELECT ON BPM_F_PROCESS_METRIC_SV TO MAXDAT_READ_ONLY;
