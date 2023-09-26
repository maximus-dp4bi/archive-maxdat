CREATE OR REPLACE VIEW INEO_D_AGENT_PERFORMANCE_HISTORY_SV
AS
SELECT ap.*, ll.load_date sf_create_ts
FROM ineo.INEO_AGENT_PERFORMANCE_HISTORY ap
  JOIN file_load_log ll ON UPPER(ap.filename) = UPPER(ll.filename);

