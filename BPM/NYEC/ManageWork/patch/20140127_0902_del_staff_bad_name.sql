
-- Update the lone staff bad name on NYEC UAT
UPDATE d_mw_owner SET "Owner Name" = REPLACE("Owner Name",', ', ',')
 WHERE dmwo_id = 2850 AND INSTR("Owner Name",', ') > 0;
UPDATE d_mw_last_update_by_name
   SET "Last Update By Name" = REPLACE("Last Update By Name",', ', ',')
 WHERE dmwlubn_id = 2871 AND INSTR("Last Update By Name",', ') > 0;
COMMIT;

-- Both UAT and PRD
DELETE FROM d_mw_owner WHERE INSTR("Owner Name",', ') > 0;
DELETE FROM d_mw_last_update_by_name WHERE INSTR("Last Update By Name",', ') > 0;
DELETE FROM d_mw_escalated WHERE INSTR("Escalated To Name",', ') > 0;
DELETE FROM d_mw_forwarded WHERE INSTR("Forwarded By Name",', ') > 0;
COMMIT;

