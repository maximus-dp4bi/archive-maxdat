-- Insert all BPM_ATTRIBUTE_LKUP data needed by a BPM process.
-- Ignore duplicate insert attempts.

declare
begin

-- BDL_ID is (NUMBER=1, VARCHAR=2, DATE=3)
-- BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(BAL_ID,BDL_ID,NAME,PURPOSE);

  /* Run this select SQL on the canonical database MAXDTDEV.
  select '  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(' || bal.BAL_ID || ',' || bal.BDL_ID || ',''' || bal.NAME || ''',''' || bal.PURPOSE || ''');' insert_bal
  from BPM_ATTRIBUTE ba
  inner join BPM_ATTRIBUTE_LKUP bal on (ba.BAL_ID = bal.BAL_ID)
  where ba.BEM_ID = 23
  order by bal.BAL_ID asc;
  */

  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(5,3,'Complete Date','The date the instances is first set to a completed status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(7,3,'Create Date','This is the date that the instance was created in the MAXe system');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(8,2,'Created By Name','Name of the staff member that created the instance in MAXe. This name should be formatted as:Last, First MI or when no middle initial exists then Last, First');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(17,2,'Last Update By Name','Name of the staff member that last updated the instance in MAXe. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(18,3,'Last Update Date','Date the instance was last updated in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(47,3,'Cancel Date','The date when the instance was cancelled');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(49,2,'Channel','The Channel identifies the channel from which the document was originally received (mail or fax) into KOFAX or via the Web.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(60,1,'Current Task ID','Task ID identifying the current task for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(65,3,'Instance Complete Date','The date the batch was successfully released to DMS, cancelled, or otherwise deleted.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,2,'Instance Status','Instance Status indicates if the batch is in process or not. When the batch is created the status is set to Active, and it remains open until the batch has been successfully released to DMS,  is cancelled, or otherwise deleted when it is then set to Complete.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(100,3,'Receipt Date','The date the document was received in the Mailroom or by NYHBE system');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(143,3,'Stage Done Date','This is the date that the stage was completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(144,3,'Stage Last Update Date','This is the date that the most recent updates were performed on the instance.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(178,2,'Current Step','The Current Activity Step identifes where the instance is in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(451,1,'Incident ID','The Incident initiated by a document created for either a complaint or appeal ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(452,2,'Incident Tracking Number','The public ID of the complaint that is searchable and known to the outside world.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(453,2,'Created By Group','The system description for the Staff Group that the user was logged in as when the incident was created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(456,2,'Incident Status','The status of the incident in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(457,3,'Incident Status Date','Date/time when INCIDENT STATUS was set or updated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(458,2,'Action Type','Classifies the action taken by MMS staff on the incident.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(459,2,'Action Comments','Free text field to document Actions taken to the incident.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(460,2,'Resolution Type','Classifies resolution determined by MMS staff on the incident.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(461,2,'Resolution Description','Free text field to document Incident Resolution');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(462,2,'Incident Type','High level description of the type of incident, defined by the project.  See Rules tab for mapping of valid values.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(463,2,'Incident About','Description of who/what the incident is about;  incident about is a subset of INCIDENT TYPE and provides more detailed groupings of incident types.');
 -- BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(464,2,'Incident Reason','The reason provided by the reporter for submitting the incident; incident reason is a subset of INCIDENT ABOUT and provides more detailed groupings.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(466,1,'About Provider ID','The MAXeb unique identifier for the provider about whom the reporter is making a complaint.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(467,2,'About Plan Code','The MAXeb unique identifier for the plan about which the reporter is making a complaint.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(468,2,'Reported By','Reporter classifies the individual or organization that has reported the incident to MAXIMUS (head of case, other adult, non-covered member, health plan, etc).  It is not the name of the individual.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(469,2,'Reporter Relationship','The relationship of the reporter to the entity involved in the complaint.  If the complaint is about something that affects the reporter, then the code might be "self". If the complaint affects the reporters child, it might be "parent" or "legal guardian".');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(474,2,'Other Party Name','A brief description of an affected party such as the name of a CSR.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(479,1,'Case ID','Unique identifier associated to the case level task in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(547,2,'Cancel Reason','The reason that the instance is cancelled');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(576,2,'Cancel By','The name of the system or performer who cancelled the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(699,3,'Stage Extract Date','Date ETL instance was extracted/inserted');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(722,2,'Cancel Method','This is the method as per which the instance was cancelled');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1272,1,'Linked Client','The client that the document is associated with ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1333,2,'Priority','An assignment by the project to group incidents such that they can be completed outside first-in-first-out (FIFO) strategy.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1337,3,'Gather Missing Information Start','The time/date stamp when the activity step starts.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1338,3,'Gather Missing Information End','The time/date stamp when the activity step ends.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1339,2,'Gather Missing Information Performed By','The user who performs the activity.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1499,2,'Incident Description','Free text field to document Incident description');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1543,2,'Advise to Withdraw in Writing','Advise to Withdraw in Writing Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1544,3,'Advise to Withdraw in Writing End','The time/date stamp when the activity step ends.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1545,2,'Advise to Withdraw in Writing Performed By','The person who sets the status that ends the activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1546,3,'Advise to Withdraw in Writing Start','The time/date stamp when the activity step starts.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1547,3,'Appeal Hearing Date','Date of the Hearing.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1548,2,'Appeal Potentially Invalid Flag','Appeal Potentially Invalid Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1549,2,'Appeal Resolved Flag','Appeal Resolved Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1550,2,'Appeal Timeliness Status','The IDR Timeliness Status indicates whether an incident is completed in the process within the business defined thresholds.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1551,2,'Appeal Valid Flag','Appeal Valid Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1552,2,'Cancel Hearing','Cancel Hearing Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1553,3,'Cancel Hearing End','The time/date stamp when the activity step ends.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1554,3,'Cancel Hearing Start','The time/date stamp when the activity step starts.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1555,2,'Cancel Hearing Performed By','The person who sets the status that ends the activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1556,2,'Change in Eligibility Flag','Change in Eligibility Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1557,2,'Channel Gateway Flag','Channel Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1558,2,'Conduct Hearing Process','Conduct Hearing Process Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1559,3,'Conduct Hearing Process End','The time/date stamp when the activity step ends.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1560,3,'Conduct Hearing Process Start','The time/date stamp when the activity step starts.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1561,2,'Conduct Hearing Process Performed By','The person who sets the status that ends the activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1562,2,'Conduct State Review','Conduct State Review Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1563,3,'Conduct State Review End','The time/date stamp when the activity step ends.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1564,3,'Conduct State Review Start','The time/date stamp when the activity step starts.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1565,2,'Conduct State Review Performed By','The person who sets the status that ends the activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1566,2,'Conduct Validity Check','Conduct Validity Check Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1567,3,'Conduct Validity End','The time/date stamp when the activity step ends.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1568,3,'Conduct Validity Start','The time/date stamp when the activity step starts.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1569,2,'Conduct Validity Performed By','The person who sets the status that ends the activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1570,2,'Gather Missing Information','Gather Missing Information Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1571,2,'Process Validity Amendment','Process Validity Amendment Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1572,3,'Process Validity Amendment End','The time/date stamp when the activity step ends.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1573,3,'Process Validity Amendment Start','The time/date stamp when the activity step starts.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1574,2,'Process Validity Amendment Performed By','The person who sets the status that ends the activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1575,2,'Review Appeal','Review Appeal Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1576,3,'Review Appeal End','The time/date stamp when the activity step ends.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1577,3,'Review Appeal Start','The time/date stamp when the activity step starts.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1578,2,'Review Appeal Performed By','The person who sets the status that ends the activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1579,2,'Review by SHOP Desk','Review by SHOP Desk Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1580,2,'Schedule Hearing','Schedule Hearing Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1581,3,'Schedule Hearing End','The time/date stamp when the activity step ends.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1582,3,'Schedule Hearing Start','The time/date stamp when the activity step starts.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1583,2,'Schedule Hearing Performed By','The person who sets the status that ends the activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1584,2,'Shop Review Flag','Shop Review Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1585,3,'SHOP Desk Review Information End','The time/date stamp when the activity step ends.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1586,3,'SHOP Desk Review Information Start','The time/date stamp when the activity step starts.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1587,2,'SHOP Desk Review Information Performed By','The person who sets the status that ends the activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1588,2,'Withdrawn In Writing Flag','Withdrawn In Writing Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1589,2,'About Plan Name','Plan name associated to About Plan Id');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1590,2,'About Provider Name','Provider name associated to About Provider Id');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1592,1,'Expected Appeal Request','Expected Appeal Request');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1593,2,'Aid to Continue','Aid to Continue is a checkbox indicating when the appellant indicates they would like to apply for Aid to Continue in the NYHBE portal. ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1594,2,'Appeal Date','The date and time the appeal was entered through the NYHBE system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1595,2,'Appeal Hearing Location','The address of the Hearing location.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1596,2,'Appeal Hearing Time','Time of the Hearing.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1597,2,'Appellant Type','Type of appellant');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1598,2,'Appellant Type Description','Description of the Appellant Type');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1599,2,'Requested Hearing Day','Requested Day of the week for the hearing to occur');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1600,2,'Requested Hearing Time','Requested time of the day for the hearing to occur - AM or PM');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1603,3,'Received Date','Captured as an index field during document processing and is transmitted to DMS as XML for XSD Document Type= Incident AND XSD Form Type = Appeal. It is the create_ts from the doc_link table in the source');

  commit;

end;
/