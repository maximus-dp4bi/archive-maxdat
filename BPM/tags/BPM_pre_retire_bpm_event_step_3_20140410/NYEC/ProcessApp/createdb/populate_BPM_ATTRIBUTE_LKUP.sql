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
  where ba.BEM_ID = 2
  order by bal.BAL_ID asc;
  */
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1,1,'Age in Business Days','Number of days from the Create Date to the Complete Date, or to the Current Date for instances that are not yet complete, excluding weekends and project holidays.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(2,1,'Age in Calendar Days','Number of days from the Create Date to the Complete Date, or to the current date for instances that are not yet complete.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(5,3,'Complete Date','The date the instances is first set to a completed status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(7,3,'Create Date','This is the date that the instance was created in the MAXe system');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(16,2,'Jeopardy Flag','Indicates if the application is in jeopardy based on the SLA Days Type and SLA Jeopardy Days. Default value is N');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(20,1,'SLA Days','Age at which time the measured cycle is determined to be untimely. If no SLA applies then this value is null');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(21,2,'SLA Days Type','Indicates if the SLA Days is based on Business Days or Calendar Days. If no SLA applies then this value is null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(22,1,'SLA Jeopardy Days','Age at which time the measured cycle is determined to be in Jeopardy. If no SLA applies then this value is null. This value should be easily configured and will initially be set to 2 for all instances.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(23,1,'SLA Target Days','Age at which time the measured cycle is determined to be untimely based on target goals set by the business. If no target has been defined then this value is null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(35,2,'Timeliness Status','Indicates if the instance was processed timely or untimely based on the SLA Days Type, SLA Days, and age or cycle days. Default value is Not Required');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(37,2,'App Complete Result','For completed applications, this categorizes the end result of the application processing (what happened to this application).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(38,2,'App Status','Current status of application in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(39,2,'App Status Group','Hierarchical grouping of MAXe App Statuses and Request for Eligibility Statuses');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(40,1,'Application ID','Unique identifier for the application in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(41,2,'Application Type','The type of application being processed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(42,2,'Auto Reprocess Flag','Indicates the instance was automatically reprocessed by the system after MI was not returned.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(44,2,'Cancel App Flag','Cancel App Activity Step');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(45,2,'Cancel App Performed By','Name of the staff member that completed the Cancel App activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(47,3,'Cancel Date','Indicates the date the ETL discovered that the instance was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(49,2,'Channel','This is the channel through which the instance was received by Maximus');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(49,2,'Channel','This is the channel through which the instance was received by Maximus');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(50,2,'Clockdown Indicator','If the application has not been received, 15 days prior to Authorization date, the state sends letter to client. Application is moved to clockdown');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(52,2,'Close App Flag','Close App  Activity Step');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(53,2,'Close App Performed By','Name of the staff member that completed the Close App activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(56,2,'Complete App Flag','Complete App Activity Step');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(57,2,'Complete App Performed By','Name of the staff member that completed the Complete App activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(59,2,'County','County associated with the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(60,1,'Current Task ID','Task ID identifying the current task for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(61,1,'Data Entry Task ID','Task ID identifying the Data Entry task created for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(62,2,'Eligibility Action','Eligibility action taken during application processing');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(63,2,'HEART App Status','This is the application status in HEART.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(64,2,'HEART Synch Flag','Indicates if MAXe is in-synch with the HEART system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(67,1,'KPR App Cycle Business Days','This is the number of days excluding weekends and project holidays from the KPR App Cycle Start Dt to the KPR App Cycle End Dt for applications that have completed the App Cycle.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(68,1,'KPR App Cycle Calendar Days','This is the number of calendar days from the App Cycle Start Date to the App Cycle End Date for applications that have completed the App Cycle.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(69,3,'KPR App Cycle End Date','End date for measuring KPR App Cycle timeliness');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(70,3,'KPR App Cycle Start Date','Start date for measuring KPR App Cycle timeliness');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(71,3,'Last Mail Date','This is used to identify the batch for renewals');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(72,1,'MI Received Task Count','This is used to monitor how many MI Received tasks were created for an instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(73,2,'Missing Information Flag','Missing Information Gateway');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(74,2,'New MI Flag','New MI Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(75,3,'Notify Client Pended App Date','Date the notification of MI was sent');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(77,2,'Notify Client Pended App Flag','Notify Client Pended App Activity Step');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(78,2,'Notify Client Pended App Performed By','Name of the staff member that completed the Notify Client Pended App activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(79,3,'Notify Client Pended App Start Date','Date work started for the Notify Client Pended App activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(80,2,'Outcome Notification Required Gateway Flag','Outcome Notification Required gateway flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(81,2,'Pend Notification Required Flag','Pend Notification Required Gateway');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(82,3,'Perform QC Date','Date the QC task was completed and the app status group changed to either Awaiting Missing Information or Done');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(84,2,'Perform QC Flag','Perform QC Activity Step');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(85,2,'Perform QC Performed By','Name of the staff member that completed the Perform QC activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(86,3,'Perform QC Start Date','Date work started for the Perform QC activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(87,3,'Perform Research Date','Date the Research task was completed');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(89,2,'Perform Research Flag','Perform Research Activity Step');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(90,2,'Perform Research Performed By','Name of the staff member that completed the Perform Research activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(91,3,'Perform Research Start Date','Date work started for the Perform Research activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(92,3,'Process App Info Date','Date initial app processing was completed');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(94,2,'Process App Info Flag','Process App Info  Activity Step');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(95,2,'Process App Info Performed By','Name of the staff member that completed the Process App Info activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(96,3,'Process App Info Start Date','Date work started for the Process App Info activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(97,2,'QC Outcome Flag','QC Outcome Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(98,2,'QC Required Flag','QC Required Gateway');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(99,1,'QC Task ID','Task ID identifying the QC task created for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(100,3,'Receipt Date','The receipt date is set when the instance is received by Maximus');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(102,2,'Receive and Process MI Flag','Receive and Process MI Activity Step');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(106,2,'Receive App Flag','Receive App  Activity Step');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(109,2,'Refer to LDSS Flag','Indicates if the instance should be referred to LDSS');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(110,2,'Research Flag','Research gateway flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(111,2,'Research Reason','This indicates the reason work was sent to Research. ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(112,1,'Research Task ID','Task ID identifying the Research task created for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(113,3,'Review and Enter Data Date','This is the date the data entry task was completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(115,2,'Review and Enter Data Flag','Review and Enter Data  Activity Step');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(116,2,'Review and Enter Data Performed By','Name of the staff member that completed the Review and Enter Data activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(117,3,'Review and Enter Data Start Date','Date work started for the Review and Enter Data App activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(123,3,'SLA Jeopardy Date','First date on which application is considered in Jeopardy, this is the date that the Jeopardy Flag was or will be set to Y');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(124,1,'State Review Task Count','This is used to monitor how many state review tasks were created for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(125,1,'State Review Task ID','Task ID identifying the State Review task created for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(126,3,'Wait for State Approval Date','Date the State Approval task was completed');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(128,2,'Wait for State Approval Performed By','Name of the staff member that completed the Wait for State Approval activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(129,3,'Wait for State Approval Start Date','Date work started for the Wait for State Approval activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(130,2,'Wait State Approval Flag','Wait State Approval Activity Step');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(131,2,'Batch Name','The Batch Name is a unique identifier assigned to each batch.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(172,1,'Work Task ID','The Task ID is the ID of the task created AFTER all proximal match tasks are completed. This TASK ID does not represent the HSDE-QC, Link Document Set, or Document Problem Resolution task.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(194,2,'Document Type','The Document Type is the high level description of a document in an envelope.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(197,2,'Document Form Type','The Document Form type is the description of the form returned by the client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(200,1,'Document Page Count','The document page count is the count of individual pages in a document.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(260,2,'State Case Identifier','Unique identifier of the HEART Case (family) which is receiving the renewal application.');
  commit;
 
  -- r3
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(331,2,'CIN ','The CIN is the unique ID associated to the applicants.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(332,3,'CIN Date','The CIN Date is the date that the CIN is created or updated, and then saved in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(333,2,'Provider Name','The Provider name is the name of the company that submitted the FPBP PE application on behalf of the client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(335,2,'FPBP Sub-type','The FPBP sub-type indicates whether the PE application only has been received (PE App), the FPBP application only has been received (FPBP App), both the PE and FPBP applications have been received (FPBP/PE), or that the type is not required because the application is for a different program type (N/A).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(336,2,'Reverse Clearance Indicator','The Reverse Clearance Indicator notifies users whether the clearance is required or not, based on information on the application.  Reverse Clearance is not required is the application if for a program type other than FPBP');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(337,3,'Reverse Clearance Indicator Date','The Reverse Clearance Indicator Date is the date that the indicator value is saved in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(338,2,'Reverse Clearance Outcome','The Reverse Cleareance Outcome indicates whether running the clearance provided enough information to move the application forward or not.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(339,2,'Upstate/Downstate Indicator','The Upstate/Downstate Indicator groups FPBP applications based on the residential zip code.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(340,3,'Invoiceable Date','The Invoiceable Date is the date the SDE task is complete. Does not apply to FPBP app type');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(341,2,'HEART Incomplete App Indicator','The HEART Incomplete App Indicator is to inform HEART not to close when there is missing data in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(342,1,'Days To Timeout','This field displays the number of calendar days between the system date and the application time out date for all applications with unsatisfied MI and a RFE status of Awaiting MI.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(343,2,'WMS Reason','The WMS Reason provides the application result detail for FPBP applications. The detail includes the acceptance reason or the denial reason');
  commit;
  
  -- r4
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(344,2,'HEART Reprocess Status','The HEART Reprocess Status is the status in HEART at the time of auto-reprocessing');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(345,3,'HEART Reprocess Status Date','The HEART Reprocess Status date is the date in HEART the auto-reprocessing was performed');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(351,2,'HEART Case Status','The HEART Case Status is the status of the HEART case associated with the renewal application and does not apply to FPBP.');
  commit;
  
  -- Reactivation
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(397,2,'Stop Application Reason','The stop application reason is the reason research stopped processing the application');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(398,2,'Reactivation Reason','The reactivation reason is the reason the  application is  reactivated  on the case in Maxe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(399,1,'Reactivation Indicator','The reactivation indicator identifies an application that has been externally reactivated and can only be set on Renewal Applications');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(400,1,'Reactivation Number','The reactivation number is the number of reactivations on an application. The initial application will always be null');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(401,2,'Workflow Reactivation Indicator','The workflow reactivation indicator determines if the application goes through the internal reactivation workflow');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(402,2,'Current Mode Code','The current mode code indicates the status of the application that has been reactivated in the workflow and determines the outcome of the reactivated application');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(403,2,'Current Mode Label','The current mode code label describes the status of the application in the workflow process');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(404,2,'Outcome Letter Type','Outcome letter type describes the type of letter being sent in this process.  There are only two outcom letter types: Manuel Notice/Courtesy letter or Docs 30 Days after Auth letter');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(405,2,'Outcome Letter Status','Outcome letter status provides the condition of the letter to determine if a letter has been requested and sent');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(406,1,'Outcome Letter ID','The unique identifier associated to the letter');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(407,3,'Outcome Letter Create Date','The outcome letter create date is the day the letter was requested to be sent to the client');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(408,3,'Outcome Letter Send Date','The outcome letter send date is the day the letter is confirmed sent to the client');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(409,2,'Reactivated By','The person who reactivated the application');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(410,3,'Reactivation Date','The date the application was reactivated');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(411,2,'Outcome Notification Required Flag','The outcome notification required flag is set to Y when the outcome notification is required and set to N when it is not required. Outcome letters are only sent on applications stopped with stopped reasons: screened ineligible or HEART screening cancelled eligibility period expired');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(412,2,'QC Indicator','The QC indicator provides informationto the state to determine if tasks are in the state queues and are ready to work. It also determines if any of the state automated jobs are ready to run');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(480,1,'Provider ID','The unique identifier for the provider to which the enrollee or potential enrollee is currently assigned (if known).');
  commit;
  
  -- v4
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(616,2,'Reverse Clearance Reason','The reverse clearance reason is the reason clearance is being performed on the application (Dropdown to include: SSN, Date of Birth, Name(full legal), and Residence Address )');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(617,2,'MA Reason','The MA Reason provides the application result detail for FPBP Downstate applications. The detail includes the acceptance reason or the denial reason.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(619,1,'Applicant ID','The Maxe Identifier for the applicant on the FPBP application');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(620,1,'Registration Task ID','Task ID identifying the Application Registration task created for the application. Will only be created on FPBP and PE types');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(621,1,'QC Registration Task ID','Task ID identifying the QC application registration task created for the FPBP application. This is the initial QC task created after the application registration task is completed and only on FPBP type = PE');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(622,3,'Perform QC Reg Date','Date the QC application registration task was completed');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(623,3,'Reg and Enter Data Start Date','Date work started for the Review and Enter Data App activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(624,3,'Perform QC Reg Start Date','Date work started for the Perform QC activity step. This is the earliest of the first date the QC task was claimed or the QC task completion date');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(625,2,'Reg and Enter Data Performed By','Name of the staff member that completed the Review and Enter Data activity step. This is the person that completed the data entry task.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(626,2,'Perform QC Reg Performed By','Name of the staff member that completed the Perform QC activity step. This is the name of the staff member that completed the QC Task as captured in the QC Task ID attribute.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(627,1,'Number of Applicants','The number of applying clients associated to the application.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(721,3,'Perform Reg Enter Data Dt','Date the application registration task was completed.');

  commit;

end;
/
