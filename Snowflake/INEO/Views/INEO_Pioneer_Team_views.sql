use schema ineo;
CREATE OR REPLACE VIEW INEO_D_PIONEER_TEAM_STAFF_ROSTER_HISTORY_SV
AS
SELECT * FROM ineo.ineo_pioneer_team_staff_roster_history;

CREATE OR REPLACE VIEW INEO_D_PIONEER_TEAM_STAFF_ROSTER_SV
AS
SELECT * FROM ineo.ineo_pioneer_team_staff_roster;

CREATE OR REPLACE VIEW INEO_D_ARCHIVE_PIONEER_TEAM_COMS_LOG_HISTORY_SV
AS
SELECT * FROM ineo.ineo_archive_pioneer_team_coms_log_history;

CREATE OR REPLACE VIEW INEO_D_ACTIVE_PIONEER_TEAM_COMS_LOG_HISTORY_SV
AS
SELECT * FROM ineo.ineo_active_pioneer_team_coms_log_history;
