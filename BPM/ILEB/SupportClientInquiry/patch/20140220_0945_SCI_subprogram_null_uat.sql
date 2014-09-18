Update corp_etl_client_inquiry_dtl set program_subtype = null
where  cecid_id in
(SELECT cecid_id     
  FROM corp_etl_client_inquiry inq ,corp_etl_client_inquiry_dtl d
 WHERE 
--((instance_status = 'Active'
 --  AND contact_end_dt IS NOT NULL
  -- AND complete_dt IS NOT NULL ) or 
   ( trunc(create_dt) between  to_date('11-DEC-2013','DD-MON-YYYY') and to_date('26-JAN-2014','DD-MON-YYYY'))
   --) --trunc(create_dt) >= to_date('12-DEC-2013','DD-MON-YYYY') and trunc(create_dt) <= to_date('26-JAN-2014','DD-MON-YYYY')) )
   and inq.ceci_id = d.ceci_id
   and program_subtype not in ('PCCM','ICP')
      and program_subtype in ('VMC','MMAI','LTSS'))
  and client_id not in (15534385,22059095,19955755 ,16156872,
22894143,
21971681,
22433738,
16660431,
16310060,
16339466,
15650309,
17151577,
15520320,
22813405,
20208039,
22048887,
15114026,
22093249,
18192460,
22015082,
22093249,
21695686,
17643355,
20601035,
16775573,
21737107,
21654284,
21692674,
20453748,
22883221,
15278871,
17151577,
22390999,
18178769);

      
 commit;