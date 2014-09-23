update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='x Eligibility Specialist A.' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='x Eligibility Specialist A.' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Account Review Unit / Non-Task' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Account Review Unit / Non-Task' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Mailroom' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Mailroom' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Data Entry - Verification Document' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Data Entry - Verification Document' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='UPK Training' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='UPK Training' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='KOFAX Mail QC' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='KOFAX Mail QC' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Free Form Follow-Up' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Free Form Follow-Up' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Pipkins Modification UPK' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Pipkins Modification UPK' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='CSS II - SHOP Bilingual' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='CSS II - SHOP Bilingual' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Quality Training' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Quality Training' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Irate Client' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Irate Client' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Awaiting Written Withdrawal' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Awaiting Written Withdrawal' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Complaint Training' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Complaint Training' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Fire Drill/ Evacuation' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Fire Drill/ Evacuation' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Returned Mail' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Returned Mail' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Identity Proofing' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Identity Proofing' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Awaiting Documentation' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Awaiting Documentation' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Appeals' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Appeals' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Document Management QC' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Document Management QC' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Un-Scheduled Break' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Un-Scheduled Break' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Flex Time' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Flex Time' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Authorized Rep' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Authorized Rep' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Application Missing Information' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Application Missing Information' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Awaiting Validity Check' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Awaiting Validity Check' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Eligibility Specialist C ' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Eligibility Specialist C ' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Document Problem Resolution' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Document Problem Resolution' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Idle Time' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Idle Time' and ATC.activity_type_category ='Unknown'
);

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Newborn - UPK' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Newborn - UPK' and ATC.activity_type_category ='Unknown'
);

commit;