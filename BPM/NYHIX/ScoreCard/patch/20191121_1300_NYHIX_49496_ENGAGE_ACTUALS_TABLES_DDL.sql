ALTER TABLE DP_SCORECARD.ENGAGE_ACTUALS_STG
ADD (
CUSTOMER_SERVICE_QC_SCORE NUMBER(5,2),
CONTENT_QC_SCORE NUMBER(5,2)
);

ALTER TABLE DP_SCORECARD.ENGAGE_ACTUALS
ADD (
CUSTOMER_SERVICE_QC_SCORE NUMBER(5,2),
CONTENT_QC_SCORE NUMBER(5,2)
);