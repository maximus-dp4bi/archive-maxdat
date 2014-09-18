alter table CORP_ETL_MFB_BATCH_STG drop constraint CHECK_MFB_BS_BATCH_CLASS;
alter table CORP_ETL_MFB_BATCH_WIP drop constraint CHECK_MFB_BW_BATCH_CLASS;
alter table CORP_ETL_MFB_BATCH drop constraint CHECK_MFB_BATCH_BATCH_CLASS;


alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_BATCH_CLASS check (BATCH_CLASS in('NYSOH-INT-MAIL','NYHIXUAT - Individual Apps','SHOP Application SIT','NYHIXUAT - Individual Apps FAX','NYHIXINT ¿ Individual Apps','NYSOH-UAT-FAX','NYHIXINT- Individual Apps','NYHIXINT - Individual Apps','NYHIXPRD ¿ Individual Apps'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_BATCH_CLASS check (BATCH_CLASS in('NYSOH-INT-MAIL','NYHIXUAT - Individual Apps','SHOP Application SIT','NYHIXUAT - Individual Apps FAX','NYHIXINT ¿ Individual Apps','NYSOH-UAT-FAX','NYHIXINT- Individual Apps','NYHIXINT - Individual Apps','NYHIXPRD ¿ Individual Apps'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_BATCH_BATCH_CLASS check (BATCH_CLASS in('NYSOH-INT-MAIL','NYHIXUAT - Individual Apps','SHOP Application SIT','NYHIXUAT - Individual Apps FAX','NYHIXINT ¿ Individual Apps','NYSOH-UAT-FAX','NYHIXINT- Individual Apps','NYHIXINT - Individual Apps','NYHIXPRD ¿ Individual Apps'));



