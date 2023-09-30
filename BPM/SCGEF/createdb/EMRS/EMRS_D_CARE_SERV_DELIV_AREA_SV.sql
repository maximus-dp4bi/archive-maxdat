IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_CARE_SERV_DELIV_AREA_SV', 'V') IS NOT NULL
  DROP VIEW [maxdat_support].[EMRS_D_CARE_SERV_DELIV_AREA_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW MAXDAT_SUPPORT.EMRS_D_CARE_SERV_DELIV_AREA_SV
AS
  SELECT region_code csda_code ,
    display_name csda_name     
  FROM organization.region r 
   JOIN organization.pca_region pr ON r.region_id = pr.region_id
  WHERE pr.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C' 
  UNION ALL
  SELECT 'UD' csda_code,      
        'Undefined' csda_name 

GO