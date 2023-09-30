delete from corp_etl_list_lkup where name in ('ProcessMail_work_expected','ProcessMail_jeop_threshold','ProcessMail_timeli_threshold');

commit;

delete from bpm_attribute_staging_table where bsl_id = 9;
delete from bpm_attribute where bem_id = 9;
delete from bpm_attribute_lkup where bal_id between 413 and 450;

commit;


delete from D_MFDOC_DOC_TYPE where dmfdocdt_id > 265;
commit;


