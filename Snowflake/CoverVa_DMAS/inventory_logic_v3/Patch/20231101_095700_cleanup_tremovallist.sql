delete from coverva_dmas.application_removal_list_full_load
where filename = 'T_Removal_List_20231101_000001'
and date_added = cast('10/31/2023' as date);

ALTER TABLE COVERVA_DMAS.DMAS_Application_V3_Current ADD (remove_from_inventory VARCHAR);
ALTER TABLE COVERVA_DMAS.DMAS_Application_V3_Inventory ADD (remove_from_inventory VARCHAR);
ALTER TABLE COVERVA_DMAS.APPLICATION_REMOVAL_LIST_FULL_LOAD ADD (remove_from_inventory VARCHAR);

UPDATE COVERVA_DMAS.DMAS_Application_V3_Current
SET remove_from_inventory = 'N';

UPDATE COVERVA_DMAS.DMAS_Application_V3_Inventory
SET remove_from_inventory = 'N';

UPDATE COVERVA_DMAS.APPLICATION_REMOVAL_LIST_FULL_LOAD
SET remove_from_inventory = 'Y';

UPDATE coverva_dmas.dmas_file_load_lkup
SET insert_fields = 'Tracking_Number,Date_Added,Removal_Reason,Filename,Filename_Prefix,Remove_From_Inventory'
,select_fields = 'REGEXP_REPLACE(t,''[^A-Za-z0-9]'',''''),CAST(regexp_replace(date_added,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS date_added,reason,filename,SUBSTR(filename,1,6) filename_prefix,remove_from_inventory'
WHERE filename_prefix = 'T_REMOVAL_LIST';

