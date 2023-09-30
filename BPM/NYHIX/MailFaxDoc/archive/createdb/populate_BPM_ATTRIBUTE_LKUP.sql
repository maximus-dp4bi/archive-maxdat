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
  where ba.BEM_ID = 18
  order by bal.BAL_ID asc;
  */  

BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(7,3,'Create Date','This is the date that the instance was created in the MAXe system');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(35,2,'Timeliness Status','Indicates if the instance was processed timely or untimely based on the SLA Days Type, SLA Days, and age or cycle days. Default value is Not Required');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(47,3,'Cancel Date','Indicates the date the ETL discovered that the instance was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(49,2,'Channel','This is the channel through which the instance was received by Maximus');
BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(60,1,'Current Task ID','Task ID identifying the current task for the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(61,1,'Data Entry Task ID','Task ID identifying the Data Entry task created for the instance');
BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,1,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(178,2,'Current Step','The Current Activity Step identifes where the instance is in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(193,1,'Document ID','The Document ID is the unique identifier to track individual documents in an envelope. This Document ID is created in DMS and saved in MAXe.');
  
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(194,2,'Document Type','The Document Type is the high level description of a document in an envelope.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(195,2,'Document Subtype','The Document Sub-Type is the description of the information inside an envelope.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(413,1,'DCN','The DCN is the unique identifier to track individual documents in an envelope. The DCN is created in DMS and saved in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(417,2,'ECN','The ECN is a unique number assigned to each envelope for tracking.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(419,2,'Rescanned','The rescanned attribute indicates whether the document is an original or has been rescanned. If the image received from KOFAX is a re-scan, set this flag to Y.  If the image is not a rescan, set to N.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(421,2,'Document Status','This is the document status assigned by the system during the imaging process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(422,3,'Document Status Date','This is the status date/time for the current Document Status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(439,2,'Link Method','The method in which the document was linked to the case, either by successful auto-linking or by manual linking.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(441,1,'Link Number','This attribute contains, the case, client or transaction number that the image is linked to depending on the value set in Link Via.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(451,1,'Incident ID','Incident ID is the MAXeb defined unique identifier assigned to each incident created in the system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(456,2,'Incident Status','The status of the incident in MAXeb.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(457,3,'Incident Status Date','Date/time when INCIDENT STATUS was set or updated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(518,3,'Transmit Date','The date/time the outbound interface file was transmitted for the JOB instance, if applicable. If the job instance is not processing an outbound file (JOB_TYPE is Other Job Type or Inbound File) this will not be populated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(559,2,'Language','The language that the letter was requested in.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(787,2,'First Follow-up Required Flag','First Follow-up Required Gateway Flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(884,2,'Last Update By','The username of the person who last updated the Outreach Request.');
BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(948,1,'Instance Status Dt','The date and time the batch was created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(973,3,'Release Dt','Date and time when the KOFAX Export Module completed processing the scanned and imported documents through the Export engine');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1200,2,'Appeal Data Entry Task ID',' Task ID for an appeal from the document');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1201,1,'Complaint Data Entry Task ID',' Task ID for a complaint data entry task from the document');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1202,3,'Create Appeal End','The timedate stamp when the activity step starts.  This should be the datetime when the corresponding  Task is completed and an incident is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1203,3,'Create Appeal Start','The timedate stamp when the activity step starts.  This should be the datetime when the corresponding  Task is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1204,3,'Create Complaint End','The timedate stamp when the activity step starts.  This should be the datetime when the corresponding  Task record is completed and an incident is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1205,3,'Create Complaint Start','The timedate stamp when the activity step starts. This should be the datetime when the corresponding  Task record is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1206,3,'Data Entry End','The timedate stamp when the activity step starts.  This should be the datetime when the corresponding  Task is completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1207,3,'Data Entry Start','The timedate stamp when the activity step starts.  This should be the datetime when the corresponding  Task is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1208,3,'Doc Set Link QC End','The timedate stamp when the activity step starts.  This should be the datetime when the corresponding  Task is completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1209,3,'Doc Set Link QC Start','The timedate stamp when the activity step starts.This should be the datetime when the corresponding  Task is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1210,1,'Doc Set Link QC Task ID',' Task ID for Doc Set Link QC Task');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1211,1,'Doc Transmit Attempt Count','The count of attempted document imagedata transmission attempts.  ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1212,2,'Document Note ID','ID of a note related to a document in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1213,1,'Document Set ID','Unique identifier of a set of documents in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1214,2,'Document Trashed ','Indicator for if a document is trashed in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1215,2,'Envelope Status','This is the Envelope status assigned by the system during the imaging process.  ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1216,3,'Envelope Status Date','This is the status datetime for the current Envelope Status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1217,1,'Escalated Task ID',' Task ID for Escalated Task');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1218,1,'Escalated Task ID 2',' Task ID for Escalated Task');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1219,2,'Expedited','Indicator for if the Document was marked as Expedited in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1220,2,'Form Type','The Document Form type is the description of the form returned by the client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1221,2,'Free Form Text ','Indicates whether the document is flagged as Free Form Text ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1222,2,'HSDE Error','Indicates whether this document has an HSDE error or whether it is simply in an envelope with another document that has an error');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1223,1,'HSDE QC Task ID',' Task ID for HSDE QC ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1224,3,'Manual Link Document End','The timedate stamp when the activity step starts.This should be the datetime when the corresponding  Task is completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1225,3,'Manual Link Document Start','The timedate stamp when the activity step starts.  This should be the datetime when the corresponding  Task is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1226,1,'Manual Linking Task ID',' Task ID for Manual LinkingLink Doc Set ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1227,3,'MAXe Create Doc End','The timedate stamp when the activity step ends.This should be the datetime when a task is created, or the document is transmitted to NYHBE');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1228,3,'MAXe Create Doc Start','The timedate stamp when the activity step starts. This should be the datetime when the document is created in the DMS.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1229,3,'MAXe Doc Create DT','The datetime that the document record is created in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1230,3,'MAXIMUS QC End','The timedate stamp when the activity step starts.  This should be the datetime when the corresponding  Task is completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1231,3,'MAXIMUS QC Start','The timedate stamp when the activity step starts.  This should be the datetime when the corresponding  Task is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1232,1,'MAXIMUS QC Task ID',' Task ID for MAXIMUS QC Task');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1233,2,'Original Doc Type','Original Document type if a document is reclassified');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1234,2,'Original Form Type','Original Document type if a document is reclassified');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1235,1,'Page Count','Count of individual pages in a document.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1236,1,'Rescan Count','Number of times a document was rescanned');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1237,2,'Research Requested','Indicator for if research has been requested on a  Document');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1238,3,'Resolve Escalated Task 2 End','The timedate stamp when the activity step starts.  This should be the datetime when the corresponding  Task is completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1239,3,'Resolve Escalated Task 2 Start','The timedate stamp when the activity step starts.  This should be the datetime when the corresponding  Task is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1240,3,'Resolve Escalated Task End','The timedate stamp when the activity step starts.  This should be the datetime when the corresponding  Task is completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1241,3,'Resolve Escalated Task Start','The timedate stamp when the activity step starts.  This should be the datetime when the corresponding  Task is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1242,3,'Resolve HSDE QC Task End','The timedate stamp when the activity step starts.  This should be the datetime when the corresponding  Task is completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1243,3,'Resolve HSDE QC Task Start','The timedate stamp when the activity step starts.  This should be the datetime when the corresponding  Task is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1244,2,'Returned Mail','Indicator for if a doc is returned mail');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1245,3,'Scan Date','The date the document was Scanned into KOFAX');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1248,3,'Transmit to NYHBE End','The timedate stamp when the activity step ends.  This should be the datetime when the corresponding STEP_INSTANCE record is completed successfully.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1249,3,'Transmit to NYHBE Start','The timedate stamp when the activity step starts. This should be the datetime when the corresponding STEP_INSTANCE record is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1250,2,'MAXe Create Doc Activity Step Flag','Create Document in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1251,2,'Create Complaint Activity Step Flag','Create Complaint (Complaint Data Entry Task)');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1252,2,'Create Appeal Activity Step Flag','Create Appeal (Appeal Data Entry Task)');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1253,2,'Resolve HSDE QC Task Activity Step Flag','Resolve XML Error (HSDE QC Task)');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1254,2,'Manual Link Doc Activity Step Flag','Link Document to Client (Manual Linking Task)');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1255,2,'Doc Set Link QC Activity Step Flag','Complete Link QC (Doc Set Link QC Task)');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1256,2,'Resolve Escalated Task Activity Step Flag','Resolve Escalated Issue (DPR Task)');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1257,2,'Data Entry Activity Step Flag','Complete Data Entry (Verification Doc Task)');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1258,2,'MAXIMUS QC Activity Step Flag','Complete MAXIMUS QC (Task)');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1259,2,'Resolve Escalated Task 2 Activity Step Flag','Resolve Escalated Issue (DPR Task)');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1260,2,'Transmit to NYHBE Activity Step Flag','Transmit Document Data to NYHBE');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1261,2,'HSDE QC Req Gateway Flag','HSDE QC Req Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1262,2,'Autolink Successful Gateway Flag','Autolink Successful Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1263,2,'Doc Set Link QC Req Gateway Flag','Doc Set Link QC Req Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1264,2,'Data Entry Req Gateway Flag','Data Entry Req Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1265,2,'MAXIMUS QC Req Gateway Flag','MAXIMUS QC Req Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1268,3,'Jeopardy Date','First date on which the document is considered in Jeopardy, this is the date that the  document Jeopardy Flag was or will be set to Y');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1269,1,'Jeopardy Days','The age at which the instance is determined to be in jeopardy of becoming untimely');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1270,2,'Jeopardy Days Type','Type of days for Jeopardy Business or Calendar');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1272,1,'Linked Client','The client that the document is associated with ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1283,1,'Target Days','Age at which the document processing cycle is determined to be untimely based on target goals set by the business. If no target has been defined then this value is null. ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1284,1,'Timeliness Days','The number of days after which the instance is determined to be processed untimely.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1285,2,'Timeliness Days Type','Type of days for Timeliness measure Business or Calendar');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1542,2,'KOFAX DCN','The user visible unique identifier for a document, which is assigned by KOFAX and persists through the DMS and MAXe, and sent to the CSC portal');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(131,2,'Batch Name','Name assigned to the batch when it is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1605,3,'Origination Dt','The date the instance was originated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1609,2,'Previous KOFAX DCN','If a document has a duplicate Kofax DCN, systems populates this value with the original value when Kofax DCN is updated in MAXe.');

  commit;

end;
/