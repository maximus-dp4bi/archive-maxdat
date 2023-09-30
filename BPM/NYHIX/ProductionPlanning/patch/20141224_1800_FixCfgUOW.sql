insert into pp_cfg_unit_of_work values (21, 'NYHIX_APPEAL_3', 'N', 'Minutes',3, 'BUS', 10, 'Appeals');
insert into pp_cfg_unit_of_work values (22, 'NYHIX_DOCRES_1', 'N', 'Minutes',2, 'BUS', 10, 'DocRes 1');
insert into pp_cfg_unit_of_work values (23, 'NYHIX_LINKING_2', 'N', 'Minutes',2, 'BUS', 10, 'Linking');
insert into pp_cfg_unit_of_work values (24, 'NYHIX_NA1', 'N', 'Minutes',50, 'BUS', 100, 'NA1');
insert into pp_cfg_unit_of_work values (25, 'NYHIX_RESEARCH_1', 'N', 'Minutes',1, 'BUS', 10, 'RESEARCH 1');
insert into pp_cfg_unit_of_work values (26, 'NYHIX_RESEARCH_15_FM', 'N', 'Minutes',15, 'BUS', 30, 'Returned Mail');
insert into pp_cfg_unit_of_work values (27, 'NYHIX_RESEARCH_15_OD', 'N', 'Minutes',15, 'BUS', 30, 'Orphan Documents');
insert into pp_cfg_unit_of_work values (28, 'NYHIX_RESEARCH_2', 'N', 'Minutes',2, 'BUS', 10, 'RESEARCH 2');
insert into pp_cfg_unit_of_work values (29, 'NYHIX_RESEARCH_NA', 'N', 'Minutes',50, 'BUS', 100, 'RESEARCH NA');
insert into pp_cfg_unit_of_work values (30, 'NYHIX_VERIF_5', 'N', 'Minutes',5, 'BUS', 10, 'VERIF');

delete from pp_f_actuals;
delete from pp_d_actual_details;

commit;

/
