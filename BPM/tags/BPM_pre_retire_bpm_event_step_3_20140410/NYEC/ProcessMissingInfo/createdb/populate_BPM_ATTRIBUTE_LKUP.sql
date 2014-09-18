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
  where ba.BEM_ID = 5
  order by bal.BAL_ID asc;
  */
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1,1,'Age in Business Days','Number of days from the Create Date to the Complete Date, or to the Current Date for instances that are not yet complete, excluding weekends and project holidays.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(16,2,'Jeopardy Flag','Indicates if the application is in jeopardy based on the SLA Days Type and SLA Jeopardy Days. Default value is N');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(20,1,'SLA Days','Age at which time the measured cycle is determined to be untimely. If no SLA applies then this value is null');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(21,2,'SLA Days Type','Indicates if the SLA Days is based on Business Days or Calendar Days. If no SLA applies then this value is null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(22,1,'SLA Jeopardy Days','Age at which time the measured cycle is determined to be in Jeopardy. If no SLA applies then this value is null. This value should be easily configured and will initially be set to 2 for all instances.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(23,1,'SLA Target Days','Age at which time the measured cycle is determined to be untimely based on target goals set by the business. If no target has been defined then this value is null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(40,1,'Application ID','Unique identifier for the application in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(47,3,'Cancel Date','Indicates the date the ETL discovered that the instance was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(49,2,'Channel','This is the channel through which the instance was received by Maximus');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(60,1,'Current Task ID','Task ID identifying the current task for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(65,3,'Instance Complete Date','Date the instance reached a terminal point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,2,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(83,3,'Perform QC End Date','Date work ended for the Perform QC activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(85,2,'Perform QC Performed By','Name of the staff member that completed the Perform QC activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(86,3,'Perform QC Start Date','Date work started for the Perform QC activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(88,3,'Perform Research End Date','Date work ended for the Perform Research activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(89,2,'Perform Research Flag','Perform Research Activity Step');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(90,2,'Perform Research Performed By','Name of the staff member that completed the Perform Research activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(91,3,'Perform Research Start Date','Date work started for the Perform Research activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(97,2,'QC Outcome Flag','QC Outcome Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(98,2,'QC Required Flag','QC Required Gateway');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(99,1,'QC Task ID','Task ID identifying the QC task created for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(111,2,'Research Reason','This indicates the reason work was sent to Research.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(112,1,'Research Task ID','Task ID identifying the Research task created for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(123,3,'SLA Jeopardy Date','First date on which application is considered in Jeopardy, this is the date that the Jeopardy Flag was or will be set to Y');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(125,1,'State Review Task ID','Task ID identifying the State Review task created for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(222,3,'Complete MI Task End Date','Date work ended for the Complete MI Task activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(223,3,'Create State Accept Task End Date','Date work ended for the Create State MI Reprocess Task  activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(224,3,'Determine MI Outcome End Date','Date work ended for the Determine MI Outcome activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(225,3,'Receive MI End Date','Date work ended for the Receive MI activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(226,3,'Request MI End Date','Date work ended for the Request  MI activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(227,2,'Complete MI Task Performed By','Name of the staff member that completed the Complete MI Task  activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(228,2,'Create State Accept Task Performed By','Name of the staff member that completed the Create State MI Reprocess Task  activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(229,2,'Determine MI Outcome Performed By','Name of the staff member that completed the Determine MI Outcome activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(230,2,'Receive MI Performed By','Name of the staff member that completed the Receive MI activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(231,2,'Request MI Performed By','Name of the staff member that completed the Request  MI activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(232,3,'Complete MI Task Start Date','Date work started for the Complete MI Task  activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(233,3,'Create State Accept Task Start Date','Date work started for the Create State MI Reprocess Task activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(234,3,'Determine MI Outcome Start Date','Date work started for the Determine MI Outcome activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(235,3,'Receive MI Start Date','Date work started for the Receive MI activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(236,3,'Request MI Start Date','Date work started for the Request MI activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(237,1,'Manual Letter ID','This is the Manual Letter ID created in MAXe when MI is invalid');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(238,3,'Manual Letter Sent Date','This is the date that the manual letter was requested.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(239,2,'MI Call Campaign','This is used to monitor if the result of processing MI initiated a request for a MI Call Campaign or not.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(240,2,'MI Channel','This is the channel through which the Missing Information (document or data) was received by Maximus. For MI processed from the manual reprocess report the channel will be null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(241,1,'MI Cycle Business Days','This is the number of days excluding weekends and project holidays from the MI Cycle Start Dt to the MI Complete Dt for MI instances that have completed the MI Cycle. For applications with a timeliness status of Not Complete, the Current Date is used in place of a null MI Complete Dt for calculation. If an MI instance completes the business process without completing the MI Processing Cycle, then this value is null');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(242,3,'MI Cycle End Date','When instance is completed');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(243,3,'MI Cycle Start Date','The earliest of MI receipt date or MI create date  for purpose of determining MI processing Internal compliance.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(244,1,'MI Letter Request ID','Unique identifyer of the letter requested to notify client of additional MI');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(245,2,'MI Letter Status','This is used to monitor the status of a MI letter requested as a result of processing MI and new MI is identified.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(246,3,'MI Receipt Date','The receipt date is set when the MI is received.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(247,3,'MI Task Complete Date','The MI Task Completed Date is the date the instance is completed, terminated, or deleted in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(248,3,'MI Task Create Date','The MI Task Create Date is the date the task is created in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(249,1,'MI Task ID','The MI task ID is the unique ID associated to the task in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(250,2,'MI Task Type','This is the name of the task type for the instance.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(251,2,'Inbound MI Type','This is the type (document, data or both) of Missing Information provided.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(252,2,'Pending MI Type','This indicates if the application is currently pending for Missing Data, Missing Documentation, or Both');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(312,2,'Manual Letter Flag','This is used to monitor if the letter is a manual letter.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(365,2,'QC Required - Phone Flag','QC required phone gateway flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(366,2,'Update State System Flag','Update state system gateway flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(367,2,'Send Research Flag','Send research gateway flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(368,2,'MI Outcome Flag','MI outcome gateway flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(369,2,'Receive MI Flag','Receive MI accept activity step flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(370,2,'Create State Accept Flag','Create state accept activity step flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(371,2,'Determine MI Outcome Flag','Determine MI Outcome activity step flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(372,2,'Complete MI Task Flag','Determine MI Task activity step flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(373,2,'Perform QC on MI Flag','Perform QC on MI activity step flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(374,2,'Send MI Letter Flag','Send MI Letter activity step flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(393,2,'All MI Satisfied','Indicates if all MI (missing data and missing documents) that was created prior to or during processing of this instance was satisfied for this application as of the date processing was completed (MI Task Complete, QC Task Complete if required, Research Task Complete if required).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(394,3,'New MI Creation Date','The first date/time that new MI was added to the application during processing of this instance.  New MI is defined as MI added to the application after the State Data Entry - MI task was created and before the completion of all tasks for this instance (Research, QC, and State Data Entry - MI) and not satisfied prior to completion of all tasks for this instance.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(395,3,'New MI Satisfied Date','The latest date/time that all new MI added to the application during processing of this instance was satisfied.  New MI is defined as MI added to the application after the State Data Entry - MI task was created and before the completion of all tasks for this instance (Research, QC, and State Data Entry - MI) and not satisfied prior to completion of all tasks for this instance.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(396,3,'MI Letter Sent Date','This is the date that the MI Letter Status was updated to Sent.');

  commit;

end;
/
