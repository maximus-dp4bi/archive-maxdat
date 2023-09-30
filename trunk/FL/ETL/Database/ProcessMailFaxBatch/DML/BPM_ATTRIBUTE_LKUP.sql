--------------------------------------------------------
--  File created - Thursday-June-26-2014   
--------------------------------------------------------
REM INSERTING into  BPM_ATTRIBUTE_LKUP
SET DEFINE OFF;
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (146,1,'Batch ID','Unique identifier for the batch in KOFAX.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (131,2,'Batch Name','Name assigned to the batch when it is created.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (944,2,'Creation Station ID','Identifies the KOFAX Capture station where the batch is created. The Station ID is assigned during the installation process.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (137,2,'Batch Created By','This is the Windows login name for the user who creates the batch.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (945,2,'Creation User ID','If the User Profiles feature is enabled, the KOFAX Capture login ID for the user who creates the batch.  If User Profiles are not enabled, this is the Windows login name for the user who creates the batch.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (147,2,'Batch Class','Name of the batch class.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (946,2,'Batch Class Description','Description of the batch class on which the batch is based. ');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (134,2,'Batch Type','The type of batch. ');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (7,3,'Create Date','This is the date that the instance was created in the MAXe system');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (65,3,'Complete Dt','The date the batch was successfully released to DMS, cancelled, or otherwise deleted.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (66,2,'Instance Status','Instance Status indicates if the batch is in process or not. When the batch is created the status is set to Active, and it remains open until the batch has been successfully released to DMS,  is cancelled, or otherwise deleted when it is then set to Complete.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (948,3,'Instance Status Dt','The date and time the batch was created.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (155,1,'Batch Page Count','The total number of pages that are scanned in a single batch.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (139,1,'Batch Doc Count','Displays the total number of documents scanned in the batch.   The value is set based on the number of document separator sheets read through KOFAX.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (140,1,'Batch Envelope Count','The total number of envelopes in the batch.  This number is entered manually at the beginning of the scanning process.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (47,3,'Cancel Dt','The date when the instance was cancelled');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (952,3,'Perform Scan Start','The date and time work started on the Scan Batch activity step.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (953,3,'Perform Scan End','Date and time all work was completed for the Scan Batch activity step.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (954,2,'Perform Scan Performed By','The name of the staff member who completed the Scan Batch activity step.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (86,3,'Perform QC Start','The date and time work started on a batch for the Perform QC activity step.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (83,3,'Perform QC End','Date and time all work was completed for a batch for the Perform QC activity step.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (85,2,'Perform QC Performed By','The name of the staff member who completed the Perform QC activity step.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (152,2,'KOFAX QC Reason','The KOFAX QC Reason explains what occurred during the scanning process that requires the batch and its contents to be reviewed by a worker in the Perform QC Activity Step. The field defaults to null and is populated with the reason during scanning. If the scan completes and no reason exists, the field is set to None.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (955,3,'Classification Start','Date and time work started on a batch for the Recognition activity step.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (956,3,'Classification End','Date and time work was completed for a batch for the Classification activity step.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (957,3,'Classification Dt','Date and time that indicates when the document was classified.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (958,3,'Recognition Start','Date and time work started on a batch for the Recognition activity step.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (959,3,'Recognition End','Date and time work was completed for a batch for the Recognition activity step.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (960,3,'Recognition Dt','Date and time that indicates when the document completed Recognition. ');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (961,3,'Validate Data Start','Date and time work started on a batch for the Verify Results activity step.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (962,3,'Validate Data End','Date and time work was completed for a batch for the Verify Results activity step.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (963,2,'Validate Data Performed By','Name of the staff member who completed the Verify Results activity step.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (964,3,'Validation Dt','Date and time that indicates when the document was validated. ');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (965,3,'Create PDFs Start','Date and time when the PDF Generator module begins.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (966,3,'Create PDFs End','Date and time when the PDF Generator module completed converting each page of a document in a batch to a PDF. ');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (968,3,'Populate Reports Data Start','Date and time when the KOFAX Advanced Reports custom workflow agent begins capturing and storing the batch  information required for reporting');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (969,3,'Populate Reports Data End','Date and time when the KOFAX Advanced Reports custom workflow agent completes capturing and storing the batch  information required for reporting');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (971,3,'Release to DMS Start','Date and time when the KOFAX Export Module begins to process the scanned and imported documents through the Export engine designed to create documents with associated metadata and place them into a managed folder (DMS)');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (972,3,'Release to DMS End','Date and time when the KOFAX Export Module completed processing the scanned and imported documents through the Export engine designed to create documents with associated metadata and place them into a managed folder (DMS)');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (974,2,'Batch Priority�','The priority of the batch.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (975,2,'Batch Deleted','Flag that indicates that the batch was deleted during the current processing session. ');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (976,2,'Pages Scanned','Flag that indicates the number of pages scanned changed during the current processing session.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (977,2,'Documents Created','Flag that indicates that documents were created during the current processing session.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (978,2,'Documents Deleted','Flag that indicates that documents were replaced during the current processing session');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (979,2,'Pages Replaced Flag','Flag that indicates pages replaced during the current processing session.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (980,2,'Pages Deleted Flag','Flag indicating that pages were deleted during at any time during processing. ');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (992,3,'Batch Complete Dt','The date/timestamp that KOFAX considers the batch completed successfully (i.e. Released to DMS).');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (993,2,'Current Batch Module ID','Identifier for the current record in Master Batch Module Staging.  It is NA if the batch is completed in KOFAX.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (994,2,'QC Required Gateway Flag','QC Required Gateway Flag');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (547,2,'Cancel Reason','The reason that the instance is cancelled.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (722,2,'Cancel Method','This is the method as per which the instance was cancelled');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (178,2,'Current Step','The Current Activity Step identifes where the instance is in the process.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (995,2,'Batch GUID','Unique indicator for the Batch in Kofax 10.');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (981,2,'Scan Batch','Scan Batch Activity Step Flag');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (982,2,'QC Batch','QC Batch Activity Step Flag');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (983,2,'Class Doc and Extract Metadata (KTM Server Module)','Classify Document and Extract Metadata (KTM Server Module) Activity Step Flag');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (984,2,'Batch Recognition (Recognition Server)','Batch Recognition (Recognition Server) Activity Step Flag');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (985,2,'Review Batch (KTM Validation Module)','Review Batch (KTM Validation Module) Activity Step Flag');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (986,2,'Create PDFs','Create PDFs Activity Step Flag');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (987,2,'Populate Reports Data','Populate Reports Data Activity Step Flag');
Insert into  BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (988,2,'Release to DMS (Export Module)','Release to DMS (Export Module) Activity Step Flag');