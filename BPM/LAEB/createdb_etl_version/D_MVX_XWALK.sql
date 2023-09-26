CREATE TABLE D_MVX_XWALK(
AID_CATEGORY VARCHAR2(3),
TYPE_CASE VARCHAR2(3),
ACUTE_MVX VARCHAR2(16),
ACUTE_COA VARCHAR2(8),
ACUTE_REGION VARCHAR2(32),
ACUTE_AGE VARCHAR2(128),
ACUTE_LOWER_LIMIT VARCHAR2(8),
ACUTE_UPPER_LIMIT VARCHAR2(8),
ACUTE_RATECELL VARCHAR2(128),
BH_ADULT_MVX VARCHAR2(16),
BH_ADULT_COA VARCHAR2(8),
BH_ADULT_REGION VARCHAR2(32),
BH_ADULT_AGE VARCHAR2(128),
BH_ADULT_RATECELL VARCHAR2(128),
BH_CHILD_MVX VARCHAR2(16),
BH_CHILD_COA VARCHAR2(8),
BH_CHILD_REGION VARCHAR2(32),
BH_CHILD_AGE VARCHAR2(128),
BH_CHILD_RATECELL VARCHAR2(128),
REASON_CODE VARCHAR2(32),
DENTAL_MVX VARCHAR2(16),
DENTAL_COA VARCHAR2(8),
DENTAL_REGION VARCHAR2(32),
DENTAL_AGE VARCHAR2(128),
DENTAL_LOWER_LIMIT VARCHAR2(8),
DENTAL_UPPER_LIMIT VARCHAR2(8),
DENTAL_RATECELL VARCHAR2(128),
DENTAL_REASON_CODE VARCHAR2(32),
CREATED_BY VARCHAR2(80),
CREATE_TS DATE,
UPDATED_BY VARCHAR2(1000),
UPDATE_TS DATE,
ORDER_BY_DEFAULT NUMBER(10,0),
EFFECTIVE_START_DATE DATE,
EFFECTIVE_END_DATE DATE,
NEMT_ADULT_RATECELL VARCHAR2(128),
NEMT_CHILD_RATECELL VARCHAR2(128) ) TABLESPACE &tablespace_name;

CREATE UNIQUE INDEX IDX1_MVX_XWALK ON D_MVX_XWALK(AID_CATEGORY,TYPE_CASE) TABLESPACE &tablespace_name;

GRANT SELECT ON D_MVX_XWALK TO &role_name;

CREATE OR REPLACE VIEW D_MVX_XWALK_SV AS
SELECT aid_category
      ,type_case
      ,acute_mvx
      ,acute_coa
      ,acute_region
      ,acute_age
      ,acute_lower_limit
      ,acute_upper_limit
      ,acute_ratecell
      ,bh_adult_mvx
      ,bh_adult_coa
      ,bh_adult_region
      ,bh_adult_age
      ,bh_adult_ratecell
      ,bh_child_mvx
      ,bh_child_coa
      ,bh_child_region
      ,bh_child_age
      ,bh_child_ratecell
      ,reason_code
      ,dental_mvx
      ,dental_coa
      ,dental_region
      ,dental_age
      ,dental_lower_limit
      ,dental_upper_limit
      ,dental_ratecell
      ,dental_reason_code
      ,created_by
      ,create_ts
      ,updated_by
      ,update_ts
      ,order_by_default
      ,effective_start_date
      ,effective_end_date
      ,nemt_adult_ratecell
      ,nemt_child_ratecell
FROM d_mvx_xwalk ;

GRANT SELECT ON D_MVX_XWALK_SV TO &role_name;
