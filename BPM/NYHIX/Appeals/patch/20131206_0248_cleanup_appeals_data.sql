UPDATE nyhbe_etl_process_appeals
SET ased_cancel_hearing = null
   ,cancel_dt = null
  ,cancel_reason = null
  ,cancel_method = null
  ,cancel_by = null
  ,incident_status = 'Cancel Hearing'
  ,max_inci_stat_hist_id = 25171
WHERE incident_id IN(26035194);

UPDATE nyhbe_etl_process_appeals
SET ased_cancel_hearing = null
   ,cancel_dt = null
  ,cancel_reason = null
  ,cancel_method = null
  ,cancel_by = null
  ,incident_status = 'Cancel Hearing'
  ,max_inci_stat_hist_id = 27125
WHERE incident_id IN(26036122);

COMMIT;