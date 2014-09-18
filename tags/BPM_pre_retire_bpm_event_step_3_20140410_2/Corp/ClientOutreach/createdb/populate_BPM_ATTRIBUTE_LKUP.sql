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
  where ba.BEM_ID = 15
  order by bal.BAL_ID asc;
  */
        BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(3,3,'Cancel Work Date','Indicates the date the ETL discovered that the task was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(5,3,'Complete Date','The date the instances is first set to a completed status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(7,3,'Create Date','This is the date that the instance was created in the MAXe system');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(47,3,'Cancel Date','Indicates the date the ETL discovered that the instance was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(59,2,'County','County associated with the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(60,1,'Current Task ID','Task ID identifying the current task for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,2,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(100,3,'Receipt Date','The receipt date is set when the instance is received by Maximus');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(157,2,'Created By','The Created By is the name of the performer who created the envelope.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(170,2,'Current Task Type','The Current Task Type is the name of the task, if one exists, associated to the envelope in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(454,1,'Origin ID','If the source of the complaint has a record associated with it such as an image and it can be linked through an ID, then record the ID.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(455,1,'Priority','An assignment by the project to group incidents such that they can be completed outside first-in-first-out (FIFO) strategy.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(479,1,'Case_ID','Unique identifier associated to the case level task in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(494,2,'Notify Client Flag','Describes whether or not the incident type requires client notification. ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(547,2,'Cancel Reason','The reason that the JOB ID instance is cancelled.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(576,2,'Cancel By','The name of the system or performer who cancelled the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(593,1,'Client_ID','Unique identifier associated to the client level task in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(655,2,'Tracking Number','Reference number that an individual can provide the agent upon contact to expedite lookup.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(722,2,'Cancel Method','This is the method as per which the instance was cancelled');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(725,2,'Service Area','Service Area describes the region or district of the state in which the member resides that determines the plans available and / or type of coverage availble to the eligible client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(740,2,'Program Type','Program Type categorizes the type of program for the client (used to populate the enrollment packet).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(747,2,'Generic Field 1','Generic Field will allow for future attribute mapping');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(748,2,'Generic Field 2','Generic Field will allow for future attribute mapping');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(749,2,'Generic Field 3','Generic Field will allow for future attribute mapping');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(750,2,'Generic Field 4','Generic Field will allow for future attribute mapping');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(751,2,'Generic Field 5','Generic Field will allow for future attribute mapping');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(803,1,'Outreach Request ID','Unique identifier for the Outreach Request in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(804,2,'Origin','This is the channel through which the request was received by Maximus.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(805,2,'Outreach Request Category','A description of what the Outreach Request is about. Also known as Affected Party Type.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(806,2,'Outreach Request Type','A subcategorization of OUTREACH REQUEST ABOUT. Describes in detail the reason for the Outreach Request. Also known as Affected Party Subtype.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(807,2,'Subprogram Type','The Subprogram associated with the Case associated with the Outreach Request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(808,2,'Outreach Request Status','The current status of the Outreach Request');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(809,3,'Outreach Request Status Dt','The date/time that the Outreach Request Status was last updated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(810,2,'Validation Error','A description of why the Outreach Request was determined to be Invalid');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(811,2,'Notify Invalid Indicator','Indicates if the Outreach Request requires notification be sent to the source of the request if the request is determined to be invalid.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(813,2,'Outreach Step 1 Type','The type of outreach step that should be completed as Outreach Step 1 in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(814,2,'Outreach Step 2 Type','The type of outreach step that should be completed as Outreach Step 2 in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(815,2,'Outreach Step 3 Type','The type of outreach step that should be completed as Outreach Step 3 in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(816,2,'Outreach Step 4 Type','The type of outreach step that should be completed as Outreach Step 4 in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(817,2,'Outreach Step 5 Type','The type of outreach step that should be completed as Outreach Step 5 in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(818,2,'Outreach Step 6 Type','The type of outreach step that should be completed as Outreach Step 6 in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(819,2,'Current Task Status','The current status of the task associated to the Outreach Request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(820,1,'Survey ID','ID for the survey associated to this Outreach Request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(821,2,'Survey Template Name','The name of the survey template completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(822,2,'CPW - Referral Date','The date that the referral was received.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(823,2,'CPW - Referral Source Type','The Type of referral source that provided the referral.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(824,2,'CPW - Referral Source Name','The name of the Referral Source.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(825,2,'CPW - Referral Reason','The reason the referral is necessary.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(826,2,'CPW - Call Back Indicator','Indicates if the Referral Source desires a Call back with Client Status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(827,2,'CPW - Priority Status of Referral','Indicates if the priority of the referral is Urgent or Standard.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(828,2,'Prov Ref - Provider Type','The type of Provider associated to the Outreach Request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(829,2,'Prov Ref - Provider/Clinic Name','The name of the specific Provider associated to the Outreach Request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(830,2,'Prov Ref - Provider City','The city in which the provider is located.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(831,2,'Prov Ref - Provider County','The county in which the provider is located.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(832,2,'Prov Ref - Provider ZIP Code','The ZIP code of the area in which the provider is located.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(833,2,'Prov Ref - Provider Date Referred','The date the referral was created by the provider.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(834,2,'Prov Ref - Missed Appointment Indicator','Indicates if the Prov Ref is for a client who missed an appointment.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(835,2,'Prov Ref - Missed Appointment Date','The dates of the missed appointments. The field can hold multiple dates if multiple appointments have been missed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(836,2,'Prov Ref - Missed Appointment Type','Captures the type of appointment that was missed. Only populated if REFERRAL TYPE = Missed Appointment.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(837,2,'Prov Ref - Missed Appointment Outreach Outcome','Captures the outcome of the Missed Appointment Outreach request');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(838,2,'Prov Ref - Missed Appointment Reason','The reason the appointment was missed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(839,2,'Prov Ref - Follow Up Lead Testing Indicator','Indicates if follow up lead testing is required for the provider referral.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(840,2,'Prov Ref - Assist with Transportation','Indicates if the provider referral client needs assistance with transportation.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(841,2,'Prov Ref - Assistance Needed Scheduling Appt','Indicates if the provider referral client needs assistance scheduling an appointment.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(842,2,'Prov Ref - Updated Patient Address','Indicates if the provider referral client needs their address updated (only for Case Management Providers).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(843,2,'Prov Ref - Other','Indicates if the provider referral is of the type Other.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(844,2,'Prov Ref - Other Comment','Comment captured if PROVREF_OTHER_IND = Yes to capture what the Other is.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(845,2,'Checkup - Type','The type of checkup for which a Checkup Verification Request was created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(846,2,'Checkup - Texas Works Advisor Name','The name of the Texas Works Advisor who submitted the Checkup Verification Request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(847,2,'Checkup - Caretaker Reports Checkup Indicator','Indicates if the Caretaker reported the children had a checkup.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(848,2,'Checkup - Provider Name','The name of the provider to whom the client reported going to for their checkup.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(849,2,'Checkup - Date of Reported Checkup','The date of the reported checkup.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(850,2,'Extra Effort - Schedule THSteps Appt Indicator','Indicates if the extra effort referral is to schedule a THSteps checkup or other appointment.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(851,2,'Extra Effort - Transportation Indicator','Indicates if the extra effort referral is for transportation assistance.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(852,2,'Extra Effort - Need More Info Indicator','Indicates if the extra effor referral is for a client who needs more information about THSteps services.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(853,2,'Extra Effort - Need More Info - Medical','Indicates if the extra effort referral is for medical reasons.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(854,2,'Extra Effort - Need More Info - Dental','Indicates if the extra effort referral is for dental reasons.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(855,2,'Extra Effort - Need More Info - Case Management','Indicates if the extra effort referral is for case management reasons.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(856,2,'Extra Effort - Help Finding Provider Indicator','Indicates if the extra effort referral is for a client who needs help finding a provider.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(857,2,'Extra Effort - Phone Indicator','Indicates if the client should be contacted by phone.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(858,2,'Extra Effort - Home Visit Indicator','Indicates if the client should be contacted by Home Visit.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(859,2,'Extra Effort - Mail Indicator','Indicates if the client should be contacted by mail.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(860,2,'Extra Effort - Other Language Indicator','Indicates if the outreach is needed in a Language other than Spanish or English.  If the Language is other than Spanish or English, this will set to Y; else, N.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(861,2,'Extra Effort - Interpreter Needed Indicator','Indicates if an interpreter is needed when contacting the client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(862,2,'Extra Effort - Language','The language indicated the Extra Effort Referral is to be conducted in.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(863,2,'Home Visit - Request Reason','The reason the Home Visit request was created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(864,2,'Home Visit - Language other than English Indicator','Indicates if the Home Visit will need to be conducted in a language other than English');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(865,2,'Home Visit - Interpreter Needed Indicator','Indicates if the Home Visit will need an interpreter.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(866,2,'Home Visit - Language','The language indicated the Home Visit is to be conducted in.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(867,2,'Reminder - Appointment Type','The type of appointment for which an Appointment Reminder Outreach Request was created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(868,2,'Reminder - Appointment Date','The date of the appointment for which a reminder is needed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(869,2,'Reminder - Provider/Clinic Name','The name of the provider or clinic at which the appointment is scheduled.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(870,1,'Delay Days 1','First delay interval used in process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(871,2,'Delay Days 1 Unit','Unit for timeout interval, calendar days, business days, hours.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(872,1,'Delay Days 2','Second delay interval used in process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(873,2,'Delay Days 2 Unit','Unit for timeout interval, calendar days, business days, hours.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(874,1,'Delay Days 3','Third delay interval used in process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(875,2,'Delay Days 3 Unit','Unit for timeout interval, calendar days, business days, hours.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(876,1,'Letter Definition 1','ID for the first letter that can be created within the process, foreign key to the Letter Definition Table.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(877,1,'Letter Definition 2','ID for the second letter that can be created within the process, foreign key to the Letter Definition Table.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(878,1,'Letter Definition 3','ID for the third letter that can be created within the process, foreign key to the Letter Definition Table.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(879,2,'Human Task Type 1','The first type of Human Task that is created within the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(880,2,'Human Task Type 2','The second type of Human Task that is created within the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(881,2,'Notify Outcome Indicator','Used to define when notification of outreach outcome must be sent to referral agency.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(882,1,'Client Notification ID','The unique identifier of the notification created for the client, as a result of the Outreach Request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(883,1,'Outcome Notification Task ID','The unique identifier of the notification created to inform the referral source of the outcome of the outreach request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(884,2,'Last Update By','The username of the person who last updated the Outreach Request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(885,2,'Final Wait Indicator','Indicates if the process requires a Final Wait before terminating.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(886,1,'Final Wait','The length of time that the outreach process remains open before being terminated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(887,2,'Final Wait Unit','The type of days in which the Final Wait is calculated. (Business or Calendar)');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(888,3,'Validate Outreach Request Start Date','The date/time that the Process Outreach Request Activity Step began.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(889,3,'Validate Outreach Request End Date','The date/time that the Process Outreach Request Activity Step ended.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(890,2,'Validate Outreach Request Performed By','The username of the person or the system name of the system that completed the Process Outreach Request activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(891,3,'Perform Outreach Start Date','The date/time that the Perform Outreach activity step began. The date/time that the outreach request was validated. Equal to ASSD Perform Outreach Step 1.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(892,3,'Perform Outreach End Date','The date/time that the Perform Outreach Activity step ended. The date/time that the outreach request reached a terminal status (and the termination timer was completed if required).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(893,2,'Perform Outreach Performed By','The username of the person who completed the Perform Outreach activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(894,3,'Perform Outreach Step 1 Start Date','The date/time that the Perform Outreach Step 1 activity Step began.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(895,3,'Perform Outreach Step 1 End Date','The date/time that the Perform Outreach Step 1 activity Step ended.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(896,2,'Perform Outreach Step 1 Performed By','The username of the person or the system name of the system that completed the Perform Outreach Step 1 activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(897,3,'Perform Outreach Step 2 Start Date','The date/time that the Perform Outreach Step 2 activity Step began.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(898,3,'Perform Outreach Step 2 End Date','The date/time that the Perform Outreach Step 2 activity Step ended.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(899,2,'Perform Outreach Step 2 Performed By','The username of the person or the system name of the system that completed the Perform Outreach Step 2 activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(900,3,'Perform Outreach Step 3 Start Date','The date/time that the Perform Outreach Step 3 activity Step began.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(901,3,'Perform Outreach Step 3 End Date','The date/time that the Perform Outreach Step 3 activity Step ended.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(902,2,'Perform Outreach Step 3 Performed By','The username of the person or the system name of the system that completed the Perform Outreach Step 3 activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(903,3,'Perform Outreach Step 4 Start Date','The date/time that the Perform Outreach Step 4 activity Step began.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(904,3,'Perform Outreach Step 4 End Date','The date/time that the Perform Outreach Step 4 activity Step ended.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(905,2,'Perform Outreach Step 4 Performed By','The username of the person or the system name of the system that completed the Perform Outreach Step 4 activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(906,3,'Perform Outreach Step 5 Start Date','The date/time that the Perform Outreach Step 5 activity Step began.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(907,3,'Perform Outreach Step 5 End Date','The date/time that the Perform Outreach Step 5 activity Step ended.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(908,2,'Perform Outreach Step 5 Performed By','The username of the person or the system name of the system that completed the Perform Outreach Step 5 activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(909,3,'Perform Outreach Step 6 Start Date','The date/time that the Perform Outreach Step 6 activity Step began.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(910,3,'Perform Outreach Step 6 End Date','The date/time that the Perform Outreach Step 6 activity Step ended.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(911,2,'Perform Outreach Step 6 Performed By','The username of the person or the system name of the system that completed the Perform Outreach Step 6 activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(912,3,'Perform Home Visit Start Date','The date/time that the Perform Home Visit activity step began. (the date/time that the request status was set to Existing Request - Home Visit.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(913,3,'Perform Home Visit End Date','The date/time that the Perform Home Visit activity step ended.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(914,2,'Perform Home Visit Performed By','The username of the person that conducted the Peform Home Visit activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(915,3,'Wait for Termination Timer Start Date','The date/time that the Wait for Termination Timer activity began.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(916,3,'Wait for Termination Timer End Date','The date/time that the Wait for Termination Timer activity ended.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(917,3,'Notify Client Start Date','The date/time that the Notify Client activity step began.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(918,3,'Notify Client End Date','The date/time that the Notify Client activity step ended.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(919,2,'Notify Client Performed By','The username of the person or the system name of the system that completed the Notify Client activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(920,3,'Notify Referral Source Start Date','The date/time that the Notify Referral Source activity step began.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(921,3,'Notify Referral Source End Date','The date/time that the Notify Referral Source activity step ended.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(922,2,'Notify Referral Source Performed By','The username of the person or the system name of the system that completed the Notify Referral Source activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(923,2,'Validate Request Flag','Validate Request Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(924,2,'Perform Outreach Flag','Perform Outreach Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(925,2,'Notify Referral Source Flag','Notify Referral Source Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(926,2,'Perform Outreach Step 1 Flag','Outreach Step 1 Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(927,2,'Perform Outreach Step 2 Flag','Outreach Step 2 Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(928,2,'Perform Outreach Step 3 Flag','Outreach Step 3 Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(929,2,'Perform Outreach Step 4 Flag','Outreach Step 4 Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(930,2,'Perform Outreach Step 5 Flag','Outreach Step 5 Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(931,2,'Perform Outreach Step 6 Flag','Outreach Step 6 Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(932,2,'Home Visit Flag','Home Visit Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(933,2,'Termination Timer Flag','Termination Timer Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(934,2,'Invalid Flag','Invalid Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(935,2,'Outreach Step 2 Flag','Outreach Step 2 Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(936,2,'Outreach Step 3 Flag','Outreach Step 3 Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(937,2,'Outreach Step 4 Flag','Outreach Step 4 Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(938,2,'Outreach Step 5 Flag','Outreach Step 5 Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(939,2,'Outreach Step 6 Flag','Outreach Step 6 Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(940,2,'Unsuccessful Flag','Unsuccessful Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(941,2,'Final Wait Flag','Final Wait Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(942,2,'Send Client Notification Flag','Send Client Notification Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(943,2,'Notify Source Flag','Notify Sourcee Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1602,2,'Extra Effort - Other Indicator','Indicates if the extra effort referral is for a client who needs assistance with something Other than the other possible options.');
  
  commit;

end;
/