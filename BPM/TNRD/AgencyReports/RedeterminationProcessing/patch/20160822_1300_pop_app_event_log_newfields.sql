begin
for i in (
select DISTINCT s.application_id,s.app_event_log_id,i.outcome_reason
 from app_event_log_stg s
  inner join (SELECT DISTINCT ref_id, i.create_ts,
                     CASE WHEN t.task_name = 'LTSS+' THEN 'LTSS'
                          WHEN t.task_name = 'Other Non-MAGI+' THEN 'NON_MAGI_APP'
                          WHEN t.task_name = 'Voluntary Terminations' THEN 'VOLUNTARY_TERM'
                          WHEN t.task_name = 'MSP Only' THEN 'MEDICARE'
                          WHEN t.task_name = 'Medically Eligible Review' THEN 'MISSING_ME'
                    ELSE null END outcome_reason
                FROM step_instance_stg i
                  INNER JOIN d_task_types t
                    ON i.step_definition_id = t.task_type_id
                  WHERE ref_type = 'APP_HEADER'
                  AND t.task_name IN('Voluntary Terminations','LTSS+','Other Non-MAGI+','MSP Only','Medically Eligible Review'))    i
      on s.application_id = i.ref_id    
      and s.create_ts = i.create_ts
where rfe_status_cd = 'AWAITING_STATE_ACCEPTANCE'
and outcome_cd is null
order by application_id) loop
update app_event_log_stg
set outcome_cd = 'PENDING'
    ,app_status_cd = 'INPROCESS'
    ,outcome_reason_cd = i.outcome_reason
    ,program_cd = 'MEDICAID'
where app_event_log_id = i.app_event_log_id;
end loop;
end;
/

begin
for e in (select end_app.app_event_log_id, end_app.application_id, end_app.app_individual_id, end_app.create_ts end_app_dt, el.create_ts elig_create_ts
       ,el.outcome_cd,COALESCE(el.program_cd,'MEDICAID') program_cd, el.program_subtype_cd, el.outcome_reason_cd
from app_event_log_stg end_app
  inner join app_event_log_stg el
    on end_app.application_id = el.application_id
    and el.app_event_cd = 'ELIG_OUTCOME_CHANGED'
    and el.outcome_cd is not null
    and el.app_event_log_id = (SELECT MAX(app_event_log_id)
                               FROM app_event_log_stg s
                               WHERE s.application_id = el.application_id
                               AND s.app_individual_id = el.app_individual_id
                               AND s.outcome_cd IS NOT NULL
                               AnD s.app_event_cd = el.app_event_cd
                               AND s.app_event_log_id < end_app.app_event_log_id )    
where 1=1
--and end_app.application_id = 1500
and end_app.app_event_cd = 'STATUS_CHANGE'
and end_app.action_cd = 'END_APPLICATION_TRACKING'
and end_app.outcome_cd IS NULL)
loop
update app_event_log_stg
set outcome_cd = e.outcome_cd
    ,outcome_reason_cd = e.outcome_reason_cd
    ,program_cd = e.program_cd
    ,program_subtype_cd = e.program_subtype_cd
where app_event_log_id = e.app_event_log_id;

end loop;
end;
/


begin
for i in(
SELECT app_event_log_id
,(SELECT MIN(app_event_log_id)
  FROM app_event_log_stg s2
  WHERE s2.application_id = l.application_id
  AND s2.app_individual_id = l.app_individual_id
  AND s2.app_event_cd = 'ELIG_OUTCOME_CHANGED'
  AND s2.note like '%OutCome from%') min_event_id_outcome_chg
,(SELECT MIN(app_event_log_id)
  FROM app_event_log_stg s2
  WHERE s2.application_id = l.application_id
  AND s2.app_individual_id = l.app_individual_id
  AND s2.app_event_cd = 'ELIG_OUTCOME_CHANGED'
  AND s2.note like '%OutCome Reasons%') min_event_id_reason_chg
,(SELECT MIN(app_event_log_id)
  FROM app_event_log_stg s2
  WHERE s2.application_id = l.application_id
  AND s2.app_individual_id = l.app_individual_id
  AND s2.app_event_cd = 'ELIG_OUTCOME_CHANGED'
  AND s2.note like '%Program Code%') min_event_id_program_chg
FROM app_event_log_stg l
WHERE app_event_cd = 'ELIG_OUTCOME_CHANGED')
loop
  for x in(
SELECT app_event_log_id, CASE WHEN app_event_cd != 'ELIG_OUTCOME_CHANGED' THEN
            o.elig_outcome_cd
        ELSE
          REPLACE( CASE WHEN note like '%New record created%' THEN
                    CASE WHEN i.min_event_id_outcome_chg IS NULL THEN
                        o.elig_outcome_cd
                    ELSE
                      (SELECT  TRIM(CASE WHEN note LIKE '%OutCome from%' THEN SUBSTR(note,instr(note,'from',1)+6,instr(SUBSTR(note,instr(note,'from',1)+6),'to',1)-3 ) ELSE null END)
                       FROM  app_event_log_stg sl    
                      WHERE app_event_log_id = i.min_event_id_outcome_chg) END
                   ELSE  
                     TRIM(CASE WHEN note LIKE '%OutCome from%' THEN
                             CASE WHEN note NOT LIKE '%Program Code%' AND note NOT LIKE '%OutCome Reasons%' THEN
                                SUBSTR(note,instr(note,'to',1,1)+4,LENGTH(SUBSTR(note,instr(note,'to',1,1)+4 ))-1 )
                             ELSE
                               SUBSTR(note,instr(note,'to',1)+4,instr(SUBSTR(note,instr(note,'to',1)+4),';',1)-2 ) END ELSE null END)
                   END,'''','') 
          END to_elig_cd,
 
          CASE WHEN app_event_cd != 'ELIG_OUTCOME_CHANGED' THEN
             o.elig_outcome_reason_cd
          ELSE
            REPLACE(CASE WHEN note like '%New record created%' THEN 
                       CASE WHEN i.min_event_id_outcome_chg IS NULL THEN
                         o.elig_outcome_reason_cd
                       ELSE
                        (SELECT TRIM(CASE WHEN note LIKE '%OutCome from%' AND note LIKE '%Program Code%' THEN
                                     CASE WHEN note LIKE '%OutCome Reasons%' THEN SUBSTR(note,instr(note,'from',1,3)+6,instr(SUBSTR(note,instr(note,'from',1,3)+6),'to',1)-3 ) ELSE null END
                                          WHEN (note LIKE '%OutCome from%' AND note NOT LIKE '%Program Code%') OR (note NOT LIKE '%OutCome from%' AND note LIKE '%Program Code%') THEN
                                             CASE WHEN note LIKE '%OutCome Reasons%' THEN SUBSTR(note,instr(note,'from',1,2)+6,instr(SUBSTR(note,instr(note,'from',1,2)+6),'to',1)-3 ) ELSE null END
                                             ELSE CASE WHEN note LIKE '%OutCome Reasons%' THEN SUBSTR(note,instr(note,'from',1,1)+6,instr(SUBSTR(note,instr(note,'from',1,1)+6),'to',1)-3 ) ELSE null END END)
                         FROM app_event_log_stg
                         WHERE app_event_log_id = i.min_event_id_reason_chg)
                       END
                     ELSE 
                      TRIM(CASE WHEN note LIKE '%OutCome from%' AND note LIKE '%Program Code%' THEN
                             CASE WHEN note LIKE '%OutCome Reasons%' THEN SUBSTR(note,instr(note,'to',1,3)+4,LENGTH(SUBSTR(note,instr(note,'to',1,3)+4 ))-1 ) ELSE null END
                                  WHEN (note LIKE '%OutCome from%' AND note NOT LIKE '%Program Code%') OR (note NOT LIKE '%OutCome from%' AND note LIKE '%Program Code%') THEN
                                   CASE WHEN note LIKE '%OutCome Reasons%' THEN SUBSTR(note,instr(note,'to',1,2)+4,LENGTH(SUBSTR(note,instr(note,'to',1,2)+4 ))-1 )  ELSE null END   
                                   ELSE CASE WHEN note LIKE '%OutCome Reasons%' THEN SUBSTR(note,instr(note,'to',1,1)+4,LENGTH(SUBSTR(note,instr(note,'to',1,1)+4 ))-1 )  ELSE null END END)
                    END,'''','') 
          END to_reason_cd,
   
          CASE WHEN app_event_cd != 'ELIG_OUTCOME_CHANGED' THEN
               o.program_cd
          ELSE
            REPLACE(CASE WHEN note like '%New record created%' THEN  
                       CASE WHEN i.min_event_id_outcome_chg IS NULL THEN
                          o.program_cd
                        ELSE
                         (SELECT TRIM(CASE WHEN note NOT LIKE '%Program Code%' THEN null
                                            WHEN note LIKE '%OutCome from%' AND note LIKE '%Program Code%' THEN  SUBSTR(note,instr(note,'from',1,2)+6,instr(SUBSTR(note,instr(note,'from',1,2)+6),'to',1)-3 ) 
                                       ELSE SUBSTR(note,instr(note,'from',1)+6,instr(SUBSTR(note,instr(note,'from',1)+6),'to',1)-3 ) END) 
                           FROM app_event_log_stg
                           WHERE app_event_log_id = i.min_event_id_program_chg)
                        END
                   ELSE     
                     TRIM(CASE WHEN note NOT LIKE '%Program Code%' THEN null
                               WHEN note LIKE '%OutCome from%' AND note NOT LIKE '%OutCome Reasons%' THEN  SUBSTR(note,instr(note,'to',1,2)+4,LENGTH(SUBSTR(note,instr(note,'to',1,2)+4 ))-1 )           
                               WHEN note LIKE '%OutCome from%' AND note LIKE '%OutCome Reasons%' THEN  SUBSTR(note,instr(note,'to',1,2)+4,instr(SUBSTR(note,instr(note,'to',1,2)+4),';',1,1)-2)             
                               WHEN note NOT LIKE '%OutCome from%' AND note LIKE '%OutCome Reasons%' THEN  SUBSTR(note,instr(note,'to',1,1)+4,instr(SUBSTR(note,instr(note,'to',1,1)+4),';',1,1)-2)             
                           ELSE SUBSTR(note,instr(note,'to',1,1)+4,LENGTH(SUBSTR(note,instr(note,'to',1,1)+4 ))-1 ) END)
                   END,'''','') 
           END to_program_cd
     ,o.program_subtype_cd
FROM app_event_log_stg l
  INNER JOIN app_elig_outcome_stg o
    ON l.application_id = o.application_id
    AND l.app_individual_id = o.app_individual_id
WHERE app_event_log_id = i.app_event_log_id) loop
  update app_event_log_stg
  set outcome_cd = x.to_elig_cd
      ,outcome_reason_cd = x.to_reason_cd
      ,program_cd = x.to_program_cd
  where app_event_log_id = x.app_event_log_id;    
end loop;

end loop;
end;
/


begin
for x in(select l.app_event_log_id, o.program_subtype_cd
 FROM app_event_log_stg l
 inner join app_elig_outcome_stg o
   on l.application_id = o.application_id
   and l.app_individual_id = o.app_individual_id 
where app_event_cd = 'ELIG_OUTCOME_CHANGED' 
and o.application_id in(select application_id
                        from (select application_id,count(1)
                               from app_event_log_stg
                               where app_event_cd = 'ELIG_OUTCOME_CHANGED'
                               group by application_id
                               having count(1) = 1))
) loop
  update app_event_log_stg s
  set program_subtype_cd = x.program_subtype_cd
     ,app_status_cd = (select status_cd from app_header_stg h where s.application_id = h.application_id)
  where app_event_log_id = x.app_event_log_id;
end loop;
end;
/   

update app_event_log_stg
set outcome_cd = 'PENDING'
   ,outcome_reason_cd = 'MSP_ONLY'
   ,program_cd = 'MEDICAID'
   ,app_status_cd = 'INPROCESS'
where application_id = 10041
and rfe_status_cd = 'AWAITING_STATE_ACCEPTANCE'
and outcome_cd is null;



commit;