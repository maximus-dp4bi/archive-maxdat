alter  maxdat.trigger TRG_BIU_NYHIX_ETL_MFD_V2 disable;

update maxdat.nyhix_etl_mail_fax_doc_v2
set instance_end_date=complete_dt
where kofax_dcn in  ('A16293DABF001','A17004EDAF001','A17006FEEA001','A16357C1FE001','A163579AAA001',
'A17005F5EE001','A17006FFC4001','A17006FF8E001','A17005F9F6001','A1635698D0001');
commit;
alter maxdat.trigger TRG_BIU_NYHIX_ETL_MFD_V2 enable;
