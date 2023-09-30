-- NYHIX-47982
-- UNDO
SET serveroutput ON;

DECLARE

v_before_count NUMBER := 0;
v_insert_count NUMBER := 0;
v_update_count NUMBER := 0;
v_after_count  NUMBER := 0;

BEGIN

  dbms_output.put_line('This script will do an UPDATE and INSERT. Please ensure that both were successful before committing.');
  dbms_output.put_line('If either part is not successful then ROLLBACK both changes!');
  dbms_output.put_line(' ');

  SELECT COUNT(0)  -- 1257
  INTO   v_before_count
  FROM   DP_SCORECARD.SC_AGENT_STAT
  WHERE  AGENT_ID in ('204267','141164','135755','128259','146329','148010','112826','118825','246142','132772','112781','246076',
                      '133322','130460','105716','140772','130271','134874','115971','102228','147813','144291','68125','141403',
                      '128207','104418','139463','46964','135861','139092','140853','146845','144550','133323','130464','144290',
                      '113818','147793','139484','150042','150047','64055','125160','139760','247463','131935','81261','204307',
                      '139610','117691','132826','246214','117693','140626','247325','139613','140921','147809','147431','135262',
                      '245997','136397','203655','141086','136273','138365','245506','140935','134807','137323','130791','130396',
                      '124490','140925','141110','137329','138388','123263')
  AND    TRUNC(AS_DATE) between '01-FEB-19' AND '28-FEB-19';

  dbms_output.put_line('Before DP_SCORECARD.SC_AGENT_STAT update record count: '||v_before_count);

  IF v_before_count > 0
  THEN

    UPDATE DP_SCORECARD.SC_AGENT_STAT sas
    SET    (tot_return_to_queue,tot_return_to_queue_timeout) = (SELECT tot_return_to_queue, tot_return_to_queue_timeout
                                                                FROM   DP_SCORECARD.SC_AGENT_STAT_47982_20190312 sas_back
                                                                WHERE  sas_back.as_date = sas.as_date
                                                                AND    sas_back.agent_id = sas.agent_id)
    WHERE  sas.AGENT_ID in ('204267','141164','135755','128259','146329','148010','112826','118825','246142','132772','112781','246076',
                        '133322','130460','105716','140772','130271','134874','115971','102228','147813','144291','68125','141403',
                        '128207','104418','139463','46964','135861','139092','140853','146845','144550','133323','130464','144290',
                        '113818','147793','139484','150042','150047','64055','125160','139760','247463','131935','81261','204307',
                        '139610','117691','132826','246214','117693','140626','247325','139613','140921','147809','147431','135262',
                        '245997','136397','203655','141086','136273','138365','245506','140935','134807','137323','130791','130396',
                        '124490','140925','141110','137329','138388','123263')
    AND    TRUNC(AS_DATE) between '01-FEB-19' AND '28-FEB-19';

    v_update_count := SQL%ROWCOUNT;

    dbms_output.put_line('DP_SCORECARD.SC_AGENT_STAT records updated: '||v_update_count);
    dbms_output.put_line('Do not commit unless the number of updated records is greater zero');

  ELSE

    dbms_output.put_line('No records found, skip the update');

  END IF;

  SELECT COUNT(0)  -- 1257
  INTO   v_after_count
  FROM   DP_SCORECARD.SC_AGENT_STAT
  WHERE  AGENT_ID in ('204267','141164','135755','128259','146329','148010','112826','118825','246142','132772','112781','246076',
                      '133322','130460','105716','140772','130271','134874','115971','102228','147813','144291','68125','141403',
                      '128207','104418','139463','46964','135861','139092','140853','146845','144550','133323','130464','144290',
                      '113818','147793','139484','150042','150047','64055','125160','139760','247463','131935','81261','204307',
                      '139610','117691','132826','246214','117693','140626','247325','139613','140921','147809','147431','135262',
                      '245997','136397','203655','141086','136273','138365','245506','140935','134807','137323','130791','130396',
                      '124490','140925','141110','137329','138388','123263')
  AND    TRUNC(AS_DATE) between '01-FEB-19' AND '28-FEB-19';

  dbms_output.put_line('After record count: '||v_after_count);
  dbms_output.put_line(' ');
----------------------------
  SELECT count(0) -- 0
  INTO   v_before_count
  FROM   DP_SCORECARD.Sc_Lag_Time_47982_20190314
  WHERE  AGENT_ID in ('204267','141164','135755','128259','146329','148010','112826','118825','246142','132772','112781','246076',
                      '133322','130460','105716','140772','130271','134874','115971','102228','147813','144291','68125','141403',
                      '128207','104418','139463','46964','135861','139092','140853','146845','144550','133323','130464','144290',
                      '113818','147793','139484','150042','150047','64055','125160','139760','247463','131935','81261','204307',
                      '139610','117691','132826','246214','117693','140626','247325','139613','140921','147809','147431','135262',
                      '245997','136397','203655','141086','136273','138365','245506','140935','134807','137323','130791','130396',
                      '124490','140925','141110','137329','138388','123263')
  AND TRUNC(LAG_DATE) between '01-FEB-19' AND '28-FEB-19';

  dbms_output.put_line('Before DP_SCORECARD.Sc_Lag_Time_47982_20190314 record count: '||v_before_count);

  IF v_before_count = 0
  THEN

    INSERT INTO DP_SCORECARD.Sc_Lag_Time
    SELECT lag_date, agent_id, supervisor_id, tot_sched_productive_time, create_by, create_date, adherence_flag
    FROM   DP_SCORECARD.SC_LAG_TIME_47982_20190314
    WHERE  AGENT_ID in ('204267','141164','135755','128259','146329','148010','112826','118825','246142','132772','112781','246076',
                        '133322','130460','105716','140772','130271','134874','115971','102228','147813','144291','68125','141403',
                        '128207','104418','139463','46964','135861','139092','140853','146845','144550','133323','130464','144290',
                        '113818','147793','139484','150042','150047','64055','125160','139760','247463','131935','81261','204307',
                        '139610','117691','132826','246214','117693','140626','247325','139613','140921','147809','147431','135262',
                        '245997','136397','203655','141086','136273','138365','245506','140935','134807','137323','130791','130396',
                        '124490','140925','141110','137329','138388','123263')
    AND TRUNC(LAG_DATE) between '01-FEB-19' AND '28-FEB-19';

    v_insert_count := SQL%ROWCOUNT;

    dbms_output.put_line('DP_SCORECARD.Sc_Lag_Time records restored: '||v_insert_count);
    dbms_output.put_line('Do not commit unless the number of deleted records is greater than zero');

  ELSE

    dbms_output.put_line('Records found, skip the insert');

  END IF;

  SELECT COUNT(0)  -- 1282
  INTO   v_after_count
  FROM   DP_SCORECARD.Sc_Lag_Time
  WHERE  AGENT_ID in ('204267','141164','135755','128259','146329','148010','112826','118825','246142','132772','112781','246076',
                      '133322','130460','105716','140772','130271','134874','115971','102228','147813','144291','68125','141403',
                      '128207','104418','139463','46964','135861','139092','140853','146845','144550','133323','130464','144290',
                      '113818','147793','139484','150042','150047','64055','125160','139760','247463','131935','81261','204307',
                      '139610','117691','132826','246214','117693','140626','247325','139613','140921','147809','147431','135262',
                      '245997','136397','203655','141086','136273','138365','245506','140935','134807','137323','130791','130396',
                      '124490','140925','141110','137329','138388','123263')
  AND TRUNC(LAG_DATE) between '01-FEB-19' AND '28-FEB-19';

  dbms_output.put_line('After insert into DP_SCORECARD.Sc_Lag_Time record count (should be equal to the before count): '||v_after_count);

END;
/
