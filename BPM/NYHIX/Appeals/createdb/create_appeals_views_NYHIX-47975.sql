
     CREATE OR REPLACE VIEW  MAXDAT.D_NYHIX_APPEALS_SV 
as
with appeals_excluded as
       (  
       select distinct FAIR_HEARING_TRACKING_NBR 
         from maxdat.D_APPEALS_CURRENT_SV            a11
         join maxdat.INCIDENT_STATUS_HISTORY_SV a12   
              on (a11.INCIDENT_ID = a12.INCIDENT_ID)
        where a11.CUR_INCIDENT_ABOUT in ('Individual','Employee', 'Employer')
          AND (  (a12.CREATED_BY  like 'NY%' or a12.CREATED_BY  like '%-1000')
                  OR  (STATUS in ( 'INC_CLOSED_DUP') or incident_status in ( 'Appeal Closed - Duplicate/Error') )
              )
       UNION ALL
      SELECT DISTINCT A.FAIR_HEARING_TRACKING_NBR FROM maxdat.D_APPEALS_CURRENT_SV   A
WHERE A.ACCOUNT_ID IN  ( SELECT B.ACCOUNT_ID  FROM maxdat.D_APPEALS_CURRENT_SV  B WHERE B.FAIR_HEARING_TRACKING_NBR LIKE 'AP0%' )
AND A.FAIR_HEARING_TRACKING_NBR LIKE 'APM%'
AND A.CREATE_DATE BETWEEN A.CREATE_DATE-365 AND A.CREATE_DATE
      )   
      
      SELECT DISTINCT Program_Type,Date_Initiated,Appeal_ID,account_id,INCIDENT_REASON,initiated_count 
      FROM 
      (
      select distinct
       Case when a11.CUR_INCIDENT_ABOUT in ('Individual') then a11.CUR_INCIDENT_ABOUT
       when a11.CUR_INCIDENT_ABOUT in ('Employee', 'Employer') then 'Small Business Marketplace'
       else NULL
       END as Program_Type,
       trunc(a11.CREATE_DATE) as Date_Initiated,
       a11.FAIR_HEARING_TRACKING_NBR as Appeal_ID,
       a11.account_id,
       a13.INCIDENT_REASON,
       1 as initiated_count,
       row_number () over ( partition by 1 ORDER BY 1 ) AS RNK 
  from maxdat.D_APPEALS_CURRENT_SV            a11
  join maxdat.INCIDENT_STATUS_HISTORY_SV a12   
       on (a11.INCIDENT_ID = a12.INCIDENT_ID)
  left outer join maxdat.D_APPEALS_CURRENT_REASONS_SV a13 
       on (a11.INCIDENT_ID = a13.INCIDENT_ID)
where a11.CUR_INCIDENT_ABOUT in ('Individual','Employee', 'Employer')
--and a11.FAIR_HEARING_TRACKING_NBR not like 'APM%'
   AND FAIR_HEARING_TRACKING_NBR not in ( select FAIR_HEARING_TRACKING_NBR from appeals_excluded where FAIR_HEARING_TRACKING_NBR  is not null )


   UNION ALL
   SELECT Program_Type,Date_Initiated,Appeal_ID,account_id,INCIDENT_REASON,initiated_count,1 
   FROM (
   select distinct
       Case when a11.CUR_INCIDENT_ABOUT in ('Individual') then a11.CUR_INCIDENT_ABOUT
       when a11.CUR_INCIDENT_ABOUT in ('Employee', 'Employer') then 'Small Business Marketplace'
       else NULL
       END as Program_Type,
       trunc(a11.CREATE_DATE) as Date_Initiated,
       a11.FAIR_HEARING_TRACKING_NBR as Appeal_ID,
       a11.account_id,
       a13.INCIDENT_REASON,
       1 as initiated_count,
       row_number () over ( partition by trunc(a11.CREATE_DATE), A11.FAIR_HEARING_TRACKING_NBR, A11.ACCOUNT_ID ORDER BY A11.ACCOUNT_ID ) AS RNK 
  from maxdat.D_APPEALS_CURRENT_SV            a11
  join maxdat.INCIDENT_STATUS_HISTORY_SV a12   
       on (a11.INCIDENT_ID = a12.INCIDENT_ID)
  left outer join maxdat.D_APPEALS_CURRENT_REASONS_SV a13 
       on (a11.INCIDENT_ID = a13.INCIDENT_ID)
where a11.CUR_INCIDENT_ABOUT in ('Individual','Employee', 'Employer')
--and a11.FAIR_HEARING_TRACKING_NBR  like 'APM%'
   AND FAIR_HEARING_TRACKING_NBR not in ( select FAIR_HEARING_TRACKING_NBR from appeals_excluded where FAIR_HEARING_TRACKING_NBR  is not null )

 )A
   WHERE A.RNK=1);
    
  

   
 
    grant select on D_NYHIX_APPEALS_SV  to MAXDAT_READ_ONLY; 