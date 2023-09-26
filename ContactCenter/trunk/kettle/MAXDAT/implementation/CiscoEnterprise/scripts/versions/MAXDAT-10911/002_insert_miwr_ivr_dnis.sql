alter session set current_schema = cisco_enterprise_cc;

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
9351,
(select d.uow_id from CC_D_UNIT_OF_WORK d where d.unit_of_work_name = 'Michigan Work Requirements IVR' )
);

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
9543,
(select d.uow_id from CC_D_UNIT_OF_WORK d where d.unit_of_work_name = 'Michigan Work Requirements IVR' )
);

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
63510,
(select d.uow_id from CC_D_UNIT_OF_WORK d where d.unit_of_work_name = 'Michigan Work Requirements IVR' )
);

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
67009,
(select d.uow_id from CC_D_UNIT_OF_WORK d where d.unit_of_work_name = 'Michigan Work Requirements IVR' )
);

insert into cc_a_list_lkup (name, list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments)
values ('IVR_DATA_FILE_NAMES','IVR_APP_NAME','MAXMIWRK','MIWR','Michigan Work Requirements', null, trunc(SYSDATE),  to_date('7/7/7777','mm/dd/yyyy'),'Global control to fetch the Project name using the Application Name from data file.');


commit;