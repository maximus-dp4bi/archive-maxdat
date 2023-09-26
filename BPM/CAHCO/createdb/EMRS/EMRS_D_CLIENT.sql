CREATE SEQUENCE  "EMRS_SEQ_CLIENT_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_CLIENT_ID" TO "MAXDAT_READ_ONLY";

DROP TABLE EMRS_D_CLIENT;
DROP TRIGGER BIR_CLIENTS ;
DROP TRIGGER BUR_CLIENTS ;

-- Create table
create table EMRS_D_CLIENT
(
  dp_client_id                         NUMBER not null,
  case_number                          NUMBER,
  client_number                        NUMBER,
  cin                                  VARCHAR2(9),
  addressokflag                        VARCHAR2(1),
  aidcode                              VARCHAR2(2),
  aliencode                            VARCHAR2(1),
  assigninthiscounty                   VARCHAR2(1),
  dob                                  DATE,
  hcoclosedate                         DATE,
  othhealthcoveragecode                VARCHAR2(1),
  oldmedicalstatus                     VARCHAR2(1),
  olddentalstaus                       VARCHAR2(1),
  firstname                            VARCHAR2(20),
  middleinitial                        VARCHAR2(1),
  lastname                             VARCHAR2(20),
  sex		                       VARCHAR2(1),
  eligibilityworkernum                 VARCHAR2(4),
  ethniccode                           VARCHAR2(1),
  participantlang                      VARCHAR2(1),
  writtenlangcode                      VARCHAR2(1),
  mcalplnmedsstatus                    VARCHAR2(2),
  dtlmedshcpstatus                     VARCHAR2(2),
  medicalid                            VARCHAR2(14),
  mandatorvolunstatus                  VARCHAR2(1),
  mandatorycounty                      VARCHAR2(1),
  denvolstatus                         VARCHAR2(1),
  maximusstatus                        VARCHAR2(1),
  isdualeligible                       VARCHAR2(1),
  isgrandfatherdlelig                  VARCHAR2(1),
  grandfatherdleligplan                VARCHAR2(3),
  alowedplanfordlelig                  VARCHAR2(3),
  medsfilecreationdate                 DATE,
  transmitdate                         DATE,
  pregnancyduedate                     DATE,
  exemptedbydr                         VARCHAR2(1),
  medicalexemption                     VARCHAR2(1),
  exemptionenddate                     DATE,
  dentalexemption                      VARCHAR2(1),
  dentalexempenddate                   DATE,
  ccsindicator                         VARCHAR2(1),
  icfindicator                         VARCHAR2(1),
  medicarecarriercode                  VARCHAR2(4),
  medicareindicator                    VARCHAR2(3),
  isnonmeds                            VARCHAR2(1),
  switchtomeds                         VARCHAR2(1),
  switchtomedsdate                     DATE,
  medicalpktrequested                  VARCHAR2(1),
  mpacketstatus                        VARCHAR2(1),
  dentalpktrequested                   VARCHAR2(1),
  dpacketstatus                        VARCHAR2(1),
  donotbulkemail                       VARCHAR2(1),
  donotbulkpostalmail                  VARCHAR2(1),
  donotemail                           VARCHAR2(1),
  donotfax                             VARCHAR2(1),
  donotphone                           VARCHAR2(1),
  authorizedrepname                    VARCHAR2(40),
  carriertype                          VARCHAR2(3),
  carrier2type                         VARCHAR2(3),
  carrier3type                         VARCHAR2(3),
  cci_status                           VARCHAR2(1),
  cci_maximusoptout                    DATE,
  cci_paceeligible                     VARCHAR2(1),
  cci_mltssstatus                      VARCHAR2(1),
  cci_espdstatus                       VARCHAR2(1),
  cci_ignorelisind                     VARCHAR2(1),
  cci_ohcfmandatory                    VARCHAR2(1),
  defaultpathextension                 VARCHAR2(1),
  defaultpathextensionexemptionid      NUMBER,
  eaflag                               VARCHAR2(1),
  enrlexclind                          VARCHAR2(1),
  esrdind                              VARCHAR2(1),
  expresslanepin                       VARCHAR2(5),
  expresslaneaffirmation               VARCHAR2(1),
  expresslaneparent                    VARCHAR2(1),
  expresslanestatusmedical             VARCHAR2(2),
  expresslanestatusdental              VARCHAR2(2),
  hcpstatusprevious                    VARCHAR2(2),
  hcbshighind                          VARCHAR2(1),
  hicn                                 VARCHAR2(15),
  institutionalind                     VARCHAR2(1),
  lisind                               VARCHAR2(1),
  mceligstat                           VARCHAR2(3),
  medicarecarrier2code                 VARCHAR2(4),
  medicarecarrier3code                 VARCHAR2(4),
  medicarestatusparta                  VARCHAR2(1),
  medicarestatuspartb                  VARCHAR2(1),
  medicarestatuspartd                  VARCHAR2(1),
  optoutind                            VARCHAR2(1),
  passiveenrollment                    VARCHAR2(1),
  sinsiind                             VARCHAR2(1),
  socamt                               VARCHAR2(5),
  subplanind                           VARCHAR2(1),
  spdstatus	                       VARCHAR2(1),
  recordcreatedate                     DATE,
  recordcreatename                     VARCHAR2(50),
  datelastmodified                     DATE,
  namelastmodified                     VARCHAR2(50),
  enrollmentstatus                     VARCHAR2(1),
  sendidltrdate                        DATE,
  importdate                           DATE,
  countychangercvddate                 DATE,
  triggerforvolunmails                 DATE,
  planoflasttrans                      VARCHAR2(3),
  lasttransdate                        DATE,
  lasttransrcvdid                      NUMBER,
  lasttransenrordisenr                 VARCHAR2(1),
  lasttransaccepted                    VARCHAR2(1),
  lastmedenrlrecid                     NUMBER,
  lastdisenrlrecid                     NUMBER,
  lastdisenroldate                     DATE,
  lastdisenrlaccepted                  VARCHAR2(1),
  lastplanid                           VARCHAR2(3),
  lastenrlopenplanid                   NUMBER,
  lastplanactivateddate                DATE,
  lastmcalffstrans                     NUMBER,
  dtllasttransid                       NUMBER,
  dtllastopentrans                     NUMBER,
  dtlenrlstatus                        VARCHAR2(1),
  lastdentalenrleffdate                DATE,
  dentalplanactive                     VARCHAR2(3),
  lastdtltranseord                     VARCHAR2(1),
  planoflastdtltrans                   VARCHAR2(3),
  lastdtlffstrans                      NUMBER,
  gmccombinedchoice                    VARCHAR2(3),
  extendeddefaultpathtriggerdate       DATE,
  aidcodemandatoryexpirationdate       DATE,
  cmceligibilitydefaultpathresetdate   DATE,
  mltsseligibilitydefaultpathresetdate DATE,
  denbbmaildate                        DATE,
  medbbmaildate                        DATE,
  medrlmaildate                        DATE,
  denrlmaildate                        DATE,
  ialettersentdate                     DATE,
  idlettersentdate                     DATE,
  dialettersentdate                    DATE,
  didlettersenddate                    DATE,
  didlettersentdate                    DATE,
  mcalmvltrsentdate                    DATE,
  dtlmvltrsentdate                     DATE,
  firstspecialdlmaildate               DATE,
  secspecialdlmaildate                 DATE,
  thirdspecialdlmaildate               DATE,
  ondisenrlpath                        VARCHAR2(1),
  medicalbbasent                       VARCHAR2(1),
  dentalbbasent                        VARCHAR2(1),
  dexemplettersenddate                 DATE,
  mexemptlettersenddate                DATE,
  campaigncompleted                    VARCHAR2(1),
  mincompletesentdate                  DATE,
  incompletechoiceformcounter          VARCHAR2(1),
  created_by                           VARCHAR2(18),
  date_created                         DATE,
  date_updated                         DATE,
  updated_by                           VARCHAR2(18)
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate indexes 
create index MAXDAT.IDX2_CLIENTNUM on MAXDAT.EMRS_D_CLIENT (CLIENT_NUMBER)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.EMRS_D_CLIENT
  add constraint CLIENT_PK primary key (DP_CLIENT_ID)
  using index 
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
create index MAXDAT.IDX2_CLIENTCASENUM on MAXDAT.EMRS_D_CLIENT (CASE_NUMBER)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  
  
  
-- Grant/Revoke object privileges 
grant select, insert, update on MAXDAT.EMRS_D_CLIENT to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.EMRS_D_CLIENT to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.EMRS_D_CLIENT to MAXDAT_READ_ONLY;

CREATE OR REPLACE TRIGGER MAXDAT."BUIR_CLIENT"
 BEFORE INSERT OR UPDATE
 ON emrs_d_client
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CLIENT.dp_client_id%TYPE;
BEGIN

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;

  IF INSERTING THEN

      IF :NEW.dp_client_id IS NULL THEN
        SElECT EMRS_SEQ_CLIENT_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_client_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;

  END IF;

END BUIR_CLIENT;
/

ALTER TRIGGER "BUIR_CLIENT" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_CLIENT_SV
AS
SELECT 
dp_client_id,
c.client_number,
c.cin as  clnt_cin,
c.client_number as  current_client_id,
c.case_number,
c.importdate as import_date,
c.hcoclosedate as hco_close_date,
a.addr_city as address_city,
a.addr_street_1 as address_line1,
a.addr_street_2 as address_line2,
a.addr_ctlk_id as address_county,
a.addr_state_cd as address_state,
a.addr_zip as address_zip_code,
c.addressokflag as address_ok_flag,
c.dob as date_of_birth,
c.ethniccode as  clnt_ethnicity,
c.enrollmentstatus as  enrollment_status,
c.dtlenrlstatus as dtl_enroll_status,
c.maximusstatus as maximus_status,
c.cci_status,
c.spdstatus as spd_status,
c.oldmedicalstatus as old_medical_status,
c.mandatorycounty as mandatory_county,
c.firstname as  first_name,
c.lastname as  last_name,
c.middleinitial as  middle_initial,
c.sex,
c.ethniccode as  race,
c.pregnancyduedate as  clnt_preg_term_date,
c.participantlang  state_language,
c.writtenlangcode as written_language,
c.aliencode as citizenship_code,
c.alowedplanfordlelig as allowed_plan_for_dual_eligible,
c.assigninthiscounty as  assign_in_this_county,
c.cci_espdstatus as cci_espd_status,
c.cci_maximusoptout as cci_maximus_opt_out,
c.cci_mltssstatus as cci_mltss_status,
c.cci_ohcfmandatory as cci_ohcf_mandatory,
c.cci_paceeligible as cci_pace_eligible,
c.countychangercvddate as county_change_rcvd_date,
c.eligibilityworkernum as eligibility_worker_num,
c.medicalexemption as medical_exemption,
c.exemptionenddate as exemption_end_date,
c.dentalexemption as dental_exemption,
c.dentalexempenddate as dental_exempt_end_date,
c.mpacketstatus as mpacket_status,
c.dpacketstatus as dpacket_status,
c.exemptedbydr as exempted_by_dr,
c.expresslaneaffirmation as express_lane_affirmation,
c.expresslaneparent as express_lane_parent,
c.expresslanepin as express_lane_pin,
c.expresslanestatusdental as express_lane_status_dental,
c.expresslanestatusmedical as express_lane_status_medical,
c.grandfatherdleligplan as grand_father_plan_id,
c.isdualeligible as is_dual_eligible,
c.isgrandfatherdlelig as is_grand_father_dual_eligible,
c.lasttransdate as last_trans_date,
c.lastdtltranseord as last_trans_dtl_enr_disenr,
c.planoflasttrans as last_trans_plan_id,
c.planoflastdtltrans as last_trans_dtl_plan_id,
c.lasttransrcvdid as last_trans_rcvd_id,
c.dtllasttransid as dtl_last_trans_id,
c.othhealthcoveragecode as oth_health_coverage_code,
c.passiveenrollment as passive_enrollment,
c.pregnancyduedate as pregnancy_due_date,
c.sendidltrdate as send_id_letter_date,
c.isnonmeds as is_non_meds,
c.switchtomeds as switch_to_meds,
c.switchtomedsdate as switch_to_meds_date,
c.transmitdate as transmit_date,
c.triggerforvolunmails as trigger_for_volun_mails,
c.recordcreatename as record_name,
c.recordcreatedate as record_date,
c.namelastmodified  as modified_name,
c.datelastmodified as modified_date,
c.aidcode as aid_code,
null as age,
null as client_reported_shcn,
null as client_type_cd,
null as clnt_expected_dob,
null as clnt_hipaa_privacy_ind,
null as clnt_marital_cd,
null as clnt_not_born,
null as clnt_preg_term_reas_cd,
null as clnt_status_cd,
null as coverage_type,
null as date_of_death,
null as date_of_death_source,
null as managed_care_candidate,
null as managed_via_gen_rev_flag,
null as managed_via_state_fund_flag,
null as migrant_worker_flag,
null as newborn,
null as plan_reported_shcn,
null as pregnant_member,
null as receiving_ssi_flag,
null as receiving_tanf_flag,
null as sched_auto_assign_date,
null as social_security_number,
null as suffix,
null as third_party_resources_avail,
null as transaction_hold,
null as cci_extended_eligible,
null as email_address1,
cast (null as date) as exemption_enter_date,
null as fax_number,
null as maxstar_phone,
null as mobile_phone,
null as adult_or_child,
c.denvolstatus den_vol_status,
c.lasttransenrordisenr last_trans_med_enr_disenr,
a.residence_addr_county addr_residence_ctlk_id,
a.residence_addr_zip addr_zip_residence,
CASE WHEN c.dob >= ADD_MONTHS(sysdate,(-21*12) ) THEN '0 - 20 years' else '21 and Over' END   Age_Group0,
CASE WHEN  FLOOR((sysdate - c.dob)/365.25) < 1 THEN '0 Years' WHEN  FLOOR((sysdate - c.dob)/365.25) > 20 THEN '21 Or More Years' ELSE '1 - 20 Years' END   Age_Group,
FLOOR(FLOOR((sysdate - c.dob)/365.25)/5)*5   Age_Years5,
CASE WHEN c.lastdtltranseord  IN ('1','4', '7') AND c.planoflastdtltrans is not null 
  THEN  c.planoflastdtltrans ||' - '|| p.plan_name
  ELSE 'Fee For Service' END last_dtl_trans_plan_name_drv,
c.planoflastdtltrans ||' - '|| p.plan_name last_dtl_trans_plan_name  
FROM emrs_d_client c
LEFT OUTER JOIN (SELECT client_number, addr_city, addr_street_1, addr_street_2, addr_ctlk_id, addr_state_cd, addr_zip, residence_addr_county, residence_addr_zip,
                        RANK() over (PARTITION BY client_number ORDER BY source_addr_end_date DESC) rank_num
                 FROM emrs_d_address) a ON c.client_number = a.client_number AND a.rank_num = 1
LEFT JOIN emrs_d_plan p ON c.planoflastdtltrans = p.plan_id;

GRANT SELECT ON EMRS_D_CLIENT_SV TO "MAXDAT_READ_ONLY";


begin
DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_CLIENT','ERRLOG_CLIENT');
  end;
/


-- Create table
create table EMRS_S_CLIENT_STG
(
  client_number                        NUMBER,
  case_number                          NUMBER,
  cin                                  VARCHAR2(9),
  addressokflag                        VARCHAR2(1),
  aidcode                              VARCHAR2(2),
  aliencode                            VARCHAR2(1),
  assigninthiscounty                   VARCHAR2(1),
  dob                                  DATE,
  hcoclosedate                         DATE,
  othhealthcoveragecode                VARCHAR2(1),
  oldmedicalstatus                     VARCHAR2(1),
  olddentalstaus                       VARCHAR2(1),
  firstname                            VARCHAR2(20),
  middleinitial                        VARCHAR2(1),
  lastname                             VARCHAR2(20),
  sex		                       VARCHAR2(1),
  eligibilityworkernum                 VARCHAR2(4),
  ethniccode                           VARCHAR2(1),
  participantlang                      VARCHAR2(1),
  writtenlangcode                      VARCHAR2(1),
  mcalplnmedsstatus                    VARCHAR2(2),
  dtlmedshcpstatus                     VARCHAR2(2),
  medicalid                            VARCHAR2(14),
  mandatorvolunstatus                  VARCHAR2(1),
  mandatorycounty                      VARCHAR2(1),
  denvolstatus                         VARCHAR2(1),
  maximusstatus                        VARCHAR2(1),
  isdualeligible                       VARCHAR2(1),
  isgrandfatherdlelig                  VARCHAR2(1),
  grandfatherdleligplan                VARCHAR2(3),
  alowedplanfordlelig                  VARCHAR2(3),
  medsfilecreationdate                 DATE,
  transmitdate                         DATE,
  pregnancyduedate                     DATE,
  exemptedbydr                         VARCHAR2(1),
  medicalexemption                     VARCHAR2(1),
  exemptionenddate                     DATE,
  dentalexemption                      VARCHAR2(1),
  dentalexempenddate                   DATE,
  ccsindicator                         VARCHAR2(1),
  icfindicator                         VARCHAR2(1),
  medicarecarriercode                  VARCHAR2(4),
  medicareindicator                    VARCHAR2(3),
  isnonmeds                            VARCHAR2(1),
  switchtomeds                         VARCHAR2(1),
  switchtomedsdate                     DATE,
  medicalpktrequested                  VARCHAR2(1),
  mpacketstatus                        VARCHAR2(1),
  dentalpktrequested                   VARCHAR2(1),
  dpacketstatus                        VARCHAR2(1),
  donotbulkemail                       VARCHAR2(1),
  donotbulkpostalmail                  VARCHAR2(1),
  donotemail                           VARCHAR2(1),
  donotfax                             VARCHAR2(1),
  donotphone                           VARCHAR2(1),
  authorizedrepname                    VARCHAR2(40),
  carriertype                          VARCHAR2(3),
  carrier2type                         VARCHAR2(3),
  carrier3type                         VARCHAR2(3),
  cci_status                           VARCHAR2(1),
  cci_maximusoptout                    DATE,
  cci_paceeligible                     VARCHAR2(1),
  cci_mltssstatus                      VARCHAR2(1),
  cci_espdstatus                       VARCHAR2(1),
  cci_ignorelisind                     VARCHAR2(1),
  cci_ohcfmandatory                    VARCHAR2(1),
  defaultpathextension                 VARCHAR2(1),
  defaultpathextensionexemptionid      NUMBER,
  eaflag                               VARCHAR2(1),
  enrlexclind                          VARCHAR2(1),
  esrdind                              VARCHAR2(1),
  expresslanepin                       VARCHAR2(5),
  expresslaneaffirmation               VARCHAR2(1),
  expresslaneparent                    VARCHAR2(1),
  expresslanestatusmedical             VARCHAR2(2),
  expresslanestatusdental              VARCHAR2(2),
  hcpstatusprevious                    VARCHAR2(2),
  hcbshighind                          VARCHAR2(1),
  hicn                                 VARCHAR2(15),
  institutionalind                     VARCHAR2(1),
  lisind                               VARCHAR2(1),
  mceligstat                           VARCHAR2(3),
  medicarecarrier2code                 VARCHAR2(4),
  medicarecarrier3code                 VARCHAR2(4),
  medicarestatusparta                  VARCHAR2(1),
  medicarestatuspartb                  VARCHAR2(1),
  medicarestatuspartd                  VARCHAR2(1),
  optoutind                            VARCHAR2(1),
  passiveenrollment                    VARCHAR2(1),
  sinsiind                             VARCHAR2(1),
  socamt                               VARCHAR2(5),
  subplanind                           VARCHAR2(1),
  spdstatus	                       VARCHAR2(1),  
  recordcreatedate                     DATE,
  recordcreatename                     VARCHAR2(50),
  datelastmodified                     DATE,
  namelastmodified                     VARCHAR2(50),
  be_modifiedon                        DATE,
  enrollmentstatus                     VARCHAR2(1),
  sendidltrdate                        DATE,
  importdate                           DATE,
  countychangercvddate                 DATE,
  triggerforvolunmails                 DATE,
  planoflasttrans                      VARCHAR2(3),
  lasttransdate                        DATE,
  lasttransrcvdid                      NUMBER,
  lasttransenrordisenr                 VARCHAR2(1),
  lasttransaccepted                    VARCHAR2(1),
  lastmedenrlrecid                     NUMBER,
  lastdisenrlrecid                     NUMBER,
  lastdisenroldate                     DATE,
  lastdisenrlaccepted                  VARCHAR2(1),
  lastplanid                           VARCHAR2(3),
  lastenrlopenplanid                   NUMBER,
  lastplanactivateddate                DATE,
  lastmcalffstrans                     NUMBER,
  dtllasttransid                       NUMBER,
  dtllastopentrans                     NUMBER,
  dtlenrlstatus                        VARCHAR2(1),
  lastdentalenrleffdate                DATE,
  dentalplanactive                     VARCHAR2(3),
  lastdtltranseord                     VARCHAR2(1),
  planoflastdtltrans                   VARCHAR2(3),
  lastdtlffstrans                      NUMBER,
  gmccombinedchoice                    VARCHAR2(3),
  extendeddefaultpathtriggerdate       DATE,
  aidcodemandatoryexpirationdate       DATE,
  cmceligibilitydefaultpathresetdate   DATE,
  mltsseligibilitydefaultpathresetdate DATE,
  denbbmaildate                        DATE,
  medbbmaildate                        DATE,
  medrlmaildate                        DATE,
  denrlmaildate                        DATE,
  ialettersentdate                     DATE,
  idlettersentdate                     DATE,
  dialettersentdate                    DATE,
  didlettersenddate                    DATE,
  didlettersentdate                    DATE,
  mcalmvltrsentdate                    DATE,
  dtlmvltrsentdate                     DATE,
  firstspecialdlmaildate               DATE,
  secspecialdlmaildate                 DATE,
  thirdspecialdlmaildate               DATE,
  ondisenrlpath                        VARCHAR2(1),
  medicalbbasent                       VARCHAR2(1),
  dentalbbasent                        VARCHAR2(1),
  dexemplettersenddate                 DATE,
  mexemptlettersenddate                DATE,
  campaigncompleted                    VARCHAR2(1),
  mincompletesentdate                  DATE,
  incompletechoiceformcounter          VARCHAR2(1),
  PartitionIDX 			       NUMBER(1)
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
-- Grant/Revoke object privileges 
grant select, insert, update on MAXDAT.EMRS_S_CLIENT_STG to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.EMRS_S_CLIENT_STG to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.EMRS_S_CLIENT_STG to MAXDAT_READ_ONLY;

create index MAXDAT.STG_IDX2_CLIENTNUM on MAXDAT.EMRS_S_CLIENT_STG (CLIENT_NUMBER)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

create index MAXDAT.STG_IDX3_CLIENTNUM_PARTIDX on MAXDAT.EMRS_S_CLIENT_STG (CLIENT_NUMBER, PARTITIONIDX)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


CREATE OR REPLACE VIEW MAXDAT.EMRS_D_CLIENT_HISTORY_SV AS
SELECT
e.dp_client_enrl_id as dp_client_history_id,
c.client_number,
c.cin as  clnt_cin,
c.client_number as  current_client_id,
c.case_number,
e.importdate as import_date,
c.hcoclosedate as hco_close_date,
a.addr_city as address_city,
a.addr_street_1 as address_line1,
a.addr_street_2 as address_line2,
a.addr_ctlk_id as address_county,
a.addr_state_cd as address_state,
a.addr_zip as address_zip_code,
c.addressokflag as address_ok_flag,
c.dob as date_of_birth,
c.ethniccode as  clnt_ethnicity,
e.enrollmentstatus as  enrollment_status,
e.dtlenrlstatus as dtl_enroll_status,
c.maximusstatus as maximus_status,
c.cci_status,
c.spdstatus as spd_status,
c.oldmedicalstatus as old_medical_status,
c.mandatorycounty as mandatory_county,
c.firstname as  first_name,
c.lastname as  last_name,
c.middleinitial as  middle_initial,
c.sex,
c.ethniccode as  race,
c.pregnancyduedate as  clnt_preg_term_date,
c.participantlang  state_language,
c.writtenlangcode as written_language,
c.aliencode as citizenship_code,
c.alowedplanfordlelig as allowed_plan_for_dual_eligible,
c.assigninthiscounty as  assign_in_this_county,
c.cci_espdstatus as cci_espd_status,
c.cci_maximusoptout as cci_maximus_opt_out,
c.cci_mltssstatus as cci_mltss_status,
c.cci_ohcfmandatory as cci_ohcf_mandatory,
c.cci_paceeligible as cci_pace_eligible,
e.countychangercvddate as county_change_rcvd_date,
c.eligibilityworkernum as eligibility_worker_num,
c.medicalexemption as medical_exemption,
c.exemptionenddate as exemption_end_date,
c.dentalexemption as dental_exemption,
c.dentalexempenddate as dental_exempt_end_date,
c.mpacketstatus as mpacket_status,
c.dpacketstatus as dpacket_status,
c.exemptedbydr as exempted_by_dr,
c.expresslaneaffirmation as express_lane_affirmation,
c.expresslaneparent as express_lane_parent,
c.expresslanepin as express_lane_pin,
c.expresslanestatusdental as express_lane_status_dental,
c.expresslanestatusmedical as express_lane_status_medical,
c.grandfatherdleligplan as grand_father_plan_id,
c.isdualeligible as is_dual_eligible,
c.isgrandfatherdlelig as is_grand_father_dual_eligible,
e.lasttransdate as last_trans_date,
e.lastdtltranseord as last_trans_dtl_enr_disenr,
e.planoflasttrans as last_trans_plan_id,
e.planoflastdtltrans as last_trans_dtl_plan_id,
e.lasttransrcvdid as last_trans_rcvd_id,
e.dtllasttransid as dtl_last_trans_id,
c.othhealthcoveragecode as oth_health_coverage_code,
c.passiveenrollment as passive_enrollment,
c.pregnancyduedate as pregnancy_due_date,
e.sendidltrdate as send_id_letter_date,
c.isnonmeds as is_non_meds,
c.switchtomeds as switch_to_meds,
c.switchtomedsdate as switch_to_meds_date,
c.transmitdate as transmit_date,
e.triggerforvolunmails as trigger_for_volun_mails,
e.recordcreatename as record_name,
e.recordcreatedate as record_date,
e.namelastmodified  as modified_name,
e.datelastmodified as modified_date,
e.record_start_date as date_of_validity_start,
e.record_end_date as date_of_validity_end,
c.aidcode as aid_code,
null as age,
null as client_reported_shcn,
null as client_type_cd,
null as clnt_expected_dob,
null as clnt_hipaa_privacy_ind,
null as clnt_marital_cd,
null as clnt_not_born,
null as clnt_preg_term_reas_cd,
null as clnt_status_cd,
null as coverage_type,
null as date_of_death,
null as date_of_death_source,
null as managed_care_candidate,
null as managed_via_gen_rev_flag,
null as managed_via_state_fund_flag,
null as migrant_worker_flag,
null as newborn,
null as plan_reported_shcn,
null as pregnant_member,
null as receiving_ssi_flag,
null as receiving_tanf_flag,
null as sched_auto_assign_date,
null as social_security_number,
null as suffix,
null as third_party_resources_avail,
null as transaction_hold,
null as cci_extended_eligible,
null as email_address1,
cast(null as date) as exemption_enter_date,
null as fax_number,
null as maxstar_phone,
null as mobile_phone,
null as adult_or_child,
c.denvolstatus den_vol_status,
e.lasttransenrordisenr last_trans_med_enr_disenr,
a.residence_addr_county addr_residence_ctlk_id,
a.residence_addr_zip addr_zip_residence,
CASE WHEN c.DOB IS NULL THEN NULL 
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 21 THEN 20 else 21 END   Age_Group0,
CASE WHEN c.DOB IS NULL THEN NULL 
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 1 THEN 0 
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) > 20 THEN 21 ELSE 20 END   Age_Group,
CASE WHEN c.DOB IS NULL THEN NULL 
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 5 THEN 0 
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 10 THEN 5
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 15 THEN 10
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 20 THEN 15
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 25 THEN 20
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 30 THEN 25
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 35 THEN 30
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 40 THEN 35
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 45 THEN 40
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 50 THEN 45
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 55 THEN 50
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 60 THEN 55
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 65 THEN 60
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 70 THEN 65
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 75 THEN 70
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 80 THEN 75
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 85 THEN 80
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 90 THEN 85
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 95 THEN 90
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 100 THEN 95
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 105 THEN 100
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 110 THEN 105
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 115 THEN 110
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 120 THEN 115
     WHEN trunc((to_number(to_char(sysdate,'yyyymmdd'))-to_number(to_char(c.dob,'yyyymmdd'))) /10000) < 125 THEN 120
     ELSE 125 END  Age_Years5,
CASE WHEN e.lastdtltranseord  IN ('1','4', '7') AND e.planoflastdtltrans is not null 
  THEN  e.planoflastdtltrans ||' - '|| p.plan_name
  ELSE 'Fee For Service' END last_dtl_trans_plan_name_drv,
e.planoflastdtltrans ||' - '|| p.plan_name last_dtl_trans_plan_name  
FROM emrs_d_client_hist_elig c
Inner join emrs_d_client_hist_enrl e on c.client_number = e.client_number
and e.record_start_date between c.record_start_date and c.record_end_date
LEFT OUTER join emrs_d_address_history a on c.client_number = a.client_number
and a.source_addr_begin_date between c.record_start_date and c.record_end_date
LEFT JOIN emrs_d_plan p ON e.planoflastdtltrans = p.plan_id;
;

GRANT SELECT ON EMRS_D_CLIENT_HISTORY_SV TO "MAXDAT_READ_ONLY";