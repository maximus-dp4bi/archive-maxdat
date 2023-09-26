IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_CELL_PHONE_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_CELL_PHONE_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_CELL_PHONE_SV
AS
 SELECT pci.contact_info_id phone_id
,CAST('01/01/1900' AS DATE) source_phone_begin_date
,ct.contact_info_type_code phon_type_cd
,ct.display_name phone_type
,CAST('12/31/2050' AS DATE) source_phone_end_date
,cr.party_id client_number 
,CAST(SUBSTRING(contact_info,1,3) AS CHAR(3)) phon_area_code
,CAST(SUBSTRING(contact_info,4,7) AS CHAR(7)) phon_phone_number
,NULL phon_ext
,NULL phon_prov_id
,NULL phon_cntt_id
,NULL phon_dolk_id
,ci.created_by_id record_name
,CAST(ci.created_date AS DATE) record_date
,ci.modified_by_id modified_name
,CAST(ci.modified_date AS DATE) modified_date
,ce.case_id case_number
,19000101000000 start_ndt
,20501231000000 end_ndt
,NULL phon_carrier_info
,NULL sms_enabled_ind
,NULL phon_bad_date
,NULL phon_bad_date_satisfied
FROM organization.party_contact_info pci
  JOIN organization.contact_info ci ON pci.contact_info_id = ci.contact_info_id
  JOIN organization.contact_info_type ct ON ci.contact_info_type_id = ct.contact_info_type_id
  JOIN enrollment.case_entity ce ON pci.party_id = ce.head_of_household_id
  JOIN enrollment.case_relationship cr ON ce.case_id = cr.case_id
WHERE ct.contact_info_type_code = 'cell'
GO