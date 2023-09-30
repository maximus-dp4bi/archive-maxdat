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
  where ba.BEM_ID = 17
  order by bal.BAL_ID asc;
  */
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(5,3,'Complete Date','The date the instances is first set to a completed status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(47,3,'Cancel Date','Indicates the date the ETL discovered that the instance was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,2,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(547,2,'Cancel Reason','The reason that the JOB ID instance is cancelled.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(555,3,'Request Date','The date/time that the client notification was requested in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(576,2,'Cancel By','The name of the system or performer who cancelled the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(722,2,'Cancel Method','This is the method as per which the instance was cancelled');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(990,2,'Site Name','Identifies the KOFAX Capture installation site where the module was launched. ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(991,2,'Site ID','Identifies the KOFAX Capture installation site where the module was launched. The Site ID is assigned during the installation process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1023,1,'Outreach Session ID','Unique identifier for the outreach request in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1024,2,'Requested By','The name of the individual who requested the outreach session.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1025,2,'Request Method','The method by which the outreach session was requested.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1026,2,'Session Created By','The username or component that originally created the record.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1027,3,'Session Create Date','The date/timestamp when the record was originally created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1028,2,'Event Type','The type of outreach session being requested');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1029,2,'Session Status','The current status of the session. ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1030,3,'Session Status Date','The date/time that the SESSION STATUS was last updated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1031,2,'Public Allowed Indicator','Indicates if the public is allowed at the session.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1032,2,'Multilingual Indicator','Indicates if the session is multilingual.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1033,2,'Group Individual Indicator','Indicates if the session is for a group or individual.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1034,2,'Estimated Attendees','Estimated number of attendees for the session.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1035,3,'Event Date','The date on which the session is scheduled to be held.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1036,3,'Alternative Date 1','First alternate date for session.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1037,3,'Alternative Date 2','Second alternate date for session.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1038,3,'Alternative Date 3','Third alternate date for session');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1041,2,'Preparation Time','The preparation time for the session.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1042,2,'Travel Time','The travel time for the session.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1043,2,'Presenter Name','The name of the presenter of the session.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1044,2,'Site Type','The type of outreach organization.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1045,2,'Site Language','The language of the outreach organization.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1046,2,'Site City','The city in which the site is located where the outreach event will take place.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1047,2,'Site ZIP Code','The ZIP code of the area where the outreach session will take place.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1048,2,'Site County','The county in which the organization is located and in which the session is to be held.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1049,2,'Site State','The state in which the organization is located and in which the session is to be held.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1050,1,'Site Capacity','The capacity that the organization site can hold.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1051,2,'Site Service Area','The service area in which the outreach session is scheduled.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1052,2,'Site Status','The status of the organization hosting the Community Outreach Event.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1053,2,'Contact Name','The name of the contact for the session.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1054,2,'Session Updated By','The username or component which most recently updated the outreach session record.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1055,3,'Session Updated Dt','The date/timestamp when the record was most recently updated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1056,1,'Note Ref ID','The unique identifier of a note associated with the outreach session.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1057,2,'Reschedule Indicator','Indicates if the session has to be rescheduled.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1058,1,'Recurring Group ID','The unique identifier of a recurring session request.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1059,2,'Recurring Frenquency','The frequency at which the outreach event is to occur.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1060,1,'Number of Occurences','The number of occurences of session requests for a particular site.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1061,2,'Client Reg Req Indicator','Indicates if client registration is requested at the outreach session.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1062,2,'Session Start Time','The time the session is scheduled to start.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1063,2,'Session End Time','The time the session is scheduled to end.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1064,1,'Details Survey ID','The unique identifier for the Details Survey associated to the Outreach Session request. The survey is used to capture additional details about the outreach session requested. There is a one to one relationship between the Survey ID and Outreach Session ID.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1065,2,'Survey Name','The name of the survey associated to the outreach request. The survey name will vary depending on the event type.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1066,2,'Event Title','The title of the HHSC Presentation Event or Community Event.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1067,2,'Languages Supported','The languages that will be supported at the HHSC Presentation.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1068,2,'Event Received From','The type of organization that submitted the request for an outreach session.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1069,2,'Event Received Via','The channel through which the request for an outreach session was received.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1070,2,'General Public Indicator','Indicates if the general public is expected to attend.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1071,2,'Seniors Indicator','Indicates if seniors are expected to attend.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1072,2,'Restricted to Agency Indicator','Indicates if the event is restricted to agency.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1073,2,'School Aged Families Indicator','Indicates if school aged families are expected to attend.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1074,2,'Migrants Indicator','Indicates if migrants are expected to attend.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1075,2,'Pregnant Women/Teens Indicator','Indicates if pregnant women/teens are expected to attend.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1076,2,'Other Groups Indicator','Indicates if other groups are expected to attend.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1077,2,'Plans to Attend','Describes if MAXIMUS and plans are expected to attend. ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1078,2,'All Plans Invited Indicator','Indicates if all plans are invited to the event.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1079,2,'STAR Invited Indicator','Indicates if STAR is invited to the event.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1080,2,'STAR+PLUS Invited Indicator','Indicates if STAR+PLUS is invited to the event.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1081,2,'Dental Invited Indicator','Indicates if Dental is invited to the event.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1082,2,'NorthSTAR Invited Indicator ','Indicates if NorthSTAR is invited to the event.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1083,2,'Plan Sponsored Indicator','Indicates if the event is plan sponsored.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1084,2,'Plan Exclusive Indicator','Indicates if the event is plan exclusive.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1085,2,'Plan RSVP Indicator','Indicates if plans are required to RSVP to attend the event.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1086,2,'RSVP Deadline','The date by which plans must RSVP if they plan to attend the event.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1087,2,'STAR Event Indicator','Indicates if the event is for STAR.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1088,2,'STAR+PLUS Event Indicator','Indicates if the event is for STAR+PLUS.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1089,2,'NorthSTAR Event Indicator','Indicates if the event is for NorthStar.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1090,2,'Dental Event Indicator','Indicates if the event is for Dental.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1091,2,'Survey Comments','Additional comments added to the survey concerning the outreach session.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1092,3,'Review Event Start Date','The date/time that the Review Event activity step began.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1093,3,'Review Event End Date','The date/time that the Review Event activity step ended.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1094,2,'Review Event Performed By','The username of the person who completed the activity step. (will be the username of the person who updated the outreach event type to something other than Pending Review-....)');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1095,3,'Wait for Event Start Date','The date/time that the Wait for Event activity step began. ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1096,3,'Wait for Event End Date','The date/time that the Wait for Event activity ended. This is the date/time when the event_date = sysdate.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1097,3,'Record Outcome Start Date','The date/time that the Record Outcome activity step began. This is equal to the event_date.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1098,3,'Record Outcome End Date','The date/time that the Record Outcome activity step ended. This is equal to the create date of the Community Activity record that is linked to the Community Event.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1099,2,'Record Outcome Performed By','The username of the person who completed the activity step. This will be equal to the username of the person who created the Community Activity Record that is linked to the Community Event.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1102,2,'Approved Flag','Approved Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1103,2,'Push to Calendar Flag','Push to Calendar Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1104,2,'MAXIMUS Attended Flag','MAXIMUS Attended Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1105,2,'Review Event Flag','Review Event Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1106,2,'Wait for Event Flag','Wait for Event Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1107,2,'Record Outcome Flag','Record Outcome Activity Step Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1108,2,'Duration','The duration of the session in hours and minutes. This field is a combination of the Duration in Minutes Cd and Duration in Hours Cd fields in the source system.'); 
   
  commit;

end;
/