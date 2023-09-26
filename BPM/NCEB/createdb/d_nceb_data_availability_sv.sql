drop view d_nceb_data_availability_sv;
Create or replace view d_nceb_data_availability_sv as
select 
case when NewEnroll_cnt > 0 then 'NewEnroll Accepted Data Exists' else 'No Data' end NewEnroll_accepted_data_exists
,case when Transfer_acnt > 0 then 'Transfer Accepted Data Exists' else 'No Data' end Transfer_accepted_data_exists
,case when Transfer_icnt > 0 then 'Transfer other status Data Exists' else 'No Data' end Transfer_data_exists
,case when outbound_cnt > 0 then 'Outbound Data Exists' else 'No Data' end Outbound_call_data_exists
,case when inbound_cnt > 0 then 'Inbound Data Exists' else 'No Data' end Inbound_call_data_exists
,case when webchat_cnt > 0 then 'Webchat Data Exists (excluding Call id 26052686)' else 'No Data (excluding Call id 26052686)' end Webchat_data_exists
,case when mailed_letter_cnt > 0 then 'Mailed Letter Data Exists' else 'No Data' end Mailed_data_exists
,case when sent_letter_cnt > 0 then 'Sent Letter Data Exists' else 'No Data' end Sent_data_exists
from (
select 
(select count(1) NewEnroll_cnt from eb.selection_txn where create_ts > to_date('6/28/2019','mm/dd/yyyy') and transaction_type_cd = 'NewEnrollment' and status_cd = 'acceptedByState') NewEnroll_cnt
,(select count(1) NewEnroll_cnt from eb.selection_txn where create_ts > to_date('6/28/2019','mm/dd/yyyy') and transaction_type_cd = 'Transfer' and status_cd = 'acceptedByState') Transfer_acnt
,(select count(1) NewEnroll_cnt from eb.selection_txn where create_ts > to_date('6/28/2019','mm/dd/yyyy') and transaction_type_cd = 'Transfer' and status_cd <> 'void') Transfer_icnt
,(select count(1) outbound_cnt from eb.call_record where create_ts > to_date('6/28/2019','mm/dd/yyyy') and call_type_cd = 'OUTBOUND') outbound_cnt
,(select count(1) inbound_cnt from eb.call_record where create_ts > to_date('6/28/2019','mm/dd/yyyy') and call_type_cd = 'INBOUND') inbound_cnt
,(select count(1) chat_cnt from eb.call_record where create_ts > to_date('6/28/2019','mm/dd/yyyy') and call_record_id <> 26052686 and call_type_cd = 'WEBCHAT') webchat_cnt
, (select count(1) from eb.letter_request lr where mailed_date is not null) Mailed_letter_cnt
, (select count(1) from eb.letter_request lr where status_cd = 'SENT') Sent_letter_cnt
from dual
)
;


GRANT SELECT ON MAXDAT_SUPPORT.d_nceb_data_availability_sv TO MAXDAT_REPORTS ;
GRANT SELECT ON MAXDAT_SUPPORT.d_nceb_data_availability_sv TO MAXDATSUPPORT_READ_ONLY;

--select * from d_nceb_data_availability_sv 
