-- NYHIX-44403  -- Remove data script -- one time only
set define off;

delete from dp_scorecard.ENGAGE_FORM_TYPE
where create_datetime >= TRUNC(SYSDATE);

commit;
