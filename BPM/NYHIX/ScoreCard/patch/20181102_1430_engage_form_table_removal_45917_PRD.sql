-- NYHIX-45917
SELECT 'Before record deletion', eft.*
FROM   dp_scorecard.ENGAGE_FORM_TYPE eft
WHERE  eft.form_type_id IN (686,687,702,703);

DELETE FROM dp_scorecard.ENGAGE_FORM_TYPE
WHERE  form_type_id IN (686,687,702,703);

COMMIT;

SELECT 'After record deletion', eft.*
FROM   dp_scorecard.ENGAGE_FORM_TYPE eft
WHERE  eft.form_type_id IN (686,687,702,703);
