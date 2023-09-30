--- NYHIX-39751
---
alter session set current_schema = MAXDAT;

update corp_etl_proc_letters set letter_type = 'Retro: Deny Retro Coverage - Above Medicaid Level' 
where letter_request_id in (9980064, 9978529, 10156580,10159697,10217037,10180166,10252751,9975356,10132708,
10139824,10250944,9977403,10219340,10218844,10256108,10258556,10147996,10165000,10254296,9979488,10150726,
10165001,10199298);
commit;
