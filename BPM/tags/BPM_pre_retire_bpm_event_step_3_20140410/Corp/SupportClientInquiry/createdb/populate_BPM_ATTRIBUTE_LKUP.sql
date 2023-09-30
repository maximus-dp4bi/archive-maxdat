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
  where ba.BEM_ID = 13
  order by bal.BAL_ID asc;
  */
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(5,3,'Complete Date','The date the instances is first set to a completed status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(7,3,'Create Date','This is the date that the instance was created in the MAXe system');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(8,2,'Created By Name','Name of the staff member that created the instance in MAXe. This name should be formatted as:Last, First MI or when no middle initial exists then Last, First');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(17,2,'Last Update By Name','Name of the staff member that last updated the instance in MAXe. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(18,3,'Last Update Date','Date the instance was last updated in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(47,3,'Cancel Date','Indicates the date the ETL discovered that the instance was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(66,2,'Instance Status','Indicates if the instances is active in the process or reached a terminal end point in the process.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(143,3,'Stage Done Date','This is the date that the stage was completed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(547,2,'Cancel Reason','The reason that the JOB ID instance is cancelled.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(559,2,'Language','The language that the letter was requested in.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(576,2,'Cancel By','The name of the system or performer who cancelled the letter.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(650,1,'CECI ID','ETL Table primary key');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(651,1,'Contact Record ID','The unique identifier defined by the source system assigned to call / webchat record.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(652,2,'Supp Contact Type Cd','Non-monitoring supplementary attribute: Contact Type Code');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(653,2,'Contact Type','Identifies how the contact was initiated (e.g., inbound, outbound or web chat). Identifies how the contact was initiated (e.g., inbound, outbound or web chat).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(654,1,'Parent Contact Record ID','The contact record ID of a distinct but related contact record used to link the records together (typcially results from call transfers).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(655,2,'Tracking Number','Reference number that an individual can provide the agent upon contact to expedite lookup.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(656,1,'Supp Worker ID','Non-monitoring supplementary attribute: Worker ID');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(657,2,'Supp Worker Name','Non-monitoring supplementary attribute: Woker Name');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(658,2,'Supp Created By','Non-monitoring supplementary attribute: Created By');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(662,3,'Contact Start Time','Date and time that the individual and agent/staff first made contact');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(663,3,'Contact End Time','Date and time that the individual and agent/staff concluded the call/web chat ending contact.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(664,2,'Supp Contact Group Cd','Non-monitoring supplementary attribute: Contact Group Code');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(665,2,'Contact Group','Categorizes individuals into groups  (e.g., participant, provider, community based organization,etc)');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(666,2,'Supp Language Cd','Non-monitoring supplementary attribute: Lanuage Code');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(668,2,'Translation Required','Indicates if a translator was needed for the contact.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(669,2,'External Telephony Reference','External reference field for data passed through IVR/ACD.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(670,1,'Supp Latest Note ID','Non-monitoring supplementary attribute: Latest Note ID');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(671,2,'Note Category','The category of the note created for the contact, if any.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(672,2,'Note Type','The note type created for the contact, if any.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(673,2,'Note Source','The source of the note record created for the contact (the module or function that created the note).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(674,2,'Note Present','Indentifies whether an associated Call Record Note exists');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(675,2,'Contact Record Field 1','Call Center Module provides project-configurable fields for the Call Record often used to capture non-standard information from the caller per project requirements).   Open Request for Project configurations.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(676,2,'Contact Record Field 2','Call Center Module provides project-configurable fields for the Call Record often used to capture non-standard information from the caller per project requirements).   Open Request for Project configurations.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(677,2,'Contact Record Field 3','Call Center Module provides project-configurable fields for the Call Record often used to capture non-standard information from the caller per project requirements).   Open Request for Project configurations.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(678,2,'Contact Record Field 4','Call Center Module provides project-configurable fields for the Call Record often used to capture non-standard information from the caller per project requirements).   Open Request for Project configurations.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(679,2,'Contact Record Field 5','Call Center Module provides project-configurable fields for the Call Record often used to capture non-standard information from the caller per project requirements).   Open Request for Project configurations.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(685,2,'Supp Updated By','Non-monitoring supplementary attribute: Updated By');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(688,3,'ASSD Handle Contact','Date and time the individual and agent/staff first made contact.set to contact_start_dt.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(689,3,'ASED Handle Contact','The date/time that handle call/webchat activity step ended. Set to contact_end_dt.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(690,2,'ASPB Handle Contact','The name of the person/system that completed the Handle Call/Web Chat activity step.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(691,3,'ASSD Create Route Work','The date/time that the Create and Route Work activity step began.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(692,3,'ASED Create Route Work','The date/time that the Create and Route Work activity step ended.  Set to the task ID create date.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(693,2,'ASF Handle Contact','This step is complete when the staff member completes the call/webchat and marks the contact record complete.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(694,2,'ASF Create Route Work','This step is complete when the appropriate work has been created and routed by the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(695,2,'ASF Cancel Contact','A skipped activity step; no rule');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(696,2,'GWF Work Identified','Set when ased_handle_contact is NOT null and gwf_work_identified is null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(697,3,'Cancel_Date','Indicates the date the ETL discovered that the contact record was cancelled or otherwise deleted.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(698,3,'Stage Update Date','Date ETL instance was last updated');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(699,3,'Stage Extract Date','Date ETL instance was extracted/inserted');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(722,2,'Cancel Method','This is the method as per which the instance was cancelled');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(800,2,'Cancel By Unit','The business unit that the staff member who created the contact is assigned to.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(801,2,'Cancel By Team','The team that the staff member who created the contact is assigned to.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(802,2,'Cancel By Role','The default role that the staff member who created the contact is assigned to.');

  commit;

end;
/
