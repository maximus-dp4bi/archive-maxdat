delete from MAXDAT.NYHX_ETL_IDR_INCIDENTS
where 1 = 1
;

delete from MAXDAT.NYHX_ETL_IDR_INCIDENTS_OLTP
where 1 = 1
;

delete from MAXDAT.NYHX_ETL_IDR_INCIDENTS_WIP
where 1 = 1
;

delete from MAXDAT.NYHX_ETL_IDR_INCIDENT_RSN
where 1 = 1
;

delete from maxdat.F_IDR_BY_DATE
where 1 = 1
;

delete from MAXDAT.d_idr_current
where 1 = 1
;

delete from MAXDAT.D_IDR_ACTION_COMMENTS
where 1 = 1
;

delete from MAXDAT.D_IDR_ENROLLMENT_STATUS
where 1 = 1
;

delete from MAXDAT.D_IDR_INCIDENT_ABOUT
where 1 = 1
;

delete from MAXDAT.D_IDR_INCIDENT_DESCRIPTION
where 1 = 1
;

delete from MAXDAT.D_IDR_INCIDENT_STATUS
where 1 = 1
;

delete from MAXDAT.D_IDR_INSTANCE_STATUS
where 1 = 1
;

delete from MAXDAT.D_IDR_LAST_UPDATED_BY
where 1 = 1
;

delete from MAXDAT.D_IDR_LAST_UPDATE_BY_NAME
where 1 = 1
;

delete from MAXDAT.D_IDR_RESOLUTION_DESCRIPTION
where 1 = 1
;

delete from MAXDAT.D_IDR_RESOLUTION_TYPE
where 1 = 1
;

DELETE FROM BPM_UPDATE_EVENT_QUEUE
where BSL_ID = 21 
;

commit;
