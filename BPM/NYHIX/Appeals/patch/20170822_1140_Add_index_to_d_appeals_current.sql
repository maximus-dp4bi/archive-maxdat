CREATE UNIQUE INDEX DAPPEALSII_UIX2
    ON MAXDAT.D_APPEALS_CURRENT (INCIDENT_ID, appeal_hearing_date)
    TABLESPACE MAXDAT_INDX;

