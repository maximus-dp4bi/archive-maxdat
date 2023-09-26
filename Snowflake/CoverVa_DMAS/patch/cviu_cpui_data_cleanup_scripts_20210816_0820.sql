update coverva_dmas.cpu_incarcerated_full_load f
set f.tracking_number = c.tracking_number_new
 ,f.switch = c.switch
 ,f.source = c.source
 ,f.applicant_name = c.applicant_name
 ,f.processing_unit = c.processing_unit
 ,f.program = c.program
 ,f.assigned_to = c.assigned_to
 ,f.locality = c.locality
 ,f.processing_status = c.processing_status
from( 
select trim(left(tracking_number,regexp_instr(tracking_number,' '))) tracking_number_new,
case when tracking_number like '%Disability Indicator%' THEN 'Disability Indicator Incarcerated Switch'
when tracking_number like '% Pregnancy Indicator%' THEN 'Pregnancy Indicator Incarcerated Switch' 
     when tracking_number like '%Incar%' THEN 'Incarcerated Switch'
   else null end  switch
, c.switch source
,c.source applicant_name
,c.applicant_name processing_unit
,c.processing_unit program
,c.program assigned_to
,c.assigned_to locality
,c.locality processing_status
,c.filename
,c.tracking_number
from coverva_dmas.cpu_incarcerated_full_load c
where tracking_number like '%Incar%') c
where f.tracking_number = c.tracking_number and f.tracking_number like '%Incar%'
;


update coverva_dmas.cviu_data_full_load f
set f.tracking_number = c.tracking_number_new
 ,f.switch = c.switch
 ,f.source = c.source
 ,f.applicant_name = c.applicant_name
 ,f.processing_unit = c.processing_unit
 ,f.program = c.program
 ,f.assigned_to = c.assigned_to
 ,f.locality = c.locality
 ,f.processing_status = c.processing_status
from( 
select trim(left(tracking_number,regexp_instr(tracking_number,' '))) tracking_number_new,
case when tracking_number like '%Disability Indicator%' THEN 'Disability Indicator Incarcerated Switch'
when tracking_number like '% Pregnancy Indicator%' THEN 'Pregnancy Indicator Incarcerated Switch' 
     when tracking_number like '%Incar%' THEN 'Incarcerated Switch'
   else null end  switch
, c.switch source
,c.source applicant_name
,c.applicant_name processing_unit
,c.processing_unit program
,c.program assigned_to
,c.assigned_to locality
,c.locality processing_status
,c.filename
,c.tracking_number
from coverva_dmas.cviu_data_full_load c
where tracking_number like '%Incar%') c
where f.tracking_number = c.tracking_number and f.tracking_number like '%Incar%'
;

select *
from coverva_dmas.dmas_application_current c
where tracking_number like '%Incar%'
and exists(select 1 from coverva_dmas.dmas_application_current a where trim(left(c.tracking_number,regexp_instr(c.tracking_number,' '))) = a.tracking_number )
and exists(select 1 from coverva_dmas.dmas_excluded_application x where trim(left(c.tracking_number,regexp_instr(c.tracking_number,' '))) = x.tracking_number and c.file_inventory_date = x.file_inventory_date);

delete from coverva_dmas.dmas_application_current c
where tracking_number like '%Incar%'
and exists(select 1 from coverva_dmas.dmas_application_current a where trim(left(c.tracking_number,regexp_instr(c.tracking_number,' '))) = a.tracking_number )
and not exists(select 1 from coverva_dmas.dmas_excluded_application x where trim(left(c.tracking_number,regexp_instr(c.tracking_number,' '))) = x.tracking_number and c.file_inventory_date = x.file_inventory_date);

update coverva_dmas.dmas_application_current c
set tracking_number = trim(left(tracking_number,regexp_instr(tracking_number,' ')))
where tracking_number like '%Incar%'
and not exists(select 1 from coverva_dmas.dmas_application_current a where trim(left(c.tracking_number,regexp_instr(c.tracking_number,' '))) = a.tracking_number )
and not exists(select 1 from coverva_dmas.dmas_excluded_application x where trim(left(c.tracking_number,regexp_instr(c.tracking_number,' '))) = x.tracking_number and c.file_inventory_date = x.file_inventory_date);

select * from coverva_dmas.dmas_application_current c
where tracking_number in('T23199566','T23201657');

select * from coverva_dmas.dmas_application_event
where tracking_number like '%Incar%'
;

delete from coverva_dmas.dmas_application_current
where tracking_number like '%Incar%'
;

update coverva_dmas.dmas_application c
set tracking_number = trim(left(tracking_number,regexp_instr(tracking_number,' ')))
where tracking_number like '%Incar%'
and trim(left(tracking_number,regexp_instr(tracking_number,' '))) in('T23199566','T23201657');