--4913 rows update
UPDATE d_am_status
SET cancel_dt = sysdate
    ,cancel_by = 'TXEB-6966'
    ,cancel_reason = 'Old alerts - no tracking required'
    ,cancel_method = 'Exception'
    ,complete_dt = sysdate
    ,instance_status = 'Complete'
WHERE TRUNC(ams_review_status_dt) < TO_DATE('04/01/2016','mm/dd/yyyy');    

COMMIT;