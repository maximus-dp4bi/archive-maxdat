update coverva_dmas.dmas_file_load_lkup
set load_file = 'Y',select_fields = replace(select_fields,'r_addtl','addr_1')
where filename_prefix like '%INCARCERATED_UNIT_ENROLLMENT%';