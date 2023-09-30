CREATE OR REPLACE VIEW d_pa_app_status_sv
AS
SELECT  app_status_code
       ,app_status
       ,display_order
       ,inventory_indicator
FROM d_app_status;

GRANT SELECT ON D_PA_APP_STATUS_SV TO MAXDAT_REPORTS;

