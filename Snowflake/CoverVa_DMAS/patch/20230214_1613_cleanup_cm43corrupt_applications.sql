CREATE TABLE coverva_dmas.dmas_cm43_exclude_applications
AS SELECT t_number
FROM DMAS_APPLICATION_INVENTORY_SV
WHERE record_sequence = 1
AND TO_DATE(APP_RECEIVED_DATE) >= CAST('03/01/2021' AS DATE)
AND TO_DATE(APP_RECEIVED_DATE) <= current_date()
AND maximus_source = 'CM43'
AND source = 'RDE'
AND current_state = 'Complete'
AND CAST(first_complete_date AS DATE) <= CAST('12/31/2022' AS DATE);

insert into coverva_dmas.dmas_excluded_application(tracking_number,ignore_application_reason,file_id,file_inventory_date,fp_create_dt)
select tracking_number,'CM43 applications from Nov and Dec corrupt files - project requested to remove on 3/08/2023',file_id,file_inventory_date,current_timestamp()
from coverva_dmas.dmas_cm43_exclude_applications;

delete from coverva_dmas.dmas_application_event
where tracking_number in(select tracking_number from coverva_dmas.dmas_cm43_exclude_applications);

delete from coverva_dmas.dmas_application
where tracking_number in(select tracking_number from coverva_dmas.dmas_cm43_exclude_applications);

delete from coverva_dmas.dmas_application_current
where tracking_number in(select tracking_number from coverva_dmas.dmas_cm43_exclude_applications);

drop table coverva_dmas.dmas_cm43_exclude_applications;