CREATE OR REPLACE VIEW PUBLIC.D_USER_SV AS
SELECT   u.user_id
        ,u.database
        ,u.project_id                       AS  user_project_id
        ,s.staff_id
        ,s.email
        ,s.is_maximus_internal_employee
        ,s.first_name
        ,s.last_name
        ,s.middle_name
        ,s.staff_type_code
        ,s.date_of_birth
        ,s.phone_number
        ,s.maximus_id
        ,t.team_id
        ,t.project_id                       AS  team_project_id
        ,t.team_name
        ,bu.project_id                      AS  business_unit_project_id
        ,bu.business_unit_id
        ,bu.business_unit_name 
 FROM   MARSDB.MARSDB_USER_VW   u
        LEFT JOIN
        MARSDB.MARSDB_TEAM_USER_VW  tu
        ON
        (
                u.user_id = tu.user_id
            AND u.project_id = tu.project_id
            and tu.effective_end_date is null
        )
        LEFT JOIN
        MARSDB.MARSDB_TEAM_VW   t
        ON
        (
                tu.team_id = t.team_id
            AND tu.project_id = t.project_id
            and t.effective_end_date is null
        )
        LEFT JOIN
        MARSDB.MARSDB_BUSINESS_UNIT_VW  bu
        ON
        (
                t.business_unit_id = bu.business_unit_id
            AND t.project_id = bu.project_id
            and bu.effective_end_date is null
        )
        LEFT JOIN 
        MARSDB.MARSDB_STAFF_VW  s 
        ON 
        (
                u.staff_id = s.staff_id
        );