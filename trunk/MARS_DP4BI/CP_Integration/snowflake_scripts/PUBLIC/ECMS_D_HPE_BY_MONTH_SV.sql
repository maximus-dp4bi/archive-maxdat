CREATE OR REPLACE VIEW PUBLIC.ECMS_D_HPE_BY_MONTH_SV AS
WITH mw AS(
      select 
          res.month
    	    ,res.project_id
         ,res.program_id
         ,res.provider_name
         ,res2.count_applications
         ,res.count_spanish_notices
         ,res.count_final_approvals
         ,res.count_final_denials
         ,res.count_initial_approvals
         ,res.count_initial_denials
         ,res.count_pending
         ,'UNKNOWN' as count_notify_provider
          from 
  (select
    month(date) || '/' || year(date) as month
    ,project_id as project_id
    ,program_id as program_id
    ,provider_name as provider_name
    --,sum(count_applications) as count_applications
    ,sum(count_spanish_notices) as count_spanish_notices
    --,sum(count_npi_submissions) as count_npi_submissions--
    ,sum(count_final_approvals) as count_final_approvals
    ,sum(count_final_denials) as count_final_denials
    ,sum(count_initial_denials) as count_initial_denials
    ,sum(count_initial_approvals) as count_initial_approvals
    ,sum(count_pending) as count_pending
    ,sum(count_notify_provider) as count_notify_provider
  FROM (
SELECT 
    dd.d_date as date
    ,hpe.project_id as project_id
    ,'UNKNOWN' as program_id
    ,nvl(hpe.provider_name,'NONE') as provider_name
    ,case when upper(hpe.language) = 'SPANISH' then 1 else 0 end as count_spanish_notices
    ,case when upper(hpe.final_determination) = 'APPROVED' then 1 else 0 end as count_final_approvals
    ,case when upper(hpe.final_determination) = 'DENIED' then 1 else 0 end as count_final_denials
    ,case when upper(hpe.initial_determination) = 'INITIAL DENIAL' then 1 else 0 end as count_initial_denials
    ,case when upper(hpe.initial_determination) = 'INITIAL APPROVAL' then 1 else 0 end as count_initial_approvals
    ,case when hpe.hpe_exception is not null then 1 else 0 end as count_pending
    ,case when 1=1 then 1 else 0 end as count_notify_provider
  
  from PUBLIC.ECMS_D_HPE_INSTANCE_SV hpe
  join public.d_dates dd
  on hpe.receipt_date = dd.d_date
  and hpe.project_id = dd.project_id
  ) group by 1,2,3,4
 
  ) res
  left outer join 
  
  ( select
     month(dd.d_date) || '/' || year(dd.d_date) as month
    ,hpe.project_id as project_id
    ,'UNKNOWN' as program_id
    ,nvl(hpe.provider_name,'NONE') as provider_name
    ,count (distinct hpe.document_id) as count_applications
    from PUBLIC.ECMS_D_HPE_INSTANCE_SV hpe
    join public.d_dates dd
    on hpe.receipt_date = dd.d_date
    and hpe.project_id = dd.project_id
    group by 1,2,3,4) res2 
  
  on res.month = res2.month
  and res.project_id = res2.project_id
  and res.program_id = res2.program_id
  and res.provider_name = res2.provider_name
)

SELECT mw.*    
FROM mw;