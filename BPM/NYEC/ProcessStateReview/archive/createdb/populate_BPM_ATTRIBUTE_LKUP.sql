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
  where ba.BEM_ID = 7
  order by bal.BAL_ID asc;
  */
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1,1,'Age in Business Days','Number of days from the Create Date to the Complete Date, or to the Current Date for instances that are not yet complete, excluding weekends and project holidays.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(39,2,'App Status Group','Hierarchical grouping of MAXe App Statuses and Request for Eligibility Statuses');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(40,1,'Application ID','Unique identifier for the application in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(47,3,'Cancel Date','Indicates the date the ETL discovered that the instance was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(60,1,'Current Task ID','Task ID identifying the current task for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(63,2,'HEART App Status','This is the application status in HEART.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(65,3,'Instance Complete Date','Date the instance reached a terminal point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,2,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(74,2,'New MI Flag','New MI Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(110,2,'Research Flag','Research gateway flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(112,1,'Research Task ID','Task ID identifying the Research task created for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(125,1,'State Review Task ID','Task ID identifying the State Review task created for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(276,2,'All MI Satisfied Flag','Indicates if all MI (missing data and missing documents) are satisfied for this application.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(277,2,'Auto-Close Flag','This identifies when a State Review Instance is complete because the application was closed in the State System first.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(278,1,'Call Campaign ID','This is used to track that an outbound call for MI is created so that the outbound call is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(279,2,'Call Campaign Identified Flag','Indicates if the result of this process instance identified the need for a MI Call Campaign.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(280,1,'Letter Request ID','This is the letter request ID of  the MI Notification.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(281,2,'Letter Status','This is used to monitor the status of a MI letter requested as a result of processing MI and new MI is identified.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(282,1,'New State Review Task ID','Task ID identifying the new State Review task created for the application.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(283,2,'RFE Status Flag','Indicates whether all RFE statuses for participants associated to this application have the same status or not.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(284,2,'State Acceptance Indicator','This is a field in the State System (that is captured and saved in the MAXe HEART table) and indicates if the application in MAXe is ready for State Review.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(285,2,'State Review Outcome','Indicates the outcome of the State Review task (accepted or rejected).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(286,3,'State Review Received End Date','Date work ended for the State Review Received activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(287,2,'State Review Received Performed By','Name of the staff member (or system job) that completed the "State Review Received" activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(288,3,'State Review Received Start Date','Date work started for the State Review Received  activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(289,3,'Process Data Correction End Date','Date work ended for theProcess Data Correction activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(290,2,'Process Data Correction Performed By','Name of the staff member (or system job) that completed the "Process Data Correction" activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(291,3,'Process Data Correction Start Date','Date work started for the Process Data Correction activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(292,3,'Research and Resolve Issue End Date','Date work ended for the Research and Resolve Issue activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(293,2,'Research and Resolve Issue Performed By','Name of the staff member (or system job) that completed the "Research and Resolve Issue" activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(294,3,'Research and Resolve Issue Start Date','Date work started for the Research and Resolve Issue activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(295,3,'Request Missing Info Notification End Date','Date work ended for the Request Missing Info Notification activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(296,3,'Request Missing Info Notification Start Date','Date work started for the Request Missing Info Notification activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(352,1,'Data Correction Task ID','Task ID identifying  Data Correction task created for the application. This is the task created after an application has been rejected from the state and requires additional work.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(353,2,'Letter Sent Flag','The Letter Sent Flag  is set to Y when new MI is identified and is unsatisfied. Set to N when New MI is satisfied and a letter is not required.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(354,2,'New MI Satisfied','Set to Y when New MI is satisfied, set to N if new MI is not satisfied.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(355,2,'Task Worked By Flag','Task worked by gateway flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(356,2,'State Result Flag','State result gateway flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(357,2,'New MI Satisfied Flag','New MI stisified gateway flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(358,2,'MI Required Flag','Missing info required gateway flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(359,2,'State Review Received Flag','State Review Received activity step flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(360,2,'Process Data Correction Flag','Process Data Correction activity step flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(361,2,'Research and Resolve Issue Flag','Research and Resolve Issue activity step flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(362,2,'Request Missing Info Notification Flag','Request Missing Info Notification activity step flag.');

  commit;

end;
/
