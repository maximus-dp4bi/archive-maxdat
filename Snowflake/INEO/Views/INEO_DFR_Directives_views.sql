use schema ineo;
CREATE OR REPLACE VIEW INEO_D_DFR_DIRECTIVES_BY_REGION_HISTORY_SV
AS
SELECT * FROM ineo.ineo_dfr_directives_by_region_history;

CREATE OR REPLACE VIEW INEO_D_DFR_DIRECTIVES_BY_REGION_SV
AS
SELECT * FROM ineo.ineo_dfr_directives_by_region;