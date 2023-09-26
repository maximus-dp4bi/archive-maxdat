delete from MAXDAT.NYHBE_ETL_PROCESS_APPEALS
where incident_id in (27275408,26110185);

delete from MAXDAT.NYHBE_ETL_PROCESS_APPEALS_RSN
where incident_id in (27275408,26110185);

delete from MAXDAT.NYHBE_PROCESS_APPEALS_OLTP
where incident_id in (27275408,26110185);

delete from MAXDAT.NYHBE_PROCESS_APPEALS_WIP_BPM
where incident_id in (27275408,26110185);

delete from MAXDAT.F_APPEALS_BY_DATE
where APL_BI_ID in (select APL_BI_ID from D_APPEALS_CURRENT where incident_id in (27275408,26110185));

delete from MAXDAT.D_APPEALS_CURRENT
where incident_id in (27275408,26110185);

DELETE FROM BPM_UPDATE_EVENT_QUEUE
where BSL_ID = 23 
and identifier in (27275408,26110185);

Commit;
