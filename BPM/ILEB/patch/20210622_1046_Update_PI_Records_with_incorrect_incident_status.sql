-- PAXTECH-2507
-- This script will affect 7 records in the CORP_ETL_PROCESS_INCIDENTS table
-- It will cause the trigger to place the updated records into the BPM queue 
-- Resulting in the records in the D_PI_CURRENT being updated with the correct INCIDENT_STATUS

UPDATE MAXDAT.CORP_ETL_PROCESS_INCIDENTS 
	SET INCIDENT_ID = INCIDENT_ID 
WHERE INCIDENT_ID in (SELECT a.INCIDENT_ID FROM MAXDAT.CORP_ETL_PROCESS_INCIDENTS a
											JOIN maxdat.d_pi_current b ON a.INCIDENT_ID = b."Incident ID"
											WHERE a.INCIDENT_STATUS <> b."Cur Incident Status");
											
commit;
