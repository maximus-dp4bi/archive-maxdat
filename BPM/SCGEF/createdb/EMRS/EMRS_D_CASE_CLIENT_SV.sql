
IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_CASE_CLIENT_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].EMRS_D_CASE_CLIENT_SV
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_CASE_CLIENT_SV
AS
SELECT null cscl_status_begin_date
,null cscl_close_reason
,rt.case_relationship_type_code cscl_relationship_cd
,null cscl_elig_determination_date
,null cscl_medical_ind
,cr.case_id case_number
,cr.party_id client_number
,null cscl_status_end_date
,null cscl_byb_temp_id
,null cscl_appl_client_id
,null cscl_actual_term_date
,null cscl_pacmis_status_cd
,null cscl_legacy
,null rhsp
,null rhga
,'O' cscl_status_cd
,null cscl_adlk_id
,null cscl_res_addr_id
,null cscl_elig_begin_dt
,null cscl_elig_end_dt
,null anniversary_dt
,null program_status_cd
,null elig_begin_nd
,null episode_id
,null status_begin_ndt
,null status_end_ndt
,null change_notes
,null case_client_id
,null modified_date
,null modified_name
,null record_date
,null record_name
FROM enrollment.case_relationship cr
  JOIN enrollment.case_relationship_type rt ON cr.case_relationship_type_id = rt.case_relationship_type_id
GO
