/*
Created by Raj A on 09/21/2016.
Description: MSSS-224 Populating the config tables per the document (MIMSS and MIMSSOCM)
*/
INSERT INTO CC_C_IVR_CALL_RESULT
(completion_code, count_created, count_offered_to_acd, count_contained, 
create_date, record_eff_date, record_end_date)
VALUES
('H','Y','N','Y',
SYSDATE, to_date('1/1/1990','mm/dd/yyyy'), to_date('12/31/2999','mm/dd/yyyy'));
INSERT INTO CC_C_IVR_CALL_RESULT
(completion_code, count_created, count_offered_to_acd, count_contained, 
create_date, record_eff_date, record_end_date)
VALUES
('N','Y','N','Y',
SYSDATE, to_date('1/1/1990','mm/dd/yyyy'), to_date('12/31/2999','mm/dd/yyyy'));
INSERT INTO CC_C_IVR_CALL_RESULT
(completion_code, count_created, count_offered_to_acd, count_contained, 
create_date, record_eff_date, record_end_date)
VALUES
('T','Y','Y','N',
SYSDATE, to_date('1/1/1990','mm/dd/yyyy'), to_date('12/31/2999','mm/dd/yyyy'));
INSERT INTO CC_C_IVR_CALL_RESULT
(completion_code, count_created, count_offered_to_acd, count_contained, 
create_date, record_eff_date, record_end_date)
VALUES
('C','Y','N','Y',
SYSDATE, to_date('1/1/1990','mm/dd/yyyy'), to_date('12/31/2999','mm/dd/yyyy'));

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 9861, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name = 'MI MSS English') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 9901, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name = 'MI MSS English') );

INSERT INTO cc_c_unit_of_work
(UNIT_OF_WORK_ID, UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, RECORD_EFF_DT, RECORD_END_DT)
VALUES (SEQ_CC_C_UNIT_OF_WORK.NEXTVAL, 'TEST MI MSS', 'INBOUND_CALL', to_date('1/1/1900','mm/dd/yyyy'), to_date('12/31/2199','mm/dd/yyyy'));
INSERT INTO cc_d_unit_of_work
(UOW_ID, UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, PRODUCTION_PLAN_ID, HOURLY_FLAG, HANDLE_TIME_UNIT)
VALUES (SEQ_CC_D_UNIT_OF_WORK.NEXTVAL, 'TEST MI MSS', 'INBOUND_CALL', 0, 'N','Seconds');

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4060, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name = 'TEST MI MSS') );
COMMIT;