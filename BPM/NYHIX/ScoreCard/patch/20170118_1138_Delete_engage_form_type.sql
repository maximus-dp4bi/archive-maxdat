select 'BEFORE:', form_type_id, EVALUATION_FORM,SCORECARD_GROUP,SCORECARD_SCORE_TYPE from dp_scorecard.engage_form_type where form_type_id > 519;

delete from dp_scorecard.engage_form_type where form_type_id in (521,522);
commit;

select 'AFTER:', form_type_id, EVALUATION_FORM,SCORECARD_GROUP,SCORECARD_SCORE_TYPE from dp_scorecard.engage_form_type where form_type_id > 519;
