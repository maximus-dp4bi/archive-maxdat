IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_MEMBER_ADDRESS_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_MEMBER_ADDRESS_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_MEMBER_ADDRESS_SV
AS
 SELECT ad.address_id address_id
		,ad.street addr_street_1
		,ad.street2 addr_street_2
		,ad.city addr_city
		,ad.state addr_state_cd
		,ad.postal_code addr_zip
		,ad.zip_4 addr_zip_four
		,adt.address_code addr_type_cd
		,adt.display_name addr_type
		,c.display_name addr_country
		,cr.party_id client_number
		,null addr_attn
		,null addr_house_code
		,null addr_bar_code
		,null addr_origin_cd
		,null addr_staff_id
		,ct.county_code addr_ctlk_id
		,null addr_dolk_id
		,null addr_prov_id
		,null addr_payc_id
		,null addr_verified
		,null addr_bad_date
		,null addr_bad_date_satisfied
		,cr.case_id case_number
		,19000101000000 start_ndt
		,20501231000000 end_ndt
		,ad.created_date record_date	
		,ad.created_by_id record_name
		,ad.modified_date modified_date
		,ad.modified_by_id modified_name
		,CAST('01/01/1900' AS DATE) source_addr_begin_date
		,CAST('12/31/2050' AS DATE) source_addr_end_date
  FROM organization.address ad
    JOIN organization.party_address pa ON ad.address_id = pa.address_id
    JOIN enrollment.case_entity ce ON pa.party_id = ce.head_of_household_id
    JOIN enrollment.case_relationship cr ON ce.case_id = cr.case_id
    JOIN organization.address_type adt ON ad.address_type_id = adt.address_type_id
    JOIN organization.country c ON ad.country_id = c.country_id
    JOIN organization.county ct ON ad.county_id = ct.county_id 
GO