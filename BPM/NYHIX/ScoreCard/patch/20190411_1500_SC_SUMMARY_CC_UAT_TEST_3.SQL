set timing on
set serveroutput on size 20000

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_QUALITY_SV
(STAFF_STAFF_ID, STAFF_STAFF_NAME, STAFF_NATID, SCORECARD_SCORE_TYPE, SCORE_TOTAL, 
 EVAL_DATE, EVALUATION_REFERENCE, EVALUATOR_ID, EVALUATOR, EVALUATION_DATE_TIME, 
 CALL_DATE)
BEQUEATH DEFINER
AS 
SELECT
	-- Modified for NYSOH - Scorecard - CR 1662 - QC Table Update
	-- Modified for NYHIX-42454 CR 1822- Scorecard Quality tab Evaluation date
	S.staff_staff_id,
	S.staff_staff_name,
	S.staff_natid,
	F.SCORECARD_SCORE_TYPE,
	E.SCORE_TOTAL,
	Case when (e.call_date is null
		or e.call_date = to_date('1/1/1753','mm/dd/yyyy')
		)
		then E.EVALUATION_DATE_TIME
		else e.call_date end as EVAL_DATE,
	E.EVALUATION_REFERENCE,
	E.evaluator_id,
	ST.LAST_NAME||', '||ST.FIRST_NAME EVALUATOR,
	E.EVALUATION_DATE_TIME,
	E.CALL_DATE
FROM dp_scorecard.scorecard_hierarchy_sv S
JOIN DP_SCORECARD.ENGAGE_ACTUALS_SV E
	ON S.staff_natid = E.AGENT_ID
JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F
	ON E.EVALUATION_FORM = F.EVALUATION_FORM
LEFT JOIN (
 select distinct national_id, LAST_NAME, FIRST_NAME
        from MAXDAT.PP_WFM_STAFF
        where delete_date is null
        and (national_id, last_update_dt)
        in ( select national_id, max(last_update_dt)
            from MAXDAT.PP_WFM_STAFF
            where delete_date is null
            group by national_id
           )
 ) ST
	ON ST.NATIONAL_ID = E.EVALUATOR_ID
WHERE F.SCORECARD_SCORE_TYPE = 'QC'
AND TRUNC(EVALUATION_DATE_TIME) >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
;

exec DP_SCORECARD.LOAD_SC_SUMMARY_CC();

create table dp_scorecard.wfl_sc_summary_cc_47593_test3 
as select * from dp_scorecard.sc_summary_cc;

grant select on dp_scorecard.wfl_sc_summary_cc_47593_test3 to dp_scorecard_read_only;

grant select on dp_scorecard.wfl_sc_summary_cc_47593_test3 to maxdat_read_only;

