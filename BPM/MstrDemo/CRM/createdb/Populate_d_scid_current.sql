--truncate table d_scid_current;

--Populate d_scid_current
INSERT INTO d_scid_current
 (contact_record_id
,contact_record_link_id
,client_id
,case_id
,case_last_name
,case_first_name
,case_full_name
,middle_initial
,clnt_cin
,case_cin
,dob
,gender
,addr_city
,addr_state_cd
,addr_county
,addr_zip
,addr_zip_four)
SELECT contact_record_id
,contact_record_link_id
,d.client_id
,d.case_id
,d.last_name
,d.first_name
,d.first_name||' '||d.middle_initial||' '||d.last_name full_name
,d.middle_initial
,LPAD(d.clnt_cin,12,'0') clnt_cin
,LPAD(d.case_cin,12,'0') case_cin
,d.dob
,d.gender_cd
,d.addr_city
,d.addr_state
,d.addr_county
,d.addr_zip
,d.addr_zip_four
FROM  scid_contact_stg co
 JOIN scid_consumer_stg d ON co.client_id = d.client_id AND co.case_id = d.case_id;

--Language 
MERGE INTO d_scid_current d
USING (SELECT scd.contact_record_link_id,language
        FROM d_sci_current sci
          JOIN d_scid_current scd ON sci.contact_record_id = scd.contact_record_id) tmp ON (tmp.contact_record_link_id = d.contact_record_link_id)
WHEN MATCHED THEN
  UPDATE 
  SET language_preference = tmp.language ; 

--Correspondence Preference  
MERGE INTO d_scid_current d
USING (SELECT *
       FROM (
         SELECT contact_record_link_id,'Paperless Correspondence' correspondence_preference
         FROM d_scid_current curr
          ORDER BY curr.correspondence_preference NULLS FIRST,curr.contact_record_link_id )
        FETCH FIRST 72 PERCENT ROWS ONLY) tmp ON (tmp.contact_record_link_id = d.contact_record_link_id)
WHEN MATCHED THEN
  UPDATE 
  SET correspondence_preference = tmp.correspondence_preference     ;  
 
MERGE INTO d_scid_current d
USING (SELECT *
       FROM (
         SELECT contact_record_link_id,'No Preference' correspondence_preference
         FROM d_scid_current curr
          ORDER BY curr.correspondence_preference NULLS FIRST,curr.contact_record_link_id )
        FETCH FIRST 28 PERCENT ROWS ONLY) tmp ON (tmp.contact_record_link_id = d.contact_record_link_id)
WHEN MATCHED THEN
  UPDATE 
  SET correspondence_preference = tmp.correspondence_preference     ;    

--Address Type  
MERGE INTO d_scid_current d
USING (SELECT *
       FROM (
         SELECT contact_record_link_id,'Physical' address_type
         FROM d_scid_current curr
          ORDER BY curr.address_type NULLS FIRST,curr.contact_record_link_id )
        FETCH FIRST 46 PERCENT ROWS ONLY) tmp ON (tmp.contact_record_link_id = d.contact_record_link_id)
WHEN MATCHED THEN
  UPDATE 
  SET address_type = tmp.address_type     ;   
  
MERGE INTO d_scid_current d
USING (SELECT *
       FROM (
         SELECT contact_record_link_id,'Mailing' address_type
         FROM d_scid_current curr
          ORDER BY curr.address_type NULLS FIRST,curr.contact_record_link_id )
        FETCH FIRST 54 PERCENT ROWS ONLY) tmp ON (tmp.contact_record_link_id = d.contact_record_link_id)
WHEN MATCHED THEN
  UPDATE 
  SET address_type = tmp.address_type     ; 
  
--Program/SubProgram
MERGE INTO d_scid_current d
USING (SELECT *
       FROM (
         SELECT contact_record_link_id,'CHIP' program,'Subprogram 3' subprogram
         FROM d_scid_current curr
          ORDER BY curr.program NULLS FIRST,curr.contact_record_link_id )
        FETCH FIRST 30 PERCENT ROWS ONLY) tmp ON (tmp.contact_record_link_id = d.contact_record_link_id)
WHEN MATCHED THEN
  UPDATE 
  SET program = tmp.program   
     ,subprogram = tmp.subprogram;  
     
MERGE INTO d_scid_current d
USING (SELECT *
       FROM (
         SELECT contact_record_link_id,'MEDICAID' program,'Subprogram 1' subprogram
         FROM d_scid_current curr
          ORDER BY curr.subprogram NULLS FIRST,curr.contact_record_link_id )
        FETCH FIRST 35 PERCENT ROWS ONLY) tmp ON (tmp.contact_record_link_id = d.contact_record_link_id)
WHEN MATCHED THEN
  UPDATE 
  SET program = tmp.program   
     ,subprogram = tmp.subprogram;  

MERGE INTO d_scid_current d
USING (SELECT *
       FROM (
         SELECT contact_record_link_id,'MEDICAID' program,'Subprogram 2' subprogram
         FROM d_scid_current curr
          ORDER BY curr.subprogram NULLS FIRST,curr.contact_record_link_id )
        FETCH FIRST 35 PERCENT ROWS ONLY) tmp ON (tmp.contact_record_link_id = d.contact_record_link_id)
WHEN MATCHED THEN
  UPDATE 
  SET program = tmp.program   
     ,subprogram = tmp.subprogram;   
 
--Populate address   
MERGE INTO d_scid_current d
USING (SELECT contact_record_link_id
        ,CASE WHEN SUBSTR(addr_street_1,3,1) IN ('1','2') THEN addr_street_1||' WAY'
              WHEN SUBSTR(addr_street_1,3,1) IN ('3','4') THEN addr_street_1||' STREET'
              WHEN SUBSTR(addr_street_1,3,1) IN ('5','6') THEN addr_street_1||' DR'
              WHEN SUBSTR(addr_street_1,3,1) IN ('7','8') THEN addr_street_1||' AVE'
              WHEN SUBSTR(addr_street_1,3,1) IN ('9') THEN addr_street_1||' BLVD'
         ELSE addr_street_1||' CIR' END addr_street_1 ,addr_street_2
        FROM(
        SELECT contact_record_link_id,case_last_name,addr_city,SUBSTR(TO_CHAR(abs(dbms_random.random)),1,3)||' '||SUBSTR(case_last_name,1,3)||SUBSTR(REPLACE(addr_city,' ',''),LENGTH(addr_city)-3,4) addr_street_1
            ,CASE WHEN addr_zip_four IS NOT NULL THEN 
               CASE WHEN SUBSTR(addr_zip_four,1,1) IN('1','2','3') THEN 'APT '||SUBSTR(TO_CHAR(abs(dbms_random.random)),1,1)
                    WHEN SUBSTR(addr_zip_four,1,1) IN('4','5','6') THEN 'APT '||dbms_random.string('U',1)||SUBSTR(TO_CHAR(abs(dbms_random.random)),1,1)
               ELSE 'APT '||dbms_random.string('U',1) END 
             ELSE NULL END addr_street_2
        FROM d_scid_current) )tmp ON (tmp.contact_record_link_id = d.contact_record_link_id)
WHEN MATCHED THEN
  UPDATE 
  SET addr_street_1 = tmp.addr_street_1
     ,addr_street_2 = tmp.addr_street_2;

--commit;     