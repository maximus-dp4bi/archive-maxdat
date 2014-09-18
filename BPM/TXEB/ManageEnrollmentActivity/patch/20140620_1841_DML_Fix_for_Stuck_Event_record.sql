/*
Created on 20-Jun-2014.
Description:
There is one instance in TX MEA ETL that was stuck since 12-May. This is happening due to the Complete_dt being before the Create_dt. As per Steven, this is 
a corner case and we need to perform below going forward.

Below is from Steven Davis on 06/20: BUSINESS RULE CHANGE FOR CORNER CASES.
For the corner case in general I think we need to create a JIRA and add logic to this rule for ased wait for fee and complete date to use selection recd date 
only when the fee recd date is prior to creation ¿ this is happening when we redocument the case for enrollment but they have already paid / have account credit 
and the record of the payment is prior to the creation of the new instance.
*/
DELETE BPM_UPDATE_EVENT_QUEUE
WHERE bueq_id = 124974701;

UPDATE corp_etl_manage_enroll
SET ased_wait_for_fee = ased_selection_recd,
complete_dt = ased_selection_recd
where client_enroll_status_id = 50637355; 
commit;