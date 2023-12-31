INSERT INTO CC_D_PROJECT(project_id, project_name, segment_id) VALUES (0, 'Unknown',0);
INSERT INTO CC_D_PROJECT(project_id, project_name,segment_id) VALUES (1, 'HIHIX',1);

INSERT INTO CC_D_PROJECT_TARGETS(project_id, average_handle_time_target,cost_per_call_target,labor_cost_per_call_target,occupancy_target,utilization_target,record_eff_dt,record_end_dt,version) 
VALUES (0, 0, 0, 0, 0, 0, to_date('01-JAN-1900','DD-MON-YYYY'), to_date('31-DEC-2999','DD-MON-YYYY'), 0);
INSERT INTO CC_D_PROJECT_TARGETS(project_id, average_handle_time_target,cost_per_call_target,labor_cost_per_call_target,occupancy_target,utilization_target,record_eff_dt,record_end_dt,version) 
VALUES (1, 90, 100, 80, 80, 90, to_date('01-JAN-1900','DD-MON-YYYY'), to_date('31-DEC-2999','DD-MON-YYYY'), 1);

INSERT INTO CC_D_PROGRAM(program_id, program_name) VALUES (0, 'Unknown');
INSERT INTO CC_D_PROGRAM(program_id, program_name) VALUES (1, 'HIX');


INSERT INTO CC_D_COUNTRY(COUNTRY_ID, COUNTRY_NAME) VALUES(1,'USA');
INSERT INTO CC_D_COUNTRY(COUNTRY_ID, COUNTRY_NAME) VALUES(0,'Unknown');

INSERT INTO CC_D_REGION(REGION_ID, REGION_NAME) VALUES(1, 'West');
INSERT INTO CC_D_REGION(REGION_ID, REGION_NAME) VALUES(0, 'Unknown');

INSERT INTO CC_D_STATE(STATE_ID, STATE_NAME) VALUES(1, 'Hawaii');
INSERT INTO CC_D_STATE(STATE_ID, STATE_NAME) VALUES(0, 'Unknown');

INSERT INTO CC_D_PROVINCE(PROVINCE_ID, PROVINCE_NAME) VALUES(0,'Unknown');

INSERT INTO CC_D_DISTRICT(DISTRICT_ID, DISTRICT_NAME) VALUES(0,'Unknown');

INSERT INTO CC_D_CONTACT_QUEUE (D_CONTACT_QUEUE_ID,QUEUE_NUMBER,QUEUE_NAME,SOURCE_QUEUE,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,QUEUE_GROUP,INTERVAL_MINUTES,SPEED_ANSWER_PERIOD_1_BOUND,SPEED_ANSWER_PERIOD_2_BOUND,SPEED_ANSWER_PERIOD_3_BOUND,SPEED_ANSWER_PERIOD_4_BOUND,SPEED_ANSWER_PERIOD_5_BOUND,SPEED_ANSWER_PERIOD_6_BOUND,SPEED_ANSWER_PERIOD_7_BOUND,SPEED_ANSWER_PERIOD_8_BOUND,SPEED_ANSWER_PERIOD_9_BOUND,SPEED_ANSWER_PERIOD_10_BOUND,CALLS_ABNDONED_PERIOD_1_BOUND,CALLS_ABNDONED_PERIOD_2_BOUND,CALLS_ABNDONED_PERIOD_3_BOUND,CALLS_ABNDONED_PERIOD_4_BOUND,CALLS_ABNDONED_PERIOD_5_BOUND,CALLS_ABNDONED_PERIOD_6_BOUND,CALLS_ABNDONED_PERIOD_7_BOUND,CALLS_ABNDONED_PERIOD_8_BOUND,CALLS_ABNDONED_PERIOD_9_BOUND,CALLS_ABNDONED_PERIOD_10_BOUND,VERSION,RECORD_EFF_DT,RECORD_END_DT) values (0,0,'Unknown',0,'Unknown',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,to_date('01-JAN-1900 00:00:00','DD-MON-RRRR HH24:MI:SS'),to_date('31-DEC-2999 00:00:00','DD-MON-RRRR HH24:MI:SS'));

INSERT INTO CC_D_GEOGRAPHY_MASTER(geography_master_id,geography_name,country_id, state_id, province_id, district_id, region_id )
VALUES(0, 'Unknown', 0, 0, 0, 0, 0);
INSERT INTO CC_D_GEOGRAPHY_MASTER(geography_master_id,geography_name,country_id, state_id, province_id, district_id, region_id )
VALUES(1, 'Hawaii', 1, 1, 0, 0, 1);

COMMIT;