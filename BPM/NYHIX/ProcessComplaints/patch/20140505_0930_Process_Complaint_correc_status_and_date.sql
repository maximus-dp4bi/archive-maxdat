update corp_etl_complaints_incidents set incident_status='Incident Closed' ,incident_status_dt =to_date('2014-03-13 18:08:00','yyyy-mm-dd hh24:mi:ss') where incident_id = 26053741;
update corp_etl_complaints_incidents set incident_status= 'Referral Closed',incident_status_dt =to_date('2014-03-13 12:17:16','yyyy-mm-dd hh24:mi:ss') where incident_id = 26056713;
update corp_etl_complaints_incidents set incident_status= 'Incident Closed',incident_status_dt = to_date('2013-12-20 10:34:46','yyyy-mm-dd hh24:mi:ss') where incident_id = 26035891;
update corp_etl_complaints_incidents set incident_status= 'Referral Closed',incident_status_dt =to_date('2013-11-06 13:55:33','yyyy-mm-dd hh24:mi:ss') where incident_id = 26035156;
update corp_etl_complaints_incidents set incident_status= 'Incident Closed',incident_status_dt =to_date('2013-11-07 11:12:30','yyyy-mm-dd hh24:mi:ss') where incident_id = 26035198;
update corp_etl_complaints_incidents set incident_status= 'Incident Closed',incident_status_dt = to_date('2013-12-19 08:21:46','yyyy-mm-dd hh24:mi:ss') where incident_id = 26035550;
update corp_etl_complaints_incidents set incident_status= 'Incident Closed',incident_status_dt = to_date('2013-12-19 15:15:05','yyyy-mm-dd hh24:mi:ss') where incident_id = 26035765;
update corp_etl_complaints_incidents set incident_status= 'Incident Closed',incident_status_dt = to_date('2013-12-20 10:39:55','yyyy-mm-dd hh24:mi:ss') where incident_id = 26035872;


commit;




