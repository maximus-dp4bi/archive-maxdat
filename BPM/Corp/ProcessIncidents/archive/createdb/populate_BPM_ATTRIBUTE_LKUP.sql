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
  where ba.BEM_ID = 10
  order by bal.BAL_ID asc;
  */
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(5,3,'Complete Date','The date the instances is first set to a completed status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(7,3,'Create Date','This is the date that the instance was created in the MAXe system');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(8,2,'Created By Name','Name of the staff member that created the instance in MAXe. This name should be formatted as:Last, First MI or when no middle initial exists then Last, First');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(17,2,'Last Update By Name','Name of the staff member that last updated the instance in MAXe. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(18,3,'Last Update Date','Date the instance was last updated in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(47,3,'Cancel Date','Indicates the date the ETL discovered that the instance was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(49,2,'Channel','This is the channel through which the instance was received by Maximus');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(60,1,'Current Task ID','Task ID identifying the current task for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,2,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(100,3,'Receipt Date','The receipt date is set when the instance is received by Maximus');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(451,1,'Incident ID','Incident ID is the MAXeb defined unique identifier assigned to each incident created in the system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(452,1,'Incident Tracking Number','The public ID of the complaint that is searchable and known to the outside world.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(453,2,'Created By Group','The system description for the Staff Group that the user was logged in as when the incident was created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(454,1,'Origin ID','If the source of the complaint has a record associated with it such as an image and it can be linked through an ID, then record the ID.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(455,1,'Priority','An assignment by the project to group incidents such that they can be completed outside first-in-first-out (FIFO) strategy.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(456,2,'Incident Status','The status of the incident in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(457,3,'Incident Status Date','Date/time when INCIDENT STATUS was set or updated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(458,2,'Action Type','Classifies the action taken by MMS staff on the incident.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(459,2,'Action Comments','Free text field to document Actions taken to the incident.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(460,2,'Resolution Type','Classifies resolution determined by MMS staff on the incident.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(461,3,'Resolution Description','Free text field to document Incident Resolution');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(462,2,'Incident Type','High level description of the type of incident, defined by the project.  See Rules tab for mapping of valid values.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(463,2,'Incident About','Description of who/what the incident is about;  incident about is a subset of INCIDENT TYPE and provides more detailed groupings of incident types.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(464,2,'Incident Reason','The reason provided by the reporter for submitting the incident; incident reason is a subset of INCIDENT ABOUT and provides more detailed groupings.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(466,1,'About Provider ID','The MAXeb unique identifier for the provider about whom the reporter is making a complaint.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(467,2,'About Plan Code','The MAXeb unique identifier for the plan about which the reporter is making a complaint.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(468,2,'Reported By','Reporter classifies the individual or organization that has reported the incident to MAXIMUS (head of case, other adult, non-covered member, health plan, etc).  It is not the name of the individual.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(469,2,'Reporter Relationship','The relationship of the reporter to the entity involved in the complaint.  If the complaint is about something that affects the reporter, then the code might be "self". If the complaint affects the reporters child, it might be "parent" or "legal guardian".');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(470,3,'State Received Appeal Date','The date/time of when the state first received the appeal, if the incident is an appeal.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(471,3,'Hearing Date','If the complaint is an appeal, the hearing date of the actual appeal.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(472,1,'Selection ID','Foreign key to SELECTION table. Used to link an enrollment history selection to an appeal.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(473,2,'EB Follow-Up Needed Flag','Flag indicating if external entity requires followup from MAXIMUS to complete the complaint.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(474,2,'Other Party Name','A brief description of an affected party such as the name of a CSR.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(475,2,'Enrollment Status','Describes the enrollment status for the enrollee or potential enrollee with whom the incident is associated when the incident is associated to a case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(476,2,'Program','The name of the program the enrollee/s or potential enrollee/s are enrolled in or are eligible when the incident is associated to a case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(477,2,'Sub-Program','The name of the sub-program the enrollee/s or potential enrollee/s are enrolled in or are eligible for when the incident is associate to a case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(478,2,'Plan Code','The unique identifier for the plan in which the enrollee or potential enrollee is enrolled (if known) when the incident is associated to a case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(479,1,'Case ID','The case identifier for the enrollee or potential enrollee submitting the incident if   when the incident is associated to a case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(480,1,'Provider ID','The unique identifier for the provider to which the enrollee or potential enrollee is currently assigned (if known).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(481,3,'Research Incident St Dt','The date/time when work started for the Identify and Research Incident activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(482,3,'Research Incident End Dt','Date/time work ended for the Identify and Research Incident activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(483,2,'Research Incident Flag','Indicates when the Identify and Research Incident activity is completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(484,2,'Escalate Incident Flag','Describes whether or not the incident requires escalation to the State.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(485,3,'Escalate to State Dt','The date/time from the MAXeb status or status history when the incident is initially escalated to a State Incident Queue (if the incident moves into more than one State queue, this will only be the date of the initial escalation to a state queue.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(486,3,'Process Incident St Dt','Date/time when work started for the Process Incident activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(487,3,'Process Incident End Dt','Date/time when work ended for the Process Incident activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(488,2,'Process Incident Flag','Indicates when the Process Incident activity is completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(489,2,'Return Incident Flag','Describes whether or not the incident requires additional work by MMS after the state completed processing.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(490,3,'Return to MMS Dt','The date/time from the MAXeb status or status history when the incident is returned to an MMS queue after leaving a State escalation queue (if the incident moves into more than one MMS queue after being returned to MMS from a state queue, this will only be the date of the initial return to an MMS queue after leaving a State Escalation queue.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(491,3,'Complete Incident St Dt','Date/time when work started for the Resolve and Complete Incident activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(492,3,'Complete Incident End Dt','Date/time when work ended for the Resolve and Complete Incident activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(493,2,'Complete Incident Flag','Indicates when the Resolve and Complete Incident activity is completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(494,2,'Notify Client Flag','Describes whether or not the incident type requires client notification.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(495,1,'Process Client Notification ID','The unique instance identifier for the incident notification by mail.  This will be the instance ID in Process Client Notification.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(496,3,'Process Clnt Notify Start Dt','The date/time that the process client notification activity begins.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(497,3,'Process Clnt Notify End Dt','The date/time that the required client notification has been sent.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(498,2,'Process Clnt Notify Flag','Flag indicates that the Notify Client of Resolution activity has completed.  Set to Y when PROCESS CLIENT NOTIFY END DT is set.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(499,2,'generic field 1','Project-configurable field');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(500,2,'generic field 2','Project-configurable field');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(501,2,'generic field 3','Project-configurable field');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(502,2,'generic field 4','Project-configurable field');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(503,2,'generic field 5','Project-configurable field');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(504,2,'Enrollee RIN','The Medicaid recipient ID of the potential enrollee / enrollee who submitted the complaint');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(505,2,'Reporter Name','The name of the individual who submitted the incident.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(547,2,'Cancel Reason','The reason that the JOB ID instance is cancelled.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(557,2,'County Code', 'The county code for an address');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(576,2,'Cancel By','The name of the system or performer who cancelled the letter.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(722,2,'Cancel Method','This is the method as per which the instance was cancelled');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1604,2,'County Name','The name of the associated county');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1499,2,'Incident Description','Free text field to document Incident description');

  commit;

end;
/