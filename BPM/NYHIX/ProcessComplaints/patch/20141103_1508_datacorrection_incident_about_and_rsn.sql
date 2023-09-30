update CORP_ETL_COMPLAINTS_INCIDENTS
set incident_about = 'Exchange Application Service'
    ,resolution_description = 'Application showing that consumer answered "Yes" to the retro question. A referral should have been generated. Will call consumer to advise on how to proceed with obtaining a retro eligibility determination.'
    ,incident_reason = 'OTHER - EXCHANGE APPLICATION SERVICE'
    ,action_comments = '"
Application showing that consumer answered &quot;Yes&quot; to the retro question. A referral should have been generated. Will call consumer to advise on how to proceed with obtaining a retro eligibility determination.
sxn15: Forward to Dawn O. for Retro request prior to Jan 2014
Referred to MA/FHP.
REFERRED TO MA/ FHP"'
    ,incident_description = CAST(q'["CONSUMER DID NOT REQUEST RETRO ACTIVE COVERAGE AT TIME OF APPLICATION, HE ANSWER NO TO THE QUESTION  IF HE NEEDED HELP PAYING MEDICAL BILLS FROM THE LAST THREE MONTH BUT HE NEEDS ASSISTANCE TO DO SO NOW. HE WILL LIKE TO HAVE RETRO ACTIVE COVERAGE.

Updated Documentation Required for Consumers Requesting Coverage for Medical Bills Within 3 Months Prior to Application Month

Doc ID:                 ALT271
Version:                11.0
Status:                 Published
Published date:                 09/02/2014
Updated:                09/02/2014
 
Body

FAST ALERT
UPDATED 09/02/14:  DOCUMENTATION REQUIRED FOR CONSUMERS REQUESTING COVERAGE FOR MEDICAL BILLS
WITHIN 3 MONTHS PRIOR TO APPLICATION MONTH
IMPACTED AREAS: 

Contact Center - Individual Marketplace      

X
Contact Center - Small Business Marketplace
Contact Center - SWCC
Eligibility and Enrollment
X
Web Chat
Please review this entire alert as much of it has been updated.  Please note that instructions pertaining specifically to self-employed individuals and those eligible for emergency-only coverage appear at the end of this alert.

A consumer may check the “help paying for medical bills” checkbox at the time of application, as well as when making changes to their Marketplace account.  However, the process is different depending on the date of application and the timing of checking the “help paying for medical bills” checkbox.  NOTE: Currently, the Marketplace is not able to systematically provide coverage in the three month retro period for consumers eligible for emergency Medicaid only.  Please see the end of this alert for more details.

NOTE: While the question refers to “bills from the past 3 months”, this box is really meant for requesting help paying for medical bills received within 3 months prior to the application month.
Consumer Checked “Help Paying for Medeckbox at Initial Application
If a consumer answers “yes” to the question below at application (prior to an eligibility determination):
The consumer will be presented an additional question asking if their income provided has been the same for the last 3 months – this refers to the 3 months for which they’re requesting the coverage (not necessarily the last 3 months, depending on the date of application). 
If they answer yes and they are determined Medicaid eligible the system will systematically back date their coverage. If they answer yes and they are determined CHP/APTC/QHP eligible, the system will send their information to the district who will send out an application to determine whether they are eligible for Medicaid (spenddown) in the three months prior to application.  Refer to Medicaid Population-Specific Programs – Excess Income Fact Sheet-WI.10.02.02.0009.0213 for more information about the Excess Income/Spenddown program.
If they answer “no” to the question about whether their income is the same in the last three months, they will receive a request for documentation titled “Proof of Income for 3 Month Retroactive Coverage Period.”
In order to satisfy this documentation request, the consumer must submit documentation of household income for each month for which they are requesting Medicaid coverage to help pay medical bills.  The consumer will select the number of months they are requesting retro coverage for on the Eligibility screen as seen below. 
If the consumer is only requesting coverage for one of the three prior months, they only need to submit income documentation for that month.
DOH will review the submitted documentation and determine whether the consumer is eligible for Medicaid in the three months prior to application and will advise the consumer of their decision.  
Note: Individuals found eligible for CHP or APTC are able to request Medicaid coverage to help pay for their medical bills for the"  ]' as VARCHAR2(4000))
where incident_id =  26165759;

commit;