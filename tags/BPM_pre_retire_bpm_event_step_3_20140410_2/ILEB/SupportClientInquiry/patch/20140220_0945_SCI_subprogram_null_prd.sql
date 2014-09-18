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
      and program_subtype in ('VMC','MMAI','LTSS'));
      
      commit;
      