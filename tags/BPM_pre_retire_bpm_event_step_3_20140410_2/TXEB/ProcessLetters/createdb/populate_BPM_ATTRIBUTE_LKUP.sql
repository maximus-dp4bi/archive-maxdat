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
  where ba.BEM_ID = 12
  order by bal.BAL_ID asc;
  */
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1,1,'Age in Business Days','Number of days from the Create Date to the Complete Date, or to the Current Date for instances that are not yet complete, excluding weekends and project holidays.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(5,3,'Complete Date','The date the instances is first set to a completed status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(7,3,'Create Date','This is the date that the instance was created in the MAXe system');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(18,3,'Last Update Date','Date the instance was last updated in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(20,1,'SLA Days','Age at which time the measured cycle is determined to be untimely. If no SLA applies then this value is null');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(21,2,'SLA Days Type','Indicates if the SLA Days is based on Business Days or Calendar Days. If no SLA applies then this value is null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(22,1,'SLA Jeopardy Days','Age at which time the measured cycle is determined to be in Jeopardy. If no SLA applies then this value is null. This value should be easily configured and will initially be set to 2 for all instances.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(23,1,'SLA Target Days','Age at which time the measured cycle is determined to be untimely based on target goals set by the business. If no target has been defined then this value is null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(29,1,'Task ID','Unique identifier for the task in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(35,2,'Timeliness Status','Indicates if the instance was processed timely or untimely based on the SLA Days Type, SLA Days, and age or cycle days. Default value is Not Required');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(47,3,'Cancel Date','Indicates the date the ETL discovered that the instance was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,2,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(123,3,'SLA Jeopardy Date','First date on which application is considered in Jeopardy, this is the date that the Jeopardy Flag was or will be set to "Y"');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(157,2,'Created By','The Created By is the name of the performer who created the envelope.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(171,2,'Work Required Flag','The Work Required Flag indicates whether a work task should be generated based on the envelope contents and current case information.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(280,1,'Letter Request ID','This is the letter request ID of  the MI Notification.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(281,2,'Letter Status','This is used to monitor the status of a MI letter requested as a result of processing MI and new MI is identified.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(309,3,'Letter Status Date','This is the date the Letter Status was updated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(476,2,'Program','The name of the program the enrollee/s or potential enrollee/s are enrolled in or are eligible when the incident is associated to a case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(477,2,'Sub-Program','The name of the sub-program the enrollee/s or potential enrollee/s are enrolled in or are eligible for when the incident is associate to a case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(479,1,'Case ID','The case identifier for the enrollee or potential enrollee submitting the incident if   when the incident is associated to a case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(555,3,'Request Date','The date/time that the client notification was requested in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(556,2,'Letter Type','Indicates the specific type of letter requested.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(557,2,'County Code','The county code for the mailing address of the letter.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(558,1,'ZIP Code','The ZIP code for the mailing address of the letter.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(559,2,'Language','The language that the letter was requested in.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(560,2,'Reprint','Indicates if the letter request is a request a reprint of a previous letter.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(561,2,'Request Driver Type','The Driver Type defines at what level the letter is being generated, either Case level or Client level.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(562,2,'Request Driver Table','The table name which drives the letter.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(563,3,'Sent Date','The date/time that the letter was sent to the mail vendor for printing and mailing.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(564,3,'Print Date','The date/time that the letter was printed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(565,3,'Mailed Date','The date/time that the letter was mailed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(566,3,'Return Date','The date/time that the letter was returned.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(567,2,'Return Reason','The letter return reason identifies why the letter was returned.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(568,2,'Rejection Reason','The Reject Reason is the reason the mailhouse rejected the Letter Request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(569,2,'Request Error Reason','The Error Reason is the reason that the request could not be processed by the system and was not sent to the mailhouse.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(570,2,'Transmitted File Name','The Letter File ID is the unique identifier of the interface file sent to the Mail House which contains the Letter Requests.  The Letter File ID identifies which File the Letter Request was transmitted on.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(571,3,'Transmitted File Date','The Letter File Send Date is the date/time that the Letter interface file containing the Letter Request ID was sent to the Mail House by the system. (Transmitted Date)');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(572,2,'Letter Response File Name','The Letter Response File ID is the unique identifier of the interface file sent from the Mail House to the system that contains the outcome data of Letters sent. The Letter Response File ID identifies which File the Letter Request was transmitted on.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(573,3,'Letter Response File Date','The Letter Response File Receive Date is the date/time that the Letter Response Interface file was received by the system from the Mail House.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(574,2,'Last Updated by Name','The name of the system or performer that updated the letter request in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(575,2,'Newborn Flag','If a letter request has been generated for a case with a newly eligible newborn, set the flag to Y; else, N. This information should be retrieved from the details of the case associated with the letter request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(576,2,'Cancel By','The name of the system or performer who cancelled the letter.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(577,3,'Process Ltr Request Start Date','Process Ltr Request Activity Step Start Date');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(578,3,'Process Ltr Request End Date','Process Ltr Request Activity Step End Date');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(579,3,'Send to Mail House Start Date','Send to Mail House Activity Step Start Date');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(580,3,'Send to Mail House End Date','Send to Mail House Activity Step End Date');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(581,3,'Receive Confirmation Start Date','Receive Confirmation Activity Step Start Date');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(582,3,'Receive Confirmation End Date','Receive Confirmation Activity Step End Date');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(583,3,'Create Route Work Star Date','Create Route Work Activity Step Start Date');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(584,3,'Create Route Work End Date','Create Route Work Activity Step End Date');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(585,2,'Process Letters Flag','Process Letters Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(586,2,'Transmit Flag','Transmit Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(587,2,'Confirmation Flag','Confirmation Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(588,2,'Create Route Work Flag','Create Route Work Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(589,2,'Validation Flag','Validation Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(590,2,'Outcome Flag','Outcome Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(591,1,'Jeopardy Status','Indicates if the notification is in jeopardy of being processed untimely.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(592,1,'SLA Category','Establishes the category of the request into SLA compliance groups.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(593,1,'Client ID','The client id/s included in the letter request.  This list should NOT include any clients associated to a case that are NOT included in the letter (e.g. - for general notifications sent to the case head that do not include client names, this will be null.');

  commit;

end;
/