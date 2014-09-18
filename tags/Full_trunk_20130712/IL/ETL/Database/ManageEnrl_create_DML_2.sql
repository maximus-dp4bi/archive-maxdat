/*
Created on 12-Jun-2013 by Raj A.
Team: MAXDAT.
Project: ICEB.
Business Process: Manage Enrollment Activity.

Description:
Inserts global controls into the Rule_lkup_mng_enrl_followup table.
Used by the ManageEnroll_Apply_UPD_Rules_to_WIP.ktr

*/
DECLARE 
 v_rec        Rule_lkup_mng_enrl_followup%ROWTYPE;
 --
     PROCEDURE ins_rec IS
        v_cnt INTEGER := 0;
        v_id INTEGER;
     BEGIN     
                   
           SELECT  COUNT(*) 
             INTO v_cnt
             FROM Rule_lkup_mng_enrl_followup  a
            WHERE a.followup_type_code = v_rec.followup_type_code
              and a.plan_type = v_rec.plan_type
              and a.program_type = v_rec.program_type;
                 
           IF v_cnt = 0 THEN
              SELECT seq_mefr.nextval 
                INTO v_id FROM dual;
                
              v_rec.mefr_id:= v_id;
              INSERT INTO Rule_lkup_mng_enrl_followup VALUES v_rec;
              
           END IF;
     END;
BEGIN
    v_rec.START_DATE := Trunc(SYSDATE);
    v_rec.END_DATE := to_date('07/07/7777','mm/dd/yyyy');
    v_rec.CREATED_TS := SYSDATE;
    v_rec.UPDATED_TS := SYSDATE;

v_rec.followup_name := 'FIRST';   
v_rec.followup_req := 'Y';  
v_rec.followup_type_code := 'RMI'; 
v_rec.followup_type := 'RM - Mandatory Initial Reminder Notice';
v_rec.followup_cal_days := '14';  
v_rec.plan_type := 'MEDICAL';
v_rec.program_type :=  'MEDICAID';
ins_rec;

v_rec.followup_name := 'FIRST'; v_rec.followup_req := 'Y';  v_rec.followup_type_code := 'RMP'; v_rec.followup_type := 'RM - Mandatory Initial Reminder Notice'; v_rec.followup_cal_days := '14';  v_rec.plan_type := 'MEDICAL'; v_rec.program_type :=  'MEDICAID'; ins_rec;
v_rec.followup_name := 'FIRST'; v_rec.followup_req := 'Y';  v_rec.followup_type_code := 'RMV'; v_rec.followup_type := 'RM - Mandatory Initial Reminder Notice'; v_rec.followup_cal_days := '14';  v_rec.plan_type := 'MEDICAL'; v_rec.program_type :=  'MEDICAID'; ins_rec;

v_rec.followup_name := 'SECOND'; v_rec.followup_req := 'Y';  v_rec.followup_type_code := 'SEI'; v_rec.followup_type := 'SE - Mandatory Secondary Enrollment Packet'; v_rec.followup_cal_days := '30';  v_rec.plan_type := 'MEDICAL'; v_rec.program_type :=  'MEDICAID'; ins_rec;
v_rec.followup_name := 'SECOND'; v_rec.followup_req := 'Y';  v_rec.followup_type_code := 'SEP'; v_rec.followup_type := 'SE - Mandatory Secondary Enrollment Packet'; v_rec.followup_cal_days := '30';  v_rec.plan_type := 'MEDICAL'; v_rec.program_type :=  'MEDICAID'; ins_rec;
v_rec.followup_name := 'SECOND'; v_rec.followup_req := 'Y';  v_rec.followup_type_code := 'SEV'; v_rec.followup_type := 'SE - Mandatory Secondary Enrollment Packet'; v_rec.followup_cal_days := '30';  v_rec.plan_type := 'MEDICAL'; v_rec.program_type :=  'MEDICAID'; ins_rec;

v_rec.followup_name := 'THIRD'; v_rec.followup_req := 'Y';  v_rec.followup_type_code := 'R1'; v_rec.followup_type := 'Outbound Call - Day 40'; v_rec.followup_cal_days := '40';  v_rec.plan_type := 'MEDICAL'; v_rec.program_type :=  'MEDICAID'; ins_rec;
v_rec.followup_name := 'FOURTH'; v_rec.followup_req := 'Y';  v_rec.followup_type_code := 'R2'; v_rec.followup_type := 'Outbound Call - Day 50'; v_rec.followup_cal_days := '50';  v_rec.plan_type := 'MEDICAL'; v_rec.program_type :=  'MEDICAID'; ins_rec;


COMMIT;      
END;
/