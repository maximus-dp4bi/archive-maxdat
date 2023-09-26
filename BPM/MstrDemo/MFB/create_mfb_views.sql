CREATE OR REPLACE VIEW d_mfb_events_sv
AS
SELECT * FROM d_mfb_events;

GRANT SELECT ON d_mfb_events_sv TO maxdat_read_only;

CREATE OR REPLACE VIEW d_mfb_reporting_sv
AS
SELECT * FROM d_mfb_reporting;

GRANT SELECT ON d_mfb_reporting_sv TO maxdat_read_only;

CREATE OR REPLACE VIEW d_mfb_form_sv
AS
SELECT * FROM d_mfb_form;

GRANT SELECT ON d_mfb_form_sv TO maxdat_read_only;

CREATE OR REPLACE VIEW d_mfb_current_sv
AS
SELECT * FROM d_mfb_current;

GRANT SELECT ON d_mfb_current_sv TO maxdat_read_only;

CREATE OR REPLACE VIEW f_mfb_by_date_sv
AS
SELECT d_date
,SUM(creation_count) creation_count
,SUM(inventory_count) inventory_count
,SUM(completion_count) completion_count
FROM f_mfb_by_date
GROUP BY d_date;

GRANT SELECT ON f_mfb_by_date_sv TO maxdat_read_only;


