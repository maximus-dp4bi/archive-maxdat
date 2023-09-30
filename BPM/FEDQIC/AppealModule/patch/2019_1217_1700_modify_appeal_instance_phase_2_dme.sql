alter table fedqic_appeal_stg add (C_DEMO_REOPENING_TYPE		NUMBER(10,0));
alter table fedqic_appeal_stg add (C_OTHER_REOPENING_TYPE		VARCHAR2(50 CHAR));
alter table fedqic_appeal_stg add (C_CASE_CURRENTLY_WITH_ALJ		NUMBER(1,0));
alter table fedqic_appeal_stg add (C_DATE_OF_REQUEST_TO_ALJ		DATE);
alter table fedqic_appeal_stg add (C_DEMO_REOPENING_DUE_DATE		DATE);
alter table fedqic_appeal_stg add (C_DEMO_REO_SENT_TO_OMHA_DATE	DATE);
alter table fedqic_appeal_stg add (C_OMHA_RESPONSE_RECEIVED		DATE);
alter table fedqic_appeal_stg add (C_RESPONSE_FROM_OMHA		NUMBER(10,0));
alter table fedqic_appeal_stg add (C_ADDITIONAL_INFO_REQUESTED		DATE);
alter table fedqic_appeal_stg add (C_REQUESTED_INFORMATION_DUE		DATE);
alter table fedqic_appeal_stg add (C_DEMO_REOPEN_FOLLOW_UP		DATE);
alter table fedqic_appeal_stg add (C_ADDITIONAL_INFO_RECEIVED		DATE);
alter table fedqic_appeal_stg add (C_REOPENING_DECISION_RESULTS	NUMBER(10,0));
alter table fedqic_appeal_stg add (C_NOT_REOPENED_REASON		NUMBER(10,0));

alter table fedqic_appeal_stg add (C_OMHA_REMAND_REQUEST		DATE);
alter table fedqic_appeal_stg add (C_REMAND_ELIGIBILITY_RESPONSE	DATE);
alter table fedqic_appeal_stg add (C_REMAND_RECEIVED_DATE		DATE);
alter table fedqic_appeal_stg add (C_OMHA_REMAND_REQUEST_RESPONSE	NUMBER(10,0));
alter table fedqic_appeal_stg add (C_OMHA_WITHDRAW_FORM_SENT		DATE);
alter table fedqic_appeal_stg add (C_OMHA_WITHDRAW_FORM_RETURNED	DATE);
alter table fedqic_appeal_stg add (C_OMHA_NOTIFIED_OF_WITHDRAWL	DATE);
alter table fedqic_appeal_stg add (C_ALJ_WITHDRAWAL			DATE);
alter table fedqic_appeal_stg add (C_DEMO_REOPENING_APPEAL_NUMBER	VARCHAR2(20 CHAR));
alter table fedqic_appeal_stg add (C_REOPENING_ANALYSIS_COMPLETED	DATE);
alter table fedqic_appeal_stg add (C_REOPENING_ANALYSIS_OUTCOME	NUMBER(10,0));
alter table fedqic_appeal_stg add (C_NOT_PURSUED_BY_CONTR_REASON	NUMBER(10,0));
alter table fedqic_appeal_stg add (C_ACK_LETTER_MAILED			DATE);
alter table fedqic_appeal_stg add (C_REO_DECISION_LETTER_MAILED	DATE);
alter table fedqic_appeal_stg add (C_REOPENING_OUTCOME			NUMBER(10,0));
alter table fedqic_appeal_stg add (C_DECLINE_TO_REOPEN_DECISION	DATE);
alter table fedqic_appeal_stg add (C_APPEAL_ATTESTATION_DATE		DATE);
alter table fedqic_appeal_stg add (C_APPEAL_ATTESTATION		NUMBER(1,0));
alter table fedqic_appeal_stg add (C_DEMO_SCHEDULED			TIMESTAMP(6));
alter table fedqic_appeal_stg add (C_DEMO_NOTIFICATION_LETTER_SENT	DATE);
alter table fedqic_appeal_stg add (C_RESPONSE_DUE			DATE);
alter table fedqic_appeal_stg add (C_RESPONSE_RECEIVED			DATE);
alter table fedqic_appeal_stg add (C_DEMO_ACCEPTANCE_STATUS		NUMBER(10,0));
alter table fedqic_appeal_stg add (C_TELE_DEMO_FOLLOW_UP		DATE);
alter table fedqic_appeal_stg add (C_DEMO_NOTIFICATION_LTR_RESENT	DATE);
alter table fedqic_appeal_stg add (C_RESCHEDULED_RESPONSE_DUE		DATE);
alter table fedqic_appeal_stg add (C_RESCHEDULE_RESPONSE_RECEIVED	DATE);
alter table fedqic_appeal_stg add (C_VERBAL_CONFIRMATION		DATE);
alter table fedqic_appeal_stg add (C_RESCHEDULED_DEMO_STATUS		NUMBER(10,0));
alter table fedqic_appeal_stg add (C_PROVIDER_OR_SUPPLIER_NAME	VARCHAR2(100 CHAR));	
alter table fedqic_appeal_stg add (C_DEMO_CONFERENCE_STATUS		NUMBER(10,0));
alter table fedqic_appeal_stg add (C_REVIEW_TYPE			NUMBER(10,0));
alter table fedqic_appeal_stg add (C_EXPERT_REVIEW_DECISION		NUMBER(10,0));		
alter table fedqic_appeal_stg add (C_REVIEW_NUMBER			NUMBER(10,0));

alter table corp_etl_appeal_wip add (DEMO_REOPENING_TYPE		NUMBER(10,0));
alter table corp_etl_appeal_wip add (OTHER_REOPENING_TYPE		VARCHAR2(50 CHAR));
alter table corp_etl_appeal_wip add (CASE_CURRENTLY_WITH_ALJ		NUMBER(1,0));
alter table corp_etl_appeal_wip add (DATE_OF_REQUEST_TO_ALJ		DATE);
alter table corp_etl_appeal_wip add (DEMO_REOPENING_DUE_DATE		DATE);
alter table corp_etl_appeal_wip add (DEMO_REO_SENT_TO_OMHA_DATE	DATE);
alter table corp_etl_appeal_wip add (OMHA_RESPONSE_RECEIVED		DATE);
alter table corp_etl_appeal_wip add (RESPONSE_FROM_OMHA		NUMBER(10,0));
alter table corp_etl_appeal_wip add (ADDITIONAL_INFO_REQUESTED		DATE);
alter table corp_etl_appeal_wip add (REQUESTED_INFORMATION_DUE		DATE);
alter table corp_etl_appeal_wip add (DEMO_REOPEN_FOLLOW_UP		DATE);
alter table corp_etl_appeal_wip add (ADDITIONAL_INFO_RECEIVED		DATE);
alter table corp_etl_appeal_wip add (REOPENING_DECISION_RESULTS	NUMBER(10,0));
alter table corp_etl_appeal_wip add (NOT_REOPENED_REASON		NUMBER(10,0));

alter table corp_etl_appeal_wip add (OMHA_REMAND_REQUEST		DATE);
alter table corp_etl_appeal_wip add (REMAND_ELIGIBILITY_RESPONSE	DATE);
alter table corp_etl_appeal_wip add (REMAND_RECEIVED_DATE		DATE);
alter table corp_etl_appeal_wip add (OMHA_REMAND_REQUEST_RESPONSE	NUMBER(10,0));
alter table corp_etl_appeal_wip add (OMHA_WITHDRAW_FORM_SENT		DATE);
alter table corp_etl_appeal_wip add (OMHA_WITHDRAW_FORM_RETURNED	DATE);
alter table corp_etl_appeal_wip add (OMHA_NOTIFIED_OF_WITHDRAWL	DATE);
alter table corp_etl_appeal_wip add (ALJ_WITHDRAWAL			DATE);
alter table corp_etl_appeal_wip add (DEMO_REOPENING_APPEAL_NUMBER	VARCHAR2(20 CHAR));
alter table corp_etl_appeal_wip add (REOPENING_ANALYSIS_COMPLETED	DATE);
alter table corp_etl_appeal_wip add (REOPENING_ANALYSIS_OUTCOME	NUMBER(10,0));
alter table corp_etl_appeal_wip add (NOT_PURSUED_BY_CONTR_REASON	NUMBER(10,0));
alter table corp_etl_appeal_wip add (ACK_LETTER_MAILED			DATE);
alter table corp_etl_appeal_wip add (REO_DECISION_LETTER_MAILED	DATE);
alter table corp_etl_appeal_wip add (REOPENING_OUTCOME			NUMBER(10,0));
alter table corp_etl_appeal_wip add (DECLINE_TO_REOPEN_DECISION	DATE);
alter table corp_etl_appeal_wip add (APPEAL_ATTESTATION_DATE		DATE);
alter table corp_etl_appeal_wip add (APPEAL_ATTESTATION		NUMBER(1,0));
alter table corp_etl_appeal_wip add (DEMO_SCHEDULED			TIMESTAMP(6));
alter table corp_etl_appeal_wip add (DEMO_NOTIFICATION_LETTER_SENT	DATE);
alter table corp_etl_appeal_wip add (RESPONSE_DUE			DATE);
alter table corp_etl_appeal_wip add (RESPONSE_RECEIVED			DATE);
alter table corp_etl_appeal_wip add (DEMO_ACCEPTANCE_STATUS		NUMBER(10,0));
alter table corp_etl_appeal_wip add (TELE_DEMO_FOLLOW_UP		DATE);
alter table corp_etl_appeal_wip add (DEMO_NOTIFICATION_LTR_RESENT	DATE);
alter table corp_etl_appeal_wip add (RESCHEDULED_RESPONSE_DUE		DATE);
alter table corp_etl_appeal_wip add (RESCHEDULE_RESPONSE_RECEIVED	DATE);
alter table corp_etl_appeal_wip add (VERBAL_CONFIRMATION		DATE);
alter table corp_etl_appeal_wip add (RESCHEDULED_DEMO_STATUS		NUMBER(10,0));
alter table corp_etl_appeal_wip add (PROVIDER_OR_SUPPLIER_NAME	VARCHAR2(100 CHAR));	
alter table corp_etl_appeal_wip add (DEMO_CONFERENCE_STATUS		NUMBER(10,0));
alter table corp_etl_appeal_wip add (REVIEW_TYPE			NUMBER(10,0));
alter table corp_etl_appeal_wip add (EXPERT_REVIEW_DECISION		NUMBER(10,0));		
alter table corp_etl_appeal_wip add (REVIEW_NUMBER			NUMBER(10,0));

alter table corp_etl_appeal add (DEMO_REOPENING_TYPE		NUMBER(10,0));
alter table corp_etl_appeal add (OTHER_REOPENING_TYPE		VARCHAR2(50 CHAR));
alter table corp_etl_appeal add (CASE_CURRENTLY_WITH_ALJ		NUMBER(1,0));
alter table corp_etl_appeal add (DATE_OF_REQUEST_TO_ALJ		DATE);
alter table corp_etl_appeal add (DEMO_REOPENING_DUE_DATE		DATE);
alter table corp_etl_appeal add (DEMO_REO_SENT_TO_OMHA_DATE	DATE);
alter table corp_etl_appeal add (OMHA_RESPONSE_RECEIVED		DATE);
alter table corp_etl_appeal add (RESPONSE_FROM_OMHA		NUMBER(10,0));
alter table corp_etl_appeal add (ADDITIONAL_INFO_REQUESTED		DATE);
alter table corp_etl_appeal add (REQUESTED_INFORMATION_DUE		DATE);
alter table corp_etl_appeal add (DEMO_REOPEN_FOLLOW_UP		DATE);
alter table corp_etl_appeal add (ADDITIONAL_INFO_RECEIVED		DATE);
alter table corp_etl_appeal add (REOPENING_DECISION_RESULTS	NUMBER(10,0));
alter table corp_etl_appeal add (NOT_REOPENED_REASON		NUMBER(10,0));

alter table corp_etl_appeal add (OMHA_REMAND_REQUEST		DATE);
alter table corp_etl_appeal add (REMAND_ELIGIBILITY_RESPONSE	DATE);
alter table corp_etl_appeal add (REMAND_RECEIVED_DATE		DATE);
alter table corp_etl_appeal add (OMHA_REMAND_REQUEST_RESPONSE	NUMBER(10,0));
alter table corp_etl_appeal add (OMHA_WITHDRAW_FORM_SENT		DATE);
alter table corp_etl_appeal add (OMHA_WITHDRAW_FORM_RETURNED	DATE);
alter table corp_etl_appeal add (OMHA_NOTIFIED_OF_WITHDRAWL	DATE);
alter table corp_etl_appeal add (ALJ_WITHDRAWAL			DATE);
alter table corp_etl_appeal add (DEMO_REOPENING_APPEAL_NUMBER	VARCHAR2(20 CHAR));
alter table corp_etl_appeal add (REOPENING_ANALYSIS_COMPLETED	DATE);
alter table corp_etl_appeal add (REOPENING_ANALYSIS_OUTCOME	NUMBER(10,0));
alter table corp_etl_appeal add (NOT_PURSUED_BY_CONTR_REASON	NUMBER(10,0));
alter table corp_etl_appeal add (ACK_LETTER_MAILED			DATE);
alter table corp_etl_appeal add (REO_DECISION_LETTER_MAILED	DATE);
alter table corp_etl_appeal add (REOPENING_OUTCOME			NUMBER(10,0));
alter table corp_etl_appeal add (DECLINE_TO_REOPEN_DECISION	DATE);
alter table corp_etl_appeal add (APPEAL_ATTESTATION_DATE		DATE);
alter table corp_etl_appeal add (APPEAL_ATTESTATION		NUMBER(1,0));
alter table corp_etl_appeal add (DEMO_SCHEDULED			TIMESTAMP(6));
alter table corp_etl_appeal add (DEMO_NOTIFICATION_LETTER_SENT	DATE);
alter table corp_etl_appeal add (RESPONSE_DUE			DATE);
alter table corp_etl_appeal add (RESPONSE_RECEIVED			DATE);
alter table corp_etl_appeal add (DEMO_ACCEPTANCE_STATUS		NUMBER(10,0));
alter table corp_etl_appeal add (TELE_DEMO_FOLLOW_UP		DATE);
alter table corp_etl_appeal add (DEMO_NOTIFICATION_LTR_RESENT	DATE);
alter table corp_etl_appeal add (RESCHEDULED_RESPONSE_DUE		DATE);
alter table corp_etl_appeal add (RESCHEDULE_RESPONSE_RECEIVED	DATE);
alter table corp_etl_appeal add (VERBAL_CONFIRMATION		DATE);
alter table corp_etl_appeal add (RESCHEDULED_DEMO_STATUS		NUMBER(10,0));
alter table corp_etl_appeal add (PROVIDER_OR_SUPPLIER_NAME	VARCHAR2(100 CHAR));	
alter table corp_etl_appeal add (DEMO_CONFERENCE_STATUS		NUMBER(10,0));
alter table corp_etl_appeal add (REVIEW_TYPE			NUMBER(10,0));
alter table corp_etl_appeal add (EXPERT_REVIEW_DECISION		NUMBER(10,0));		
alter table corp_etl_appeal add (REVIEW_NUMBER			NUMBER(10,0));

alter table d_mw_appeal_instance add (DEMO_REOPENING_TYPE		NUMBER(10,0));
alter table d_mw_appeal_instance add (OTHER_REOPENING_TYPE		VARCHAR2(50 CHAR));
alter table d_mw_appeal_instance add (CASE_CURRENTLY_WITH_ALJ		NUMBER(1,0));
alter table d_mw_appeal_instance add (DATE_OF_REQUEST_TO_ALJ		DATE);
alter table d_mw_appeal_instance add (DEMO_REOPENING_DUE_DATE		DATE);
alter table d_mw_appeal_instance add (DEMO_REO_SENT_TO_OMHA_DATE	DATE);
alter table d_mw_appeal_instance add (OMHA_RESPONSE_RECEIVED		DATE);
alter table d_mw_appeal_instance add (RESPONSE_FROM_OMHA		NUMBER(10,0));
alter table d_mw_appeal_instance add (ADDITIONAL_INFO_REQUESTED		DATE);
alter table d_mw_appeal_instance add (REQUESTED_INFORMATION_DUE		DATE);
alter table d_mw_appeal_instance add (DEMO_REOPEN_FOLLOW_UP		DATE);
alter table d_mw_appeal_instance add (ADDITIONAL_INFO_RECEIVED		DATE);
alter table d_mw_appeal_instance add (REOPENING_DECISION_RESULTS	NUMBER(10,0));
alter table d_mw_appeal_instance add (NOT_REOPENED_REASON		NUMBER(10,0));

alter table d_mw_appeal_instance add (OMHA_REMAND_REQUEST		DATE);
alter table d_mw_appeal_instance add (REMAND_ELIGIBILITY_RESPONSE	DATE);
alter table d_mw_appeal_instance add (REMAND_RECEIVED_DATE		DATE);
alter table d_mw_appeal_instance add (OMHA_REMAND_REQUEST_RESPONSE	NUMBER(10,0));
alter table d_mw_appeal_instance add (OMHA_WITHDRAW_FORM_SENT		DATE);
alter table d_mw_appeal_instance add (OMHA_WITHDRAW_FORM_RETURNED	DATE);
alter table d_mw_appeal_instance add (OMHA_NOTIFIED_OF_WITHDRAWL	DATE);
alter table d_mw_appeal_instance add (ALJ_WITHDRAWAL			DATE);
alter table d_mw_appeal_instance add (DEMO_REOPENING_APPEAL_NUMBER	VARCHAR2(20 CHAR));
alter table d_mw_appeal_instance add (REOPENING_ANALYSIS_COMPLETED	DATE);
alter table d_mw_appeal_instance add (REOPENING_ANALYSIS_OUTCOME	NUMBER(10,0));
alter table d_mw_appeal_instance add (NOT_PURSUED_BY_CONTR_REASON	NUMBER(10,0));
alter table d_mw_appeal_instance add (ACK_LETTER_MAILED			DATE);
alter table d_mw_appeal_instance add (REO_DECISION_LETTER_MAILED	DATE);
alter table d_mw_appeal_instance add (REOPENING_OUTCOME			NUMBER(10,0));
alter table d_mw_appeal_instance add (DECLINE_TO_REOPEN_DECISION	DATE);
alter table d_mw_appeal_instance add (APPEAL_ATTESTATION_DATE		DATE);
alter table d_mw_appeal_instance add (APPEAL_ATTESTATION		NUMBER(1,0));
alter table d_mw_appeal_instance add (DEMO_SCHEDULED			TIMESTAMP(6));
alter table d_mw_appeal_instance add (DEMO_NOTIFICATION_LETTER_SENT	DATE);
alter table d_mw_appeal_instance add (RESPONSE_DUE			DATE);
alter table d_mw_appeal_instance add (RESPONSE_RECEIVED			DATE);
alter table d_mw_appeal_instance add (DEMO_ACCEPTANCE_STATUS		NUMBER(10,0));
alter table d_mw_appeal_instance add (TELE_DEMO_FOLLOW_UP		DATE);
alter table d_mw_appeal_instance add (DEMO_NOTIFICATION_LTR_RESENT	DATE);
alter table d_mw_appeal_instance add (RESCHEDULED_RESPONSE_DUE		DATE);
alter table d_mw_appeal_instance add (RESCHEDULE_RESPONSE_RECEIVED	DATE);
alter table d_mw_appeal_instance add (VERBAL_CONFIRMATION		DATE);
alter table d_mw_appeal_instance add (RESCHEDULED_DEMO_STATUS		NUMBER(10,0));
alter table d_mw_appeal_instance add (PROVIDER_OR_SUPPLIER_NAME	VARCHAR2(100 CHAR));	
alter table d_mw_appeal_instance add (DEMO_CONFERENCE_STATUS		NUMBER(10,0));
alter table d_mw_appeal_instance add (REVIEW_TYPE			NUMBER(10,0));
alter table d_mw_appeal_instance add (EXPERT_REVIEW_DECISION		NUMBER(10,0));		
alter table d_mw_appeal_instance add (REVIEW_NUMBER			NUMBER(10,0));

commit;

create index DMWAP_DEMO_DRT on D_MW_APPEAL_INSTANCE ("DEMO_REOPENING_TYPE") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_ORT on D_MW_APPEAL_INSTANCE ("OTHER_REOPENING_TYPE") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_WALJ on D_MW_APPEAL_INSTANCE ("CASE_CURRENTLY_WITH_ALJ") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RALJ on D_MW_APPEAL_INSTANCE ("DATE_OF_REQUEST_TO_ALJ") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RDD on D_MW_APPEAL_INSTANCE ("DEMO_REOPENING_DUE_DATE") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RSO on D_MW_APPEAL_INSTANCE ("DEMO_REO_SENT_TO_OMHA_DATE") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_ORR on D_MW_APPEAL_INSTANCE ("OMHA_RESPONSE_RECEIVED") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RO on D_MW_APPEAL_INSTANCE ("RESPONSE_FROM_OMHA") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_AIRQ on D_MW_APPEAL_INSTANCE ("ADDITIONAL_INFO_REQUESTED") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RID on D_MW_APPEAL_INSTANCE ("REQUESTED_INFORMATION_DUE") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RFU on D_MW_APPEAL_INSTANCE ("DEMO_REOPEN_FOLLOW_UP") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_AIRC on D_MW_APPEAL_INSTANCE ("ADDITIONAL_INFO_RECEIVED") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RDR on D_MW_APPEAL_INSTANCE ("REOPENING_DECISION_RESULTS") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_NRR on D_MW_APPEAL_INSTANCE ("NOT_REOPENED_REASON") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_ORMR on D_MW_APPEAL_INSTANCE ("OMHA_REMAND_REQUEST") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RER on D_MW_APPEAL_INSTANCE ("REMAND_ELIGIBILITY_RESPONSE") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RRD on D_MW_APPEAL_INSTANCE ("REMAND_RECEIVED_DATE") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_ORRR on D_MW_APPEAL_INSTANCE ("OMHA_REMAND_REQUEST_RESPONSE") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_OWFS on D_MW_APPEAL_INSTANCE ("OMHA_WITHDRAW_FORM_SENT") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_ONW on D_MW_APPEAL_INSTANCE ("OMHA_NOTIFIED_OF_WITHDRAWL") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_ALJW on D_MW_APPEAL_INSTANCE ("ALJ_WITHDRAWAL") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RAN on D_MW_APPEAL_INSTANCE ("DEMO_REOPENING_APPEAL_NUMBER") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RAC on D_MW_APPEAL_INSTANCE ("REOPENING_ANALYSIS_COMPLETED") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RAO on D_MW_APPEAL_INSTANCE ("REOPENING_ANALYSIS_OUTCOME") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_NPCR on D_MW_APPEAL_INSTANCE ("NOT_PURSUED_BY_CONTR_REASON") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_ALM on D_MW_APPEAL_INSTANCE ("ACK_LETTER_MAILED") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RDLM on D_MW_APPEAL_INSTANCE ("REO_DECISION_LETTER_MAILED") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_ROO on D_MW_APPEAL_INSTANCE ("REOPENING_OUTCOME") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_DROD on D_MW_APPEAL_INSTANCE ("DECLINE_TO_REOPEN_DECISION") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_AAD on D_MW_APPEAL_INSTANCE ("APPEAL_ATTESTATION_DATE") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_AA on D_MW_APPEAL_INSTANCE ("APPEAL_ATTESTATION") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_DS on D_MW_APPEAL_INSTANCE ("DEMO_SCHEDULED") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_NLS on D_MW_APPEAL_INSTANCE ("DEMO_NOTIFICATION_LETTER_SENT") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RDU on D_MW_APPEAL_INSTANCE ("RESPONSE_DUE") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RRC on D_MW_APPEAL_INSTANCE ("RESPONSE_RECEIVED") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_DAS on D_MW_APPEAL_INSTANCE ("DEMO_ACCEPTANCE_STATUS") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_TFU on D_MW_APPEAL_INSTANCE ("TELE_DEMO_FOLLOW_UP") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_NLR on D_MW_APPEAL_INSTANCE ("DEMO_NOTIFICATION_LTR_RESENT") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RRDU on D_MW_APPEAL_INSTANCE ("RESCHEDULED_RESPONSE_DUE") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RRRC on D_MW_APPEAL_INSTANCE ("RESCHEDULE_RESPONSE_RECEIVED") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_VC on D_MW_APPEAL_INSTANCE ("VERBAL_CONFIRMATION") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RDS on D_MW_APPEAL_INSTANCE ("RESCHEDULED_DEMO_STATUS") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_PSN on D_MW_APPEAL_INSTANCE ("PROVIDER_OR_SUPPLIER_NAME") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_DCS on D_MW_APPEAL_INSTANCE ("DEMO_CONFERENCE_STATUS") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RTY on D_MW_APPEAL_INSTANCE ("REVIEW_TYPE") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_ERD on D_MW_APPEAL_INSTANCE ("EXPERT_REVIEW_DECISION") online tablespace MAXDAT_INDX parallel compute statistics;
create index DMWAP_DEMO_RNU on D_MW_APPEAL_INSTANCE ("REVIEW_NUMBER") online tablespace MAXDAT_INDX parallel compute statistics;

commit;

CREATE TABLE D_DEMO_REOPENING_TYPE
   (
        D_DRT_ID NUMBER NOT NULL,
        DEMO_REOPEN_TYPE_ID NUMBER(19,0) NOT NULL,
        DEMO_REOPEN_TYPE_NAME VARCHAR2(255 CHAR),
        DEMO_REOPEN_TYPE_DESCRIPTION VARCHAR2(255 CHAR),
        START_DATE DATE,
        END_DATE DATE
    )   tablespace MAXDAT_DATA;

  alter table D_DEMO_REOPENING_TYPE add constraint DAPP_DRT_PK primary key (D_DRT_ID)
  using index tablespace MAXDAT_INDX;
create unique index DAPPDRT_UIX1 on D_DEMO_REOPENING_TYPE ("DEMO_REOPEN_TYPE_ID") online tablespace MAXDAT_INDX parallel compute statistics;
Grant select on D_DEMO_REOPENING_TYPE to MAXDAT_READ_ONLY;
CREATE SEQUENCE  SEQ_APP_DRT_ID  
MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

CREATE TABLE D_OMHA_RESPONSE
   (
        D_OR_ID NUMBER NOT NULL,
        OMHA_RESPONSE_ID NUMBER(19,0) NOT NULL,
        OMHA_RESPONSE_NAME VARCHAR2(255 CHAR),
        OMHA_RESPONSE_DESCRIPTION VARCHAR2(255 CHAR),
        START_DATE DATE,
        END_DATE DATE
    )   tablespace MAXDAT_DATA;

  alter table  D_OMHA_RESPONSE add constraint DAPP_OR_PK primary key (D_OR_ID)
  using index tablespace MAXDAT_INDX;
create unique index DAPPOR_UIX1 on  D_OMHA_RESPONSE ("OMHA_RESPONSE_ID") online tablespace MAXDAT_INDX parallel compute statistics;
Grant select on  D_OMHA_RESPONSE to MAXDAT_READ_ONLY;
CREATE SEQUENCE  SEQ_APP_OR_ID  
MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

CREATE TABLE D_REOPENING_DECISION_RESULTS
   (
        D_RDR_ID NUMBER NOT NULL,
        REOPEN_DECISION_RESULTS_ID NUMBER(19,0) NOT NULL,
        REOPEN_DECISION_RESULTS_NAME VARCHAR2(255 CHAR),
        REOPEN_DECISION_RESULTS_DESCRIPTION VARCHAR2(255 CHAR),
        START_DATE DATE,
        END_DATE DATE
    )   tablespace MAXDAT_DATA;

  alter table  D_REOPENING_DECISION_RESULTS add constraint DAPP_RDR_PK primary key (D_RDR_ID)
  using index tablespace MAXDAT_INDX;
create unique index DAPRDR_UIX1 on  D_REOPENING_DECISION_RESULTS ("REOPEN_DECISION_RESULTS_ID") online tablespace MAXDAT_INDX parallel compute statistics;
Grant select on  D_REOPENING_DECISION_RESULTS to MAXDAT_READ_ONLY;
CREATE SEQUENCE  SEQ_APP_RDR_ID  
MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

CREATE TABLE D_NOT_REOPENED_REASON
   (
        D_NRR_ID NUMBER NOT NULL,
        NOT_REOPENED_REASON_ID NUMBER(19,0) NOT NULL,
        NOT_REOPENED_REASON_NAME VARCHAR2(255 CHAR),
        NOT_REOPENED_REASON_DESCRIPTION VARCHAR2(255 CHAR),
        START_DATE DATE,
        END_DATE DATE
    )   tablespace MAXDAT_DATA;

  alter table  D_NOT_REOPENED_REASON add constraint DAPP_NRR_PK primary key (D_NRR_ID)
  using index tablespace MAXDAT_INDX;
create unique index DAPNRR_UIX1 on  D_NOT_REOPENED_REASON ("NOT_REOPENED_REASON_ID") online tablespace MAXDAT_INDX parallel compute statistics;
Grant select on  D_NOT_REOPENED_REASON to MAXDAT_READ_ONLY;
CREATE SEQUENCE  SEQ_APP_NRR_ID  
MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

  CREATE TABLE D_OMHA_REM_RESP
   (
        D_ORR_ID NUMBER NOT NULL,
        OMHA_REM_RESP_ID NUMBER(19,0) NOT NULL,
        OMHA_REM_RESP_NAME VARCHAR2(255 CHAR),
        OMHA_REM_RESP_DESCRIPTION VARCHAR2(255 CHAR),
        START_DATE DATE,
        END_DATE DATE
    )   tablespace MAXDAT_DATA;

  alter table D_OMHA_REM_RESP add constraint DAPP_ORR_PK primary key (D_ORR_ID)
  using index tablespace MAXDAT_INDX;
create unique index DAPPORR_UIX1 on D_OMHA_REM_RESP ("OMHA_REM_RESP_ID") online tablespace MAXDAT_INDX parallel compute statistics;
Grant select on D_OMHA_REM_RESP to MAXDAT_READ_ONLY;
CREATE SEQUENCE  SEQ_APP_ORR_ID  
MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

  CREATE TABLE D_REOPENING_ANALYSIS_OUTCOME_TYPE
   (
        D_RAOT_ID NUMBER NOT NULL,
        REOPEN_ANALYSIS_OUTCOME_TYPE_ID NUMBER(19,0) NOT NULL,
        REOPEN_ANALYSIS_OUTCOME_TYPE_NAME VARCHAR2(255 CHAR),
        REOPEN_ANALYSIS_OUTCOME_TYPE_DESCRIPTION VARCHAR2(255 CHAR),
        START_DATE DATE,
        END_DATE DATE
    )   tablespace MAXDAT_DATA;

  alter table D_REOPENING_ANALYSIS_OUTCOME_TYPE add constraint DAPP_RAOT_PK primary key (D_RAOT_ID)
  using index tablespace MAXDAT_INDX;
create unique index DAPPRAOT_UIX1 on D_REOPENING_ANALYSIS_OUTCOME_TYPE ("REOPEN_ANALYSIS_OUTCOME_TYPE_ID") online tablespace MAXDAT_INDX parallel compute statistics;
Grant select on D_REOPENING_ANALYSIS_OUTCOME_TYPE to MAXDAT_READ_ONLY;
CREATE SEQUENCE  SEQ_APP_RAOT_ID  
MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

  CREATE TABLE D_NOT_PURSUE_CONTR_REASON_TYPE
   (
        D_NPCRT_ID NUMBER NOT NULL,
        NOT_PURSUE_CONTR_REASON_TYPE_ID NUMBER(19,0) NOT NULL,
        NOT_PURSUE_CONTR_REASON_TYPE_NAME VARCHAR2(255 CHAR),
        NOT_PURSUE_CONTR_REASON_TYPE_DESCRIPTION VARCHAR2(255 CHAR),
        START_DATE DATE,
        END_DATE DATE
    )   tablespace MAXDAT_DATA;

  alter table D_NOT_PURSUE_CONTR_REASON_TYPE add constraint DAPP_NPCRT_PK primary key (D_NPCRT_ID)
  using index tablespace MAXDAT_INDX;
create unique index DAPPNPCRT_UIX1 on D_NOT_PURSUE_CONTR_REASON_TYPE ("NOT_PURSUE_CONTR_REASON_TYPE_ID") online tablespace MAXDAT_INDX parallel compute statistics;
Grant select on D_NOT_PURSUE_CONTR_REASON_TYPE to MAXDAT_READ_ONLY;
CREATE SEQUENCE  SEQ_APP_NPCRT_ID  
MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

  CREATE TABLE D_REOPENING_OUTCOME
   (
        D_RO_ID NUMBER NOT NULL,
        REOPEN_OUTCOME_ID NUMBER(19,0) NOT NULL,
        REOPEN_OUTCOME_NAME VARCHAR2(255 CHAR),
        REOPEN_OUTCOME_DESCRIPTION VARCHAR2(255 CHAR),
        START_DATE DATE,
        END_DATE DATE
    )   tablespace MAXDAT_DATA;

  alter table D_REOPENING_OUTCOME add constraint DAPP_RO_PK primary key (D_RO_ID)
  using index tablespace MAXDAT_INDX;
create unique index DAPPRO_UIX1 on D_REOPENING_OUTCOME ("REOPEN_OUTCOME_ID") online tablespace MAXDAT_INDX parallel compute statistics;
Grant select on D_REOPENING_OUTCOME to MAXDAT_READ_ONLY;
CREATE SEQUENCE  SEQ_APP_RO_ID  
MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

  CREATE TABLE D_DEMO_ACCEPTANCE_STATUS
   (
        D_DAS_ID NUMBER NOT NULL,
        DEMO_ACCEPT_STATUS_ID NUMBER(19,0) NOT NULL,
        DEMO_ACCEPT_STATUS_NAME VARCHAR2(255 CHAR),
        DEMO_ACCEPT_STATUS_DESCRIPTION VARCHAR2(255 CHAR),
        START_DATE DATE,
        END_DATE DATE
    )   tablespace MAXDAT_DATA;

  alter table D_DEMO_ACCEPTANCE_STATUS add constraint DAPP_DAS_PK primary key (D_DAS_ID)
  using index tablespace MAXDAT_INDX;
create unique index DAPDAS_UIX1 on D_DEMO_ACCEPTANCE_STATUS ("DEMO_ACCEPT_STATUS_ID") online tablespace MAXDAT_INDX parallel compute statistics;
Grant select on D_DEMO_ACCEPTANCE_STATUS to MAXDAT_READ_ONLY;
CREATE SEQUENCE  SEQ_APP_DAS_ID  
MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

  CREATE TABLE D_RESCHEDULED_DEMO_STATUS_TYPE
   (
        D_RDS_ID NUMBER NOT NULL,
        RESCHED_DEMO_STATUS_ID NUMBER(19,0) NOT NULL,
        RESCHED_DEMO_STATUS_NAME VARCHAR2(255 CHAR),
        RESCHED_DEMO_STATUS_DESCRIPTION VARCHAR2(255 CHAR),
        START_DATE DATE,
        END_DATE DATE
    )   tablespace MAXDAT_DATA;

  alter table D_RESCHEDULED_DEMO_STATUS_TYPE add constraint DAPP_RDS_PK primary key (D_RDS_ID)
  using index tablespace MAXDAT_INDX;
create unique index DAPRDS_UIX1 on D_RESCHEDULED_DEMO_STATUS_TYPE ("RESCHED_DEMO_STATUS_ID") online tablespace MAXDAT_INDX parallel compute statistics;
Grant select on D_RESCHEDULED_DEMO_STATUS_TYPE to MAXDAT_READ_ONLY;
CREATE SEQUENCE  SEQ_APP_RDS_ID  
MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

  CREATE TABLE D_DEMO_CONFERENCE_STATUS
   (
        D_DCS_ID NUMBER NOT NULL,
        DEMO_CONF_STATUS_ID NUMBER(19,0) NOT NULL,
        DEMO_CONF_STATUS_NAME VARCHAR2(255 CHAR),
        DEMO_CONF_STATUS_DESCRIPTION VARCHAR2(255 CHAR),
        START_DATE DATE,
        END_DATE DATE
    )   tablespace MAXDAT_DATA;

  alter table D_DEMO_CONFERENCE_STATUS add constraint DAPP_DCS_PK primary key (D_DCS_ID)
  using index tablespace MAXDAT_INDX;
create unique index DAPDCS_UIX1 on D_DEMO_CONFERENCE_STATUS ("DEMO_CONF_STATUS_ID") online tablespace MAXDAT_INDX parallel compute statistics;
Grant select on D_DEMO_CONFERENCE_STATUS to MAXDAT_READ_ONLY;
CREATE SEQUENCE  SEQ_APP_DCS_ID  
MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

  CREATE TABLE D_REVIEW_TYPE
   (
        D_RT_ID NUMBER NOT NULL,
        REVIEW_TYPE_ID NUMBER(19,0) NOT NULL,
        REVIEW_TYPE_NAME VARCHAR2(255 CHAR),
        REVIEW_TYPE_DESCRIPTION VARCHAR2(255 CHAR),
        START_DATE DATE,
        END_DATE DATE
    )   tablespace MAXDAT_DATA;

  alter table D_REVIEW_TYPE add constraint DAPP_RT_PK primary key (D_RT_ID)
  using index tablespace MAXDAT_INDX;
create unique index DAPRT_UIX1 on D_REVIEW_TYPE ("REVIEW_TYPE_ID") online tablespace MAXDAT_INDX parallel compute statistics;
Grant select on D_REVIEW_TYPE to MAXDAT_READ_ONLY;
CREATE SEQUENCE  SEQ_APP_RT_ID  
MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

  CREATE TABLE D_REVIEW_NUMBER
   (
        D_RN_ID NUMBER NOT NULL,
        REVIEW_NUMBER_ID NUMBER(19,0) NOT NULL,
        REVIEW_NUMBER_NAME VARCHAR2(255 CHAR),
        REVIEW_NUMBER_DESCRIPTION VARCHAR2(255 CHAR),
        START_DATE DATE,
        END_DATE DATE
    )   tablespace MAXDAT_DATA;

  alter table D_REVIEW_NUMBER add constraint DAPP_RN_PK primary key (D_RN_ID)
  using index tablespace MAXDAT_INDX;
create unique index DAPRN_UIX1 on D_REVIEW_NUMBER ("REVIEW_NUMBER_ID") online tablespace MAXDAT_INDX parallel compute statistics;
Grant select on D_REVIEW_NUMBER to MAXDAT_READ_ONLY;
CREATE SEQUENCE  SEQ_APP_RN_ID  
MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

  CREATE TABLE D_SECOND_MED_REV_DEC
   (
        D_SR_ID NUMBER NOT NULL,
        SECOND_MED_REV_DEC_ID NUMBER(19,0) NOT NULL,
        SECOND_MED_REV_DEC_NAME VARCHAR2(255 CHAR),
        SECOND_MED_REV_DEC_DESCRIPTION VARCHAR2(255 CHAR),
        START_DATE DATE,
        END_DATE DATE
    )   tablespace MAXDAT_DATA;

  alter table D_SECOND_MED_REV_DEC add constraint DAPP_SRD_PK primary key (D_SR_ID)
  using index tablespace MAXDAT_INDX;
create unique index DAPPSRD_UIX1 on D_SECOND_MED_REV_DEC ("SECOND_MED_REV_DEC_ID") online tablespace MAXDAT_INDX parallel compute statistics;
Grant select on D_SECOND_MED_REV_DEC to MAXDAT_READ_ONLY;
CREATE SEQUENCE  SEQ_APP_SRD_ID  
MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;

commit;
CREATE OR REPLACE VIEW D_MW_APPEAL_INSTANCE_SV
AS
SELECT *
from (select 
  a.APPEAL_ID
, a.CREATE_DATE
, a.COMPLETE_DATE
, a.CANCELLED_DATE
, (select trim(st.first_name) || ' ' || (case when st.middle_name is not null then (trim(st.middle_name) || ' ') else '' end) || trim(st.last_name) from d_staff st where st.staff_id = a.ADJUDICATOR) as ADJUDICATOR  
, a.DEADLINE_DATE 
, issues.ISSUE_NAME as APPEAL_ISSUE
, items.ITEM_SERVICE_NAME as APPEAL_ITEM  
, a.APPEAL_NUMBER
, priorities.PRIORITY_NAME as APPEAL_PRIORITY
, a.REQUEST_RECEIVED 
, stages.STAGE_NAME as APPEAL_STAGE  
, statuses.STATUS_NAME as APPEAL_STATUS 
, types.TYPE_NAME as APPEAL_TYPE
, dismissals.DISMISSAL_NAME as APPEAL_DISMISSAL 
, dismissal_reasons.DISMISS_REASON_NAME as APPEAL_DISMISSAL_REASON
, case when a.auto_forward is not null then 'Y' else 'N' end as AUTO_FORWARD
, a.CASE_FILE_REQUEST_DATE 
, a.ACKNOWLEDGEMENT_LETTER_DATE 
, a.DECISION_MAILED_DATE 
, a.DECISION_SENT_PLAN_DATE 
, a.MEDICAL_REVIEW_CHECK 
, parts.PART_NAME as APPEAL_PART
, reasons.REASON_NAME as APPEAL_REASON 
, a.APPEAL_TOLLING_DATE
, a.APPEAL_NOTICE_DATE 
, a.CASE_FILE_RECEIVED_DATE
, a.PRECHECK_COMPLETED
,a.ACKNOWLEDGEMENT_LETTER_AGE_IN_BUS_DAYS
--, a.ACKNOWLEDGEMENT_LETTER_AGE_IN_CAL_DAYS
,TRUNC(COALESCE(a.ACKNOWLEDGEMENT_LETTER_DATE,sysdate)) - TRUNC(a.REQUEST_RECEIVED) AS ACKNOWLEDGEMENT_LETTER_AGE_IN_CAL_DAYS
, 'C' as ACKNOWLEDGEMENT_LETTER_DAYS_TYPE	
,a.ACKNOWLEDGEMENT_LETTER_TIMELINESS_STATUS
, 999 as ACKNOWLEDGEMENT_LETTER_JEOPARDY_DAYS
,a.ACKNOWLEDGEMENT_LETTER_JEOPARDY_FLAG
, 999 as ACKNOWLEDGEMENT_LETTER_TIMELINESS
,a.CASE_FILE_AGE_IN_BUS_DAYS
,a.CASE_FILE_AGE_IN_CAL_DAYS
,TRUNC(COALESCE(a.CASE_FILE_RECEIVED_DATE, sysdate)) - TRUNC(a.CASE_FILE_REQUEST_DATE) AS CASE_FILE_RECEIVED_AGE_IN_CAL_DAYS
, 'C' as CASE_FILE_DAYS_TYPE
,a.CASE_FILE_TIMELINESS_STATUS
, 999 as CASE_FILE_JEOPARDY_DAYS
,a.CASE_FILE_JEOPARDY_FLAG
, 999 as CASE_FILE_TIMELINESS_THRESHOLD
,a.APPEAL_AGE_IN_BUS_DAYS
,a.APPEAL_AGE_IN_CAL_DAYS
, 'C' as APPEAL_DAYS_TYPE
,case when (a.complete_date is not null and a.complete_date <= a.deadline_date) then 'Timely' when (a.complete_date is not null and a.complete_date > a.deadline_date) then 'Untimely' else null end as APPEAL_TIMELINESS_STATUS
, 999 as APPEAL_JEOPARDY_DAYS
,a.APPEAL_JEOPARDY_FLAG
, 999 as APPEAL_TIMELINESS_THRESHOLD
,a.CASE_FILE_ENTRY_AGE_IN_BUS_DAYS
,a.CASE_FILE_ENTRY_AGE_IN_CAL_DAYS
, 'C' as CASE_FILE_ENTRY_DAYS_TYPE
,a.CASE_FILE_ENTRY_TIMELINESS_STATUS
, 999 as CASE_FILE_ENTRY_JEOPARDY_DAYS
,a.CASE_FILE_ENTRY_JEOPARDY_FLAG
,999 as CASE_FILE_ENTRY_TIMELINESS_THRESHOLD
,a.DECISION_LETTER_AGE_IN_BUS_DAYS
,a.DECISION_LETTER_AGE_IN_CAL_DAYS
, 'C' as DECISION_LETTER_DAYS_TYPE
,a.DECISION_LETTER_TIMELINESS_STATUS
,999 as DECISION_LETTER_JEOPARDY_DAYS
,a.DECISION_LETTER_JEOPARDY_FLAG
, 999 as DECISION_LETTER_TIMELINESS_THRESHOLD
,a.REQUEST_HPMS_AGE_IN_BUS_DAYS
,a.REQUEST_HPMS_AGE_IN_CAL_DAYS
, 'C' as REQUEST_HPMS_DAYS_TYPE
,a.REQUEST_HPMS_TIMELINESS_STATUS
, 999 as REQUEST_HPMS_JEOPARDY_DAYS
,a.REQUEST_HPMS_JEOPARDY_FLAG
, 999 as REQUEST_HPMS_TIMELINESS_THRESHOLD
,a.ADJUDICATOR_PROCESS_AGE_IN_BUS_DAYS
,a.ADJUDICATOR_PROCESS_AGE_IN_CAL_DAYS
, 'C' as ADJUDICATOR_PROCESS_DAYS_TYPE
,a.ADJUDICATOR_PROCESS_TIMELINESS_STATUS
, 999 as ADJUDICATOR_PROCESS_JEOPARDY_DAYS
,a.ADJUDICATOR_PROCESS_JEOPARDY_FLAG
, 999 as ADJUDICATOR_PROCESS_TIMELINESS_THRESHOLD
,a.CASE_FILE_REQUEST_AGE_IN_BUS_DAYS
--,a.CASE_FILE_REQUEST_AGE_IN_CAL_DAYS
,TRUNC(COALESCE(CASE_FILE_REQUEST_DATE, sysdate)) - TRUNC(REQUEST_RECEIVED) AS CASE_FILE_REQUEST_AGE_IN_CAL_DAYS 
, 'C' as CASE_FILE_REQUEST_DAYS_TYPE
,a.CASE_FILE_REQUEST_TIMELINESS_STATUS
, 999 as CASE_FILE_REQUEST_JEOPARDY_DAYS
,a.CASE_FILE_REQUEST_JEOPARDY_FLAG
, 999 as CASE_FILE_REQUEST_TIMELINESS_THRESHOLD
, a.CLAIMED_DATE
, decisions.DECISION_NAME as DECISION
, dec_notif_methods.DEC_NOTIF_METHOD_NAME as DECISION_NOTIFICATION_METHOD
, hpmss.HPMS_NAME as HPMS
, a.HPMS_REQUESTED_DATE
, a.IS_REQUEST_FOR_INFORMATION_P
, macs.MAC_NAME as MAC
, medicare_types.MEDICARE_TYPE_NAME as MEDICARE_TYPE
, msps.MSP_NAME as MSP
, a.NEW_DOCUMENTATION_REVIEWED
, a.PHYSICIAN_SPECIALTY
, a.REASON_FOR_APPEAL
, a.WITHDRAWAL
, withdraw_req_subms.WITHDRAW_REQ_SUBM_NAME as WITHDRAWAL_REQUEST_SUBMITTED
, non_englishes.NON_ENGLISH_NAME as NON_ENGLISH
, a.NON_ENGLISH_OTHER
, dispositions.DISPOSITION_NAME as DISPOSITION
, disposition_exps.DISPOSITION_EXP_NAME as DISPOSITION_EXPLANATION
, proc_dec_reasons.PROC_DEC_REASON_NAME as PROCEDURAL_DECISION_REASON
, sub_reasons.SUBSTANTIVE_REASON_NAME as SUBSTANTIVE_REASON
, a.FIRST_REVIEW_CASE_ATTESTATIO
, (select ft_med_rev_ds.FT_MED_REV_NAME from D_APPEAL_FT_MED_REV_DS ft_med_rev_ds where a.FIRST_MEDICAL_REVIEW_DECISIO = ft_med_rev_ds.FT_MED_REV_ID) as FIRST_MEDICAL_REVIEW_DECISIO
, (select trim(st.first_name) || ' ' || (case when st.middle_name is not null then (trim(st.middle_name) || ' ') else '' end) || trim(st.last_name) from d_staff st where st.staff_id = a.FIRST_REVIEWER) as FIRST_REVIEWER
, (select ft_med_rev_ds.FT_MED_REV_NAME from D_APPEAL_FT_MED_REV_DS ft_med_rev_ds where a.THIRD_MEDICAL_REVIEW_DECISIO = ft_med_rev_ds.FT_MED_REV_ID) as THIRD_MEDICAL_REVIEW_DECISIO
, a.THIRD_REVIEW_CASE_ATTESTATIO
, (select trim(st.first_name) || ' ' || (case when st.middle_name is not null then (trim(st.middle_name) || ' ') else '' end) || trim(st.last_name) from d_staff st where st.staff_id = a.THIRD_REVIEWER) as THIRD_REVIEWER
, a.EXPERT_REVIEW_CASE_ATTESTATI
, a.EXPERT_REVIEW_CITATION
, (select trim(st.first_name) || ' ' || (case when st.middle_name is not null then (trim(st.middle_name) || ' ') else '' end) || trim(st.last_name) from d_staff st where st.staff_id = a.EXPERT_REVIEWER_MD_ID) as EXPERT_REVIEWER_MD_ID,
a.STG_LAST_UPDATE_DATE,
(select sum (ti.task_claimed_time) from d_mw_task_instance ti where ti.source_reference_id = a.appeal_id) as CLAIMED_TIME,
(select sum (ti.task_unclaimed_time) from d_mw_task_instance ti where ti.source_reference_id = a.appeal_id) as UNCLAIMED_TIME,
a.closed_date as CLOSED_DATE,
a.withdrawn_date as WITHDRAWN_DATE,
case when (a.create_date is null or trunc(a.create_date) <= trunc(sysdate)) and (a.closed_date is null or trunc(a.closed_date) > trunc(sysdate)) 
and (a.withdrawn_date is null or trunc(a.withdrawn_date) > trunc(sysdate)) and (a.cancelled_date is null or trunc(a.cancelled_date) > trunc(sysdate))
then 1 else 0 end as INVENTORY_FLAG,
case when (a.create_date is null or trunc(a.create_date) <= trunc(sysdate)) and (a.complete_date is null or trunc(a.complete_date) > trunc(sysdate)) 
and (a.closed_date is null or trunc(a.closed_date) > trunc(sysdate)) and (a.withdrawn_date is null or trunc(a.withdrawn_date) > trunc(sysdate)) 
and (a.cancelled_date is null or trunc(a.cancelled_date) > trunc(sysdate))
then 1 else 0 end as SLA_INVENTORY_FLAG,
ds.doc_source_name as DOCUMENT_SOURCE,
(select count(distinct (document_id)) from d_qic_document qd where qd.appeal_id = a.appeal_id) as document_count,
(select count(distinct (claim_id)) from d_qic_claim qc where qc.appeal_id = a.appeal_id) as claim_count,
DRT.DEMO_REOPEN_TYPE_NAME as DEMO_REOPENING_TYPE,
a.OTHER_REOPENING_TYPE,
a.CASE_CURRENTLY_WITH_ALJ,
a.DATE_OF_REQUEST_TO_ALJ,
a.DEMO_REOPENING_DUE_DATE,
a.DEMO_REO_SENT_TO_OMHA_DATE,
a.OMHA_RESPONSE_RECEIVED,
OHR.OMHA_RESPONSE_NAME as RESPONSE_FROM_OMHA,
a.ADDITIONAL_INFO_REQUESTED,
a.REQUESTED_INFORMATION_DUE,
a.DEMO_REOPEN_FOLLOW_UP,
a.ADDITIONAL_INFO_RECEIVED,
RDR.REOPEN_DECISION_RESULTS_NAME as REOPENING_DECISION_RESULTS,
NRR.NOT_REOPENED_REASON_NAME as NOT_REOPENED_REASON,
a.OMHA_REMAND_REQUEST,
a.REMAND_ELIGIBILITY_RESPONSE,
a.REMAND_RECEIVED_DATE,	
ORR.OMHA_REM_RESP_NAME as OMHA_REMAND_REQUEST_RESPONSE,
a.OMHA_WITHDRAW_FORM_SENT,
a.OMHA_WITHDRAW_FORM_RETURNED,
a.OMHA_NOTIFIED_OF_WITHDRAWL,
a.ALJ_WITHDRAWAL,
a.DEMO_REOPENING_APPEAL_NUMBER,
a.REOPENING_ANALYSIS_COMPLETED,
RAOT.REOPEN_ANALYSIS_OUTCOME_TYPE_NAME as REOPENING_ANALYSIS_OUTCOME,
NPCRT.NOT_PURSUE_CONTR_REASON_TYPE_NAME  as NOT_PURSUED_BY_CONTR_REASON,
a.ACK_LETTER_MAILED,
a.REO_DECISION_LETTER_MAILED,
RO.REOPEN_OUTCOME_NAME as REOPENING_OUTCOME,
a.DECLINE_TO_REOPEN_DECISION,
a.APPEAL_ATTESTATION_DATE,
a.APPEAL_ATTESTATION,
a.DEMO_SCHEDULED,
a.DEMO_NOTIFICATION_LETTER_SENT,
a.RESPONSE_DUE,
a.RESPONSE_RECEIVED,
DAS.DEMO_STATUS_NAME as DEMO_ACCEPTANCE_STATUS,
a.TELE_DEMO_FOLLOW_UP,
a.DEMO_NOTIFICATION_LTR_RESENT,
a.RESCHEDULED_RESPONSE_DUE,
a.RESCHEDULE_RESPONSE_RECEIVED,
a.VERBAL_CONFIRMATION,
RDS.DEMO_STATUS_NAME as RESCHEDULED_DEMO_STATUS,
a.PROVIDER_OR_SUPPLIER_NAME,	
DCS.DEMO_CONF_STATUS_NAME as DEMO_CONFERENCE_STATUS,
RT.REVIEW_TYPE_NAME as REVIEW_TYPE,
SMRD.SECOND_MED_REV_DEC_NAME as EXPERT_REVIEW_DECISION,		
RN.REVIEW_NUMBER_NAME  as REVIEW_NUMBER,
a.EXPERT_REVIEW_CASE_ATTESTATI as SECOND_REVIEW_CASE_ATTESTATION,
case when (a.DEMO_REO_SENT_TO_OMHA_DATE is null) and 
(ti.task_type_id = 9286497 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as DEMO_REOPENING_NEW_COUNT,
case when (a.DEMO_REO_SENT_TO_OMHA_DATE is not null) and 
(a.OMHA_RESPONSE_RECEIVED is null) and 
(ti.task_type_id = 9286497 and ti.instance_start_date is not null and ti.instance_end_date is null)
then 1 else 0 end as SENT_TO_OMHA_COUNT,
case when (a.OMHA_RESPONSE_RECEIVED is not null) and 
(a.RESPONSE_FROM_OMHA = 9287858) and 
(ti.task_type_id = 9286497 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as OMHA_RESPONSE_RECEIVED_NOT_REOPEN_COUNT,
case when (a.OMHA_RESPONSE_RECEIVED is not null) and 
(a.RESPONSE_FROM_OMHA = 9287857) 
and (a.REQUESTED_INFORMATION_DUE is null or trunc(a.REQUESTED_INFORMATION_DUE) >= trunc(sysdate)) and
(ti.task_type_id = 9286497 and ti.instance_start_date is not null and ti.instance_end_date is null)
then 1 else 0 end as OMHA_RESPONSE_RECEIVED_REOPEN_COUNT,
case when (a.ADDITIONAL_INFO_RECEIVED is null)  
and (a.REQUESTED_INFORMATION_DUE is null or trunc(a.REQUESTED_INFORMATION_DUE) >= trunc(sysdate)) and 
(ti.task_type_id = 9286497 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as AWAITING_ADDITIONAL_INFO_COUNT,
case when (a.ADDITIONAL_INFO_RECEIVED is null)  
and (a.REQUESTED_INFORMATION_DUE is not null and trunc(a.REQUESTED_INFORMATION_DUE) < trunc(sysdate)) 
and (a.NOT_REOPENED_REASON is null)
and (ti.task_type_id = 9286497 and ti.instance_start_date is not null and ti.instance_end_date is null)
then 1 else 0 end as ADDITIONAL_INFO_OVERDUE_COUNT,
case when (a.ADDITIONAL_INFO_RECEIVED is not null)  
and (a.REQUESTED_INFORMATION_DUE is null or trunc(a.REQUESTED_INFORMATION_DUE) >= trunc(sysdate)) 
and (a.OMHA_REMAND_REQUEST is null)
and (ti.task_type_id = 9286497 and ti.instance_start_date is not null and ti.instance_end_date is null)
then 1 else 0 end as ADDITIONAL_INFORMATION_RECEIVED_COUNT,
case when (a.OMHA_REMAND_REQUEST is not null)
and (a.REMAND_ELIGIBILITY_RESPONSE is null)
and (ti.task_type_id = 9286497 and ti.instance_start_date is not null and ti.instance_end_date is null)
then 1 else 0 end as AWAITING_REMAND_ELIGIBILITY_RESPONSE_FROM_OMHA_COUNT,
case when (a.REMAND_ELIGIBILITY_RESPONSE is not null)
and (a.REMAND_RECEIVED_DATE is null)
and (ti.task_type_id = 9286497 and ti.instance_start_date is not null and ti.instance_end_date is null)
then 1 else 0 end as AWAITING_REMAND_COUNT,
case when (a.REMAND_RECEIVED_DATE is not null)
and (a.REOPENING_ANALYSIS_COMPLETED is null)
and (ti.task_type_id = 9286497 and ti.instance_start_date is not null and ti.instance_end_date is null)
then 1 else 0 end as REOPENING_ANALYSIS_COUNT,
case when (a.REOPENING_ANALYSIS_COMPLETED is not null)
and (a.REO_DECISION_LETTER_MAILED is null) 
and (ti.task_type_id = 9286497 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as REOPENING_DECISION_LETTER_NEEDED_COUNT,
case when (a.REO_DECISION_LETTER_MAILED is not null) 
and (ti.task_type_id = 9286497 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as REOPENING_COMPLETE_COUNT,
case when (a.OMHA_WITHDRAW_FORM_SENT is not null)
and (a.OMHA_WITHDRAW_FORM_RETURNED is null)
and (ti.task_type_id = 9286497 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as AWAITING_OMHA_WITHDRAWL_FORM_FROM_SUPPLIER_COUNT,
case when (a.OMHA_WITHDRAW_FORM_RETURNED is not null)
and (a.OMHA_NOTIFIED_OF_WITHDRAWL is null) 
and (ti.task_type_id = 9286497 and ti.instance_start_date is not null and ti.instance_end_date is null)
then 1 else 0 end as NOTIFY_OMHA_OF_SUPPLIER_WITHDRAWL_COUNT,
case when (a.OMHA_NOTIFIED_OF_WITHDRAWL is not null)
and (a.ALJ_WITHDRAWAL is null)
and (ti.task_type_id = 9286497 and ti.instance_start_date is not null and ti.instance_end_date is null)
then 1 else 0 end  as PENDING_ALJ_WITHDRAWAL_COUNT,
case when (a.DEMO_SCHEDULED is null)
and (a.DEMO_NOTIFICATION_LETTER_SENT is null)
and (ti.task_type_id = 9286496 and ti.instance_start_date is not null and ti.instance_end_date is null)
then 1 else 0 end as NEW_READY_FOR_DEMO_COUNT,
case when (a.DEMO_SCHEDULED is not null)
and (a.DEMO_NOTIFICATION_LETTER_SENT is not null)
and (a.RESPONSE_RECEIVED is null)
and (a.RESPONSE_DUE is null or trunc(a.RESPONSE_DUE) > trunc(sysdate))
and (a.DEMO_NOTIFICATION_LTR_RESENT is null)
and (a.TELE_DEMO_FOLLOW_UP is null)
and (ti.task_type_id = 9286496 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as AWAITING_RESPONSE_COUNT,
case when (a.DEMO_NOTIFICATION_LETTER_SENT is not null)
and (a.RESPONSE_RECEIVED is not null)
and (a.DEMO_ACCEPTANCE_STATUS = 9287312)
and (a.DEMO_SCHEDULED > sysdate) --? --- note demo_scheduled has times as well as dates in source
and (ti.task_type_id = 9286496 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as RESPONSE_RECEIVED_ACCEPTED_PENDING_CONFERENCE_COUNT,
case when (a.DEMO_NOTIFICATION_LETTER_SENT is not null)
and (a.RESPONSE_RECEIVED is not null)
and (a.DEMO_ACCEPTANCE_STATUS = 9287313)
and (ti.task_type_id = 9286496 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as RESPONSE_RECEIVED_DECLINED_COUNT,
case when (a.DEMO_SCHEDULED is not null)
and (a.DEMO_NOTIFICATION_LETTER_SENT is not null)
and (a.RESPONSE_RECEIVED is null)
and (a.RESPONSE_DUE is not null and trunc(a.RESPONSE_DUE) < trunc(sysdate))
and (a.DEMO_NOTIFICATION_LTR_RESENT is null)
and (a.TELE_DEMO_FOLLOW_UP is null)
and (ti.task_type_id = 9286496 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as RESPONSE_OVERDUE_FOLLOW_UP_REQUIRED_COUNT,
case when (a.DEMO_SCHEDULED is not null)
and (a.DEMO_NOTIFICATION_LETTER_SENT is not null)
and (a.RESPONSE_RECEIVED is null)
and (a.RESPONSE_DUE is not null and trunc(a.RESPONSE_DUE) < trunc(sysdate))
and (a.DEMO_NOTIFICATION_LTR_RESENT is null) --?
and (a.TELE_DEMO_FOLLOW_UP is not null)
and (ti.task_type_id = 9286496 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as RESPONSE_OVERDUE_FOLLOW_UP_COMPLETE_COUNT,
case when (a.DEMO_NOTIFICATION_LTR_RESENT is not null)
and (a.RESCHEDULE_RESPONSE_RECEIVED is null)
and (a.RESCHEDULED_RESPONSE_DUE is null or trunc(a.RESCHEDULED_RESPONSE_DUE) >= trunc(sysdate))
and (ti.task_type_id = 9286496 and ti.instance_start_date is not null and ti.instance_end_date is null)
then 1 else 0 end as AWAITING_RESCHEDULE_RESPONSE_COUNT,
case when  (a.RESCHEDULE_RESPONSE_RECEIVED is not null)
and (a.DEMO_ACCEPTANCE_STATUS = 9287312)
and (ti.task_type_id = 9286496 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as RESCHEDULE_RESPONSE_RECEIVED_ACCEPTED_COUNT,
case when  (a.RESCHEDULE_RESPONSE_RECEIVED is not null)
and (a.DEMO_ACCEPTANCE_STATUS = 9287313)
and (ti.task_type_id = 9286496 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as RESCHEDULE_RESPONSE_RECEIVED_DECLINED_COUNT,
case when (a.DEMO_NOTIFICATION_LTR_RESENT is not null)
and (a.RESCHEDULE_RESPONSE_RECEIVED is null) --?
and (a.RESCHEDULED_RESPONSE_DUE is not null and trunc(a.RESCHEDULED_RESPONSE_DUE) < trunc(sysdate))
and (ti.task_type_id = 9286496 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as RESCHEDULE_RESPONSE_OVERDUE_COUNT,
case when (a.DEMO_CONFERENCE_STATUS = 9287314)
and (ti.task_type_id = 9286496 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as DEMO_CONFERENCE_HELD_COUNT,
case when (a.DEMO_CONFERENCE_STATUS = 9287316 )
and (ti.task_type_id = 9286496 and ti.instance_start_date is not null and ti.instance_end_date is null) 
then 1 else 0 end as DEMO_CONFERENCE_CANCELLED_NO_SHOW_COUNT,
rank() over (partition by a.appeal_id order by ti.task_id desc) rnk
from D_MW_APPEAL_INSTANCE a
LEFT OUTER JOIN D_APPEAL_PRIORITIES priorities ON a.APPEAL_PRIORITY_ID = priorities.PRIORITY_ID
LEFT OUTER JOIN D_APPEAL_PARTS parts ON a.APPEAL_PART_ID = parts.PART_ID
LEFT OUTER JOIN D_APPEAL_ISSUES issues ON a.APPEAL_ISSUE = issues.ISSUE_ID
LEFT OUTER JOIN D_APPEAL_ITEM_SERVICES items ON a.APPEAL_ITEM = items.ITEM_SERVICE_ID
LEFT OUTER JOIN D_APPEAL_STAGES stages ON a.APPEAL_STAGE = stages.STAGE_ID
LEFT OUTER JOIN D_APPEAL_STATUSES statuses ON a.APPEAL_STATUS = statuses.STATUS_ID
LEFT OUTER JOIN D_APPEAL_TYPES types ON a.APPEAL_TYPE = types.TYPE_ID
LEFT OUTER JOIN D_APPELLANT_DISMISSALS dismissals ON a.APPEAL_DISMISSAL = dismissals.DISMISSAL_ID
LEFT OUTER JOIN D_APPELLANT_DISMISS_REASONS dismissal_reasons ON a.APPEAL_DISMISSAL_REASON = dismissal_reasons.DISMISS_REASON_ID
LEFT OUTER JOIN D_APPEAL_REASONS reasons ON a.APPEAL_REASON = reasons.REASON_ID
LEFT OUTER JOIN D_APPEAL_DECISIONS decisions ON a.DECISION = decisions.DECISION_ID
LEFT OUTER JOIN D_APPEAL_DEC_NOTIF_METHODS dec_notif_methods ON a.DECISION_NOTIFICATION_METHOD = dec_notif_methods.DEC_NOTIF_METHOD_ID
LEFT OUTER JOIN D_APPEAL_HPMSS hpmss ON a.HPMS = hpmss.HPMS_ID
LEFT OUTER JOIN D_APPEAL_MACS macs ON a.MAC = macs.MAC_ID
LEFT OUTER JOIN D_APPEAL_MEDICARE_TYPES medicare_types ON a.MEDICARE_TYPE = medicare_types.MEDICARE_TYPE_ID
LEFT OUTER JOIN D_APPEAL_MSPS msps ON a.MSP = msps.MSP_ID
LEFT OUTER JOIN D_APPEAL_WITHDRAW_REQ_SUBMS withdraw_req_subms ON a.WITHDRAWAL_REQUEST_SUBMITTED = withdraw_req_subms.WITHDRAW_REQ_SUBM_ID
LEFT OUTER JOIN D_APPEAL_NON_ENGLISHES non_englishes ON a.NON_ENGLISH = non_englishes.NON_ENGLISH_ID
LEFT OUTER JOIN D_APPEAL_DISPOSITIONS dispositions ON a.DISPOSITION = dispositions.DISPOSITION_ID
LEFT OUTER JOIN D_APPEAL_DISPOSITION_EXPS disposition_exps ON a.DISPOSITION_EXPLANATION = disposition_exps.DISPOSITION_ExP_ID
LEFT OUTER JOIN D_APPEAL_PROC_DEC_REASONS proc_dec_reasons ON a.PROCEDURAL_DECISION_REASON = proc_dec_reasons.PROC_DEC_REASON_ID
LEFT OUTER JOIN D_APPEAL_SUBSTANTIVE_REASONS sub_reasons ON a.SUBSTANTIVE_REASON = sub_reasons.SUBSTANTIVE_REASON_ID
LEFT OUTER JOIN d_qic_document doc ON doc.appeal_id = a.appeal_id and doc.document_type = 1891 
LEFT OUTER JOIN D_DOC_SOURCE ds ON doc.SOURCE = ds.DOC_SOURCE_ID
LEFT OUTER JOIN D_DEMO_REOPENING_TYPE DRT ON a.DEMO_REOPENING_TYPE = DRT.DEMO_REOPEN_TYPE_ID
LEFT OUTER JOIN D_OMHA_RESPONSE OHR ON a.RESPONSE_FROM_OMHA = OHR.OMHA_RESPONSE_ID
LEFT OUTER JOIN D_REOPENING_DECISION_RESULTS RDR ON a.REOPENING_DECISION_RESULTS = RDR.REOPEN_DECISION_RESULTS_ID
LEFT OUTER JOIN D_NOT_REOPENED_REASON NRR ON a.NOT_REOPENED_REASON = NRR.NOT_REOPENED_REASON_ID
LEFT OUTER JOIN D_OMHA_REM_RESP ORR ON a.OMHA_REMAND_REQUEST_RESPONSE = ORR.OMHA_REM_RESP_ID
LEFT OUTER JOIN D_REOPENING_ANALYSIS_OUTCOME_TYPE RAOT ON a.REOPENING_ANALYSIS_OUTCOME	 = RAOT.REOPEN_ANALYSIS_OUTCOME_TYPE_ID 
LEFT OUTER JOIN D_NOT_PURSUE_CONTR_REASON_TYPE NPCRT ON a.NOT_PURSUED_BY_CONTR_REASON =  NPCRT.NOT_PURSUE_CONTR_REASON_TYPE_ID
LEFT OUTER JOIN D_REOPENING_OUTCOME RO ON a.REOPENING_OUTCOME = RO.REOPEN_OUTCOME_ID 
LEFT OUTER JOIN D_DEMO_STATUS DAS ON a.DEMO_ACCEPTANCE_STATUS= DAS.DEMO_STATUS_ID
LEFT OUTER JOIN D_DEMO_STATUS RDS ON a.RESCHEDULED_DEMO_STATUS = RDS.DEMO_STATUS_ID
LEFT OUTER JOIN D_DEMO_CONFERENCE_STATUS DCS ON a.DEMO_CONFERENCE_STATUS= DCS.DEMO_CONF_STATUS_ID
LEFT OUTER JOIN D_REVIEW_TYPE RT ON a.REVIEW_TYPE = RT.REVIEW_TYPE_ID 
LEFT OUTER JOIN D_SECOND_MED_REV_DEC SMRD ON a.EXPERT_REVIEW_DECISION = SMRD.SECOND_MED_REV_DEC_ID
LEFT OUTER JOIN D_REVIEW_NUMBER RN ON a.REVIEW_NUMBER = RN.REVIEW_NUMBER_ID 
LEFT OUTER JOIN D_MW_TASK_INSTANCE ti ON a.appeal_id = ti.source_reference_id
)
where rnk=1
with read only;
GRANT SELECT ON D_MW_APPEAL_INSTANCE_SV TO MAXDAT_READ_ONLY;

commit;


CREATE OR REPLACE VIEW MAXDAT.F_MW_APPEAL_INSTANCE_BY_DATE_SV
AS select 
a.APPEAL_ID
, bdd.D_DATE
, a.CREATE_DATE
, a.COMPLETE_DATE
, a.CANCELLED_DATE
, (select trim(st.first_name) || ' ' || (case when st.middle_name is not null then (trim(st.middle_name) || ' ') else '' end) || trim(st.last_name) from d_staff st where st.staff_id = a.ADJUDICATOR) as ADJUDICATOR
, a.DEADLINE_DATE
, issues.ISSUE_NAME as APPEAL_ISSUE
, items.ITEM_SERVICE_NAME as APPEAL_ITEM
, a.APPEAL_NUMBER
, priorities.PRIORITY_NAME as APPEAL_PRIORITY
, a.REQUEST_RECEIVED
, stages.STAGE_NAME as APPEAL_STAGE
, statuses.STATUS_NAME as APPEAL_STATUS
, types.TYPE_NAME as APPEAL_TYPE
, dismissals.DISMISSAL_NAME as APPEAL_DISMISSAL
, dismissal_reasons.DISMISS_REASON_NAME as APPEAL_DISMISSAL_REASON
, case when a.auto_forward is not null then 'Y' else 'N' end as AUTO_FORWARD
, a.CASE_FILE_REQUEST_DATE
, a.ACKNOWLEDGEMENT_LETTER_DATE
, a.DECISION_MAILED_DATE
, a.DECISION_SENT_PLAN_DATE
, a.MEDICAL_REVIEW_CHECK
, parts.PART_NAME as APPEAL_PART
, reasons.REASON_NAME as APPEAL_REASON
, a.APPEAL_TOLLING_DATE
, a.APPEAL_NOTICE_DATE
, a.CASE_FILE_RECEIVED_DATE
, a.PRECHECK_COMPLETED
,a.ACKNOWLEDGEMENT_LETTER_AGE_IN_BUS_DAYS
--,a.ACKNOWLEDGEMENT_LETTER_AGE_IN_CAL_DAYS
,TRUNC(COALESCE(a.ACKNOWLEDGEMENT_LETTER_DATE,sysdate)) - TRUNC(a.REQUEST_RECEIVED) AS ACKNOWLEDGEMENT_LETTER_AGE_IN_CAL_DAYS
, 'C' as ACKNOWLEDGEMENT_LETTER_DAYS_TYPE
,a.ACKNOWLEDGEMENT_LETTER_TIMELINESS_STATUS
, 999 as ACKNOWLEDGEMENT_LETTER_JEOPARDY_DAYS
,a.ACKNOWLEDGEMENT_LETTER_JEOPARDY_FLAG
, 999 as ACKNOWLEDGEMENT_LETTER_TIMELINESS
,a.CASE_FILE_AGE_IN_BUS_DAYS
,a.CASE_FILE_AGE_IN_CAL_DAYS
,TRUNC(COALESCE(a.CASE_FILE_RECEIVED_DATE, sysdate)) - TRUNC(a.CASE_FILE_REQUEST_DATE) AS CASE_FILE_RECEIVED_AGE_IN_CAL_DAYS
, 'C' as CASE_FILE_DAYS_TYPE
,a.CASE_FILE_TIMELINESS_STATUS
, 999 as CASE_FILE_JEOPARDY_DAYS
,a.CASE_FILE_JEOPARDY_FLAG
, 999 as CASE_FILE_TIMELINESS_THRESHOLD
,a.APPEAL_AGE_IN_BUS_DAYS
,a.APPEAL_AGE_IN_CAL_DAYS
, 'C' as APPEAL_DAYS_TYPE
,case when (a.complete_date is not null and a.complete_date <= a.deadline_date) then 'Timely' when (a.complete_date is not null and a.complete_date > a.deadline_date) then 'Untimely' else null end as APPEAL_TIMELINESS_STATUS
, 999 as APPEAL_JEOPARDY_DAYS
,a.APPEAL_JEOPARDY_FLAG
, 999 as APPEAL_TIMELINESS_THRESHOLD
,a.CASE_FILE_ENTRY_AGE_IN_BUS_DAYS
,a.CASE_FILE_ENTRY_AGE_IN_CAL_DAYS
, 'C' as CASE_FILE_ENTRY_DAYS_TYPE
,a.CASE_FILE_ENTRY_TIMELINESS_STATUS
, 999 as CASE_FILE_ENTRY_JEOPARDY_DAYS
,a.CASE_FILE_ENTRY_JEOPARDY_FLAG
,999 as CASE_FILE_ENTRY_TIMELINESS_THRESHOLD
,a.DECISION_LETTER_AGE_IN_BUS_DAYS
,a.DECISION_LETTER_AGE_IN_CAL_DAYS
, 'C' as DECISION_LETTER_DAYS_TYPE
,a.DECISION_LETTER_TIMELINESS_STATUS
,999 as DECISION_LETTER_JEOPARDY_DAYS
,a.DECISION_LETTER_JEOPARDY_FLAG
, 999 as DECISION_LETTER_TIMELINESS_THRESHOLD
,a.REQUEST_HPMS_AGE_IN_BUS_DAYS
,a.REQUEST_HPMS_AGE_IN_CAL_DAYS
, 'C' as REQUEST_HPMS_DAYS_TYPE
,a.REQUEST_HPMS_TIMELINESS_STATUS
, 999 as REQUEST_HPMS_JEOPARDY_DAYS
,a.REQUEST_HPMS_JEOPARDY_FLAG
, 999 as REQUEST_HPMS_TIMELINESS_THRESHOLD
,a.ADJUDICATOR_PROCESS_AGE_IN_BUS_DAYS
,a.ADJUDICATOR_PROCESS_AGE_IN_CAL_DAYS
, 'C' as ADJUDICATOR_PROCESS_DAYS_TYPE
,a.ADJUDICATOR_PROCESS_TIMELINESS_STATUS
, 999 as ADJUDICATOR_PROCESS_JEOPARDY_DAYS
,a.ADJUDICATOR_PROCESS_JEOPARDY_FLAG
, 999 as ADJUDICATOR_PROCESS_TIMELINESS_THRESHOLD
,a.CASE_FILE_REQUEST_AGE_IN_BUS_DAYS
--,a.CASE_FILE_REQUEST_AGE_IN_CAL_DAYS
,TRUNC(COALESCE(a.CASE_FILE_REQUEST_DATE, sysdate)) - TRUNC(a.REQUEST_RECEIVED) AS CASE_FILE_REQUEST_AGE_IN_CAL_DAYS 
, 'C' as CASE_FILE_REQUEST_DAYS_TYPE
,a.CASE_FILE_REQUEST_TIMELINESS_STATUS
, 999 as CASE_FILE_REQUEST_JEOPARDY_DAYS
,a.CASE_FILE_REQUEST_JEOPARDY_FLAG
, 999 as CASE_FILE_REQUEST_TIMELINESS_THRESHOLD
, a.CLAIMED_DATE
, decisions.DECISION_NAME as DECISION
, dec_notif_methods.DEC_NOTIF_METHOD_NAME as DECISION_NOTIFICATION_METHOD
, hpmss.HPMS_NAME as HPMS
, a.HPMS_REQUESTED_DATE
, a.IS_REQUEST_FOR_INFORMATION_P
, macs.MAC_NAME as MAC
, medicare_types.MEDICARE_TYPE_NAME as MEDICARE_TYPE
, msps.MSP_NAME as MSP
, a.NEW_DOCUMENTATION_REVIEWED
, a.PHYSICIAN_SPECIALTY
, a.REASON_FOR_APPEAL
, a.WITHDRAWAL
, withdraw_req_subms.WITHDRAW_REQ_SUBM_NAME as WITHDRAWAL_REQUEST_SUBMITTED
, non_englishes.NON_ENGLISH_NAME as NON_ENGLISH
, a.NON_ENGLISH_OTHER
, dispositions.DISPOSITION_NAME as DISPOSITION
, disposition_exps.DISPOSITION_EXP_NAME as DISPOSITION_EXPLANATION
, proc_dec_reasons.PROC_DEC_REASON_NAME as PROCEDURAL_DECISION_REASON
, sub_reasons.SUBSTANTIVE_REASON_NAME as SUBSTANTIVE_REASON
, a.FIRST_REVIEW_CASE_ATTESTATIO
, (select ft_med_rev_ds.FT_MED_REV_NAME from D_APPEAL_FT_MED_REV_DS ft_med_rev_ds where a.FIRST_MEDICAL_REVIEW_DECISIO = ft_med_rev_ds.FT_MED_REV_ID) as FIRST_MEDICAL_REVIEW_DECISIO
, (select trim(st.first_name) || ' ' || (case when st.middle_name is not null then (trim(st.middle_name) || ' ') else '' end) || trim(st.last_name) from d_staff st where st.staff_id = a.FIRST_REVIEWER) as FIRST_REVIEWER
, (select ft_med_rev_ds.FT_MED_REV_NAME from D_APPEAL_FT_MED_REV_DS ft_med_rev_ds where a.THIRD_MEDICAL_REVIEW_DECISIO = ft_med_rev_ds.FT_MED_REV_ID) as THIRD_MEDICAL_REVIEW_DECISIO
, a.THIRD_REVIEW_CASE_ATTESTATIO
, (select trim(st.first_name) || ' ' || (case when st.middle_name is not null then (trim(st.middle_name) || ' ') else '' end) || trim(st.last_name) from d_staff st where st.staff_id = a.THIRD_REVIEWER) as THIRD_REVIEWER
, a.EXPERT_REVIEW_CASE_ATTESTATI
, a.EXPERT_REVIEW_CITATION
, (select trim(st.first_name) || ' ' || (case when st.middle_name is not null then (trim(st.middle_name) || ' ') else '' end) || trim(st.last_name) from d_staff st where st.staff_id = a.EXPERT_REVIEWER_MD_ID) as EXPERT_REVIEWER_MD_ID,
a.CLOSED_DATE,
a.WITHDRAWN_DATE
              ,CASE WHEN bdd.D_DATE = TRUNC(a.CREATE_DATE) THEN 1 ELSE 0 END AS CREATION_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.CLOSED_DATE) OR bdd.D_DATE = TRUNC(a.CANCELLED_DATE) OR bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE)) THEN 0 ELSE 1 END AS INVENTORY_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.CLOSED_DATE) OR bdd.D_DATE = TRUNC(a.CANCELLED_DATE) OR bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE))
		OR (a.COMPLETE_DATE IS NOT NULL AND bdd.d_DATE >= TRUNC(a.COMPLETE_DATE))
		THEN 0 ELSE 1 END AS SLA_INVENTORY_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.COMPLETE_DATE) THEN 1 ELSE 0 END AS COMPLETION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.CLOSED_DATE) THEN 1 ELSE 0 END AS CLOSED_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.CANCELLED_DATE) THEN 1 ELSE 0 END AS CANCELLATION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE) THEN 1 ELSE 0 END AS WITHDRAWN_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.CLOSED_DATE) OR bdd.D_DATE = TRUNC(a.CANCELLED_DATE) OR bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE)) THEN 1 ELSE 0 END AS TERMINATION_COUNT,
              Bus_days_between(TRUNC(a.CREATE_DATE), trunc(bdd.d_date)) AGE_IN_BUS_DAYS,
              CASE WHEN  (bdd.D_DATE = TRUNC(a.COMPLETE_DATE) AND bdd.D_DATE <= a.DEADLINE_DATE AND a.complete_date <= a.deadline_date) THEN 1 ELSE 0 END as TIMELY_APPEALS_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.COMPLETE_DATE) AND (bdd.D_DATE > a.DEADLINE_DATE or a.complete_date > a.deadline_date)) THEN 1 ELSE 0 END as UNTIMELY_APPEALS_COUNT,
case when (bdd.d_date = trunc(a.create_date)) then (select count(distinct(claim_id)) from d_qic_claim qc where a.appeal_id = qc.appeal_id) else 0 end as CLAIM_CREATION_COUNT,
case when (bdd.d_date = trunc(a.closed_date)) then (select count(distinct(claim_id)) from d_qic_claim qc where a.appeal_id = qc.appeal_id) else 0 end as CLAIMS_CLOSED_COUNT,
CASE WHEN bdd.D_DATE = TRUNC(a.CASE_FILE_RECEIVED_DATE) THEN 1 ELSE 0 END AS CASE_FILE_RECEIVED_COUNT,
CASE WHEN ( (a.CASE_FILE_REQUEST_DATE IS NOT NULL ) AND (bdd.D_DATE >= TRUNC(a.CASE_FILE_REQUEST_DATE) )
AND ( (a.CASE_FILE_RECEIVED_DATE IS NULL) OR (bdd.d_date < trunc(a.CASE_FILE_RECEIVED_DATE)) )) THEN 1 ELSE 0 END AS CASE_FILE_PENDING_COUNT,
a.DEMO_SCHEDULED,
a.DEMO_NOTIFICATION_LETTER_SENT,
a.EXPERT_REVIEW_CASE_ATTESTATI as SECOND_REVIEW_CASE_ATTESTATION,
0 as RECEIVED_CASE_COUNT,
0 as RECEIVED_CLAIM_COUNT,
0 as CASE_REQUEST_COUNT,
0 AS AWAITING_CASES_COUNT,
0 as AWAITING_FILES_COUNT,
0 as PENDING_TRIAGE_CASES_COUNT,
0 as PENDING_TRIAGE_CLAIMS_COUNT,
0 as CLINICAL_REVIEW_COUNT,
0 as TECHNICAL_REVIEW_COUNT,
0 as PENDNG_LETTER_COUNT,
0 as CLINICAL_DEMO_COUNT,
0 as TECHNICAL_DEMO_COUNT,
0 as DEMO_SCHEDULED_COUNT,
0 as NOTIFICATION_SENT_COUNT,
0 as PENDNG_SECOND_REVIEW_COUNT,
0 as CLINICAL_READY_FOR_APPEAL_REVIEW_COUNT,
0 as TECHNICAL_READY_FOR_APPEAL_REVIEW_COUNT,
0 as PENDING_FOR_LETTER_WRITING_COUNT,
0 as CLINICAL_READY_FOR_DEMO_COUNT,
0 as TECHNICAL_READY_FOR_DEMO_COUNT,
0 as DEMO_SCHEDULED_TODAY_COUNT,
0 as NOTIFICATION_SENT_TODAY_COUNT,
0 as CLAIMS_PENDING_SECOND_REVIEW_COUNT,
0 as FIRST_REVIEW_TODAY_COUNT,
0 as SECOND_REVIEW_TODAY_COUNT,
0 as LETTER_WRITTEN_TODAY_COUNT,
0 as TOTAL_CLOSED_TODAY_COUNT,
0 as FAVORABLE_COUNT,
0 as UNFAVORABLE_COUNT,
0 as PARTIALLY_FAVORABLE_COUNT,
0 as DISMISSED_COUNT,
0 as DEMO_REOPENING_NEW_COUNT,
0 as SENT_TO_OMHA_COUNT,
0 as OMHA_RESPONSE_RECEIVED_NOT_REOPEN_COUNT,
0 as OMHA_RESPONSE_RECEIVED_REOPEN_COUNT,
0 as AWAITING_ADDITIONAL_INFO_COUNT,
0 as ADDITIONAL_INFO_OVERDUE_COUNT,
0 as ADDITIONAL_INFORMATION_RECEIVED_COUNT,
0 as AWAITING_REMAND_ELIGIBILITY_RESPONSE_FROM_OMHA_COUNT,
0 as AWAITING_REMAND_COUNT,
0 as REOPENING_ANALYSIS_COUNT,
0 as REOPENING_DECISION_LETTER_NEEDED_COUNT,
0 as REOPENING_COMPLETE_COUNT,
0 as AWAITING_OMHA_WITHDRAWL_FORM_FROM_SUPPLIER_COUNT,
0 as NOTIFY_OMHA_OF_SUPPLIER_WITHDRAWL_COUNT,
0 as PENDING_ALJ_WITHDRAWAL_COUNT,
0 as NEW_READY_FOR_DEMO_COUNT,
0 as AWAITING_RESPONSE_COUNT,
0 as RESPONSE_RECEIVED_ACCEPTED_PENDING_CONFERENCE_COUNT,
0 as RESPONSE_RECEIVED_DECLINED_COUNT,
0 as RESPONSE_OVERDUE_FOLLOW_UP_REQUIRED_COUNT,
0 as RESPONSE_OVERDUE_FOLLOW_UP_COMPLETE_COUNT,
0 as AWAITING_RESCHEDULE_RESPONSE_COUNT,
0 as RESCHEDULE_RESPONSE_RECEIVED_ACCEPTED_COUNT,
0 as RESCHEDULE_RESPONSE_RECEIVED_DECLINED_COUNT,
0 as RESCHEDULE_RESPONSE_OVERDUE_COUNT,
0 as DEMO_CONFERENCE_HELD_COUNT,
0 as DEMO_CONFERENCE_CANCELLED_NO_SHOW_COUNT
FROM D_DATES bdd
JOIN D_MW_APPEAL_INSTANCE a
  ON  (
       ((a.create_date is null) OR (bdd.D_DATE >= TRUNC(a.CREATE_DATE)))
       AND (
                ((closed_date is null) OR (bdd.d_date <= trunc(closed_date))) AND
 		((cancelled_date is null) OR (bdd.d_date <= trunc(cancelled_date))) AND
     		((withdrawn_date is null) OR (bdd.d_date <= trunc(withdrawn_date)))
            )
    )
LEFT OUTER JOIN D_APPEAL_PRIORITIES priorities ON a.APPEAL_PRIORITY_ID = priorities.PRIORITY_ID
LEFT OUTER JOIN D_APPEAL_PARTS parts ON a.APPEAL_PART_ID = parts.PART_ID
LEFT OUTER JOIN D_APPEAL_ISSUES issues ON a.APPEAL_ISSUE = issues.ISSUE_ID
LEFT OUTER JOIN D_APPEAL_ITEM_SERVICES items ON a.APPEAL_ITEM = items.ITEM_SERVICE_ID
LEFT OUTER JOIN D_APPEAL_STAGES stages ON a.APPEAL_STAGE = stages.STAGE_ID
LEFT OUTER JOIN D_APPEAL_STATUSES statuses ON a.APPEAL_STATUS = statuses.STATUS_ID
LEFT OUTER JOIN D_APPEAL_TYPES types ON a.APPEAL_TYPE = types.TYPE_ID
LEFT OUTER JOIN D_APPELLANT_DISMISSALS dismissals ON a.APPEAL_DISMISSAL = dismissals.DISMISSAL_ID
LEFT OUTER JOIN D_APPELLANT_DISMISS_REASONS dismissal_reasons ON a.APPEAL_DISMISSAL_REASON = dismissal_reasons.DISMISS_REASON_ID
LEFT OUTER JOIN D_APPEAL_REASONS reasons ON a.APPEAL_REASON = reasons.REASON_ID
LEFT OUTER JOIN D_APPEAL_DECISIONS decisions ON a.DECISION = decisions.DECISION_ID
LEFT OUTER JOIN D_APPEAL_DEC_NOTIF_METHODS dec_notif_methods ON a.DECISION_NOTIFICATION_METHOD = dec_notif_methods.DEC_NOTIF_METHOD_ID
LEFT OUTER JOIN D_APPEAL_HPMSS hpmss ON a.HPMS = hpmss.HPMS_ID
LEFT OUTER JOIN D_APPEAL_MACS macs ON a.MAC = macs.MAC_ID
LEFT OUTER JOIN D_APPEAL_MEDICARE_TYPES medicare_types ON a.MEDICARE_TYPE = medicare_types.MEDICARE_TYPE_ID
LEFT OUTER JOIN D_APPEAL_MSPS msps ON a.MSP = msps.MSP_ID
LEFT OUTER JOIN D_APPEAL_WITHDRAW_REQ_SUBMS withdraw_req_subms ON a.WITHDRAWAL_REQUEST_SUBMITTED = withdraw_req_subms.WITHDRAW_REQ_SUBM_ID
LEFT OUTER JOIN D_APPEAL_NON_ENGLISHES non_englishes ON a.NON_ENGLISH = non_englishes.NON_ENGLISH_ID
LEFT OUTER JOIN D_APPEAL_DISPOSITIONS dispositions ON a.DISPOSITION = dispositions.DISPOSITION_ID
LEFT OUTER JOIN D_APPEAL_DISPOSITION_EXPS disposition_exps ON a.DISPOSITION_EXPLANATION = disposition_exps.DISPOSITION_ExP_ID
LEFT OUTER JOIN D_APPEAL_PROC_DEC_REASONS proc_dec_reasons ON a.PROCEDURAL_DECISION_REASON = proc_dec_reasons.PROC_DEC_REASON_ID
LEFT OUTER JOIN D_APPEAL_SUBSTANTIVE_REASONS sub_reasons ON a.SUBSTANTIVE_REASON = sub_reasons.SUBSTANTIVE_REASON_ID
WITH READ ONLY;


GRANT SELECT ON F_MW_APPEAL_INSTANCE_BY_DATE_SV TO MAXDAT_READ_ONLY;

commit;
