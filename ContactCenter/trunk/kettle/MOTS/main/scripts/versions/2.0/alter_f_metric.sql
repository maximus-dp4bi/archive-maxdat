alter table F_METRIC
add (
  ACTUAL_TREND_INDICATOR number(1,0),
  ACTUAL_FORECAST_VARIANCE_FRMT number(1,0));
  
CREATE OR REPLACE VIEW F_METRIC_SV AS
SELECT F_METRIC.* FROM F_METRIC;