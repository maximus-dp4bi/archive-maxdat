/*
Created by Raj A on 12/07/2016.
Description: Per PAIEB-541 and MAXDAT-5052 Populating the config tables per the document (MAXPAIEB_RESPONSE_YYYYMMDD)
*/
INSERT INTO cc_c_unit_of_work
(UNIT_OF_WORK_ID, UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, RECORD_EFF_DT, RECORD_END_DT)
VALUES (SEQ_CC_C_UNIT_OF_WORK.NEXTVAL, 'PA IEB', 'INBOUND_CALL', to_date('1/1/1900','mm/dd/yyyy'), to_date('12/31/2199','mm/dd/yyyy'));
INSERT INTO cc_d_unit_of_work
VALUES (SEQ_CC_D_UNIT_OF_WORK.NEXTVAL, 'PA IEB','INBOUND_CALL',0,'N','Seconds');

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4080, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name = 'PA IEB') );
COMMIT;