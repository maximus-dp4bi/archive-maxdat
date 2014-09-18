prompt Creating table 'EMRS_D_PROVIDER_TYPES'
create table EMRS_D_PROVIDER_TYPES
 (PROVIDER_TYPE_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(50) not null
 ,PROVIDER_NAME varchar2(65) not null
 ,PROVIDER_CODE varchar2(3) not null
 ,VALID varchar2(1)
 ,INVALID varchar2(1)
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_PROVIDER_TYPES.PROVIDER_TYPE_ID is 'Provider Type ID (PK)';
comment on column EMRS_D_PROVIDER_TYPES.MANAGED_CARE_PROGRAM is 'Managed Care Program that Uses This CSDA';
comment on column EMRS_D_PROVIDER_TYPES.PROVIDER_NAME is 'Provider Name';
comment on column EMRS_D_PROVIDER_TYPES.PROVIDER_CODE is 'Provider Code';
comment on column EMRS_D_PROVIDER_TYPES.VALID is 'Provider is Valid';
comment on column EMRS_D_PROVIDER_TYPES.INVALID is 'Provider is Invalid';
comment on column EMRS_D_PROVIDER_TYPES.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_PROVIDER_TYPES.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_PROVIDER_TYPES.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_PROVIDER_TYPES.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_PROVIDER_TYPES.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_PROVIDER_TYPES.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_PROVIDER_TYPES.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_TERMINATION_REASONS'
create table EMRS_D_TERMINATION_REASONS
 (TERM_REASON_CODE_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(30) not null
 ,PLAN_NAME varchar2(25) not null
 ,REASON_CODE varchar2(5) not null
 ,REASON varchar2(200) not null
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_TERMINATION_REASONS.TERM_REASON_CODE_ID is 'Term Reason Code ID (PK)';
comment on column EMRS_D_TERMINATION_REASONS.MANAGED_CARE_PROGRAM is 'Managed Care Program';
comment on column EMRS_D_TERMINATION_REASONS.PLAN_NAME is 'Plan Type Name (that Reason belongs to)';
comment on column EMRS_D_TERMINATION_REASONS.REASON_CODE is 'Reason Code';
comment on column EMRS_D_TERMINATION_REASONS.REASON is 'Term Reason';
comment on column EMRS_D_TERMINATION_REASONS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_TERMINATION_REASONS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_TERMINATION_REASONS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_TERMINATION_REASONS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_TERMINATION_REASONS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_TERMINATION_REASONS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_TERMINATION_REASONS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_STATUS_IN_GROUPS'
create table EMRS_D_STATUS_IN_GROUPS
 (STATUS_IN_GROUP_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(30) not null
 ,STATUS_IN_GROUP_CATEGORY varchar2(50) not null
 ,STATUS_IN_GROUP_CODE number(2,0) not null
 ,STATUS_IN_GROUP varchar2(300) not null
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_STATUS_IN_GROUPS.STATUS_IN_GROUP_ID is 'Status in Group ID (PK)';
comment on column EMRS_D_STATUS_IN_GROUPS.MANAGED_CARE_PROGRAM is 'Managed Care Program';
comment on column EMRS_D_STATUS_IN_GROUPS.STATUS_IN_GROUP_CATEGORY is 'Status in Group Category';
comment on column EMRS_D_STATUS_IN_GROUPS.STATUS_IN_GROUP_CODE is 'Status in Group Code';
comment on column EMRS_D_STATUS_IN_GROUPS.STATUS_IN_GROUP is 'Status in Group';
comment on column EMRS_D_STATUS_IN_GROUPS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_STATUS_IN_GROUPS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_STATUS_IN_GROUPS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_STATUS_IN_GROUPS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_STATUS_IN_GROUPS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_STATUS_IN_GROUPS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_STATUS_IN_GROUPS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_STAFF_PEOPLE'
create table EMRS_D_STAFF_PEOPLE
 (STAFF_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(30) not null
 ,GENDER varchar2(1)
 ,FIRST_NAME varchar2(25)
 ,MIDDLE_INITIAL varchar2(1)
 ,LAST_NAME varchar2(25)
 ,LOGIN_ID varchar2(35)
 ,LOGIN_GROUP varchar2(8)
 ,DEPT_NAME varchar2(8)
 ,ROLE varchar2(20)
 ,START_DATE date
 ,USER_TYPE varchar2(4)
 ,END_DATE date
 ,MANAGER_STAFF_ID number(30)
 ,PHONE number(11)
 ,SOURCE_RECORD_ID integer
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_STAFF_PEOPLE.STAFF_ID is 'Staff ID (PK)';
comment on column EMRS_D_STAFF_PEOPLE.MANAGED_CARE_PROGRAM is 'Managed Care Program that Uses this Program';
comment on column EMRS_D_STAFF_PEOPLE.GENDER is 'Gender';
comment on column EMRS_D_STAFF_PEOPLE.FIRST_NAME is 'Staff''s Login First Name';
comment on column EMRS_D_STAFF_PEOPLE.MIDDLE_INITIAL is 'Staff''s Login Middle Initial';
comment on column EMRS_D_STAFF_PEOPLE.LAST_NAME is 'Staff''s Login Last Name';
comment on column EMRS_D_STAFF_PEOPLE.LOGIN_ID is 'Staff''s Login ID';
comment on column EMRS_D_STAFF_PEOPLE.LOGIN_GROUP is 'Staff''s Login Group';
comment on column EMRS_D_STAFF_PEOPLE.DEPT_NAME is 'Staff''s Department;Unit Name or Number';
comment on column EMRS_D_STAFF_PEOPLE.ROLE is 'Staff Role';
comment on column EMRS_D_STAFF_PEOPLE.START_DATE is 'Staff Person''s Start Date';
comment on column EMRS_D_STAFF_PEOPLE.USER_TYPE is 'System User Type';
comment on column EMRS_D_STAFF_PEOPLE.END_DATE is 'Staff Person''s End Date';
comment on column EMRS_D_STAFF_PEOPLE.MANAGER_STAFF_ID is 'Staff''s Manager''s ID';
comment on column EMRS_D_STAFF_PEOPLE.PHONE is 'Staff''s Phone Number';
comment on column EMRS_D_STAFF_PEOPLE.SOURCE_RECORD_ID is 'Source-System Primary-Key Record ID #';
comment on column EMRS_D_STAFF_PEOPLE.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_STAFF_PEOPLE.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_STAFF_PEOPLE.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_STAFF_PEOPLE.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_STAFF_PEOPLE.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_STAFF_PEOPLE.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_STAFF_PEOPLE.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_LANGUAGES'
create table EMRS_D_LANGUAGES
 (LANGUAGE_CODE_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(30) not null
 ,LANGUAGE_CODE varchar2(5) not null
 ,LANGUAGE varchar2(20) not null
 ,BUSINESS_START_DATE date
 ,BUSINESS_END_DATE date
 ,SOURCE_RECORD_ID varchar2(30)
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_LANGUAGES.LANGUAGE_CODE_ID is 'Language Code ID (PK)';
comment on column EMRS_D_LANGUAGES.MANAGED_CARE_PROGRAM is 'Managed Care Program';
comment on column EMRS_D_LANGUAGES.LANGUAGE_CODE is 'Language Code';
comment on column EMRS_D_LANGUAGES.LANGUAGE is 'Language';
comment on column EMRS_D_LANGUAGES.BUSINESS_START_DATE is 'Business Start Date (Business begins using this Language)';
comment on column EMRS_D_LANGUAGES.BUSINESS_END_DATE is 'Business End Date (Business stops using this Language)';
comment on column EMRS_D_LANGUAGES.SOURCE_RECORD_ID is 'Source-System Primary-Key Record ID #';
comment on column EMRS_D_LANGUAGES.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_LANGUAGES.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_LANGUAGES.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_LANGUAGES.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_LANGUAGES.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_LANGUAGES.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_LANGUAGES.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_COUNTIES'
create table EMRS_D_COUNTIES
 (COUNTY_ID integer not null
 ,STATE varchar2(17) not null
 ,COUNTY_CODE varchar2(3)
 ,COUNTY_FIPS_CODE varchar2(3)
 ,COUNTY_NAME varchar2(20)
 ,MODIFIED_DATE date
 ,MODIFIED_TIME varchar2(5)
 ,MODIFIED_NAME varchar2(6)
 ,VOL varchar2(1)
 ,STATUS varchar2(1)
 ,CSDAID varchar2(2)
 ,STAR varchar2(1)
 ,STARPLUS varchar2(2)
 ,PUBLIC_HEALTH_CODE number(2)
 ,SH_REGION varchar2(2)
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_COUNTIES.COUNTY_ID is 'County ID (PK)';
comment on column EMRS_D_COUNTIES.STATE is 'State Name';
comment on column EMRS_D_COUNTIES.COUNTY_CODE is 'State County Number';
comment on column EMRS_D_COUNTIES.COUNTY_FIPS_CODE is 'County FIPS Number';
comment on column EMRS_D_COUNTIES.COUNTY_NAME is 'County Name';
comment on column EMRS_D_COUNTIES.MODIFIED_DATE is 'Record Modification Date';
comment on column EMRS_D_COUNTIES.MODIFIED_TIME is 'Record Modification Time';
comment on column EMRS_D_COUNTIES.MODIFIED_NAME is 'Record Modified By - Last Name';
comment on column EMRS_D_COUNTIES.VOL is 'Voluntary;Mandatory;No MC';
comment on column EMRS_D_COUNTIES.STATUS is 'Implementation Status';
comment on column EMRS_D_COUNTIES.CSDAID is 'STAR CSDA ID';
comment on column EMRS_D_COUNTIES.STAR is 'STAR County (Y;N)';
comment on column EMRS_D_COUNTIES.STARPLUS is 'STAR+PLUS County (Y;N)';
comment on column EMRS_D_COUNTIES.PUBLIC_HEALTH_CODE is 'Public Health Region Code';
comment on column EMRS_D_COUNTIES.SH_REGION is 'Star Health Region Code';
comment on column EMRS_D_COUNTIES.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_COUNTIES.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_COUNTIES.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_COUNTIES.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_COUNTIES.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_COUNTIES.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_COUNTIES.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_DATE_PERIODS'
create table EMRS_D_DATE_PERIODS
 (DATE_PERIOD_ID number not null
 ,DATE_FULL varchar2(18)
 ,DATE_STANDARD_1 varchar2(11)
 ,DATE_STANDARD_2 varchar2(10)
 ,DATE_STANDARD_3 number(8,0)
 ,DATE_STANDARD_4 date
 ,DAY_OF_WEEK varchar2(9)
 ,MONTH_NAME varchar2(9)
 ,SEASON varchar2(6)
 ,QUARTER varchar2(20)
 ,LAST_DAY_IN_MONTH_IND varchar2(1)
 ,LAST_DAY_IN_WEEK_IND varchar2(1)
 ,HOLIDAY_IND varchar2(35)
 ,WEEKDAY_IND varchar2(8)
 ,MAJOR_EVENT varchar2(80)
 ,WEEK_ENDING_DATE date
 ,DAY_NUMBER_IN_MONTH varchar2(4)
 ,DAY_NUMBER_IN_WEEK varchar2(1)
 ,DAY_NUMBER_IN_YEAR varchar2(5)
 ,FISCAL_HALF_YEAR varchar2(15)
 ,FISCAL_MONTH_NUM_IN_YEAR number(2,0)
 ,FISCAL_QUARTER varchar2(18)
 ,FISCAL_WEEK number(2,0)
 ,FISCAL_YEAR varchar2(4)
 ,FISCAL_YEAR_DAY_NUMBER number(3,0)
 ,FISCAL_YEAR_MONTH varchar2(8)
 ,FISCAL_YEAR_QUARTER varchar2(13)
 ,MONTH_NUMBER_IN_YEAR number(2,0)
 ,WEEK_NUMBER_IN_YEAR number(2,0)
 ,YEAR_YYYY varchar2(4)
 ,YEAR_HALF varchar2(8)
 ,YEAR_MONTH varchar2(7)
 ,YEAR_QUARTER varchar2(13)
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18)
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_DATE_PERIODS.DATE_PERIOD_ID is 'Date Period ID (PK)';
comment on column EMRS_D_DATE_PERIODS.DATE_FULL is 'Full Date Format (December 30, 2035)';
comment on column EMRS_D_DATE_PERIODS.DATE_STANDARD_1 is '1st Standard Date Format (31-Dec-2035)';
comment on column EMRS_D_DATE_PERIODS.DATE_STANDARD_2 is '2nd Standard Date Format (12;31;2035)';
comment on column EMRS_D_DATE_PERIODS.DATE_STANDARD_3 is '3nd Standard Date Format (20351231)';
comment on column EMRS_D_DATE_PERIODS.DATE_STANDARD_4 is '4nd Standard Date Format (31-DEC-2035)';
comment on column EMRS_D_DATE_PERIODS.DAY_OF_WEEK is 'Day of Week (Monday)';
comment on column EMRS_D_DATE_PERIODS.MONTH_NAME is 'Month Name (December)';
comment on column EMRS_D_DATE_PERIODS.SEASON is 'Season of the Year (Winter)';
comment on column EMRS_D_DATE_PERIODS.QUARTER is 'Calendar Year Quarter (Calendar 4th Quarter)';
comment on column EMRS_D_DATE_PERIODS.LAST_DAY_IN_MONTH_IND is 'Last Day in Month Indicator (Y;N)';
comment on column EMRS_D_DATE_PERIODS.LAST_DAY_IN_WEEK_IND is 'Last Day in Week Indicator (Y;N)';
comment on column EMRS_D_DATE_PERIODS.HOLIDAY_IND is 'Updatable Field';
comment on column EMRS_D_DATE_PERIODS.WEEKDAY_IND is 'Weekday Indicator (Week-Day;Week-End)';
comment on column EMRS_D_DATE_PERIODS.MAJOR_EVENT is 'Updatable Field';
comment on column EMRS_D_DATE_PERIODS.WEEK_ENDING_DATE is 'Week Ending Date (05-JAN-2036)';
comment on column EMRS_D_DATE_PERIODS.DAY_NUMBER_IN_MONTH is 'Day Number in Month (31)';
comment on column EMRS_D_DATE_PERIODS.DAY_NUMBER_IN_WEEK is 'Day Number in Week (2)';
comment on column EMRS_D_DATE_PERIODS.DAY_NUMBER_IN_YEAR is 'Day Number in Year (365)';
comment on column EMRS_D_DATE_PERIODS.FISCAL_HALF_YEAR is 'Fiscal Half-Year (Fiscal 1st-Half)';
comment on column EMRS_D_DATE_PERIODS.FISCAL_MONTH_NUM_IN_YEAR is 'Fiscal Month Number in Year (4)';
comment on column EMRS_D_DATE_PERIODS.FISCAL_QUARTER is 'Fiscal Quarter (Fiscal 2nd Quarter)';
comment on column EMRS_D_DATE_PERIODS.FISCAL_WEEK is 'Fiscal Week (18)';
comment on column EMRS_D_DATE_PERIODS.FISCAL_YEAR is 'Fiscal Year (2036)';
comment on column EMRS_D_DATE_PERIODS.FISCAL_YEAR_DAY_NUMBER is 'Fiscal Year Day Number (122)';
comment on column EMRS_D_DATE_PERIODS.FISCAL_YEAR_MONTH is 'Fiscal Year Month (F2036-4)';
comment on column EMRS_D_DATE_PERIODS.FISCAL_YEAR_QUARTER is 'Fiscal Year Quarter (F2036-2nd Qtr)';
comment on column EMRS_D_DATE_PERIODS.MONTH_NUMBER_IN_YEAR is 'Month Number in Year (12)';
comment on column EMRS_D_DATE_PERIODS.WEEK_NUMBER_IN_YEAR is 'Week Number in Year (12)';
comment on column EMRS_D_DATE_PERIODS.YEAR_YYYY is 'Year (2035)';
comment on column EMRS_D_DATE_PERIODS.YEAR_HALF is 'Year Half (2nd Half)';
comment on column EMRS_D_DATE_PERIODS.YEAR_MONTH is 'Year Month (2035-12)';
comment on column EMRS_D_DATE_PERIODS.YEAR_QUARTER is 'Year Quarter (2035-4th Qtr)';
comment on column EMRS_D_DATE_PERIODS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_DATE_PERIODS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_DATE_PERIODS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_DATE_PERIODS.CREATED_BY is 'Created By';
comment on column EMRS_D_DATE_PERIODS.DATE_CREATED is 'Date Created';
comment on column EMRS_D_DATE_PERIODS.UPDATED_BY is 'Updated By';
comment on column EMRS_D_DATE_PERIODS.DATE_UPDATED is 'Date Updated';

prompt Creating table 'EMRS_D_PLANS'
create table EMRS_D_PLANS
 (PLAN_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(50) not null
 ,CSDA varchar2(2)
 ,PLAN_CODE varchar2(3) not null
 ,PLAN_NAME varchar2(45) not null
 ,PLAN_TYPE varchar2(2)
 ,PLAN_ABBREVIATION varchar2(20)
 ,PLAN_EFFECTIVE_DATE date
 ,ADDRESS1 varchar2(25)
 ,ADDRESS2 varchar2(25)
 ,CITY varchar2(18)
 ,STATE varchar2(2)
 ,ZIP number(5)
 ,ACTIVE varchar2(1)
 ,CONTACT_FIRST_NAME varchar2(10)
 ,CONTACT_INITIAL varchar2(1)
 ,CONTACT_LAST_NAME varchar2(15)
 ,CONTACT_FULL_NAME varchar2(25)
 ,CONTACT_PHONE number(10)
 ,CONTACT_EXTENSION varchar2(6)
 ,MEMBER_CONTACT_PHONE number(10)
 ,ENROLLOK varchar2(1)
 ,PLAN_ASSIGN varchar2(1)
 ,RECORD_DATE date
 ,RECORD_TIME varchar2(5)
 ,RECORD_NAME varchar2(6)
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_PLANS.PLAN_ID is 'Plan (PK)';
comment on column EMRS_D_PLANS.MANAGED_CARE_PROGRAM is 'Managed Care Program that Uses this Plan';
comment on column EMRS_D_PLANS.CSDA is 'Plan Service Delivery Area';
comment on column EMRS_D_PLANS.PLAN_CODE is 'Plan Code';
comment on column EMRS_D_PLANS.PLAN_NAME is 'Plan Name';
comment on column EMRS_D_PLANS.PLAN_TYPE is 'Type Plan Indicator';
comment on column EMRS_D_PLANS.PLAN_ABBREVIATION is 'Plan Name Abbreviation';
comment on column EMRS_D_PLANS.PLAN_EFFECTIVE_DATE is 'Plan Effective Date';
comment on column EMRS_D_PLANS.ADDRESS1 is 'Plan Address1';
comment on column EMRS_D_PLANS.ADDRESS2 is 'Plan Address2';
comment on column EMRS_D_PLANS.CITY is 'Plan City';
comment on column EMRS_D_PLANS.STATE is 'Plan State';
comment on column EMRS_D_PLANS.ZIP is 'Plan Zip Code';
comment on column EMRS_D_PLANS.ACTIVE is 'Plan Activated';
comment on column EMRS_D_PLANS.CONTACT_FIRST_NAME is 'MAXIMUS Contact First Name';
comment on column EMRS_D_PLANS.CONTACT_INITIAL is 'MAXIMUS Contact Middle Initial';
comment on column EMRS_D_PLANS.CONTACT_LAST_NAME is 'MAXIMUS Contact Last Name';
comment on column EMRS_D_PLANS.CONTACT_FULL_NAME is 'MAXIMUS Contact First, Last Name';
comment on column EMRS_D_PLANS.CONTACT_PHONE is 'MAXIMUS Contact Phone Number';
comment on column EMRS_D_PLANS.CONTACT_EXTENSION is 'MAXIMUS Contact Phone Extension';
comment on column EMRS_D_PLANS.MEMBER_CONTACT_PHONE is 'Member Contact Phone Number';
comment on column EMRS_D_PLANS.ENROLLOK is 'OK To Enroll';
comment on column EMRS_D_PLANS.PLAN_ASSIGN is 'Use In Assignment (Y;N)';
comment on column EMRS_D_PLANS.RECORD_DATE is 'Record Creation Date';
comment on column EMRS_D_PLANS.RECORD_TIME is 'Record Creation Time';
comment on column EMRS_D_PLANS.RECORD_NAME is 'Record Created By';
comment on column EMRS_D_PLANS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_PLANS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_PLANS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_PLANS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_PLANS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_PLANS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_PLANS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_CLIENTS'
create table EMRS_D_CLIENTS
 (CLIENT_ID integer not null
 ,CLIENT_NUMBER number(11,0)
 ,MANAGED_CARE_PROGRAM varchar2(50) not null
 ,FULL_NAME varchar2(26)
 ,FIRST_NAME varchar2(17)
 ,MIDDLE_INITIAL varchar2(1)
 ,LAST_NAME varchar2(17)
 ,COVERAGE_TYPE varchar2(2)
 ,ENROLLMENT_STATUS varchar2(1)
 ,TRANSACTION_HOLD varchar2(1)
 ,MANAGED_CARE_CANDIDATE varchar2(1)
 ,BASE_PLAN number(2,0)
 ,RACE varchar2(30)
 ,SEX varchar2(1)
 ,DATE_OF_BIRTH date
 ,PHONE number(10)
 ,SOCIAL_SECURITY_NUMBER varchar2(11)
 ,ADD1 varchar2(22)
 ,ADD2 varchar2(22)
 ,CITY varchar2(20)
 ,ST varchar2(2)
 ,ZIP varchar2(5)
 ,COUNTY number(3)
 ,SSN_RAILROAD_CLAIM_NUMBER varchar2(12)
 ,RECORD_DATE date
 ,RECORD_TIME varchar2(5)
 ,RECORD_NAME varchar2(6)
 ,MODIFIED_DATE date
 ,MODIFIED_TIME varchar2(5)
 ,MODIFIED_NAME varchar2(6)
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,DATE_CREATED date
 ,CREATED_BY varchar2(18) not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel
;

comment on column EMRS_D_CLIENTS.CLIENT_ID is 'Client ID (PK)';
comment on column EMRS_D_CLIENTS.CLIENT_NUMBER is 'Client Number';
comment on column EMRS_D_CLIENTS.MANAGED_CARE_PROGRAM is 'Managed Care Program of This Client';
comment on column EMRS_D_CLIENTS.FULL_NAME is 'Full Name';
comment on column EMRS_D_CLIENTS.FIRST_NAME is 'First Name';
comment on column EMRS_D_CLIENTS.MIDDLE_INITIAL is 'Middle Initial';
comment on column EMRS_D_CLIENTS.LAST_NAME is 'Last Name';
comment on column EMRS_D_CLIENTS.COVERAGE_TYPE is 'Coverage Type';
comment on column EMRS_D_CLIENTS.ENROLLMENT_STATUS is 'Enrollment Status';
comment on column EMRS_D_CLIENTS.TRANSACTION_HOLD is 'Transaction Hold (Y;N)';
comment on column EMRS_D_CLIENTS.MANAGED_CARE_CANDIDATE is 'Managed Care Candidate (Y;N)';
comment on column EMRS_D_CLIENTS.BASE_PLAN is 'Base Plan';
comment on column EMRS_D_CLIENTS.RACE is 'Race of Client';
comment on column EMRS_D_CLIENTS.SEX is 'Sex;Gender of Client';
comment on column EMRS_D_CLIENTS.DATE_OF_BIRTH is 'Date of Birth';
comment on column EMRS_D_CLIENTS.PHONE is 'Phone Number';
comment on column EMRS_D_CLIENTS.SOCIAL_SECURITY_NUMBER is 'Social Security Number';
comment on column EMRS_D_CLIENTS.ADD1 is 'Address 1';
comment on column EMRS_D_CLIENTS.ADD2 is 'Address 2';
comment on column EMRS_D_CLIENTS.CITY is 'City';
comment on column EMRS_D_CLIENTS.ST is 'State';
comment on column EMRS_D_CLIENTS.ZIP is 'Zip Code';
comment on column EMRS_D_CLIENTS.COUNTY is 'County';
comment on column EMRS_D_CLIENTS.SSN_RAILROAD_CLAIM_NUMBER is 'SS;Railroad Claim Number';
comment on column EMRS_D_CLIENTS.RECORD_DATE is 'Record Creation Date';
comment on column EMRS_D_CLIENTS.RECORD_TIME is 'Record Creation Time';
comment on column EMRS_D_CLIENTS.RECORD_NAME is 'Record Creation Name';
comment on column EMRS_D_CLIENTS.MODIFIED_DATE is 'Record Modification Date';
comment on column EMRS_D_CLIENTS.MODIFIED_TIME is 'Record Modification Time';
comment on column EMRS_D_CLIENTS.MODIFIED_NAME is 'Record Modification Name';
comment on column EMRS_D_CLIENTS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_CLIENTS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_CLIENTS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_CLIENTS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_CLIENTS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_CLIENTS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_CLIENTS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_TARGET_GROUP_TYPES'
create table EMRS_D_TARGET_GROUP_TYPES
 (TARGET_GROUP_TYPE_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(50) not null
 ,TARGET_GROUP_TYPE_CATEGORY varchar2(10)
 ,TARGET_GROUP_TYPE_NAME varchar2(100)
 ,TARGET_GROUP_TYPE_CODE varchar2(7)
 ,START_DATE date
 ,END_DATE date
 ,SOURCE_RECORD_ID number
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_TARGET_GROUP_TYPES.TARGET_GROUP_TYPE_ID is 'Outreach Target Group Type ID (PK)';
comment on column EMRS_D_TARGET_GROUP_TYPES.MANAGED_CARE_PROGRAM is 'Managed Care Program that Uses this Target Group Type';
comment on column EMRS_D_TARGET_GROUP_TYPES.TARGET_GROUP_TYPE_CATEGORY is 'Outreach Target Group Type Category';
comment on column EMRS_D_TARGET_GROUP_TYPES.TARGET_GROUP_TYPE_NAME is 'Outreach Target Group Type Name';
comment on column EMRS_D_TARGET_GROUP_TYPES.TARGET_GROUP_TYPE_CODE is 'OutreachTarget Group Type Code';
comment on column EMRS_D_TARGET_GROUP_TYPES.START_DATE is 'Outreach Target Group Type Start Date';
comment on column EMRS_D_TARGET_GROUP_TYPES.END_DATE is 'Outreach Target Group Type End Date';
comment on column EMRS_D_TARGET_GROUP_TYPES.SOURCE_RECORD_ID is 'Source-System Primary-Key Record ID #';
comment on column EMRS_D_TARGET_GROUP_TYPES.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_TARGET_GROUP_TYPES.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_TARGET_GROUP_TYPES.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_TARGET_GROUP_TYPES.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_TARGET_GROUP_TYPES.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_TARGET_GROUP_TYPES.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_TARGET_GROUP_TYPES.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_BUSINESS_CHANNELS'
create table EMRS_D_BUSINESS_CHANNELS
 (CHANNEL_ID integer not null
 ,CHANNEL_CODE number(3,0)
 ,CHANNEL_DESCRIPTION varchar2(50)
 ,DATE_CREATED date not null
 ,CREATED_BY varchar2(18) not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_BUSINESS_CHANNELS.CHANNEL_ID is 'Busines Channel ID (PK)';
comment on column EMRS_D_BUSINESS_CHANNELS.CHANNEL_CODE is 'Busines Channel Code';
comment on column EMRS_D_BUSINESS_CHANNELS.CHANNEL_DESCRIPTION is 'Busines Channel Description';
comment on column EMRS_D_BUSINESS_CHANNELS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_BUSINESS_CHANNELS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_BUSINESS_CHANNELS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_BUSINESS_CHANNELS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_FEDERAL_POVERTY_LEVELS'
create table EMRS_D_FEDERAL_POVERTY_LEVELS
 (FPL_ID integer not null
 ,FPL_YEAR date
 ,FPL_LOCALE varchar2(100)
 ,FPL_NUMBER_IN_FAMILY number(3,0)
 ,FPL_MAX_DOLLARS number(6,0)
 ,FPL_DESCRIPTION varchar2(100)
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_FEDERAL_POVERTY_LEVELS.FPL_ID is ' Federal Poverty Level ID (PK)';
comment on column EMRS_D_FEDERAL_POVERTY_LEVELS.FPL_YEAR is ' Federal Poverty Level Effective Year';
comment on column EMRS_D_FEDERAL_POVERTY_LEVELS.FPL_LOCALE is ' Federal Poverty Level Locale';
comment on column EMRS_D_FEDERAL_POVERTY_LEVELS.FPL_NUMBER_IN_FAMILY is ' Federal Poverty Level Number of Family Members';
comment on column EMRS_D_FEDERAL_POVERTY_LEVELS.FPL_MAX_DOLLARS is ' Federal Poverty Level Maximum Dollar Income';
comment on column EMRS_D_FEDERAL_POVERTY_LEVELS.FPL_DESCRIPTION is ' Federal Poverty Level Description';
comment on column EMRS_D_FEDERAL_POVERTY_LEVELS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_FEDERAL_POVERTY_LEVELS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_FEDERAL_POVERTY_LEVELS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_FEDERAL_POVERTY_LEVELS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_FEDERAL_POVERTY_LEVELS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_FEDERAL_POVERTY_LEVELS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_FEDERAL_POVERTY_LEVELS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_COVERAGE_CATEGORIES'
create table EMRS_D_COVERAGE_CATEGORIES
 (COVERAGE_CATEGORY_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(30) not null
 ,COVERAGE_CATEGORY_TYPE varchar2(30)
 ,COVERAGE_CATEGORY_CODE varchar2(2) not null
 ,COVERAGE_CATEGORY varchar2(80)
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_COVERAGE_CATEGORIES.COVERAGE_CATEGORY_ID is 'Coverage Category ID (PK)';
comment on column EMRS_D_COVERAGE_CATEGORIES.MANAGED_CARE_PROGRAM is 'Managed Care Program';
comment on column EMRS_D_COVERAGE_CATEGORIES.COVERAGE_CATEGORY_TYPE is 'Coverage Category Type';
comment on column EMRS_D_COVERAGE_CATEGORIES.COVERAGE_CATEGORY_CODE is 'Coverage Category Code';
comment on column EMRS_D_COVERAGE_CATEGORIES.COVERAGE_CATEGORY is 'Coverage Category';
comment on column EMRS_D_COVERAGE_CATEGORIES.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_COVERAGE_CATEGORIES.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_COVERAGE_CATEGORIES.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_COVERAGE_CATEGORIES.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_COVERAGE_CATEGORIES.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_COVERAGE_CATEGORIES.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_COVERAGE_CATEGORIES.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_F_ENROLLMENTS'
create table EMRS_F_ENROLLMENTS
 (ENROLLMENT_ID integer not null
 ,CASE_ID integer not null
 ,CHANGE_REASON_ID integer not null
 ,CLIENT_ID integer not null
 ,COMMUNICATION_TYPE_ID integer not null
 ,COUNTY_ID integer not null
 ,COVERAGE_CATEGORY_ID integer not null
 ,CSDA_ID integer not null
 ,DATE_PERIOD_ID number not null
 ,ENROLLMENT_ACTION_STATUS_ID integer not null
 ,FPL_ID integer not null
 ,LANGUAGE_CODE_ID integer not null
 ,PLAN_ID integer not null
 ,PROGRAM_ID integer not null
 ,PROVIDER_ID integer not null
 ,PROVIDER_TYPE_ID integer not null
 ,RACE_ID integer not null
 ,REJECTION_ERROR_REASON_ID integer not null
 ,RISK_GROUP_ID integer not null
 ,STAT_IN_GRP_ID integer not null
 ,SUB_PROGRAM_ID integer not null
 ,TERM_REASON_CODE_ID integer not null
 ,TIME_PERIOD_ID number not null
 ,CERTIFICATION_DATE varchar2(240)
 ,CO_PAY_AMOUNT number(3,2)
 ,CSDA_CHANGE_DATE date
 ,ENROLLMENT_FEE_ASSESSED number(4,2)
 ,ENROLLMENT_FEE_ASSESSED_DATE number(4)
 ,ENROLLMENT_FEE_PAID number(4,2)
 ,ENROLLMENT_FEE_PAID_DATE date
 ,ENROLLMENT_STATUS_CHANGE_DATE date
 ,JYEAR_OF_LAST_ENROLLMENT_FORM date
 ,MANAGED_CARE_END_DATE date
 ,MANAGED_CARE_START_DATE date
 ,MEDICAID_BUY_IN_FEE number(4,2)
 ,MEDICAID_BUY_IN_FEE_DATE date
 ,MEDICAID_RECERTIFICATION_DATE date
 ,NUMBER_COUNT number
 ,PEOPLE_IN_FAMILY number(2)
 ,DATE_CREATED date not null
 ,CREATED_BY varchar2(18) not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_F_ENROLLMENTS.CASE_ID is 'Case ID (PK)';
comment on column EMRS_F_ENROLLMENTS.CHANGE_REASON_ID is 'Change Reason ID (PK)';
comment on column EMRS_F_ENROLLMENTS.CLIENT_ID is 'Client ID (PK)';
comment on column EMRS_F_ENROLLMENTS.COMMUNICATION_TYPE_ID is 'Communication Type ID (PK)';
comment on column EMRS_F_ENROLLMENTS.COUNTY_ID is 'County ID (PK)';
comment on column EMRS_F_ENROLLMENTS.COVERAGE_CATEGORY_ID is 'Coverage Category ID (PK)';
comment on column EMRS_F_ENROLLMENTS.CSDA_ID is 'CSDA ID (PK)';
comment on column EMRS_F_ENROLLMENTS.ENROLLMENT_ACTION_STATUS_ID is 'Enrollment Status ID (PK)';
comment on column EMRS_F_ENROLLMENTS.FPL_ID is ' Federal Poverty Level ID (PK)';
comment on column EMRS_F_ENROLLMENTS.LANGUAGE_CODE_ID is 'Language Code ID (PK)';
comment on column EMRS_F_ENROLLMENTS.PLAN_ID is 'Plan (PK)';
comment on column EMRS_F_ENROLLMENTS.PROGRAM_ID is 'Program Type ID (PK)';
comment on column EMRS_F_ENROLLMENTS.PROVIDER_ID is 'Provider Type ID (PK)';
comment on column EMRS_F_ENROLLMENTS.PROVIDER_TYPE_ID is 'Provider Type ID (PK)';
comment on column EMRS_F_ENROLLMENTS.RACE_ID is 'Race ID (SK)';
comment on column EMRS_F_ENROLLMENTS.REJECTION_ERROR_REASON_ID is 'Rejection Error Reason ID (PK)';
comment on column EMRS_F_ENROLLMENTS.RISK_GROUP_ID is 'Risk Group ID (PK)';
comment on column EMRS_F_ENROLLMENTS.STAT_IN_GRP_ID is 'Status in Group ID (PK)';
comment on column EMRS_F_ENROLLMENTS.SUB_PROGRAM_ID is 'Sub Program ID (PK)';
comment on column EMRS_F_ENROLLMENTS.TERM_REASON_CODE_ID is 'Term Reason Code ID (PK)';
comment on column EMRS_F_ENROLLMENTS.TIME_PERIOD_ID is 'Time Period ID (PK)';
comment on column EMRS_F_ENROLLMENTS.CERTIFICATION_DATE is 'Certification Date';
comment on column EMRS_F_ENROLLMENTS.CO_PAY_AMOUNT is 'Co-Pay Amount';
comment on column EMRS_F_ENROLLMENTS.CSDA_CHANGE_DATE is 'Date CSDA Changed';
comment on column EMRS_F_ENROLLMENTS.ENROLLMENT_FEE_ASSESSED is 'Enrollment Fee Amount Assessed';
comment on column EMRS_F_ENROLLMENTS.ENROLLMENT_FEE_ASSESSED_DATE is 'Enrollment Fee Assessment Date';
comment on column EMRS_F_ENROLLMENTS.ENROLLMENT_FEE_PAID is 'Enrollment Fee Amount Paid';
comment on column EMRS_F_ENROLLMENTS.ENROLLMENT_FEE_PAID_DATE is 'Enrollment Fee Paid Date';
comment on column EMRS_F_ENROLLMENTS.ENROLLMENT_STATUS_CHANGE_DATE is 'Date Enrollment Status Changed';
comment on column EMRS_F_ENROLLMENTS.JYEAR_OF_LAST_ENROLLMENT_FORM is 'Year of Last Enrollment (Julian)';
comment on column EMRS_F_ENROLLMENTS.MANAGED_CARE_END_DATE is 'Managed Care End Date, Current';
comment on column EMRS_F_ENROLLMENTS.MANAGED_CARE_START_DATE is 'Managed Care Start Date, Current';
comment on column EMRS_F_ENROLLMENTS.MEDICAID_BUY_IN_FEE is 'Medicaid Buy-In Fee';
comment on column EMRS_F_ENROLLMENTS.MEDICAID_BUY_IN_FEE_DATE is 'Medicaid Buy-In Fee Date';
comment on column EMRS_F_ENROLLMENTS.MEDICAID_RECERTIFICATION_DATE is 'Medicaid Re-Certification Date';
comment on column EMRS_F_ENROLLMENTS.NUMBER_COUNT is 'Number Count';
comment on column EMRS_F_ENROLLMENTS.PEOPLE_IN_FAMILY is 'Number of People in Family';
comment on column EMRS_F_ENROLLMENTS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_F_ENROLLMENTS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_F_ENROLLMENTS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_F_ENROLLMENTS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_F_ORCH_SELECTED_TARGETS'
create table EMRS_F_ORCH_SELECTED_TARGETS
 (OUTREACH_SELECTED_TARGET_ID integer not null
 ,ACTION_TYPE_ID integer not null
 ,COUNTY_ID integer not null
 ,CSDA_ID integer not null
 ,HEADSTART_GRANTEE_ID integer not null
 ,SCHOOL_DISTRICT_ID integer not null
 ,TARGET_ACTIVITY_ID integer not null
 ,TARGET_GROUP_ID integer not null
 ,TARGET_GROUP_TYPE_ID integer not null
 ,NUMBER_COUNT integer not null
 ,ACTIVITY_DATE date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_F_ORCH_SELECTED_TARGETS.OUTREACH_SELECTED_TARGET_ID is 'Outreach Outcome ID (PK)';
comment on column EMRS_F_ORCH_SELECTED_TARGETS.ACTION_TYPE_ID is 'Outreach Action Type ID (PK)';
comment on column EMRS_F_ORCH_SELECTED_TARGETS.COUNTY_ID is 'County ID (PK)';
comment on column EMRS_F_ORCH_SELECTED_TARGETS.CSDA_ID is 'CSDA ID (PK)';
comment on column EMRS_F_ORCH_SELECTED_TARGETS.HEADSTART_GRANTEE_ID is 'Head Start Grantee';
comment on column EMRS_F_ORCH_SELECTED_TARGETS.SCHOOL_DISTRICT_ID is 'School District ID (PK)';
comment on column EMRS_F_ORCH_SELECTED_TARGETS.TARGET_ACTIVITY_ID is 'Outreach Target Activity ID (PK)';
comment on column EMRS_F_ORCH_SELECTED_TARGETS.TARGET_GROUP_ID is 'Selected Target Group Type ID (PK)';
comment on column EMRS_F_ORCH_SELECTED_TARGETS.TARGET_GROUP_TYPE_ID is 'Outreach Target Group Type ID (PK)';
comment on column EMRS_F_ORCH_SELECTED_TARGETS.NUMBER_COUNT is 'Number Count';
comment on column EMRS_F_ORCH_SELECTED_TARGETS.ACTIVITY_DATE is 'Activity Date';
comment on column EMRS_F_ORCH_SELECTED_TARGETS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_F_ORCH_SELECTED_TARGETS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_F_ORCH_SELECTED_TARGETS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_F_ORCH_SELECTED_TARGETS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_HEADSTART_GRANTEES'
create table EMRS_D_HEADSTART_GRANTEES
 (HEADSTART_GRANTEE_ID integer not null
 ,GRANTEE_NAME varchar2(50) not null
 ,START_DATE date
 ,END_DATE date
 ,SOURCE_RECORD_ID integer
 ,SR_REGION_ID     integer
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_HEADSTART_GRANTEES.HEADSTART_GRANTEE_ID is 'Head Start Grantee';
comment on column EMRS_D_HEADSTART_GRANTEES.GRANTEE_NAME is 'Grantee Name';
comment on column EMRS_D_HEADSTART_GRANTEES.START_DATE is 'Grantee Start Date';
comment on column EMRS_D_HEADSTART_GRANTEES.END_DATE is 'Grantee End Date';
comment on column EMRS_D_HEADSTART_GRANTEES.SOURCE_RECORD_ID is 'Source Record ID';
comment on column EMRS_D_HEADSTART_GRANTEES.SR_REGION_ID is 'Source-System Region ID';
comment on column EMRS_D_HEADSTART_GRANTEES.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_HEADSTART_GRANTEES.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_HEADSTART_GRANTEES.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_HEADSTART_GRANTEES.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_HEADSTART_GRANTEES.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_HEADSTART_GRANTEES.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_HEADSTART_GRANTEES.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_F_OUTREACH_EVENTS'
create table EMRS_F_OUTREACH_EVENTS
 (OUTREACH_EVENT_ID integer not null
 ,ACTIVITY_ID integer not null
 ,COMMUNICATION_TYPE_ID integer not null
 ,DATE_PERIOD_ID number not null
 ,LANGUAGE_CODE_ID integer not null
 ,STAFF_ID integer not null
 ,ACTIVITY_EVENT_DATE date
 ,DOOR_PRIZE_VALUE number(7,2)
 ,FEE_AMOUNT number(7,2)
 ,NUMBER_KITS_PROVIDED number
 ,NUMBER_RECIPIENT_ATTENDEES number
 ,NUMBER_STAFF_ATTENDEES number
 ,NUMBER_COUNT number(3,0) not null
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_F_OUTREACH_EVENTS.OUTREACH_EVENT_ID is 'Outreach Event ID (PK)';
comment on column EMRS_F_OUTREACH_EVENTS.ACTIVITY_ID is 'Outreach Activity ID (PK)';
comment on column EMRS_F_OUTREACH_EVENTS.COMMUNICATION_TYPE_ID is 'Communication Type ID (PK)';
comment on column EMRS_F_OUTREACH_EVENTS.DATE_PERIOD_ID is 'Date Period ID (PK)';
comment on column EMRS_F_OUTREACH_EVENTS.LANGUAGE_CODE_ID is 'Language Code ID (PK)';
comment on column EMRS_F_OUTREACH_EVENTS.STAFF_ID is 'Staff ID (PK)';
comment on column EMRS_F_OUTREACH_EVENTS.ACTIVITY_EVENT_DATE is 'Activity;Event Date';
comment on column EMRS_F_OUTREACH_EVENTS.DOOR_PRIZE_VALUE is 'Outreach Door Prize Value';
comment on column EMRS_F_OUTREACH_EVENTS.FEE_AMOUNT is 'Outreach Event Fee Amount';
comment on column EMRS_F_OUTREACH_EVENTS.NUMBER_KITS_PROVIDED is 'Number of Outreach Kits Provided';
comment on column EMRS_F_OUTREACH_EVENTS.NUMBER_RECIPIENT_ATTENDEES is 'Number of Outreach Recipient Attendees';
comment on column EMRS_F_OUTREACH_EVENTS.NUMBER_STAFF_ATTENDEES is 'Number of Outreach Staff Attendees';
comment on column EMRS_F_OUTREACH_EVENTS.NUMBER_COUNT is 'Number Count';
comment on column EMRS_F_OUTREACH_EVENTS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_F_OUTREACH_EVENTS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_F_OUTREACH_EVENTS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_F_OUTREACH_EVENTS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_S_OUTREACH_FACTS'
create table EMRS_S_OUTREACH_FACTS
 (ACTIVITY_ID integer not null
 ,ACTIVITY_NAME varchar2(50)
 ,ACTIVITY_DATE date not null
 ,ACTIVITY_CATEGORY varchar2(10) not null
 ,ACTIVITY_TYPE varchar2(2000)
 ,COUNTY_NAME varchar2(30)
 ,CSDA_CODE varchar2(10)
 ,DOOR_PRIZE_VALUE number(10,2)
 ,FEE_AMOUNT number(10,2)
 ,NBR_KITS_PROVIDED integer
 ,NBR_RECIPIENT_ATTENDEES integer
 ,NBR_STAFF_ATTENDEES integer
 ,STAFF_FIRST varchar2(25)
 ,ST_CNTY_NUM number(10,0) not null
 ,ACTIVITY_ACTION_TYPE_ID integer not null
 ,COMM_TYPE_ID integer not null
 ,LANG_ID integer not null
 ,OBSERVATION_ID integer not null
 ,REGION_ID integer not null
 ,SRC_STAFF_ID integer not null
 ,TIME_PERIOD_ID integer not null
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_S_OUTREACH_FACTS.ACTIVITY_ID is 'Activities ID';
comment on column EMRS_S_OUTREACH_FACTS.ACTIVITY_NAME is 'Activity Name';
comment on column EMRS_S_OUTREACH_FACTS.ACTIVITY_DATE is 'Activity Date';
comment on column EMRS_S_OUTREACH_FACTS.ACTIVITY_CATEGORY is 'Group Category';
comment on column EMRS_S_OUTREACH_FACTS.ACTIVITY_TYPE is 'Group Type Name';
comment on column EMRS_S_OUTREACH_FACTS.COUNTY_NAME is 'County Name';
comment on column EMRS_S_OUTREACH_FACTS.CSDA_CODE is 'CSDA Code';
comment on column EMRS_S_OUTREACH_FACTS.DOOR_PRIZE_VALUE is 'Door Prize Value';
comment on column EMRS_S_OUTREACH_FACTS.FEE_AMOUNT is 'Fee Amount';
comment on column EMRS_S_OUTREACH_FACTS.NBR_KITS_PROVIDED is 'Number of Kits Provided';
comment on column EMRS_S_OUTREACH_FACTS.NBR_RECIPIENT_ATTENDEES is 'Number of Recipient Attendees';
comment on column EMRS_S_OUTREACH_FACTS.NBR_STAFF_ATTENDEES is 'Number of Staff Attendees';
comment on column EMRS_S_OUTREACH_FACTS.STAFF_FIRST is 'Staff''s First Name';
comment on column EMRS_S_OUTREACH_FACTS.ST_CNTY_NUM is 'State County Number';
comment on column EMRS_S_OUTREACH_FACTS.ACTIVITY_ACTION_TYPE_ID is 'Activity_Trans - Target Group Type';
comment on column EMRS_S_OUTREACH_FACTS.COMM_TYPE_ID is 'Communication Type ID';
comment on column EMRS_S_OUTREACH_FACTS.LANG_ID is 'Language ID';
comment on column EMRS_S_OUTREACH_FACTS.OBSERVATION_ID is 'Observation ID';
comment on column EMRS_S_OUTREACH_FACTS.REGION_ID is 'Regions ID';

prompt Creating table 'EMRS_D_CHANGE_REASONS'
create table EMRS_D_CHANGE_REASONS
 (CHANGE_REASON_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(30) not null
 ,CHANGE_REASON_CODE_PLAN varchar2(240)
 ,CHANGE_REASON_CODE varchar2(3) not null
 ,CHANGE_REASON varchar2(120) not null
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_CHANGE_REASONS.CHANGE_REASON_ID is 'Change Reason ID (PK)';
comment on column EMRS_D_CHANGE_REASONS.MANAGED_CARE_PROGRAM is 'Managed Care Program';
comment on column EMRS_D_CHANGE_REASONS.CHANGE_REASON_CODE is 'Change Reason Code';
comment on column EMRS_D_CHANGE_REASONS.CHANGE_REASON is 'Change Reason';
comment on column EMRS_D_CHANGE_REASONS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_CHANGE_REASONS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_CHANGE_REASONS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_CHANGE_REASONS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_CHANGE_REASONS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_CHANGE_REASONS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_CHANGE_REASONS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_ENROLLMENT_ACTION_STATU'
create table EMRS_D_ENROLLMENT_ACTION_STATU
 (ENROLLMENT_ACTION_STATUS_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(50) not null
 ,ENROLLMENT_ACTION_STATUS_CODE varchar2(2)
 ,ENROLLMENT_ACTION_STATUS_CODE_ varchar2(35)
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_ENROLLMENT_ACTION_STATU.ENROLLMENT_ACTION_STATUS_ID is 'Enrollment Status ID (PK)';
comment on column EMRS_D_ENROLLMENT_ACTION_STATU.MANAGED_CARE_PROGRAM is 'Managed Care Program that Uses This CSDA';
comment on column EMRS_D_ENROLLMENT_ACTION_STATU.ENROLLMENT_ACTION_STATUS_CODE is 'Enrollment Status Code';
comment on column EMRS_D_ENROLLMENT_ACTION_STATU.ENROLLMENT_ACTION_STATUS_CODE_ is 'Enrollment Status Description';
comment on column EMRS_D_ENROLLMENT_ACTION_STATU.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_ENROLLMENT_ACTION_STATU.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record'
comment on column EMRS_D_ENROLLMENT_ACTION_STATU.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_ENROLLMENT_ACTION_STATU.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_ENROLLMENT_ACTION_STATU.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_ENROLLMENT_ACTION_STATU.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_ENROLLMENT_ACTION_STATU.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_TARGET_GROUPS'
create table EMRS_D_TARGET_GROUPS
 (TARGET_GROUP_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(50) not null
 ,ACTIVITY_ID integer
 ,ACTIVITY_NAME varchar2(50)
 ,ACTIVITY_DATE date
 ,SELECTED_TARGET_GROUP_ID integer
 ,SELECTED_TARGET_CATEGORY varchar2(10) not null
 ,SELECTED_TARGET_GROUP_NAME varchar2(2000) not null
 ,SCHOOL_ID integer
 ,SOURCE_RECORD_ID integer not null
 ,VERSION number(3,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_TARGET_GROUPS.TARGET_GROUP_ID is 'Selected Target Group Type ID (PK)';
comment on column EMRS_D_TARGET_GROUPS.MANAGED_CARE_PROGRAM is 'Managed Care Program that Uses This Action Type';
comment on column EMRS_D_TARGET_GROUPS.ACTIVITY_ID is 'Activity ID';
comment on column EMRS_D_TARGET_GROUPS.ACTIVITY_NAME is 'Activity Name';
comment on column EMRS_D_TARGET_GROUPS.ACTIVITY_DATE is 'Activity Date';
comment on column EMRS_D_TARGET_GROUPS.SELECTED_TARGET_GROUP_ID is 'Selected Target Group ID';
comment on column EMRS_D_TARGET_GROUPS.SELECTED_TARGET_CATEGORY is 'Selected Target Group Category';
comment on column EMRS_D_TARGET_GROUPS.SELECTED_TARGET_GROUP_NAME is 'Selected Target GroupName';
comment on column EMRS_D_TARGET_GROUPS.SCHOOL_ID is 'School ID';
comment on column EMRS_D_TARGET_GROUPS.SOURCE_RECORD_ID is 'Source-System Primary-Key Record ID #';
comment on column EMRS_D_TARGET_GROUPS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_TARGET_GROUPS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_TARGET_GROUPS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_TARGET_GROUPS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_TARGET_GROUPS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_TARGET_GROUPS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_TARGET_GROUPS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_OUTREACH_ACTIVITIES'
create table EMRS_D_OUTREACH_ACTIVITIES
 (ACTIVITY_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(50) not null
 ,ACTIVITY_NAME varchar2(50)
 ,ACTIVITY_DATE date
 ,ACTIVITY_ADDRESS varchar2(55)
 ,ACTIVITY_CITY varchar2(30)
 ,ACTIVITY_STATE varchar2(2)
 ,ACTIVITY_ZIP varchar2(15)
 ,ACTIVITY_FEE_ASSESSED number(7,2)
 ,ACTIVITY_DOOR_PRIZE_VALUE number(7,2)
 ,CONTACT_FNAME varchar2(40)
 ,CONTACT_LNAME varchar2(40)
 ,CONTACT_EMAIL varchar2(50)
 ,CONTACT_ADDRESS varchar2(55)
 ,CONTACT_AREA_CODE varchar2(3)
 ,CONTACT_PHONE varchar2(11)
 ,CONTACT_EXTENSION varchar2(6)
 ,OBSERVATION varchar2(2000)
 ,OUTCOME_COMMENTS varchar2(1000)
 ,SOURCE_RECORD_ID integer
 ,NBR_KITS_PROVIDED integer
 ,NBR_RECIPIENT_ATTENDEES integer
 ,NBR_STAFF_ATTENDEES integer
 ,SR_COMM_TYPE_ID integer
 ,SR_LANGUAGE_ID integer
 ,SR_OBSERVATION_ID integer
 ,SR_STAFF_ID integer
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_OUTREACH_ACTIVITIES.ACTIVITY_ID is 'Outreach Activity ID (PK)';
comment on column EMRS_D_OUTREACH_ACTIVITIES.MANAGED_CARE_PROGRAM is 'Managed Care Program that Uses This Outreach Target Group Activity';
comment on column EMRS_D_OUTREACH_ACTIVITIES.ACTIVITY_NAME is 'Activity Name';
comment on column EMRS_D_OUTREACH_ACTIVITIES.ACTIVITY_DATE is 'Activity Date';
comment on column EMRS_D_OUTREACH_ACTIVITIES.ACTIVITY_ADDRESS is 'Activity Site Address';
comment on column EMRS_D_OUTREACH_ACTIVITIES.ACTIVITY_CITY is 'Activity City';
comment on column EMRS_D_OUTREACH_ACTIVITIES.ACTIVITY_STATE is 'Activity State';
comment on column EMRS_D_OUTREACH_ACTIVITIES.ACTIVITY_ZIP is 'Activity Zip Code';
comment on column EMRS_D_OUTREACH_ACTIVITIES.ACTIVITY_FEE_ASSESSED is 'Outreach Target Group Activity Fee Assessed (Y;N)';
comment on column EMRS_D_OUTREACH_ACTIVITIES.ACTIVITY_DOOR_PRIZE_VALUE is 'Outreach Target Group Activity Door Prize (Y;N)';
comment on column EMRS_D_OUTREACH_ACTIVITIES.CONTACT_FNAME is 'Contact First Name';
comment on column EMRS_D_OUTREACH_ACTIVITIES.CONTACT_LNAME is 'Contact Last Name';
comment on column EMRS_D_OUTREACH_ACTIVITIES.CONTACT_EMAIL is 'Contact Email Address';
comment on column EMRS_D_OUTREACH_ACTIVITIES.CONTACT_ADDRESS is 'Contact Address';
comment on column EMRS_D_OUTREACH_ACTIVITIES.CONTACT_AREA_CODE is 'Contact Area Code';
comment on column EMRS_D_OUTREACH_ACTIVITIES.CONTACT_PHONE is 'Contact Phone Number';
comment on column EMRS_D_OUTREACH_ACTIVITIES.CONTACT_EXTENSION is 'Contact Phone Extension';
comment on column EMRS_D_OUTREACH_ACTIVITIES.OBSERVATION is 'Observation';
comment on column EMRS_D_OUTREACH_ACTIVITIES.OUTCOME_COMMENTS is 'Outcome Comments';
comment on column EMRS_D_OUTREACH_ACTIVITIES.SOURCE_RECORD_ID is 'Source-System Primary-Key Record ID #';
comment on column EMRS_D_OUTREACH_ACTIVITIES.NBR_KITS_PROVIDED is 'Number of Kits Provided';
comment on column EMRS_D_OUTREACH_ACTIVITIES.NBR_RECIPIENT_ATTENDEES is 'Number of Recipient Attendees';
comment on column EMRS_D_OUTREACH_ACTIVITIES.NBR_STAFF_ATTENDEES is 'Number of Staff Attendees';
comment on column EMRS_D_OUTREACH_ACTIVITIES.SR_COMM_TYPE_ID is 'Source-System Communication TypeID';
comment on column EMRS_D_OUTREACH_ACTIVITIES.SR_LANGUAGE_ID is 'Source-System Language ID';
comment on column EMRS_D_OUTREACH_ACTIVITIES.SR_OBSERVATION_ID is 'Source-System Observation ID';
comment on column EMRS_D_OUTREACH_ACTIVITIES.SR_STAFF_ID is 'Source-System Staff ID';
comment on column EMRS_D_OUTREACH_ACTIVITIES.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_OUTREACH_ACTIVITIES.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_OUTREACH_ACTIVITIES.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_OUTREACH_ACTIVITIES.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_OUTREACH_ACTIVITIES.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_OUTREACH_ACTIVITIES.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_OUTREACH_ACTIVITIES.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_COMMUNICATION_STATUS'
create table EMRS_D_COMMUNICATION_STATUS
 (COMMUNICATION_STATUS_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(50)
 ,COMMUNICATION_STATUS_CODE varchar2(5)
 ,COMMUNICATION_STATUS_NAME varchar2(20)
 ,COMMUNICATION_STATUS_DESC varchar2(200)
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_COMMUNICATION_STATUS.COMMUNICATION_STATUS_ID is 'Communication Status ID (PK)';
comment on column EMRS_D_COMMUNICATION_STATUS.MANAGED_CARE_PROGRAM is 'Managed Care Program that Could Be In This Communication State';
comment on column EMRS_D_COMMUNICATION_STATUS.COMMUNICATION_STATUS_CODE is 'Communication Status  Code';
comment on column EMRS_D_COMMUNICATION_STATUS.COMMUNICATION_STATUS_NAME is 'Communication Status  Name';
comment on column EMRS_D_COMMUNICATION_STATUS.COMMUNICATION_STATUS_DESC is 'Communication Status  Description';
comment on column EMRS_D_COMMUNICATION_STATUS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_COMMUNICATION_STATUS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_COMMUNICATION_STATUS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_COMMUNICATION_STATUS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_COMMUNICATION_STATUS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_COMMUNICATION_STATUS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_COMMUNICATION_STATUS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_CARE_SERV_DELIV_AREAS'
create table EMRS_D_CARE_SERV_DELIV_AREAS
 (CSDA_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(50) not null
 ,CSDA_CODE varchar2(3) not null
 ,CSDA_NAME varchar2(35) not null
 ,REGION_NUMBER_CATEGORY varchar2(5)
 ,STATUS varchar2(1)
 ,IMPLEMENTATION_DATE date
 ,RECORD_DATE date
 ,RECORD_TIME varchar2(5)
 ,RECORD_NAME varchar2(18)
 ,MODIFIED_DATE date
 ,MODIFIED_TIME varchar2(5)
 ,MODIFIED_NAME varchar2(18)
 ,STARPLUS varchar2(1)
 ,SOURCE_RECORD_ID number
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_CARE_SERV_DELIV_AREAS.CSDA_ID is 'CSDA ID (PK)';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.MANAGED_CARE_PROGRAM is 'Managed Care Program that Uses This CSDA';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.CSDA_CODE is 'Care Service Delivery Area ID';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.CSDA_NAME is 'CSDA Name';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.REGION_NUMBER_CATEGORY is 'Outreach Region Number';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.STATUS is 'CSDA Status';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.IMPLEMENTATION_DATE is 'CSDA Implementation Date';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.RECORD_DATE is 'Record Creation Date';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.RECORD_TIME is 'Record Creation Time';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.RECORD_NAME is 'Record Created By';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.MODIFIED_DATE is 'Record Modification Date';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.MODIFIED_TIME is 'Record Modification Time';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.MODIFIED_NAME is 'Record Modified By - Last Name';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.STARPLUS is 'STAR+PLUS CSDA (Y;N)';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.SOURCE_RECORD_ID is 'Source-System Primary-Key Record ID #';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_CARE_SERV_DELIV_AREAS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_S_HEADSTART_GRANT_CENTERS'
create table EMRS_S_HEADSTART_GRANT_CENTERS
 (SOURCE_RECORD_ID integer not null
 ,ACTIVITY_NAME varchar2(50)
 ,ACTIVITY_DATE varchar2(240)
 ,ACTIVITY_ID varchar2(240)
 ,SELECTED_TARGET_GROUP_ID varchar2(240)
 ,SELECTED_TARGET_CATEGORY varchar2(7)
 ,SELECTED_TARGET_GROUP_NAME varchar2(100)
 ,HEADSTART_GRANTEE varchar2(50)
 ,TRG_GRP_SRC_TBL varchar2(30)
 ,SR_GRNCN_ID varchar2(240)
 ,SR_HSGRNT_ID varchar2(240)
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_S_HEADSTART_GRANT_CENTERS.SOURCE_RECORD_ID is 'Source Record ID';
comment on column EMRS_S_HEADSTART_GRANT_CENTERS.ACTIVITY_NAME is 'Activity Name';
comment on column EMRS_S_HEADSTART_GRANT_CENTERS.ACTIVITY_DATE is 'Activity Date';
comment on column EMRS_S_HEADSTART_GRANT_CENTERS.ACTIVITY_ID is 'Activity ID';
comment on column EMRS_S_HEADSTART_GRANT_CENTERS.SELECTED_TARGET_GROUP_ID is 'Selected Target Group ID';
comment on column EMRS_S_HEADSTART_GRANT_CENTERS.SELECTED_TARGET_CATEGORY is 'Selected Target Group Category';
comment on column EMRS_S_HEADSTART_GRANT_CENTERS.SELECTED_TARGET_GROUP_NAME is 'Selected Target Group Name';
comment on column EMRS_S_HEADSTART_GRANT_CENTERS.HEADSTART_GRANTEE is 'Head Start Grantee';
comment on column EMRS_S_HEADSTART_GRANT_CENTERS.TRG_GRP_SRC_TBL is 'Target Group Source Table';
comment on column EMRS_S_HEADSTART_GRANT_CENTERS.SR_GRNCN_ID is 'Source-Record GRNCN_ID';
comment on column EMRS_S_HEADSTART_GRANT_CENTERS.SR_HSGRNT_ID is 'Source-Record HSGRNT_ID';

prompt Creating table 'EMRS_D_ACTION_TYPES'
create table EMRS_D_ACTION_TYPES
 (ACTION_TYPE_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(50) not null
 ,ACTION_CATEGORY varchar2(10)
 ,ACTION_TYPE_NAME varchar2(50) not null
 ,ACTION_TYPE_DESCRIPTION varchar2(160)
 ,SOURCE_RECORD_ID integer not null
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel
;

comment on column EMRS_D_ACTION_TYPES.ACTION_TYPE_ID is 'Outreach Action Type ID (PK)';
comment on column EMRS_D_ACTION_TYPES.MANAGED_CARE_PROGRAM is 'Managed Care Program that Uses This Action Type';
comment on column EMRS_D_ACTION_TYPES.ACTION_CATEGORY is 'Outreach Action Type Category';
comment on column EMRS_D_ACTION_TYPES.ACTION_TYPE_NAME is 'Outreach Action Type Name';
comment on column EMRS_D_ACTION_TYPES.ACTION_TYPE_DESCRIPTION is 'Outreach Action Type Description';
comment on column EMRS_D_ACTION_TYPES.SOURCE_RECORD_ID is 'Source-System Primary-Key Record ID #';
comment on column EMRS_D_ACTION_TYPES.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_ACTION_TYPES.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_ACTION_TYPES.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_ACTION_TYPES.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_ACTION_TYPES.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_ACTION_TYPES.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_ACTION_TYPES.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_OTHER_CHIP_CODES'
create table EMRS_D_OTHER_CHIP_CODES
 (OTHER_CHIP_CODE_ID number(30) not null
 ,OTHER_CHIP_CODE_TYPE varchar2(30) not null
 ,OTHER_CHIP_CODE varchar2(5) not null
 ,OTHER_CHIP_CODE_DESCRIPTION varchar2(100) not null
 ,MANAGED_CARE_PROGRAM varchar2(30) not null
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_OTHER_CHIP_CODES.OTHER_CHIP_CODE_ID is 'Other CHIP Codes ID (PK)';
comment on column EMRS_D_OTHER_CHIP_CODES.OTHER_CHIP_CODE_TYPE is 'Category or Type of CHIP Code';
comment on column EMRS_D_OTHER_CHIP_CODES.OTHER_CHIP_CODE is 'CHIP Code';
comment on column EMRS_D_OTHER_CHIP_CODES.OTHER_CHIP_CODE_DESCRIPTION is 'CHIP Code Description';
comment on column EMRS_D_OTHER_CHIP_CODES.MANAGED_CARE_PROGRAM is 'Managed Care Program';
comment on column EMRS_D_OTHER_CHIP_CODES.CREATED_BY is 'Created By';
comment on column EMRS_D_OTHER_CHIP_CODES.DATE_CREATED is 'Date Created';
comment on column EMRS_D_OTHER_CHIP_CODES.UPDATED_BY is 'Updated By';
comment on column EMRS_D_OTHER_CHIP_CODES.DATE_UPDATED is 'Date Updated';

prompt Creating table 'EMRS_D_RACES'
create table EMRS_D_RACES
 (RACE_ID integer not null
 ,RACE_CODE number(2,0)
 ,RACE_DESCRIPTION varchar2(75)
 ,MANAGED_CARE_PROGRAM varchar2(50)
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,DATE_CREATED date
 ,CREATED_BY varchar2(18) not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_RACES.RACE_ID is 'Race ID (SK)';
comment on column EMRS_D_RACES.RACE_CODE is 'Race Code Number';
comment on column EMRS_D_RACES.RACE_DESCRIPTION is 'Race Description';
comment on column EMRS_D_RACES.MANAGED_CARE_PROGRAM is 'Managed Care Program that Uses This Race Code;Description';
comment on column EMRS_D_RACES.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_RACES.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_RACES.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_RACES.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_RACES.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_RACES.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_RACES.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_F_COMMUNICATIONS'
create table EMRS_F_COMMUNICATIONS
 (COMMUNICATION_ID integer not null
 ,BIZCHANL_CHANNEL_ID integer not null
 ,CASE_ID integer not null
 ,CLIENT_ID integer not null
 ,COMMUNICATION_ACTION_ID integer not null
 ,COMMUNICATION_STATUS_ID integer not null
 ,COMMUNICATION_TYPE_ID integer not null
 ,CONTACT_TYPE_ID integer not null
 ,COUNTY_ID integer not null
 ,DATE_PERIOD_ID number not null
 ,LANGUAGE_CODE_ID integer not null
 ,PROGRAM_ID integer not null
 ,STAFF_ID integer not null
 ,TIME_PERIOD_ID number not null
 ,EVENT_DATE date
 ,NUMBER_COUNT number(3)
 ,CISCO_HOLD_TIME date
 ,CISCO_TALK_TIME varchar2(240)
 ,CISCO_AVERAGE_CALL_WAIT date
 ,CISCO_SPEED_TO_ANSWER date
 ,CISCO_HOW_LONG_TO_PROCESS date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel
;

comment on column EMRS_F_COMMUNICATIONS.COMMUNICATION_ID is 'Communication ID (PK)';
comment on column EMRS_F_COMMUNICATIONS.BIZCHANL_CHANNEL_ID is 'Busines Channel ID (PK)';
comment on column EMRS_F_COMMUNICATIONS.CASE_ID is 'Case ID (PK)';
comment on column EMRS_F_COMMUNICATIONS.CLIENT_ID is 'Client ID (PK)';
comment on column EMRS_F_COMMUNICATIONS.COMMUNICATION_ACTION_ID is 'Communication Action ID (PK)';
comment on column EMRS_F_COMMUNICATIONS.COMMUNICATION_STATUS_ID is 'Communication Status ID (PK)';
comment on column EMRS_F_COMMUNICATIONS.COMMUNICATION_TYPE_ID is 'Communication Type ID (PK)';
comment on column EMRS_F_COMMUNICATIONS.CONTACT_TYPE_ID is 'Channel ID (PK)';
comment on column EMRS_F_COMMUNICATIONS.COUNTY_ID is 'County ID (PK)';
comment on column EMRS_F_COMMUNICATIONS.DATE_PERIOD_ID is 'Date Period ID (PK)';
comment on column EMRS_F_COMMUNICATIONS.LANGUAGE_CODE_ID is 'Language Code ID (PK)';
comment on column EMRS_F_COMMUNICATIONS.PROGRAM_ID is 'Program Type ID (PK)';
comment on column EMRS_F_COMMUNICATIONS.STAFF_ID is 'Staff ID (PK)';
comment on column EMRS_F_COMMUNICATIONS.TIME_PERIOD_ID is 'Time Period ID (PK)';
comment on column EMRS_F_COMMUNICATIONS.EVENT_DATE is 'Date on Which the Event Occurred';
comment on column EMRS_F_COMMUNICATIONS.NUMBER_COUNT is 'Number Count';
comment on column EMRS_F_COMMUNICATIONS.CISCO_HOLD_TIME is 'Time waiting on Hold before Agent';
comment on column EMRS_F_COMMUNICATIONS.CISCO_AVERAGE_CALL_WAIT is 'Average Call Wait';
comment on column EMRS_F_COMMUNICATIONS.CISCO_SPEED_TO_ANSWER is 'Average Speed to Answer';
comment on column EMRS_F_COMMUNICATIONS.CISCO_HOW_LONG_TO_PROCESS is 'How Log to Process Call';
comment on column EMRS_F_COMMUNICATIONS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_F_COMMUNICATIONS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_F_COMMUNICATIONS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_F_COMMUNICATIONS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_F_NOTES'
create table EMRS_F_NOTES
 (NOTE_ID integer not null
 ,BIZCHANL_CHANNEL_ID integer not null
 ,CASE_ID integer not null
 ,CLIENT_ID integer not null
 ,COMMUNICATION_ACTION_ID integer not null
 ,COMMUNICATION_STATUS_ID integer not null
 ,COMMUNICATION_TYPE_ID integer not null
 ,CONTACT_TYPE_ID integer not null
 ,COUNTY_ID integer not null
 ,DATE_PERIOD_ID number not null
 ,LANGUAGE_CODE_ID integer not null
 ,PROGRAM_ID integer not null
 ,STAFF_ID integer not null
 ,TIME_PERIOD_ID number not null
 ,NOTE LONG
 ,NUMBER_COUNT number not null
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_F_NOTES.NOTE_ID is 'Note ID (PK)';
comment on column EMRS_F_NOTES.BIZCHANL_CHANNEL_ID is 'Busines Channel ID (PK)';
comment on column EMRS_F_NOTES.CASE_ID is 'Case ID (PK)';
comment on column EMRS_F_NOTES.CLIENT_ID is 'Client ID (PK)';
comment on column EMRS_F_NOTES.COMMUNICATION_ACTION_ID is 'Communication Action ID (PK)';
comment on column EMRS_F_NOTES.COMMUNICATION_STATUS_ID is 'Communication Status ID (PK)';
comment on column EMRS_F_NOTES.COMMUNICATION_TYPE_ID is 'Communication Type ID (PK)';
comment on column EMRS_F_NOTES.CONTACT_TYPE_ID is 'Channel ID (PK)';
comment on column EMRS_F_NOTES.COUNTY_ID is 'County ID (PK)';
comment on column EMRS_F_NOTES.DATE_PERIOD_ID is 'Date Period ID (PK)';
comment on column EMRS_F_NOTES.LANGUAGE_CODE_ID is 'Language Code ID (PK)';
comment on column EMRS_F_NOTES.PROGRAM_ID is 'Program Type ID (PK)';
comment on column EMRS_F_NOTES.STAFF_ID is 'Staff ID (PK)';
comment on column EMRS_F_NOTES.TIME_PERIOD_ID is 'Time Period ID (PK)';
comment on column EMRS_F_NOTES.NOTE is 'Note - Comment - Message';
comment on column EMRS_F_NOTES.NUMBER_COUNT is 'Number Count';
comment on column EMRS_F_NOTES.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_F_NOTES.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_F_NOTES.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_F_NOTES.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_CONTACT_TYPES'
create table EMRS_D_CONTACT_TYPES
 (CONTACT_TYPE_ID integer not null
 ,CONTACT_TYPE_CODE number(3,0)
 ,CONTACT_TYPE_DESCRIPTION varchar2(50)
 ,DATE_CREATED date
 ,CREATED_BY varchar2(18) not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_CONTACT_TYPES.CONTACT_TYPE_ID is 'Channel ID (PK)';
comment on column EMRS_D_CONTACT_TYPES.CONTACT_TYPE_CODE is 'Media Channel Code';
comment on column EMRS_D_CONTACT_TYPES.CONTACT_TYPE_DESCRIPTION is 'Media Channel Description';
comment on column EMRS_D_CONTACT_TYPES.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_CONTACT_TYPES.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_CONTACT_TYPES.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_CONTACT_TYPES.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_CASES'
create table EMRS_D_CASES
 (CASE_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(50) not null
 ,CASE_NUMBER varchar2(9) not null
 ,CSDA_CODE varchar2(3) not null
 ,FIRST_NAME varchar2(10)
 ,MIDDLE_INITIAL varchar2(1)
 ,LAST_NAME varchar2(26)
 ,FULL_NAME varchar2(40)
 ,PHONE varchar2(10)
 ,MAILING_ADDRESS1 varchar2(26)
 ,MAILING_ADDRESS2 varchar2(26)
 ,MAILING_CITY varchar2(20)
 ,MAILING_STATE varchar2(2)
 ,MAILING_ZIP number(5)
 ,CASE_SEARCH_ELEMENT varchar2(9)
 ,GUARDIAN_FULL_NAME varchar2(60)
 ,RECORD_DATE date
 ,RECORD_TIME varchar2(5)
 ,RECORD_NAME varchar2(6)
 ,MODIFIED_DATE date
 ,MODIFIED_TIME varchar2(5)
 ,MODIFIED_NAME varchar2(6)
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_CASES.CASE_ID is 'Case ID (PK)';
comment on column EMRS_D_CASES.MANAGED_CARE_PROGRAM is 'Managed Care Program that Uses This CSDA';
comment on column EMRS_D_CASES.CASE_NUMBER is 'Case Number';
comment on column EMRS_D_CASES.CSDA_CODE is 'Care Service Delivery Area ID';
comment on column EMRS_D_CASES.FIRST_NAME is 'HOH First Name';
comment on column EMRS_D_CASES.MIDDLE_INITIAL is 'HOH Middle Initial';
comment on column EMRS_D_CASES.LAST_NAME is 'HOH Last Name';
comment on column EMRS_D_CASES.FULL_NAME is 'HOH Full Name';
comment on column EMRS_D_CASES.PHONE is 'Phone Number';
comment on column EMRS_D_CASES.MAILING_ADDRESS1 is 'Case Address 1';
comment on column EMRS_D_CASES.MAILING_ADDRESS2 is 'Case Address 2';
comment on column EMRS_D_CASES.MAILING_CITY is 'Case City';
comment on column EMRS_D_CASES.MAILING_STATE is 'Case State';
comment on column EMRS_D_CASES.MAILING_ZIP is 'Case ZIP';
comment on column EMRS_D_CASES.CASE_SEARCH_ELEMENT is 'Case Search Element (Last3 +Zip3)';
comment on column EMRS_D_CASES.GUARDIAN_FULL_NAME is 'HOH Full Name';
comment on column EMRS_D_CASES.RECORD_DATE is 'Record Creation Date';
comment on column EMRS_D_CASES.RECORD_TIME is 'Record Creation Time';
comment on column EMRS_D_CASES.RECORD_NAME is 'Record Creation Name';
comment on column EMRS_D_CASES.MODIFIED_DATE is 'Record Modification Date';
comment on column EMRS_D_CASES.MODIFIED_TIME is 'Record Modification Time';
comment on column EMRS_D_CASES.MODIFIED_NAME is 'Record Modification Name';
comment on column EMRS_D_CASES.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_CASES.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_CASES.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_CASES.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_CASES.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_CASES.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_CASES.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_COMMUNICATION_ACTIONS'
create table EMRS_D_COMMUNICATION_ACTIONS
 (COMMUNICATION_ACTION_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(50) not null
 ,COMMUNICATION_ACTION_NAME varchar2(20) not null
 ,COMMUNICATION_ACTION_DESCRIPTI varchar2(100)
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_COMMUNICATION_ACTIONS.COMMUNICATION_ACTION_ID is 'Communication Action ID (PK)';
comment on column EMRS_D_COMMUNICATION_ACTIONS.MANAGED_CARE_PROGRAM is 'Managed Care Program that Uses This CSDA';
comment on column EMRS_D_COMMUNICATION_ACTIONS.COMMUNICATION_ACTION_NAME is 'Communication Action Name';
comment on column EMRS_D_COMMUNICATION_ACTIONS.COMMUNICATION_ACTION_DESCRIPTI is 'Communication Action Description';
comment on column EMRS_D_COMMUNICATION_ACTIONS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_COMMUNICATION_ACTIONS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_COMMUNICATION_ACTIONS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_COMMUNICATION_ACTIONS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_COMMUNICATION_ACTIONS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_COMMUNICATION_ACTIONS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_COMMUNICATION_ACTIONS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_PROVIDERS'
create table EMRS_D_PROVIDERS
 (PROVIDER_ID integer not null
 ,PROVIDER_CODE varchar2(9) not null
 ,MANAGED_CARE_PROGRAM varchar2(30)
 ,PLAN_ID varchar2(6)
 ,PROVIDER_TITLE varchar2(4)
 ,PROVIDER_FIRST_NAME varchar2(35)
 ,PROVIDER_LAST_NAME varchar2(35)
 ,ATTENTION_LINE varchar2(40)
 ,ADDRESS_1 varchar2(30)
 ,ADDRESS_2 varchar2(30)
 ,ADDRESS_3 varchar2(30)
 ,CITY varchar2(12)
 ,STATE varchar2(6)
 ,ZIP varchar2(9)
 ,PHONE varchar2(12)
 ,COUNTY_ID varchar2(10)
 ,PROVIDER_LICENSE_NUMBER varchar2(11)
 ,PROVIDER_LICENSE_NUMBER_OLD varchar2(11)
 ,PROVIDER_LICENSE_NATIONAL_ID varchar2(11)
 ,PROVIDER_LICENSE_CATEGORY varchar2(1)
 ,NPI_BENEFIT_CODE varchar2(3)
 ,NPI_PRIMARY_TAXONOMY_CODE varchar2(10)
 ,RACE_ID varchar2(9)
 ,PROVIDER_TYPE varchar2(3)
 ,PROVIDER_SPECIALTY varchar2(2)
 ,PROVIDER_TAX_ID varchar2(16)
 ,PROVIDER_SEX_RESTRICTIONS varchar2(5)
 ,CSDA_ID varchar2(7)
 ,AGE_HIGH integer
 ,AGE_LOW integer
 ,LANGUAGE_SERVED_1 integer
 ,LANGUAGE_SERVED_2 integer
 ,LANGUAGE_SERVED_3 integer
 ,TOTAL_CLIENTS_ALLOWED varchar2(240)
 ,SOURCE_RECORD_DATE date
 ,SOURCE_RECORD_TIME varchar2(5)
 ,SOURCE_RECORD_NAME varchar2(10)
 ,VERSION integer
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_PROVIDERS.PROVIDER_ID is 'Provider Type ID (PK)';
comment on column EMRS_D_PROVIDERS.PROVIDER_CODE is 'Provider Medicaid Number';
comment on column EMRS_D_PROVIDERS.PLAN_ID is 'Plan ID';
comment on column EMRS_D_PROVIDERS.PROVIDER_TITLE is 'Provider Title';
comment on column EMRS_D_PROVIDERS.PROVIDER_FIRST_NAME is 'Provider First Name';
comment on column EMRS_D_PROVIDERS.PROVIDER_LAST_NAME is 'Provider Last Name';
comment on column EMRS_D_PROVIDERS.ATTENTION_LINE is 'Provider Attention Address Line';
comment on column EMRS_D_PROVIDERS.ADDRESS_1 is 'Provider Address 1';
comment on column EMRS_D_PROVIDERS.ADDRESS_2 is 'Provider Address 2';
comment on column EMRS_D_PROVIDERS.ADDRESS_3 is 'Provider Address 3';
comment on column EMRS_D_PROVIDERS.CITY is 'Provider City';
comment on column EMRS_D_PROVIDERS.STATE is 'Provider State';
comment on column EMRS_D_PROVIDERS.ZIP is 'Provider Zip Code';
comment on column EMRS_D_PROVIDERS.PHONE is 'Provider Phone';
comment on column EMRS_D_PROVIDERS.COUNTY_ID is 'Provider County ID';
comment on column EMRS_D_PROVIDERS.PROVIDER_LICENSE_NUMBER is 'Provider License Number';
comment on column EMRS_D_PROVIDERS.PROVIDER_LICENSE_NUMBER_OLD is 'Old Provider License Number';
comment on column EMRS_D_PROVIDERS.PROVIDER_LICENSE_NATIONAL_ID is 'National Provider Indentification Number (NPI)';
comment on column EMRS_D_PROVIDERS.PROVIDER_LICENSE_CATEGORY is 'Provider License Category';
comment on column EMRS_D_PROVIDERS.NPI_BENEFIT_CODE is 'NPI Benefit Code';
comment on column EMRS_D_PROVIDERS.NPI_PRIMARY_TAXONOMY_CODE is 'NPI Priimary Taxonomy Code';
comment on column EMRS_D_PROVIDERS.RACE_ID is 'Provider Race ID';
comment on column EMRS_D_PROVIDERS.PROVIDER_TYPE is 'Provider Type';
comment on column EMRS_D_PROVIDERS.PROVIDER_SPECIALTY is 'Provider Specialty';
comment on column EMRS_D_PROVIDERS.PROVIDER_TAX_ID is 'Provider Tax ID';
comment on column EMRS_D_PROVIDERS.PROVIDER_SEX_RESTRICTIONS is 'Provider Sex Restrictions';
comment on column EMRS_D_PROVIDERS.CSDA_ID is 'Provider Care Service Delivery Area';
comment on column EMRS_D_PROVIDERS.AGE_HIGH is 'Upper Age Limit';
comment on column EMRS_D_PROVIDERS.AGE_LOW is 'Lower Age Limit';
comment on column EMRS_D_PROVIDERS.LANGUAGE_SERVED_1 is 'Language Served 1';
comment on column EMRS_D_PROVIDERS.LANGUAGE_SERVED_2 is 'Language Served 2';
comment on column EMRS_D_PROVIDERS.LANGUAGE_SERVED_3 is 'Language Served 3';
comment on column EMRS_D_PROVIDERS.TOTAL_CLIENTS_ALLOWED is 'Total Clients Allowed';
comment on column EMRS_D_PROVIDERS.SOURCE_RECORD_DATE is 'Source System Record Date';
comment on column EMRS_D_PROVIDERS.SOURCE_RECORD_TIME is 'Source System Record Time';
comment on column EMRS_D_PROVIDERS.SOURCE_RECORD_NAME is 'Source System Record Name';
comment on column EMRS_D_PROVIDERS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_PROVIDERS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_PROVIDERS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_PROVIDERS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_PROVIDERS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_PROVIDERS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_PROVIDERS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_TARGET_ACTIVITIES'
create table EMRS_D_TARGET_ACTIVITIES
 (TARGET_ACTIVITY_ID integer not null
 ,ACTIVITY_NAME varchar2(50)
 ,ACTIVITY_DATE date
 ,SR_COMM_TYPE_ID integer
 ,SR_LANGUAGE_ID integer
 ,SR_OBSERVATION_ID integer
 ,SR_REGION_ID integer
 ,SR_STAFF_ID integer
 ,SOURCE_RECORD_ID integer
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_TARGET_ACTIVITIES.TARGET_ACTIVITY_ID is 'Outreach Target Activity ID (PK)';
comment on column EMRS_D_TARGET_ACTIVITIES.ACTIVITY_NAME is 'Activity Name';
comment on column EMRS_D_TARGET_ACTIVITIES.ACTIVITY_DATE is 'Activity Date';
comment on column EMRS_D_TARGET_ACTIVITIES.SR_COMM_TYPE_ID is 'Source-System Communication TypeID';
comment on column EMRS_D_TARGET_ACTIVITIES.SR_LANGUAGE_ID is 'Source-System Language ID';
comment on column EMRS_D_TARGET_ACTIVITIES.SR_OBSERVATION_ID is 'Source-System Observation ID';
comment on column EMRS_D_TARGET_ACTIVITIES.SR_REGION_ID is 'Source-System Region ID';
comment on column EMRS_D_TARGET_ACTIVITIES.SR_STAFF_ID is 'Source-System Staff ID';
comment on column EMRS_D_TARGET_ACTIVITIES.SOURCE_RECORD_ID is 'Source-System Primary-Key Record ID #';
comment on column EMRS_D_TARGET_ACTIVITIES.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_TARGET_ACTIVITIES.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_TARGET_ACTIVITIES.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_TARGET_ACTIVITIES.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_TARGET_ACTIVITIES.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_TARGET_ACTIVITIES.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_TARGET_ACTIVITIES.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_PROVIDER_SPECIALTY_CODE'
create table EMRS_D_PROVIDER_SPECIALTY_CODE
 (PROVIDER_SPECIALTY_CODE_ID integer not null
 ,PROVIDER_SPECIALTY_CODE varchar2(3) not null
 ,PROVIDER_SPECIALTY varchar2(65) not null
 ,VALID_PCP varchar2(1)
 ,INVALID_PCP varchar2(1)
 ,SPECIAL_NEEDS varchar2(1)
 ,MANAGED_CARE_PROGRAM varchar2(30) not null
 ,DATE_CREATED date
 ,CREATED_BY varchar2(18) not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_PROVIDER_SPECIALTY_CODE.PROVIDER_SPECIALTY_CODE_ID is 'Provider Specialty Code ID (PK)';
comment on column EMRS_D_PROVIDER_SPECIALTY_CODE.PROVIDER_SPECIALTY_CODE is 'Provider Specialty Code';
comment on column EMRS_D_PROVIDER_SPECIALTY_CODE.PROVIDER_SPECIALTY is 'Provider Specialty';
comment on column EMRS_D_PROVIDER_SPECIALTY_CODE.VALID_PCP is 'Valid PCP Provider';
comment on column EMRS_D_PROVIDER_SPECIALTY_CODE.INVALID_PCP is 'Invalid PCP Provider';
comment on column EMRS_D_PROVIDER_SPECIALTY_CODE.SPECIAL_NEEDS is 'Special Needs Provider';
comment on column EMRS_D_PROVIDER_SPECIALTY_CODE.MANAGED_CARE_PROGRAM is 'Managed Care Program';
comment on column EMRS_D_PROVIDER_SPECIALTY_CODE.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_PROVIDER_SPECIALTY_CODE.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_PROVIDER_SPECIALTY_CODE.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_PROVIDER_SPECIALTY_CODE.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_RISK_GROUPS'
create table EMRS_D_RISK_GROUPS
 (RISK_GROUP_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(30) not null
 ,RISK_GROUP varchar2(75) not null
 ,RISK_GROUP_CODE number(3,0) not null
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_RISK_GROUPS.RISK_GROUP_ID is 'Risk Group ID (PK)';
comment on column EMRS_D_RISK_GROUPS.MANAGED_CARE_PROGRAM is 'Managed Care Program';
comment on column EMRS_D_RISK_GROUPS.RISK_GROUP is 'Risk Group';
comment on column EMRS_D_RISK_GROUPS.RISK_GROUP_CODE is 'Risk Group Code';
comment on column EMRS_D_RISK_GROUPS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_RISK_GROUPS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_RISK_GROUPS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_RISK_GROUPS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_RISK_GROUPS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_RISK_GROUPS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_RISK_GROUPS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_SCHOOL_DISTRICTS'
create table EMRS_D_SCHOOL_DISTRICTS
 (SCHOOL_DISTRICT_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(30)
 ,REGION_NAME varchar2(30)
 ,COUNTY_NAME varchar2(30)
 ,DISTRICT_TYPE varchar2(20)
 ,DISTRICT_NAME varchar2(100)
 ,SCHOOL_NAME varchar2(50)
 ,SR_FIPS_COUNTY_NBR integer
 ,SR_REGION_ID integer
 ,SOURCE_RECORD_ID integer
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_SCHOOL_DISTRICTS.SCHOOL_DISTRICT_ID is 'School District ID (PK)';
comment on column EMRS_D_SCHOOL_DISTRICTS.MANAGED_CARE_PROGRAM is 'Managed Care Program';
comment on column EMRS_D_SCHOOL_DISTRICTS.REGION_NAME is 'Region Name';
comment on column EMRS_D_SCHOOL_DISTRICTS.COUNTY_NAME is 'County Name';
comment on column EMRS_D_SCHOOL_DISTRICTS.DISTRICT_TYPE is 'District Type';
comment on column EMRS_D_SCHOOL_DISTRICTS.DISTRICT_NAME is 'District Name';
comment on column EMRS_D_SCHOOL_DISTRICTS.SR_FIPS_COUNTY_NBR is 'Source-System County ID';
comment on column EMRS_D_SCHOOL_DISTRICTS.SR_REGION_ID is 'Source-System Region ID';
comment on column EMRS_D_SCHOOL_DISTRICTS.SOURCE_RECORD_ID is 'Source-System SCHID Record ID #';
comment on column EMRS_D_SCHOOL_DISTRICTS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_SCHOOL_DISTRICTS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_SCHOOL_DISTRICTS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_SCHOOL_DISTRICTS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_SCHOOL_DISTRICTS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_SCHOOL_DISTRICTS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_SCHOOL_DISTRICTS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_SUB_PROGRAMS'
create table EMRS_D_SUB_PROGRAMS
 (SUB_PROGRAM_ID integer not null
 ,SUB_PROGRAM_NAME varchar2(80) not null
 ,SUB_PROGRAM_CODE varchar2(5)
 ,PARENT_PROGRAM_ID number(30) not null
 ,PARENT_PROGRAM_NAME varchar2(100)
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_SUB_PROGRAMS.SUB_PROGRAM_ID is 'Sub Program ID (PK)';
comment on column EMRS_D_SUB_PROGRAMS.SUB_PROGRAM_NAME is 'Sub-Program Name';
comment on column EMRS_D_SUB_PROGRAMS.SUB_PROGRAM_CODE is 'Sub-Program Code';
comment on column EMRS_D_SUB_PROGRAMS.PARENT_PROGRAM_ID is 'Parent Program ID';
comment on column EMRS_D_SUB_PROGRAMS.PARENT_PROGRAM_NAME is 'Parent Program Name';
comment on column EMRS_D_SUB_PROGRAMS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_SUB_PROGRAMS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_SUB_PROGRAMS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_SUB_PROGRAMS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_SUB_PROGRAMS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_SUB_PROGRAMS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_SUB_PROGRAMS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_COMMUNICATION_TYPES'
create table EMRS_D_COMMUNICATION_TYPES
 (COMMUNICATION_TYPE_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(50)
 ,COMMUNICATION_TYPE_CODE varchar2(10)
 ,COMMUNICATION_TYPE_NAME varchar2(50) not null
 ,COMMUNICATION_TYPE_DESCRIPTION varchar2(300)
 ,SOURCE_RECORD_ID number default 0
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_COMMUNICATION_TYPES.COMMUNICATION_TYPE_ID is 'Communication Type ID (PK)';
comment on column EMRS_D_COMMUNICATION_TYPES.MANAGED_CARE_PROGRAM is 'Managed Care Program that Uses This Communication Type';
comment on column EMRS_D_COMMUNICATION_TYPES.COMMUNICATION_TYPE_CODE is 'Communication Type Code';
comment on column EMRS_D_COMMUNICATION_TYPES.COMMUNICATION_TYPE_NAME is 'Communication Type Name';
comment on column EMRS_D_COMMUNICATION_TYPES.COMMUNICATION_TYPE_DESCRIPTION is 'Communication Type Description';
comment on column EMRS_D_COMMUNICATION_TYPES.SOURCE_RECORD_ID is 'Source-System Primary-Key Record ID #';
comment on column EMRS_D_COMMUNICATION_TYPES.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_COMMUNICATION_TYPES.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_COMMUNICATION_TYPES.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_COMMUNICATION_TYPES.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_COMMUNICATION_TYPES.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_COMMUNICATION_TYPES.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_COMMUNICATION_TYPES.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_REJECTION_ERROR_REASONS'
create table EMRS_D_REJECTION_ERROR_REASONS
 (REJECTION_ERROR_REASON_ID integer not null
 ,MANAGED_CARE_PROGRAM varchar2(30) not null
 ,REJECTION_CATEGORY varchar2(30) not null
 ,RELATED_FILES varchar2(25) not null
 ,REJECTION_CODE varchar2(3)
 ,REJECTION_ERROR_REASON varchar2(25)
 ,REJECTION_ERROR_DESCRIPTION varchar2(1000)
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18) not null
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_REJECTION_ERROR_REASONS.REJECTION_ERROR_REASON_ID is 'Rejection Error Reason ID (PK)';
comment on column EMRS_D_REJECTION_ERROR_REASONS.MANAGED_CARE_PROGRAM is 'Managed Care Program';
comment on column EMRS_D_REJECTION_ERROR_REASONS.REJECTION_CATEGORY is 'Rejection Category (Department or System that Uses this Code)';
comment on column EMRS_D_REJECTION_ERROR_REASONS.RELATED_FILES is 'Rejection Error Reason applies to this related file(s)';
comment on column EMRS_D_REJECTION_ERROR_REASONS.REJECTION_CODE is 'Rejection Error Code';
comment on column EMRS_D_REJECTION_ERROR_REASONS.REJECTION_ERROR_REASON is 'Rejection Error Reason';
comment on column EMRS_D_REJECTION_ERROR_REASONS.REJECTION_ERROR_DESCRIPTION is 'Description or Definition for Rejection Error Reason';
comment on column EMRS_D_REJECTION_ERROR_REASONS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_REJECTION_ERROR_REASONS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_REJECTION_ERROR_REASONS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_REJECTION_ERROR_REASONS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_REJECTION_ERROR_REASONS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_REJECTION_ERROR_REASONS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_REJECTION_ERROR_REASONS.DATE_UPDATED is 'Warehouse Load Date Updated';

prompt Creating table 'EMRS_D_TIME_PERIODS'
create table EMRS_D_TIME_PERIODS
 (TIME_PERIOD_ID number not null
 ,HOUR_MINUTE varchar2(5) not null
 ,HOUR_MINUTE_MILITARY varchar2(5) not null
 ,MORNING_NOON_NIGHT varchar2(9) not null
 ,OPEN_LUNCH_CLOSE varchar2(16) not null
 ,HOUR varchar2(4) not null
 ,MINUTE number(2) not null
 ,SECOND number(2) not null
 ,MILITARY_HOUR varchar2(2) not null
 ,MILITARY_MINUTE varchar2(2) not null
 ,MILITARY_SECOND varchar2(2) not null
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,CREATED_BY varchar2(18)
 ,DATE_CREATED date
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;
 
comment on column EMRS_D_TIME_PERIODS.TIME_PERIOD_ID is 'Time Period ID (PK)';
comment on column EMRS_D_TIME_PERIODS.HOUR_MINUTE is 'Hour and Minutes (HH:MI)';
comment on column EMRS_D_TIME_PERIODS.HOUR_MINUTE_MILITARY is 'Military Hour and Minutes (HH24:MI)';
comment on column EMRS_D_TIME_PERIODS.MORNING_NOON_NIGHT is 'Morning (6am-11:30am), Afternoon (12-6:30pm), or Night (7pm-5:30am)';
comment on column EMRS_D_TIME_PERIODS.OPEN_LUNCH_CLOSE is 'Office Opening (7-9am), Lunch Hours (11am-1:30pm), or Business Closing Hours (4-6pm)';
comment on column EMRS_D_TIME_PERIODS.HOUR is 'Hours (12)';
comment on column EMRS_D_TIME_PERIODS.MINUTE is 'Minutes (59)';
comment on column EMRS_D_TIME_PERIODS.SECOND is 'Seconds (59)';
comment on column EMRS_D_TIME_PERIODS.MILITARY_HOUR is 'Military Hours (24)';
comment on column EMRS_D_TIME_PERIODS.MILITARY_MINUTE is 'Military Minutes (59)';
comment on column EMRS_D_TIME_PERIODS.MILITARY_SECOND is 'Military Seconds (59)';
comment on column EMRS_D_TIME_PERIODS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_TIME_PERIODS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_TIME_PERIODS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_TIME_PERIODS.CREATED_BY is 'Created By';
comment on column EMRS_D_TIME_PERIODS.DATE_CREATED is 'Date Created';
comment on column EMRS_D_TIME_PERIODS.UPDATED_BY is 'Updated By';
comment on column EMRS_D_TIME_PERIODS.DATE_UPDATED is 'Date Updated';

prompt Creating table 'EMRS_D_PROGRAMS'
create table EMRS_D_PROGRAMS
 (PROGRAM_ID integer default 0 not null
 ,MANAGED_CARE_PROGRAM varchar2(30) not null
 ,PROGRAM_CATEGORY varchar2(10) not null
 ,PROGRAM_CODE varchar2(7) not null
 ,PROGRAM_NAME varchar2(120) not null
 ,ACTIVE_INACTIVE varchar2(1) default'A'
 ,START_DATE date
 ,END_DATE date
 ,SOURCE_RECORD_ID number
 ,VERSION number(2,0)
 ,DATE_OF_VALIDITY_START date
 ,DATE_OF_VALIDITY_END date
 ,DATE_CREATED date
 ,CREATED_BY varchar2(18) not null
 ,UPDATED_BY varchar2(18)
 ,DATE_UPDATED date
 )
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_DATA parallel;

comment on column EMRS_D_PROGRAMS.PROGRAM_ID is 'Program Type ID (PK)';
comment on column EMRS_D_PROGRAMS.MANAGED_CARE_PROGRAM is 'Managed Care Program that Uses this Program';
comment on column EMRS_D_PROGRAMS.PROGRAM_CATEGORY is 'Program Category';
comment on column EMRS_D_PROGRAMS.PROGRAM_CODE is 'Program Type Code';
comment on column EMRS_D_PROGRAMS.PROGRAM_NAME is 'Program Type';
comment on column EMRS_D_PROGRAMS.ACTIVE_INACTIVE is 'Program Type is Active or Inactive (A;I)';
comment on column EMRS_D_PROGRAMS.START_DATE is 'Program Start Date';
comment on column EMRS_D_PROGRAMS.END_DATE is 'Program End Date';
comment on column EMRS_D_PROGRAMS.SOURCE_RECORD_ID is 'Source-System Primary-Key Record ID #';
comment on column EMRS_D_PROGRAMS.VERSION is 'Type-2 SCD Version Number';
comment on column EMRS_D_PROGRAMS.DATE_OF_VALIDITY_START is 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_PROGRAMS.DATE_OF_VALIDITY_END is 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
comment on column EMRS_D_PROGRAMS.DATE_CREATED is 'Warehouse Load Creation Date';
comment on column EMRS_D_PROGRAMS.CREATED_BY is 'Warehouse Load Created By';
comment on column EMRS_D_PROGRAMS.UPDATED_BY is 'Warehouse Load Updated By';
comment on column EMRS_D_PROGRAMS.DATE_UPDATED is 'Warehouse Load Date Updated';


prompt Creating index 'ENROLL_RISKGRP_FK_I'
create index ENROLL_RISKGRP_FK_I on EMRS_F_ENROLLMENTS
 (RISK_GROUP_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_REJERR_FK_I'
create index ENROLL_REJERR_FK_I on EMRS_F_ENROLLMENTS
 (REJECTION_ERROR_REASON_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_CNTY_FK_I'
create index ENROLL_CNTY_FK_I on EMRS_F_ENROLLMENTS
 (COUNTY_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_LANG_FK_I'
create index ENROLL_LANG_FK_I on EMRS_F_ENROLLMENTS
 (LANGUAGE_CODE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_COMMTYP_FK_I'
create index ENROLL_COMMTYP_FK_I on EMRS_F_ENROLLMENTS
 (COMMUNICATION_TYPE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_CHGREASON_FK_I'
create index ENROLL_CHGREASON_FK_I on EMRS_F_ENROLLMENTS
 (CHANGE_REASON_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_ENRLASTAT_FK_I'
create index ENROLL_ENRLASTAT_FK_I on EMRS_F_ENROLLMENTS
 (ENROLLMENT_ACTION_STATUS_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_TIMEPERI_FK_I'
create index ENROLL_TIMEPERI_FK_I on EMRS_F_ENROLLMENTS
 (TIME_PERIOD_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_DATEPERIOD_FK_I'
create index ENROLL_DATEPERIOD_FK_I on EMRS_F_ENROLLMENTS
 (DATE_PERIOD_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_CLIENT_FK_I'
create index ENROLL_CLIENT_FK_I on EMRS_F_ENROLLMENTS
 (CLIENT_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_PROVIDRS_FK_I'
create index ENROLL_PROVIDRS_FK_I on EMRS_F_ENROLLMENTS
 (PROVIDER_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_PRVIDRTYP_FK_I'
create index ENROLL_PRVIDRTYP_FK_I on EMRS_F_ENROLLMENTS
 (PROVIDER_TYPE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_TERMREAS_FK_I'
create index ENROLL_TERMREAS_FK_I on EMRS_F_ENROLLMENTS
 (TERM_REASON_CODE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_FPL_FK_I'
create index ENROLL_FPL_FK_I on EMRS_F_ENROLLMENTS
 (FPL_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_CASES_FK_I'
create index ENROLL_CASES_FK_I on EMRS_F_ENROLLMENTS
 (CASE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_PLAN_FK_I'
create index ENROLL_PLAN_FK_I on EMRS_F_ENROLLMENTS
 (PLAN_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_SUBPROG_FK_I'
create index ENROLL_SUBPROG_FK_I on EMRS_F_ENROLLMENTS
 (SUB_PROGRAM_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_COVGCAT_FK_I'
create index ENROLL_COVGCAT_FK_I on EMRS_F_ENROLLMENTS
 (COVERAGE_CATEGORY_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_PROGTYPE_FK_I'
create index ENROLL_PROGTYPE_FK_I on EMRS_F_ENROLLMENTS
 (PROGRAM_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_CSDA_FK_I'
create index ENROLL_CSDA_FK_I on EMRS_F_ENROLLMENTS
 (CSDA_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_STATNGRP_FK_I'
create index ENROLL_STATNGRP_FK_I on EMRS_F_ENROLLMENTS
 (STAT_IN_GRP_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ENROLL_RACE_FK_I'
create index ENROLL_RACE_FK_I on EMRS_F_ENROLLMENTS
 (RACE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'OUTSELTRG_SCHODIST_FK_I'
create index OUTSELTRG_SCHODIST_FK_I on EMRS_F_ORCH_SELECTED_TARGETS
 (SCHOOL_DISTRICT_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'OUTSELTRG_TARGACTV_FK_I'
create index OUTSELTRG_TARGACTV_FK_I on EMRS_F_ORCH_SELECTED_TARGETS
 (TARGET_ACTIVITY_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'OUTSELTRG_HEADGRNTEE_FK_I'
create index OUTSELTRG_HEADGRNTEE_FK_I on EMRS_F_ORCH_SELECTED_TARGETS
 (HEADSTART_GRANTEE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'OUTSELTRG_CSDA_FK_I'
create index OUTSELTRG_CSDA_FK_I on EMRS_F_ORCH_SELECTED_TARGETS
 (CSDA_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'OUTSELTRG_CNTY_FK_I'
create index OUTSELTRG_CNTY_FK_I on EMRS_F_ORCH_SELECTED_TARGETS
 (COUNTY_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'OUTSELTRG_ACTNTYP_FK_I'
create index OUTSELTRG_ACTNTYP_FK_I on EMRS_F_ORCH_SELECTED_TARGETS
 (ACTION_TYPE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'OUTSELTRG_TARGGRP_FK_I'
create index OUTSELTRG_TARGGRP_FK_I on EMRS_F_ORCH_SELECTED_TARGETS
 (TARGET_GROUP_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'OUTSELTRG_TARGRPTYP_FK_I'
create index OUTSELTRG_TARGRPTYP_FK_I on EMRS_F_ORCH_SELECTED_TARGETS
 (TARGET_GROUP_TYPE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ORCHEVENT_STAFF_FK_I'
create index ORCHEVENT_STAFF_FK_I on EMRS_F_OUTREACH_EVENTS
 (STAFF_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ORCHEVENT_LANG_FK_I'
create index ORCHEVENT_LANG_FK_I on EMRS_F_OUTREACH_EVENTS
 (LANGUAGE_CODE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ORCHEVENT_COMMTYP_FK_I'
create index ORCHEVENT_COMMTYP_FK_I on EMRS_F_OUTREACH_EVENTS
 (COMMUNICATION_TYPE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ORCHEVENT_ORCHACTV_FK_I'
create index ORCHEVENT_ORCHACTV_FK_I on EMRS_F_OUTREACH_EVENTS
 (ACTIVITY_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'ORCHEVENT_DATEPERIOD_FK_I'
create index ORCHEVENT_DATEPERIOD_FK_I on EMRS_F_OUTREACH_EVENTS
 (DATE_PERIOD_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'COMMU_CNTY_FK_I'
create index COMMU_CNTY_FK_I on EMRS_F_COMMUNICATIONS
 (COUNTY_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'COMMU_DATEPERIOD_FK_I'
create index COMMU_DATEPERIOD_FK_I on EMRS_F_COMMUNICATIONS
 (DATE_PERIOD_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'COMMU_COMMSTAT_FK_I'
create index COMMU_COMMSTAT_FK_I on EMRS_F_COMMUNICATIONS
 (COMMUNICATION_STATUS_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'COMMU_COMMTYP_FK_I'
create index COMMU_COMMTYP_FK_I on EMRS_F_COMMUNICATIONS
 (COMMUNICATION_TYPE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'COMMU_COMMACTN_FK_I'
create index COMMU_COMMACTN_FK_I on EMRS_F_COMMUNICATIONS
 (COMMUNICATION_ACTION_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'COMMU_STAFF_FK_I'
create index COMMU_STAFF_FK_I on EMRS_F_COMMUNICATIONS
 (STAFF_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'COMMU_CONTACTYP_FK_I'
create index COMMU_CONTACTYP_FK_I on EMRS_F_COMMUNICATIONS
 (CONTACT_TYPE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'COMMU_BIZCHANL_FK_I'
create index COMMU_BIZCHANL_FK_I on EMRS_F_COMMUNICATIONS
 (BIZCHANL_CHANNEL_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'COMMU_TIMEPERI_FK_I'
create index COMMU_TIMEPERI_FK_I on EMRS_F_COMMUNICATIONS
 (TIME_PERIOD_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'COMMU_LANG_FK_I'
create index COMMU_LANG_FK_I on EMRS_F_COMMUNICATIONS
 (LANGUAGE_CODE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'COMMU_PROGTYPE_FK_I'
create index COMMU_PROGTYPE_FK_I on EMRS_F_COMMUNICATIONS
 (PROGRAM_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'COMMU_CASES_FK_I'
create index COMMU_CASES_FK_I on EMRS_F_COMMUNICATIONS
 (CASE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'COMMU_CLIENT_FK_I'
create index COMMU_CLIENT_FK_I on EMRS_F_COMMUNICATIONS
 (CLIENT_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'NOTE_TIMEPERI_FK_I'
create index NOTE_TIMEPERI_FK_I on EMRS_F_NOTES
 (TIME_PERIOD_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'NOTE_COMMACTN_FK_I'
create index NOTE_COMMACTN_FK_I on EMRS_F_NOTES
 (COMMUNICATION_ACTION_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'NOTE_STAFF_FK_I'
create index NOTE_STAFF_FK_I on EMRS_F_NOTES
 (STAFF_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'NOTE_CNTY_FK_I'
create index NOTE_CNTY_FK_I on EMRS_F_NOTES
 (COUNTY_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'NOTE_PROGTYPE_FK_I'
create index NOTE_PROGTYPE_FK_I on EMRS_F_NOTES
 (PROGRAM_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'NOTE_LANG_FK_I'
create index NOTE_LANG_FK_I on EMRS_F_NOTES
 (LANGUAGE_CODE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'NOTE_CONTACTYP_FK_I'
create index NOTE_CONTACTYP_FK_I on EMRS_F_NOTES
 (CONTACT_TYPE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'NOTE_CASES_FK_I'
create index NOTE_CASES_FK_I on EMRS_F_NOTES
 (CASE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'NOTE_CLIENT_FK_I'
create index NOTE_CLIENT_FK_I on EMRS_F_NOTES
 (CLIENT_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'NOTE_DATEPERIOD_FK_I'
create index NOTE_DATEPERIOD_FK_I on EMRS_F_NOTES
 (DATE_PERIOD_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'NOTE_COMMTYP_FK_I'
create index NOTE_COMMTYP_FK_I on EMRS_F_NOTES
 (COMMUNICATION_TYPE_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'NOTE_BIZCHANL_FK_I'
create index NOTE_BIZCHANL_FK_I on EMRS_F_NOTES
 (BIZCHANL_CHANNEL_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

prompt Creating index 'NOTE_COMMSTAT_FK_I'
create index NOTE_COMMSTAT_FK_I on EMRS_F_NOTES
 (COMMUNICATION_STATUS_ID)
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX;

  
prompt Creating primary key on 'EMRS_D_PROVIDER_TYPES'
alter table EMRS_D_PROVIDER_TYPES
 add (constraint PRVIDRTYP_PK primary key 
  (PROVIDER_TYPE_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_TERMINATION_REASONS'
alter table EMRS_D_TERMINATION_REASONS
 add (constraint TERMREAS_PK primary key 
  (TERM_REASON_CODE_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_STATUS_IN_GROUPS'
alter table EMRS_D_STATUS_IN_GROUPS
 add (constraint STATNGRP_PK primary key 
  (STATUS_IN_GROUP_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_STAFF_PEOPLE'
alter table EMRS_D_STAFF_PEOPLE
 add (constraint STAFF_PK primary key 
  (STAFF_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_LANGUAGES'
alter table EMRS_D_LANGUAGES
 add (constraint LANG_PK primary key 
  (LANGUAGE_CODE_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_COUNTIES'
alter table EMRS_D_COUNTIES
 add (constraint CNTY_PK primary key 
  (COUNTY_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_DATE_PERIODS'
alter table EMRS_D_DATE_PERIODS
 add (constraint datePERIOD_PK primary key 
  (DATE_PERIOD_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_PLANS'
alter table EMRS_D_PLANS
 add (constraint PLAN_PK primary key 
  (PLAN_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_CLIENTS'
alter table EMRS_D_CLIENTS
 add (constraint CLIENT_PK primary key 
  (CLIENT_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_TARGET_GROUP_TYPES'
alter table EMRS_D_TARGET_GROUP_TYPES
 add (constraint TARGRPTYP_PK primary key 
  (TARGET_GROUP_TYPE_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_BUSINESS_CHANNELS'
alter table EMRS_D_BUSINESS_CHANNELS
 add (constraint BIZCHANL_PK primary key 
  (CHANNEL_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_FEDERAL_POVERTY_LEVELS'
alter table EMRS_D_FEDERAL_POVERTY_LEVELS
 add (constraint FPL_PK primary key 
  (FPL_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_COVERAGE_CATEGORIES'
alter table EMRS_D_COVERAGE_CATEGORIES
 add (constraint COVGCAT_PK primary key 
  (COVERAGE_CATEGORY_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS
 add (constraint ENROLL_PK primary key 
  (ENROLLMENT_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_F_ORCH_SELECTED_TARGETS'
alter table EMRS_F_ORCH_SELECTED_TARGETS
 add (constraint OUTSELTRG_PK primary key 
  (OUTREACH_SELECTED_TARGET_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_HEADSTART_GRANTEES'
alter table EMRS_D_HEADSTART_GRANTEES
 add (constraint HEADGRNTEE_PK primary key 
  (HEADSTART_GRANTEE_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_F_OUTREACH_EVENTS'
alter table EMRS_F_OUTREACH_EVENTS
 add (constraint ORCHEVENT_PK primary key 
  (OUTREACH_EVENT_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_S_OUTREACH_FACTS'
alter table EMRS_S_OUTREACH_FACTS
 add (constraint OUTFAC_PK primary key 
  (ACTIVITY_DATE
  ,ACTIVITY_ID
  ,ST_CNTY_NUM
  ,OBSERVATION_ID
  ,SRC_STAFF_ID
  ,ACTIVITY_ACTION_TYPE_ID
  ,COMM_TYPE_ID
  ,LANG_ID
  ,REGION_ID
  ,TIME_PERIOD_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_CHANGE_REASONS'
alter table EMRS_D_CHANGE_REASONS
 add (constraint CHGREASON_PK primary key 
  (CHANGE_REASON_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_ENROLLMENT_ACTION_STATU'
alter table EMRS_D_ENROLLMENT_ACTION_STATU
 add (constraint ENRLASTAT_PK primary key 
  (ENROLLMENT_ACTION_STATUS_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_TARGET_GROUPS'
alter table EMRS_D_TARGET_GROUPS
 add (constraint TARGGRP_PK primary key 
  (TARGET_GROUP_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_OUTREACH_ACTIVITIES'
alter table EMRS_D_OUTREACH_ACTIVITIES
 add (constraint ORCHACTV_PK primary key 
  (ACTIVITY_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_COMMUNICATION_STATUS'
alter table EMRS_D_COMMUNICATION_STATUS
 add (constraint COMMSTAT_PK primary key 
  (COMMUNICATION_STATUS_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_CARE_SERV_DELIV_AREAS'
alter table EMRS_D_CARE_SERV_DELIV_AREAS
 add (constraint CSDA_PK primary key 
  (CSDA_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_S_HEADSTART_GRANT_CENTERS'
alter table EMRS_S_HEADSTART_GRANT_CENTERS
 add (constraint HDSTRCEN_PK primary key 
  (SOURCE_RECORD_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_ACTION_TYPES'
alter table EMRS_D_ACTION_TYPES
 add (constraint ACTNTYP_PK primary key 
  (ACTION_TYPE_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_OTHER_CHIP_CODES'
alter table EMRS_D_OTHER_CHIP_CODES
 add (constraint OTHERCHIP_PK primary key 
  (OTHER_CHIP_CODE_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_RACES'
alter table EMRS_D_RACES
 add (constraint RACE_PK primary key 
  (RACE_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_F_COMMUNICATIONS'
alter table EMRS_F_COMMUNICATIONS
 add (constraint COMMU_PK primary key 
  (COMMUNICATION_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_F_NOTES'
alter table EMRS_F_NOTES
 add (constraint NOTE_PK primary key 
  (NOTE_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_CONTACT_TYPES'
alter table EMRS_D_CONTACT_TYPES
 add (constraint CONTACTYP_PK primary key 
  (CONTACT_TYPE_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_CASES'
alter table EMRS_D_CASES
 add (constraint CASES_PK primary key 
  (CASE_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_COMMUNICATION_ACTIONS'
alter table EMRS_D_COMMUNICATION_ACTIONS
 add (constraint COMMACTN_PK primary key 
  (COMMUNICATION_ACTION_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_PROVIDERS'
alter table EMRS_D_PROVIDERS
 add (constraint PROVIDRS_PK primary key 
  (PROVIDER_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_TARGET_ACTIVITIES'
alter table EMRS_D_TARGET_ACTIVITIES
 add (constraint TARGACTV_PK primary key 
  (TARGET_ACTIVITY_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_PROVIDER_SPECIALTY_CODE'
alter table EMRS_D_PROVIDER_SPECIALTY_CODE
 add (constraint PRVSPCOD_PK primary key 
  (PROVIDER_SPECIALTY_CODE_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_RISK_GROUPS'
alter table EMRS_D_RISK_GROUPS
 add (constraint RISKGRP_PK primary key 
  (RISK_GROUP_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_SCHOOL_DISTRICTS'
alter table EMRS_D_SCHOOL_DISTRICTS
 add (constraint SCHODIST_PK primary key 
  (SCHOOL_DISTRICT_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_SUB_PROGRAMS'
alter table EMRS_D_SUB_PROGRAMS
 add (constraint SUBPROG_PK primary key 
  (SUB_PROGRAM_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_COMMUNICATION_TYPES'
alter table EMRS_D_COMMUNICATION_TYPES
 add (constraint COMMTYP_PK primary key 
  (COMMUNICATION_TYPE_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_REJECTION_ERROR_REASONS'
alter table EMRS_D_REJECTION_ERROR_REASONS
 add (constraint REJERR_PK primary key 
  (REJECTION_ERROR_REASON_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_TIME_PERIODS'
alter table EMRS_D_TIME_PERIODS
 add (constraint TIMEPERI_PK primary key 
  (TIME_PERIOD_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating primary key on 'EMRS_D_PROGRAMS'
alter table EMRS_D_PROGRAMS
 add (constraint PROGTYPE_PK primary key 
  (PROGRAM_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);


prompt Creating unique key on 'EMRS_D_PROVIDER_TYPES'
alter table EMRS_D_PROVIDER_TYPES
 add (constraint PRVIDRTYP_CODE_UK unique 
  (PROVIDER_CODE)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_PROVIDER_TYPES'
alter table EMRS_D_PROVIDER_TYPES
 add (constraint PRVIDRTYP_NAME_UK unique 
  (PROVIDER_NAME)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_TERMINATION_REASONS'
alter table EMRS_D_TERMINATION_REASONS
 add (constraint TERMREAS_PLANCODE_UK unique 
  (PLAN_NAME
  ,REASON_CODE)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_STATUS_IN_GROUPS'
alter table EMRS_D_STATUS_IN_GROUPS
 add (constraint STATNGRP_CATCODE_UK unique 
  (STATUS_IN_GROUP_CATEGORY
  ,STATUS_IN_GROUP_CODE)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_STATUS_IN_GROUPS'
alter table EMRS_D_STATUS_IN_GROUPS
 add (constraint STATNGRP_CAT_UK unique 
  (STATUS_IN_GROUP_CATEGORY)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_STATUS_IN_GROUPS'
alter table EMRS_D_STATUS_IN_GROUPS
 add (constraint STATNGRP_GRP_UK unique 
  (STATUS_IN_GROUP)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_LANGUAGES'
alter table EMRS_D_LANGUAGES
 add (constraint LANG_LANG_COMB_UK unique 
  (MANAGED_CARE_PROGRAM
  ,LANGUAGE_CODE
  ,LANGUAGE));

prompt Creating unique key on 'EMRS_D_COUNTIES'
alter table EMRS_D_COUNTIES
 add (constraint CNTY_CNTY_COMB_UK unique 
  (STATE
  ,COUNTY_CODE
  ,COUNTY_NAME));

prompt Creating unique key on 'EMRS_D_PLANS'
alter table EMRS_D_PLANS
 add (constraint PLAN_PLAN_COMB_UK unique 
  (PLAN_CODE
  ,MANAGED_CARE_PROGRAM
  ,PLAN_NAME)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_CLIENTS'
alter table EMRS_D_CLIENTS
 add (constraint CLIENT_CLI_COMB_UK unique 
  (MANAGED_CARE_CANDIDATE
  ,SOCIAL_SECURITY_NUMBER)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_TARGET_GROUP_TYPES'
alter table EMRS_D_TARGET_GROUP_TYPES
 add (constraint TARGRPTYP_GROUP_KEY_UK unique 
  (TARGET_GROUP_TYPE_CODE
  ,SOURCE_RECORD_ID
  ,TARGET_GROUP_TYPE_CATEGORY
  ,TARGET_GROUP_TYPE_NAME
  ,MANAGED_CARE_PROGRAM)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_FEDERAL_POVERTY_LEVELS'
alter table EMRS_D_FEDERAL_POVERTY_LEVELS
 add (constraint FPL_YRLONU_UK unique 
  (FPL_YEAR
  ,FPL_NUMBER_IN_FAMILY
  ,FPL_LOCALE)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_COVERAGE_CATEGORIES'
alter table EMRS_D_COVERAGE_CATEGORIES
 add (constraint COVGCAT_CODETYPE_UK unique 
  (COVERAGE_CATEGORY_CODE
  ,COVERAGE_CATEGORY_TYPE)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_F_ORCH_SELECTED_TARGETS'
alter table EMRS_F_ORCH_SELECTED_TARGETS
 add (constraint OUTSELTRG_ORCH_SEL_TGT_UK unique 
  (TARGET_ACTIVITY_ID
  ,TARGET_GROUP_ID
  ,TARGET_GROUP_TYPE_ID
  ,SCHOOL_DISTRICT_ID
  ,COUNTY_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_F_OUTREACH_EVENTS'
alter table EMRS_F_OUTREACH_EVENTS
 add (constraint ORCHEVENT_ORCH_EVENTS_UK unique 
  (LANGUAGE_CODE_ID
  ,DATE_PERIOD_ID
  ,COMMUNICATION_TYPE_ID
  ,ACTIVITY_ID
  ,STAFF_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_CHANGE_REASONS'
alter table EMRS_D_CHANGE_REASONS
 add (constraint CHGREASON_CODE_UK unique 
  (CHANGE_REASON_CODE)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_CHANGE_REASONS'
alter table EMRS_D_CHANGE_REASONS
 add (constraint CHGREASON_REASON_UK unique 
  (CHANGE_REASON)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_CHANGE_REASONS'
alter table EMRS_D_CHANGE_REASONS
 add (constraint CHGREASON_PLAN_REASON_UK unique 
  (CHANGE_REASON_CODE_PLAN
  ,CHANGE_REASON_CODE)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_COMMUNICATION_STATUS'
alter table EMRS_D_COMMUNICATION_STATUS
 add (constraint COMMSTAT_COMMSTAT_COMB_UK unique 
  (MANAGED_CARE_PROGRAM
  ,COMMUNICATION_STATUS_CODE
  ,COMMUNICATION_STATUS_NAME)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_CARE_SERV_DELIV_AREAS'
alter table EMRS_D_CARE_SERV_DELIV_AREAS
 add (constraint CSDA_CSDA_COMB_UK unique 
  (MANAGED_CARE_PROGRAM
  ,SOURCE_RECORD_ID
  ,REGION_NUMBER_CATEGORY
  ,CSDA_CODE
  ,CSDA_NAME)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_OTHER_CHIP_CODES'
alter table EMRS_D_OTHER_CHIP_CODES
 add (constraint OTHERCHIP_CODE_UK unique 
  (OTHER_CHIP_CODE)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_OTHER_CHIP_CODES'
alter table EMRS_D_OTHER_CHIP_CODES
 add (constraint OTHERCHIP_TYPE_UK unique 
  (OTHER_CHIP_CODE_TYPE)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_RACES'
alter table EMRS_D_RACES
 add (constraint RACE_RACE_COMB_UK unique 
  (MANAGED_CARE_PROGRAM
  ,RACE_CODE)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_COMMUNICATION_ACTIONS'
alter table EMRS_D_COMMUNICATION_ACTIONS
 add (constraint COMMACTN_PROG_NAME_UK unique 
  (MANAGED_CARE_PROGRAM
  ,COMMUNICATION_ACTION_NAME)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_PROVIDER_SPECIALTY_CODE'
alter table EMRS_D_PROVIDER_SPECIALTY_CODE
 add (constraint PRVSPCOD_PROVIDER_SPECIALTY_UK unique 
  (PROVIDER_SPECIALTY)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_PROVIDER_SPECIALTY_CODE'
alter table EMRS_D_PROVIDER_SPECIALTY_CODE
 add (constraint PRVSPCOD_SPECIALTY_CODE_UK unique 
  (PROVIDER_SPECIALTY_CODE)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_RISK_GROUPS'
alter table EMRS_D_RISK_GROUPS
 add (constraint RISKGRP_CODE_UK unique 
  (RISK_GROUP_CODE)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_RISK_GROUPS'
alter table EMRS_D_RISK_GROUPS
 add (constraint RISKGRP_GROUP_UK unique 
  (RISK_GROUP)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_SCHOOL_DISTRICTS'
alter table EMRS_D_SCHOOL_DISTRICTS
 add (constraint SCHODIST_SCHODIST_COMB_UK unique 
  (MANAGED_CARE_PROGRAM
  ,SOURCE_RECORD_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_SUB_PROGRAMS'
alter table EMRS_D_SUB_PROGRAMS
 add (constraint SUBPROG_SUBPROG_COMB_UK unique 
  (SUB_PROGRAM_CODE
  ,PARENT_PROGRAM_ID)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_COMMUNICATION_TYPES'
alter table EMRS_D_COMMUNICATION_TYPES
 add (constraint COMMTYP_CODEASSOC_UK unique 
  (MANAGED_CARE_PROGRAM
  ,SOURCE_RECORD_ID
  ,COMMUNICATION_TYPE_CODE
  ,COMMUNICATION_TYPE_NAME)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_REJECTION_ERROR_REASONS'
alter table EMRS_D_REJECTION_ERROR_REASONS
 add (constraint REJERR_REASON_UK unique 
  (MANAGED_CARE_PROGRAM
  ,RELATED_FILES
  ,REJECTION_CODE)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);

prompt Creating unique key on 'EMRS_D_PROGRAMS'
alter table EMRS_D_PROGRAMS
 add (constraint PROGTYPE_TYPOFPROG_COMB_UK unique 
  (MANAGED_CARE_PROGRAM
  ,PROGRAM_CODE
  ,PROGRAM_NAME)
 using index 
 pctfree 10
 storage
 (
   initial 100K
   next 2K
   pctincrease 0
 ) tablespace EMRS_INDX);
                                          

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_CSDA_FK foreign key 
  (CSDA_ID) references EMRS_D_CARE_SERV_DELIV_AREAS
  (CSDA_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_DATEPERIOD_FK foreign key 
  (DATE_PERIOD_ID) references EMRS_D_DATE_PERIODS
  (DATE_PERIOD_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_STATNGRP_FK foreign key 
  (STAT_IN_GRP_ID) references EMRS_D_STATUS_IN_GROUPS
  (STATUS_IN_GROUP_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_CASES_FK foreign key 
  (CASE_ID) references EMRS_D_CASES
  (CASE_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_PROGTYPE_FK foreign key 
  (PROGRAM_ID) references EMRS_D_PROGRAMS
  (PROGRAM_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_RACE_FK foreign key 
  (RACE_ID) references EMRS_D_RACES
  (RACE_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_TIMEPERI_FK foreign key 
  (TIME_PERIOD_ID) references EMRS_D_TIME_PERIODS
  (TIME_PERIOD_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_CNTY_FK foreign key 
  (COUNTY_ID) references EMRS_D_COUNTIES
  (COUNTY_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_CLIENT_FK foreign key 
  (CLIENT_ID) references EMRS_D_CLIENTS
  (CLIENT_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_LANG_FK foreign key 
  (LANGUAGE_CODE_ID) references EMRS_D_LANGUAGES
  (LANGUAGE_CODE_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_TERMREAS_FK foreign key 
  (TERM_REASON_CODE_ID) references EMRS_D_TERMINATION_REASONS
  (TERM_REASON_CODE_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_PRVIDRTYP_FK foreign key 
  (PROVIDER_TYPE_ID) references EMRS_D_PROVIDER_TYPES
  (PROVIDER_TYPE_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_PLAN_FK foreign key 
  (PLAN_ID) references EMRS_D_PLANS
  (PLAN_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_COMMTYP_FK foreign key 
  (COMMUNICATION_TYPE_ID) references EMRS_D_COMMUNICATION_TYPES
  (COMMUNICATION_TYPE_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_RISKGRP_FK foreign key 
  (RISK_GROUP_ID) references EMRS_D_RISK_GROUPS
  (RISK_GROUP_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_SUBPROG_FK foreign key 
  (SUB_PROGRAM_ID) references EMRS_D_SUB_PROGRAMS
  (SUB_PROGRAM_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_ENRLASTAT_FK foreign key 
  (ENROLLMENT_ACTION_STATUS_ID) references EMRS_D_ENROLLMENT_ACTION_STATU
  (ENROLLMENT_ACTION_STATUS_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_PROVIDRS_FK foreign key 
  (PROVIDER_ID) references EMRS_D_PROVIDERS
  (PROVIDER_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_REJERR_FK foreign key 
  (REJECTION_ERROR_REASON_ID) references EMRS_D_REJECTION_ERROR_REASONS
  (REJECTION_ERROR_REASON_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_CHGREASON_FK foreign key 
  (CHANGE_REASON_ID) references EMRS_D_CHANGE_REASONS
  (CHANGE_REASON_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_COVGCAT_FK foreign key 
  (COVERAGE_CATEGORY_ID) references EMRS_D_COVERAGE_CATEGORIES
  (COVERAGE_CATEGORY_ID));

prompt Creating foreign key on 'EMRS_F_ENROLLMENTS'
alter table EMRS_F_ENROLLMENTS add (constraint
 ENROLL_FPL_FK foreign key 
  (FPL_ID) references EMRS_D_FEDERAL_POVERTY_LEVELS
  (FPL_ID));

prompt Creating foreign key on 'EMRS_F_ORCH_SELECTED_TARGETS'
alter table EMRS_F_ORCH_SELECTED_TARGETS add (constraint
 OUTSELTRG_SCHODIST_FK foreign key 
  (SCHOOL_DISTRICT_ID) references EMRS_D_SCHOOL_DISTRICTS
  (SCHOOL_DISTRICT_ID));

prompt Creating foreign key on 'EMRS_F_ORCH_SELECTED_TARGETS'
alter table EMRS_F_ORCH_SELECTED_TARGETS add (constraint
 OUTSELTRG_TARGRPTYP_FK foreign key 
  (TARGET_GROUP_TYPE_ID) references EMRS_D_TARGET_GROUP_TYPES
  (TARGET_GROUP_TYPE_ID));

prompt Creating foreign key on 'EMRS_F_ORCH_SELECTED_TARGETS'
alter table EMRS_F_ORCH_SELECTED_TARGETS add (constraint
 OUTSELTRG_HEADGRNTEE_FK foreign key 
  (HEADSTART_GRANTEE_ID) references EMRS_D_HEADSTART_GRANTEES
  (HEADSTART_GRANTEE_ID));

prompt Creating foreign key on 'EMRS_F_ORCH_SELECTED_TARGETS'
alter table EMRS_F_ORCH_SELECTED_TARGETS add (constraint
 OUTSELTRG_CNTY_FK foreign key 
  (COUNTY_ID) references EMRS_D_COUNTIES
  (COUNTY_ID));

prompt Creating foreign key on 'EMRS_F_ORCH_SELECTED_TARGETS'
alter table EMRS_F_ORCH_SELECTED_TARGETS add (constraint
 OUTSELTRG_TARGACTV_FK foreign key 
  (TARGET_ACTIVITY_ID) references EMRS_D_TARGET_ACTIVITIES
  (TARGET_ACTIVITY_ID));

prompt Creating foreign key on 'EMRS_F_ORCH_SELECTED_TARGETS'
alter table EMRS_F_ORCH_SELECTED_TARGETS add (constraint
 OUTSELTRG_TARGGRP_FK foreign key 
  (TARGET_GROUP_ID) references EMRS_D_TARGET_GROUPS
  (TARGET_GROUP_ID));

prompt Creating foreign key on 'EMRS_F_ORCH_SELECTED_TARGETS'
alter table EMRS_F_ORCH_SELECTED_TARGETS add (constraint
 OUTSELTRG_CSDA_FK foreign key 
  (CSDA_ID) references EMRS_D_CARE_SERV_DELIV_AREAS
  (CSDA_ID));

prompt Creating foreign key on 'EMRS_F_ORCH_SELECTED_TARGETS'
alter table EMRS_F_ORCH_SELECTED_TARGETS add (constraint
 OUTSELTRG_ACTNTYP_FK foreign key 
  (ACTION_TYPE_ID) references EMRS_D_ACTION_TYPES
  (ACTION_TYPE_ID));

prompt Creating foreign key on 'EMRS_F_OUTREACH_EVENTS'
alter table EMRS_F_OUTREACH_EVENTS add (constraint
 ORCHEVENT_COMMTYP_FK foreign key 
  (COMMUNICATION_TYPE_ID) references EMRS_D_COMMUNICATION_TYPES
  (COMMUNICATION_TYPE_ID));

prompt Creating foreign key on 'EMRS_F_OUTREACH_EVENTS'
alter table EMRS_F_OUTREACH_EVENTS add (constraint
 ORCHEVENT_LANG_FK foreign key 
  (LANGUAGE_CODE_ID) references EMRS_D_LANGUAGES
  (LANGUAGE_CODE_ID));

prompt Creating foreign key on 'EMRS_F_OUTREACH_EVENTS'
alter table EMRS_F_OUTREACH_EVENTS add (constraint
 ORCHEVENT_ORCHACTV_FK foreign key 
  (ACTIVITY_ID) references EMRS_D_OUTREACH_ACTIVITIES
  (ACTIVITY_ID));

prompt Creating foreign key on 'EMRS_F_OUTREACH_EVENTS'
alter table EMRS_F_OUTREACH_EVENTS add (constraint
 ORCHEVENT_STAFF_FK foreign key 
  (STAFF_ID) references EMRS_D_STAFF_PEOPLE
  (STAFF_ID));

prompt Creating foreign key on 'EMRS_F_OUTREACH_EVENTS'
alter table EMRS_F_OUTREACH_EVENTS add (constraint
 ORCHEVENT_DATEPERIOD_FK foreign key 
  (DATE_PERIOD_ID) references EMRS_D_DATE_PERIODS
  (DATE_PERIOD_ID));

prompt Creating foreign key on 'EMRS_F_COMMUNICATIONS'
alter table EMRS_F_COMMUNICATIONS add (constraint
 COMMU_COMMSTAT_FK foreign key 
  (COMMUNICATION_STATUS_ID) references EMRS_D_COMMUNICATION_STATUS
  (COMMUNICATION_STATUS_ID));

prompt Creating foreign key on 'EMRS_F_COMMUNICATIONS'
alter table EMRS_F_COMMUNICATIONS add (constraint
 COMMU_PROGTYPE_FK foreign key 
  (PROGRAM_ID) references EMRS_D_PROGRAMS
  (PROGRAM_ID));

prompt Creating foreign key on 'EMRS_F_COMMUNICATIONS'
alter table EMRS_F_COMMUNICATIONS add (constraint
 COMMU_CLIENT_FK foreign key 
  (CLIENT_ID) references EMRS_D_CLIENTS
  (CLIENT_ID));

prompt Creating foreign key on 'EMRS_F_COMMUNICATIONS'
alter table EMRS_F_COMMUNICATIONS add (constraint
 COMMU_CONTACTYP_FK foreign key 
  (CONTACT_TYPE_ID) references EMRS_D_CONTACT_TYPES
  (CONTACT_TYPE_ID));

prompt Creating foreign key on 'EMRS_F_COMMUNICATIONS'
alter table EMRS_F_COMMUNICATIONS add (constraint
 COMMU_BIZCHANL_FK foreign key 
  (BIZCHANL_CHANNEL_ID) references EMRS_D_BUSINESS_CHANNELS
  (CHANNEL_ID));

prompt Creating foreign key on 'EMRS_F_COMMUNICATIONS'
alter table EMRS_F_COMMUNICATIONS add (constraint
 COMMU_COMMACTN_FK foreign key 
  (COMMUNICATION_ACTION_ID) references EMRS_D_COMMUNICATION_ACTIONS
  (COMMUNICATION_ACTION_ID));

prompt Creating foreign key on 'EMRS_F_COMMUNICATIONS'
alter table EMRS_F_COMMUNICATIONS add (constraint
 COMMU_TIMEPERI_FK foreign key 
  (TIME_PERIOD_ID) references EMRS_D_TIME_PERIODS
  (TIME_PERIOD_ID));

prompt Creating foreign key on 'EMRS_F_COMMUNICATIONS'
alter table EMRS_F_COMMUNICATIONS add (constraint
 COMMU_COMMTYP_FK foreign key 
  (COMMUNICATION_TYPE_ID) references EMRS_D_COMMUNICATION_TYPES
  (COMMUNICATION_TYPE_ID));

prompt Creating foreign key on 'EMRS_F_COMMUNICATIONS'
alter table EMRS_F_COMMUNICATIONS add (constraint
 COMMU_CNTY_FK foreign key 
  (COUNTY_ID) references EMRS_D_COUNTIES
  (COUNTY_ID));

prompt Creating foreign key on 'EMRS_F_COMMUNICATIONS'
alter table EMRS_F_COMMUNICATIONS add (constraint
 COMMU_CASES_FK foreign key 
  (CASE_ID) references EMRS_D_CASES
  (CASE_ID));

prompt Creating foreign key on 'EMRS_F_COMMUNICATIONS'
alter table EMRS_F_COMMUNICATIONS add (constraint
 COMMU_LANG_FK foreign key 
  (LANGUAGE_CODE_ID) references EMRS_D_LANGUAGES
  (LANGUAGE_CODE_ID));

prompt Creating foreign key on 'EMRS_F_COMMUNICATIONS'
alter table EMRS_F_COMMUNICATIONS add (constraint
 COMMU_STAFF_FK foreign key 
  (STAFF_ID) references EMRS_D_STAFF_PEOPLE
  (STAFF_ID));

prompt Creating foreign key on 'EMRS_F_COMMUNICATIONS'
alter table EMRS_F_COMMUNICATIONS add (constraint
 COMMU_DATEPERIOD_FK foreign key 
  (DATE_PERIOD_ID) references EMRS_D_DATE_PERIODS
  (DATE_PERIOD_ID));

prompt Creating foreign key on 'EMRS_F_NOTES'
alter table EMRS_F_NOTES add (constraint
 NOTE_COMMTYP_FK foreign key 
  (COMMUNICATION_TYPE_ID) references EMRS_D_COMMUNICATION_TYPES
  (COMMUNICATION_TYPE_ID));

prompt Creating foreign key on 'EMRS_F_NOTES'
alter table EMRS_F_NOTES add (constraint
 NOTE_DATEPERIOD_FK foreign key 
  (DATE_PERIOD_ID) references EMRS_D_DATE_PERIODS
  (DATE_PERIOD_ID));

prompt Creating foreign key on 'EMRS_F_NOTES'
alter table EMRS_F_NOTES add (constraint
 NOTE_CNTY_FK foreign key 
  (COUNTY_ID) references EMRS_D_COUNTIES
  (COUNTY_ID));

prompt Creating foreign key on 'EMRS_F_NOTES'
alter table EMRS_F_NOTES add (constraint
 NOTE_STAFF_FK foreign key 
  (STAFF_ID) references EMRS_D_STAFF_PEOPLE
  (STAFF_ID));

prompt Creating foreign key on 'EMRS_F_NOTES'
alter table EMRS_F_NOTES add (constraint
 NOTE_BIZCHANL_FK foreign key 
  (BIZCHANL_CHANNEL_ID) references EMRS_D_BUSINESS_CHANNELS
  (CHANNEL_ID));

prompt Creating foreign key on 'EMRS_F_NOTES'
alter table EMRS_F_NOTES add (constraint
 NOTE_CLIENT_FK foreign key 
  (CLIENT_ID) references EMRS_D_CLIENTS
  (CLIENT_ID));

prompt Creating foreign key on 'EMRS_F_NOTES'
alter table EMRS_F_NOTES add (constraint
 NOTE_CASES_FK foreign key 
  (CASE_ID) references EMRS_D_CASES
  (CASE_ID));

prompt Creating foreign key on 'EMRS_F_NOTES'
alter table EMRS_F_NOTES add (constraint
 NOTE_PROGTYPE_FK foreign key 
  (PROGRAM_ID) references EMRS_D_PROGRAMS
  (PROGRAM_ID));

prompt Creating foreign key on 'EMRS_F_NOTES'
alter table EMRS_F_NOTES add (constraint
 NOTE_COMMACTN_FK foreign key 
  (COMMUNICATION_ACTION_ID) references EMRS_D_COMMUNICATION_ACTIONS
  (COMMUNICATION_ACTION_ID))
;

prompt Creating foreign key on 'EMRS_F_NOTES'
alter table EMRS_F_NOTES add (constraint
 NOTE_TIMEPERI_FK foreign key 
  (TIME_PERIOD_ID) references EMRS_D_TIME_PERIODS
  (TIME_PERIOD_ID));

prompt Creating foreign key on 'EMRS_F_NOTES'
alter table EMRS_F_NOTES add (constraint
 NOTE_LANG_FK foreign key 
  (LANGUAGE_CODE_ID) references EMRS_D_LANGUAGES
  (LANGUAGE_CODE_ID));

prompt Creating foreign key on 'EMRS_F_NOTES'
alter table EMRS_F_NOTES add (constraint
 NOTE_COMMSTAT_FK foreign key 
  (COMMUNICATION_STATUS_ID) references EMRS_D_COMMUNICATION_STATUS
  (COMMUNICATION_STATUS_ID));

prompt Creating foreign key on 'EMRS_F_NOTES'
alter table EMRS_F_NOTES add (constraint
 NOTE_CONTACTYP_FK foreign key 
  (CONTACT_TYPE_ID) references EMRS_D_CONTACT_TYPES
  (CONTACT_TYPE_ID));


prompt Creating sequence 'EMRS_SEQ_OUTREACH_EVENT_ACT_ID'
create sequence EMRS_SEQ_OUTREACH_EVENT_ACT_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_COMMUNICATION_TYPE_ID'
create sequence EMRS_SEQ_COMMUNICATION_TYPE_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_FPL_ID'
create sequence EMRS_SEQ_FPL_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_COVERAGE_CODE_ID'
create sequence EMRS_SEQ_COVERAGE_CODE_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_TERM_REASON_CODE_ID'
create sequence EMRS_SEQ_TERM_REASON_CODE_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_STAT_IN_GRP_ID'
create sequence EMRS_SEQ_STAT_IN_GRP_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_OTHER_CHIP_CODE_ID'
create sequence EMRS_SEQ_OTHER_CHIP_CODE_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_CHANGE_REASON_ID'
create sequence EMRS_SEQ_CHANGE_REASON_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_STAFF_ID'
create sequence EMRS_SEQ_STAFF_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_PROVIDER_ID'
create sequence EMRS_SEQ_PROVIDER_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_MEDICAID_CATG_ID'
create sequence EMRS_SEQ_MEDICAID_CATG_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_NOTES_ID'
create sequence EMRS_SEQ_NOTES_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_COMMUNICAT_ACTIONS_ID'
create sequence EMRS_SEQ_COMMUNICAT_ACTIONS_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_TARGET_GROUP_ID'
create sequence EMRS_SEQ_TARGET_GROUP_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_POPLTN_ELIG_CRITRA_ID'
create sequence EMRS_SEQ_POPLTN_ELIG_CRITRA_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_PCA_REASON_CODE_ID'
create sequence EMRS_SEQ_PCA_REASON_CODE_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_OUTREACH_ACTIVITY_ID'
create sequence EMRS_SEQ_OUTREACH_ACTIVITY_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_COMMUNICATIONS_F_ID'
create sequence EMRS_SEQ_COMMUNICATIONS_F_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_SELECTED_TARGET_ID'
create sequence EMRS_SEQ_SELECTED_TARGET_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_PROVDR_SPECTY_CODE_ID'
create sequence EMRS_SEQ_PROVDR_SPECTY_CODE_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_LANGUAGE_CODE_ID'
create sequence EMRS_SEQ_LANGUAGE_CODE_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_COMM_STATUS_ID'
create sequence EMRS_SEQ_COMM_STATUS_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_ENROLLMENT_ID'
create sequence EMRS_SEQ_ENROLLMENT_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_DATE_PERIOD_ID'
create sequence EMRS_SEQ_DATE_PERIOD_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_HEADSTART_GRANTEE_ID'
create sequence EMRS_SEQ_HEADSTART_GRANTEE_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_SCHOOL_DISTRICT_ID'
create sequence EMRS_SEQ_SCHOOL_DISTRICT_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle;

prompt Creating sequence 'EMRS_SEQ_PLANS_ID'
create sequence EMRS_SEQ_PLANS_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_RISK_GROUP_ID'
create sequence EMRS_SEQ_RISK_GROUP_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_COUNTIES_ID'
create sequence EMRS_SEQ_COUNTIES_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_TARGET_GROUP_TYP_ID'
create sequence EMRS_SEQ_TARGET_GROUP_TYP_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_CLIENT_ID'
create sequence EMRS_SEQ_CLIENT_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_CARE_SERV_DELIV_AREA'
create sequence EMRS_SEQ_CARE_SERV_DELIV_AREA
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_PROVIDER_TYPE_CODE_ID'
create sequence EMRS_SEQ_PROVIDER_TYPE_CODE_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_ENROLMT_ACT_STATUS_ID'
create sequence EMRS_SEQ_ENROLMT_ACT_STATUS_ID
  nomaxvalue
  nominvalue
  nocycle;

prompt Creating sequence 'EMRS_SEQ_RACE_ID'
create sequence EMRS_SEQ_RACE_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_REJECTN_ERR_REASON_ID'
create sequence EMRS_SEQ_REJECTN_ERR_REASON_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_COVERAGE_CATEGORY_ID'
create sequence EMRS_SEQ_COVERAGE_CATEGORY_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_SUB_PROGRAM_ID'
create sequence EMRS_SEQ_SUB_PROGRAM_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_PROGRAM_ID'
create sequence EMRS_SEQ_PROGRAM_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_CASES_ID'
create sequence EMRS_SEQ_CASES_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_PLAN_CODE_ID'
create sequence EMRS_SEQ_PLAN_CODE_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;

prompt Creating sequence 'EMRS_SEQ_CONTACT_TYPE_ID'
create sequence EMRS_SEQ_CONTACT_TYPE_ID
  nomaxvalue
  nominvalue
  nocycle;

prompt Creating sequence 'EMRS_SEQ_ACTION_TYPE_ID'
create sequence EMRS_SEQ_ACTION_TYPE_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle;

prompt Creating sequence 'EMRS_SEQ_TIME_PERIOD_ID'
create sequence EMRS_SEQ_TIME_PERIOD_ID
  increment by 1
  start with 1
  nomaxvalue
  nominvalue
  nocycle
  cache 5;


/*
prompt Creating synonym 'EMRS_SEQ_OUTREACH_EVENT_ACT_ID' 
create public synonym EMRS_SEQ_OUTREACH_EVENT_ACT_ID for EMRS.EMRS_SEQ_OUTREACH_EVENT_ACT_ID;

prompt Creating synonym 'EMRS_SEQ_COMMUNICATION_TYPE_ID' 
create public synonym EMRS_SEQ_COMMUNICATION_TYPE_ID for EMRS.EMRS_SEQ_COMMUNICATION_TYPE_ID;

prompt Creating synonym 'EMRS_D_TERMINATION_REASONS' 
create public synonym EMRS_D_TERMINATION_REASONS for EMRS.EMRS_D_TERMINATION_REASONS;

prompt Creating synonym 'EMRS_D_PROVIDER_TYPES' 
create public synonym EMRS_D_PROVIDER_TYPES for EMRS.EMRS_D_PROVIDER_TYPES;

prompt Creating synonym 'EMRS_SEQ_FPL_ID' 
create public synonym EMRS_SEQ_FPL_ID for EMRS.EMRS_SEQ_FPL_ID;

prompt Creating synonym 'EMRS_SEQ_COVERAGE_CODE_ID' 
create public synonym EMRS_SEQ_COVERAGE_CODE_ID for EMRS.EMRS_SEQ_COVERAGE_CODE_ID;

prompt Creating synonym 'EMRS_SEQ_TERM_REASON_CODE_ID' 
create public synonym EMRS_SEQ_TERM_REASON_CODE_ID for EMRS.EMRS_SEQ_TERM_REASON_CODE_ID;

prompt Creating synonym 'EMRS_D_STAFF_PEOPLE' 
create public synonym EMRS_D_STAFF_PEOPLE for EMRS.EMRS_D_STAFF_PEOPLE;

prompt Creating synonym 'EMRS_D_COUNTIES' 
create public synonym EMRS_D_COUNTIES for EMRS.EMRS_D_COUNTIES;

prompt Creating synonym 'EMRS_D_LANGUAGES' 
create public synonym EMRS_D_LANGUAGES for EMRS.EMRS_D_LANGUAGES;

prompt Creating synonym 'EMRS_D_DATE_PERIODS' 
create public synonym EMRS_D_DATE_PERIODS for EMRS.EMRS_D_DATE_PERIODS;

prompt Creating synonym 'EMRS_SEQ_STAT_IN_GRP_ID' 
create public synonym EMRS_SEQ_STAT_IN_GRP_ID for EMRS.EMRS_SEQ_STAT_IN_GRP_ID;

prompt Creating synonym 'EMRS_SEQ_OTHER_CHIP_CODE_ID' 
create public synonym EMRS_SEQ_OTHER_CHIP_CODE_ID for EMRS.EMRS_SEQ_OTHER_CHIP_CODE_ID;

prompt Creating synonym 'EMRS_SEQ_CHANGE_REASON_ID' 
create public synonym EMRS_SEQ_CHANGE_REASON_ID for EMRS.EMRS_SEQ_CHANGE_REASON_ID;

prompt Creating synonym 'EMRS_D_CLIENTS' 
create public synonym EMRS_D_CLIENTS for EMRS.EMRS_D_CLIENTS;

prompt Creating synonym 'EMRS_D_REJECTION_ERROR_REASON' 
create public synonym EMRS_D_REJECTION_ERROR_REASON for EMRS.EMRS_D_REJECTION_ERROR_REASONS;

prompt Creating synonym 'EMRS_D_PLANS' 
create public synonym EMRS_D_PLANS for EMRS.EMRS_D_PLANS;

prompt Creating synonym 'EMRS_SEQ_STAFF_ID' 
create public synonym EMRS_SEQ_STAFF_ID for EMRS.EMRS_SEQ_STAFF_ID;

prompt Creating synonym 'EMRS_SEQ_PROVIDER_ID' 
create public synonym EMRS_SEQ_PROVIDER_ID for EMRS.EMRS_SEQ_PROVIDER_ID;

prompt Creating synonym 'EMRS_SEQ_MEDICAID_CATG_ID' 
create public synonym EMRS_SEQ_MEDICAID_CATG_ID for EMRS.EMRS_SEQ_MEDICAID_CATG_ID;

prompt Creating synonym 'EMRS_D_TARGET_GROUP_TYPES' 
create public synonym EMRS_D_TARGET_GROUP_TYPES for EMRS.EMRS_D_TARGET_GROUP_TYPES;

prompt Creating synonym 'EMRS_SEQ_NOTES_ID' 
create public synonym EMRS_SEQ_NOTES_ID for EMRS.EMRS_SEQ_NOTES_ID;

prompt Creating synonym 'EMRS_SEQ_COMMUNICAT_ACTIONS_ID' 
create public synonym EMRS_SEQ_COMMUNICAT_ACTIONS_ID for EMRS.EMRS_SEQ_COMMUNICAT_ACTIONS_ID;

prompt Creating synonym 'EMRS_D_FEDERAL_POVERTY_LEVEL' 
create public synonym EMRS_D_FEDERAL_POVERTY_LEVEL for EMRS.EMRS_D_FEDERAL_POVERTY_LEVELS;

prompt Creating synonym 'EMRS_SEQ_OUTREACH_ACTIVITY_ID' 
create public synonym EMRS_SEQ_OUTREACH_ACTIVITY_ID for EMRS.EMRS_SEQ_OUTREACH_ACTIVITY_ID;

prompt Creating synonym 'EMRS_SEQ_COMMUNICATIONS_F_ID' 
create public synonym EMRS_SEQ_COMMUNICATIONS_F_ID for EMRS.EMRS_SEQ_COMMUNICATIONS_F_ID;

prompt Creating synonym 'EMRS_D_COVERAGE_CATEGORIES' 
create public synonym EMRS_D_COVERAGE_CATEGORIES for EMRS.EMRS_D_COVERAGE_CATEGORIES;

prompt Creating synonym 'EMRS_SEQ_SELECTED_TARGET_ID' 
create public synonym EMRS_SEQ_SELECTED_TARGET_ID for EMRS.EMRS_SEQ_SELECTED_TARGET_ID;

prompt Creating synonym 'EMRS_SEQ_PROVDR_SPECTY_CODE_ID' 
create public synonym EMRS_SEQ_PROVDR_SPECTY_CODE_ID for EMRS.EMRS_SEQ_PROVDR_SPECTY_CODE_ID;

prompt Creating synonym 'EMRS_SEQ_LANGUAGE_CODE_ID' 
create public synonym EMRS_SEQ_LANGUAGE_CODE_ID for EMRS.EMRS_SEQ_LANGUAGE_CODE_ID;

prompt Creating synonym 'EMRS_F_ORCH_SELECTED_TARGETS' 
create public synonym EMRS_F_ORCH_SELECTED_TARGETS for EMRS.EMRS_F_ORCH_SELECTED_TARGETS;

prompt Creating synonym 'EMRS_D_HEADSTART_GRANTEES' 
create public synonym EMRS_D_HEADSTART_GRANTEES for EMRS.EMRS_D_HEADSTART_GRANTEES;

prompt Creating synonym 'EMRS_F_OUTREACH_EVENTS' 
create public synonym EMRS_F_OUTREACH_EVENTS for EMRS.EMRS_F_OUTREACH_EVENTS;

prompt Creating synonym 'EMRS_S_OUTREACH_FACTS' 
create public synonym EMRS_S_OUTREACH_FACTS for EMRS.EMRS_S_OUTREACH_FACTS;

prompt Creating synonym 'EMRS_D_CHANGE_REASONS' 
create public synonym EMRS_D_CHANGE_REASONS for EMRS.EMRS_D_CHANGE_REASONS;

prompt Creating synonym 'EMRS_D_ENROLLMENT_ACTION_STATU' 
create public synonym EMRS_D_ENROLLMENT_ACTION_STATU for EMRS.EMRS_D_ENROLLMENT_ACTION_STATU;

prompt Creating synonym 'EMRS_SEQ_COMM_STATUS_ID' 
create public synonym EMRS_SEQ_COMM_STATUS_ID for EMRS.EMRS_SEQ_COMM_STATUS_ID;

prompt Creating synonym 'EMRS_SEQ_SELECTED_GROUP_ID' 
create public synonym EMRS_SEQ_SELECTED_GROUP_ID for EMRS.EMRS_SEQ_TARGET_GROUP_ID;

prompt Creating synonym 'EMRS_SEQ_ENROLLMENT_ID' 
create public synonym EMRS_SEQ_ENROLLMENT_ID for EMRS.EMRS_SEQ_ENROLLMENT_ID;

prompt Creating synonym 'EMRS_SEQ_DATE_PERIOD_ID' 
create public synonym EMRS_SEQ_DATE_PERIOD_ID for EMRS.EMRS_SEQ_DATE_PERIOD_ID;

prompt Creating synonym 'EMRS_V_ORCH_TARGET_ACTIVITIES' 
create public synonym EMRS_V_ORCH_TARGET_ACTIVITIES for EMRS.EMRS_V_ORCH_TARGET_ACTIVITIES;

prompt Creating synonym 'EMRS_D_TARGET_GROUPS' 
create public synonym EMRS_D_TARGET_GROUPS for EMRS.EMRS_D_TARGET_GROUPS;

prompt Creating synonym 'EMRS_D_OUTREACH_ACTIVITIES' 
create public synonym EMRS_D_OUTREACH_ACTIVITIES for EMRS.EMRS_D_OUTREACH_ACTIVITIES;

prompt Creating synonym 'EMRS_D_COMMUNICATION_STATUS' 
create public synonym EMRS_D_COMMUNICATION_STATUS for EMRS.EMRS_D_COMMUNICATION_STATUS;

prompt Creating synonym 'EMRS_D_CARE_SERV_DELIV_AREAS' 
create public synonym EMRS_D_CARE_SERV_DELIV_AREAS for EMRS.EMRS_D_CARE_SERV_DELIV_AREAS;

prompt Creating synonym 'EMRS_SEQ_HEADSTART_GRANTEE_ID' 
create public synonym EMRS_SEQ_HEADSTART_GRANTEE_ID for EMRS.EMRS_SEQ_HEADSTART_GRANTEE_ID;

prompt Creating synonym 'EMRS_SEQ_SCHOOL_DISTRICT_ID' 
create public synonym EMRS_SEQ_SCHOOL_DISTRICT_ID for EMRS.EMRS_SEQ_SCHOOL_DISTRICT_ID;

prompt Creating synonym 'EMRS_SEQ_PLANS_ID' 
create public synonym EMRS_SEQ_PLANS_ID for EMRS.EMRS_SEQ_PLANS_ID;

prompt Creating synonym 'EMRS_SEQ_RISK_GROUP_ID' 
create public synonym EMRS_SEQ_RISK_GROUP_ID for EMRS.EMRS_SEQ_RISK_GROUP_ID;

prompt Creating synonym 'EMRS_SEQ_COUNTIES_ID' 
create public synonym EMRS_SEQ_COUNTIES_ID for EMRS.EMRS_SEQ_COUNTIES_ID;

prompt Creating synonym 'EMRS_SEQ_TARGET_GROUP_TYP_ID' 
create public synonym EMRS_SEQ_TARGET_GROUP_TYP_ID for EMRS.EMRS_SEQ_TARGET_GROUP_TYP_ID;

prompt Creating synonym 'EMRS_S_HEADSTART_GRANT_CENTERS' 
create public synonym EMRS_S_HEADSTART_GRANT_CENTERS for EMRS.EMRS_S_HEADSTART_GRANT_CENTERS;

prompt Creating synonym 'EMRS_D_ACTION_TYPES' 
create public synonym EMRS_D_ACTION_TYPES for EMRS.EMRS_D_ACTION_TYPES;

prompt Creating synonym 'EMRS_D_OTHER_CHIP_CODES' 
create public synonym EMRS_D_OTHER_CHIP_CODES for EMRS.EMRS_D_OTHER_CHIP_CODES;

prompt Creating synonym 'EMRS_D_RACES' 
create public synonym EMRS_D_RACES for EMRS.EMRS_D_RACES;

prompt Creating synonym 'EMRS_SEQ_CLIENT_ID' 
create public synonym EMRS_SEQ_CLIENT_ID for EMRS.EMRS_SEQ_CLIENT_ID;

prompt Creating synonym 'EMRS_SEQ_CARE_SERV_DELIV_AREA' 
create public synonym EMRS_SEQ_CARE_SERV_DELIV_AREA for EMRS.EMRS_SEQ_CARE_SERV_DELIV_AREA;

prompt Creating synonym 'EMRS_D_CASES' 
create public synonym EMRS_D_CASES for EMRS.EMRS_D_CASES;

prompt Creating synonym 'EMRS_D_CONTACT_TYPES' 
create public synonym EMRS_D_CONTACT_TYPES for EMRS.EMRS_D_CONTACT_TYPES;

prompt Creating synonym 'EMRS_SEQ_PROVIDER_TYPE_CODE_ID' 
create public synonym EMRS_SEQ_PROVIDER_TYPE_CODE_ID for EMRS.EMRS_SEQ_PROVIDER_TYPE_CODE_ID;

prompt Creating synonym 'EMRS_D_PROVIDERS' 
create public synonym EMRS_D_PROVIDERS for EMRS.EMRS_D_PROVIDERS;

prompt Creating synonym 'EMRS_D_COMMUNICATION_ACTIONS' 
create public synonym EMRS_D_COMMUNICATION_ACTIONS for EMRS.EMRS_D_COMMUNICATION_ACTIONS;

prompt Creating synonym 'EMRS_SEQ_RACE_ID' 
create public synonym EMRS_SEQ_RACE_ID for EMRS.EMRS_SEQ_RACE_ID;

prompt Creating synonym 'EMRS_SEQ_REJECTN_ERR_REASON_ID' 
create public synonym EMRS_SEQ_REJECTN_ERR_REASON_ID for EMRS.EMRS_SEQ_REJECTN_ERR_REASON_ID;

prompt Creating synonym 'EMRS_SEQ_COVERAGE_CATEGORY_ID' 
create public synonym EMRS_SEQ_COVERAGE_CATEGORY_ID for EMRS.EMRS_SEQ_COVERAGE_CATEGORY_ID;

prompt Creating synonym 'EMRS_D_TARGET_ACTIVITIES' 
create public synonym EMRS_D_TARGET_ACTIVITIES for EMRS.EMRS_D_TARGET_ACTIVITIES;

prompt Creating synonym 'EMRS_SEQ_SUB_PROGRAM_ID' 
create public synonym EMRS_SEQ_SUB_PROGRAM_ID for EMRS.EMRS_SEQ_SUB_PROGRAM_ID;

prompt Creating synonym 'EMRS_SEQ_PROGRAM_ID' 
create public synonym EMRS_SEQ_PROGRAM_ID for EMRS.EMRS_SEQ_PROGRAM_ID;

prompt Creating synonym 'EMRS_D_PROVIDER_SPECIALTY_CODE' 
create public synonym EMRS_D_PROVIDER_SPECIALTY_CODE for EMRS.EMRS_D_PROVIDER_SPECIALTY_CODE;

prompt Creating synonym 'EMRS_D_RISK_GROUPS' 
create public synonym EMRS_D_RISK_GROUPS for EMRS.EMRS_D_RISK_GROUPS;

prompt Creating synonym 'EMRS_D_STATUS_IN_GROUP' 
create public synonym EMRS_D_STATUS_IN_GROUP for EMRS.EMRS_D_STATUS_IN_GROUPS;

prompt Creating synonym 'EMRS_SEQ_CASES_ID' 
create public synonym EMRS_SEQ_CASES_ID for EMRS.EMRS_SEQ_CASES_ID;

prompt Creating synonym 'EMRS_SEQ_PLAN_CODE_ID' 
create public synonym EMRS_SEQ_PLAN_CODE_ID for EMRS.EMRS_SEQ_PLAN_CODE_ID;

prompt Creating synonym 'EMRS_D_SCHOOL_DISTRICTS' 
create public synonym EMRS_D_SCHOOL_DISTRICTS for EMRS.EMRS_D_SCHOOL_DISTRICTS;

prompt Creating synonym 'EMRS_D_SUB_PROGRAMS' 
create public synonym EMRS_D_SUB_PROGRAMS for EMRS.EMRS_D_SUB_PROGRAMS;

prompt Creating synonym 'EMRS_D_COMMUNICATION_TYPES' 
create public synonym EMRS_D_COMMUNICATION_TYPES for EMRS.EMRS_D_COMMUNICATION_TYPES;

prompt Creating synonym 'EMRS_SEQ_ACTION_TYPE_ID' 
create public synonym EMRS_SEQ_ACTION_TYPE_ID for EMRS.EMRS_SEQ_ACTION_TYPE_ID;

prompt Creating synonym 'EMRS_SEQ_TIME_PERIOD_ID' 
create public synonym EMRS_SEQ_TIME_PERIOD_ID for EMRS.EMRS_SEQ_TIME_PERIOD_ID;

prompt Creating synonym 'EMRS_D_TIME_PERIODS' 
create public synonym EMRS_D_TIME_PERIODS for EMRS.EMRS_D_TIME_PERIODS;

prompt Creating synonym 'EMRS_D_PROGRAMS' 
create public synonym EMRS_D_PROGRAMS for EMRS.EMRS_D_PROGRAMS;

prompt Creating synonym 'EMRS_F_ENROLLMENT' 
create public synonym EMRS_F_ENROLLMENT for EMRS.EMRS_F_ENROLLMENTS;
*/
