delete cc_c_ivr_dnis where uow_id in (select d.uow_id from CC_D_UNIT_OF_WORK d where upper(d.unit_of_work_name) = 'CSCC IVR');

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
4070,
(select d.uow_id from CC_D_UNIT_OF_WORK d where upper(d.unit_of_work_name) = 'CSCC IVR' )
);

commit;
