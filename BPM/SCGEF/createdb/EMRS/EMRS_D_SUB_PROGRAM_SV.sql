IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_SUB_PROGRAM_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_SUB_PROGRAM_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_SUB_PROGRAM_SV
AS
 SELECT DISTINCT ct.display_name subprogram_name ,
    ct.coverage_type_code subprogram_code ,    
    pt.display_name parent_program_name ,
    CAST('01/01/1900' AS DATE) start_date,
    CAST('12/31/2050' AS DATE) end_date ,    
    pt.program_type_code plan_service_type
 FROM Landing.SC_Program_Group_Type_Crossref pg
  JOIN enrollment.coverage_type ct ON pg.coverage_type_id = ct.coverage_type_id
  JOIN enrollment.program_type pt ON pg.program_type_id = pt.program_type_id
  UNION ALL
  SELECT  'Undefined' subprogram_name, 	
        'UD' subprogram_code,        
	'NA' parent_program_name,
	CAST('01/01/1900' AS DATE) start_date ,   
       	CAST('12/31/2050' AS DATE) end_date ,  
	'NA' plan_service_type  

GO  