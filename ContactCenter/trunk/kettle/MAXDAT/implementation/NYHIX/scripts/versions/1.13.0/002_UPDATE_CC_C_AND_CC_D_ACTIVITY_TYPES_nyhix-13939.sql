
select * from CC_D_ACTIVITY_TYPE
where activity_type_name in (
'Assistor Classroom Training ',
'HSDE Access Application',
'HSDE Nav/CAC Batches',
'HSDE NYSOH Application',
'Link Document Set - Verification',
'Link Document Set QC - VDoc',
'Link Document Set - App',
'HSDE QC - Verification',
'Link Doc Set QC - App'
);

select * from CC_C_ACTIVITY_TYPE
where activity_type_name in (
'Assistor Classroom Training ',
'HSDE Access Application',
'HSDE Nav/CAC Batches',
'HSDE NYSOH Application',
'Link Document Set - Verification',
'Link Document Set QC - VDoc',
'Link Document Set - App',
'HSDE QC - Verification',
'Link Doc Set QC - App'
);

update CC_D_ACTIVITY_TYPE set activity_type_category = 'Training' , is_paid_flag = 1, is_available_flag =0 , is_ready_flag =0 , is_absence_flag =0 where activity_type_name = 'Assistor Classroom Training ';
update CC_C_ACTIVITY_TYPE set activity_type_category = 'Training' , is_paid_flag = 1, is_available_flag =0 , is_ready_flag =0 , is_absence_flag =0 where activity_type_name = 'Assistor Classroom Training ';

update CC_D_ACTIVITY_TYPE set activity_type_category = 'Other Not Ready' , is_paid_flag = 1, is_available_flag =0 , is_ready_flag =0 , is_absence_flag =0 where activity_type_name in ('HSDE Access Application',
'HSDE Nav/CAC Batches',
'HSDE NYSOH Application',
'Link Document Set - Verification',
'Link Document Set QC - VDoc',
'Link Document Set - App',
'HSDE QC - Verification','Link Doc Set QC - App');
update CC_C_ACTIVITY_TYPE set activity_type_category = 'Other Not Ready' , is_paid_flag = 1, is_available_flag =0 , is_ready_flag =0 , is_absence_flag =0 where activity_type_name in ('HSDE Access Application',
'HSDE Nav/CAC Batches',
'HSDE NYSOH Application',
'Link Document Set - Verification',
'Link Document Set QC - VDoc',
'Link Document Set - App',
'HSDE QC - Verification','Link Doc Set QC - App');


commit;
