CREATE TABLE WR_C_DISPOSITION_CONFIG
(disposition_code VARCHAR2(64)
 ,disposition_description VARCHAR2(200)
 ,success_disposition_indicator VARCHAR2(1)
 ,create_date DATE
 ,update_date DATE
 ,created_by VARCHAR2(80)
 ,updated_by VARCHAR2(80));
 
CREATE INDEX wrc_disposition_idx1 ON wr_c_disposition_config(disposition_code);

 GRANT SELECT ON WR_C_DISPOSITION_CONFIG TO MAXDAT_REPORTS;
 
 CREATE OR REPLACE VIEW WR_C_DISPOSITION_CONFIG_SV
 AS
 SELECT disposition_code
        ,disposition_description
        ,success_disposition_indicator
FROM wr_c_disposition_config;

 GRANT SELECT ON WR_C_DISPOSITION_CONFIG_SV TO MAXDAT_REPORTS;
 GRANT SELECT ON WR_C_DISPOSITION_CONFIG_SV TO MAXDATSUPPORT_READ_ONLY;