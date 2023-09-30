IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_PROGRAM_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_PROGRAM_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_PROGRAM_SV
AS
SELECT program_type_code program_code ,
    display_name program_name ,
    CASE WHEN enabled_flag =1  THEN 'A' ELSE 'I' END active_inactive ,
    CAST('12/31/2050' AS DATE) end_date ,
    NULL program_category ,    
    CAST('01/01/1900' AS DATE) start_date
  FROM enrollment.program_type pt
    JOIN enrollment.pca_program_type ppt ON pt.program_type_id = ppt.program_type_id
  WHERE ppt.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C' 
  UNION ALL
  SELECT 'UD' program_code,  
	 'Undefined' program_name, 	  
         'N' active_inactive,
	 CAST('12/31/2050' AS DATE) end_date ,  
	 NULL program_category , 
	 CAST('01/01/1900' AS DATE) start_date

GO 