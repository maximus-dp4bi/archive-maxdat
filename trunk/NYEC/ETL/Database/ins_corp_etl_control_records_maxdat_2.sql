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
   v_rec.NAME := 'AP_PROCESS_DAYS';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '3';
   v_rec.DESCRIPTION := 'Used to get applications worked in calendar days, 0 for current day worked applications and 1 for Yesterday and so forth';
    ins_upd_rec;

   --*****************************************
   v_rec.NAME := 'AP_SLA_DAYS_TYPE';
   v_rec.VALUE_TYPE := 'V';
   v_rec.VALUE := 'B';
   v_rec.DESCRIPTION := 'Used to calculate SLA Days TYPE, N is none, B is Busisness, C is Calendar.';
    ins_upd_rec;

   --*****************************************
   -- Update 'AP_LAST_APPLICATION_ID' to Zero for Initial Load
	
   Update corp_etl_control
      set Value = 0
    where Name = 'AP_LAST_APPLICATION_ID';


END;
/
COMMIT;

SELECT * FROM corp_etl_control;

