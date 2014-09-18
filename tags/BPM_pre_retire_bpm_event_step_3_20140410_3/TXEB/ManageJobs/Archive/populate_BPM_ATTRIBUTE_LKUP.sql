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
  where ba.BEM_ID = 11
  order by bal.BAL_ID asc;
  */
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(5,3,'Complete Date','The date the instances is first set to a completed status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(7,3,'Create Date','This is the date that the instance was created in the MAXe system');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(47,3,'Cancel Date','Indicates the date the ETL discovered that the instance was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,2,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(100,3,'Receipt Date','The receipt date is set when the instance is received by Maximus');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(157,2,'Created By','The Created By is the name of the performer who created the envelope.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(506,1,'Job ID','The name of the system or performer that update the job record in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(507,2,'Job Name','System assigned name for the job.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(508,2,'Job Detail','Job detail contains specific job instance information generated by the system when processing the job. If the job is an inbound or outbound interface processing job, this will be populated with a sting of data that contains the interface file name, among other details. If the job is not an inbound or outbound interface processing job, this will be populated with other information related to the job.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(509,2,'Job Group','System defined grouping of jobs.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(510,2,'Job Type','Job Type describes the work the job is performing.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(511,3,'Job Start Date','The date/time the job started processing.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(512,3,'Job End Date','The date/time the job completed processing, or errored out of processing.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(513,2,'Job Status','The status of the job in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(514,2,'File Name','The interface file name for job instances that are processing inbound or outbound files (JOB_TYPE is either Inbound File or Outbound File), if applicable. If the job instance is not processing files (JOB_TYPE is Other Job Type) this will not be populated. Project configured values for File Name are listed in the Values Tab under File_Name.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(518,3,'Transmit Date','The date/time the outbound interface file was transmitted for the JOB instance, if applicable. If the job instance is not processing an outbound file (JOB_TYPE is Other Job Type or Inbound File) this will not be populated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(519,2,'File Type','A grouping of interface files by type as defined by the project. If the job instance is not processing files (JOB_TYPE is Other Job Type) this will not be populated. Project configured values for File Type are listed in the Values Tab under File_Type.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(520,2,'File Source','The originating source of the interface file that is being processed by the JOB, if applicable. If the job instance is not processing an interface file (JOB_TYPE is Other Job Type) this will not be populated. Project configured values for File Source are listed in the Values Tab under File_Source.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(521,2,'File Destination','The destination of the interface file that is being processed by the JOB, if applicable. If the job instance is not processing an interface file (JOB_TYPE is Other Job Type) this will not be populated. Project configured values for File Destination are listed in the Values Tab under File_Destination.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(522,2,'Health Plan Name','The health plan name associated with a JOB that is processing either an inbound or outbound file, if applicable. If the job instance is not processing an interface file (JOB_TYPE is Other Job Type), or if the file source or destination is not a health plan, this will not be populated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(523,2,'Reponse File Required','Indicates when a response file is required as a result of the job processing an inbound interface file, if applicable. If the job instance is not processing an inbound file (JOB_TYPE is Other Job Type or Outbound File) this will not be populated. Project configured values for Response File Required are listed in the Values Tab under Response_File_Required.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(524,1,'Record Count','The total record count of an inbound or outbound interface file that have been processed by the job instance. If the job instance is not processing files (JOB_TYPE is Other Job Type) this will not be populated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(525,1,'Record Error Count','The number of records from an inbound file that could not be processed by the job instance, or the number of records that could not be processed and sent on an outbound file due to error. If the job instance is not processing files (JOB_TYPE is Other Job Type) this will not be populated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(526,2,'Response File Name','Provides the name of the response file that was created as a result of the job processing an inbound file, if applicable. If the job instance is not processing an inbound file (JOB_TYPE is Other Job Type  or Outbound File) this will not be populated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(527,2,'Last Update by Name','The name of the system or performer that update the job record in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(528,3,'Last Update by Date','The date/time that the job record in the source system was updated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(529,3,'Identify Job Start Date','Identify Job Activity Step Start Date');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(530,3,'Identify Job End Date','Identify Job Activity Step End Date');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(531,3,'Process Job Start Date','Process Job Activity Step Start Date.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(532,3,'Process Job End Date','Process Job Activity Step End Date.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(533,3,'Create Reponse File Start Date','Create Reponse File Activity Step Start Date.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(534,3,'Create Response File End Date','Create Response File Activity Step End Date.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(535,3,'Create Outbound Start Date','Create Outbound Activity Step Start Date.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(536,3,'Create Outbound End Date','Create Outbound Activity Step End Date');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(537,2,'Identify Job Flag','Identify Job Activity Step Flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(538,2,'Process Job Flag','Process Job Activity Step Flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(539,2,'Create Reponse File Flag','Create Reponse File Activity Step Flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(540,2,'Create Outbound File Flag','Create Outbound File Activity Step Flag.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(541,2,'Processed OK Flag','Processed OK Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(542,2,'Job Type Flag','Job Type Gateway Flag');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(543,2,'Response File Flag','Response File Gateway Flag \');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(547,2,'Cancel Reason','The reason that the JOB ID instance is cancelled.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(548,2,'File Received Timely','For a JOB TYPE of Inbound File, File Received Timely indicates if a file has been received when expected (timely) or not (untimely).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(549,2,'Record Count Threshold Met','For a JOB TYPE of Inbound File, indicates whether or not file record count is within expected range.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(550,1,'Record Error Percentage','For a JOB TYPE of Inbound File, percentage of records that fail processing due to error based on total record count of an inbound interface file.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(551,2,'Record Error Threshold','For a JOB TYPE of Inbound File, indicates if the file processed within accepted error margin.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(552,2,'File Processed Timely','For a JOB TYPE of Inbound File, File Processed Timely indicates if a file has been processed timely (within managerial defined targets) or untimely.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(553,1,'File Process Time','For a JOB TYPE of Inbound File, Total time for file processing to complete, measured in days-hours-minutes-seconds from JOB_START_DT to JOB_END_DT');
  
  commit;

end;
/
