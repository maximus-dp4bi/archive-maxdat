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
   v_rec.NAME := 'STEP_INST_HIST_MISSING_REC_LOOKBACK';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '90000';
   v_rec.DESCRIPTION := 'Used to set number of task history to look back and catch missing records ';
   ins_upd_rec;
 --*****************************************

   v_rec.NAME := 'CC_EVENT_STG_CAPTURE_EVENT_ID';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '0';
   v_rec.DESCRIPTION := 'The event table will look at this table to see when to start and also update by event id';
   ins_upd_rec;

END;
/
COMMIT;


