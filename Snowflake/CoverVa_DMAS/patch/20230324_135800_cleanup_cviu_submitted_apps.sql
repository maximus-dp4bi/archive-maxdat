update cviu_data_full_load
set processing_status = 'Submitted'
where filename = 'CVIU_Inventory_20230324_082035'
and processing_status = 'Completed';

call SP_UPDATE_APPLICATION_CURRENT_STATE('2023-03-24T11:40:00.000Z');
call SP_UPDATE_APPLICATION_REVIEW_DATE('2023-03-24T11:40:00.000Z');
CALL SP_POPULATE_APPLICATION_CURRENT();