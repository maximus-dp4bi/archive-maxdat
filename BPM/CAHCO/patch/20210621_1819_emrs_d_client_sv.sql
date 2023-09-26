alter session set current_schema = MAXDAT;

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

GRANT SELECT ON "EMRS_D_CLIENT_SV" TO "MAXDAT_READ_ONLY";
