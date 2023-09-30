create table emrs_cost_share_enrl_onetime    
as
SELECT d.cs_period_start_date cost_share_start_date
                 ,d.cs_period_end_date cost_share_end_date
                 ,d.cap_amount co_pay_amount
                 ,d.enrollment_fee enrollment_fee_assessed
                 ,CASE WHEN d.fee_status = 'PAID' THEN d.enrollment_fee ELSE 0 END enrollment_fee_paid
                 ,CASE WHEN d.fee_status = 'PAID' THEN d.fee_status_date ELSE null END enrollment_fee_paid_date
                 ,d.cap_met_date met_cost_share_cap_date                                  
                 ,d.fpil fpl_percentage
                 ,d.cap_met_amount
                 ,d.fee_status
                 ,d.fee_status_date
                 ,d.lpd_date last_payment_date
                 ,d.plan_notified_date
                 ,d.total_expense_amount
                 ,(SELECT MIN(LEAST(cs_period_start_date,create_ts)) 
                   FROM cost_share_details_stg u1 
                   WHERE u1.cs_details_id = d.cs_details_id) enrollment_fee_assessed_date 
                   ,f.enrollment_id
                   ,f.managed_care_start_date
                   ,f.managed_care_end_date
                   ,f.chip_annual_enroll_date
                   ,d.enrollment_start_date
                   ,d.enrollment_end_date
              FROM cost_share_details_stg d, emrs_f_enrollment f
              WHERE d.case_id = f.case_number
              and d.enrollment_end_date + 1 = f.chip_annual_enroll_date
              --and d.case_id = 3709970
              ;

DECLARE  
  CURSOR temp_cur IS
    select * from emrs_cost_share_enrl_onetime s
    where cost_share_start_date = (select max(cost_share_start_date)
                                   from emrs_cost_share_enrl_onetime s1
                                   where s.enrollment_id = s1.enrollment_id);    

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT         
              UPDATE emrs_f_enrollment
              SET cost_share_start_date =	temp_tab(indx).cost_share_start_date
                  ,cost_share_end_date =	temp_tab(indx).cost_share_end_date
                  ,co_pay_amount =	temp_tab(indx).co_pay_amount
                  ,enrollment_fee_assessed =	temp_tab(indx).enrollment_fee_assessed
                  ,enrollment_fee_paid =	temp_tab(indx).enrollment_fee_paid
                  ,enrollment_fee_paid_date =	temp_tab(indx).enrollment_fee_paid_date
                  ,met_cost_share_cap_date =	temp_tab(indx).met_cost_share_cap_date                  
                  ,enrollment_fee_assessed_date	= temp_tab(indx).enrollment_fee_assessed_date
                  ,fpl_percentage	= temp_tab(indx).fpl_percentage
                  ,fee_status	= temp_tab(indx).fee_status
                  ,fee_status_date	=  temp_tab(indx).fee_status_date
                  ,last_payment_date =	temp_tab(indx).last_payment_date
                  ,plan_notified_date = temp_tab(indx).plan_notified_date
                  ,cap_met_amount = temp_tab(indx).cap_met_amount
                  ,total_expense_amount = temp_tab(indx).total_expense_amount
             WHERE enrollment_id = temp_tab(indx).enrollment_id;                     
      END;
      COMMIT;
    END LOOP;
    COMMIT;
    CLOSE temp_cur;
END;
/