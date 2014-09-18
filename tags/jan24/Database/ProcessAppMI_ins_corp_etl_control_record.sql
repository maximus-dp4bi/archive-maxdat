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
   v_rec.NAME := 'AP_LAST_MI_ID';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '0';
   v_rec.DESCRIPTION := 'Used to fetch Application Missing Info from OLTP for AP MI process.';
   ins_upd_rec;
 --*****************************************

END;
/
COMMIT;


