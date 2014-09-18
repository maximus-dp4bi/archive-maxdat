drop sequence SEQ_CC_C_PROJECT_CONFIG;

CREATE SEQUENCE SEQ_CC_C_PROJECT_CONFIG
 START WITH     4
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

insert into CC_C_PROJECT_CONFIG(project_name,program_name,region_name,state_name,province_name,district_name,country_name,record_eff_dt,record_end_dt)values
('TX Eligibility Support','ES','Central','Texas','n/a','n/a','USA',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.9','102','102_ADD_ES_PROJECT_TO_CC_C_PROJECT_CONFIG');

commit;