CREATE OR REPLACE VIEW EMRS_F_AUTOASSIGN_SV
AS
SELECT j.jurisdiction county_code
       ,j.benefit_plan 
       ,j.factor_value plan_code
       ,j.plan_id_ext
       ,j.plan_id_ext||j.jurisdiction plan_and_county
       ,j.factor_number plan_percent
       ,j.factor_number3 capacity
       ,SUM(enr.plan_count) enroll_count
       ,nvl(ta.total_to_assign,0) total_to_assign
       ,nvl(ata.total_to_assign_after,0) total_to_assign_after
       ,asn.asn_in_cty total_assigned
       ,j.factor_number3 - SUM(enr.plan_count)  plan_space_available
       ,CASE WHEN j.factor_value2 = '1' AND (j.factor_number3 *.8) > SUM(enr.plan_count)+((j.factor_number/100)*ta.total_to_assign) THEN 1 ELSE 0 END plan_group1_notat_capacity
       ,CASE WHEN j.factor_value2 = '2' AND (j.factor_number3 *.8) > SUM(enr.plan_count)+((j.factor_number/100)*ta.total_to_assign) THEN 1 ELSE 0 END plan_group2_notat_capacity
       ,CASE WHEN j.factor_value2 = '3' AND (j.factor_number3 *.8) > SUM(enr.plan_count)+((j.factor_number/100)*ta.total_to_assign) THEN 1 ELSE 0 END plan_group3_notat_capacity
       ,CASE WHEN j.factor_value2 = '1' AND (j.factor_number3 *.8) > SUM(enr.plan_count)+((j.factor_number/100)*ta.total_to_assign) THEN ROUND((j.factor_number/100)*ta.total_to_assign) ELSE 0 END plan_group1_to_assign
       ,CASE WHEN j.factor_value2 = '2' AND (j.factor_number3 *.8) > SUM(enr.plan_count)+((j.factor_number/100)*ta.total_to_assign) THEN ROUND((j.factor_number/100)*ta.total_to_assign) ELSE 0 END plan_group2_to_assign
       ,CASE WHEN j.factor_value2 = '3' AND (j.factor_number3 *.8) > SUM(enr.plan_count)+((j.factor_number/100)*ta.total_to_assign) THEN ROUND((j.factor_number/100)*ta.total_to_assign) ELSE 0 END plan_group3_to_assign       
       ,CASE WHEN j.factor_value2 = '1' AND (j.factor_number3 *.8) > SUM(enr.plan_count)+((j.factor_number/100)*ata.total_to_assign_after) THEN 1 ELSE 0 END plan_group1_notat_capacity_aft
       ,CASE WHEN j.factor_value2 = '2' AND (j.factor_number3 *.8) > SUM(enr.plan_count)+((j.factor_number/100)*ata.total_to_assign_after) THEN 1 ELSE 0 END plan_group2_notat_capacity_aft
       ,CASE WHEN j.factor_value2 = '3' AND (j.factor_number3 *.8) > SUM(enr.plan_count)+((j.factor_number/100)*ata.total_to_assign_after) THEN 1 ELSE 0 END plan_group3_notat_capacity_aft
       ,CASE WHEN j.factor_value2 = '1' AND (j.factor_number3 *.8) > SUM(enr.plan_count)+((j.factor_number/100)*ata.total_to_assign_after) THEN ROUND((j.factor_number/100)*ata.total_to_assign_after) ELSE 0 END plan_group1_to_assign_aft
       ,CASE WHEN j.factor_value2 = '2' AND (j.factor_number3 *.8) > SUM(enr.plan_count)+((j.factor_number/100)*ata.total_to_assign_after) THEN ROUND((j.factor_number/100)*ata.total_to_assign_after) ELSE 0 END plan_group2_to_assign_aft
       ,CASE WHEN j.factor_value2 = '3' AND (j.factor_number3 *.8) > SUM(enr.plan_count)+((j.factor_number/100)*ata.total_to_assign_after) THEN ROUND((j.factor_number/100)*ata.total_to_assign_after) ELSE 0 END plan_group3_to_assign_aft       
       ,CASE WHEN j.factor_value2 = '4' then 1 else 0 end  plan_group4_to_assign
FROM (SELECT *
      FROM jurisdiction_factor j
        JOIN (SELECT DISTINCT pl.plan_id,pl.plan_code, pl.plan_id_ext,ccon.county_cd,
                        CASE WHEN c.plan_service_type_cd = 'MAINSTREAM' THEN 'MA'  
                             WHEN c.plan_service_type_cd = 'ICO' THEN 'ICO'
                       ELSE null END benefit_plan                                     
             FROM eb.plans pl
              JOIN eb.contract c ON pl.plan_id = c.plan_id
              JOIN eb.contract_amendment ca ON c.contract_id =ca.contract_id
              JOIN eb.contract_aid_category caid on caid.contract_amendment_id = ca.contract_amendment_id
              JOIN eb.enum_aid_category eaid on eaid.value = caid.aid_category_cd
              JOIN eb.county_contract ccon on ccon.contract_amendment_id = ca.contract_amendment_id           
            WHERE 1=1
            AND ca.end_date IS NULL
            AND ca.status_cd = 'ACTIVE'        
            AND c.end_date IS NULL) p
        ON j.factor_value = p.plan_code  
        AND j.jurisdiction = p.county_cd
      WHERE benefit_plan IS NOT NULL ) j   
  left JOIN (SELECT i.addr_county county, p.plan_id, p.plan_code, benefit_plan,COUNT(1) plan_count
        FROM selection_segment ss
        JOIN client_supplementary_info i ON i.client_id = ss.client_id AND i.addr_county <> '00'              
        JOIN eb.plans p ON p.plan_id = ss.plan_id
        JOIN (SELECT DISTINCT c.plan_id,
                CASE WHEN c.plan_service_type_cd = 'MAINSTREAM' THEN 'MA'  
                     WHEN c.plan_service_type_cd = 'ICO' THEN 'ICO'
                ELSE null END benefit_plan
            FROM eb.contract c 
              JOIN eb.contract_amendment ca ON c.contract_id =ca.contract_id
              JOIN eb.contract_aid_category caid on caid.contract_amendment_id = ca.contract_amendment_id
              JOIN eb.enum_aid_category eaid on eaid.value = caid.aid_category_cd
              JOIN eb.county_contract ccon on ccon.contract_amendment_id = ca.contract_amendment_id) con ON con.plan_id = ss.plan_id 
        WHERE ( ss.end_date IS NULL OR ss.end_date >= ADD_MONTHS(TRUNC(sysdate,'MON'),1) )
        GROUP BY i.addr_county , p.plan_id, p.plan_code,benefit_plan              
        UNION 
        SELECT i.addr_county county, p.plan_id, p.plan_code, benefit_plan,COUNT(1) plan_count
        FROM selection_txn st
          JOIN client_supplementary_info i ON i.client_id = st.client_id AND i.addr_county <> '00'                
          JOIN eb.plans p ON p.plan_id = st.plan_id
          JOIN (SELECT DISTINCT c.plan_id,
                  CASE WHEN c.plan_service_type_cd = 'MAINSTREAM' THEN 'MA'  
                       WHEN c.plan_service_type_cd = 'ICO' THEN 'ICO'
                  ELSE null END benefit_plan
                FROM eb.contract c 
                  JOIN eb.contract_amendment ca ON c.contract_id =ca.contract_id
                  JOIN eb.contract_aid_category caid on caid.contract_amendment_id = ca.contract_amendment_id
                  JOIN eb.enum_aid_category eaid on eaid.value = caid.aid_category_cd
                  JOIN eb.county_contract ccon on ccon.contract_amendment_id = ca.contract_amendment_id) con ON con.plan_id = st.plan_id
        WHERE st.transaction_type_cd IN ('NewEnrollment','Transfer')
        AND st.status_cd IN ('readyToUpload','uploadedToState') 
        GROUP BY i.addr_county , p.plan_id, p.plan_code, benefit_plan) enr    
    ON j.jurisdiction = enr.county       
    AND j.factor_value = enr.plan_code
    AND j.benefit_plan = enr.benefit_plan
  left JOIN (SELECT i.addr_county county 
               ,CASE WHEN el.sub_status_codes like 'ICO%' THEN 'ICO' 
                     WHEN el.sub_status_codes in ('CSHCS','MEDICAID') THEN 'MA' 
                     ELSE null END benefit_plan
               ,COUNT(1) total_to_assign
--               ,SUM(CASE WHEN aa.aa_action_cd = 'ASSIGNED' THEN 1 ELSE 0 END) total_assigned
        from client_supplementary_info i
        join client_enroll_status es on es.client_id = i.client_id
        and es.end_date is null
        and es.program_cd = 'MEDICAID'
        and es.enroll_status_cd = 'AAR'
        join client_elig_status el on el.client_id = i.client_id
        and el.end_date is null
        and el.elig_status_cd = 'M'
        and el.sub_status_codes = 'MEDICAID'
        group by i.addr_county, CASE WHEN el.sub_status_codes like 'ICO%' THEN 'ICO' 
                     WHEN el.sub_status_codes in ('CSHCS','MEDICAID') THEN 'MA' 
                     ELSE null END ) ta
    ON j.jurisdiction = ta.county
    AND enr.benefit_plan = ta.benefit_plan        
  left JOIN (SELECT i.addr_county county 
                      ,CASE WHEN c7.plan_service_type_cd = 'MAINSTREAM' THEN 'MA'  
                       WHEN c7.plan_service_type_cd = 'ICO' THEN 'ICO'
                  ELSE null END benefit_plan
               ,COUNT(1) total_to_assign_after
--               ,SUM(CASE WHEN aa.aa_action_cd = 'ASSIGNED' THEN 1 ELSE 0 END) total_assigned
        from client_supplementary_info i
        join selection_txn t2 on t2.client_id = i.client_id
        join contract c7 on c7.contract_id = t2.contract_id
          and c7.plan_service_type_cd in ( 'MAINSTREAM','ICO')
          and t2.transaction_type_cd = 'DefaultEnroll'
          and t2.status_cd in ('readyToUpload','pendingAssignment')
        join client_elig_status el on el.client_id = i.client_id
          and el.end_date is null
          and el.elig_status_cd = 'M'
          and el.sub_status_codes in ( 'MEDICAID','CSHCS','ICO')
        group by i.addr_county, CASE WHEN c7.plan_service_type_cd = 'MAINSTREAM' THEN 'MA'  
                       WHEN c7.plan_service_type_cd = 'ICO' THEN 'ICO'
                  ELSE null END 
        ) ata
    ON j.jurisdiction = ata.county
    AND enr.benefit_plan = ata.benefit_plan        
    left outer join 
    ( select i9.addr_county asn_cty , 
                      CASE WHEN con9.plan_service_type_cd = 'MAINSTREAM' THEN 'MA'  
                       WHEN con9.plan_service_type_cd = 'ICO' THEN 'ICO'
                  ELSE null END benefit_plan
                  , count(1) asn_in_cty
    from selection_txn st9
    join client_supplementary_info i9 on i9.client_id = st9.client_id
    and i9.addr_county <> '00'
    join eb.plans p9 on p9.plan_id = st9.plan_id
    join contract con9 on con9.plan_id = st9.plan_id
    and con9.plan_service_type_cd in ('MAINSTREAM','ICO')
    where st9.transaction_type_cd = 'DefaultEnroll'
    and st9.status_cd in ( 'readyToUpload','pendingAssignment')
    group by i9.addr_county, CASE WHEN con9.plan_service_type_cd = 'MAINSTREAM' THEN 'MA'  
                                  WHEN con9.plan_service_type_cd = 'ICO' THEN 'ICO'
                                  ELSE null END
                  ) asn on asn.asn_cty = j.jurisdiction
WHERE factor_name = 'AA_PERCENT'   
GROUP BY j.jurisdiction
       ,j.benefit_plan
       ,j.factor_value      
       ,j.plan_id_ext
       ,j.factor_value2
       ,j.factor_number
       ,j.factor_number3 
       ,ta.total_to_assign
       ,ata.total_to_assign_after
       ,asn.asn_in_cty
       ,j.plan_id_ext;
       
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_AUTOASSIGN_SV TO MAXDAT_REPORTS;        
