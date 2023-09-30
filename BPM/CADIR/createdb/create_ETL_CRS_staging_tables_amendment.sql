CREATE TABLE S_CRS_IMR_PRELIMINARY_REVIEW
(
 SCIPR_ID                          NUMBER(19,0) NOT NULL
,PRELIMINARY_REVIEW_ID             NUMBER(19,0) NOT NULL
,IMR_ID				   NUMBER(19,0)
,BASE_ID			   NUMBER(19,0)
,UNTIMELY_FLAG			   VARCHAR2(3)
,DWC_DISPUTE_FLAG		   VARCHAR2(3)
,INFO_ISSUED_FLAG		   VARCHAR2(3)
,LIABILITY_DWC_RESP_FLAG	   VARCHAR2(3)
,SEND_BACK_TO_IMR_FLAG		   VARCHAR2(3)
,DUPLICATE_FLAG			   VARCHAR2(3)
,DISPUTE_FLAG			   VARCHAR2(3)
,INELIGIBLE_LETTER_ID		   NUMBER(10,0)
,DAYS_BETWEEN			   VARCHAR2(255)
,DEADLINE_DATE			   DATE
,INSUFFICIENT_INFORMATION	   CLOB
,PHYS_CERT_DWC_RESP_FLAG	   VARCHAR2(3)
,RECEIVED_DATE			   DATE
,DWC_ASSIGN_AT_TEST_FLAG	   VARCHAR2(3)
,DUPLICATE_CASE_NUMBER	           VARCHAR2(255)
,ROUTE_TO_DWC_FLAG		   VARCHAR2(3)
,EXP_VALIDATE_FLAG		   VARCHAR2(3)
,DOI_VALIDATE_FLAG		   VARCHAR2(3)
,DETAILED_COMMENTS		   CLOB
,LIABILITY_ISSUE_FLAG		   VARCHAR2(3)
,UR_SERVED_DATE			   DATE
,ANY_OTHER_ISSUE		   CLOB
,DOI_DWC_RESPONSE_FLAG		   VARCHAR2(3)
,DWC_ELIG_DETAIL		   CLOB
,PRELIM_DETERM_DATE		   DATE
,INFO_DWC_RESP_FLAG		   VARCHAR2(3)
,PHYS_CERT_FLAG			   VARCHAR2(3)
,ROUTE_TO_EXPERT_REVIEW_FLAG	   VARCHAR2(3)
,UR_PRIORITY_EXP_FLAG		   VARCHAR2(3)
,DWC_UNTIMELY_FLAG		   VARCHAR2(3)
,DWC_DUPLICATE_FLAG		   VARCHAR2(3)
,PRIORITY			   VARCHAR2(255)
,LIABILITY_DESC			   VARCHAR2(255)
,DISPUTE_DETAILS		   VARCHAR2(255)
,DOI_DATE			   DATE
,CREATE_DT                         DATE
,CREATED_BY                        VARCHAR2(100)
,LAST_UPDATE_DT                    DATE
,LAST_UPDATED_BY                   VARCHAR2(100)
);

ALTER TABLE S_CRS_IMR_PRELIMINARY_REVIEW ADD CONSTRAINT S_CRS_IMR_PRELIM_REV_PK PRIMARY KEY
(
  SCIPR_ID
);

CREATE INDEX IMR_ID_FK ON S_CRS_IMR_PRELIMINARY_REVIEW
  (
    IMR_ID ASC
  )
TABLESPACE MAXDAT_INDX LOGGING ;

CREATE INDEX INELIGIBLE_LETTER_ID_FK ON S_CRS_IMR_PRELIMINARY_REVIEW
  (
    INELIGIBLE_LETTER_ID ASC
  )
TABLESPACE MAXDAT_INDX LOGGING ;
