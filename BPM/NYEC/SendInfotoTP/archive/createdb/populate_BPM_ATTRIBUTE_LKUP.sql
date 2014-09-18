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
  where ba.BEM_ID = 8
  order by bal.BAL_ID asc;
  */
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1,1,'Age in Business Days','Number of days from the Create Date to the Complete Date, or to the Current Date for instances that are not yet complete, excluding weekends and project holidays.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(20,1,'SLA Days','Age at which time the measured cycle is determined to be untimely. If no SLA applies then this value is null');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(21,2,'SLA Days Type','Indicates if the SLA Days is based on Business Days or Calendar Days. If no SLA applies then this value is null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(22,1,'SLA Jeopardy Days','Age at which time the measured cycle is determined to be in Jeopardy. If no SLA applies then this value is null. This value should be easily configured and will initially be set to 2 for all instances.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(23,1,'SLA Target Days','Age at which time the measured cycle is determined to be untimely based on target goals set by the business. If no target has been defined then this value is null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(40,1,'Application ID','Unique identifier for the application in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(47,3,'Cancel Date','Indicates the date the ETL discovered that the instance was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(65,3,'Instance Complete Date','Date the instance reached a terminal point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,2,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(123,3,'SLA Jeopardy Date','First date on which application is considered in Jeopardy, this is the date that the Jeopardy Flag was or will be set to "Y"');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(297,3,'Info Request Create Date','The date the information request was created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(298,1,'Info Request ID','Indicates the actual source ID of the information request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(299,2,'Info Request Source','Indicates the source of the Request ID.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(300,2,'Info Request Type','Indicates specific type of information request monitored, for example, the type of letter (MI or Renewal Reminder or Material Request).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(301,2,'Info Request Group','Hierarchical grouping of Request Types');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(302,2,'Info Request Status','Indicates the status of the information request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(303,2,'Call Flag','Indicates whether a call should be attempted (or re-attempted).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(304,2,'Call Result','Indicates the Result of the outbound call attempt.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(305,3,'Call Status Date','This is the date the Call Status was updated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(306,1,'New Call Request ID','Indicates the new call request id if a retry call is created in the events table.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(307,3,'Letter Image Linked Date','This is the date the returned Letter Image was linked to the application.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(308,3,'Letter Request Date','This is the date that the MI or a Renewal Reminder notification was identified for the client. Regardless how many times a letter errors, the Letter Request Date remains the same.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(309,3,'Letter Status Date','This is the date the Letter Status was updated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(310,1,'New Letter Req ID','This is used to capture the new Letter Request ID that created when letter (or material request) errored during mailing.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(311,3,'Info Request Sent Date','This is the date the Letter Request was sent to the print vendor for mailing, or the date the Outbound Call Request was included on a file for the telephony vendor');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(312,2,'Manual Letter Flag','This is used to monitor if the letter is a manual letter.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(313,2,'District Name','Indicates District which will receive the Referral Summary.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(314,3,'Send IEDR Date','The date the Image was sent to IEDR on the Image File.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(315,2,'IEDR Error Flag','This is used to monitor if an error was returned on the response file from IEDR for an image.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(316,3,'Info Req Cycle End Date','This is the date the Information Request Instance was completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(317,3,'Info Req Cycle Start Date','The earliest of Create Date or the Original Letter Request Date  for purpose of determining Information Request processing compliance.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(318,1,'Info Request Cycle Business Days','This is the number of days excluding weekends and project holidays from the Info Req Cycle Start Dt to the Info Req Complete Dt for Information Request instances that have completed the Information Request Cycle');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(319,3,'Receive Info Req End Date','Date work ended for the Receive Information Request activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(320,3,'Receive Info Req Start Date','Date work started for the Receive Information Request activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(321,3,'Process Image End Date','Date work ended for the Process Image Send Request activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(322,3,'Process Image Start Date','Date work started for the Process Image Send Request  activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(323,3,'Perform Outbound Call End Date','Date work ended for the Perform Outbound Call  activity step');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(324,3,'Perform Outbound Call Start Date','Date work started for the Perform Outbound Call activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(325,3,'Create New Call Request End Date','Date work ended for the Create New Call Request activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(326,3,'Create New Call Request Start Date','Date work started for the Create New Call Request activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(327,3,'Mail Letter Request End Date','Date work ended for the Mail Letter Request activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(328,3,'Mail Letter Request Start Date','Date work started for the Mail Letter Request activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(329,3,'Create New Letter Request End Date','Date work ended for the Create New Letter Request activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(330,3,'Create New Letter Request Start Date','Date work started for the Create New Letter Request activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(375,2,'Letter Mailed Flag','Letter Mailed Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(376,2,'Request Type Flag','Request Type Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(377,2,'Retry Call Flag','Retry Call Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(378,2,'Create New Call Request Flag','Create New Call Request Activity Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(379,2,'Create New Letter Request Flag','Create New Letter Request Activity Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(380,2,'Mail Letter Request Flag','Mail Letter Request Activity Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(381,2,'Perform Outbound Call Flag','Perform Outbound Call Activity Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(382,2,'Process Image Flag','Process Image Activity Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(383,2,'Receive Info Request Flag','Receive Info Request Activity Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(384,2,'Create New Call Request Performed By','Name of the staff member (or system job) that completed the "New Call Request" activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(385,2,'Create New Letter Request Performed By','Name of the staff member (or system job) that completed the "New Letter Request" activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(386,3,'Create Referral Summary End Date','Date work ended for the Create Referral activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(387,2,'Create Referral Summary Performed By','Name of the staff member (or system job) that completed the "Create Referral" activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(388,3,'Create Referral Summary Start Date','Date work started for the Create Referral activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(389,2,'Mail Letter Request - Performed By','Name of the staff member (or system job) that completed the "Mail Letter Request" activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(390,2,'Perform Outbound Call Performed By','Name of the staff member (or system job) that completed the "Outbound Call" activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(391,2,'Process Image Performed By','Name of the staff member (or system job) that completed the "Process Image Send Request" activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(392,2,'Receive Info Req Performed By','Name of the staff member (or system job) that completed the "Process Data Correction" activity step.');
  
  commit;

end;
/
