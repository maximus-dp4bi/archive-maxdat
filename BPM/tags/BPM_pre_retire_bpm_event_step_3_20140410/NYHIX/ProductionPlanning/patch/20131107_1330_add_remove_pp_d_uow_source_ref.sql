update pp_cfg_unit_of_work set jeopardy_inv_age=2 where label='HSDE1';
update pp_cfg_unit_of_work set jeopardy_inv_age=2 where label='SHOP';
update pp_cfg_unit_of_work set jeopardy_inv_age=1 where label='Account Correction';
update pp_cfg_unit_of_work set jeopardy_inv_age=3 where label='Data Entry';
update pp_cfg_unit_of_work set jeopardy_inv_age=7 where label='Doc Resolution 2';
update pp_cfg_unit_of_work set jeopardy_inv_age=1 where label='Linking';
update pp_cfg_unit_of_work set jeopardy_inv_age=7 where label='FM';
update pp_cfg_unit_of_work set jeopardy_inv_age=7 where label='Other';

update pp_d_unit_of_work set jeopardy_inv_age=2 where label='HSDE1';
update pp_d_unit_of_work set jeopardy_inv_age=2 where label='SHOP';
update pp_d_unit_of_work set jeopardy_inv_age=1 where label='Account Correction';
update pp_d_unit_of_work set jeopardy_inv_age=3 where label='Data Entry';
update pp_d_unit_of_work set jeopardy_inv_age=7 where label='Doc Resolution 2';
update pp_d_unit_of_work set jeopardy_inv_age=1 where label='Linking';
update pp_d_unit_of_work set jeopardy_inv_age=7 where label='FM';
update pp_d_unit_of_work set jeopardy_inv_age=7 where label='Other';

delete from pp_d_uow_source_ref where source_ref_value in ('Data Entry Task','Data Entry-SHOP Employer Task','Data Entry-SHOP Employee Task');

INSERT INTO PP_D_UOW_SOURCE_REF SELECT 39, 5, 1, 'DPR - Other', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 40, 5, 1, 'DPR - Doc/Form Type Mismatch Task ', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 41, 5, 1, 'DPR - Document Problem Resolution', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;

delete from pp_d_actual_details;
delete from pp_f_actuals;

commit;

/