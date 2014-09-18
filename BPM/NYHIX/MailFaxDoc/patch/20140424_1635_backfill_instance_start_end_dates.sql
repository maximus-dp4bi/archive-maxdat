--cron job has to be turned off while this update is running

alter trigger TRG_BIU_NYHIX_ETL_MFD disable;
alter trigger TRG_AI_NYHIX_ETL_MFD_Q disable;
alter trigger TRG_AU_NYHIX_ETL_MFD_Q disable;

--set the create date of some records to the original create date from the source. These records were previously updated to scan date in a previous patch
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2031-11-07 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10004236';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009683';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009684';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009685';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009686';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009687';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009688';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009692';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009693';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009694';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009695';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009698';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009699';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009701';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009706';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009707';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009708';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009709';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009710';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009721';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009731';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009732';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009733';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009734';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2031-12-19 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10032330';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-01-16 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10044506';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-01-24 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10060938';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-27 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10101141';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-27 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10101142';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-17 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10101486';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138360';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138361';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138362';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138363';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138364';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138365';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138366';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138367';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138368';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138369';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138370';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138371';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138372';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138373';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138374';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138375';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138376';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138377';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138378';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138379';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138380';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138381';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138382';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138383';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138384';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138385';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138386';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138387';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138388';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138389';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138390';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138391';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138392';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138393';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138394';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138395';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138396';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138397';
update NYHIX_ETL_MAIL_FAX_DOC set CREATE_DT= to_date('2014-12-30 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10145154';

update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2031-11-07 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10004236';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009683';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009684';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009685';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009686';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009687';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009688';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009692';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009693';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009694';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009695';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009698';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009699';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009701';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009706';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009707';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009708';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009709';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009710';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009721';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009731';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009732';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009733';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-04 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10009734';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2031-12-19 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10032330';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-01-16 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10044506';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-01-24 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10060938';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-27 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10101141';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-27 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10101142';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-17 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10101486';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138360';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138361';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138362';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138363';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138364';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138365';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138366';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138367';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138368';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138369';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138370';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138371';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138372';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138373';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138374';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138375';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138376';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138377';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138378';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138379';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138380';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138381';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138382';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138383';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138384';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138385';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138386';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138387';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138388';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138389';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138390';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138391';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138392';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138393';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138394';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138395';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138396';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-14 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10138397';
update D_NYHIX_MFD_CURRENT set CREATE_DT= to_date('2014-12-30 00:00:00','YYYY-MM-DD HH24:MI:SS') where dcn = '10145154';

commit;


--Backfill Instance Start and End Dates for Complete instances
DECLARE  
CURSOR cmfd_cur IS

  SELECT eemfdb_id, stg_extract_dt, stg_last_update_dt, instance_start_date,
    CASE WHEN complete_dt IS NOT NULL AND complete_dt >= instance_start_date THEN complete_dt
      ELSE CASE WHEN cancel_dt IS NOT NULL AND cancel_dt >= instance_start_date THEN cancel_dt
         ELSE stg_last_update_dt END END instance_end_date
  FROM(
  SELECT eemfdb_id,stg_extract_dt, stg_last_update_dt,cancel_dt, complete_dt,
    CASE WHEN create_dt >= TO_DATE('10-01-2013','MM-DD-YYYY') AND create_dt <= scan_dt AND create_dt <= SYSDATE THEN create_dt 
          ELSE CASE WHEN scan_dt  >= TO_DATE('10-01-2013','MM-DD-YYYY') AND scan_dt <= origination_dt AND scan_dt <= SYSDATE THEN scan_dt
                  ELSE CASE WHEN origination_dt >= TO_DATE('10-01-2013','MM-DD-YYYY') AND origination_dt <= SYSDATE THEN origination_dt 
                     ELSE stg_extract_dt END END END instance_start_date
  FROM NYHIX_ETL_MAIL_FAX_DOC
  WHERE complete_dt IS NOT NULL);
   
   TYPE t_cmfd_tab IS TABLE OF cmfd_cur%ROWTYPE INDEX BY PLS_INTEGER;
   cmfd_tab t_cmfd_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN cmfd_cur;
   LOOP
     FETCH cmfd_cur BULK COLLECT INTO cmfd_tab LIMIT v_bulk_limit;
     EXIT WHEN cmfd_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..cmfd_tab.COUNT
         UPDATE NYHIX_ETL_MAIL_FAX_DOC
         SET instance_start_date = cmfd_tab(indx).instance_start_date
             ,instance_end_date = cmfd_tab(indx).instance_end_date
         WHERE eemfdb_id = cmfd_tab(indx).eemfdb_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE cmfd_cur;
END;
/

--Backfill Instance Start Date for Active instances
DECLARE  
CURSOR amfd_cur IS
  SELECT eemfdb_id,stg_extract_dt, stg_last_update_dt,
    CASE WHEN create_dt >= TO_DATE('10-01-2013','MM-DD-YYYY') AND create_dt <= scan_dt AND create_dt <= SYSDATE THEN create_dt 
          ELSE CASE WHEN scan_dt  >= TO_DATE('10-01-2013','MM-DD-YYYY') AND scan_dt <= origination_dt AND scan_dt <= SYSDATE THEN scan_dt
                  ELSE CASE WHEN origination_dt >= TO_DATE('10-01-2013','MM-DD-YYYY') AND origination_dt <= SYSDATE THEN origination_dt 
                     ELSE SYSDATE END END END instance_start_date 
  FROM NYHIX_ETL_MAIL_FAX_DOC
  WHERE instance_status = 'Active';
   
   TYPE t_amfd_tab IS TABLE OF amfd_cur%ROWTYPE INDEX BY PLS_INTEGER;
   amfd_tab t_amfd_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN amfd_cur;
   LOOP
     FETCH amfd_cur BULK COLLECT INTO amfd_tab LIMIT v_bulk_limit;
     EXIT WHEN amfd_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..amfd_tab.COUNT
         UPDATE NYHIX_ETL_MAIL_FAX_DOC
         SET instance_start_date = amfd_tab(indx).instance_start_date             
         WHERE eemfdb_id = amfd_tab(indx).eemfdb_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE amfd_cur;
END;
/


--Backfill Instance Start and End Dates for current dimension
DECLARE  
CURSOR mfdcur_cur IS
   SELECT nyhix_mfd_bi_id, mfd.instance_start_date, mfd.instance_end_date
   FROM NYHIX_ETL_MAIL_FAX_DOC mfd, D_NYHIX_MFD_CURRENT cur
   WHERE mfd.dcn = cur.dcn;
   
   TYPE t_mfdcur_tab IS TABLE OF mfdcur_cur%ROWTYPE INDEX BY PLS_INTEGER;
   mfdcur_tab t_mfdcur_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN mfdcur_cur;
   LOOP
     FETCH mfdcur_cur BULK COLLECT INTO mfdcur_tab LIMIT v_bulk_limit;
     EXIT WHEN mfdcur_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..mfdcur_tab.COUNT
         UPDATE D_NYHIX_MFD_CURRENT
         SET instance_start_date = mfdcur_tab(indx).instance_start_date   
             ,instance_end_date = mfdcur_tab(indx).instance_end_date
         WHERE nyhix_mfd_bi_id = mfdcur_tab(indx).nyhix_mfd_bi_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE mfdcur_cur;
END;
/

alter table f_nyhix_mfd_by_date enable row movement;

--Fix the bucket start date and d_date of records with invalid/future date and those that were previously updated to scan date
 DECLARE  
CURSOR cfmfd_cur IS

  SELECT f.fnmfdbd_id, cmfd.instance_start_date instance_start_date 
  FROM F_NYHIX_MFD_BY_DATE f,D_NYHIX_MFD_CURRENT cmfd
  WHERE f.nyhix_mfd_bi_id = cmfd.nyhix_mfd_bi_id
  AND creation_count = 1
  AND (d_date > SYSDATE
   OR substr(to_char(d_date,'mm/dd/yyyy'),7,1) = '0'
   OR cmfd.dcn in('10004236','10009683','10009684','10009685','10009686','10009687','10009688','10009692','10009693','10009694','10009695','10009698','10009699',
'10009701','10009706','10009707','10009708','10009709','10009710','10009721','10009731','10009732','10009733','10009734','10032330','10044506','10060938','10101141',
'10101142','10101486','10138360','10138361','10138362','10138363','10138364','10138365','10138366','10138367','10138368','10138369','10138370','10138371','10138372',
'10138373','10138374','10138375','10138376','10138377','10138378','10138379','10138380','10138381','10138382','10138383','10138384','10138385','10138386','10138387',
'10138388','10138389','10138390','10138391','10138392','10138393','10138394','10138395','10138396','10138397','10145154',
'10044503','10044504','10044505','10060935','10060936','10060937','10060938','10181592','10181593','10181594','10181595','10181600','10181602','10181603','10181598'));
   
   TYPE t_cfmfd_tab IS TABLE OF cfmfd_cur%ROWTYPE INDEX BY PLS_INTEGER;
   cfmfd_tab t_cfmfd_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN cfmfd_cur;
   LOOP
     FETCH cfmfd_cur BULK COLLECT INTO cfmfd_tab LIMIT v_bulk_limit;
     EXIT WHEN cfmfd_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..cfmfd_tab.COUNT
         UPDATE F_NYHIX_MFD_BY_DATE
         SET bucket_start_date =  cfmfd_tab(indx).instance_start_date,
             d_date =  cfmfd_tab(indx).instance_start_date
         WHERE fnmfdbd_id = cfmfd_tab(indx).fnmfdbd_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE cfmfd_cur;
END;
/

UPDATE F_NYHIX_MFD_BY_DATE
SET bucket_start_date =  bucket_end_date,
     d_date = bucket_end_date
WHERE fnmfdbd_id= 18722172;

 DECLARE  
CURSOR cfmfd_cur IS

  SELECT f.fnmfdbd_id, cmfd.instance_start_date instance_start_date 
  FROM F_NYHIX_MFD_BY_DATE f,D_NYHIX_MFD_CURRENT cmfd
  WHERE f.nyhix_mfd_bi_id = cmfd.nyhix_mfd_bi_id
  AND creation_count = 1
  AND cmfd.instance_start_date <> f.d_date;
  
   TYPE t_cfmfd_tab IS TABLE OF cfmfd_cur%ROWTYPE INDEX BY PLS_INTEGER;
   cfmfd_tab t_cfmfd_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN cfmfd_cur;
   LOOP
     FETCH cfmfd_cur BULK COLLECT INTO cfmfd_tab LIMIT v_bulk_limit;
     EXIT WHEN cfmfd_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..cfmfd_tab.COUNT
         UPDATE F_NYHIX_MFD_BY_DATE
         SET bucket_start_date =  TRUNC(cfmfd_tab(indx).instance_start_date),
             d_date =  cfmfd_tab(indx).instance_start_date
         WHERE fnmfdbd_id = cfmfd_tab(indx).fnmfdbd_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE cfmfd_cur;
END;
/

 DECLARE  
CURSOR cfmfd_cur IS

  SELECT f.fnmfdbd_id, TRUNC(cmfd.instance_end_date) instance_end_date 
  FROM F_NYHIX_MFD_BY_DATE f,D_NYHIX_MFD_CURRENT cmfd
  WHERE f.nyhix_mfd_bi_id = cmfd.nyhix_mfd_bi_id
  AND completion_count = 1
  AND cmfd.instance_end_date IS NOT NULL
  AND TRUNC(cmfd.instance_end_date) <> f.bucket_end_date;
  
   TYPE t_cfmfd_tab IS TABLE OF cfmfd_cur%ROWTYPE INDEX BY PLS_INTEGER;
   cfmfd_tab t_cfmfd_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN cfmfd_cur;
   LOOP
     FETCH cfmfd_cur BULK COLLECT INTO cfmfd_tab LIMIT v_bulk_limit;
     EXIT WHEN cfmfd_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..cfmfd_tab.COUNT
         UPDATE F_NYHIX_MFD_BY_DATE
         SET bucket_end_date =  cfmfd_tab(indx).instance_end_date           
         WHERE fnmfdbd_id = cfmfd_tab(indx).fnmfdbd_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE cfmfd_cur;
END;
/


COMMIT;

alter table f_nyhix_mfd_by_date disable row movement;

alter trigger TRG_BIU_NYHIX_ETL_MFD enable;
alter trigger TRG_AI_NYHIX_ETL_MFD_Q enable;
alter trigger TRG_AU_NYHIX_ETL_MFD_Q enable;


