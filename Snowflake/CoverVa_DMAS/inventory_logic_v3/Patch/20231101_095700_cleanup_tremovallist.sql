delete from coverva_dmas.application_removal_list_full_load
where filename = 'T_Removal_List_20231101_000001'
and date_added = cast('10/31/2023' as date);