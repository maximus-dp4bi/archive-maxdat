CREATE TABLE cfg_plan_types(plan_id VARCHAR,plan_name VARCHAR,create_ts TIMESTAMP_NTZ(9) default current_timestamp(),update_ts TIMESTAMP_NTZ(9) default current_timestamp());
 
 INSERT INTO cfg_plan_types(plan_id,plan_name) VALUES('145','Aetna');
 INSERT INTO cfg_plan_types(plan_id,plan_name) VALUES('192','AmeriHealth');
 INSERT INTO cfg_plan_types(plan_id,plan_name) VALUES('293','Anthem');
 INSERT INTO cfg_plan_types(plan_id,plan_name) VALUES('420','Buckeye');
 INSERT INTO cfg_plan_types(plan_id,plan_name) VALUES('315','CareSource');
 INSERT INTO cfg_plan_types(plan_id,plan_name) VALUES('191','Humana');
 INSERT INTO cfg_plan_types(plan_id,plan_name) VALUES('731','Molina');
 INSERT INTO cfg_plan_types(plan_id,plan_name) VALUES('761','United HealthCare');
 
 ALTER TABLE cfg_plan_types ADD PRIMARY KEY (plan_id);
 
CREATE OR REPLACE VIEW public.d_cfg_plan_types_sv
 AS
 SELECT plan_id
 ,plan_name
 FROM ohpnm_dp4bi_dev.cfg_plan_types;
 
 CREATE TABLE cfg_program_types(program_code NUMBER, program_type VARCHAR,create_ts TIMESTAMP_NTZ(9) default current_timestamp(),update_ts TIMESTAMP_NTZ(9) default current_timestamp());
 
 INSERT INTO cfg_program_types(program_code,program_type) VALUES(1,'Medicaid');
 INSERT INTO cfg_program_types(program_code,program_type) VALUES(2,'Deprecated');
 INSERT INTO cfg_program_types(program_code,program_type) VALUES(3,'Deprecated');
 INSERT INTO cfg_program_types(program_code,program_type) VALUES(4,'ICDS/MyCare');
 INSERT INTO cfg_program_types(program_code,program_type) VALUES(5,'Both');
 INSERT INTO cfg_program_types(program_code,program_type) VALUES(7,'OhioRISE');
 
 ALTER TABLE cfg_program_types ADD PRIMARY KEY (program_code);
 
 CREATE OR REPLACE VIEW public.d_cfg_program_types_sv
 AS
 SELECT program_code
 ,program_type
 FROM ohpnm_dp4bi_dev.cfg_program_types;
 
 CREATE TABLE cfg_region_provider_panel(region VARCHAR,provider_panel_type VARCHAR,provider_panel NUMBER,create_ts TIMESTAMP_NTZ(9) default current_timestamp(),update_ts TIMESTAMP_NTZ(9) default current_timestamp());
 
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('Central','CBHC_MENTAL_HEALTH_CENTER',18);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('Central','CBHC_SUD_TREATMENT_PROVIDER',8);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('Central','OTHER_BEHAVIORAL_HEALTH',43);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('East Central','CBHC_MENTAL_HEALTH_CENTER',19);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('East Central','CBHC_SUD_TREATMENT_PROVIDER',8);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('East Central','OTHER_BEHAVIORAL_HEALTH',54);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('Northeast','CBHC_MENTAL_HEALTH_CENTER',50);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('Northeast','CBHC_SUD_TREATMENT_PROVIDER',8);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('Northeast','OTHER_BEHAVIORAL_HEALTH',99);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('Northeast Central','CBHC_MENTAL_HEALTH_CENTER',10);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('Northeast Central','CBHC_SUD_TREATMENT_PROVIDER',6);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('Northeast Central','OTHER_BEHAVIORAL_HEALTH',33);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('Northwest','CBHC_MENTAL_HEALTH_CENTER',10);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('Northwest','CBHC_SUD_TREATMENT_PROVIDER',6);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('Northwest','OTHER_BEHAVIORAL_HEALTH',43);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('Southwest','CBHC_MENTAL_HEALTH_CENTER',28);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('Southwest','CBHC_SUD_TREATMENT_PROVIDER',8);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('Southwest','OTHER_BEHAVIORAL_HEALTH',53);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('West Central','CBHC_MENTAL_HEALTH_CENTER',19);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('West Central','CBHC_SUD_TREATMENT_PROVIDER',6);
 INSERT INTO cfg_region_provider_panel(region,provider_panel_type,provider_panel) VALUES('West Central','OTHER_BEHAVIORAL_HEALTH',39); 
 
 ALTER TABLE cfg_region_provider_panel ADD PRIMARY KEY (region,provider_panel_type);
 
 CREATE OR REPLACE VIEW public.d_cfg_region_provider_panel_sv
 AS
 SELECT region
 ,provider_panel_type
 ,provider_panel
 FROM ohpnm_dp4bi_dev.cfg_region_provider_panel;