/*
Created on 21-Jun-2013 by Raj A.
Team: MAXDAT.
Project: ICEB.
Business Process: Manage Enrollment Activity.

Description:
Inserts global controls into the Rule_lkup_mng_enrl_sla table.
Used by the Semantic layer code, i.e., the DPY_MANAGE_ENROLL_pkg.sql

Updated on 31-Jul-2013 by Raj A. New SLA days and Followup calendar days per Steven Davis.
*/
DECLARE 
 v_rec        Rule_lkup_mng_enrl_sla%ROWTYPE;
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
v_rec.sla_type := 'ENROLLMENT_PACKET'; 
v_rec.newborn_flag := 'Y';
ins_rec;

v_rec.sla_days_type := 'C'; v_rec.sla_days := 40;  v_rec.sla_type := 'FIRST_FOLLOWUP'; v_rec.newborn_flag := 'Y'; ins_rec;
v_rec.sla_days_type := 'C'; v_rec.sla_days := 14;  v_rec.sla_type := 'SECOND_FOLLOWUP'; v_rec.newborn_flag := 'Y'; ins_rec;
v_rec.sla_days_type := 'C'; v_rec.sla_days := 50;  v_rec.sla_type := 'THIRD_FOLLOWUP'; v_rec.newborn_flag := 'Y'; ins_rec;
v_rec.sla_days_type := 'C'; v_rec.sla_days := 30;  v_rec.sla_type := 'FOURTH_FOLLOWUP'; v_rec.newborn_flag := 'Y'; ins_rec;
v_rec.sla_days_type := 'C'; v_rec.sla_days := 60;  v_rec.sla_type := 'AUTO_ASSIGNMENT'; v_rec.newborn_flag := 'Y'; ins_rec;

v_rec.sla_days_type := 'C'; v_rec.sla_days := 5;   v_rec.sla_type := 'ENROLLMENT_PACKET';  v_rec.newborn_flag := 'N'; ins_rec;
v_rec.sla_days_type := 'C'; v_rec.sla_days := 40;  v_rec.sla_type := 'FIRST_FOLLOWUP';  v_rec.newborn_flag := 'N'; ins_rec;
v_rec.sla_days_type := 'C'; v_rec.sla_days := 14;  v_rec.sla_type := 'SECOND_FOLLOWUP'; v_rec.newborn_flag := 'N'; ins_rec;
v_rec.sla_days_type := 'C'; v_rec.sla_days := 50;  v_rec.sla_type := 'THIRD_FOLLOWUP';  v_rec.newborn_flag := 'N'; ins_rec;
v_rec.sla_days_type := 'C'; v_rec.sla_days := 30;  v_rec.sla_type := 'FOURTH_FOLLOWUP'; v_rec.newborn_flag := 'N'; ins_rec;
v_rec.sla_days_type := 'C'; v_rec.sla_days := 60;  v_rec.sla_type := 'AUTO_ASSIGNMENT'; v_rec.newborn_flag := 'N'; ins_rec;


COMMIT;      
END;
/