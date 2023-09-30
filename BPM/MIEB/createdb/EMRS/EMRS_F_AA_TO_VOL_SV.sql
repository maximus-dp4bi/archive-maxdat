CREATE OR REPLACE VIEW EMRS_F_AA_TO_VOL_SV
 AS
SELECT trunc(d.D_date,'MM') AS RECORD_DATE
       , p.PLAN_ID
       ,count(sp.client_id) client_cnt
FROM MAXDAT_SUPPORT.D_dates d
join (
SELECT distinct pl.plan_id
      FROM eb.plans pl
      JOIN eb.contract c            ON pl.plan_id = c.plan_id
      JOIN eb.contract_amendment ca ON c.contract_id =ca.contract_id
      JOIN eb.contract_aid_category caid on caid.contract_amendment_id = ca.contract_amendment_id
      JOIN eb.enum_aid_category eaid on eaid.value = caid.aid_category_cd
      JOIN eb.county_contract ccon on ccon.contract_amendment_id = ca.contract_amendment_id  
      join eb.enum_subprogram_type esub on esub.value = eaid.subprogram_codes
      WHERE 1=1
      AND ca.end_date IS NULL
      AND ca.status_cd = 'ACTIVE'
      AND c.end_date IS NULL 
      and eaid.value = 'MA-HMP' 
--      and esub.value = 'MC'     
      ) p on 1=1
left join (
      select 
      aavol.*
      from
      (
            select
            TRUNC(SH1.CREATE_TS) TRANSFER_dATE --transfer acceptedbystate date
            ,E1.PLAN_ID TO_PLAN_ID  --Vol plan
            ,E1.Client_Aid_Category_Cd
            ,E1.PRIOR_PLAN_ID FROM_PLAN_ID ---AA plan
            ,E1.TRANSACTION_TYPE_CD TO_TRANSACTION_TYPE_CD
            ,E2_PRIOR.TRANSACTION_TYPE_CD FROM_TRANSACTION_TYPE_CD
            , E1.CLIENT_ID
            , e1.prior_selection_segment_id
            , e1.selection_txn_id t_selection_txn_id
            , e2_prior.selection_txn_id a_selection_txn_id
            , d1.selection_txn_id dis_selection_txn_id
            , row_number() over(partition by e1.client_id order by e1.create_ts desc, e2_prior.create_ts desc) rown
            FROM
            EB.SELECTION_TXN E1
            JOIN EB.SELECTION_TXN_STATUS_HISTORY SH1 ON SH1.SELECTION_TXN_ID = E1.SELECTION_TXN_ID AND SH1.STATUS_CD = 'acceptedByState'
            JOIN EB.SELECTION_TXN E2_PRIOR ON (E2_PRIOR.CLIENT_ID = E1.CLIENT_ID AND E2_PRIOR.plan_ID = E1.PRIOR_plan_ID  and e2_prior.create_ts < e1.create_ts and e2_prior.start_date < e1.start_date)
            JOIN EB.SELECTION_TXN_STATUS_HISTORY SH2_PRIOR ON SH2_PRIOR.SELECTION_TXN_ID = E2_PRIOR.SELECTION_TXN_ID AND SH2_PRIOR.STATUS_CD = 'acceptedByState'
            left JOIN EB.SELECTION_TXN D1 ON (D1.CLIENT_ID = E1.CLIENT_ID AND d1.create_ts < e1.create_ts and D1.CREATE_TS > E2_PRIOR.CREATE_TS AND D1.TRANSACTION_TYPE_CD = 'Disenrollment')
            left JOIN EB.SELECTION_TXN_STATUS_HISTORY dsh1 ON dsh1.SELECTION_TXN_ID = d1.SELECTION_TXN_ID AND dsh1.STATUS_CD = 'acceptedByState'
            WHERE  1=1
                 AND E2_PRIOR.TRANSACTION_TYPE_CD = 'DefaultEnroll'
                 and e1.transaction_type_cd = 'Transfer' 
                 AND (E1.CREATE_TS >=add_months(TRUNC(sysdate,'mm'),-16))
                 and TRUNC(SH1.CREATE_TS,'MM') >= to_date('1/1/2018','mm/dd/yyyy')
--                 and e1.prior_plan_id = 800
        ) aavol
        where rown = 1
        and dis_selection_txn_id is null
) sp on (d.D_DATE BETWEEN sp.transfer_date AND COALESCE(sp.transfer_date, TO_DATE('12-Dec-2050', 'dd-Mon-yyyy'))
        and sp.to_plan_id = p.plan_id
        and sp.Client_Aid_Category_Cd = 'MA-HMP'
        )
where d.D_DATE BETWEEN ADD_MONTHS(TRUNC(sysdate, 'mm'), -9) AND TRUNC(sysdate)
group by trunc(d.D_date,'MM')
       , p.PLAN_ID
--order by trunc(d.d_date,'MM') desc
;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_AA_TO_VOL_SV TO MAXDAT_REPORTS; 


       
