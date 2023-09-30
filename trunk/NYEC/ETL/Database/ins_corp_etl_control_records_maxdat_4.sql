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
   v_rec.NAME := 'IR_LAST_APPLICATION_ID';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '0';
   v_rec.DESCRIPTION := 'Used to fetch Applications from OLTP for Initiate Renewal process';
   ins_upd_rec;
   --*****************************************
   v_rec.NAME := 'InitRenewal_notice1_days';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '10';
   v_rec.DESCRIPTION := 'NY Rule 1 for Initiate Renewal ';
   ins_upd_rec;
   --*****************************************
   v_rec.NAME := 'InitRenewal_notice2_days';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '20';
   v_rec.DESCRIPTION := 'NY Rule 1 for Initiate Renewal ';
   ins_upd_rec;
   --*****************************************
   v_rec.NAME := 'InitRenewal_notice3_days';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '30';
   v_rec.DESCRIPTION := 'NY Rule 1 for Initiate Renewal ';
   ins_upd_rec;
   --*****************************************

END;
/
COMMIT;
