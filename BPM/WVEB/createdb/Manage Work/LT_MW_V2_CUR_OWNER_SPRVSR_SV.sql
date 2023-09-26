CREATE OR REPLACE VIEW LT_MW_V2_CUR_OWNER_SPRVSR_SV
AS
  SELECT a.TASK_ID,
    NVL(a.CURR_OWNER_STAFF_ID, -9999) AS CURR_OWNER_STAFF_ID,
    NVL(c.TEAM_SUPERVISOR_STAFF_ID, -99999) AS TEAM_SUPERVISOR_STAFF_ID
  FROM
    (SELECT
      (SELECT ext_staff_number 
      FROM staff 
      WHERE ext_staff_number = SI.OWNER
      UNION
      SELECT TO_CHAR(staff_id) 
      FROM staff 
      WHERE TO_CHAR(staff_id) = SI.OWNER
      ) AS curr_owner_staff_id ,
      SI.TEAM_ID AS curr_team_id ,
      SI.STEP_INSTANCE_ID AS TASK_ID
    FROM STEP_INSTANCE SI
    LEFT OUTER JOIN step_definition sd ON si.step_definition_id = sd.step_definition_id
    WHERE sd.step_type_cd IN ('VIRTUAL_HUMAN_TASK','HUMAN_TASK')
    AND (si.create_ts>=add_months(TRUNC(sysdate,'mm'),-8)
    OR status NOT IN('TERMINATED','COMPLETED') )
    ) a
    --join d_staff b on (a.CURR_OWNER_STAFF_ID = b.staff_id)
  LEFT JOIN
    (SELECT group_id team_id, 
            group_name team_name, 
            description team_description, 
            COALESCE(supervisor_staff_id,0) AS team_supervisor_staff_id 
            FROM GROUPS 
            WHERE type_cd = 'TEAM'
    ) c ON (a.CURR_TEAM_ID = c.TEAM_ID) --and
    --(c.TEAM_SUPERVISOR_STAFF_ID = a.CURR_OWNER_STAFF_ID)
  LEFT JOIN
    (SELECT STAFF_ID , 
            EXT_STAFF_NUMBER , 
            DOB , 
            SSN , 
            FIRST_NAME , 
            FIRST_NAME_CANON , 
            FIRST_NAME_SOUND_LIKE , 
            GENDER_CD , 
            START_DATE , 
            END_DATE , 
            PHONE_NUMBER , 
            LAST_NAME , 
            LAST_NAME_CANON , 
            LAST_NAME_SOUND_LIKE , 
            CREATED_BY , 
            CREATE_TS , 
            UPDATED_BY , 
            UPDATE_TS , 
            MIDDLE_NAME , 
            MIDDLE_NAME_CANON , 
            MIDDLE_NAME_SOUND_LIKE , 
            EMAIL , 
            FAX_NUMBER , 
            NOTE_REFID , 
            DEPLOYMENT_STAFF_NUM , 
            DEFAULT_GROUP_ID , 
            STAFF_TYPE_CD , 
            UNIQUE_STAFF_ID , 
            VOID_IND 
            FROM STAFF
    ) d ON (c.TEAM_SUPERVISOR_STAFF_ID = d.staff_id) ; 
    
    GRANT SELECT ON MAXDAT_LOOKUP.LT_MW_V2_CUR_OWNER_SPRVSR_SV TO EB_MAXDAT_REPORTS ;
