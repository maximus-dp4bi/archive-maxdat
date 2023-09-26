Alter table TX_ETL_L_ELIG_DAILY MODIFY (
mail_city                    VARCHAR2(25),
res_city                     VARCHAR2(25)
);

ALTER TABLE TX_ETL_L_ELIG_DAILY ADD (
recordcontent                VARCHAR2(2600),
   recordcontent_hash           NUMBER(38),
   stage2_flag                  NUMBER(1),
   demographic_hash             VARCHAR2(32),
   demographic_change_ind       VARCHAR2(1),
   eligibility_hash             VARCHAR2(32),
   eligibility_change_ind       VARCHAR2(1),
   enrollment_hash              VARCHAR2(32),
   enrollment_change_ind        VARCHAR2(1),
   process_ts                   DATE,
   error_text                   VARCHAR2(2600),
   reprocessed_job_id           NUMBER,
   med_suppressed_ssi1          VARCHAR2(1),
   med_suppressed_ssi2          VARCHAR2(1),
   med_suppressed_ssi3          VARCHAR2(1),
   med_suppressed_ssi4          VARCHAR2(1),
   med_suppressed_ssi5          VARCHAR2(1),
   med_suppressed_ssi6          VARCHAR2(1),
   med_suppressed_ssi7          VARCHAR2(1),
   med_suppressed_ssi8          VARCHAR2(1),
   med_suppressed_ssi9          VARCHAR2(1),
   med_suppressed_ssi10         VARCHAR2(1),
   med_suppressed_ssi11         VARCHAR2(1),
   med_suppressed_ssi12         VARCHAR2(1),
   provider_activity_type1_bkp      VARCHAR2(2),
   provider_activity_type2_bkp      VARCHAR2(2),
   provider_activity_type3_bkp      VARCHAR2(2),
   provider_activity_type4_bkp      VARCHAR2(2),
   provider_activity_type5_bkp      VARCHAR2(2),
   provider_activity_type6_bkp      VARCHAR2(2),
   provider_activity_type7_bkp      VARCHAR2(2),
   provider_activity_type8_bkp      VARCHAR2(2),
   provider_activity_type9_bkp      VARCHAR2(2),
   provider_activity_type10_bkp     VARCHAR2(2),
   mbi                          VARCHAR2(11),
   client_prefix_name           VARCHAR2(4),
   client_first_name            VARCHAR2(30),
   client_mid_name              VARCHAR2(30),
   client_last_name             VARCHAR2(30),
   client_sufx_name             VARCHAR2(4),
   edg_prefix_name              VARCHAR2(4),
   edg_first_name               VARCHAR2(30),
   edg_mid_name                 VARCHAR2(30),
   edg_last_name                VARCHAR2(30),
   edg_sufx_name                VARCHAR2(4),
   hoh_prefix_name              VARCHAR2(4),
   hoh_first_name               VARCHAR2(30),
   hoh_mid_name                 VARCHAR2(30),
   hoh_last_name                VARCHAR2(30),
   hoh_sufx_name                VARCHAR2(4),
   guardian_prefix_name         VARCHAR2(4),
   guardian_first_name          VARCHAR2(30),
   guardian_mid_name            VARCHAR2(30),
   guardian_last_name           VARCHAR2(30),
   guardian_sufx_name           VARCHAR2(4),
   mail_addr_st_num             VARCHAR2(6),
   mail_addr_st_num_frac        VARCHAR2(3),
   mail_addr_st_dir             VARCHAR2(2),
   mail_addr_st_name            VARCHAR2(30),
   mail_addr_st_type            VARCHAR2(4),
   mail_addr_dwelling_type_cd   VARCHAR2(4),
   mail_addr_apt_num            VARCHAR2(8),
   mail_addr_line               VARCHAR2(50),
   res_addr_st_num              VARCHAR2(6),
   res_addr_st_num_frac         VARCHAR2(3),
   res_addr_st_dir              VARCHAR2(2),
   res_addr_st_name             VARCHAR2(30),
   res_addr_st_type             VARCHAR2(4),
   res_addr_dwelling_type_cd    VARCHAR2(4),
   res_addr_apt_num             VARCHAR2(8),
   res_addr_line                VARCHAR2(50)
   );
   
Alter table TX_ETL_L_ELIGIBILITY MODIFY (
mail_city                    VARCHAR2(25),
res_city                     VARCHAR2(25)
);

ALTER TABLE TX_ETL_L_ELIGIBILITY ADD (
recordcontent                VARCHAR2(2600),
   recordcontent_hash           NUMBER(38),
   stage2_flag                  NUMBER(1),
   demographic_hash             VARCHAR2(32),
   demographic_change_ind       VARCHAR2(1),
   eligibility_hash             VARCHAR2(32),
   eligibility_change_ind       VARCHAR2(1),
   enrollment_hash              VARCHAR2(32),
   enrollment_change_ind        VARCHAR2(1),
   process_ts                   DATE,
   error_text                   VARCHAR2(2600),
   reprocessed_job_id           NUMBER,
   med_suppressed_ssi1          VARCHAR2(1),
   med_suppressed_ssi2          VARCHAR2(1),
   med_suppressed_ssi3          VARCHAR2(1),
   med_suppressed_ssi4          VARCHAR2(1),
   med_suppressed_ssi5          VARCHAR2(1),
   med_suppressed_ssi6          VARCHAR2(1),
   med_suppressed_ssi7          VARCHAR2(1),
   med_suppressed_ssi8          VARCHAR2(1),
   med_suppressed_ssi9          VARCHAR2(1),
   med_suppressed_ssi10         VARCHAR2(1),
   med_suppressed_ssi11         VARCHAR2(1),
   med_suppressed_ssi12         VARCHAR2(1),
   provider_activity_type1_bkp      VARCHAR2(2),
   provider_activity_type2_bkp      VARCHAR2(2),
   provider_activity_type3_bkp      VARCHAR2(2),
   provider_activity_type4_bkp      VARCHAR2(2),
   provider_activity_type5_bkp      VARCHAR2(2),
   provider_activity_type6_bkp      VARCHAR2(2),
   provider_activity_type7_bkp      VARCHAR2(2),
   provider_activity_type8_bkp      VARCHAR2(2),
   provider_activity_type9_bkp      VARCHAR2(2),
   provider_activity_type10_bkp     VARCHAR2(2),
   mbi                          VARCHAR2(11),
   client_prefix_name           VARCHAR2(4),
   client_first_name            VARCHAR2(30),
   client_mid_name              VARCHAR2(30),
   client_last_name             VARCHAR2(30),
   client_sufx_name             VARCHAR2(4),
   edg_prefix_name              VARCHAR2(4),
   edg_first_name               VARCHAR2(30),
   edg_mid_name                 VARCHAR2(30),
   edg_last_name                VARCHAR2(30),
   edg_sufx_name                VARCHAR2(4),
   hoh_prefix_name              VARCHAR2(4),
   hoh_first_name               VARCHAR2(30),
   hoh_mid_name                 VARCHAR2(30),
   hoh_last_name                VARCHAR2(30),
   hoh_sufx_name                VARCHAR2(4),
   guardian_prefix_name         VARCHAR2(4),
   guardian_first_name          VARCHAR2(30),
   guardian_mid_name            VARCHAR2(30),
   guardian_last_name           VARCHAR2(30),
   guardian_sufx_name           VARCHAR2(4),
   mail_addr_st_num             VARCHAR2(6),
   mail_addr_st_num_frac        VARCHAR2(3),
   mail_addr_st_dir             VARCHAR2(2),
   mail_addr_st_name            VARCHAR2(30),
   mail_addr_st_type            VARCHAR2(4),
   mail_addr_dwelling_type_cd   VARCHAR2(4),
   mail_addr_apt_num            VARCHAR2(8),
   mail_addr_line               VARCHAR2(50),
   res_addr_st_num              VARCHAR2(6),
   res_addr_st_num_frac         VARCHAR2(3),
   res_addr_st_dir              VARCHAR2(2),
   res_addr_st_name             VARCHAR2(30),
   res_addr_st_type             VARCHAR2(4),
   res_addr_dwelling_type_cd    VARCHAR2(4),
   res_addr_apt_num             VARCHAR2(8),
   res_addr_line                VARCHAR2(50)
   );
   
