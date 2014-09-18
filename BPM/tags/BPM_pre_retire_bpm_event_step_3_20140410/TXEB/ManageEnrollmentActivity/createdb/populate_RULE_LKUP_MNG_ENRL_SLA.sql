/*
Created on 19-Aug-2013 by Raj A.
Team: MAXDAT.
Business Process: Manage Enrollment Activity.

Description:
Inserts global controls into the Rule_lkup_mng_enrl_sla table.
Used by the Semantic layer code, i.e., the MANAGE_ENROLL_pkg.sql
*/
DECLARE 
 v_rec        RULE_LKUP_MNG_ENRL_SLA%ROWTYPE;
 --
     PROCEDURE ins_rec IS
        v_cnt INTEGER := 0;
        v_id INTEGER;
     BEGIN     
                   
           SELECT  COUNT(*) 
             INTO v_cnt
             FROM Rule_lkup_mng_enrl_sla  a
            WHERE a.sla_days_type = v_rec.sla_days_type
              and a.sla_type = v_rec.sla_type
              and a.newborn_flag = v_rec.newborn_flag;
                 
           IF v_cnt = 0 THEN
              SELECT seq_mes.nextval 
                INTO v_id FROM dual;
                
              v_rec.mes_id:= v_id;
              INSERT INTO Rule_lkup_mng_enrl_sla VALUES v_rec;
              
           END IF;
     END;
BEGIN
   
    v_rec.CREATED_TS := SYSDATE;
    v_rec.UPDATED_TS := SYSDATE;

v_rec.sla_days_type := 'C';   
v_rec.sla_days := 2;  
V_REC.SLA_TYPE := 'ENROLLMENT_PACKET'; 
v_rec.newborn_flag := 'N';
ins_rec;

V_REC.SLA_DAYS_TYPE := 'C'; V_REC.SLA_DAYS := 15;  V_REC.SLA_TYPE := 'FIRST_FOLLOWUP'; V_REC.NEWBORN_FLAG := 'N'; INS_REC;
v_rec.sla_days_type := 'C'; v_rec.sla_days := 75;  v_rec.sla_type := 'SECOND_FOLLOWUP'; v_rec.newborn_flag := 'N'; ins_rec;
v_rec.sla_days_type := 'C'; v_rec.sla_days := 2;  v_rec.sla_type := 'ENROLLMENT_PACKET'; v_rec.newborn_flag := 'Y'; ins_rec;
V_REC.SLA_DAYS_TYPE := 'C'; V_REC.SLA_DAYS := 15;  V_REC.SLA_TYPE := 'FIRST_FOLLOWUP'; V_REC.NEWBORN_FLAG := 'Y'; INS_REC;
v_rec.sla_days_type := 'C'; v_rec.sla_days := 75;  v_rec.sla_type := 'SECOND_FOLLOWUP'; v_rec.newborn_flag := 'Y'; ins_rec;

v_rec.sla_days_type := 'C'; v_rec.sla_days := null;  v_rec.sla_type := 'AUTO_ASSIGNMENT'; v_rec.newborn_flag := 'N'; ins_rec;
v_rec.sla_days_type := 'C'; v_rec.sla_days := null;  v_rec.sla_type := 'AUTO_ASSIGNMENT'; v_rec.newborn_flag := 'Y'; ins_rec;


COMMIT;      
END;
/