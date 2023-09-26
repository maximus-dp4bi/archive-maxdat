-- establish a control count
select count(*) from nyhix_mfb_v2_maxdat_reporting_bak_20230101;

update maxdat.nyhix_mfb_v2_maxdat_reporting mdr
	set ENVELOPE_RECEIVED_DATE 
		= ( select ENVELOPE_RECEIVED_DATE
			from nyhix_mfb_v2_maxdat_reporting_bak_20230101 bak
			where bak.DB_RECORD_NUM = mdr.DB_RECORD_NUM 
		)
where DB_RECORD_NUM
in ( select DB_RECORD_NUM 
	from nyhix_mfb_v2_maxdat_reporting_bak_20230101 bak
	);
 
-- commit only if the rows updated match the contro count