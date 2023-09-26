use database MARS_DP4BI_DEV;
use database MARS_DP4BI_UAT;

use schema public;

CREATE OR REPLACE VIEW F_INBOUND_CORRESPONDENCE_DOCUMENTS_BY_DAY_SV AS
with mw as (select
                 d.D_DATE
                ,coalesce(d.project_id,ict.project_id) as PROJECT_ID
                ,icd.created_by_business_unit_name AS BUSINESS_UNIT
                ,ict.DOCUMENT_TYPE AS DOCUMENT_TYPE    
                ,ict.INBOUND_CORRESPONDENCE_CHANNEL_TYPE                  
                ,count(DISTINCT ict.project_id || ict.INBOUND_CORRESPONDENCE_ID) AS COUNT_INBOUND_CORRESPONDENCE
            from 
                PUBLIC.D_DATES d
            full join
                PUBLIC.ECMS_D_INBOUND_CORRESPONDENCE_DOCUMENTS_TASK_INSTANCE_SV ict on
                d.project_id = ict.project_id and
                d.d_date = ict.RECEIVED_DATE
            left join 
                ECMS_D_INBOUND_CORRESPONDENCE_DOCUMENTS_INSTANCE_SV icd on
                ict.inbound_correspondence_id = icd.inbound_correspondence_id
            left join -- Limit the date range
                (select project_id, min(TO_DATE(RECEIVED_DATE)) AS START_DATE from MARSDB.MARSDB_INBOUND_CORRESPONDENCE_VW ici group by project_id) icst on
                icst.project_id = d.project_id                
            where (d.d_date <= CURRENT_DATE() and 
                   d.d_date >= icst.START_DATE) or
                   d.d_date is null
            GROUP BY
                 D_DATE  
                ,d.PROJECT_ID
                ,icd.created_by_business_unit_name
                ,ict.project_id  
                ,ict.DOCUMENT_TYPE
                ,ict.INBOUND_CORRESPONDENCE_CHANNEL_TYPE)
select 
    *
from
    mw
;
