# Additional column to CASES table:

ALTER TABLE emrs_s_cases_stg ADD ADDR_BAD_FLAG VARCHAR2(1);
ALTER TABLE emrs_d_case      ADD ADDR_BAD_FLAG VARCHAR2(1);
ALTER TABLE emrs_d_case_hist ADD ADDR_BAD_FLAG VARCHAR2(1);

CREATE OR REPLACE TRIGGER "BUIR_CASE"
 BEFORE INSERT OR UPDATE
 ON emrs_d_case
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CASE.dp_case_id%TYPE;
BEGIN

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;

  IF INSERTING THEN

      IF :NEW.dp_case_id IS NULL THEN
        SElECT EMRS_SEQ_CASES_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_case_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;

    Insert into Emrs_D_Case_Hist (  case_number, case_id, clnt_client_id, mails_returned, addr_bad_date, addr_bad_flag,
                record_name, record_date,  modified_name,  modified_date,  record_start_date,  record_end_date,
                dp_case_hist_id,  created_by,  date_created, updated_by,  date_updated )
    Values ( :NEW.Case_Number, :NEW.case_id, :NEW.clnt_client_id, :NEW.mails_returned, :NEW.addr_bad_date, :NEW.addr_bad_flag,
             :NEW.record_name, :NEW.record_date,  :NEW.modified_name,  :NEW.modified_date,  :NEW.record_date,
             to_date('12312050','MMDDYYYY'), emrs_seq_cases_hist_id.nextval, :NEW.created_by,
             :NEW.date_created, :NEW.updated_by,  :NEW.date_updated);

  ELSIF UPDATING THEN

      Update Emrs_D_Case_Hist Set Record_end_date = :New.Modified_Date, Current_Flag = 'N'
       Where Case_number = :New.Case_Number
         and record_end_Date = to_date('12312050','MMDDYYYY');

      Insert into Emrs_D_Case_Hist (  case_number, case_id, clnt_client_id, mails_returned, addr_bad_date, addr_bad_flag,
                  record_name, record_date,  modified_name,  modified_date,  record_start_date,  record_end_date,
                  dp_case_hist_id,  created_by,  date_created, updated_by,  date_updated )
      Values ( :NEW.Case_Number, :NEW.case_id, :NEW.clnt_client_id, :NEW.mails_returned, :NEW.addr_bad_date,:NEW.addr_bad_flag,
               :NEW.record_name, :NEW.record_date,  :NEW.modified_name,  :NEW.modified_date,  :NEW.modified_date,
               to_date('12312050','MMDDYYYY'), emrs_seq_cases_hist_id.nextval, :NEW.created_by,
               :NEW.date_created, :NEW.updated_by,  :NEW.date_updated);

  END IF;

END BUIR_CASE;
/


ALTER TRIGGER "BUIR_CASE" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_CASE_SV
AS
SELECT
dp_case_id,
c.case_number,
c.case_id, 
l.cin as case_cin,
clnt_client_id,
l.firstname as first_name,
l.lastname as last_name,
l.middleinitial as middle_initial,
l.writtenlangcode as case_language_cd,
l.participantlang as case_spoken_language_cd,
c.mails_returned,
c.addr_bad_date,
c.addr_bad_flag,
null as case_status,
null as case_educated_ind,
null as case_head_ssn,
null as case_how_educated_cd,
null as family_number,
c.record_name,
c.record_date,
c.modified_name,
c.modified_date,
c.created_by,
c.date_created,
c.updated_by,
c.date_updated,
null as last_state_updated_by,
CASE WHEN c.mails_returned = 'Y' then 'Mail Returned' ELSE 'No Mail Returned' END mails_returned_drv
FROM emrs_d_case c
LEFT OUTER JOIN emrs_d_client l on c.clnt_client_id = l.client_number;

GRANT SELECT ON "EMRS_D_CASE_SV" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE VIEW EMRS_D_CASE_HISTORY_SV AS
SELECT dp_case_hist_id,
l.cin  as case_cin,
null as case_head_ssn,
c.case_number,
clnt_client_id,
c.mails_returned,
c.addr_bad_date,
c.addr_bad_flag,
null as family_number,
l.firstname as first_name,
l.lastname as last_name,
l.middleinitial as middle_initial,
null as last_state_updated_by,
record_name,
record_date,
modified_name,
modified_date,
c.record_start_date as date_of_validity_start,
c.record_end_date as date_of_validity_end,
0 as version,
c.current_flag,
c.created_by,
c.date_created,
c.updated_by,
c.date_updated,
CASE WHEN c.mails_returned = 'Y' then 'Mail Returned' ELSE 'No Mail Returned' END mails_returned_drv
FROM emrs_d_case_hist c
LEFT OUTER JOIN emrs_d_client l on c.clnt_client_id = l.client_number;

GRANT SELECT ON "EMRS_D_CASE_HISTORY_SV" TO "MAXDAT_READ_ONLY";


# Additional eligibility columns to CLIENTS table :

#•	MedicalEligibilityReasonID Number(3)
#•	DentalEligibilityReasonID  Number(3)
#•	SPDEligibilityReasonID     Number(3)
#•	MedicareContractNum        varchar2(5)
#•	MedicarePlanID			   varchar2(3)
#•	MedicarePlanStartDate	   Date

ALTER TABLE emrs_s_client_stg ADD MedicalEligibilityReasonID NUMBER(3);
ALTER TABLE emrs_s_client_stg ADD DentalEligibilityReasonID NUMBER(3);
ALTER TABLE emrs_s_client_stg ADD SPDEligibilityReasonID NUMBER(3);
ALTER TABLE emrs_s_client_stg ADD MedicareContractNum VARCHAR2(5);
ALTER TABLE emrs_s_client_stg ADD MedicarePlanID 	  VARCHAR2(3);
ALTER TABLE emrs_s_client_stg ADD MedicarePlanStartDate	DATE;

ALTER TABLE emrs_d_client ADD MedicalEligibilityReasonID NUMBER(3);
ALTER TABLE emrs_d_client ADD DentalEligibilityReasonID NUMBER(3);
ALTER TABLE emrs_d_client ADD SPDEligibilityReasonID NUMBER(3);
ALTER TABLE emrs_d_client ADD MedicareContractNum VARCHAR2(5);
ALTER TABLE emrs_d_client ADD MedicarePlanID 	  VARCHAR2(3);
ALTER TABLE emrs_d_client ADD MedicarePlanStartDate	DATE;

ALTER TABLE emrs_d_client_hist_elig ADD MedicalEligibilityReasonID NUMBER(3);
ALTER TABLE emrs_d_client_hist_elig ADD DentalEligibilityReasonID NUMBER(3);
ALTER TABLE emrs_d_client_hist_elig ADD SPDEligibilityReasonID NUMBER(3);
ALTER TABLE emrs_d_client_hist_elig ADD MedicareContractNum VARCHAR2(5);
ALTER TABLE emrs_d_client_hist_elig ADD MedicarePlanID 	  VARCHAR2(3);
ALTER TABLE emrs_d_client_hist_elig ADD MedicarePlanStartDate	DATE;

CREATE OR REPLACE VIEW MAXDAT.EMRS_D_CLIENT_SV
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
c.MedicalEligibilityReasonID,
c.DentalEligibilityReasonID,
c.SPDEligibilityReasonID,
c.MedicareContractNum,
c.MedicarePlanID,
c.MedicarePlanStartDate,
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
c.MedicalEligibilityReasonID,
c.DentalEligibilityReasonID,
c.SPDEligibilityReasonID,
c.MedicareContractNum,
c.MedicarePlanID,
c.MedicarePlanStartDate,
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
CASE WHEN c.dob >= ADD_MONTHS(sysdate,(-21*12) ) THEN '0 - 20 years' else '21 and Over' END   Age_Group0,
CASE WHEN  FLOOR((sysdate - c.dob)/365.25) < 1 THEN '0 Years' WHEN  FLOOR((sysdate - c.dob)/365.25) > 20 THEN '21 Or More Years' ELSE '1 - 20 Years' END   Age_Group,
FLOOR(FLOOR((sysdate - c.dob)/365.25)/5)*5   Age_Years5,
CASE WHEN e.lastdtltranseord  IN ('1','4', '7') AND e.planoflastdtltrans is not null
  THEN  e.planoflastdtltrans ||' - '|| p.plan_name
  ELSE 'Fee For Service' END last_dtl_trans_plan_name_drv,
e.planoflastdtltrans ||' - '|| p.plan_name last_dtl_trans_plan_name
FROM emrs_d_client_hist_elig c
Inner join emrs_d_client_hist_enrl e on c.client_number = e.client_number
and e.record_start_date between c.record_start_date and c.record_end_date
LEFT OUTER join emrs_d_address_history a on c.client_number = a.client_number
and e.record_start_date between a.source_addr_begin_date and a.source_addr_end_date
LEFT JOIN emrs_d_plan p ON e.planoflastdtltrans = p.plan_id;

GRANT SELECT ON EMRS_D_CLIENT_HISTORY_SV TO "MAXDAT_READ_ONLY";