INSERT INTO D_METRIC_DEFINITION (D_DATA_TYPE_ID, NAME, LABEL, TYPE, CATEGORY, VALUE_TYPE, STATUS, HAS_TARGET, HAS_FORECAST, IS_CALCULATED, FUNCTIONAL_AREA, RECORD_EFF_DT, RECORD_END_DT, CREATE_DATE, CREATED_BY, LAST_MODIFIED_DATE, UPDATED_BY)
	VALUES (2, 'Calls Offered Per FTE', 'Calls Offered Per FTE', 'Corporate Standard', 'Agent Efficiency', 'Decimal', 'OK', 'Y', 'Y', 'Y', 'Contact Center', '01-JAN-00', '01-SEP-13', '31-DEC-99', 'MOTS', '06-SEP-13', 'MOTS');
	
INSERT INTO D_METRIC_PROJECT (D_PROJECT_ID, D_PROGRAM_ID, D_GEOGRAPHY_MASTER_ID, D_METRIC_DEFINITION_ID, SUPPLY_FORECAST, SUPPLY_TARGET, IS_SLA, SLA_TYPE, SLA_THRESHOLD, RECORD_EFF_DT, RECORD_END_DT, CREATE_DATE, CREATED_BY, LAST_MODIFIED_DATE, UPDATED_BY)
	VALUES (1,4,2,10, 'Y','Y','Y', 'testVal', '1', '01-JAN-00', '31-DEC-99', '01-SEP-13', 'MOTS', '01-SEP-13', 'MOTS');	
INSERT INTO D_METRIC_PROJECT (D_PROJECT_ID, D_PROGRAM_ID, D_GEOGRAPHY_MASTER_ID, D_METRIC_DEFINITION_ID, SUPPLY_FORECAST, SUPPLY_TARGET, IS_SLA, SLA_TYPE, SLA_THRESHOLD, RECORD_EFF_DT, RECORD_END_DT, CREATE_DATE, CREATED_BY, LAST_MODIFIED_DATE, UPDATED_BY)
	VALUES (2,4,3,10, 'Y','Y','Y', 'testVal', '1', '01-JAN-00', '31-DEC-99', '01-SEP-13', 'MOTS', '01-SEP-13', 'MOTS');
INSERT INTO D_METRIC_PROJECT (D_PROJECT_ID, D_PROGRAM_ID, D_GEOGRAPHY_MASTER_ID, D_METRIC_DEFINITION_ID, SUPPLY_FORECAST, SUPPLY_TARGET, IS_SLA, SLA_TYPE, SLA_THRESHOLD, RECORD_EFF_DT, RECORD_END_DT, CREATE_DATE, CREATED_BY, LAST_MODIFIED_DATE, UPDATED_BY)
	VALUES (3,4,4,10, 'Y','Y','Y', 'testVal', '1', '01-JAN-00', '31-DEC-99', '01-SEP-13', 'MOTS', '01-SEP-13', 'MOTS');
INSERT INTO D_METRIC_PROJECT (D_PROJECT_ID, D_PROGRAM_ID, D_GEOGRAPHY_MASTER_ID, D_METRIC_DEFINITION_ID, SUPPLY_FORECAST, SUPPLY_TARGET, IS_SLA, SLA_TYPE, SLA_THRESHOLD, RECORD_EFF_DT, RECORD_END_DT, CREATE_DATE, CREATED_BY, LAST_MODIFIED_DATE, UPDATED_BY)
	VALUES (4,4,5,10, 'Y','Y','Y', 'testVal', '1', '01-JAN-00', '31-DEC-99', '01-SEP-13', 'MOTS', '01-SEP-13', 'MOTS');
INSERT INTO D_METRIC_PROJECT (D_PROJECT_ID, D_PROGRAM_ID, D_GEOGRAPHY_MASTER_ID, D_METRIC_DEFINITION_ID, SUPPLY_FORECAST, SUPPLY_TARGET, IS_SLA, SLA_TYPE, SLA_THRESHOLD, RECORD_EFF_DT, RECORD_END_DT, CREATE_DATE, CREATED_BY, LAST_MODIFIED_DATE, UPDATED_BY)
	VALUES (5,4,6,10, 'Y','Y','Y', 'testVal', '1', '01-JAN-00', '31-DEC-99', '01-SEP-13', 'MOTS', '01-SEP-13', 'MOTS');	
INSERT INTO D_METRIC_PROJECT (D_PROJECT_ID, D_PROGRAM_ID, D_GEOGRAPHY_MASTER_ID, D_METRIC_DEFINITION_ID, SUPPLY_FORECAST, SUPPLY_TARGET, IS_SLA, SLA_TYPE, SLA_THRESHOLD, RECORD_EFF_DT, RECORD_END_DT, CREATE_DATE, CREATED_BY, LAST_MODIFIED_DATE, UPDATED_BY)
	VALUES (6,4,7,10, 'Y','Y','Y', 'testVal', '1', '01-JAN-00', '31-DEC-99', '01-SEP-13', 'MOTS', '01-SEP-13', 'MOTS');
INSERT INTO D_METRIC_PROJECT (D_PROJECT_ID, D_PROGRAM_ID, D_GEOGRAPHY_MASTER_ID, D_METRIC_DEFINITION_ID, SUPPLY_FORECAST, SUPPLY_TARGET, IS_SLA, SLA_TYPE, SLA_THRESHOLD, RECORD_EFF_DT, RECORD_END_DT, CREATE_DATE, CREATED_BY, LAST_MODIFIED_DATE, UPDATED_BY)
	VALUES (7,4,8,10, 'Y','Y','Y', 'testVal', '1', '01-JAN-00', '31-DEC-99', '01-SEP-13', 'MOTS', '01-SEP-13', 'MOTS');
INSERT INTO D_METRIC_PROJECT (D_PROJECT_ID, D_PROGRAM_ID, D_GEOGRAPHY_MASTER_ID, D_METRIC_DEFINITION_ID, SUPPLY_FORECAST, SUPPLY_TARGET, IS_SLA, SLA_TYPE, SLA_THRESHOLD, RECORD_EFF_DT, RECORD_END_DT, CREATE_DATE, CREATED_BY, LAST_MODIFIED_DATE, UPDATED_BY)
	VALUES (8,4,9,10, 'Y','Y','Y', 'testVal', '1', '01-JAN-00', '31-DEC-99', '01-SEP-13', 'MOTS', '01-SEP-13', 'MOTS');
	
--HI HIX
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (38.41,23.68,23.68,82,2);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (35.41,19.73,19.73,82,3);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (161.35,33.16,33.16,82,4);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (78.41,105.88,105.88,82,5);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (121.18,73.64,73.64,82,7);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (179.61,184.72,184.72,82,8);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (181.5,184.72,184.72,82,9);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (224.87,184.72,184.72,82,10);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (186.10,221.67,221.67,82,11);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (194.20,221.67,221.67,82,12);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (149.10,151.67,151.67,82,13);
	
--NY HIX
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (58.86,13.7,13.7,83,2);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (90.24,56.1,56.1,83,3);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (71.45,13.88,13.88,83,4);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (92.97,81.51,81.51,83,5);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (59.52,80.997,80.997,83,7);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (80.97,85.89,85.89,83,8);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (81.07,80.997,80.997,83,9);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (84.66,88.71,88.71,83,10);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (91.02,62.07,62.07,83,11);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (88.76,88.27,88.27,83,12);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (68.71,74.57,74.57,83,13);
	
--VT HIX
--NO FTE COUNT VALUES CURRENTLY SUPPLIED
	
--CT HIX
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (4.21,85,6);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (5.57,85,1);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (8,53.68,53.68,85,2);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (15.23,53.68,53.68,85,3);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (107.52,25.3,25.3,85,4);
INSERT INTO F_METRIC (FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (25.3,25.3,85,5);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (76.9,104.95,104.95,85,7);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (105.77,117.07,117.07,85,8);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (120.49,125.7,125.7,85,9);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (132.88,122.3,122.3,85,10);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (150.82,105.68,105.68,85,11);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (137.15,144.46,144.46,85,12);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (136.76,134.04,134.04,85,13);
	
--DC HIX
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (5.52,108.22,108.22,86,2);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (7.52,108.22,108.22,86,3);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (25.13,188.46,188.46,86,4);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (12.5,41.69,41.69,86,5);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (13.67,41.69,41.69,86,7);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (23.53,41.69,41.69,86,8);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (22.35,86,9);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (24.65,91.55,91.55,86,10);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (43.62,41.4,41.4,86,11);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (60.0,41.4,41.4,86,12);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (52.51,50.4,50.4,86,13);
	
--CCO - Boise
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (15.82,87,8);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (14.04,87,9);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (30.82,87,10);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (41.31,87,11);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (33.62,87,12);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (22.17,87,13);
	
--CCO - BROWNSVILLE
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (10.29,88,6);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (7.53,88,1);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (1.81,88,3);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (15.57,88,4);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (16.3,88,5);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (8.35,88,7);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (5.48,88,8);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (4.81,88,9);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (6.47,88,10);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (16.64,88,11);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (11.8,88,12);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (17.92,88,13);
	
--MD HIX
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (14.18,89,6);
INSERT INTO F_METRIC (ACTUAL_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (27.82,89,1);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (38.05,106.82,106.82,89,2);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (21.62,106.82,106.82,89,3);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (139.01,79.0,79.0,89,4);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (118.49,79.0,79.0,89,5);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (93.31,94.08,94.08,89,7);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (100.16,94.08,94.08,89,8);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (95.15,96.03,96.03,89,9);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (97.86,112.62,112.62,89,10);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (90.98,112.62,112.62,89,11);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (78.11,114.99,114.99,89,12);
INSERT INTO F_METRIC (ACTUAL_VALUE, FORECAST_VALUE, TARGET_VALUE, D_METRIC_PROJECT_ID, D_REPORTING_PERIOD_ID) 
	VALUES (66.87,121.38,121.38,89,13);
		