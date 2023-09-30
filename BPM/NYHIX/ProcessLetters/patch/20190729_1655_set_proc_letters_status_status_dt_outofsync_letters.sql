----  NYHIX-51090.  Letter Status not Matching MAXe
----


merge into 
( 
SELECT 
p.letter_request_id as letter_request_id,
p.status as status , 
p.status_dt as status_dt,complete_dt,create_dt
FROM corp_etl_proc_letters p 

where complete_dt is not null
and status not in ('Mailed','Combined Similar Requests','Overcome by Events','Voided','Errored','Rejected by Mailhouse','Canceled')
and create_dt >= add_months(trunc(sysdate,'mm'),-5)
)a
using 
( SELECT 
s.letter_id as letter_id ,
s.letter_status  as letter_status,
s.letter_update_ts  as letter_update_ts
FROM 
 letters_stg  s 
)b
on (a.letter_request_id = b.letter_id)
when matched then update
set a.status = b.letter_status,
a.status_dt = b.letter_update_ts;


COMMIT; 
