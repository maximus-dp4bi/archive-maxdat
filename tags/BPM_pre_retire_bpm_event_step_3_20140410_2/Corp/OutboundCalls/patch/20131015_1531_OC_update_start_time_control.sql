-- 10/15/13 Update Outbound Calls start time control variable. Originally for ILEB UAT testing.

UPDATE corp_etl_control SET value = '1700' WHERE Name = 'OUTBOUNDCALL_DAILY_START';
COMMIT;
