UPDATE corp_etl_proc_let_material_chd
SET material_desc = CASE material_cd 
                         WHEN 'CTH_FACT' THEN 'C/TH Fact Sheet'
                         WHEN 'VOTER_REG' THEN 'Voter Registration Form'
                         WHEN 'AUTHORIZED_REP' THEN 'Authorized Representative Form'
                         WHEN 'ESI' THEN 'ESI Form'
                         WHEN 'PREM_REVIEW' THEN 'Premium Contribution Review Form'
                         WHEN 'MED_REIMBURSE' THEN 'Medical Assistance Reimbursement Detail Form'
                         WHEN 'CONFINE_COST' THEN 'Confinement Cost Letter'
                         WHEN 'FARM_BUSINESS_INC' THEN 'Farm Business Income Form'
                         WHEN 'FINANCIAL_MAIN' THEN 'Financial Maintenance Form'
                         WHEN 'CHILD_HEALTH' THEN 'Childrens Health Insurance Brochure '
                         WHEN 'CHRONIC_REN' THEN 'Chronic Care Renewal Form'
                         WHEN 'ABSENT_PARENT_FORMS' THEN 'Absent Parent Forms'
                         WHEN 'ID_Verify_Form' THEN 'ID Verification Form'
                         WHEN 'DISCONT_COV' THEN 'Intent to Discontinue Insurance Letter'
                         WHEN 'SS_5' THEN 'SS-5 Form'
                         WHEN 'APP_REQUEST' THEN 'Application Request'
                         WHEN 'EXCESS_INC_FACT' THEN 'Excess Income Fact Sheet'
                         WHEN 'LTC_FACT' THEN 'Long Term Care Fact Sheet'
                         WHEN 'HC_PROXY' THEN 'Health Care Proxy Form'
                         WHEN 'WAIT_EXCEPTION' THEN 'Waiting Period Exception Form'
                         ELSE NULL END
;  

commit;