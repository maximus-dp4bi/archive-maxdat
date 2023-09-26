insert into pp_d_uow_source_ref (usr_id,uow_id,source_ref_type_id,source_ref_value,source_ref_detail_identifier,effective_date,end_date,source_ref_id)
values (SEQ_PP_USR_ID.nextval,19,4,'Incarceration Proof','PIPKINS EVENTS',sysdate,to_date('07-JUL-77','dd-mon-yy'),1230);

commit;