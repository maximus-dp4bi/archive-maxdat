-- Change index to non-unique

DROP INDEX DP_SCORECARD.LWOP_IDX;

CREATE INDEX DP_SCORECARD.LWOP_IDX
ON DP_SCORECARD.SC_AUDIT_LWOP (STAFF_STAFF_ID, LWOP_OCCURRENCE_DATE)
TABLESPACE MAXDAT_DATA;


--DROP VIEW DP_SCORECARD.SC_AUDIT_LWOP_SV;

DROP VIEW DP_SCORECARD.SC_AUDIT_LWOP_SV;

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
              WHERE     TRUNC (SENIORITY_EFFECTIVE_DATE) <>
                        TO_DATE ('12/31/9999', 'MM/DD/YYYY')
                    AND TRUNC (NVL (SENIORITY_EFFECTIVE_DATE, HIRE_DATE)) >=
                        TO_DATE ('04/01/2017', 'mm/dd/yyyy')),
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
                              64
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
                              64
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


GRANT SELECT ON DP_SCORECARD.SC_AUDIT_LWOP_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_LWOP_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_LWOP_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_LWOP_SV TO MAXDAT_REPORTS;


