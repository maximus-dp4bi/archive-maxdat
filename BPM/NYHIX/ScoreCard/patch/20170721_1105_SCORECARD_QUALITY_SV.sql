CREATE or replace VIEW DP_SCORECARD.SCORECARD_QUALITY_SV
AS 
SELECT 
	-- Modified for NYSOH - Scorecard - CR 1662 - QC Table Update 
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
	ST.LAST_NAME||', '||ST.FIRST_NAME EVALUATOR
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
AND TRUNC(EVALUATION_DATE_TIME) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM');

grant select on DP_SCORECARD.SCORECARD_QUALITY_SV to MAXDAT_READ_ONLY;	

grant SELECT on DP_SCORECARD.SCORECARD_QUALITY_SV to DP_SCORECARD_READ_ONLY;	


