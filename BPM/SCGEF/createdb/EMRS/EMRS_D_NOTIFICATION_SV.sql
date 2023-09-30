IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_NOTIFICATION_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_NOTIFICATION_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_NOTIFICATION_SV AS
SELECT  hmd.member_detail_id notification_id
       ,hmd.sent_to_pbe_date send_date
	   ,hmd.loop_2000_ins03 maintenance_type_cd
	   ,hmd.loop_2000_ins04 maintenance_reason
	   ,hmd.created_by record_name
	   ,hmd.created_date record_date
	   ,hmd.coverage_id selection_segment_id
	   ,hmd.received_from_mmis_date received_date_mmis
	   ,hmd.sent_to_mmis_date sent_date_mmis
	   ,pbe.provider_business_entity_program_id plan_id
	   ,hmd.file_type file_type
	   ,hmd.transaction_status transaction_status
	   ,hmd.gef_processing_action processing_action
FROM enrollment.holding_member_detail hmd
  JOIN enrollment.provider_business_entity_program pbe ON hmd.trading_partner_party_id = pbe.provider_business_entity_id

 GO