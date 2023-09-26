--Program
INSERT INTO EMRS_D_PROGRAM(PROGRAM_CODE, PROGRAM_NAME,START_DATE,END_DATE, PROGRAM_CATEGORY, ACTIVE_INACTIVE)
VALUES('HCO','Health Care Options',TO_DATE('01/01/1900','mm/dd/yyyy'), TO_DATE('12/31/2050','mm/dd/yyyy'),'HCO','A');

--Sub Program
INSERT INTO EMRS_D_SUB_PROGRAM(SUB_PROGRAM_CODE,SUB_PROGRAM_NAME,PARENT_PROGRAM_NAME,PLAN_SERVICE_TYPE)
VALUES('SPD','Senior Person of Disability','HCO','HCO');

INSERT INTO EMRS_D_SUB_PROGRAM(SUB_PROGRAM_CODE,SUB_PROGRAM_NAME,PARENT_PROGRAM_NAME,PLAN_SERVICE_TYPE)
VALUES('MLTSS','Managed Long Term Services and supports','HCO','HCO');

INSERT INTO EMRS_D_SUB_PROGRAM(SUB_PROGRAM_CODE,SUB_PROGRAM_NAME,PARENT_PROGRAM_NAME,PLAN_SERVICE_TYPE)
VALUES('ESPD','Extended Senior Person of Disability','HCO','HCO');

INSERT INTO EMRS_D_SUB_PROGRAM(SUB_PROGRAM_CODE,SUB_PROGRAM_NAME,PARENT_PROGRAM_NAME,PLAN_SERVICE_TYPE)
VALUES('CCI','Coordinated Care Initiative','HCO','HCO');

INSERT INTO EMRS_D_SUB_PROGRAM(SUB_PROGRAM_CODE,SUB_PROGRAM_NAME,PARENT_PROGRAM_NAME,PLAN_SERVICE_TYPE)
VALUES('HF','Healthy Families','HCO','HCO');

--Selection Reasons
INSERT INTO EMRS_D_SELECTION_REASON(SELECTION_REASON_CODE, SELECTION_REASON)
VALUES('A','Auto Assign');

INSERT INTO EMRS_D_SELECTION_REASON(SELECTION_REASON_CODE, SELECTION_REASON)
VALUES('D','Dual Eligible Transaction');

INSERT INTO EMRS_D_SELECTION_REASON(SELECTION_REASON_CODE, SELECTION_REASON)
VALUES('E','Passive Enrollment/Provider Linkage Default');

INSERT INTO EMRS_D_SELECTION_REASON(SELECTION_REASON_CODE, SELECTION_REASON)
VALUES('N','Generic Transaction');

INSERT INTO EMRS_D_SELECTION_REASON(SELECTION_REASON_CODE, SELECTION_REASON)
VALUES('P','Prior Plan');

INSERT INTO EMRS_D_SELECTION_REASON(SELECTION_REASON_CODE, SELECTION_REASON)
VALUES('R','Regular');

--Selection Statuses
INSERT INTO EMRS_D_SELECTION_STATUS(SELECTION_STATUS_CODE,SELECTION_STATUS_DESCRIPTION,ALLOW_NEW_SELECTION_IND)
VALUES ('disregarded','Disregarded','N');

INSERT INTO EMRS_D_SELECTION_STATUS(SELECTION_STATUS_CODE,SELECTION_STATUS_DESCRIPTION,ALLOW_NEW_SELECTION_IND)
VALUES ('invalid','Invalid','N');

INSERT INTO EMRS_D_SELECTION_STATUS(SELECTION_STATUS_CODE,SELECTION_STATUS_DESCRIPTION,ALLOW_NEW_SELECTION_IND)
VALUES ('acceptedByState','Accepted By State','N');

INSERT INTO EMRS_D_SELECTION_STATUS(SELECTION_STATUS_CODE,SELECTION_STATUS_DESCRIPTION,ALLOW_NEW_SELECTION_IND)
VALUES ('readyToUpload','Ready To Upload','N');

INSERT INTO EMRS_D_SELECTION_STATUS(SELECTION_STATUS_CODE,SELECTION_STATUS_DESCRIPTION,ALLOW_NEW_SELECTION_IND)
VALUES ('uploadedToState','Uploaded To State','N');

INSERT INTO EMRS_D_SELECTION_STATUS(SELECTION_STATUS_CODE,SELECTION_STATUS_DESCRIPTION,ALLOW_NEW_SELECTION_IND)
VALUES ('inResearch','In Research','N');

--Gender
INSERT INTO EMRS_D_GENDER(GENDER_CODE,GENDER)
VALUES ('F','Female');

INSERT INTO EMRS_D_GENDER(GENDER_CODE,GENDER)
VALUES ('M','Male');

INSERT INTO EMRS_D_GENDER(GENDER_CODE,GENDER)
VALUES ('N','Not Applicable');

INSERT INTO EMRS_D_GENDER(GENDER_CODE,GENDER)
VALUES ('U','Unspecified');

-- Unknown Values

INSERT INTO MAXDAT.EMRS_D_AID_CATEGORY
    (
    AID_CATEGORY_ID
    , AID_CATEGORY_CODE
    , AID_CATEGORY_NAME
    , ACTIVE_INACTIVE
    , START_DATE
    , END_DATE
    )
SELECT 
    0
    , 'U'
    , 'Unknown'
    , 'A'
    , to_date('02/17/2009','mm/dd/yyyy')
    , to_date('12/31/2050','mm/dd/yyyy')
FROM EMRS_D_AID_CATEGORY
WHERE AID_CATEGORY_CODE = 'U'
HAVING count(*) = 0;

INSERT INTO MAXDAT.EMRS_D_CHANGE_REASON
    (
    CHANGE_REASON_ID
    , CHANGE_REASON_CODE
    , CHANGE_REASON
    , CHANGE_REASON_CODE_PLAN
    , CHANGE_REASON_TYPE
    )
SELECT    0
    , 'U'
    , 'Unknown'
    , null
    , 'ENROLLMENT'
FROM EMRS_D_CHANGE_REASON
WHERE CHANGE_REASON_CODE = 'U'
HAVING count(*) = 0;
    
INSERT INTO MAXDAT.EMRS_D_EMRGCY_DENR_REASON
    (
    EMRGCY_DENR_REASON_ID
    , EMRGCY_DENR_REASON_CODE
    , EMRGCY_DENR_REASON
    )
SELECT
    0
    , 'U'
    , 'Unknown'
FROM EMRS_D_EMRGCY_DENR_REASON
WHERE EMRGCY_DENR_REASON_CODE = 'U'
HAVING count(*) = 0;
    
INSERT INTO MAXDAT.EMRS_D_EMRGCY_DENR_SOURCE
    (
    EMRGCY_DENR_SOURCE_ID
    , EMRGCY_DENR_SOURCE_CODE
    , EMRGCY_DENR_SOURCE
    )
SELECT
    0
    , 'U'
    , 'Unknown'
FROM EMRS_D_EMRGCY_DENR_SOURCE
WHERE EMRGCY_DENR_SOURCE_CODE = 'U'
HAVING count(*) = 0;

INSERT INTO MAXDAT.EMRS_D_EMRGCY_DENR_STATUS
    (
    EMRGCY_DENR_STATUS_ID
    , EMRGCY_DENR_STATUS_CODE
    , EMRGCY_DENR_STATUS
    , FINAL_STATUS
    , APPROVAL
    , DENIAL
    , PENDING
    )
SELECT
    0
    , 'U'
    , 'Unknown'
    , 'N'
    , 'N'
    , 'N'
    , 'N'
FROM EMRS_D_EMRGCY_DENR_STATUS
WHERE EMRGCY_DENR_STATUS_CODE = 'U'
HAVING count(*) = 0;

INSERT INTO MAXDAT.EMRS_D_ENROLL_TRANS_TYPE
    (
    ENROLLMENT_TRANS_TYPE_ID
    , ENROLLMENT_TRANS_TYPE_CODE
    , ENROLLMENT_TRANS_TYPE
    )
SELECT
    0
    , '0'
    , 'Unknown'
FROM EMRS_D_ENROLL_TRANS_TYPE
WHERE ENROLLMENT_TRANS_TYPE_CODE = '0'
HAVING count(*) = 0;

INSERT INTO MAXDAT.EMRS_D_ENROLLMENT_STATUS
    (
    ENROLLMENT_STATUS_ID
    , ENROLLMENT_STATUS_CODE
    , ENROLLMENT_STATUS_DESC
    , IS_AA_PCE_IND
    , IS_MANDATORY_UNASSIGN_IND
    )
SELECT
    0
    , 'U'
    , 'Unknown'
    , 0
    , 0
FROM EMRS_D_ENROLLMENT_STATUS
WHERE ENROLLMENT_STATUS_CODE = 'U'
HAVING count(*) = 0;

-- EMRS_D_EXEMPTION_REASON has an EXEMPTION_REASON_CODE of 'U' in the table already
INSERT INTO MAXDAT.EMRS_D_EXEMPTION_REASON
    (
    EXEMPTION_REASON_ID
    , EXEMPTION_REASON_CODE
    , EXEMPTION_REASON
    )
SELECT
    0
    , '0'
    , 'Unknown'
FROM EMRS_D_EXEMPTION_REASON
WHERE EXEMPTION_REASON_CODE = '0'
HAVING count(*) = 0;

-- EMRS_D_EXEMPTION_STATUS has an EXEMPTION_STATUS_CODE of '0' and 'U' in the table already
INSERT INTO MAXDAT.EMRS_D_EXEMPTION_STATUS
    (
    EXEMPTION_STATUS_ID
    , EXEMPTION_STATUS_CODE
    , EXEMPTION_STATUS
    , FINAL_STATUS
    , APPROVAL
    , DENIAL
    , PENDING
    )
SELECT
    0
    , 'UK'
    , 'Unknown'
    , 'N'
    , 'N'
    , 'N'
    , 'N'
FROM EMRS_D_EXEMPTION_STATUS
WHERE EXEMPTION_STATUS_CODE = 'UK'
HAVING count(*) = 0;

INSERT INTO MAXDAT.EMRS_D_SELECTION_REASON
    (
    SELECTION_REASON_ID
    , SELECTION_REASON_CODE
    , SELECTION_REASON
    )
SELECT
    0
    , 'U'
    , 'Unknown'
FROM EMRS_D_SELECTION_REASON
WHERE SELECTION_REASON_CODE = 'U'
HAVING count(*) = 0;

INSERT INTO MAXDAT.EMRS_D_SELECTION_SOURCE
    (
    SELECTION_SOURCE_ID
    , SELECTION_SOURCE_CODE
    , SELECTION_SOURCE
    , IS_CHOICE_IND
    )
SELECT
    0
    , 'U'   
    , 'Unknown Source'
    , 'N'
FROM EMRS_D_SELECTION_SOURCE
WHERE SELECTION_SOURCE_CODE = 'U'
HAVING count(*) = 0;

INSERT INTO MAXDAT.EMRS_D_SELECTION_STATUS
    (
    SELECTION_STATUS_ID
    , SELECTION_STATUS_CODE
    , SELECTION_STATUS_DESCRIPTION
    , ALLOW_NEW_SELECTION_IND
    )
SELECT
    0
    ,'U'
    ,'Unknown'
    , 'N'
FROM EMRS_D_SELECTION_STATUS
WHERE SELECTION_STATUS_CODE = 'U'
HAVING count(*) = 0;

INSERT INTO MAXDAT.HCO_D_FORM_STATUS
    (
    FORM_STATUS_CODE
    , FORM_STATUS
    , DP_FORM_STATUS_ID
    )
SELECT
    'U'
    , 'Unknown'
    , 0
FROM HCO_D_FORM_STATUS
WHERE FORM_STATUS_CODE = 'U'
HAVING count(*) = 0;

INSERT INTO MAXDAT.HCO_D_MAIL_STATUS
    (
    MAIL_STATUS_ID
    , MAIL_STATUS_CODE
    , MAIL_STATUS
    , DP_MAIL_STATUS_ID
    )
SELECT
    0
    , 'U'
    , 'Unknown'
    , 0
FROM HCO_D_MAIL_STATUS
WHERE MAIL_STATUS_CODE = 'U'
HAVING count(*) = 0;

INSERT INTO MAXDAT.HCO_D_MAIL_TYPE
    (
    MAIL_TYPE_ID
    , MAIL_TYPE_CODE
    , MAIL_TYPE
    , START_DATE
    , END_DATE
    , IS_PACKET
    , MANDATORY_VOLUNTARY
    , PPD_REQUIRED
    , DP_MAIL_TYPE_ID
    )
SELECT
    0
    , 'U'
    , 'Unknown Mail Type'
    , to_date('06/08/2009','mm/dd/yyyy')
    , to_date('12/31/2050','mm/dd/yyyy')
    , 'N'
    , null
    , 'N'
    , 0
FROM HCO_D_MAIL_TYPE
WHERE MAIL_TYPE_CODE = 'U'
HAVING count(*) = 0;

INSERT INTO MAXDAT.EMRS_D_PROGRAM
    (
    PROGRAM_ID
    , PROGRAM_CODE
    , PROGRAM_NAME
    , START_DATE
    , END_DATE
    , PROGRAM_CATEGORY
    , ACTIVE_INACTIVE
    )
SELECT
    0
    , 'U'
    , 'Unknown Program'
    , to_date('01/01/1900','mm/dd/yyyy')
    , to_date('12/31/2050','mm/dd/yyyy')
   , 'HCO'
    , 'A'
FROM EMRS_D_PROGRAM
WHERE PROGRAM_CODE = 'U'
HAVING count(*) = 0;

INSERT INTO MAXDAT.EMRS_D_SUB_PROGRAM
    (
    SUB_PROGRAM_ID
    , SUB_PROGRAM_NAME
    , SUB_PROGRAM_CODE
    , PARENT_PROGRAM_NAME
    , PLAN_SERVICE_TYPE
    )
SELECT
    0
    , 'Unknown Sub-Program'
    , 'U'
    , 'HCO'
    , 'HCO'
FROM EMRS_D_SUB_PROGRAM
WHERE SUB_PROGRAM_CODE = 'U'
HAVING count(*) = 0;

COMMIT;


INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    0
    , 0
    , 20
    , 0
    , 0
    , '0-20 Years'
    , '0 Years'
    , '0 to 4'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    1
    , 1
    , 20
    , 20
    , 0
    , '0-20 Years'
    , '1-20 Years'
    , '0 to 4'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    2
    , 2
    , 20
    , 20
    , 0
    , '0-20 Years'
    , '1-20 Years'
    , '0 to 4'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    3
    , 3
    , 20
    , 20
    , 0
    , '0-20 Years'
    , '1-20 Years'
    , '0 to 4'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    4
    , 4
    , 20
    , 20
    , 0
    , '0-20 Years'
    , '1-20 Years'
    , '0 to 4'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    5
    , 5
    , 20
    , 20
    , 5
    , '0-20 Years'
    , '1-20 Years'
    , '5 to 9'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    6
    , 6
    , 20
    , 20
    , 5
    , '0-20 Years'
    , '1-20 Years'
    , '5 to 9'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    7
    , 7
    , 20
    , 20
    , 5
    , '0-20 Years'
    , '1-20 Years'
    , '5 to 9'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    8
    , 8
    , 20
    , 20
    , 5
    , '0-20 Years'
    , '1-20 Years'
    , '5 to 9'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    9
    , 9
    , 20
    , 20
    , 5
    , '0-20 Years'
    , '1-20 Years'
    , '5 to 9'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    10
    , 10
    , 20
    , 20
    , 10
    , '0-20 Years'
    , '1-20 Years'
    , '10 to 14'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    11
    , 11
    , 20
    , 20
    , 10
    , '0-20 Years'
    , '1-20 Years'
    , '10 to 14'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    12
    , 12
    , 20
    , 20
    , 10
    , '0-20 Years'
    , '1-20 Years'
    , '10 to 14'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    13
    , 13
    , 20
    , 20
    , 10
    , '0-20 Years'
    , '1-20 Years'
    , '10 to 14'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    14
    , 14
    , 20
    , 20
    , 10
    , '0-20 Years'
    , '1-20 Years'
    , '10 to 14'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    15
    , 15
    , 20
    , 20
    , 15
    , '0-20 Years'
    , '1-20 Years'
    , '15 to 19'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    16
    , 16
    , 20
    , 20
    , 15
    , '0-20 Years'
    , '1-20 Years'
    , '15 to 19'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    17
    , 17
    , 20
    , 20
    , 15
    , '0-20 Years'
    , '1-20 Years'
    , '15 to 19'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    18
    , 18
    , 20
    , 20
    , 15
    , '0-20 Years'
    , '1-20 Years'
    , '15 to 19'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    19
    , 19
    , 20
    , 20
    , 15
    , '0-20 Years'
    , '1-20 Years'
    , '15 to 19'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    20
    , 20
    , 20
    , 20
    , 20
    , '0-20 Years'
    , '1-20 Years'
    , '20 to 24'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    21
    , 21
    , 21
    , 21
    , 20
    , '21 and Over'
    , '21 Or More Years'
    , '20 to 24'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    22
    , 22
    , 21
    , 21
    , 20
    , '21 and Over'
    , '21 Or More Years'
    , '20 to 24'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    23
    , 23
    , 21
    , 21
    , 20
    , '21 and Over'
    , '21 Or More Years'
    , '20 to 24'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    24
    , 24
    , 21
    , 21
    , 20
    , '21 and Over'
    , '21 Or More Years'
    , '20 to 24'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    25
    , 25
    , 21
    , 21
    , 25
    , '21 and Over'
    , '21 Or More Years'
    , '25 to 29'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    26
    , 26
    , 21
    , 21
    , 25
    , '21 and Over'
    , '21 Or More Years'
    , '25 to 29'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    27
    , 27
    , 21
    , 21
    , 25
    , '21 and Over'
    , '21 Or More Years'
    , '25 to 29'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    28
    , 28
    , 21
    , 21
    , 25
    , '21 and Over'
    , '21 Or More Years'
    , '25 to 29'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    29
    , 29
    , 21
    , 21
    , 25
    , '21 and Over'
    , '21 Or More Years'
    , '25 to 29'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    30
    , 30
    , 21
    , 21
    , 30
    , '21 and Over'
    , '21 Or More Years'
    , '30 to 34'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    31
    , 31
    , 21
    , 21
    , 30
    , '21 and Over'
    , '21 Or More Years'
    , '30 to 34'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    32
    , 32
    , 21
    , 21
    , 30
    , '21 and Over'
    , '21 Or More Years'
    , '30 to 34'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    33
    , 33
    , 21
    , 21
    , 30
    , '21 and Over'
    , '21 Or More Years'
    , '30 to 34'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    34
    , 34
    , 21
    , 21
    , 30
    , '21 and Over'
    , '21 Or More Years'
    , '30 to 34'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    35
    , 35
    , 21
    , 21
    , 35
    , '21 and Over'
    , '21 Or More Years'
    , '35 to 39'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    36
    , 36
    , 21
    , 21
    , 35
    , '21 and Over'
    , '21 Or More Years'
    , '35 to 39'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    37
    , 37
    , 21
    , 21
    , 35
    , '21 and Over'
    , '21 Or More Years'
    , '35 to 39'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    38
    , 38
    , 21
    , 21
    , 35
    , '21 and Over'
    , '21 Or More Years'
    , '35 to 39'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    39
    , 39
    , 21
    , 21
    , 35
    , '21 and Over'
    , '21 Or More Years'
    , '35 to 39'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    40
    , 40
    , 21
    , 21
    , 40
    , '21 and Over'
    , '21 Or More Years'
    , '40 to 44'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    41
    , 41
    , 21
    , 21
    , 40
    , '21 and Over'
    , '21 Or More Years'
    , '40 to 44'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    42
    , 42
    , 21
    , 21
    , 40
    , '21 and Over'
    , '21 Or More Years'
    , '40 to 44'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    43
    , 43
    , 21
    , 21
    , 40
    , '21 and Over'
    , '21 Or More Years'
    , '40 to 44'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    44
    , 44
    , 21
    , 21
    , 40
    , '21 and Over'
    , '21 Or More Years'
    , '40 to 44'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    45
    , 45
    , 21
    , 21
    , 45
    , '21 and Over'
    , '21 Or More Years'
    , '45 to 49'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    46
    , 46
    , 21
    , 21
    , 45
    , '21 and Over'
    , '21 Or More Years'
    , '45 to 49'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    47
    , 47
    , 21
    , 21
    , 45
    , '21 and Over'
    , '21 Or More Years'
    , '45 to 49'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    48
    , 48
    , 21
    , 21
    , 45
    , '21 and Over'
    , '21 Or More Years'
    , '45 to 49'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    49
    , 49
    , 21
    , 21
    , 45
    , '21 and Over'
    , '21 Or More Years'
    , '45 to 49'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    50
    , 50
    , 21
    , 21
    , 50
    , '21 and Over'
    , '21 Or More Years'
    , '50 to 54'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    51
    , 51
    , 21
    , 21
    , 50
    , '21 and Over'
    , '21 Or More Years'
    , '50 to 54'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    52
    , 52
    , 21
    , 21
    , 50
    , '21 and Over'
    , '21 Or More Years'
    , '50 to 54'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    53
    , 53
    , 21
    , 21
    , 50
    , '21 and Over'
    , '21 Or More Years'
    , '50 to 54'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    54
    , 54
    , 21
    , 21
    , 50
    , '21 and Over'
    , '21 Or More Years'
    , '50 to 54'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    55
    , 55
    , 21
    , 21
    , 55
    , '21 and Over'
    , '21 Or More Years'
    , '55 to 59'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    56
    , 56
    , 21
    , 21
    , 55
    , '21 and Over'
    , '21 Or More Years'
    , '55 to 59'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    57
    , 57
    , 21
    , 21
    , 55
    , '21 and Over'
    , '21 Or More Years'
    , '55 to 59'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    58
    , 58
    , 21
    , 21
    , 55
    , '21 and Over'
    , '21 Or More Years'
    , '55 to 59'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    59
    , 59
    , 21
    , 21
    , 55
    , '21 and Over'
    , '21 Or More Years'
    , '55 to 59'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    60
    , 60
    , 21
    , 21
    , 60
    , '21 and Over'
    , '21 Or More Years'
    , '60 to 64'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    61
    , 61
    , 21
    , 21
    , 60
    , '21 and Over'
    , '21 Or More Years'
    , '60 to 64'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    62
    , 62
    , 21
    , 21
    , 60
    , '21 and Over'
    , '21 Or More Years'
    , '60 to 64'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    63
    , 63
    , 21
    , 21
    , 60
    , '21 and Over'
    , '21 Or More Years'
    , '60 to 64'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    64
    , 64
    , 21
    , 21
    , 60
    , '21 and Over'
    , '21 Or More Years'
    , '60 to 64'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    65
    , 65
    , 21
    , 21
    , 65
    , '21 and Over'
    , '21 Or More Years'
    , '65 to 69'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    66
    , 66
    , 21
    , 21
    , 65
    , '21 and Over'
    , '21 Or More Years'
    , '65 to 69'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    67
    , 67
    , 21
    , 21
    , 65
    , '21 and Over'
    , '21 Or More Years'
    , '65 to 69'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    68
    , 68
    , 21
    , 21
    , 65
    , '21 and Over'
    , '21 Or More Years'
    , '65 to 69'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    69
    , 69
    , 21
    , 21
    , 65
    , '21 and Over'
    , '21 Or More Years'
    , '65 to 69'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    70
    , 70
    , 21
    , 21
    , 70
    , '21 and Over'
    , '21 Or More Years'
    , '70 to 74'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    71
    , 71
    , 21
    , 21
    , 70
    , '21 and Over'
    , '21 Or More Years'
    , '70 to 74'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    72
    , 72
    , 21
    , 21
    , 70
    , '21 and Over'
    , '21 Or More Years'
    , '70 to 74'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    73
    , 73
    , 21
    , 21
    , 70
    , '21 and Over'
    , '21 Or More Years'
    , '70 to 74'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    74
    , 74
    , 21
    , 21
    , 70
    , '21 and Over'
    , '21 Or More Years'
    , '70 to 74'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    75
    , 75
    , 21
    , 21
    , 75
    , '21 and Over'
    , '21 Or More Years'
    , '75 to 79'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    76
    , 76
    , 21
    , 21
    , 75
    , '21 and Over'
    , '21 Or More Years'
    , '75 to 79'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    77
    , 77
    , 21
    , 21
    , 75
    , '21 and Over'
    , '21 Or More Years'
    , '75 to 79'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    78
    , 78
    , 21
    , 21
    , 75
    , '21 and Over'
    , '21 Or More Years'
    , '75 to 79'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    79
    , 79
    , 21
    , 21
    , 75
    , '21 and Over'
    , '21 Or More Years'
    , '75 to 79'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    80
    , 80
    , 21
    , 21
    , 80
    , '21 and Over'
    , '21 Or More Years'
    , '80 to 84'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    81
    , 81
    , 21
    , 21
    , 80
    , '21 and Over'
    , '21 Or More Years'
    , '80 to 84'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    82
    , 82
    , 21
    , 21
    , 80
    , '21 and Over'
    , '21 Or More Years'
    , '80 to 84'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    83
    , 83
    , 21
    , 21
    , 80
    , '21 and Over'
    , '21 Or More Years'
    , '80 to 84'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    84
    , 84
    , 21
    , 21
    , 80
    , '21 and Over'
    , '21 Or More Years'
    , '80 to 84'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    85
    , 85
    , 21
    , 21
    , 85
    , '21 and Over'
    , '21 Or More Years'
    , '85 to 89'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    86
    , 86
    , 21
    , 21
    , 85
    , '21 and Over'
    , '21 Or More Years'
    , '85 to 89'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    87
    , 87
    , 21
    , 21
    , 85
    , '21 and Over'
    , '21 Or More Years'
    , '85 to 89'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    88
    , 88
    , 21
    , 21
    , 85
    , '21 and Over'
    , '21 Or More Years'
    , '85 to 89'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    89
    , 89
    , 21
    , 21
    , 85
    , '21 and Over'
    , '21 Or More Years'
    , '85 to 89'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    90
    , 90
    , 21
    , 21
    , 90
    , '21 and Over'
    , '21 Or More Years'
    , '90 to 94'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    91
    , 91
    , 21
    , 21
    , 90
    , '21 and Over'
    , '21 Or More Years'
    , '90 to 94'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    92
    , 92
    , 21
    , 21
    , 90
    , '21 and Over'
    , '21 Or More Years'
    , '90 to 94'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    93
    , 93
    , 21
    , 21
    , 90
    , '21 and Over'
    , '21 Or More Years'
    , '90 to 94'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    94
    , 94
    , 21
    , 21
    , 90
    , '21 and Over'
    , '21 Or More Years'
    , '90 to 94'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    95
    , 95
    , 21
    , 21
    , 95
    , '21 and Over'
    , '21 Or More Years'
    , '95 to 99'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    96
    , 96
    , 21
    , 21
    , 95
    , '21 and Over'
    , '21 Or More Years'
    , '95 to 99'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    97
    , 97
    , 21
    , 21
    , 95
    , '21 and Over'
    , '21 Or More Years'
    , '95 to 99'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    98
    , 98
    , 21
    , 21
    , 95
    , '21 and Over'
    , '21 Or More Years'
    , '95 to 99'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    99
    , 99
    , 21
    , 21
    , 95
    , '21 and Over'
    , '21 Or More Years'
    , '95 to 99'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    100
    , 100
    , 21
    , 21
    , 100
    , '21 and Over'
    , '21 Or More Years'
    , '100 to 104'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    101
    , 101
    , 21
    , 21
    , 100
    , '21 and Over'
    , '21 Or More Years'
    , '100 to 104'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    102
    , 102
    , 21
    , 21
    , 100
    , '21 and Over'
    , '21 Or More Years'
    , '100 to 104'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    103
    , 103
    , 21
    , 21
    , 100
    , '21 and Over'
    , '21 Or More Years'
    , '100 to 104'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    104
    , 104
    , 21
    , 21
    , 100
    , '21 and Over'
    , '21 Or More Years'
    , '100 to 104'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    105
    , 105
    , 21
    , 21
    , 105
    , '21 and Over'
    , '21 Or More Years'
    , '105 to 109'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    106
    , 106
    , 21
    , 21
    , 105
    , '21 and Over'
    , '21 Or More Years'
    , '105 to 109'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    107
    , 107
    , 21
    , 21
    , 105
    , '21 and Over'
    , '21 Or More Years'
    , '105 to 109'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    108
    , 108
    , 21
    , 21
    , 105
    , '21 and Over'
    , '21 Or More Years'
    , '105 to 109'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    109
    , 109
    , 21
    , 21
    , 105
    , '21 and Over'
    , '21 Or More Years'
    , '105 to 109'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    110
    , 110
    , 21
    , 21
    , 110
    , '21 and Over'
    , '21 Or More Years'
    , '110 to 114'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    111
    , 111
    , 21
    , 21
    , 110
    , '21 and Over'
    , '21 Or More Years'
    , '110 to 114'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    112
    , 112
    , 21
    , 21
    , 110
    , '21 and Over'
    , '21 Or More Years'
    , '110 to 114'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    113
    , 113
    , 21
    , 21
    , 110
    , '21 and Over'
    , '21 Or More Years'
    , '110 to 114'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    114
    , 114
    , 21
    , 21
    , 110
    , '21 and Over'
    , '21 Or More Years'
    , '110 to 114'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    115
    , 115
    , 21
    , 21
    , 115
    , '21 and Over'
    , '21 Or More Years'
    , '115 to 119'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    116
    , 116
    , 21
    , 21
    , 115
    , '21 and Over'
    , '21 Or More Years'
    , '115 to 119'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    117
    , 117
    , 21
    , 21
    , 115
    , '21 and Over'
    , '21 Or More Years'
    , '115 to 119'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    118
    , 118
    , 21
    , 21
    , 115
    , '21 and Over'
    , '21 Or More Years'
    , '115 to 119'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    119
    , 119
    , 21
    , 21
    , 115
    , '21 and Over'
    , '21 Or More Years'
    , '115 to 119'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    120
    , 120
    , 21
    , 21
    , 120
    , '21 and Over'
    , '21 Or More Years'
    , '120 to 124'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    121
    , 121
    , 21
    , 21
    , 120
    , '21 and Over'
    , '21 Or More Years'
    , '120 to 124'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    122
    , 122
    , 21
    , 21
    , 120
    , '21 and Over'
    , '21 Or More Years'
    , '120 to 124'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    123
    , 123
    , 21
    , 21
    , 120
    , '21 and Over'
    , '21 Or More Years'
    , '120 to 124'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    124
    , 124
    , 21
    , 21
    , 120
    , '21 and Over'
    , '21 Or More Years'
    , '120 to 124'
    );

INSERT INTO MAXDAT.EMRS_D_CLIENT_AGEGROUP
    (
    AGEGROUP_ID
    , AGEGROUP_YEAR
    , AGEGROUP
    , AGEGROUP0
    , AGEGROUP5
    , AGEGROUP_DESC
    , AGEGROUP0_DESC
    , AGEGROUP5_DESC
    )
VALUES
    (
    125
    , 125
    , 21
    , 21
    , 125
    , '21 and Over'
    , '21 Or More Years'
    , 'Older than 124'
    );



COMMIT;
   