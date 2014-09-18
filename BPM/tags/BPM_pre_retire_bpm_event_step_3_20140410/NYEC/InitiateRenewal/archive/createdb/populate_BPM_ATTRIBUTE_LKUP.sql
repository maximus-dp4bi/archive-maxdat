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
  where ba.BEM_ID = 6
  order by bal.BAL_ID asc;
  */
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1,1,'Age in Business Days','Number of days from the Create Date to the Complete Date, or to the Current Date for instances that are not yet complete, excluding weekends and project holidays.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(40,1,'Application ID','Unique identifier for the application in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(47,3,'Cancel Date','Indicates the date the ETL discovered that the instance was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(50,2,'Clockdown Indicator','If the application has not been received, 15 days prior to Authorization date, the state sends letter to client. Application is moved to clockdown');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(65,3,'Instance Complete Date','Date the instance reached a terminal point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,2,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(253,3,'Renewal File Received Date','This is the date that MAXIMUS receives the file with all cases who have entered renewal.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(254,3,'Shell App Create Date','This is the date that the renewal shell is created in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(255,2,'Shell App Create Source','Inidcates the method or orginal source of the request to begin the renewal cycle');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(256,3,'Renewal_Receipt Date','The receipt date is set when the application is received.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(257,3,'Authorization Change Date','This is the day the authorization date was changed');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(258,3,'Authorization End Date','MAXe Authorization End Date.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(259,3,'Close Date','The date that the renewal can no longer be processed and the client has not responded after being notified');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(260,2,'State Case Identifier','Unique identifier of the HEART Case (family) which is receiving the renewal application.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(261,3,'Notice 1 Due Date','This is the date that the nofication is due to be completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(262,3,'Notice 1 Create Date','This is the date that the notification request is created in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(263,3,'Notice 1 Complete Date','This is the date that the notification was completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(264,2,'Notice 1 Type','This is the type of outbound notification. For NYEC, Notification 1 is an outbound call.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(265,1,'Notice 1 Source ID','This is the letter ID or the outbound call ID created for the notification.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(266,3,'Notice 2 Due Date','This is the date that the nofication is due to be completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(267,3,'Notice 2 Create Date','This is the date that the notification request is created in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(268,3,'Notice 2 Complete Date','This is the date that the notification was completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(269,2,'Notice 2 Type','This is the type of outbound notification.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(270,1,'Notice 2 Source ID','This is the letter ID or the outbound call ID created for the notification.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(271,3,'Notice 3 Due Date','This is the date that the nofication is due to be completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(272,3,'Notice 3 Create Date','This is the date that the notification request is created in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(273,3,'Notice 3 Complete Date','This is the date that the notification was completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(274,2,'Notice 3 Type','This is the type of outbound notification.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(275,1,'Notice 3 Source ID','This is the letter ID or the outbound call ID created for the notification.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(363,2,'File Process Successful Flag','File process successful gateway flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(364,2,'Process Exception Result Flag','Process exception result gateway flag.');
  
  commit;

end;
/