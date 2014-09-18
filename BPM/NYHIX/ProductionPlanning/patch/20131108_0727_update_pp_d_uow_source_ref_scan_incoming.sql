update PP_D_UOW_SOURCE_REF set source_ref_type_id=3, source_ref_detail_identifier='BATCH CLASS' where usr_id=3 and source_ref_value='Scan Incoming';

delete from pp_d_actual_details;
delete from pp_f_actuals;

commit;

/