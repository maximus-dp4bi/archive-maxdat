
---- NYHIX-39601 

update dp_scorecard.ENGAGE_ACTUALS set deleted_flag=null
where EVALUATION_REFERENCE_ID in (select EVALUATION_REFERENCE_ID from
dp_scorecard.ENGAGE_ACTUALS a
JOIN dp_scorecard.Engage_form_type a1
ON a.EVALUATION_FORM = a1.EVALUATION_FORM
WHERE a1.SCORECARD_GROUP = 'FPBP'
AND trunc(LAST_UPDATE_DATE) =  '08-MAR-2018');
commit;