DECLARE
 v_rec        corp_etl_control%ROWTYPE;
 --
     PROCEDURE ins_upd_rec IS
        v_cnt INTEGER := 0;
     BEGIN
           SELECT  COUNT(*) INTO v_cnt
             FROM corp_etl_control  a
            WHERE a.NAME = v_rec.NAME;
           IF v_cnt = 0 THEN
              INSERT INTO corp_etl_control VALUES v_rec;
           END IF;
     END;
BEGIN
   v_rec.CREATED_TS := SYSDATE;
   v_rec.UPDATED_TS := SYSDATE;

   --*****************************************
   v_rec.NAME := 'AP_WAIT_DAYS_BEFORE_STAGE_DONE';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '2';
   v_rec.DESCRIPTION := 'Used to hold Applications for days before setting stage_done_date after processing complete';
   ins_upd_rec;
   --*****************************************


   -- Update existing records for MAXDAT 275
	
    update Nyec_Etl_Process_App
       set Stage_done_date = sysdate
     where Stage_done_date is null
       and trunc(complete_dt) <=  Trunc(sysdate) -2;

END;
/
COMMIT;