CREATE TABLE scid_contact_stg(
contact_record_id NUMBER
,contact_record_link_id NUMBER
,client_id NUMBER
,case_id NUMBER) TABLESPACE MAXDAT_DATA;

CREATE TABLE scid_consumer_stg
(client_id NUMBER
,case_id NUMBER
,last_name VARCHAR2(100)
,first_name VARCHAR2(100)
,middle_initial VARCHAR2(1)
,clnt_cin VARCHAR2(20)
,case_cin VARCHAR2(20)
,dob DATE
,gender_cd VARCHAR2(1)
,addr_city VARCHAR2(100)
,addr_state VARCHAR2(20)
,addr_county VARCHAR2(100)
,addr_zip VARCHAR2(10)
,addr_zip_four VARCHAR2(10)
) TABLESPACE MAXDAT_DATA;

CREATE TABLE d_scid_current
(contact_record_id NUMBER
,contact_record_link_id NUMBER
,client_id NUMBER
,case_id NUMBER
,case_last_name VARCHAR2(100)
,case_first_name VARCHAR2(100)
,case_full_name VARCHAR2(200)
,middle_initial VARCHAR2(1)
,clnt_cin VARCHAR2(20)
,case_cin VARCHAR2(20)
,dob DATE
,gender VARCHAR2(1)
,addr_street_1 VARCHAR2(256)
,addr_street_2 VARCHAR2(256)
,addr_city VARCHAR2(100)
,addr_state_cd VARCHAR2(20)
,addr_county VARCHAR2(100)
,addr_zip VARCHAR2(10)
,addr_zip_four VARCHAR2(10)
,address_type VARCHAR2(100)
,correspondence_preference VARCHAR2(50)
,language_preference VARCHAR2(50)
,subprogram VARCHAR2(50)
,program VARCHAR2(50)
) TABLESPACE MAXDAT_DATA;

CREATE OR REPLACE VIEW d_scid_current_sv
AS
SELECT contact_record_id
,contact_record_link_id
,client_id
,case_id
,case_last_name
,case_first_name
,case_full_name client_full_name
,middle_initial case_middle_initial
,clnt_cin
,case_cin
,dob consumer_dob
,FLOOR(months_between(TRUNC(sysdate),dob)/12) consumer_age
,gender consumer_gender
,addr_street_1
,addr_street_2
,addr_city
,addr_state_cd
,addr_county
,addr_zip
,addr_zip_four
,address_type
,correspondence_preference
,language_preference
,subprogram
,program
FROM d_scid_current;

GRANT SELECT ON D_SCID_CURRENT_SV TO MAXDAT_READ_ONLY; 