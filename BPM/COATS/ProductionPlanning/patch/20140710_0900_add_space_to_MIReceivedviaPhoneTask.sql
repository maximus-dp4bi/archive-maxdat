UPDATE pp_d_uow_source_ref set source_ref_value='MI Received via Phone task ' where usr_id=57;
UPDATE pp_d_uow_source_ref set source_ref_value='Disenrollment - PARIS' where usr_id=66;

TRUNCATE TABLE pp_d_actual_details;
TRUNCATE TABLE pp_f_actuals;

commit;

/