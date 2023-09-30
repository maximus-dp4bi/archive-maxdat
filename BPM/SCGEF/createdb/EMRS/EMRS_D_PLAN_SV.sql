IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_PLAN_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_PLAN_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


 CREATE VIEW MAXDAT_SUPPORT.EMRS_D_PLAN_SV
AS
  SELECT pe.created_by_id record_name,
    pep.provider_business_entity_program_id plan_id,    
    pep.provider_business_entity_code plan_code,
    pe.name plan_name,
    pe.name plan_abbreviation,
    pep.enrollment_valid_from plan_effective_date,
    NULL address1,
    NULL address2,
    NULL city,
    NULL state,
    NULL zip,
    CASE WHEN pep.enrollment_valid_until > getdate() THEN 'Y' ELSE 'N'  END active, 
    CASE WHEN pep.enrollment_valid_until > getdate() THEN 'Y' ELSE 'N'  END  enrollok,
    CASE WHEN auto_assign_applicable = 1 THEN 'Y' ELSE 'N' END plan_assign,
    pe.created_date record_date,        
    'MEDICAL' plan_type,
    pt.program_type_code plan_service_type    
  FROM enrollment.provider_business_entity pe
    JOIN enrollment.provider_business_entity_program pep ON pe.provider_business_entity_id = pep.provider_business_entity_id
    JOIN enrollment.program_type pt ON pep.program_type_id = pt.program_type_id
    JOIN enrollment.pca_program_type ppt ON pt.program_type_id = ppt.program_type_id
  WHERE ppt.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C'
  UNION ALL
  SELECT NULL record_name,
       --  CAST('00000000-0000-0000-0000-000000000000' as uniqueidentifier) plan_id,
         -1 plan_id,	
         'UD' plan_code,  
	 'Undefined' plan_name, 	
	 'Undefined' plan_abbreviation,  
         CAST('01/01/1900' AS DATE) plan_effective_date, 
	 NULL address1,
	 NULL address2,
	 NULL city,
	 NULL state,
	 NULL zip,
	 'N' active,
	 'N' enrollok,
	 'N' plan_assign,
	 NULL record_date,
	 'NA' plan_type,
	 'NA' plan_service_type  
  UNION ALL  
  SELECT NULL record_name,       
         0 plan_id,	
      'FFS' plan_code,  
	 'FFS' plan_name, 	
	 'FFS' plan_abbreviation,  
     CAST('01/01/1900' AS DATE) plan_effective_date, 
	 NULL address1,
	 NULL address2,
	 NULL city,
	 NULL state,
	 NULL zip,
	 'N' active,
	 'N' enrollok,
	 'N' plan_assign,
	 NULL record_date,
	 'NA' plan_type,
	 'NA' plan_service_type  
GO