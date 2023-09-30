CREATE OR REPLACE VIEW PUBLIC.ECMS_D_HPE_INSTANCE_SV AS
with je as (
   select project_id,event_id,parse_json (payload) as payload
    from marsdb.marsdb_events_vw
     where payload is not null and event_name = 'INBOUND_CORRESPONDENCE_SAVE_EVENT' and payload like '%VACV HPE Form%'
   ) 
   ,fl as (select je.project_id, je.event_id, f.value, f.seq,f.index
              from je, 
   lateral flatten(input=>payload:dataObject.metaData,recursive=>false) f)
   SELECT 
     je.project_id::integer as project_id
    ,'UNKNOWN' as program_id
    ,je.event_id::integer as event_id
    --,je.payload:eventCreatedOn::date as receipt_date
    --8447    
    ,to_date(to_timestamp_tz(marsdb.get_formatted_datetime(je.payload:dataObject:createdOn)::VARCHAR, 'YYYY-MM-DD"T"HH24:MI:SS.FFTZH:TZM')) AS create_date
    ,je.payload:dataObject.receivedDate::date as receipt_date
    
    ,je.payload:dataObject.inboundCorrespondenceId::varchar as document_id
    ,nas.start_date::date as start_date
    ,nas.end_date::date as end_date
    ,nas.INCOME_LT_EQUAL_FPL::varchar as INCOME_LT_EQUAL_FPL 
    ,nas.INITIAL_DETERMINATION::varchar as  INITIAL_DETERMINATION
    ,nas.denial_reason::varchar as denial_reason
    ,nas.immigration_status::varchar as immigration_status
    ,nas.aid_category::varchar as aid_category
    ,nas.hpe_exception::varchar as hpe_exception
    ,nas.hpe_status::varchar as hpe_status
    ,nas.first_name::varchar as first_name
    ,nas.middle_initial::varchar as middle_initial
    ,nas.last_name::varchar as last_name
    ,nas.dob::date as dob
    ,nas.gender::varchar as gender
    ,nas.RES_ADDRESS_CITY_COUNTY::varchar as res_address_city_county
    ,nas.household_size::integer as household_size
    ,to_decimal(nas.monthly_income::varchar, '$999,999.00') as monthly_income
    ,nas.student::varchar as student
    ,nas.babies_expected::integer as babies_expected
    ,nas.pregnancy_due_date::date as pregnancy_due_date
    ,nas.resident_of_state::varchar as resident_of_state
    ,nas.citizen_or_legal_res::varchar as citizen_or_legal_res
    ,nas.current_hpe_exhausted::varchar as current_hpe_exhausted
    ,nas.language::varchar as language
    ,nas.address_1::varchar as address_1
    ,nas.address_2::varchar as address_2
    ,nas.city::varchar as city
    ,nas.state::varchar as state
    ,nas.zip_code::varchar  as zip_code
    ,nas.ldss_locality::varchar as ldss_locality
    ,nas.ssn::varchar as ssn
    ,nas.race::varchar as race
    ,nas.home_phone_number::varchar as home_phone
    ,nas.had_foster_care_age_18::varchar as had_foster_care_age_18
    ,nas.breast_cervical_cancer::varchar  as breast_cervical_cancer
    ,nas.provider_name::varchar as provider_name
    ,nas.provider_npi::varchar as provider_npi
    ,nas.submitted_by_name::varchar as submitted_by_name
    ,nas.submitted_by_title::varchar as submitted_by_title
    ,nas.submitted_by_work_phone::varchar as submitted_by_work_phone
    ,nas.submitted_by_email_address::varchar as submitted_by_email_address
    ,nas.adult_dob::date as adult_dob
    ,nas.hpe_note_1::varchar as hpe_note_1
    ,nas.hpe_note_2::varchar as hpe_note_2
    ,'UNKNOWN' as mars_case_id
    ,'UNKNOWN' as mars_consumer_id
    ,'UNKNOWN' as mmis_case_id
    ,'UNKNOWN' as mmis_client_id
    ,'UNKNOWN' as final_determination
from je
         LEFT JOIN (
           SELECT na.event_id, na.project_id
           ,max(start_date) as start_date, max(end_date) as end_date, max(INCOME_LT_EQUAL_FPL) as INCOME_LT_EQUAL_FPL
           ,max(initial_determination) as initial_determination, max(denial_reason) as denial_reason, max(immigration_status) as immigration_status
           ,max(aid_category) as aid_category, max(hpe_exception) as hpe_exception, max(hpe_status) as hpe_status
           ,max(first_name) as first_name, max(last_name) as last_name
           ,max(middle_initial) as middle_initial, max(dob) as dob, max(gender) as gender
           ,max(RES_ADDRESS_CITY_COUNTY) as RES_ADDRESS_CITY_COUNTY, max(household_size) as household_size
           ,max(monthly_income) as monthly_income, max(student) as student, max(babies_expected) as babies_expected
           ,max(pregnancy_due_date) as pregnancy_due_date, max(resident_of_state) as resident_of_state, max(CITIZEN_OR_LEGAL_RES) as CITIZEN_OR_LEGAL_RES
           ,max(CURRENT_HPE_EXHAUSTED) as CURRENT_HPE_EXHAUSTED, max(language) as language
           ,max(address_1) as address_1, max(address_2) as address_2, max(city) as city, max(state) as state, max(zip_code) as zip_code
           ,max(ldss_locality) as ldss_locality, max(ssn) as ssn, max(race) as race
           ,max(home_phone_number) as home_phone_number, max(HAD_FOSTER_CARE_AGE_18) as HAD_FOSTER_CARE_AGE_18,max(breast_cervical_cancer) as breast_cervical_cancer
           , max(provider_name) as provider_name, max(provider_npi) as provider_npi 
           ,max(submitted_by_name) as submitted_by_name, max(submitted_by_title) as submitted_by_title
           ,max(SUBMITTED_BY_WORK_PHONE) as SUBMITTED_BY_WORK_PHONE, max(SUBMITTED_BY_EMAIL_ADDRESS) as SUBMITTED_BY_EMAIL_ADDRESS
           ,max(adult_dob) as adult_dob, max(hpe_note_1) as hpe_note_1, max(hpe_note_2) as hpe_note_2
           FROM (
           
             SELECT fl.EVENT_ID,fl.PROJECT_ID
                    ,case when fl.value:name = 'Start Date' then fl.value:value else null end AS start_date
                    ,case when fl.value:name = 'End Date' then fl.value:value else null end AS end_date
                    ,case when fl.value:name = 'Income <= FPL' then fl.value:value else null end AS INCOME_LT_EQUAL_FPL                                
                    ,case when fl.value:name = 'Initial Determination' then fl.value:value else null end AS initial_determination             
                    ,case when fl.value:name = 'Denial Reason' then fl.value:value else null end AS denial_reason             
                    ,case when fl.value:name = 'Immigration Status' then fl.value:value else null end AS immigration_status
                    ,case when fl.value:name = 'Aid Category' then fl.value:value else null end AS aid_category
                    ,case when fl.value:name = 'VACV HPE Exception' then fl.value:value else null end AS hpe_exception
                    ,case when fl.value:name = 'VACV HPE Status' then fl.value:value else null end AS hpe_status
                    ,case when fl.value:name = 'First Name' then fl.value:value else null end AS first_name
                    ,case when fl.value:name = 'Middle Initial' then fl.value:value else null end as middle_initial
                    ,case when fl.value:name = 'Last Name' then fl.value:value else null end as last_name
                    ,case when fl.value:name = 'DOB' then fl.value:value else null end as dob
                    ,case when fl.value:name = 'Gender' then fl.value:value else null end as gender
                    ,case when fl.value:name = 'Residence Address City/County' then fl.value:value else null end as RES_ADDRESS_CITY_COUNTY
                    ,case when fl.value:name = 'Household Size' then fl.value:value else null end as household_size
                    ,case when fl.value:name = 'Monthly Income' then fl.value:value else null end as monthly_income
                    ,case when fl.value:name = 'Student' then fl.value:value else null end as student
                    ,case when fl.value:name = 'Babies expected' then fl.value:value else null end as babies_expected
                    ,case when fl.value:name = 'Pregnancy Due Date' then fl.value:value else null end as pregnancy_due_date
                    ,case when fl.value:name = 'Resident Of State' then fl.value:value else null end as resident_of_state
                    ,case when fl.value:name = 'US Citizen Or Legal Alien' then fl.value:value else null end as CITIZEN_OR_LEGAL_RES            
                    ,case when fl.value:name = 'Current HPE Exhausted' then fl.value:value else null end as CURRENT_HPE_EXHAUSTED
                    ,case when fl.value:name = 'VACV Language' then fl.value:value else null end as language      
                    ,case when fl.value:name = 'Address Line 1' then fl.value:value else null end as ADDRESS_1
                    ,case when fl.value:name = 'Address Line 2' then fl.value:value else null end as ADDRESS_2
                    ,case when fl.value:name = 'Address City' then fl.value:value else null end as CITY
                    ,case when fl.value:name = 'Address State' then fl.value:value else null end as STATE
                    ,case when fl.value:name = 'Address Zip' then fl.value:value else null end as ZIP_CODE
                    ,case when fl.value:name = 'VACV LDSS Locality' then fl.value:value else null end as ldss_locality
                    ,case when fl.value:name = 'SSN' then fl.value:value else null end as SSN
                    ,case when fl.value:name = 'Race' then fl.value:value else null end as race
                    ,case when fl.value:name = 'Home Phone Number' then fl.value:value else null end as home_phone_number
                    ,case when fl.value:name = 'Had Foster Care Age 18' then fl.value:value else null end as HAD_FOSTER_CARE_AGE_18
                    ,case when fl.value:name = 'Breast Cervical Cancer' then fl.value:value else null end as breast_cervical_cancer                         
                    ,case when fl.value:name = 'Provider Name' then fl.value:value else null end as provider_name
                    ,case when fl.value:name = 'NPI' then fl.value:value else null end as provider_npi            
                    ,case when fl.value:name = 'Submitter Name' then fl.value:value else null end as submitted_by_name
                    ,case when fl.value:name = 'Submitter Title' then fl.value:value else null end as submitted_by_title 
                    ,case when fl.value:name = 'Work Phone Number' then fl.value:value else null end as SUBMITTED_BY_WORK_PHONE
                    ,case when fl.value:name = 'Email Address' then fl.value:value else null end as SUBMITTED_BY_EMAIL_ADDRESS              
             
                    ,case when fl.value:name = 'Adult_DOB' then fl.value:value else null end as ADULT_DOB
                    ,case when fl.value:name = 'NoteText1' then fl.value:value else null end as HPE_NOTE_1             
                    ,case when fl.value:name = 'NoteText2' then fl.value:value else null end as HPE_NOTE_2
             
             
                 FROM fl                                      
               
           ) na group by 1,2 ) nas
                 ON je.EVENT_ID = nas.EVENT_ID AND je.PROJECT_ID = nas.PROJECT_ID
 ;