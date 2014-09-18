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
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1,1,'Age in Business Days','Number of days from the Create Date to the Complete Date, or to the Current Date for instances that are not yet complete, excluding weekends and project holidays.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(2,1,'Age in Calendar Days','Number of days from the Create Date to the Complete Date, or to the current date for instances that are not yet complete.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(5,3,'Complete Date','The date the instances is first set to a completed status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(7,3,'Create Date','This is the date that the instance was created in the MAXe system');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,2,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(479,1,'Case ID','The case identifier for the enrollee or potential enrollee submitting the incident if   when the incident is associated to a case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(547,2,'Cancel Reason','The reason that the JOB ID instance is cancelled.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(557,2,'County Code','The county code for the mailing address of the letter.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(575,2,'Newborn Flag','If a letter request has been generated for a case with a newly eligible newborn, set the flag to Y; else, N. This information should be retrieved from the details of the case associated with the letter request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(593,1,'Client ID','The client id/s included in the letter request.  This list should NOT include any clients associated to a case that are NOT included in the letter (e.g. - for general notifications sent to the case head that do not include client names, this will be null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(722,2,'Cancel Method','This is the method as per which the instance was cancelled');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(723,1,'Client Enroll Status ID','The enrollment status record ID for the client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(724,2,'Client CIN','State assigned individual identifier for the client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(725,2,'Service Area','Service Area describes the region or district of the state in which the member resides that determines the plans available and / or type of coverage availble to the eligible client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(726,2,'ZIP Code','The ZIP Code for the clients residential address.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(727,2,'Enrollment Status Code','Determines the action required to process the client record in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(728,3,'Enrollment Status Date','The date/time that the current enrollment status code was determined by the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(729,3,'Auto-Assign Due Date','The date that the final auto-assignment of plan/PCP should be performed in order to enroll the client if the plan/PCP is not provided by the member or head of case.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(730,1,'Enrollment Packet Request ID','The letter request ID for the enrollment packet sent to the client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(731,3,'Enrollment Packet Request Date','The date/time that the enrollment packet was requested in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(732,1,'Enrollment Fee Amount Due','If an enrollment fee is required in order to enroll in coverage, this will contain the dollar amount of the required fee.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(733,1,'Enrollment Fee Amount Paid','The dollar amount that has been applied to the case in order to satisfy enrollment fee requirements for enrollment, if applicable.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(734,3,'Enrollment Fee Received Date','The date/time that the enrollment fee is received, if applicable.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(735,1,'CHIP Plan Change Notice ID','During the manage enrollment activity process, a CHIP client can receive a Health Plan Change Packet if the state provides a new residential address.  If the HPC is triggered during the process, the letter request ID will be stored here.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(736,3,'CHIP Plan Change Mailed Date','The date/time that the CHIP Plan Change Notice is mailed to the client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(737,1,'CHIP Enroll MI Notice ID','During the manage enrollment activity process, a CHIP client can an Enrollment Missing Information Notice if they send in selection information that is incomplete and the client can not be enrolled.  If the EMI is triggered during the process, the letter request ID will be stored here');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(738,3,'CHIP Enroll MI Sent Date','The date/time that the CHIP Enroll MI Notice is mailed to the client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(739,2,'Plan Type','Plan Type categorizes the type of coverage for the client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(740,2,'Program Type','Program Type categorizes the type of program for the client (used to populate the enrollment packet).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(741,2,'Selection Method','Describes the source of the plan/PCP selections for medical health coverage currently assigned to the member.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(742,2,'Selection Created by Name','The name of the system or performer that created  the current client selection in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(743,3,'Selection Create Date','The date/time that the current client selection was created in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(744,2,'Selection Last Update by Name','The name of the system or performer that last updated  the current client selection in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(745,3,'Selection Last Update Date','The date/time that the current client selection was last updated in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(746,2,'Selection Auto Processed','Selection Auto Processed indicates if the selection data received from the member by mail, fax or online was automatically processed into the system, or if it required manual data-entry.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(747,2,'Generic Field 1','Generic Field will allow for future attribute mapping');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(748,2,'Generic Field 2','Generic Field will allow for future attribute mapping');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(749,2,'Generic Field 3','Generic Field will allow for future attribute mapping');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(750,2,'Generic Field 4','Generic Field will allow for future attribute mapping');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(751,2,'Generic Field 5','Generic Field will allow for future attribute mapping');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(752,3,'Valid Slcn Received Start Date','The date/time that the Valid Selections Received activity step begins; equivalent to the date/time that valid selections received from the client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(753,3,'Valid Slcn Received End Dt','The date/time that the Valid Selections Received activity step begins; equivalent to the date/time that valid selections received from the client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(754,3,'Send Enroll Packet Start Date','The date/time when the Send Enrollment Packet Activity starts; equivalent to the date/time that the Enrollment Status Calc value is set to A');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(755,3,'Send Enroll Packet End Date','The date/time when the Send Enrollment Packet Activity ends; equivalent to the request date for the enrollment packet.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(756,2,'First Follow-up ID','Provides system identifier for the first follow-up, if applicable.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(757,2,'First Followup Type Code','Supporting attribute - used to assign followup type required to the instance based on values table rules.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(758,3,'First Follow-up Start Date','The date/time that the First Follow-up activity step begins; equivalent to the date/time that first follow-up is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(759,3,'First Follow-up End Date','The date/time that the First Follow-up activity step ends; equivalent to the date/time that first follow-up is completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(760,2,'Second Follow-up ID','Provides system identifier for the second follow-up, if applicable.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(761,2,'Second Followup Type Code','Supporting attribute - used to assign followup type required to the instance based on values table rules.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(762,3,'Second Follow-up Start Date','The date/time that the Second Follow-up activity step begins; equivalent to the date/time that second follow-up is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(763,3,'Second Follow-up End Date','The date/time that the Second Follow-up activity step ends; equivalent to the date/time that second follow-up is completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(764,2,'Third Follow-up ID','Provides system identifier for the third follow-up, if applicable.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(765,2,'Third Followup Type Code','Supporting attribute - used to assign followup type required to the instance based on values table rules.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(766,3,'Third Follow-up Start Date','The date/time that the Third Follow-up activity step begins; equivalent to the date/time that third follow-up is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(767,3,'Third Follow-up End Date','The date/time that the Third Follow-up activity step ends; equivalent to the date/time that third follow-up is completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(768,2,'Fourth Follow-up ID','Provides system identifier for the fourth follow-up, if applicable.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(769,2,'Fourth Followup Type Code','Supporting attribute - used to assign followup type required to the instance based on values table rules.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(770,3,'Fourth Follow-up Start Date','The date/time that the Fourth Follow-up activity step begins; equivalent to the date/time that fourth follow-up is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(771,3,'Fourth Follow-up End Date','The date/time that the Third Follow-up activity step ends; equivalent to the date/time that fouth follow-up is completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(772,3,'Auto Assign Start Date','The date/time when the Auto Assign Activity begins; equivalent to the date/time that the final auto-assignment is performed to enroll a client that is pending selections.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(773,3,'Auto Assign End Date','The date/time when the Auto Assign Activity ends; equivalent to the date/time that the system auto-assigns valid selections for the client prior to enrollment in a plan.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(774,3,'Wait for Enroll Fee Start Date','The date/time that the Wait for Enrollment Fee activity step begins; equivalent to the date/time valid selections are created for the client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(775,3,'Wait for Enroll Fee End Date','The date/time that the Wait for Enrollment Fee activity step ends; equivalent to the date/time that the enrollment fee is received.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(776,3,'Cancel Enroll Activity Date','The date/time that the Enrollment Activity instance was cancelled (the client is no longer eligible, client failed to pay required enrollment fee before the deadline).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(777,2,'Cancelled By','The person or system that cancelled the instance in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(778,2,'Send Enroll Packet Flag','Monitor if an Enrollment packet was sent.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(779,2,'Selections Received Flag','Monitor if the potential enrollee selected valid plan/PCP selections via phone, mail/fax or web.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(780,2,'First Follow-up Complete Flag','Monitor if the first followup was made during the client enrollment process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(781,2,'Second Follow-up Complete Flag','Monitor if the second followup was made during the client enrollment process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(782,2,'Third Follow-up Complete Flag','Monitor if the third followup was made during the client enrollment process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(783,2,'Fourth Follow-up Complete Flag','Monitor if the fourth followup was made during the client enrollment process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(784,2,'Auto Assign Flag','Monitor if a valid plan/PCP selections are auto-assigned for the member.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(785,2,'Wait for Fee Flag','Monitor if the enrollment fee has been paid, if required.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(786,2,'Enroll Packet Required Flag','Enroll Packet Required Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(787,2,'First Follow-up Required Flag','First Follow-up Required Gateway Flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(788,2,'Second Follow-up Required Flag','Second Follow-up Required Gateway Flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(789,2,'Third Follow-up Required Flag','Third Follow-up Required Gateway Flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(790,2,'Fourth Follow-up Required Flag','Fourth Follow-up Required Gateway Flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(791,2,'Required Fee Paid Flag','Required Fee Paid Flag Gateway flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(792,2,'Cancel Enroll Activity Flag','Monitor if The potential enrollee is no longer elible based on updates recevied on The Daily Eligibility File');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(807,2,'Subprogram Type','The Subprogram associated with the Case associated with the Outreach Request.');
  commit;

end;
/