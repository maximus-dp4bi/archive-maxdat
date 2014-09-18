BEGIN
    FOR tmp_cur IN (
                           SELECT distinct sis.step_instance_id, sis.team_id, g.group_id,g.group_name, 
                            g.supervisor_staff_id, s.Staff_id,s.First_Name
                           ,s.display_name
                           ,mw.team_supervisor_name
                      FROM corp_etl_manage_work  mw
                          ,step_instance_stg sis
                          ,staff_lkup        s
                          ,groups_stg        g
                     WHERE mw.task_id = sis.step_instance_id
                       AND sis.team_id = g.group_id (+)
                       AND to_char(g.supervisor_staff_id) = s.staff_id(+)
                       AND nvl(mw.team_supervisor_name,'u') <> nvl(s.display_name,'u')
                       and sis.step_instance_history_id in (select max(sis2.step_instance_history_id) 
                                                            from step_instance_stg sis2 
                                                            where sis2.step_instance_id = sis.step_instance_id) 
                       AND mw.stage_done_date IS NULL
                       order by 1 )
    LOOP
        --dbms_output.put_line(tmp_cur.step_instance_id||' At #1 cur: '||tmp_cur.team_supervisor_name);
        --dbms_output.put_line(tmp_cur.step_instance_id||' At #1 new: '||tmp_cur.display_name);
        UPDATE corp_etl_manage_work 
        SET team_supervisor_name = tmp_cur.display_name
        WHERE task_id = tmp_cur.step_instance_id;
        commit; 
    END LOOP;
END;
/
