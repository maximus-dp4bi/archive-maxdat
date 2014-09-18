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
  where ba.BEM_ID =22
  order by bal.BAL_ID asc;
  */
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1540,2,'Incident Forwarding Target',' Incident Forwarding Target -State');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1539,2,'Incident Forwarding Timeliness Status','Incident Forwarding Timeliness Status -State');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1538,2,'Return to State Flag','Return to the State?');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1537,2,'FollowUp Req Flag','Follow-up Required?');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1536,2,'Resolved SUP Flag','Resolved? (SUP)');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1535,2,'Resolved EES CSS Flag','Resolved? (EES/CSS, Complex Gateway)');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1534,2,'Withdraw Incident Flag','Withdraw Incident');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1533,2,'Perform FollowUp Flag','Perform Follow-up Actions');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1532,2,'Resolve Incident DOH Flag','Resolve Incident');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1531,2,'Resolve Incident SUP Flag','Attempt to Resolve Incident (Supervisor)');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1530,2,'Resolve Incident EES CSS Flag','Attempt to Resolve Incident (EE Specialist or CSS)');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1516,2,'Forwarded ','Describes whether the incident was forwarded for processing.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1499,2,'Incident Description','Free text field to document Incident description');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1486,3,'Perform Follow-up Actions Start','The time/date stamp when the activity step starts.  
-This should be when MAXIMUS opens the Incident in the status "Refer to Maximus"');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1485,3,'Perform Follow-up Actions End','The time/date stamp when the activity step ends.
-This should be when the status of the Incident is changed to "Closed"  or "Refer to State"');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1484,3,'Withdraw Incident Start','The time/date stamp when the activity step starts.  
-This should be when the status of the Incident is changed to "*Withdrawn*"');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1483,3,'Withdraw Incident End','The time/date stamp when the activity step ends.  
-This should be when the status of the Incident is changed to "*Withdrawn*"');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1482,3,'Resolve Incident Start','The time/date stamp when the activity step starts.
-This should be when the state receives the Incident.  ');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1481,3,'Resolve Incident End','The time/date stamp when the activity step ends.  
-This should be when the status of the Incident is changed to "Closed" or "Refer to Maximus."');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1480,3,'Attempt to Resolve Incident (Supervisor) Start','The time/date stamp when the activity step starts.  
-This should be when the supervisor opens the Incident.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1479,3,'Attempt to Resolve Incident (Supervisor) End','The time/date stamp when the activity step ends.  
-This should be when the status of the Incident is changed to "Closed" or "Refer to DOH."');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1478,3,'Resolve Incident Start Dt','The time/date stamp when the activity step starts.  
-This should be when the specialist opens the Incident ');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1477,3,'Resolve Incident End Dt','The time/date stamp when the activity step ends. 
-This should be when the status of the Incident is changed to "Closed" or "Refer to Supervisor" or "Refer to DOH."');


  commit;

end;
/