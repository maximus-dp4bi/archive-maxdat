
update coverva_dmas.dmas_file_log d
set cdc_v3_processed = 'Y',cdc_v3_processed_date = current_timestamp()
where filename_prefix in(select filename_prefix from coverva_dmas.dmas_file_load_lkup where ( use_in_v3_inventory = 'Y'))
AND cdc_v3_Processed = 'N';

update coverva_dmas.dmas_file_log d
set cdc_v3_processed = 'N',cdc_v3_processed_date = null
where filename_prefix in(select filename_prefix from coverva_dmas.dmas_file_load_lkup where ( use_in_v3_inventory = 'Y'))
AND cdc_v3_Processed = 'Y'
and cast(file_date as date) >= cast('07/17/2023' as date)
and cast(load_date as date) = cast('07/18/2023' as date);

select * from coverva_dmas.dmas_file_log d
where filename_prefix in(select filename_prefix from coverva_dmas.dmas_file_load_lkup where ( use_in_v3_inventory = 'Y'))
AND cdc_v3_Processed = 'Y'
and cast(file_date as date) >= cast('07/17/2023' as date)
and cast(load_date as date) = cast('07/18/2023' as date);

select * from dmas_config_control;

update dmas_config_control
set config_value = '07/17/2023'
where config_name = 'INVENTORY_V3_FILE_DATE';

update dmas_application_v3_inventory v
set v.source = x.source
from (select tracking_number,source
      from dmas_application_v3_current) x
where v.tracking_number = x.tracking_number
and x.source is not null
and v.source is null;

update dmas_application_v3_inventory v
set v.processing_unit = x.processing_unit
from (select tracking_number,processing_unit
      from dmas_application_v3_current) x
where v.tracking_number = x.tracking_number
and x.processing_unit is not null
and v.processing_unit is null;

update dmas_application_v3_inventory v
set v.case_type = x.case_type
from (select tracking_number,case_type
      from dmas_application_v3_current) x
where v.tracking_number = x.tracking_number
and x.case_type is not null
and v.case_type is null;

update dmas_application_v3_inventory v
set v.initial_review_complete_date = x.initial_review_complete_date
from (select tracking_number,current_state,initial_review_complete_date
      from dmas_application_v3_current) x
where v.tracking_number = x.tracking_number
and x.current_state = v.current_state
and v.initial_review_complete_date is null
and x.initial_review_complete_date is not null
and v.current_state not in('Intake','Waiting Initial Review');

update dmas_application_v3_inventory v
set v.application_processing_end_date = x.application_processing_end_date
, v.previous_processing_end_date = x.application_processing_end_date
,v.previous_initial_review_date = v.initial_review_complete_date
from (select tracking_number,current_state,application_processing_end_date
      from dmas_application_v3_current) x
where v.tracking_number = x.tracking_number
and x.current_state = v.current_state
and v.application_processing_end_date is null
and x.application_processing_end_date is not null
and v.current_state not in('Intake','Waiting Initial Review','Waiting for Verification Documents','Non Maximus Assigned');

update dmas_application_v3_inventory v
set v.previous_initial_review_date = v.initial_review_complete_date
where initial_review_complete_date is not null
and previous_initial_review_date is null;