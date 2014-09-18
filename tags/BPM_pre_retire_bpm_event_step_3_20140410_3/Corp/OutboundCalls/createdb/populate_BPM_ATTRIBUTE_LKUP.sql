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
  where ba.BEM_ID = 20
  order by bal.BAL_ID asc;
  */
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(5,3,'Complete Date','The date the instances is first set to a completed status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(7,3,'Create Date','This is the date that the instance was created in the MAXe system');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(47,3,'Cancel Date','Indicates the date the ETL discovered that the instance was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,2,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(476,2,'Program','The name of the program the enrollee/s or potential enrollee/s are enrolled in or are eligible when the incident is associated to a case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(477,2,'Sub-Program','The name of the sub-program the enrollee/s or potential enrollee/s are enrolled in or are eligible for when the incident is associate to a case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(479,1,'Case ID','The case identifier for the enrollee or potential enrollee submitting the incident if   when the incident is associated to a case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(506,1,'Job ID','The name of the system or performer that update the job record in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(547,2,'Cancel Reason','The reason that the JOB ID instance is cancelled.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(559,2,'Language','The language that the letter was requested in.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(593,1,'Client ID','The client id/s included in the letter request.  This list should NOT include any clients associated to a case that are NOT included in the letter (e.g. - for general notifications sent to the case head that do not include client names, this will be null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(722,2,'Cancel Method','This is the method as per which the instance was cancelled');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1311,1,'Outbound Call Identifier','Outbound Call Identifier');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1312,2,'Case CIN','A secondary unique identifier of the Case in MAXeb that is used for external purposes and directly (one to one) related to the Case ID.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1313,2,'Campaign Indicator','The reason for the outbound call. ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1314,1,'Row ID','The row on the job that represents the record.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1315,2,'Campaign ID','The name of the call campaign for which the outbound call record was created.');
/* 9/30/13 B.Thai exclude due to PHI
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1316,2,'State Reported Home Phone','The first phone number added to the call record. This number is the state reported home phone number associated with the case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1317,2,'Client Reported Home Phone','The second phone number added to the call record. The  number is the client reported home phone number associated with the case in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1318,2,'Client Reported Cell Phone','The third phone number added to the call record. The number is the client reported cell phone number associated with the case in MAXeb.');
*/
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1319,2,'Phone Numbers Provided','The number of phone numbers provided to the Outbound Dialer for the specific call record. ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1320,1,'Error Count','Indicates if the dial file record was in error or not.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1321,2,'Error Text','The reason for the error on the dial file record.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1322,3,'Job Processing End Time','The date/time that the outbound dial file completed processing.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1323,1,'Letter/Materials Request ID','The unique identifier of a Letter or Materials request associated to this dial file record.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1324,1,'Number of Attempts Required','The number of attempts that the system will make to contact the client at each unique phone number provided. ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1325,1,'Number of Attempts Made','The number of call attempts dialed for the call record. ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1326,2,'Dial Cycle Outcome','The outcome of the call record indicating if the dialer (after all attempts made) made contact with or failed to reach a live person or voicemail.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1327,3,'Transmit to Dialer Start Date','The date/time that the Dialer File (outbound interface file) was created containing the call record. This should be set to create_dt.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1328,3,'Transmit to Dialer End Date','The date/time that the outbound dial file was sent to the dialer.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1329,3,'Process Outcome Start Date','The date/time that the Dialer Response File was received from the outbound dialer. This will be the create date of the first job to be processed with a dialer response record associated to the parent record.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1330,3,'Process Outcome End Date','The date/time that the call record was completed (See UPD5_10 for conditions that indicate completion).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1331,2,'Transmit to Dialer Flag','Transmit Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1332,2,'Process Outcome Flag','Process Activity Step Outcome Flag');
  
  commit;

end;
/