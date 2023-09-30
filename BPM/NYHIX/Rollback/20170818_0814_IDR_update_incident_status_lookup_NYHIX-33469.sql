delete from MAXDAT.INCIDENT_STATUS_LOOKUP where INCIDENT_STATUS = 'Incident Withdrawn';
delete from MAXDAT.INCIDENT_STATUS_LOOKUP where INCIDENT_STATUS = 'Incident Closed';
delete from MAXDAT.INCIDENT_STATUS_LOOKUP where INCIDENT_STATUS = 'Request Withdrawn - IDR Completed';
delete from MAXDAT.INCIDENT_STATUS_LOOKUP where INCIDENT_STATUS = 'Request Withdrawn - IDR Not Completed';
delete from MAXDAT.INCIDENT_STATUS_LOOKUP where INCIDENT_STATUS = 'Dismissal - Failed to Amend Invalid Appeal Request';
delete from MAXDAT.INCIDENT_STATUS_LOOKUP where INCIDENT_STATUS = 'Incident Closed - Decision Overturned';
delete from MAXDAT.INCIDENT_STATUS_LOOKUP where INCIDENT_STATUS = 'Incident Closed - Decision Upheld';

Commit;
