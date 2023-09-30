DELETE FROM PP_D_ACTUAL_DETAILS;
DELETE FROM PP_F_ACTUALS;
DELETE FROM PP_F_FORECAST;
DELETE FROM PP_FORECAST_NOTES;
DELETE FROM PP_D_PRODUCTION_PLAN_HORIZON;
DELETE FROM PP_STG_FORECAST;
DELETE FROM PP_CFG_HORIZON;
DELETE FROM pp_cfg_unit_of_work;
DELETE FROM PP_D_UOW_SOURCE_REF;
DELETE FROM pp_d_unit_of_work;
COMMIT;

insert into maxdat.pp_cfg_unit_of_work values (1, 'NYHIX_HSDE1', 'N', 'Minutes',10, 'CAL', 15, 'HSDE1');
insert into maxdat.pp_cfg_unit_of_work values (2, 'NYHIX_HSDE2', 'N', 'Minutes',2, 'CAL', 3, 'HSDE2');
insert into maxdat.pp_cfg_unit_of_work values (3, 'NYHIX_IMAGING_KQC', 'N', 'Minutes',1, 'CAL', 2, 'Imaging and K-QC');
insert into maxdat.pp_cfg_unit_of_work values (4, 'NYHIX_SHOPAPP', 'N', 'Minutes',10, 'CAL', 15, 'SHOP');
insert into maxdat.pp_cfg_unit_of_work values (5, 'NYHIX_DOCRES_ACCTCORR', 'N', 'Minutes',2, 'CAL', 3, 'Account Correction');
insert into maxdat.pp_cfg_unit_of_work values (6, 'NYHIX_COMPLAINT', 'N', 'Minutes',7, 'CAL', 10, 'Complaints');
insert into maxdat.pp_cfg_unit_of_work values (7, 'NYHIX_APPEAL', 'N', 'Minutes',2, 'CAL', 3, 'Appeals');
insert into maxdat.pp_cfg_unit_of_work values (8, 'NYHIX_DATAENTRY', 'N', 'Minutes',10, 'CAL', 15, 'Data Entry');
insert into maxdat.pp_cfg_unit_of_work values (9, 'NYHIX_DOCRES1', 'N', 'Minutes',1, 'CAL', 2, 'Doc Resolution 1');
insert into maxdat.pp_cfg_unit_of_work values (10, 'NYHIX_DOCRES2', 'N', 'Minutes',10, 'CAL', 15, 'Doc Resolution 2');
insert into maxdat.pp_cfg_unit_of_work values (11, 'NYHIX_LINKING', 'N', 'Minutes',2, 'CAL', 3, 'Linking');
insert into maxdat.pp_cfg_unit_of_work values (12, 'NYHIX_SHOPFM', 'N', 'Minutes',10, 'CAL', 15, 'FM');
insert into maxdat.pp_cfg_unit_of_work values (13, 'NYHIX_OTHER', 'N', 'Minutes',10, 'CAL', 15, 'Other');
insert into maxdat.pp_cfg_unit_of_work values (14, 'NYHIX_QC', 'N', 'Minutes',2, 'CAL', 3, 'QC');


insert into maxdat.pp_d_unit_of_work values (1, 'NYHIX_HSDE1', 'Minutes',10, 'HSDE1');
insert into maxdat.pp_d_unit_of_work values (2, 'NYHIX_HSDE2', 'Minutes',2, 'HSDE2');
insert into maxdat.pp_d_unit_of_work values (3, 'NYHIX_IMAGING_KQC', 'Minutes',1, 'Imaging and K-QC');
insert into maxdat.pp_d_unit_of_work values (4, 'NYHIX_SHOPAPP', 'Minutes',10, 'SHOP');
insert into maxdat.pp_d_unit_of_work values (5, 'NYHIX_DOCRES_ACCTCORR', 'Minutes',2, 'Account Correction');
insert into maxdat.pp_d_unit_of_work values (6, 'NYHIX_COMPLAINT', 'Minutes',7, 'Complaints');
insert into maxdat.pp_d_unit_of_work values (7, 'NYHIX_APPEAL', 'Minutes',2, 'Appeals');
insert into maxdat.pp_d_unit_of_work values (8, 'NYHIX_DATAENTRY', 'Minutes',10, 'Data Entry');
insert into maxdat.pp_d_unit_of_work values (9, 'NYHIX_DOCRES1', 'Minutes',1, 'Doc Resolution 1');
insert into maxdat.pp_d_unit_of_work values (10, 'NYHIX_DOCRES2', 'Minutes',10, 'Doc Resolution 2');
insert into maxdat.pp_d_unit_of_work values (11, 'NYHIX_LINKING', 'Minutes',2, 'Linking');
insert into maxdat.pp_d_unit_of_work values (12, 'NYHIX_SHOPFM', 'Minutes',10, 'FM');
insert into maxdat.pp_d_unit_of_work values (13, 'NYHIX_OTHER', 'Minutes',10, 'Other');
insert into maxdat.pp_d_unit_of_work values (14, 'NYHIX_QC', 'Minutes',2, 'QC');

INSERT INTO PP_D_UOW_SOURCE_REF SELECT 1, 1, 1, 'HIGH SPEED DATA ENTRY - FULL MASK', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 2, 2, 1, 'HIGH SPEED DATA ENTRY - SHORT MASK', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 3, 3, 1, 'KOFAX IMAGING AND QC', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 4, 4, 1, 'EMPLOYEE APPLICATION', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 5, 5, 1, 'ACCOUNT CORRECTION', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 6, 7, 1, 'EXISTING APPEAL', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 7, 6, 1, 'COMPLAINT', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 8, 7, 1, 'APPEAL', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 9, 7, 1, 'IDR INCIDENT OPEN', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 10, 7, 1, 'APPEAL INCIDENT OPEN', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 11, 7, 1, 'REFER TO ES-C', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 12, 7, 1, 'SCHEDULE HEARING', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 13, 8, 1, 'VERIFICATION DOCUMENT', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 14, 8, 1, 'APPLICATION IN PROCESS', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 15, 9, 1, 'HSDE-QC', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 16, 9, 1, 'FREE FORM TEXT', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 17, 10, 1, 'RETURNED MAIL', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 18, 10, 1, 'RETURNED MAIL - APPLICATION', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 19, 10, 1, 'ORPHAN DOCUMENT', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 20, 9, 1, 'WRONG PROGRAM', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 21, 11, 1, 'LINK DOCUMENT SET', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 22, 12, 1, 'FINANCIAL MANAGEMENT', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 23, 12, 1, 'FM RETURNED MAIL', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 24, 13, 1, 'OTHER', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 25, 14, 1, 'QUALITY CONTROL', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;

commit;

/