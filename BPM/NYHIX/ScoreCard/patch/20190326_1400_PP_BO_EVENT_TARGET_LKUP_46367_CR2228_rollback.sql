-- NYHIX-46367 CR 2228
set define off;

DELETE FROM dp_scorecard.pp_bo_event_target_lkup
WHERE  event_id in (1593,1594,1595,1596,1597,1598,1599,1600,1601,1602,1603,1604,1605,1606,1607,1608)

COMMIT;