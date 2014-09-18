insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (131,2,'Batch Name','The Batch Name is a unique identifier assigned to each batch.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (132,2,'Batch Source','The Batch Source identifies the channel from which the envelope was originally received. Values for NY are Mail and Fax.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (133,2,'Batch Stage','The Batch Stage identifies where in the process the batch currently resides.  The batch stages for New York are: Scan, QC, and Validation. The stages are set when the modules are completed.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (134,2,'Batch Type','The Batch Type identifies the group of envelopes that are scanned together.  The business defines the various batch types based on the types of envelopes the project receives. In NY, the batch types are Renewals, Supporting, Undeliverable Recertifications, Rescan, Manual Notice (outbound), Other, Research Faxes (printed from separate fax machine).');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (135,1,'BKSE ID','This is the unique identifier of the batch instance in the staging table.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (136,2,'BPMS Processed','This is set when the updates are processed in the bpms.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (137,2,'Batch Created By','The Batch Created By identifies the name of the performer who initiated the batch scanning process.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (138,3,'Batch Creation Date','The Batch Create Date/Time is the date that the batch is initially scanned. This date may or not be the same day as the envelope receipt date.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (139,1,'Batch Doc Count','The Batch Document Count displays total number of documents scanned. This does not represent the number of documents in a single envelope.  The value is set based on the number of document separator sheets read through KOFAX.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (140,1,'Batch Env Count','The Batch Envelope Count represents the number of envelopes in each individual batch.  This number is entered manually at the beginning of the scanning process.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (141,3,'KOFAX Creation Date','The KOFAX Creation Date is the date that the scanned batch was successfully created in KOFAX.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (142,3,'Batch Receipt Date','The Batch Receipt Date is the business translation of the creation date for information received outside of business hours.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (143,3,'Stage Done Date','This is the date that the stage was completed.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (144,3,'Stage Last Update Date','This is the date that the most recent updates were performed on the instance.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (145,3,'Delete Batch Date','The Delete Batch Date/Time is set when the batch is deleted or discarded.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (146,2,'Batch ID','The Batch ID is set by KOFAX and is a unique identifier for each batch.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (147,2,'Batch Class','The Batch Class is the name of the server submitting the batch for scanning.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (148,2,'Batch Curr Step','The Current Activity Step identies where the instances is in the process.  If the Batch has completed scanning with no errors, and there is no QC required or QC is complete, and validation is NOT complete, then the current step is Validation. If the Batch has completed scanning with no errors, and QC is required and QC is not complete, then the current step is QC. If the batch has been created but the scan is not complete, then the current step is Scan. If the batch has completed validation, then the current step is End.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (149,2,'Batch Jeopardy Status','The Batch Scan Jeopardy Status indicates if an in-process batch is at risk of becoming untimely. Set the flag to "Y" when the batch creation date is greater than or equal to 24 hours from the current date and the batch has not completed the process. Set the flag to "N" when the batch creation date is less than 24 hours from the current date and the batch has not completed the process. Set the flag to NA when the instance is complete.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (150,2,'Batch Scan Timeliness Status','The Batch Scanning Timeliness Status indicates whether a batch is processed within the business defined thresholds.  Set the status to "Processed Timely" if the batch complete date (date validation is complete or date the batch is cancelled) is less than 24 hours from batch creation date. Set the status to "Processed Untimely" when the batch complete date is greater than or equal to 24 hours from the batch creation date. Set the status to "Not Processed" when the batch complete date is null OR the batch was cancelled.  Delete Batch Flag	The Delete Batch Flag is set when a batch is manually or systematically deleted in KOFAX.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (151,2,'Batch Delete By','The Delete Batch Completed By is the performer who deleted or discarded the batch.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (152,2,'KOFAX QC Reason','The KOFAX QC Reason explains what occurred durring the scanning process that requires the envelope and its contents to be reviewed by a worker.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (153,2,'Stage Cmplt By','The Stage Completed By is the name of performer who completed the Scanning, QC, or Validation module in KOFAX.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (154,1,'Stage Completion Age','The Stage Age is the number of days, hours, and minutes between the creation date and the stage done date.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (155,1,'Batch Page Count','The Batch Page Count is the total number of pages that are scanned in a single batch.');

insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (156,1,'BKRE ID','This is the unique identifier of the envelope instance in the staging table.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (157,2,'Created By','The Created By is the name of the performer who created the envelope.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (158,3,'Creation Date','The Creation Date is the date that the envelope is created in MAXe.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (159,1,'KOFAX Doc Coun','The  Document Count is the number of generic DCNs saved in the KOFAX Directory.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (160,1,'Envelope ID','The Envelope ID is a unique number assigned to each envelope for tracking.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (161,1,'DMS Doc Count','The DMS Document count is the number of DCNs that DMS created for the envelope.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (162,2,'DMS Status','The DMS Status indicates whether the ECN was successfully saved and processed in DMS.  If there is no error returned when DMS collects the ECN from the KOFAX directory, then the status is set to "Pass." If there is an error when DMS attempts to get the Envelope from the KOFAX directory, then the status is set to "Fail." This field can be updated if a subsequent attempt passed.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (163,3,'DMS Status Date','The DMS Status date indicates the date and time that DMS attempted to collect the ECN from the KOFAX Directory.  This date can be updated at each attempt.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (164,1,'Inbound Info Cycle Age','The Inbound Info Cycle Age is the days, hours, minutes, and seconds from the Batch Create Date/Time to  one of the following:  - Envelope Discarded Date/Time  - Batch Cancel Date/Time  - Proximal Match Complete Date/Time when no work is required,  - Create Work Complete Date/Time.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (165,2,'KOFAX Status','The KOFAX Directory status indicates whether the ECN and XML were saved in the KOFAX Directory.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (166,3,'KOFAX Status Date','The KOFAX Directory status date is the date that the envelope was passed to the KOFAX Directory.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (167,1,'MAXE Doc Count','The MAXe Document count is the number of  DCNs created in MAXe after DMS releases the envelope.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (168,2,'MAXE Status','The MAXe Status indicates whether the envelope was successfully passed from DMS to MAXe.  If there is an error in DMS when DMS attempts to release the information to MAXe, then the status is "Fail." If there is no error, then the status is "Pass."');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (169,3,'MAXE Status Date','The MAXe Status date indicates the date that DMS attempts to release the ECN to MAXe.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (170,2,'Current Task Type','The Current Task Type is the name of the task, if one exists, associated to the envelope in MAXe.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (171,2,'Work Required Flag','The Work Required Flag indicates whether a work task should be generated based on the envelope contents and current case information.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (172,1,'Work Task ID','The Task ID is the ID of the task created AFTER all proximal match tasks are completed. This TASK ID does not represent the HSDE-QC, Link Document Set, or Document Problem Resolution task.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (173,2,'Work Type Created','The Work Type created defines the data entry or research work that is created once Proximal Match is completed.  If no work is created, then the value will be null. Valid worktypes are Renewal Application, Missing Information, Research or Other.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (174,3,'When Attempt Date','The Envelope Release Attempt Date/Time is set when KOFAX attempts to release envelope and document data into the Document Management System (DMS).');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (175,1,'XML Response Code','The KOFAX Release Status describes the results of the Document Management System (DMS) creating the Envelope and Document IDs and electonic data, and then releasing the data to MAXe.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (176,2,'Case Number','The Case Number is the unique Case in MAXe to which an envelope is linked, or the case to which the clients belong.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (177,2,'Discard Envelope Flag','The Discard Envelope Flag is set when an envelope cannot be released and must be rescanned. This can happen in KOFAX or in DMS.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (178,2,'Current Step','The Current Activity Step identifes where the instance is in the process.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (179,2,'Envelope Jeopardy Status','The Release Jeopardy Status indicates if an envelope is at risk of becoming untimely.  The Status is set to "Y" if the ECN does not exist in MAXe, and the DMS Status is Pass, and the DMS status date timestamp is equal to or greater than 45 minutes. The Status is set to "N" if the ECN does not exist in MAXe, and the DMS Status is Pass, and the DMS status date timestamp is less than 45 minutes. The status is set to "NA" if the ECN exists in MAXe or if the instance is complete.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (180,3,'Envelope Receipt Date','The Envelope Receipt Date is the business date that the envelope is received.  If an envelope is received outside of normal business hours, then the date is pushed forward to the next available business day.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (181,1,'Envelope Release Cycle Age','The Envelope Release Cycle age is the days, hours, minutes, and seconds from the Envelope Release Attempt Date/Time to one of the following:  - Envelope Discarded Date/Time  - Proximal Match Complete Date/Time when no work is required  - Create Work Complete Date/Time.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (182,2,'Envelope Research Reason','The Envelope Research Reason is a value set (manually or automatically) that explains to users why an envelope was sent to research.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (183,2,'Envelope Release Timeliness Status','The Envelope Release Timeliness Status indicates if an envelope was RELEASED timely, untimely, or has not been released. The Status is set to "Processed Untimely" if the MAXE Status is Pass, and the difference from the KOFAX Status date and the MAXE status date timestamp is equal to or greater than 60 minutes. The Status is set to "Processed Timely" if the MAXE Status is passed, and the difference from the KOFAX status date and the MAXE status date timestamp is less than 60 minutes. The Status is set to "Not Processed" when the MAXE Status is fail or null.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (184,2,'Envelope Timeliness Status','The Envelope Timeliness Status indicates if an envelope was processed timely, untimely, or has not been completed. Set the status to "Processed Timely" if when the proximal match is completed in 3 or less business days. Set the status to "Processed Untimely" when the proximal match is completed in more than 3 business days. Set the status to "Not Processed" when the proximal match is not completed.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (185,1,'MAXE ECN','The MAXe ECN is the ECN saved in MAXe. This is used to reconcile envelopes from KOFAX to MAXE.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (186,1,'Proximal Match Age','The Proximal Match Age is the days, hours, minutes, and seconds from the MAXE_STATUS_DATE to the Proximal Match Complete Date/Time when the MAXE_STATUS = Pass.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (187,2,'Proximal Match Completed By','The Proximal Match Completed By is the name of the performer who processed and linked all documents within an envelope.  Use the name of the worker who completed the Link Document Set tasks when no Document Problem Resolution task was created after. Use the name of the worker who completed the Document Problem Resolution task if one was created.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (188,3,'Proximal Match Complete Date','The Proximal Match Complete Date/Time represents the date that the envelope and its corresponding documents are all processed (linked, or discarded for a valid reason).');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (189,1,'Release Age','The Release Age is the days, hours, minutes, and seconds from the KOFAX Status Date when KOFAX Status = Pass to one of the following:  - Envelope Discard Date  - MAXe Status Date when MAXe Status = Pass');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (190,3,'Work Create Date','The Work Created Date/Time is the date that the application, fair hearing, case maintenance, or missing information work is created.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (191,2,'Env Discard By','The Envelope Discarded By is the name of the performer who removed the envelope for rescanning.  If KOFAX deletes the envelope because it cannot be saved to the directory, then the performer is KOFAX.  If DMS deletes the envelope because it cannot be pulled from the directory or saved to MAXe, then the performer is DMS.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (192,3,'Env Discard Date','The Envelope Discarded Date/Time is set when the envelope is removed from DMS and KOFAX because it cannot be released to MAXe.');

insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (193,1,'Document ID','The Document ID is the unique identifier to track individual documents in an envelope. This Document ID is created in DMS and saved in MAXe.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (194,2,'Document Type','The Document Type is the high level description of a document in an envelope.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (195,2,'Document Subtype','The Document Sub-Type is the description of the information inside an envelope.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (196,3,'Document Create Date','The Document Create Date is the date that the document ID is assigned by DMS.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (197,2,'Document Form Type','The Document Form type is the description of the form returned by the client.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (198,2,'Envelope ID','The Envelope ID is a unique number assigned to each envelope for tracking.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (199,1,'KOFAX Document ID','The KOFAX Document ID is assigned by KOFAX and sent to DMS, but is not passed to MAXe.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (200,1,'Document Page Count','The document page count is the count of individual pages in a document.');
