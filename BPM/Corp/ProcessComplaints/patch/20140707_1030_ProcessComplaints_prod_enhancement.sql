--disable trigger

update corp_etl_complaints_incidents
set incident_status = 'Refer to State-Medicaid Managed Care'
where incident_status = 'Refer to State-Managed Care';

update f_complaint_by_date set dcmplis_id = (select dcmplis_id from d_complaint_incident_status where incident_status = 'Refer to State-Managed Care')
where dcmplis_id = (select dcmplis_id from d_complaint_incident_status where incident_status = 'Refer to State-Medicaid Managed Care');

delete from  d_complaint_incident_status where incident_status = 'Refer to State-Medicaid Managed Care';

update d_complaint_incident_status set incident_status = 'Refer to State-Medicaid Managed Care'
where  incident_status = 'Refer to State-Managed Care';

update d_complaint_current set cur_incident_status = 'Refer to State-Medicaid Managed Care'
where cur_incident_status = 'Refer to State-Managed Care';


update corp_etl_complaints_incidents
set incident_status = 'Refer to State-APTC/QHP Plan Management'
where incident_status = 'Refer to State-Research';

update f_complaint_by_date set dcmplis_id = (select dcmplis_id from d_complaint_incident_status where incident_status = 'Refer to State-Research')
where dcmplis_id = (select dcmplis_id from d_complaint_incident_status where incident_status =  'Refer to State-APTC/QHP Plan Management');

delete from  d_complaint_incident_status where incident_status = 'Refer to State-APTC/QHP Plan Management';

update d_complaint_incident_status set incident_status = 'Refer to State-APTC/QHP Plan Management'
where  incident_status = 'Refer to State-Research';

update d_complaint_current set cur_incident_status = 'Refer to State-APTC/QHP Plan Management'
where cur_incident_status = 'Refer to State-Research';

update corp_etl_complaints_incidents
set priority = 'High'
where priority = '1'  ;

update d_complaint_current 
set  priority = 'High'
where priority = '1' ;

update corp_etl_complaints_incidents
set priority = 'Medium'
where priority = '3' ;

update d_complaint_current 
set  priority = 'Medium'
where priority = '3' ;

update corp_etl_complaints_incidents
set priority = 'Low'
where priority = '5' ;

update d_complaint_current 
set  priority =  'Low'
where priority ='5' ;

commit;
--0	NOW (as is)
--1	High
--2	Med-High
--3	Medium
--4	Med-Low
--5	Low
--Need data type field for priority as mentioned in description
