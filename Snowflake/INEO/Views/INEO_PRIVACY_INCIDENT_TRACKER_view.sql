DROP VIEW INEO_INEO_PRIVACY_INCIDENT_TRACKER_HISTORY_SV;
CREATE OR REPLACE VIEW INEO_D_PRIVACY_INCIDENT_TRACKER_HISTORY_SV
AS
SELECT * FROM ineo.INEO_PRIVACY_INCIDENT_TRACKER_HISTORY;

DROP VIEW INEO_INEO_PRIVACY_INCIDENT_TRACKER_SV;
CREATE OR REPLACE VIEW INEO_D_PRIVACY_INCIDENT_TRACKER_SV
AS
SELECT * FROM ineo.INEO_PRIVACY_INCIDENT_TRACKER;



