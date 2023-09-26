--PERSON_RPT_VW
CREATE OR REPLACE FORCE VIEW "FLCPD0_STAGE"."PERSON_RPT_VW" ("OPERATION$", "CSCN$", "COMMIT_TIMESTAMP$", "XIDUSN$", "XIDSLT$", "XIDSEQ$", "DDLDESC$", "DDLOPER$", "DDLPDOBJN$", "RSID$", "TARGET_COLMAP$", "TIMESTAMP$", "USERNAME$", "AIAN_IND", "ARRIVED_BEFORE_1996_IND", "BLIND_OR_DISABLED_IND", "CITIZENSHIP_ATO_VERIF_ID", "CITIZENSHIP_DOCUMENT_ID", "CITIZENSHIP_MANUAL_TRIED_DATE", "CITIZENSHIP_VERIFIED_DATE", "CITIZENSHIP_VERIFIED_SOURCE", "CITIZENSHIP_VERIFIED_TYPE", "CITIZ_VERIF_INSUFF_REASON", "CMS_ELIGIBILITY_IND", "CMS_ELIGIBILITY_IND_DATE", "CMS_REFERRAL_QSTN_UPDATE_DATE", "DATE_OF_BIRTH", "DECEASED_DATE", "DECEASED_FLAG", "DECLARED_US_CITIZEN_IND", "ELIGIBLE_ITU_SERVICES_IND", "ELIG_IMMIGRATION_STATUS_IND", "EMPLOYED_IND", "ETHNICITY", "FIRST_NAME", "FIVE_YEAR_STATUS", "FOSTER_CARE_IND", "FULL_TIME_STUDENT_IND", "GENDER", "HSMV_IND", "HSMV_IND_DATE", "IDENTITY_ATO_VERIF_ID", "IDENTITY_DOCUMENT_ID", "IDENTITY_VERIFICATION_SOURCE", "IDENTITY_VERIFIED_DATE", "IDENTITY_VERIFIED_FLAG", "IDENT_VERIF_INSUFF_REASON", "IMMIGRANT_CODE", "IMMIGRATION_DOCUMENT_NUMBER", "IMMIGRATION_DOCUMENT_TYPE", "INCARCERATED_IND", "INSERT_DATE", "INSERT_JOB_NAME", "INSERT_USER", "INSERT_USER_ROLE", "JPA_VERSION", "LAST_NAME", "LAST_UPDATE_JOB_NAME", "LAST_UPDATE_USER", "LIMITED_IN_ANY_WAY_IND", "LPR_LESS_THAN_5YEARS_IND", "MDCD_ELIG_END_DATE", "MDCD_MATCH_IND", "MDCD_MATCH_IND_DATE", "MDCD_RECIPIENT_ID", "MEC_ID", "MIDDLE_INITIAL", "NAME_SUFFIX", "NEEDS_SPECIAL_THERAPY_IND", "NO_OTHER_INCOME_IND", "NUMBER_BABIES_DUE", "PERSON_ID", "PERSON_NUMBER", "PREGNANCY_DUE_DATE", "PREGNANT_IND", "RACE_1", "RACE_2", "RACE_3", "RACE_4", "RACE_5", "RACE_6", "RECEIVED_ITU_SERVICES_IND", "RECOGNIZED_TRIBE_IND", "SELF_EMPLOYED_IND", "SSN", "SSN_APPLICATION_DATE", "STATE_EMP_VERIF_IND", "STATE_EMP_VERIF_IND_DATE", "TRIBAL_MBRSHP_ATO_VERIF_ID", "TRIBAL_MBRSHP_DOCUMENT_ID", "TRIBAL_MBRSHP_VERIF_DATE", "TRIBAL_MBRSHP_VERIF_FLAG", "TRIBAL_MBRSHP_VERIF_SOURCE", "TRIBAL_VERIF_INSUFF_REASON", "TRIBE_NAME", "UNEMPLOYED_IND", "UPDATE_DATE", "UPDATE_USER_ROLE", "USCIS_NUMBER", "USES_MORE_MED_CARE_IND", "US_ENTRY_DATE", "VETERAN_STATUS_IND", "WORK_PHONE") AS 
Select decode(Shareplex_source_operation,'UPDATE BEFORE','UO','UPDATE AFTER','UN','INSERT','I','DELETE','D') "OPERATION$",
       Shareplex_source_SCN "CSCN$",
       Shareplex_source_TIME "COMMIT_TIMESTAMP$", 
       NULL "XIDUSN$",
       NULL "XIDSLT$", 
       NULL "XIDSEQ$",   
       NULL "DDLDESC$", 
       NULL "DDLOPER$", 
       NULL "DDLPDOBJN$", 
       NULL "RSID$", 
       NULL "TARGET_COLMAP$", 
       Shareplex_source_TIME "TIMESTAMP$", 
       NULL "USERNAME$", 
       PC.*   
  FROM "FLCPD0_CDC"."PERSON_CT" PC
 WHERE PC.shareplex_source_scn >= 523031955 and PC.shareplex_source_scn <=539086134;
