DECLARE
 CURSOR fpil_cur IS
  SELECT  s.case_id
       ,cs_period_start_date cost_share_start_date
       ,cs_period_end_date cost_share_end_date
       ,cap_amount co_pay_amount
       ,enrollment_fee enrollment_fee_assessed
       ,CASE WHEN fee_paid_flag = 'Y' THEN enrollment_fee ELSE 0 END enrollment_fee_paid
       ,date_fee_paid enrollment_fee_paid_date
       ,cap_met_date met_cost_share_cap_date
       ,'ANNUAL' enrollment_fee_frequency
       ,enrollment_end_date + 1 chip_annual_enroll_date
       ,family_size people_in_family
       ,(SELECT MIN(LEAST(cs_period_start_date,create_ts)) 
         FROM cost_share_details_stg d1 
         WHERE d1.case_id = s.case_id
         AND d1.enrollment_start_date = s.enrollment_start_date
         AND d1.enrollment_end_date = s.enrollment_end_date) enrollment_fee_assessed_date                              
        ,s.update_ts modified_date
        ,cs_details_id
        ,COALESCE(edf.fpl_id,0) fpl_id
        ,s.fpil fpl_percentage        
        ,f.enrollment_id
        ,f.managed_care_start_date
        ,f.managed_care_end_date
        ,f.client_number
        ,f.case_number
FROM   cost_share_details_stg s
  INNER JOIN emrs_f_enrollment f
   ON s.case_id = f.case_number
  LEFT OUTER JOIN emrs_d_federal_poverty_level edf
    ON edf.fpl_number_in_family = s.family_size
    AND TO_CHAR(sysdate,'YYYY') = TO_CHAR(fpl_year,'YYYY')
WHERE f.program_id =  604 -- CHIP only
AND COALESCE(f.managed_care_end_date,last_day(trunc(sysdate)) + 1) BETWEEN  s.cs_period_start_date AND s.cs_period_end_date;

   
   TYPE t_fpil_tab IS TABLE OF fpil_cur%ROWTYPE INDEX BY PLS_INTEGER;
    fpil_tab t_fpil_tab;
    v_bulk_limit NUMBER := 5000;  
BEGIN
  OPEN fpil_cur;
  LOOP
     FETCH fpil_cur BULK COLLECT INTO fpil_tab LIMIT v_bulk_limit;
     EXIT WHEN fpil_tab.COUNT = 0; -- Exit when missing rows
    
     FOR indx IN 1 .. fpil_tab.COUNT LOOP  
       UPDATE emrs_f_enrollment
       SET cost_share_start_date = fpil_tab(indx).cost_share_start_date
           ,cost_share_end_date = fpil_tab(indx).cost_share_end_date
           ,co_pay_amount = fpil_tab(indx).co_pay_amount
           ,enrollment_fee_assessed = fpil_tab(indx).enrollment_fee_assessed
           ,enrollment_fee_paid = fpil_tab(indx).enrollment_fee_paid
           ,met_cost_share_cap_date = fpil_tab(indx).met_cost_share_cap_date
           ,enrollment_fee_frequency = fpil_tab(indx).enrollment_fee_frequency
           ,chip_annual_enroll_date = fpil_tab(indx).chip_annual_enroll_date
           ,people_in_family = fpil_tab(indx).people_in_family
           ,enrollment_fee_assessed_date = fpil_tab(indx).enrollment_fee_assessed_date
           ,fpl_percentage = fpil_tab(indx).fpl_percentage
           ,fpl_id = fpil_tab(indx).fpl_id
       WHERE enrollment_id = fpil_tab(indx).enrollment_id; 
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
END;
/

COMMIT;