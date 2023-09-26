-- TXEB-3622 "No Longer Required" DB script encountered "Object no longer exists" on production
-- This scrip fixes the dimensional. The facts are good.

BEGIN
  FOR c IN
        (SELECT outreach_id, o.cancel_reason, o.cancel_method
           FROM corp_etl_clnt_outreach o
          WHERE o.instance_status = 'Complete'
            AND outreach_status IN ('Withdrawn','Outreach No Longer Required','Outreach Invalid Request')
            AND outreach_id IN (26135334,26176332,26176517,26135636,26176684
                               ,26154524,26154729,26134111,26847754,26154563
                               ,26152766,26847755,26142414,26175867,26175920
                               ,26175801,26142417,26176284,26176465,26138378
                               ,26081038))

  LOOP
    UPDATE d_cor_current d
       SET cancel_method = c.cancel_method
         , cancel_reason = c.cancel_reason
     WHERE outreach_request_id = c.outreach_id
       AND (c.cancel_reason != d.cancel_reason OR
            c.cancel_method != d.cancel_method);
  END LOOP;
  COMMIT;
END;