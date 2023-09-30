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
  where ba.BEM_ID = 9
  order by bal.BAL_ID asc;
  */
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(49,2,'Channel','This is the channel through which the instance was received by Maximus');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(65,3,'Instance Complete Date','Date the instance reached a terminal point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,2,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(131,2,'Batch Name','The Batch Name is a unique identifier assigned to each batch.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(172,1,'Work Task ID','The Task ID is the ID of the task created AFTER all proximal match tasks are completed. This TASK ID does not represent the HSDE-QC, Link Document Set, or Document Problem Resolution task.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(194,2,'Document Type','The Document Type is the high level description of a document in an envelope.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(197,2,'Document Form Type','The Document Form type is the description of the form returned by the client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(200,1,'Document Page Count','The document page count is the count of individual pages in a document.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(413,1,'DCN','The DCN is the unique identifier to track individual documents in an envelope. The DCN is created in DMS and saved in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(414,3,'DCN Create Date','The date/time that the DCN is assigned by DMS.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(417,2,'ECN','The ECN is a unique number assigned to each envelope for tracking.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(418,1,'Original DCN','The Original DCN is the DCN in DMS that was assigned to the original document released to DMS that required rescan.  When Rescanned is set to Y, populate the original DCN for the document.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(419,2,'Rescanned','The rescanned attribute indicates whether the document is an original or has been rescanned. If the image received from KOFAX is a re-scan, set this flag to Y.  If the image is not a rescan, set to N.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(421,2,'Document Status','This is the document status assigned by the system during the imaging process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(422,3,'Document Status Date','This is the status date/time for the current Document Status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(423,1,'DCN Count','The DCN count is the number of DCNs created in the source system after DMS releases the document (should be 1 since each instance is a document).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(424,2,'DCN Timeliness Status','The DCN Timeliness Status indicates whether an document is completed in the process within the business defined thresholds.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(426,2,'Autolink Failure Reason','This attribute is set when the attempted autolink fails.  The reason that the autolink activity failed. - MAXeb only provides a single reason; = "invalid bar code"');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(427,3,'Create IA Task Start','The time/date stamp when the Create IA Task Activity starts. - This should be the date/time when the initial IA Manual Link Task ID is created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(428,3,'Create IA Task End','The time/date stamp when the Create Manual Task Activity is complete.  This should be the date/time when the IA Manual Link Task ID task is claimed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(429,1,'IA Manual Classify Task ID','The IA Manual Classify Task ID is the unique identifier of the IA classification task, if one exists, associated to the document.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(430,1,'IA Manual Link Task ID','The IA Manual Link Task ID is the unique identifier of the IA linking task, if one exists, associated to the document.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(431,3,'Manual Link Image Start','The time/date stamp when the Manual Link Image Activity starts.  This should be the date/time when the IA MANUAL LINK TASK ID is claimed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(432,3,'Manual Link Image End','The time/date stamp when the Manual Link Image Activity is completed.  This should be the date/time when the IA MANUAL LINK TASK ID is closed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(433,3,'Manual Classify Form Doc Type Start','The time/date stamp when the Manual Link Image Activity starts.  This should be the date/time when the IA MANUAL CLASSIFY TASK ID is claimed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(434,3,'Manual Classify Form Doc Type End','The time/date stamp when the Manual Link Image Activity is completed.  This should be the date/time when the IA MANUAL CLASSIFY TASK ID is closed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(435,3,'Create and Route Work Start','The time/date stamp when the Create and Route Work Activity starts.  When the document was successfully autolinked, set to date/time autolinked.  When the document was not autolinked, set to the greater of the 2 following dates: MANUAL CLASSIFY FORM DOC TYPE END MANUAL LINK IMAGE END');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(436,3,'Create and Route Work End','The time/date stamp when the Create and Route Work Activity is complete.  Set to date/time that the expected work has been identified and recorded.  This will be the create date for for the WORK TASK ID');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(437,2,'Work Task Type','The Work Type created defines the data entry or research work that is created once IA is completed.  If no work is created, then the value will be null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(438,3,'Cancel Document Processing End','The Cancel Document Processing Cancel Date/Time is set when the instance is confirmed cancelled, logically deleted, or otherwise discarded.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(439,2,'Link Method','The method in which the document was linked to the case, either by successful auto-linking or by manual linking.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(440,2,'Link Via','When the image is linked either manually or via successful autolinking, this attribute indicates the type of linking performed, and is based on the document and form type. Set to "Case" if the image is linked at the case level, set to "Client" if the image is linked at the client level, set to "Indirect" if the image is linked to an associated transaction for the case / client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(441,1,'Link Number','This attribute contains, the case, client or transaction number that the image is linked to depending on the value set in Link Via.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(442,2,'Document Barcode Flag','When the image is received from KOFAX, set this flag to Y if the document is barcoded.  If the document is not barcoded, set to N.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(443,2,'Create IA Task Flag','This attribute indicates that the activity step has been completed.  Set to Y when Create IA Task End not null');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(444,2,'ManualClassFormDocFlag','This attribute identifies documents that have a manual image assembly task created but where the form and document type are already known.  When the image assembly task is created and both the form and doc type are known, set to Y.  When the image assembly task is created and the form and/or doc type are not know, set to N.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(445,2,'Manual Link Image Flag','This flag is set when the activity is complete.  Set to Y when ased_link_images_manual is not null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(446,2,'CreateRouteWorkFlag','This flag is set when the activity is complete.  Set to Y when ased_create_and_route_work is not null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(447,2,'Autolink Outcome Flag','This attribute is set when the system attempts to perform an autolink for an image with a valid barcode.  If the autolink is successfully completed (the image is linked by the system) set to "Autolink Successful".  If the autolink fails, set to "Autolink Failed".');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(448,2,'Rescan Required Flag','The rescan indicator indicates whether the document needs to be rescanned.  If a rescan has been requested, set to "Y".  If the document has a manual image assembly task and is linked, set to "N".');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(449,2,'DocClassPresent Flag','This attribute identifies documents that have a manual image assembly task created but where the form and document type are already known.  When the image assembly task is created and both the form and doc type are known, set to Y.  When the image assembly task is created and the form and/or doc type are not know, set to N.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(450,2,'Work Identified Flag','The Work Required Flag indicates whether a work task should be generated based on the form and document type and the current case information.  This will be determined by rules defined by the project and will be configured in the Work Created Rules Table based on the expected tasks created for certain doc/form types.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(547,2,'Cancel Reason','The reason that the JOB ID instance is cancelled.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(576,2,'Cancel By','The name of the system or performer who cancelled the letter.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(722,2,'Cancel Method','This is the method as per which the instance was cancelled');

  commit;

end;
/