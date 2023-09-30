CREATE OR REPLACE VIEW PP_D_UNIT_OF_WORK_SV AS
SELECT UOW_ID, 
     UNIT_OF_WORK_NAME, 
     HANDLE_TIME_UNIT, 
     JEOPARDY_INV_AGE,
     LABEL	 
	 FROM PP_D_UNIT_OF_WORK
WITH READ ONLY; 

COMMIT;

/