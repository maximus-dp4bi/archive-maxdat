alter session set current_schema = maxdat;

create index cc_f_v2_call_sv_idx1
  on cc_f_v2_call_sv (d_date_id);
  
create index hco_ivr_transactions_idx2
 on hco_ivr_transactions (response_date);

create index hco_ivr_transactions_idx3
 on hco_ivr_transactions (activity_id);

create index hco_ob_transactions_I003
 on hco_ob_transactions (activity_id);
