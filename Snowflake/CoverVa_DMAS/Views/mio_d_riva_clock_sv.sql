USE SCHEMA PUBLIC;
--pbi_riva_clock
CREATE OR REPLACE VIEW mio_d_riva_clock_sv AS
WITH emp AS(SELECT e.*,TIMESTAMPDIFF(MINUTE,e.start_date,e.end_date) start_end_minutes
            FROM(SELECT e.id
                  ,CONCAT(e.first_name,' ', e.last_name) AS employeename
                  ,s.Supervisor
                  ,m.Manager
                  ,CAST(CONVERT_TIMEZONE('UTC', 'America/New_York',c.created) AS DATE) create_date
                  ,MIN(CONVERT_TIMEZONE('UTC', 'America/New_York',c.created)) start_date
                  ,MAX(CONVERT_TIMEZONE('UTC', 'America/New_York',CASE WHEN l.action = 'End of Shift' THEN c.created ELSE c.ended END)) end_date            
                 FROM coverva_mio.clock_punches c 
                    JOIN coverva_mio.look_time_clock l ON c.action_id = l.id
                    JOIN coverva_mio.employees e ON c.Emp_ID = e.id
                    LEFT JOIN mio_d_supervisor_sv s ON e.supervisor = s.id
                    LEFT JOIN mio_d_manager_sv m ON e.manager = m.id
                GROUP BY e.id,CONCAT(e.first_name,' ', e.last_name),s.Supervisor,m.Manager,CAST(CONVERT_TIMEZONE('UTC', 'America/New_York',c.created) AS DATE) ) e
           GROUP BY e.id,e.employeename,e.Supervisor,e.Manager,e.create_date,e.start_date, e.end_date ),
pr AS(SELECT c.emp_id
        ,CAST(CONVERT_TIMEZONE('UTC', 'America/New_York',c.created) AS DATE)  clock_date
        ,SUM(TIMESTAMPDIFF(MINUTE,c.created,c.ended)) processing
      FROM coverva_mio.clock_punches c 
       JOIN coverva_mio.look_time_clock l ON c.action_id = l.id
      WHERE action = 'Processing'
      GROUP BY c.emp_id,CAST(CONVERT_TIMEZONE('UTC', 'America/New_York',c.created) AS DATE)),
brk AS(SELECT emp_id,clock_date,SUM(break1) break1, SUM(break2) break2
       FROM(SELECT d.emp_id,d.clock_date,CASE WHEN rnk = 1 THEN break ELSE 0 END break1, CASE WHEN rnk > 1 THEN break ELSE 0 END break2
            FROM(SELECT c.emp_id
                   ,RANK() OVER(PARTITION BY c.emp_id,c.action_id,CAST(c.created AS DATE) ORDER BY CAST(c.created AS DATE),c.id) rnk
                   ,CAST(CONVERT_TIMEZONE('UTC', 'America/New_York',c.created) AS DATE)  clock_date                                   
                   ,TIMESTAMPDIFF(MINUTE,c.created,c.ended) break
                 FROM coverva_mio.clock_punches c 
                    JOIN coverva_mio.look_time_clock l ON c.action_id = l.id
                 WHERE action = 'Break') d )
       GROUP BY emp_id,clock_date),
lunch AS(SELECT c.emp_id
          ,CAST(CONVERT_TIMEZONE('UTC', 'America/New_York',c.created) AS DATE)  clock_date
          ,SUM(TIMESTAMPDIFF(MINUTE,c.created,c.ended)) lunch
         FROM coverva_mio.clock_punches c 
           JOIN coverva_mio.look_time_clock l ON c.action_id = l.id
         WHERE action = 'Lunch'
         GROUP BY c.emp_id,CAST(CONVERT_TIMEZONE('UTC', 'America/New_York',c.created) AS DATE)),
rsch AS(SELECT c.emp_id
         ,CAST(CONVERT_TIMEZONE('UTC', 'America/New_York',c.created) AS DATE)  clock_date
         ,SUM(TIMESTAMPDIFF(MINUTE,c.created,c.ended)) research
        FROM coverva_mio.clock_punches c 
          JOIN coverva_mio.look_time_clock l ON c.action_id = l.id
        WHERE action = 'Research'
        GROUP BY c.emp_id,CAST(CONVERT_TIMEZONE('UTC', 'America/New_York',c.created) AS DATE)),
mtg AS(SELECT c.emp_id
         ,CAST(CONVERT_TIMEZONE('UTC', 'America/New_York',c.created) AS DATE)  clock_date
         ,SUM(TIMESTAMPDIFF(MINUTE,c.created,c.ended)) meeting_training
       FROM coverva_mio.clock_punches c 
         JOIN coverva_mio.look_time_clock l ON c.action_id = l.id
       WHERE action = 'Meeting/Training'
       GROUP BY c.emp_id,CAST(CONVERT_TIMEZONE('UTC', 'America/New_York',c.created) AS DATE) )
SELECT emp.id emp_id
  ,employeename
  ,supervisor
  ,manager
  ,emp.create_date clock_date
  ,emp.start_date
  ,emp.end_date  
  ,COALESCE(pr.processing,0) processing
  ,COALESCE(brk.break1,0) break1
  ,COALESCE(brk.break2,0) break2
  ,COALESCE(lunch.lunch,0) lunch
  ,COALESCE(rsch.research,0) research
  ,COALESCE(mtg.meeting_training,0) meeting_training
  ,1440 - (COALESCE(Processing,0) + COALESCE(Break1,0) + COALESCE(Break2,0) + COALESCE(Lunch,0) + COALESCE(Research,0) + COALESCE(Meeting_Training,0)) end_of_shift
  ,emp.start_end_minutes
  ,COALESCE(Processing,0) + COALESCE(Break1,0) + COALESCE(Break2,0) + COALESCE(Lunch,0) + COALESCE(Research,0) + COALESCE(Meeting_Training,0) sum_action_minutes
FROM emp
 LEFT JOIN pr ON emp.id = pr.emp_id AND emp.create_date = pr.clock_date
 LEFT JOIN brk ON emp.id = brk.emp_id AND emp.create_date = brk.clock_date
 LEFT JOIN lunch ON emp.id = lunch.emp_id AND emp.create_date = lunch.clock_date
 LEFT JOIN rsch ON emp.id = rsch.emp_id  AND emp.create_date = rsch.clock_date
 LEFT JOIN mtg ON emp.id = mtg.emp_id  AND emp.create_date = mtg.clock_date ;