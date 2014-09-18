DECLARE
  v_timeliness   varchar(50) ;
  v_sla_days1 VARCHAR2(50);
  v_sla_days2 VARCHAR2(50);
  v_sla_days3 VARCHAR2(50);
  v_sla_date DATE;
        p_create_date   DATE;
      p_process  VARCHAR2(100);
      p_outreach_category  VARCHAR2(100);
      p_outreach_type  VARCHAR2(100);
      p_ased_outreach_step1  DATE;
      p_ased_outreach_step2  DATE;
      p_ased_outreach_step3  DATE;
      p_ased_outreach_step4  DATE;
      p_ased_outreach_step5  DATE;
      p_outreach_step6  VARCHAR2(100);
      p_ased_outreach_step6  DATE;
      p_reminder_appt_dt  DATE;
      p_complete_date  DATE;
      p_outreach_status VARCHAR2(100);     
BEGIN

   FOR i in (SELECT cREATE_DATE,GENERIC_FIELD_2,OUTREACH_REQUEST_CATEGORY, OUTREACH_REQUEST_TYPE,
                    PERFORM_OR_STEP1_END_DATE,PERFORM_OR_STEP2_END_DATE,
                    PERFORM_OR_STEP3_END_DATE,PERFORM_OR_STEP4_END_DATE,PERFORM_OR_STEP5_END_DATE,
                    OUTREACH_STEP_6_TYPE,PERFORM_OR_STEP6_END_DATE,
                    TO_DATE(REMINDER_APPOINTMENT_DATE,'mm/dd/yy') remind_appt_dt,COMPLETE_DATE,OUTREACH_REQUEST_STATUS,
                    outreach_request_id
    FROM d_cor_current c
    WHERE c.instance_status = 'Complete'
     and    c.outreach_request_status = 'Outreach Successful'
     and    c.timeliness_status = 'Not Processed')
   LOOP
   
      p_create_date := null;
      p_process := null;
      p_outreach_category := null;
      p_outreach_type := null; 
      p_ased_outreach_step1 := null;
      p_ased_outreach_step2 := null;   
      p_ased_outreach_step3 := null;
      p_ased_outreach_step4 := null;
      p_ased_outreach_step5 := null;
      p_outreach_step6 := null;
      p_ased_outreach_step6 := null;
      p_reminder_appt_dt := null;
      p_complete_date := null;
      p_outreach_status:= null;
      v_sla_days1 := null;
      v_sla_days2 := null;
      v_sla_days3 := null;
      v_sla_date := null;
      v_timeliness := null;
   
      p_create_date := i.cREATE_DATE;
      p_process := i.GENERIC_FIELD_2;
      p_outreach_category := i.OUTREACH_REQUEST_CATEGORY;
      p_outreach_type := i.OUTREACH_REQUEST_TYPE; 
      p_ased_outreach_step1 := i.PERFORM_OR_STEP1_END_DATE;
      p_ased_outreach_step2 := i.PERFORM_OR_STEP2_END_DATE;   
      p_ased_outreach_step3 := i.PERFORM_OR_STEP3_END_DATE;
      p_ased_outreach_step4 := i.PERFORM_OR_STEP4_END_DATE;
      p_ased_outreach_step5 := i.PERFORM_OR_STEP5_END_DATE;
      p_outreach_step6 := i.OUTREACH_STEP_6_TYPE;
      p_ased_outreach_step6 := i.PERFORM_OR_STEP6_END_DATE;
      p_reminder_appt_dt := i.remind_appt_dt;
      p_complete_date := i.COMPLETE_DATE;
      p_outreach_status := i.OUTREACH_REQUEST_STATUS;
   

    -- Timeliness for Process 9
    IF p_process = 'OUTREACH_REQUEST_9' THEN      
       BEGIN
        SELECT timeliness
        INTO v_sla_days1 
        FROM CORP_CLNT_OUTREACH_NOTIFY_LKUP
        WHERE outreach_category_desc = p_outreach_category
        AND outreach_type_desc = p_outreach_type  
        AND outreach_activity = 'Automated Call 1';
       EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_sla_days1 := NULL;
       END;
      
       BEGIN
        SELECT timeliness
        INTO v_sla_days2 
        FROM CORP_CLNT_OUTREACH_NOTIFY_LKUP
        WHERE outreach_category_desc = p_outreach_category
        AND outreach_type_desc = p_outreach_type  
        AND outreach_activity = 'Automated Call 2';
       EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_sla_days2 := NULL;
       END;
      
       BEGIN
        SELECT timeliness
        INTO v_sla_days3 
        FROM CORP_CLNT_OUTREACH_NOTIFY_LKUP
        WHERE outreach_category_desc = p_outreach_category
        AND outreach_type_desc = p_outreach_type  
        AND outreach_activity = p_outreach_step6;
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
           v_sla_days3 := NULL;
       END;
       -- check timeliness for first step 
       IF v_sla_days1 IS NOT NULL THEN
         IF p_ased_outreach_step3 IS NOT NULL THEN
           IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step3) <=  TO_NUMBER(v_sla_days1) THEN
             v_timeliness := 'Timely';
           ELSE
             v_timeliness := 'Untimely';
           END IF;
         ELSE
           v_timeliness := 'Not Processed';
         END IF;
       ELSE
         v_timeliness := 'Not Required';
       END IF;
      
       IF v_timeliness = 'Timely' THEN
       --check timeliness for second step.  first step should have already been completed at this time.
         IF v_sla_days2 IS NOT NULL THEN
           IF p_ased_outreach_step5 IS NOT NULL THEN
             IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step5) <=  TO_NUMBER(v_sla_days2) THEN
               v_timeliness := 'Timely';
             ELSE
               v_timeliness := 'Untimely';
             END IF;
           END IF;
         ELSE
           v_timeliness := 'Not Required';
         END IF;  
         
         IF v_timeliness = 'Timely' THEN
           --check timeliness for third step.  second step should have already been completed at this time.
           IF v_sla_days3 IS NOT NULL THEN
             IF p_ased_outreach_step6 IS NOT NULL THEN
               IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step6) <=  TO_NUMBER(v_sla_days3) THEN
                 v_timeliness := 'Timely';
               ELSE
                 v_timeliness := 'Untimely';
               END IF;
             END IF;
           ELSE
             v_timeliness := 'Not Required';
           END IF;   
         END IF;
       END IF;
      
       -- just a catchall in case outreach is already completed, Outreach is successful but end dates are null (this should not happen)
       IF p_complete_date IS NOT NULL THEN
         IF p_outreach_status IN ('Withdrawn','Outreach No Longer Required') THEN
            v_timeliness := 'Not Applicable';
         ELSIF p_outreach_status = 'Outreach Successful' AND v_timeliness = 'Not Processed' THEN
           IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_complete_date) <= TO_NUMBER(v_sla_days3) THEN
             v_timeliness := 'Timely';    
           ELSE
             v_timeliness := 'Untimely';    
           END IF;
         END IF;
       END IF;       
       
    ELSE
      BEGIN
        SELECT timeliness
        INTO v_sla_days1 
        FROM CORP_CLNT_OUTREACH_NOTIFY_LKUP
        WHERE outreach_category_desc = p_outreach_category
        AND outreach_type_desc = p_outreach_type;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_sla_days1 := NULL;
      END;
        
      IF v_sla_days1 IS NOT NULL THEN
        --Timeliness for Process 1 or 11
        IF p_process IN('OUTREACH_REQUEST_1' , 'OUTREACH_REQUEST_11') THEN               
          IF p_ased_outreach_step3 IS NOT NULL THEN       
            IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step3) <=  TO_NUMBER(v_sla_days1) THEN
              v_timeliness := 'Timely';
            ELSE
              v_timeliness := 'Untimely';
            END IF;
          ELSE
            v_timeliness := 'Not Processed';
          END IF;       
        --Timeliness for Process2
        ELSIF p_process IN('OUTREACH_REQUEST_2','OUTREACH_REQUEST_4') THEN        
          IF p_ased_outreach_step3 IS NOT NULL THEN
            IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step3) <=  TO_NUMBER(v_sla_days1) THEN
              v_timeliness := 'Timely';           
            ELSE
              v_timeliness := 'Untimely';
            END IF;
          ELSE
            v_timeliness := 'Not Processed';
          END IF;
          IF v_timeliness = 'Timely' THEN
            IF p_ased_outreach_step4 IS NOT NULL THEN
              IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step4) <=  TO_NUMBER(v_sla_days1) THEN
                v_timeliness := 'Timely';           
              ELSE
                v_timeliness := 'Untimely';
              END IF;
            END IF;                
          END IF;
        --Timeliness for Process 3
        ELSIF p_process = 'OUTREACH_REQUEST_3' THEN  
          IF p_ased_outreach_step1 IS NOT NULL THEN
            IF p_ased_outreach_step1 <= get_bus_date(p_reminder_appt_dt, -1*TO_NUMBER(v_sla_days1)) THEN
              v_timeliness := 'Timely';
            ELSE
              v_timeliness := 'Untimely';
            END IF;
          ELSE
            v_timeliness := 'Not Processed';  -- if step1 is not done yet, then the following steps are also not done
          END IF;
          
          IF v_timeliness = 'Timely' THEN
            --only check the rest of the steps if step 1 is Timely
            IF p_ased_outreach_step2 IS NOT NULL THEN
              IF p_ased_outreach_step2 <= get_bus_date(p_reminder_appt_dt, -1*TO_NUMBER(v_sla_days1)) THEN
                v_timeliness := 'Timely';
              ELSE
                v_timeliness := 'Untimely';
              END IF;          
            END IF;          
            
            IF v_timeliness = 'Timely' THEN
              IF p_ased_outreach_step3 IS NOT NULL THEN
                IF p_ased_outreach_step3 <= get_bus_date(p_reminder_appt_dt, -1*TO_NUMBER(v_sla_days1)) THEN
                  v_timeliness := 'Timely';
                ELSE
                  v_timeliness := 'Untimely';
                END IF;
              END IF;
            END IF;  
          END IF;          
          
          -- just a catchall in case outreach is already completed, Outreach is successful but end dates are null (this should not happen)
          IF p_complete_date IS NOT NULL THEN
            IF p_outreach_status IN ('Withdrawn','Outreach No Longer Required') THEN
              v_timeliness := 'Not Applicable';
            ELSIF p_outreach_status = 'Outreach Successful' AND v_timeliness = 'Not Processed' THEN      
              IF p_complete_date <=  get_bus_date(p_reminder_appt_dt, -1*TO_NUMBER(v_sla_days1)) THEN
                v_timeliness := 'Timely';              
              ELSE
                v_timeliness := 'Untimely';              
              END IF;
            END IF;
          END IF;          
       
        --Timeliness for Process 5
        ELSIF p_process = 'OUTREACH_REQUEST_5' THEN          
        --  v_sla_date := TO_DATE('10-'||TO_CHAR(p_assd_outreach_step1,'MON-YY'),'DD-MON-YY');
          v_sla_date := get_bus_date(p_create_date,TO_NUMBER(v_sla_days1));                                    

          IF p_ased_outreach_step1 IS NOT NULL THEN            
            IF p_ased_outreach_step1 <= v_sla_date THEN
              v_timeliness := 'Timely';          
            ELSE
              v_timeliness := 'Untimely';
            END IF;
          ELSE
            IF p_complete_date IS NOT NULL THEN              
              IF p_outreach_status IN('Withdrawn','Outreach No Longer Required') THEN
                v_timeliness := 'Not Applicable';
              ELSIF p_outreach_status = 'Outreach Successful' THEN
                IF p_complete_date <= v_sla_date THEN
                  v_timeliness := 'Timely'; 
                ELSE
                  v_timeliness := 'Untimely';
                END IF;
              END IF;
            ELSE
              v_timeliness := 'Not Processed';
            END IF;
          END IF;           
          
       --Timeliness for Process 6 or 7
        ELSIF p_process IN('OUTREACH_REQUEST_6','OUTREACH_REQUEST_7') THEN  
          IF p_ased_outreach_step1 IS NOT NULL THEN
            IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step1) <=  TO_NUMBER(v_sla_days1) THEN
              v_timeliness := 'Timely';
            ELSE
              v_timeliness := 'Untimely';
            END IF;
          ELSE
            v_timeliness := 'Not Processed';
          END IF;
          
          IF v_timeliness = 'Timely' THEN
            IF p_ased_outreach_step3 IS NOT NULL THEN
              IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step3) <=  TO_NUMBER(v_sla_days1) THEN
                v_timeliness := 'Timely';
              ELSE
                v_timeliness := 'Untimely';
              END IF;
            END IF;
          END IF;       
         
          IF p_process = 'OUTREACH_REQUEST_6' THEN
            IF v_timeliness = 'Timely' THEN
              IF p_ased_outreach_step5 IS NOT NULL THEN
                IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step5) <=  TO_NUMBER(v_sla_days1) THEN
                  v_timeliness := 'Timely';
                ELSE
                  v_timeliness := 'Untimely';
                END IF;
              END IF;
            END IF;         
          END IF;  
        --Timeliness for Process 8 or 10
        ELSIF p_process IN('OUTREACH_REQUEST_8','OUTREACH_REQUEST_10') THEN
          IF p_ased_outreach_step1 IS NOT NULL THEN
            IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step1) <=  TO_NUMBER(v_sla_days1) THEN
              v_timeliness := 'Timely';
            ELSE
              v_timeliness := 'Untimely';
            END IF;
          ELSE
            v_timeliness := 'Not Processed';
          END IF;
         
          IF v_timeliness = 'Timely' THEN
            IF p_ased_outreach_step2 IS NOT NULL THEN
              IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_ased_outreach_step2) <=  TO_NUMBER(v_sla_days1) THEN
                v_timeliness := 'Timely';
              ELSE
                v_timeliness := 'Untimely';
              END IF; 
            END IF;
          END IF;
        END IF;        
        
        --catch all for other processes to check if timeliness still needs to be calculated
        IF p_process NOT IN('OUTREACH_REQUEST_3','OUTREACH_REQUEST_5') THEN
          IF p_complete_date IS NOT NULL THEN
            IF p_outreach_status IN ('Withdrawn','Outreach No Longer Required') THEN
              v_timeliness := 'Not Applicable';
            ELSIF p_outreach_status = 'Outreach Successful' AND v_timeliness = 'Not Processed' THEN
              IF BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,p_complete_date) <= TO_NUMBER(v_sla_days1) THEN
                v_timeliness := 'Timely';    
              ELSE
                v_timeliness := 'Untimely';    
              END IF;
            END IF;
          END IF;
        END IF;
                
      ELSE  
        --no sla days found for the particular outreach category/type
        v_timeliness := 'Not Required';
      END IF;  
            
    END IF;  

   UPDATE d_cor_current
   SET timeliness_status = v_timeliness
   WHERE outreach_request_id = i.outreach_request_id;
  
 END LOOP; 

 END;   
 /
 
 