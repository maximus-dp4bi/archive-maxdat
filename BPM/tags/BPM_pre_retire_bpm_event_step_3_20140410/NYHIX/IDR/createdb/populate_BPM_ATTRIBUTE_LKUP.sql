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
  where ba.BEM_ID = 14
  order by bal.BAL_ID asc;
  */
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(451,1,'Incident ID','Incident ID is the MAXeb defined unique identifier assigned to each incident created in the system.'); 
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(453,2,'Created By Group','The system description for the Staff Group that the user was logged in as when the incident was created.'); 
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(8,2,'Created By Name','Name of the staff member that created the instance in MAXe. This name should be formatted as:Last, First MI or when no middle initial exists then Last, First');  
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(452,1,'Incident Tracking Number','The public ID of the complaint that is searchable and known to the outside world.'); 
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(7,3,'Create Date','This is the date that the instance was created in the MAXe system');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(462,2,'Incident Type','High level description of the type of incident, defined by the project.  See Rules tab for mapping of valid values.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(593,1,'Client ID','The client id/s included in the letter request.  This list should NOT include any clients associated to a case that are NOT included in the letter (e.g. - for general notifications sent to the case head that do not include client names, this will be null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1334,3,'Review Documentation Start','The time/date stamp when the activity step starts.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1335,3,'Review Documentation End','The time/date stamp when the activity step ends.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1336,2,'Review Documentation Performed By','The user who performs the activity.');  
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1337,3,'Gather Missing Information Start','The time/date stamp when the activity step starts.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1338,3,'Gather Missing Information End','The time/date stamp when the activity step ends.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1339,2,'Gather Missing Information Performed By','The user who performs the activity.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(467,2,'About Plan Code','The MAXeb unique identifier for the plan about which the reporter is making a complaint.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(466,1,'About Provider ID','The MAXeb unique identifier for the provider about whom the reporter is making a complaint.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(459,2,'Action Comments','Free text field to document Actions taken to the incident.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(458,2,'Action Type','Classifies the action taken by MMS staff on the incident.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(777,2,'Cancelled By','The person or system that cancelled the instance in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(47,3,'Cancel Date','Indicates the date the ETL discovered that the instance was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(722,2,'Cancel Method','This is the method as per which the instance was cancelled');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(547,2,'Cancel Reason','The reason that the JOB ID instance is cancelled.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(60,1,'Current Task ID','Task ID identifying the current task for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(475,2,'Enrollment Status','Describes the enrollment status for the enrollee or potential enrollee with whom the incident is associated when the incident is associated to a case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(463,2,'Incident About','Description of who/what the incident is about;  incident about is a subset of INCIDENT TYPE and provides more detailed groupings of incident types.');
  
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(464,2,'Incident Reason','The reason provided by the reporter for submitting the incident; incident reason is a subset of INCIDENT ABOUT and provides more detailed groupings.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(456,2,'Incident Status','The status of the incident in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(457,3,'Incident Status Date','Date/time when INCIDENT STATUS was set or updated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(65,3,'Instance Complete Date','Date the instance reached a terminal point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,2,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(17,2,'Last Update By Name','Name of the staff member that last updated the instance in MAXe. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(18,3,'Last Update Date','Date the instance was last updated in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(884,2,'Last Update By','The username of the person who last updated the Outreach Request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(474,2,'Other Party Name','A brief description of an affected party such as the name of a CSR.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(455,1,'Priority','An assignment by the project to group incidents such that they can be completed outside first-in-first-out (FIFO) strategy.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(468,2,'Reported By','Reporter classifies the individual or organization that has reported the incident to MAXIMUS (head of case, other adult, non-covered member, health plan, etc).  It is not the name of the individual.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(469,2,'Reporter Relationship','The relationship of the reporter to the entity involved in the complaint.  If the complaint is about something that affects the reporter, then the code might be "self". If the complaint affects the reporters child, it might be "parent" or "legal guardian".');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(460,2,'Resolution Type','Classifies resolution determined by MMS staff on the incident.');
  
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(479,1,'Case ID','The case identifier for the enrollee or potential enrollee submitting the incident if   when the incident is associated to a case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1340,2,'Forwarded','Describes whether the incident was forwarded for processing.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1341,2,'Forwarded To','Describes the highest level of forwarding to which the incident was sent for processing.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1268,3,'Jeopardy Date','First date on which the document is considered in Jeopardy, this is the date that the  document Jeopardy Flag was or will be set to Y');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1269,1,'Jeopardy Days','The age at which the instance is determined to be in jeopardy of becoming untimely');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1283,1,'Target Days','Age at which the document processing cycle is determined to be untimely based on target goals set by the business. If no target has been defined then this value is null. ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1,1,'Age in Business Days','Number of days from the Create Date to the Complete Date, or to the Current Date for instances that are not yet complete, excluding weekends and project holidays.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(2,1,'Age in Calendar Days','Number of days from the Create Date to the Complete Date, or to the current date for instances that are not yet complete.');    
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(16,2,'Jeopardy Flag','Indicates if the application is in jeopardy based on the SLA Days Type and SLA Jeopardy Days. Default value is "N"');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1342,2,'IDR Timeliness Status','"The IDR Timeliness Status indicates whether an incident is completed in the process within the business defined thresholds.');  
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1270,2,'Jeopardy Days Type','Type of days for Jeopardy Business or Calendar');
  
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1343,2,'Rev IDR Docs Flag','Monitor if the IDR related documents were processed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1344,2,'Docs Received Flag','Monitor if the IDR related Missing Information was processed.	');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1345,2,'Continue Appeal Flag','Gateway Flag that signifies if an Appeal Incident needs to be created.');
   
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1499,2,'Incident Description','Free text field to document Incident description.'); 
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(461,2,'Resolution Description','Free text field to document Incident Resolution');
  
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(178,2,'Current Step','The Current Activity Step identifes where the instance is in the process.');
  
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1597,2,'Appellant Type','Type of appellant');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1598,2,'Appellant Type Description','Description of the Appellant Type');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1606,2,'Reporter Phone','The Phone number of the individual who submitted the incident.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(505,2,'Reporter Name','The name of the individual who submitted the incident.');
    
  commit;

end;
/