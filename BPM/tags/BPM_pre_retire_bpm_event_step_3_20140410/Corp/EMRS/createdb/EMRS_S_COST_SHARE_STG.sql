CREATE TABLE emrs_s_cost_share_stg
(case_number NUMBER(*,0)
 ,cost_share_start_date DATE
 ,cost_share_end_date DATE
 ,co_pay_amount NUMBER(22,3)
 ,enrollment_fee_assessed  NUMBER(22,4)
 ,enrollment_fee_paid NUMBER(22,4)
 ,enrollment_fee_paid_date DATE
 ,met_cost_share_cap_date DATE
 ,enrollment_fee_frequency VARCHAR2(30)
 ,chip_annual_enroll_date DATE
 ,people_in_family NUMBER(22,0)
 ,enrollment_fee_assessed_date DATE
 ,modified_date DATE
 ,chip_next_enroll_date DATE
 ,cs_details_id NUMBER(*,0)
 ,fpl_percentage NUMBER(22,4))
TABLESPACE MAXDAT_DATA;

CREATE INDEX IDX1_COSTSHARESTG ON emrs_s_cost_share_stg(case_number) TABLESPACE MAXDAT_INDX;
 
CREATE OR REPLACE PUBLIC SYNONYM emrs_s_cost_share_stg FOR emrs_s_cost_share_stg;