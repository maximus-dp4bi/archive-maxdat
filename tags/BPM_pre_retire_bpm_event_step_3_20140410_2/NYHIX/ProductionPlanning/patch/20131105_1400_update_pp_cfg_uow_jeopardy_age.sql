update pp_cfg_unit_of_work set jeopardy_inv_age=2 where label='HSDE1';
update pp_cfg_unit_of_work set jeopardy_inv_age=2 where label='SHOP';
update pp_cfg_unit_of_work set jeopardy_inv_age=1 where label='Account Correction';
update pp_cfg_unit_of_work set jeopardy_inv_age=3 where label='Data Entry';
update pp_cfg_unit_of_work set jeopardy_inv_age=7 where label='Doc Resolution 2';
update pp_cfg_unit_of_work set jeopardy_inv_age=1 where label='Linking';
update pp_cfg_unit_of_work set jeopardy_inv_age=7 where label='FM';
update pp_cfg_unit_of_work set jeopardy_inv_age=7 where label='Other';

delete from pp_d_actual_details;
delete from pp_f_actuals;

commit;

/