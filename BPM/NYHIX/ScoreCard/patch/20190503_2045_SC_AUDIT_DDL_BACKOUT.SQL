-- DROP VIEW DP_SCORECARD.SC_AUDIT_LWOP_SV;

/* Formatted on 4/25/2019 3:39:06 PM (QP5 v5.326) */
CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_LWOP_SV
(
    LWOP_INSTANCE_ID,
    UPDATED_BY_NATID,
    STAFF_STAFF_ID,
    HIRE_DATE,
    LWOP_OCCURRENCE_DATE,
    LWOP_HOURS,
    START_DATE,
    LWOP_LIMIT,
    LWOP_BALANCE,
    MESSAGE
)
BEQUEATH DEFINER
AS
    WITH
        SCH
        AS
            (SELECT STAFF_ID
                        AS STAFF_STAFF_ID,
                    TRUNC (NVL (SENIORITY_EFFECTIVE_DATE, HIRE_DATE))
                        AS HIRE_DATE
               FROM DP_SCORECARD.SC_HIERARCHY_STAFF
              WHERE TRUNC (SENIORITY_EFFECTIVE_DATE) <>
                    TO_DATE ('12/31/9999', 'MM/DD/YYYY')),
        LWOP_DATA
        AS
            (  SELECT lwop_instance_id,
                      SUPERVISOR_NATID,
                      STAFF_STAFF_ID,
                      HIRE_DATE,
                      LWOP_OCCURRENCE_DATE,
                      START_DATE,
                      CASE
                          WHEN LWOP_OCCURRENCE_DATE BETWEEN TRUNC (HIRE_DATE)
                                                        AND (  ADD_MONTHS (
                                                                   TRUNC (
                                                                       HIRE_DATE),
                                                                   +12)
                                                             - (  1
                                                                / (24 * 60 * 60)))
                          THEN
                              56
                          WHEN LWOP_OCCURRENCE_DATE BETWEEN TRUNC (HIRE_DATE)
                                                        AND (  ADD_MONTHS (
                                                                   TRUNC (
                                                                       HIRE_DATE),
                                                                   +24)
                                                             - (  1
                                                                / (24 * 60 * 60)))
                          THEN
                              40
                          ELSE
                              0
                      END
                          AS LWOP_LIMIT,
                      SUM (LWOP_HOURS)
                          AS LWOP_HOURS,
                      MESSAGE
                 FROM (SELECT L.LWOP_INSTANCE_ID,
                              L.LWOP_UPDATE_USER
                                  AS SUPERVISOR_NATID,
                              SCH.STAFF_STAFF_ID,
                              SCH.HIRE_DATE,
                              -------------
                              CASE
                                  WHEN TRUNC (LWOP_OCCURRENCE_DATE) <
                                       TRUNC (HIRE_DATE)
                                  THEN
                                      TRUNC (LWOP_OCCURRENCE_DATE)
                                  WHEN LWOP_OCCURRENCE_DATE BETWEEN TRUNC (
                                                                        HIRE_DATE)
                                                                AND (  ADD_MONTHS (
                                                                           TRUNC (
                                                                               HIRE_DATE),
                                                                           +12)
                                                                     - (  1
                                                                        / (  24
                                                                           * 60
                                                                           * 60)))
                                  THEN
                                      HIRE_DATE
                                  WHEN LWOP_OCCURRENCE_DATE BETWEEN ADD_MONTHS (
                                                                        TRUNC (
                                                                            HIRE_DATE),
                                                                        +12)
                                                                AND (  ADD_MONTHS (
                                                                           TRUNC (
                                                                               HIRE_DATE),
                                                                           +24)
                                                                     - (  1
                                                                        / (  24
                                                                           * 60
                                                                           * 60)))
                                  THEN
                                      ADD_MONTHS (TRUNC (HIRE_DATE), +12)
                                  ELSE
                                      ADD_MONTHS (TRUNC (HIRE_DATE), +24)
                              END
                                  AS START_DATE,
                              --------------
                              NVL (L.LWOP_OCCURRENCE_DATE, SCH.hire_date)
                                  AS LWOP_OCCURRENCE_DATE,
                              L.LWOP_HOURS,
                              'LWOP Hours Used'
                                  AS MESSAGE
                         FROM SCH
                              --    LEFT OUTER JOIN SC_AUDIT_LWOP L
                              JOIN DP_SCORECARD.SC_AUDIT_LWOP L
                                  ON L.STAFF_STAFF_ID = SCH.STAFF_STAFF_ID
                       UNION ALL                               -- INITIAL HIRE
                       SELECT -1,
                              NULL
                                  AS SUPERVISOR_NATID,
                              STAFF_STAFF_ID,
                              HIRE_DATE,
                              TRUNC (hire_date)
                                  AS start_date,
                              HIRE_DATE
                                  AS LWOP_OCCURRENCE_DATE,
                              0
                                  AS LWOP_HOURS,
                              'Permanent Hire Date - 1st Year Balance'
                                  AS MESSAGE
                         FROM SCH H
                       UNION ALL                       -- One Year Annaversary
                       SELECT -1,
                              NULL
                                  AS SUPERVISOR_NATID,
                              STAFF_STAFF_ID,
                              HIRE_DATE,
                              ADD_MONTHS (TRUNC (HIRE_DATE), +12)
                                  AS start_date,
                              ADD_MONTHS (TRUNC (HIRE_DATE), +12)
                                  AS LWOP_OCCURRENCE_DATE,
                              0
                                  AS LWOP_HOURS,
                              'Permanent Hire Date - 2nd Year Balance'
                                  AS MESSAGE
                         FROM SCH
                        WHERE    TRUNC (SYSDATE) >=
                                 ADD_MONTHS (TRUNC (HIRE_DATE), +12)
                              OR STAFF_STAFF_ID IN
                                     (SELECT STAFF_STAFF_ID
                                        FROM DP_SCORECARD.SC_AUDIT_LWOP
                                       WHERE TRUNC (LWOP_OCCURRENCE_DATE) >=
                                             ADD_MONTHS (TRUNC (HIRE_DATE),
                                                         +12))
                       UNION ALL                    -- Second year Annaversary
                       SELECT -1,
                              NULL
                                  AS SUPERVISOR_NATID,
                              STAFF_STAFF_ID,
                              HIRE_DATE,
                              ADD_MONTHS (TRUNC (HIRE_DATE), +24)
                                  AS start_date,
                              ADD_MONTHS (TRUNC (HIRE_DATE), +24)
                                  AS LWOP_OCCURRENCE_DATE,
                              0
                                  AS LWOP_HOURS,
                              'Permanent Hire Date - 3rd and Subsequent Year Balance'
                                  AS MESSAGE
                         FROM SCH
                        WHERE    TRUNC (SYSDATE) >=
                                 ADD_MONTHS (TRUNC (HIRE_DATE), +24)
                              OR STAFF_STAFF_ID IN
                                     (SELECT STAFF_STAFF_ID
                                        FROM DP_SCORECARD.SC_AUDIT_LWOP
                                       WHERE TRUNC (LWOP_OCCURRENCE_DATE) >=
                                             ADD_MONTHS (TRUNC (HIRE_DATE),
                                                         +24)))
             GROUP BY lwop_instance_id,
                      SUPERVISOR_NATID,
                      STAFF_STAFF_ID,
                      HIRE_DATE,
                      start_date,
                      LWOP_OCCURRENCE_DATE,
                      CASE
                          WHEN LWOP_OCCURRENCE_DATE BETWEEN TRUNC (hire_date)
                                                        AND (  ADD_MONTHS (
                                                                   TRUNC (
                                                                       HIRE_DATE),
                                                                   +12)
                                                             - (  1
                                                                / (  24
                                                                   * 60
                                                                   * 60)))
                          THEN
                              56
                          WHEN LWOP_OCCURRENCE_DATE BETWEEN TRUNC (hire_date)
                                                        AND (  ADD_MONTHS (
                                                                   TRUNC (
                                                                       HIRE_DATE),
                                                                   +24)
                                                             - (  1
                                                                / (  24
                                                                   * 60
                                                                   * 60)))
                          THEN
                              40
                          ELSE
                              0
                      END,
                      MESSAGE),
        LWOP_BALANCE
        AS
            (  SELECT lwop_instance_id,
                      supervisor_natid,
                      STAFF_STAFF_ID,
                      TRUNC (HIRE_DATE)
                          AS HIRE_DATE,
                      TRUNC (LWOP_OCCURRENCE_DATE)
                          AS LWOP_OCCURRENCE_DATE,
                      LWOP_HOURS,
                      TRUNC (START_DATE)
                          AS START_DATE,
                      LWOP_LIMIT,
                      MESSAGE,
                      -- calculate the balance
                      SUM (LWOP_HOURS)
                          OVER (PARTITION BY STAFF_STAFF_ID, START_DATE
                                ORDER BY
                                    STAFF_STAFF_ID,
                                    start_date,
                                    LWOP_OCCURRENCE_DATE,
                                    lwop_instance_id)
                          total_used
                 FROM LWOP_DATA
                WHERE LWOP_OCCURRENCE_DATE IS NOT NULL
             GROUP BY lwop_instance_id,
                      supervisor_natid,
                      STAFF_STAFF_ID,
                      TRUNC (HIRE_DATE),
                      TRUNC (start_date),
                      TRUNC (LWOP_OCCURRENCE_DATE),
                      LWOP_HOURS,
                      TRUNC (START_DATE),
                      LWOP_LIMIT,
                      STAFF_STAFF_ID,
                      HIRE_DATE,
                      LWOP_OCCURRENCE_DATE,
                      LWOP_HOURS,
                      START_DATE,
                      MESSAGE)
      SELECT LB.LWOP_INSTANCE_ID,
             SUPERVISOR_NATID
                 AS UPDATED_BY_NATID,
             LB.STAFF_STAFF_ID,
             LB.HIRE_DATE,
             LB.LWOP_OCCURRENCE_DATE,
             LB.LWOP_HOURS,
             LB.START_DATE,
             LB.LWOP_LIMIT,
             (LB.LWOP_LIMIT - LB.total_used)
                 LWOP_BALANCE,
             CASE
                 WHEN    (NVL (LB.LWOP_LIMIT - LB.total_used, 0) < 0)
                      OR (LB.LWOP_HOURS = 0 AND LB.LWOP_INSTANCE_ID > 0)
                 THEN
                     'Balance Cannot be Negative'
                 WHEN (LB.LWOP_HOURS IS NULL AND LB.LWOP_INSTANCE_ID > 0)
                 THEN
                     'Error: LWOP Hours used do not meet criteria'
                 ELSE
                     MESSAGE
             END
                 AS MESSAGE
        FROM LWOP_BALANCE LB
    ORDER BY STAFF_STAFF_ID,
             HIRE_DATE,
             LWOP_OCCURRENCE_DATE,
             lwop_instance_id;


GRANT INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_LWOP_SV TO DP_SCORECARD_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_LWOP_SV TO DP_SCORECARD_OLTP_SIUD;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_LWOP_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_LWOP_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_LWOP_SV TO MAXDAT_MSTR_TRX_RPT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_LWOP_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_LWOP_SV TO MAXDAT_REPORTS;


CREATE OR REPLACE Procedure DP_SCORECARD.INSERT_SC_AUDIT_LWOP
   ( in_staff_id in number
   , in_hours in number
   , in_date in date
   , in_NATIONAL_ID in NUMBER )


AS
   V_USERNAME VARCHAR2(100);

   LV_NEGATIVE_BALANCE_FOUND  NUMBER(5) := 0;
   LV_HOURS   NUMBER(3,1)  := 0;

   lv_err_code varchar2(50) := null;
   lv_err_msg  varchar2(200) := null;


BEGIN


   LV_NEGATIVE_BALANCE_FOUND := 0;

    IF  IN_STAFF_ID IS NULL
    OR IN_HOURS IS NULL OR IN_HOURS < 0
    OR IN_DATE IS NULL
    OR IN_NATIONAL_ID IS NULL
    OR IN_DATE < TRUNC(SYSDATE-7)
        THEN
        /*do nothing*/
        NULL;
    ELSE

      --get username
        select name into v_username from
        (
        SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=in_NATIONAL_ID
        UNION
        SELECT director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT supervisor_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
        );

        LV_HOURS := IN_HOURS;

        IF LV_HOURS <> IN_HOURS
        OR LV_HOURS < 0
        OR LV_HOURS > 99.9
            THEN LV_HOURS := NULL;
        END IF;


        INSERT INTO DP_SCORECARD.SC_AUDIT_LWOP
        (STAFF_STAFF_ID,
          LWOP_OCCURRENCE_DATE,
          LWOP_HOURS,
          LWOP_CREATE_USER,
          LWOP_CREATE_DATE,
          LWOP_UPDATE_USER,
          LWOP_UPDATE_DATE
		)
        VALUES
        (IN_STAFF_ID,
         TRUNC(IN_DATE),
         LV_HOURS,
         V_USERNAME,
         SYSDATE,
         V_USERNAME,
         SYSDATE);

        SELECT COUNT(*) INTO LV_NEGATIVE_BALANCE_FOUND
        FROM dp_scorecard.SC_AUDIT_LWOP_SV
        WHERE STAFF_STAFF_ID = in_staff_id
        AND LWOP_BALANCE < 0;

        IF LV_NEGATIVE_BALANCE_FOUND = 0
        THEN
            COMMIT;
        ELSE
            ROLLBACK;

            INSERT INTO DP_SCORECARD.SC_AUDIT_LWOP
                (STAFF_STAFF_ID,
                LWOP_OCCURRENCE_DATE,
                LWOP_HOURS,
                LWOP_CREATE_USER,
                LWOP_CREATE_DATE,
                LWOP_UPDATE_USER,
                LWOP_UPDATE_DATE
                )
            VALUES
                (IN_STAFF_ID,
                TRUNC(IN_DATE),
                0, --in_hours,
                V_USERNAME,
                SYSDATE,
                V_USERNAME,
                SYSDATE);

            -- COMMIT;

        END IF;



        COMMIT;

    END IF;

EXCEPTION

    -- PER SPCIFICATIONS DO NOT RAISE AN ERROR
    -- BECAUSE MICRO STARTEGY WILL CRASH

    WHEN OTHERS THEN


        NULL;


END;
/

show errors

CREATE OR REPLACE Procedure DP_SCORECARD.Update_SC_AUDIT_LWOP
   ( IN_STAFF_ID            IN NUMBER,
    IN_LWOP_INSTANCE_ID     IN NUMBER,
    IN_DELETE_FLAG          IN NUMBER,
    IN_NATIONAL_ID          IN NUMBER,
    IN_HOURS                IN NUMBER )


AS

    LV_USER_COUNT  NUMBER(5) := 0;

    LV_NEGATIVE_BALANCE_FOUND  NUMBER(5) := 0;
    LV_HOURS   NUMBER(3,1)  := 0;

    LV_LWOP_DATE  DATE := SYSDATE;

    LV_ERR_CODE VARCHAR2(50) := NULL;
    LV_ERR_MSG  VARCHAR2(200) := NULL;


BEGIN


    LV_USER_COUNT  := 0;
    LV_NEGATIVE_BALANCE_FOUND := 0;

        select count(*) into lv_user_count from
        (
        SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=in_NATIONAL_ID
        UNION
        SELECT director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT supervisor_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
        );

    IF NVL(LV_USER_COUNT,0) = 0
        THEN
            RETURN;
    END IF;

    SELECT LWOP_OCCURRENCE_DATE INTO LV_LWOP_DATE
    FROM SC_AUDIT_LWOP
    WHERE  STAFF_STAFF_ID=IN_STAFF_ID
    AND LWOP_INSTANCE_ID = IN_LWOP_INSTANCE_ID;

    IF IN_DELETE_FLAG = 1
    AND LV_LWOP_DATE > TRUNC(SYSDATE - 7)
        THEN
            DELETE FROM DP_SCORECARD.SC_AUDIT_LWOP  WHERE STAFF_STAFF_ID=IN_STAFF_ID AND LWOP_INSTANCE_ID = IN_LWOP_INSTANCE_ID;

            COMMIT;

            RETURN;
    END IF;

    RETURN;

    -------------------------------------------------
    -- MICRO STRATEGEY DOES NOT ALLOW AN UPDATE
    -- THE FOLLWOING CODE IS NOT USED AT THIS TIME
    -------------------------------------------------

        LV_HOURS := IN_HOURS;

        IF LV_HOURS <> IN_HOURS
            OR LV_HOURS < 0
            OR LV_HOURS > 99.9
        THEN LV_HOURS := NULL;
        END IF;


    --    UPDATE DP_SCORECARD.SC_AUDIT_LWOP
    --    SET LWOP_HOURS		= 	LV_HOURS,
    --        LWOP_UPDATE_DATE    	=	sysdate,
    --        LWOP_UPDATE_USER    	=	v_username
    --    WHERE LWOP_INSTANCE_ID = IN_LWOP_INSTANCE_ID;
	--	  AND IN_HOURS >= 0;

        SELECT COUNT(*) INTO LV_NEGATIVE_BALANCE_FOUND
        FROM dp_scorecard.SC_AUDIT_LWOP_SV
        WHERE STAFF_STAFF_ID = in_staff_id
        AND LWOP_BALANCE < 0;

        IF LV_NEGATIVE_BALANCE_FOUND = 0
        THEN
            COMMIT;
        ELSE
            ROLLBACK;

        -- UPDATE DP_SCORECARD.SC_AUDIT_LWOP
        -- SET LWOP_HOURS		= 	IN_HOURS,
        --    LWOP_UPDATE_DATE    	=	sysdate,
        --    LWOP_UPDATE_USER    	=	v_username
        -- WHERE LWOP_INSTANCE_ID = IN_LWOP_INSTANCE_ID
		--  AND IN_HOURS >= 0;

        -- COMMIT;

        END IF;

        COMMIT;


EXCEPTION

    -- PER SPCIFICATIONS DO NOT RAISE AN ERROR
    -- BECAUSE MICRO STARTEGY WILL CRASH

    WHEN OTHERS THEN



        NULL;


END;
/

show errors