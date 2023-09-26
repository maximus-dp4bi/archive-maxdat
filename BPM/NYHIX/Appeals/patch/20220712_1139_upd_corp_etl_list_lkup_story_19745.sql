-- Story 19745 actioned by Guy Thibodeau
UPDATE MAXDAT.CORP_ETL_LIST_LKUP
SET OUT_VAR = '''Refer to ES-C'',''Refer to ES-C Supervisor'',''Refer to NY Appeals Unit'',''Refer to NY Appeals Unit Supervisor'',''Remand'',''Request to Vacate Dismissal'',''Reschedule Hearing- Appellant Request'',''Reschedule Hearing- DOH Request'',''Decision Overturned'',''Dismissal - Failed to Attend Hearing'',''Dismissal - Death'''
WHERE name = 'PA_EXCLUDE_STATUS'
;
UPDATE MAXDAT.CORP_ETL_LIST_LKUP
SET OUT_VAR = '''Appeal Validity Check'',''Dismissal - Failed to Amend Invalid Appeal Request'',''Dismissal - Death'''
WHERE name = 'PA_UPD6_10'
;
UPDATE MAXDAT.CORP_ETL_LIST_LKUP
SET OUT_VAR = '''Dismissal - Failed to Amend Invalid Appeal Request'',''Dismissal - Death'''
WHERE name = 'PA_UPD6_20'
;
UPDATE MAXDAT.CORP_ETL_LIST_LKUP
SET OUT_VAR = '''Appeal Closed - Duplicate/Error'',''Appeal Closed - Other'''
WHERE name = 'PA_UPD18_20'
;
UPDATE MAXDAT.CORP_ETL_LIST_LKUP
SET OUT_VAR = '''Dismissed'',''Dismissal - Death'''
WHERE name = 'PA_UPD20_10'
;
UPDATE MAXDAT.CORP_ETL_LIST_LKUP
SET OUT_VAR = '''Appeal Closed - ARU Action Completed'',''Appeal Closed - Other'''
WHERE name = 'PA_UPD20_20'
;
UPDATE MAXDAT.CORP_ETL_LIST_LKUP
SET OUT_VAR = '''Appeal Closed - DOH Action Completed'',''Appeal Closed - Other'''
WHERE name = 'PA_UPD20_30'
;
UPDATE MAXDAT.CORP_ETL_LIST_LKUP
SET OUT_VAR = '''Appeal Closed - Failed to Attend Hearing'',''Appeal Closed - Other'''
WHERE name = 'PA_UPD20_40'
;
UPDATE MAXDAT.CORP_ETL_LIST_LKUP
SET OUT_VAR = '''Appeal Closed - Non-Sworn Cancellation'',''Appeal Closed - Other'''
WHERE name = 'PA_UPD20_50'
;
UPDATE MAXDAT.CORP_ETL_LIST_LKUP
SET OUT_VAR = '''Appeal Closed - Written Withdrawal'',''Appeal Closed - Other'''
WHERE name = 'PA_UPD20_60'
;
UPDATE MAXDAT.CORP_ETL_LIST_LKUP
SET OUT_VAR = '''Appeal Closed'',''Appeal Closed - Failure to Participate'',''Appeal Closed - Phone Not Working/Bad Number'',''Appeal Closed - Invalid Appeal Request'',''Appeal Closed - Other'''
WHERE name = 'PA_UPD20_70'
;
COMMIT;
