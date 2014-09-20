
update CORP_ETL_COMPLAINTS_INCIDENTS
set incident_about = 'Program'
    ,incident_reason = 'MA'
    ,action_comments = 'Closing complaint.  This is not a complaint.  Sending as defect.  Ryann W referred to supervisor'
where incident_id =  26060635;

update CORP_ETL_COMPLAINTS_INCIDENTS
set incident_about = 'CBIC Referral/Address Change'
    ,incident_reason = 'CBIC Card Requested/Address Change'
    ,action_comments = 'returned to rep closing inquiry
exh13: Please follow approved fast alerts to update the information.
Correct spelling is on NYHBE app. CBIC
REFERRED TO SUPERVISOR"'
    ,incident_description = CAST(q'[Case #: AC0000654738 Recipient’s County (In eMedNY): 06  CHAUTAUQUA   Caller’s Name:         RAEGEN DYE  Caller’s Phone #:716-720-0339  Caller’s relationship to recipient who moved/needs CBIC: SELF Recipient’s CIN or SSN:EN25837Q/087787611  New Address :  Mailing or Residence: 2015 EAST MAIN ST, FALCONER, NY 14733 Date of Move (if actual date is unknown, ask for approx date):  Names of everyone who moved including their case #:   Name of person needing a replacement card (if applicable): RAEGEN DYE  CONSUMER'S NAME WAS ALSO SPELLED INCORRECTLY, SHOULD BE "RAEGEN" ]' as VARCHAR2(4000))
where incident_id =  26091200;


update CORP_ETL_COMPLAINTS_INCIDENTS
set incident_about = 'Health Plan'
    ,resolution_description = 'plan contacted member'
    ,incident_reason = 'ENROLLMENT'
    ,action_comments = '"issue resolved
working with Empire<action/>
Reviewed application. Reviewed enrollment history and events tab. Explained complaint process. No time frames indicated. Forwarded complaint to supervisor. (clm)"'
    ,incident_description = CAST(q'[Urgent Medical Need AC#:AC0000350396  HX#:HX0000453187 Callers first and last name: Veronica Campanelli Caller's Phone Number: 8453582529 DOB: 09-11-1970 SSN: 081625053 Eligibility determination date: 11/25/2013 Is the caller enrolled through the small business marketplace or the individual marketplace>? Individual If SBM, employer group name? n/a Did the caller receive a plan card (QHP/MMC)? Yes, QHP Did the caller receive a CBIC (if yes, provide CIN)?: n/a What coverage appears in eMedNY (FFS/MMC/None)? n/a What did the plan tell the caller? Description of call:? The health plan three-way called into the NYSOH today to see if we change the end date her application/directly transmit the effective end date for the previous plan, Empire Platinum Guided Access – ceaf plan to 3/31/2014. At this time our system is showing her effective end date for 5-31-2014. Consumer purchased coverage off of the marketplace through an Aetna plan. The consumer is post-surgery and is pending radiation treatment the empire plan did not cover/was not going to cover which is why the consumer indicates she called the NYSOH at the end of March to verify and end date for her insurance of 3-31-14. The consumer has been trying day after day to resolve this issue. When the provider(S) she is trying to access the these treatment/services from look her information for billing purposes, the Aetna coverage that she currently actively enrolled in will not allow claims due to the Empire still showing in the system with an effective end date of 5-31-14. Health plan verified that in their system she is showing having an effective end date of 5-31-14, though she did not pay the last two months (April and May). Urgent. Is the caller being denied an urgent medical service/prescription? Yes, Aetna which is active will not cover the services because Empire still showing the system as active. Date & Time the medical appointment is scheduled? ASAP How many days of medication does the caller have left?n/a Provider Name:n/a Provider Phone Number:n/a (clm)  ]' as VARCHAR2(4000))
where incident_id =  26097670;

update CORP_ETL_COMPLAINTS_INCIDENTS
set incident_about = 'CBIC Referral/Address Change'   
    ,incident_reason = 'CBIC Card Requested/Address Change'
    ,action_comments = '"
axh20: DOH generated 2 CBICs. Changed priority from 5 to 3.
5/13/14- Refer to DOH
REFERRED TO SUPERVISOR"'
    ,incident_description = CAST(q'[CASE# AC0001695379 CBIC#TQ03704P RECIPIENT'S COUNTY  60  NEW YORK CALLER PHONE: 212-662-4607 CALLER'S RELATIONSHIP TO RECIPIENT: PARENT ADDRESS: 131 ST. NICHOLAS AVENUE, APT 14B, NEW YORK, NY 10026 NAME OF PERSON NEEDING CIN: JAVIA ROBERTS DOB:03/03/1997 SSN:230777541 *************************************** CASE#: AC0001695379 CBIC# TQ03694H RECIPIENT'S COUNTY: #14 (ERIE ) CALLER NAME: ADRIELLA ROBERTS CALLER PHONE#: 212-662-4607 CALLER'S RELATIONSHIP TO RECIPIENT: PARENT NEW ADDRESS:  MAILING OR RESIDENCE: 131 ST. NICHOLAS AVENUE APT 14B, NEW YORK, NY 10026 DATE OF MOVE:  NAMES OF EVERYONE WHO MOVED/CASE NAME AND CIN OF PERSON NEEDING CARD: ADRIELLA ROBERTS DOB: 003/19/1999     SSN: 093-88-7689 ]' as VARCHAR2(4000))
where incident_id =  26094445;

update CORP_ETL_COMPLAINTS_INCIDENTS
set incident_about = 'CBIC Referral/Address Change'   
    ,incident_reason = 'CBIC Card Requested/Address Change'
    ,action_comments = '"
Kxs37: DOH generated CBIC.
5/13/14- Refer to Doh
5/13/14- Refer to DOH
REFERRED TO SUPERVISOR"'
    ,incident_description = CAST(q'[CASE# AC0001670883 CBIC# SE59206Q RECIPENT'S COUNTY# 58  BRONX CALLER NAME: PEGGY RIVERA  PARENT  CALLER PHONE:917-704-2268 ADDRESS: 1715 RANDALL AVENUE, BRONX, NY 10473 NAME OF PERSON NEEDING CBIC CARD: JASMINE CRUZ/SE59206Q CONSUMER DOB: 04/16/2002  SS# 061-92-9005 ]' as VARCHAR2(4000))
where incident_id =  26094424;

update CORP_ETL_COMPLAINTS_INCIDENTS
set incident_about = 'Program'   
    ,incident_reason = 'APTC/CSR/QHP'
    ,action_comments = '"
As per note below, complaint closed.
Updated to submitting a Defect Form for this account.
Advised Consumer that their account will be reviewed relative to their request to be able to pick a plan."'
    ,incident_description = CAST(q'[Account Number: AC0001158986  HX Number:  HX0001296591 Caller's First and Last Name: Danielle Davis-Conklin SSN: 115-64-2691  DOB:  01-12-1974 Eligibility Determination date: 5/22/2014 Is caller enrolled in a QHP/Dental Plan in the Individual Marketplace or Small Business Marketplace? n/a If SBM, employer group name: n/a  Did the caller receive a Plan Card (QHP/MMC)?: n/a  Did the caller receive a CBIC (if yes, provide CIN)?: n/a  What coverage appears in eMedNY (FFS/MMC/None)?: n/a  What did the plan tell the caller?: n/a  Description of call:  Consumer signed up for QHP using SEP that their coverage ended 3-30-2014.  It gives APTC and CSR and it gives the kids CHP but will not let a plan get picked for the parents. Is the caller being denied an urgent medical service/prescription? n/a Date & Time the medical appointment is scheduled? n/a How many days of medication does the caller have left? n/a Provider Name:n/a  Provider Phone Number: n/a  ]' as VARCHAR2(4000))
where incident_id =  26103692;

update CORP_ETL_COMPLAINTS_INCIDENTS
set incident_about = 'Exchange Application Service'   
    ,incident_reason = 'OTHER - EXCHANGE APPLICATION SERVICE'
    ,action_comments = '"
reference#26266105 dual complaints- kxm24
-Consumer contacted NYSOH to get status update regarding SEP request. While attempting to help Consumer, NYSOH Representative disenrolled Consumer from coverage.

-SEP was originally filed as Consumer was assured by OBGYN that QHP would be accepted. Consumer then was informed that the hospital affiliated with OBGYN was no longer accepting the coverage, and if Consumer gave birth at that facility the bills would not be covered. Consumer now requesting SEP for the original reason, but now, due to NYSOH representative error, is requesting SEP to simply have coverage at all. Jim M.
reopening from task  26147422

Reopened from previous task. Consumer is stating that the plan website stated that her provider participated in. Steps taken are listed.

•       The applicant made reasonable efforts to determine if a provider participated in certain plans but due to the incorrect or misleading information regarding network participation, including information provided through the Marketplace, the applicant chose a plan and afterward found that a key provider does not participate with the plan selected.

06/23/2014 12:01 PM     6/23/14- Consumer called to check the status of her submitted complaint. Consumer states that her OB/GYN is the only one in her area that accepts Metro Plus, however the physcian will no longer be participating effective 7/1/14.  Consumer also stated that the two hospitals in her do not accept the coverage. But NorthShore LIJ does, the issue with that is her OB/GYN does not go to that facility.  Consumer is seeking SEP to change health plans.  Consumer states she contacted Metro Plus and insurance co referred consumer to their website. Consumer states she did contact the providers listed on the site, but was told they do not participate in the health plan.
06/14/2014 12:01 PM     Contact applicant.  No inappropriate action taken, therefore SEP is denied based on limited information provided.  Member must use plan providers and cannot change after open enrollment.  CDP/DOH.  
05/12/2014 12:54 PM     {No Action Recorded}
05/10/2014 10:50 AM     Caller inquired about the status of the SEP because she needs prenatal coverage. Caller asks that someone be in contact with her when the SEP is approved.
05/08/2014 02:28 PM     Complaint filed on behalf of consumer. JasonK
"'
    ,incident_description = CAST(q'[SPECIAL ENROLLMENT Account Number: AC0001594438  HX Number: HX0002036390 Caller's First and Last Name: Yimin Liu Caller's Phone Number: 9173280666 SSN: 486 25 5635 DOB: 11/21/83 CSS actions and why referring to DOH SPECIAL ENROLLMENT: Hospital for pre-natal coverage isn't covered under MetroPlus and wants to change to Affinity. Consumer used plan website and hospital was listed.  ]' as VARCHAR2(4000))
where incident_id =  26127886;

update CORP_ETL_COMPLAINTS_INCIDENTS
set incident_about = 'Exchange Application Service'   
    ,incident_reason = 'Urgent Medical Need'
    ,action_comments = '"
Claim# 26266105- duplicate closing task. kxm24
Claim# 26266105- duplicate closing task. kxm24
-Consumer contacted NYSOH to get status update regarding SEP request. While attempting to help Consumer, NYSOH Representative disenrolled Consumer from coverage.

-SEP was originally filed as Consumer was assured by OBGYN that QHP would be accepted. Consumer then was informed that the hospital affiliated with OBGYN was no longer accepting the coverage, and if Consumer gave birth at that facility the bills would not be covered. Consumer now requesting SEP for the original reason, but now, due to NYSOH representative error, is requesting SEP to simply have coverage at all. Jim M.
Refer to State-Application Support



07/07/2014 03:32 PM     closed reopened
06/23/2014 12:01 PM     6/23/14- Consumer called to check the status of her submitted complaint. Consumer states that her OB/GYN is the only one in her area that accepts Metro Plus, however the physcian will no longer be participating effective 7/1/14.  Consumer also stated that the two hospitals in her do not accept the coverage. But NorthShore LIJ does, the issue with that is her OB/GYN does not go to that facility.  Consumer is seeking SEP to change health plans.  Consumer states she contacted Metro Plus and insurance co referred consumer to their website. Consumer states she did contact the providers listed, but was told they do not participate in the health plan.
06/14/2014 12:01 PM     Contact applicant.  No inappropriate action taken, therefore SEP is denied based on limited information provided.  Member must use plan providers and cannot change after open enrollment.  CDP/DOH.  
05/12/2014 12:54 PM     {No Action Recorded}
05/10/2014 10:50 AM     Caller inquired about the status of the SEP because she needs prenatal coverage. Caller asks that someone be in contact with her when the SEP is approved.
05/08/2014 02:28 PM     Complaint filed on behalf of consumer. JasonK
"'
    ,incident_description = CAST(q'[SPECIAL ENROLLMENT  Account Number: AC0001594438  HX Number: HX0002036390 Caller's First and Last Name: Yimin Liu Caller's Phone Number: 9173280666 SSN: 486 25 5635 DOB: 11/21/83 CSS actions and why referring to DOH SPECIAL ENROLLMENT: Hospital for pre-natal coverage isn't covered under MetroPlus and wants to change to Affinity.]' as VARCHAR2(4000))
where incident_id =  26142179;