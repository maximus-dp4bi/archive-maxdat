--------------------------------------------------------
--  File created - Wednesday-December-14-2016   
--------------------------------------------------------
DROP VIEW "DP_SCORECARD"."SCORECARD_PROD_DP_BO_SV";
CREATE VIEW DP_SCORECARD.SCORECARD_PROD_DP_BO_SV
AS select dates, staff_id,  event_name, event_name_sort as event_sort_id, metric as productivity from dp_scorecard.sc_production_bo
where event_name='Daily Production'
UNION
select dates, staff_id,  event_name, event_name_sort as event_sort_id, metric as productivity from dp_scorecard.sc_production_bo
where event_name='Daily Adherence';
GRANT select on DP_SCORECARD.SCORECARD_PROD_DP_BO_SV to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_PROD_DP_BO_SV to MAXDAT;
