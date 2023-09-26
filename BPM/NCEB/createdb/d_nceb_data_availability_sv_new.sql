Create or replace view d_nceb_data_availability_sv as
select 'New Enroll Accepted by State' Data_type, case when (select count(1) NewEnroll_cnt from eb.selection_txn where create_ts > to_date('6/28/2019','mm/dd/yyyy') and transaction_type_cd = 'NewEnrollment' and status_cd = 'acceptedByState')>0 then 'Data created after 6/28 exists' else 'No Data' end Data_exists from dual
union
select 'Transfer Accepted by State' Data_type, case when (select count(1) from eb.selection_txn where create_ts > to_date('6/28/2019','mm/dd/yyyy') and transaction_type_cd = 'Transfer' and status_cd = 'acceptedByState') >0 then 'Data created after 6/28 exists' else 'No Data' end Data_exists from dual
union
select 'Transfers in any Status' Data_type, case when (select count(1)  from eb.selection_txn where create_ts > to_date('6/28/2019','mm/dd/yyyy') and transaction_type_cd = 'Transfer' and status_cd <> 'void')  >0 then 'Data created after 6/28 exists' else 'No Data' end Data_exists from dual
union
select 'Outbound Calls' Data_type, case when (select count(1)  from eb.call_record where create_ts > to_date('6/28/2019','mm/dd/yyyy') and call_type_cd = 'OUTBOUND') >0 then 'Data created after 6/28 exists' else 'No Data' end Data_exists from dual
union
select 'Inbound Calls' Data_type, case when (select count(1) inbound_cnt from eb.call_record where create_ts > to_date('6/28/2019','mm/dd/yyyy') and call_type_cd = 'INBOUND')  >0 then 'Data created after 6/28 exists' else 'No Data' end Data_exists from dual
union
select 'Webchat Records' Data_type, case when (select count(1) chat_cnt from eb.call_record where create_ts > to_date('6/28/2019','mm/dd/yyyy') and call_record_id <> 26052686 and call_type_cd = 'WEBCHAT')  >0 then 'Data Exists(excluding Call id 26052686)' else 'No Data(excluding Call id 26052686)' end Data_exists from dual
union
select 'Letters Mailed by vendor' Data_type, case when (select count(1) from eb.letter_request lr where mailed_date is not null)  >0 then 'Data Exists' else 'No Data' end Data_exists from dual
union
select 'Letters Sent to vendor' Data_type, case when (select count(1) from eb.letter_request lr where status_cd = 'SENT')  >0 then 'Data Exists' else 'No Data' end Data_exists from dual
;


GRANT SELECT ON MAXDAT_SUPPORT.d_nceb_data_availability_sv TO MAXDAT_REPORTS ;
GRANT SELECT ON MAXDAT_SUPPORT.d_nceb_data_availability_sv TO MAXDATSUPPORT_READ_ONLY;

--select * from d_nceb_data_availability_sv 
