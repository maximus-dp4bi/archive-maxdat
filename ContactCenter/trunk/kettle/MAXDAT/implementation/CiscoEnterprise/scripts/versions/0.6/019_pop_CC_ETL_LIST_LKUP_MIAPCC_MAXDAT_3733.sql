/*
Created by Raj A on 06/23/2016.
Description: MAXDAT-3733
Configuring for MI APCC project. Start using Ref_type to store program_name. out_var has project_name.
*/
INSERT INTO CC_A_LIST_LKUP
(NAME, list_type, VALUE, out_var, ref_type, start_date, end_date, comments)
VALUES (
'IVR_DATA_FILE_NAMES', 'IVR_APP_NAME','MAXMIAPS', 'MI APCC', 'MI Provider Support',
trunc(SYSDATE),  to_date('7/7/7777','mm/dd/yyyy'),
'Global control to fetch the Project name using the Application Name from data file.'
)
;

UPDATE CC_A_LIST_LKUP
   SET ref_type = 'VA EB'
 WHERE NAME = 'IVR_DATA_FILE_NAMES'
 AND list_type = 'IVR_APP_NAME'
 AND VALUE = 'MAXVAEB'
 ;
UPDATE CC_A_LIST_LKUP
   SET ref_type = 'MI PACC'
 WHERE NAME = 'IVR_DATA_FILE_NAMES'
 AND list_type = 'IVR_APP_NAME'
 AND VALUE = 'MAXMIPA'
 ;
UPDATE CC_A_LIST_LKUP
   SET ref_type = 'MIEB'
 WHERE NAME = 'IVR_DATA_FILE_NAMES'
 AND list_type = 'IVR_APP_NAME'
 AND VALUE = 'MAXMIACA'
 ;
COMMIT;

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 2305, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='MI APCC IVR') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 9570, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='MI APCC Test') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 9841, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='MI APCC Test') );
COMMIT;