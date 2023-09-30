--DROP VIEW DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV;

/* Formatted on 10/24/2018 1:01:54 PM (QP5 v5.326) */
CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV
(
    SEARCH_STAFF_ID,
    MANAGER_STAFF_ID,
    MANAGER_NAME,
    SUPERVISOR_STAFF_ID,
    SUPERVISOR_NAME,
    STAFF_STAFF_ID,
    STAFF_STAFF_NAME,
    STAFF_NATID,
    PT_ID,
    PT_ENTRY_DATE,
    DL_ID,
    DISCUSSION_TOPIC,
    COMMENTS,
    CREATE_BY,
    CREATE_DATETIME,
    LAST_UPDATED_BY,
    LAST_UPDATED_DATETIME,
    DELAY_BUSINESS_DAYS
)
BEQUEATH DEFINER
AS
    SELECT pt.STAFF_ID
               AS SEARCH_staff_id,
           sh.manager_staff_id,
           sh.manager_name,
           sh.supervisor_staff_id,
           sh.supervisor_name,
           sh.staff_staff_id,
           sh.staff_staff_name,
           sh.staff_natid,
           pt.pt_id,
           pt.pt_entry_date,
           pt.dl_id,
           dl.discussion_topic,
           pt.comments,
           pt.create_by,
           pt.create_datetime,
           pt.last_updated_by,
           pt.LAST_UPDATED_DATETIME,
           -- Be sure MAXDAT has done the grant execute, debug on bus_days_between to dp_scorecard with grant option
           MAXDAT.BUS_DAYS_BETWEEN (pt.pt_entry_date, pt.CREATE_DATETIME)
               AS DELAY_BUSINESS_DAYS
      FROM dp_scorecard.sc_performance_tracker  pt
           JOIN dp_scorecard.sc_discussion_lkup dl ON pt.dl_id = dl.dl_id
           LEFT OUTER JOIN
           (SELECT staff_staff_id     AS SEARCH_staff_id,
                   manager_staff_id,
                   manager_name,
                   supervisor_staff_id,
                   supervisor_natid,
                   supervisor_name,
                   staff_staff_id,
                   staff_staff_name,
                   staff_natid
              FROM dp_scorecard.scorecard_hierarchy
            UNION
            SELECT supervisor_staff_id     AS SEARCH_staff_id,
                   manager_staff_id,
                   manager_name,
                   supervisor_staff_id,
                   supervisor_natid,
                   supervisor_name,
                   NULL                    AS staff_staff_id,
                   NULL                    AS staff_staff_name,
                   NULL                    AS staff_natid
              FROM dp_scorecard.scorecard_hierarchy) sh
               ON pt.staff_id = sh.SEARCH_staff_id;
/

show errors			   


GRANT SELECT ON DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV TO DP_SCORECARD_READ_ONLY;

