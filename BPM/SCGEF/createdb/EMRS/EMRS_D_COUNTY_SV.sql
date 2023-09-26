IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_COUNTY_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_COUNTY_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW MAXDAT_SUPPORT.EMRS_D_COUNTY_SV
AS
  SELECT NULL plan_service_type ,        
    'SC' state ,
    county_code county_code ,
    NULL county_fips_code ,
    c.display_name county_name 
  FROM organization.county c    
  WHERE c.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C'
  UNION ALL
  SELECT NULL plan_service_type,      
	'NA' state, 
        'UD' county_code,  
	NULL county_fips_code,    
        'Undefined' county_name

GO