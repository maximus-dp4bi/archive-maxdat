update DP_SCORECARD.engage_form_type set end_date = null
where end_date is not null;
commit;