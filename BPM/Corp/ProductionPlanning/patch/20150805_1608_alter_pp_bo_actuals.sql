alter table pp_bo_actuals
add (work_activity varchar2(4000), annotation varchar2(4000));

CREATE OR REPLACE VIEW PP_BO_ACTUALS_SV AS
SELECT * FROM PP_BO_ACTUALS
WITH READ ONLY; 


COMMIT;
/