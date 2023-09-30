--Selection txn count
select * from (
select trunc(st.status_date) Record_date, transaction_type_cd Transaction_type, status_cd Transaction_Status,  count(1) "Count of Transactions"
from selection_txn st where st.status_cd in ( 'acceptedByState','denied', 'invalid')
and st.create_ts >= to_date('6/28/2019','mm/dd/yyyy')
group by trunc(st.status_date), transaction_type_cd, status_cd
)
order by Record_date desc , transaction_type, Transaction_Status desc
;

--Mailed letters count
select trunc(mailed_date) Record_Date, count(1) "Count of Letters Mailed" 
from letter_request lr 
where mailed_date is not null
group by trunc(mailed_date)
order by trunc(mailed_date) desc;

-- Referral Count
select trunc(call_start_ts) Record_Date, count(distinct event_id) "Count of Referral Calls" 
from call_record cr
JOIN EB.EVENT E ON E.CALL_RECORD_ID = CR.CALL_RECORD_ID --AND E.EVENT_TYPE_CD = 'INBOUND_CALL'
JOIN EB.ENUM_MANUAL_CALL_ACTION REFF ON REFF.CATEGORIES like 'REFERRAL' AND REFF.VALUE = E.CONTEXT
where cr.create_ts >= to_date('6/28/2019','mm/dd/yyyy')
and cr.call_end_ts is not null
and (cr.call_type_cd in ('INBOUND','OUTBOUND'))
group by trunc(call_start_ts)
order by trunc(call_start_ts) desc;

-- count of chats
select trunc(cast(FROM_TZ(cast( CALL_sTART_TS AS TIMESTAMP),'UTC') AT TIME ZONE 'US/EASTERN' as date)) Record_Date, count(distinct cr.call_record_id) "Count of Chats(End_TS not null)"
from call_record cr
where call_type_cd = 'WEBCHAT'
and cr.call_start_ts >= to_date('6/28/2019','mm/dd/yyyy')
and substr(trim(created_by),1,1) = '-'
and cr.call_end_ts is not null
and medchat_id is not null
group by trunc(cast(FROM_TZ(cast( CALL_sTART_TS AS TIMESTAMP),'UTC') AT TIME ZONE 'US/EASTERN' as date))
order by trunc(cast(FROM_TZ(cast( CALL_sTART_TS AS TIMESTAMP),'UTC') AT TIME ZONE 'US/EASTERN' as date)) desc;

-- count of outbound calls
select trunc(call_start_ts) Record_Date, count(distinct cr.call_record_id) "Count of Outbound Calls(End_TS not null)"
from call_record cr
where call_type_cd = 'OUTBOUND'
and cr.create_ts >= to_date('6/28/2019','mm/dd/yyyy')
and cr.call_end_ts is not null
group by trunc(call_start_ts)
order by trunc(call_start_ts) desc;

