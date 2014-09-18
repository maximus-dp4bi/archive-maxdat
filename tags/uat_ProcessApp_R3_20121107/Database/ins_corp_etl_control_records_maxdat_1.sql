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
     v_rec.NAME := 'HIGH_LIMIT_TASK_HISTORY_ID';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '999999999999999';
   v_rec.DESCRIPTION := 'Used to set task history High limit, rarely used';
    ins_upd_rec;


    --*****************************************
   v_rec.NAME := 'MW_LAST_STEP_INST_HIST_ID';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '100000';
   v_rec.DESCRIPTION := 'Used to fetch task history records from OLTP for MW process';
    ins_upd_rec;
   --*****************************************
   v_rec.NAME := 'MW_SLA_DAYS';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '0';
   v_rec.DESCRIPTION := 'Used to calculate SLA Days, 0 is not defined ';
    ins_upd_rec;
   v_rec.NAME := 'MW_SLA_DAYS_TYPE';
   v_rec.VALUE_TYPE := 'V';
   v_rec.VALUE := 'N';
   v_rec.DESCRIPTION := 'Used to calculate SLA Days TYPE, N is none, B is Busisness, C is Calendar  ';
    ins_upd_rec;
   v_rec.NAME := 'MW_SLA_TARGET_DAYS';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '0';
   v_rec.DESCRIPTION := 'Used to calculate SLA Days, 0 is not defined ';
    ins_upd_rec;

   v_rec.NAME := 'MW_SLA_JEOPARDY_DAYS';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '0';
   v_rec.DESCRIPTION := 'Used to calculate SLA Days, 0 is not defined ';
    ins_upd_rec;
    
     --*****************************************
   v_rec.NAME := 'AP_SLA_DAYS';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '6';
   v_rec.DESCRIPTION := 'Used to calculate SLA Days for App Processing';
    ins_upd_rec;
     --*****************************************
   v_rec.NAME := 'AP_SLA_JEOPARDY_DAYS';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '2';
   v_rec.DESCRIPTION := 'Used to calculate SLA Jeopardy Days for App Processing';
    ins_upd_rec;
     --*****************************************
   v_rec.NAME := 'AP_SLA_TARGET_DAYS';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '4';
   v_rec.DESCRIPTION := 'Used to calculate SLA Target Days for App Processing ';
    ins_upd_rec;
     --*****************************************
   v_rec.NAME := 'AP_CLOCKDOWN_DAYS';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '15';
   v_rec.DESCRIPTION := 'Used to calculate CLOCKDOWN Days for App Processing ';
    ins_upd_rec;
   --*****************************************
   v_rec.NAME := 'AP_LAST_APPLICATION_ID';
   v_rec.VALUE_TYPE := 'N';
   v_rec.VALUE := '100000';
   v_rec.DESCRIPTION := 'Used to fetch Applications from OLTP for AP process';
    ins_upd_rec;

   --*****************************************
   v_rec.NAME := 'AP_IN_PROCESS';
   v_rec.VALUE_TYPE := 'V';
   v_rec.VALUE := 'N';
   v_rec.DESCRIPTION := 'Used to determine if Schedule can start Stage update';
    ins_upd_rec;
 --*****************************************    
   v_rec.NAME := 'MW_IN_PROCESS';
   v_rec.VALUE_TYPE := 'V';
   v_rec.VALUE := 'N';
   v_rec.DESCRIPTION := 'Used to determine if Schedule can start Stage update';
    ins_upd_rec;
 --*****************************************
   v_rec.NAME := 'MIB_IN_PROCESS';
   v_rec.VALUE_TYPE := 'V';
   v_rec.VALUE := 'N';
   v_rec.DESCRIPTION := 'Used to determine if Schedule can start Stage update';
    ins_upd_rec;
END;
/
COMMIT;

SELECT * FROM corp_etl_control;

