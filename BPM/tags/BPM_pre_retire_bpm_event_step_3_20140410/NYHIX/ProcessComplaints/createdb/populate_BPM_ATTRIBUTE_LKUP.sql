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
  where ba.BEM_ID = 22
  order by bal.BAL_ID asc;
  */
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1480,3,'Attempt to Resolve Incident (Supervisor) Start','The time/date stamp when the activity step starts.  
  -- This should be when the supervisor opens the Incident.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1479,3,'Attempt to Resolve Incident (Supervisor) End','The time/date stamp when the activity step ends.  
  -- This should be when the status of the Incident is changed to "Closed" or "Refer to DOH."');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1478,3,'Resolve Incident Start Dt','The time/date stamp when the activity step starts.  
  -- This should be when the specialist opens the Incident ');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1477,3,'Resolve Incident End Dt','The time/date stamp when the activity step ends. 
  -- This should be when the status of the Incident is changed to "Closed" or "Refer to Supervisor" or "Refer to DOH."');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (65,3,'Instance Complete Date','The date the batch was successfully released to DMS, cancelled, or otherwise deleted.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (66,2,'Instance Status','Instance Status indicates if the batch is in process or not. When the batch is created the status is set to Active, and it remains open until the batch has been successfully released to DMS,  is cancelled, or otherwise deleted when it is then set to Complete.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (451,1,'Incident ID','The Incident initiated by a document created for either a complaint or appeal ');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (47,3,'Cancel Date','The date when the instance was cancelled');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (49,2,'Channel','The Channel identifies the channel from which the document was originally received (mail or fax) into KOFAX or via the Web.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (61,1,'Data Entry Task ID',' Task ID for DE Task');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (884,2,'Last Updated By','Last user to update the document in MAXe');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1341,2,'Forwarded To','Describes the highest level of forwarding to which the incident was sent for processing.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1,1,'Age in Business Days','Number of days from the Create Date to the Complete Date, or to the Current Date for instances that are not yet complete, excluding weekends and project holidays.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (2,1,'Age in Calendar Days','Number of days from the Create Date to the Complete Date, or to the current date for instances that are not yet complete.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (7,3,'Create Date','This is the date that the instance was created in the MAXe system');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (8,2,'Created By Name','Name of the staff member that created the instance in MAXe. This name should be formatted as:Last, First MI or when no middle initial exists then Last, First');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (16,2,'Jeopardy Flag','Indicates if the application is in jeopardy based on the SLA Days Type and SLA Jeopardy Days. Default value is "N"');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (17,2,'Last Update By Name','Name of the staff member that last updated the instance in MAXe. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (18,3,'Last Update Date','Date the instance was last updated in MAXe');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (21,2,'SLA Days Type','Indicates if the SLA Days is based on Business Days or Calendar Days. If no SLA applies then this value is null. ');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (22,1,'SLA Jeopardy Days','Age at which time the measured cycle is determined to be in Jeopardy. If no SLA applies then this value is null. This value should be easily configured and will initially be set to 2 for all instances.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (23,1,'SLA Target Days','Age at which time the measured cycle is determined to be untimely based on target goals set by the business. If no target has been defined then this value is null.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (35,2,'Timeliness Status','Indicates if the instance was processed timely or untimely based on the SLA Days Type, SLA Days, and age or cycle days. Default value is Not Required');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (593,1,'Client ID','Unique identifier associated to the client level task in MAXe');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (479,1,'Case ID','Unique identifier associated to the case level task in MAXe');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (722,2,'Cancel Method','This is the method as per which the instance was cancelled');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (547,2,'Cancel Reason','The reason that the instance is cancelled');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (576,2,'Cancel By','The name of the system or performer who cancelled the instance');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1270,2,'Jeopardy Days Type','Type of days for Jeopardy Business or Calendar');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1540,2,'Incident Forwarding Target',' Incident Forwarding Target -State');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1539,2,'Incident Forwarding Timeliness Status','Incident Forwarding Timeliness Status -State');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1538,2,'Return to State Flag','Return to the State?');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1537,2,'FollowUp Req Flag','Follow-up Required?');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1536,2,'Resolved SUP Flag','Resolved? (SUP)');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1535,2,'Resolved EES CSS Flag','Resolved? (EES/CSS, Complex Gateway)');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1534,2,'Withdraw Incident Flag','Withdraw Incident');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1533,2,'Perform FollowUp Flag','Perform Follow-up Actions');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1532,2,'Resolve Incident DOH Flag','Resolve Incident');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1531,2,'Resolve Incident SUP Flag','Attempt to Resolve Incident (Supervisor)');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1530,2,'Resolve Incident EES CSS Flag','Attempt to Resolve Incident (EE Specialist or CSS)');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1516,2,'Forwarded ','Describes whether the incident was forwarded for processing.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1499,2,'Incident Description','Free text field to document Incident description');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1486,3,'Perform Follow-up Actions Start','The time/date stamp when the activity step starts.  
  -- This should be when MAXIMUS opens the Incident in the status "Refer to Maximus"');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1485,3,'Perform Follow-up Actions End','The time/date stamp when the activity step ends.
  -- This should be when the status of the Incident is changed to "Closed"  or "Refer to State"');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1484,3,'Withdraw Incident Start','The time/date stamp when the activity step starts.  
  -- This should be when the status of the Incident is changed to "*Withdrawn*"');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1483,3,'Withdraw Incident End','The time/date stamp when the activity step ends.  
  -- This should be when the status of the Incident is changed to "*Withdrawn*"');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1482,3,'Resolve Incident Start','The time/date stamp when the activity step starts.
  -- This should be when the state receives the Incident.  ');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1481,3,'Resolve Incident End','The time/date stamp when the activity step ends.  
  -- This should be when the status of the Incident is changed to "Closed" or "Refer to Maximus."');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (474,2,'Other Party Name','A brief description of an affected party such as the name of a CSR.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (469,2,'Reporter Relationship','The relationship of the reporter to the entity involved in the complaint.  If the complaint is about something that affects the reporter, then the code might be "self". If the complaint affects the reporters child, it might be "parent" or "legal guardian".');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (468,2,'Reported By','Reporter classifies the individual or organization that has reported the incident to MAXIMUS (head of case, other adult, non-covered member, health plan, etc).  It is not the name of the individual.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (467,2,'About Plan Code','The MAXeb unique identifier for the plan about which the reporter is making a complaint.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (466,1,'About Provider ID','The MAXeb unique identifier for the provider about whom the reporter is making a complaint.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (464,2,'Incident Reason','The reason provided by the reporter for submitting the incident; incident reason is a subset of INCIDENT ABOUT and provides more detailed groupings.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (463,2,'Incident About','Description of who/what the incident is about;  incident about is a subset of INCIDENT TYPE and provides more detailed groupings of incident types.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (462,2,'Incident Type','High level description of the type of incident, defined by the project.  See Rules tab for mapping of valid values.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (461,2,'Resolution Description','Free text field to document Incident Resolution');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (460,2,'Resolution Type','Classifies resolution determined by MMS staff on the incident.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (459,2,'Action Comments','Free text field to document Actions taken to the incident.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (458,2,'Action Type','Classifies the action taken by MMS staff on the incident.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (457,3,'Incident Status Date','Date/time when INCIDENT STATUS was set or updated.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (456,2,'Incident Status','The status of the incident in MAXeb.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (455,1,'Priority','An assignment by the project to group incidents such that they can be completed outside first-in-first-out (FIFO) strategy.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (453,2,'Created By Group','The system description for the Staff Group that the user was logged in as when the incident was created.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (452,1,'Incident Tracking Number','The public ID of the complaint that is searchable and known to the outside world.');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (60,1,'Current Task ID','Task ID identifying the current task for the instance');
  insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1591,2,'Followup Flag','The Follow-Up Checkbox Flag indicates whether the state requests follow-up tasts from Maximus');
  Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1601,3,'Forward DT','The date when the complaint is forwarded to state the first time');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1606,2,'Reporter Phone','The Phone number of the individual who submitted the incident.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1607,2,'SLA Satisfied','The Phone number of the individual who submitted the incident.');
  Insert into bpm_attribute_lkup (BAL_ID,BDL_ID,NAME,PURPOSE) values (505,2,'Reporter Name','The name of the individual who submitted the incident.');
  commit;

end;
/