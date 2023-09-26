alter session set current_schema = cisco_enterprise_cc;

delete cc_c_ivr_dnis where destination_dnis = 4094 and uow_id in (select d.uow_id from CC_D_UNIT_OF_WORK d where upper(d.unit_of_work_name) = 'VAEB IVR');

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
4094,
(select d.uow_id from CC_D_UNIT_OF_WORK d where upper(d.unit_of_work_name) = 'CCC PLUS IVR' )
);

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
9703,
(select d.uow_id from CC_D_UNIT_OF_WORK d where upper(d.unit_of_work_name) = 'CCC PLUS IVR TEST' )
);

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
9857,
(select d.uow_id from CC_D_UNIT_OF_WORK d where upper(d.unit_of_work_name) = 'CCC PLUS IVR TEST' )
);

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
9905,
(select d.uow_id from CC_D_UNIT_OF_WORK d where upper(d.unit_of_work_name) = 'CCC PLUS IVR TEST' )
);

/*
insert into cc_a_list_lkup (name, list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments)
 values ('IVR_DATA_FILE_NAMES','IVR_APP_NAME','MAXVACCC','VA EB','CCC PLUS', null, trunc(SYSDATE),  to_date('7/7/7777','mm/dd/yyyy'),'Global control to fetch the Project name using the Application Name from data file.');
 */

commit;