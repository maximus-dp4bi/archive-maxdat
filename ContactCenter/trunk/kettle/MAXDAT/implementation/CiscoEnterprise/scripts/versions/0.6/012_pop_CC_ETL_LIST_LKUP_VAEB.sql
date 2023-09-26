/*
Created by Raj A on 06/07/2016.
Description: MAXDAT-3635, 3612
1. Increasing the table columns size to 255 Bytes after discussing with Steven Davis and Sara. 
2. Making the table columns, BEGIN_NODE and END_NODE NULLable and resized to 255 Bytes.
*/
INSERT INTO CC_A_LIST_LKUP
(NAME, list_type, VALUE, out_var, start_date, end_date, comments)
VALUES (
'IVR_DATA_FILE_NAMES', 'IVR_APP_NAME','MAXVAEB', 'VA EB',
trunc(SYSDATE),  to_date('7/7/7777','mm/dd/yyyy'),
'Global control to fetch the Project name using the Application Name from data file.'
);
COMMIT;

ALTER TABLE cc_s_ivr_response MODIFY exit_point_description VARCHAR2(255);
ALTER TABLE cc_s_ivr_response MODIFY MAIN_MENU_SELECTION VARCHAR2(255);

ALTER TABLE CC_D_IVR_SELF_SERVICE_PATH MODIFY begin_node VARCHAR2(255) NULL;
ALTER TABLE CC_D_IVR_SELF_SERVICE_PATH MODIFY end_node VARCHAR2(255) NULL;

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4091, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='CCC IVR') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4092, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='Medallion IVR') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4093, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='VAEB Test') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4094, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='VAEB IVR') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4095, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='VAEB IVR') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4096, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='VAEB IVR') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4097, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='VAEB IVR') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4098, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='VAEB IVR') );
COMMIT;