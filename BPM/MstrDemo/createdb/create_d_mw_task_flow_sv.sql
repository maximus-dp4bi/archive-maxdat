CREATE OR REPLACE VIEW D_MW_TASK_FLOW_SV
AS
SELECT task_id
       ,task_name source_task_name
       ,age_in_business_days
       ,age_in_calendar_days
       ,mw_direction
       ,complete_date
       ,handle_time      
       ,dest_task_type destination_task_name
       ,match_flow
       ,dest_task_id destination_task_id
       ,create_date
       ,curr_claim_date claim_date
       ,timeliness_status
       ,source_process_instance_id
       ,owner_name
       ,supervisor_name
FROM (
SELECT mw.*
       ,COALESCE(flt.task_name,'END') dest_task_type
       ,CASE WHEN flt.flow_id IS NOT NULL OR COALESCE(flt.task_name,'END') = 'END' THEN 'Y' ELSE 'N' END match_flow  
FROM (SELECT mw.task_id,
        mw.task_type_id,
        instance_start_date,
        instance_end_date,
        mw.source_process_instance_id,
        tt.task_name,
        age_in_business_days,
        age_in_calendar_days,
        'TO' mw_direction,
        mw.complete_date,
        ROUND((mw.complete_date - mw.curr_claim_date) *24*60,2) handle_time,
        lead(mw.task_type_id,1) over(partition by source_process_instance_id order by instance_start_date) to_task,
        lead(mw.task_id,1) over(partition by source_process_instance_id order by instance_start_date) dest_task_id,
        mw.create_date,
        mw.curr_claim_date,
        mw.timeliness_status,
        st.first_name||CASE WHEN st.middle_name IS NULL THEN ' ' ELSE ' '||st.middle_name||' ' END||st.last_name owner_name,
        sup.first_name||CASE WHEN sup.middle_name IS NULL THEN ' ' ELSE ' '||sup.middle_name||' ' END||sup.last_name supervisor_name
      FROM D_MW_TASK_instance mw
      JOIN d_task_types tt ON mw.task_type_id = tt.task_type_id
      LEFT JOIN d_staff st ON mw.curr_owner_staff_id = st.staff_id
      LEFT JOIN d_teams t ON mw.curr_team_id = t.team_id
      LEFT JOIN d_staff sup ON t.team_supervisor_staff_id = sup.staff_id) mw
 LEFT JOIN(SELECT fl_to.flow_id,fl_to.flow_source_entity_id, fl_to.flow_destination_entity_id, tt_to.task_type_id,tt_to.task_name ,tt_fr.task_type_id fr_task_type_id
           FROM d_bpm_flow fl_to 
            JOIN d_bpm_task_type_entity te_to ON te_to.entity_id = fl_to.flow_destination_entity_id
            JOIN d_task_types tt_to ON tt_to.task_type_id = te_to.task_type_id
            JOIN d_bpm_task_type_entity te_fr ON te_fr.entity_id = fl_to.flow_source_entity_id
            JOIN d_task_types tt_fr ON tt_fr.task_type_id = te_fr.task_type_id            
            ) flt ON flt.task_type_id = mw.to_task AND flt.fr_task_type_id = mw.task_type_id
WHERE mw.complete_date IS NOT NULL            
UNION ALL
SELECT mw.*
       ,COALESCE(flr.from_task_name,'START') dest_task_type
       ,CASE WHEN flr.flow_id IS NOT NULL OR COALESCE(flr.from_task_name,'START') = 'START' THEN 'Y' ELSE 'N' END match_flow
FROM (SELECT mw.task_id,
        mw.task_type_id,
        instance_start_date,
        instance_end_date,
        mw.source_process_instance_id,
        tt.task_name,
        age_in_business_days,
        age_in_calendar_days,
        'FROM' mw_direction,
        mw.complete_date,
        ROUND((mw.complete_date - mw.curr_claim_date) *24*60,2) handle_time,
        lag(mw.task_type_id,1) over(partition by source_process_instance_id order by instance_start_date) from_task, 
        lag(mw.task_id,1) over(partition by source_process_instance_id order by instance_start_date) dest_task_id,
        mw.create_date,
        mw.curr_claim_date,
        mw.timeliness_status,
        st.first_name||CASE WHEN st.middle_name IS NULL THEN ' ' ELSE ' '||st.middle_name||' ' END||st.last_name owner_name,
        sup.first_name||CASE WHEN sup.middle_name IS NULL THEN ' ' ELSE ' '||sup.middle_name||' ' END||sup.last_name supervisor_name
      FROM D_MW_TASK_instance mw
      JOIN d_task_types tt ON mw.task_type_id = tt.task_type_id
      LEFT JOIN d_staff st ON mw.curr_owner_staff_id = st.staff_id
      LEFT JOIN d_teams t ON mw.curr_team_id = t.team_id
      LEFT JOIN d_staff sup ON t.team_supervisor_staff_id = sup.staff_id) mw
      LEFT JOIN(SELECT fl_to.flow_id, fl_to.flow_source_entity_id, fl_to.flow_destination_entity_id, tt_to.task_type_id,tt_to.task_name ,tt_fr.task_type_id fr_task_type_id,tt_fr.task_name from_task_name
                FROM d_bpm_flow fl_to 
                 JOIN d_bpm_task_type_entity te_to ON te_to.entity_id = fl_to.flow_destination_entity_id
                 JOIN d_task_types tt_to ON tt_to.task_type_id = te_to.task_type_id
                 JOIN d_bpm_task_type_entity te_fr ON te_fr.entity_id = fl_to.flow_source_entity_id
                 JOIN d_task_types tt_fr ON tt_fr.task_type_id = te_fr.task_type_id            
                ) flr ON flr.task_type_id = mw.task_type_id AND flr.fr_task_type_id = mw.from_task
      WHERE mw.complete_date IS NOT NULL
)
WHERE (task_name IN('BATCH','LINK_CLASSIFY') AND dest_task_type NOT IN('END','START') )
OR (task_name NOT IN('BATCH','LINK_CLASSIFY') AND dest_task_type != 'START');


GRANT SELECT ON D_MW_TASK_FLOW_SV TO MAXDAT_READ_ONLY; 