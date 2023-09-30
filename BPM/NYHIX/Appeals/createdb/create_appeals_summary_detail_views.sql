CREATE OR REPLACE VIEW   D_NYHIX_APPEALS_SUMMARY_SV 
as
select    count(distinct (Case when a11.CUR_INCIDENT_ABOUT in ('Individual') 
        then a11.FAIR_HEARING_TRACKING_NBR else NULL end))  count1,
                   count(distinct (Case when a11.CUR_INCIDENT_ABOUT in ('Employee', 'Employer') 
                   then a11.FAIR_HEARING_TRACKING_NBR else NULL end))  count2
from      maxdat.D_APPEALS_CURRENT_SV            a11
join maxdat.INCIDENT_STATUS_HISTORY_SV a12   on (a11.INCIDENT_ID = a12.INCIDENT_ID)
where  trunc(a11.CREATE_DATE) between To_Date('01-04-2019', 'dd-mm-yyyy') and To_Date('30-04-2019', 'dd-mm-yyyy')
        and a11.CUR_INCIDENT_ABOUT in ('Individual','Employee', 'Employer')
        and a12.CREATED_BY not like 'NY%'
        and a12.CREATED_BY not like '%-1000'
                              and a11.CUR_INCIDENT_STATUS <> 'Incident Closed – Duplicate' 
                              and (a11.FAIR_HEARING_TRACKING_NBR like 'AP%' or 
                                   (a11.FAIR_HEARING_TRACKING_NBR like 'APM%' and a11.account_id in
                                   (select account_id FROM (SELECT count(b.incident_id), b.account_id FROM MAXDAT.d_appeals_current b WHERE FAIR_HEARING_TRACKING_NBR like 'APM%' and 
              create_date > add_months(sysdate,-12) group by b.account_id 
              having count(b.incident_id) > 2))));

 grant select on D_NYHIX_APPEALS_SUMMARY_SV  to MAXDAT_READ_ONLY; 

CREATE OR REPLACE VIEW  D_NYHIX_APPEALS_SV 
as
select    distinct 
Case when a11.CUR_INCIDENT_ABOUT in ('Individual') then a11.CUR_INCIDENT_ABOUT
    when a11.CUR_INCIDENT_ABOUT in ('Employee', 'Employer') then 'Small Business Marketplace'
    else NULL
    END as Program_Type,
trunc(a11.CREATE_DATE) as Date_Initiated,
a11.FAIR_HEARING_TRACKING_NBR as Appeal_ID,
a11.account_id,
a13.INCIDENT_REASON,
1 as initiated_count
from      maxdat.D_APPEALS_CURRENT_SV            a11
join maxdat.INCIDENT_STATUS_HISTORY_SV a12   on (a11.INCIDENT_ID = a12.INCIDENT_ID)
left outer join        maxdat.D_APPEALS_CURRENT_REASONS_SV                 a13 on (a11.INCIDENT_ID = a13.INCIDENT_ID)
where  a11.CUR_INCIDENT_ABOUT in ('Individual','Employee', 'Employer')
        and a12.CREATED_BY not like 'NY%'
        and a12.CREATED_BY not like '%-1000'
                              and a11.CUR_INCIDENT_STATUS <> 'Incident Closed – Duplicate' 
                              and (a11.FAIR_HEARING_TRACKING_NBR like 'AP%' or 
                                   (a11.FAIR_HEARING_TRACKING_NBR like 'APM%' and a11.account_id in
                                   (select account_id FROM (SELECT count(b.incident_id), b.account_id FROM MAXDAT.d_appeals_current b WHERE FAIR_HEARING_TRACKING_NBR like 'APM%' and 
              create_date > add_months(sysdate,-12) group by b.account_id 
              having count(b.incident_id) > 2))));

 grant select on D_NYHIX_APPEALS_SV  to MAXDAT_READ_ONLY; 
