--This table is to get the min events from the existing dmas_application_event table
--Will be used for the v2 logic so that we can use the v2_event table going forward
CREATE OR REPLACE TABLE coverva_dmas.dmas_application_v2_min_event
(tracking_number VARCHAR NOT NULL,
 cpu_last_event TIMESTAMP_NTZ(9),
 min_cpu_submit_date TIMESTAMP_NTZ(9),
 last_date_in_file TIMESTAMP_NTZ(9), 
 last_date_in_file_mwrk TIMESTAMP_NTZ(9),
 max_file_inv_date TIMESTAMP_NTZ(9)
);

ALTER TABLE coverva_dmas.dmas_application_v2_min_event ADD primary key (tracking_number);

INSERT INTO coverva_dmas.dmas_application_v2_min_event(tracking_number,cpu_last_event,min_cpu_submit_date,last_date_in_file,last_date_in_file_mwrk,max_file_inv_date)
SELECT e.tracking_number, cpuev.cpu_last_event,mcpus.min_cpu_submit_date,ame.last_date_in_file,wrk.last_date_in_file_mwrk,fc.max_file_inv_date
FROM coverva_dmas.dmas_application_current e                        
LEFT JOIN(SELECT tracking_number,MIN(event_date) cpu_last_event 
                         FROM coverva_dmas.dmas_application_event cpue 
                         WHERE cpue.in_cpu = 'N' 
                         AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_event cpuf WHERE cpue.tracking_number = cpuf.tracking_number and cpuf.event_date > cpue.event_date and cpuf.in_cpu = 'Y') 
                         GROUP BY tracking_number) cpuev ON e.tracking_number = cpuev.tracking_number
               LEFT JOIN(SELECT tracking_number,MIN(event_date) min_cpu_submit_date 
                         FROM coverva_dmas.dmas_application_event cpue 
                         WHERE cpue.in_cpu = 'Y' AND cpu_status = 'Submitted'
                         GROUP BY tracking_number) mcpus ON e.tracking_number = mcpus.tracking_number 
               LEFT JOIN(SELECT tracking_number,MAX(event_date) last_date_in_file
                         FROM coverva_dmas.dmas_application_event ame
                         WHERE (ame.in_app_metric = 'Y' 
                         OR ame.in_ppit = 'Y' 
                         OR ame.in_app_metric_pw = 'Y'                                
                         OR ame.in_cviu = 'Y'
                         OR ame.in_cpu_incarcerated = 'Y'
                         OR ame.in_cm043 = 'Y' )  
                         AND EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_event mn JOIN public.d_dates dd ON mn.event_date = dd.d_date AND dd.project_id = 117 AND business_day_flag = 'Y'
                                      WHERE ame.tracking_number = mn.tracking_number
                                      AND mn.in_app_metric = 'N' AND mn.in_ppit = 'N' AND mn.in_app_metric_pw = 'N' AND mn.in_cviu = 'N' AND mn.in_cpu_incarcerated = 'N' AND mn.in_cm043 = 'N'
                                      AND mn.event_id > ame.event_id 
                                      AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_event my JOIN public.d_dates dd ON my.event_date = dd.d_date AND dd.project_id = 117 AND business_day_flag = 'Y'
                                                     WHERE my.tracking_number = mn.tracking_number                                    
                                                     AND (my.in_app_metric = 'Y' OR my.in_ppit = 'Y' OR my.in_app_metric_pw = 'Y' OR my.in_cviu = 'Y' OR my.in_cpu_incarcerated = 'Y' OR my.in_cm043 = 'Y') 
                                                     AND my.event_id > mn.event_id ) )
                         GROUP BY tracking_number) ame ON ame.tracking_number = e.tracking_number
              LEFT JOIN(SELECT tracking_number,MIN(event_date) last_date_in_file_mwrk
                         FROM coverva_dmas.dmas_application_event wrk
                         WHERE ( (wrk.in_app_metric = 'Y' AND (REGEXP_INSTR(am_worker, '900') = 0) )
                         OR (wrk.in_ppit = 'Y' AND (REGEXP_INSTR(ppit_worker, '900') = 0) )                         
                         OR (wrk.in_cviu = 'Y'AND (REGEXP_INSTR(cviu_worker, '900') = 0) ) 
                         OR (wrk.in_cpu_incarcerated = 'Y' AND ( REGEXP_INSTR(cpui_worker, '900') = 0) )        )                        
                         GROUP BY tracking_number) wrk ON wrk.tracking_number = e.tracking_number   
 LEFT JOIN (SELECT e.tracking_number,MIN(event_date) max_file_inv_date
            FROM coverva_dmas.dmas_application_event e
              LEFT JOIN PUBLIC.D_DATES dd on e.event_date = dd.d_date AND dd.project_id = 117
            WHERE business_day_flag = 'Y'
            AND ( ( (in_app_metric = 'N' AND in_ppit = 'N' AND in_app_metric_pw = 'N' AND in_cviu = 'N' AND in_cpu_incarcerated = 'N' AND in_cm043 = 'N')
            AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_event en WHERE e.tracking_number = en.tracking_number 
                            AND (en.in_app_metric = 'Y' OR en.in_ppit = 'Y' OR en.in_app_metric_pw = 'Y' OR en.in_cviu = 'Y' OR en.in_cpu_incarcerated = 'Y' OR en.in_cm043 = 'Y') AND en.event_id > e.event_id)
            AND (in_running_am = 'Y' OR in_running_ppit = 'Y' OR in_running_pw = 'Y' OR in_running_cviu = 'Y' OR in_running_cpui = 'Y' OR in_running_cm043 = 'Y') )            
             OR ( (e.in_app_metric = 'Y' AND (REGEXP_INSTR(e.am_worker, '900') = 0) )
                         OR (e.in_ppit = 'Y' AND (REGEXP_INSTR(e.ppit_worker, '900') = 0) )                         
                         OR (e.in_cviu = 'Y'AND (REGEXP_INSTR(e.cviu_worker, '900') = 0) ) 
                         OR (e.in_cpu_incarcerated = 'Y' AND ( REGEXP_INSTR(e.cpui_worker, '900') = 0) ) ) )
            GROUP BY e.tracking_number) fc ON e.tracking_number = fc.tracking_number   ;  