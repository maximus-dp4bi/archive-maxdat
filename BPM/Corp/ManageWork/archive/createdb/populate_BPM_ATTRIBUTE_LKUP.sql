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
  where ba.BEM_ID = 1
  order by bal.BAL_ID asc;
  */
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1,1,'Age in Business Days','Number of days from the Create Date to the Complete Date, or to the Current Date for instances that are not yet complete, excluding weekends and project holidays.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(2,1,'Age in Calendar Days','Number of days from the Create Date to the Complete Date, or to the current date for instances that are not yet complete.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(3,3,'Cancel Work Date','Indicates the date the ETL discovered that the task was no longer available to be worked.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(4,2,'Cancel Work Flag','Indicates if the task is no longer available to be worked (deleted or disregarded).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(5,3,'Complete Date','The date the instances is first set to a completed status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(6,2,'Complete Flag','Indicates if the instance is determined to be in a completed state');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(7,3,'Create Date','This is the date that the instance was created in the MAXe system');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(8,2,'Created By Name','Name of the staff member that created the instance in MAXe. This name should be formatted as:Last, First MI or when no middle initial exists then Last, First');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(9,2,'Escalated Flag','Indicates if the instance is currently escalated.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(10,2,'Escalated To Name','Name of the staff member in MAXe to whom the instance has been escalated. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(11,2,'Forwarded By Name','Name of the staff member in MAXe who forwarded the instance. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(12,2,'Forwarded Flag','Indicates if the task was forwarded to the current location.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(13,2,'Group Name','Name of the MAXe Group to which a task is assigned.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(14,2,'Group Parent Name','Name of the MAXe Group identified as the parent group of the MAXe Group to which a task is assigned.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(15,2,'Group Supervisor Name','Name of the staff member in MAXe identified as the supervisor of the group. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(16,2,'Jeopardy Flag','Indicates if the application is in jeopardy based on the SLA Days Type and SLA Jeopardy Days. Default value is "N"');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(17,2,'Last Update By Name','Name of the staff member that last updated the instance in MAXe. This name should be formatted as: Last, First MI or when no middle initial exists then Last, First');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(18,3,'Last Update Date','Date the instance was last updated in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(19,2,'Owner Name','Name of the staff member that is considered to be the owner of the instance.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(20,1,'SLA Days','Age at which time the measured cycle is determined to be untimely. If no SLA applies then this value is null');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(21,2,'SLA Days Type','Indicates if the SLA Days is based on Business Days or Calendar Days. If no SLA applies then this value is null. ');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(22,1,'SLA Jeopardy Days','Age at which time the measured cycle is determined to be in Jeopardy. If no SLA applies then this value is null. This value should be easily configured and will initially be set to 2 for all instances.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(23,1,'SLA Target Days','Age at which time the measured cycle is determined to be untimely based on target goals set by the business. If no target has been defined then this value is null.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(24,2,'Source Reference ID','Unique identifier for the item to which this instance is associated (Application ID, Document ID, etc). This is useful for looking up more details in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(25,2,'Source Reference Type','Indicates the type of Source Reference ID that is being provided.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(26,1,'Status Age in Business Days','Number of days from the Status Date to the current date excluding weekends and project holidays for instances that are not yet complete. Once an instance is complete, this value should be 0.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(27,1,'Status Age in Calendar Days','Number of days from the Status Date to the current date for instances that are not yet complete. Once an instance is complete, this value should be 0.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(28,3,'Status Date','Date the instance Status was set in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(29,1,'Task ID','Unique identifier for the task in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(30,2,'Task Status','Current status of the task in MAXe indicating if the task is claimed or unclaimed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(31,2,'Task Type','Indicates the type of work.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(32,2,'Team Name','Name of the MAXe Group identified as the team');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(33,2,'Team Parent Name','Name of the MAXe Group identified as the parent group of the MAXe Group identified');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(34,2,'Team Supervisor Name','Name of the staff member in MAXe identified as the supervisor of the team');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(35,2,'Timeliness Status','Indicates if the instance was processed timely or untimely based on the SLA Days Type, SLA Days, and age or cycle days. Default value is Not Required');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(36,2,'Unit of Work','Indicates the Production Planning Unit of Work.');

  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(593,1,'Client_ID','Unique identifier associated to the client level task in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(479,1,'Case_ID','Unique identifier associated to the case level task in MAXe');

  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(722,2,'Cancel Method','This is the method as per which the instance was cancelled');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(547,2,'Cancel Reason','The reason that the instance is cancelled');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(576,2,'Cancel By','The name of the system or performer who cancelled the instance');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(793,1,'TASK_PRIORITY','Indicates the priority of the task instance in MAXe');
  
  -- From MAXDAT-1055 - Handle complete date < create date in queue processing. 
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1608,3,'Source Complete Date','Original complete date value from source.');

end;
/
