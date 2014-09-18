UPDATE corp_etl_proc_outbnd_call oc
   SET subprogram = 'MMAI'
 WHERE job_id >= 30548
   AND subprogram IS NULL
   AND EXISTS
       (SELECT 1 FROM etl_e_dialer_run_stg rd
         WHERE oc.job_id = rd.job_id AND oc.row_id = rd.row_id
           AND substr(record_content, instr(record_content,',',1,2)+1, instr(record_content, ',', 1,3) - instr(record_content, ',', 1,2)-1)
            = 'M'
       );
 --
COMMIT;
