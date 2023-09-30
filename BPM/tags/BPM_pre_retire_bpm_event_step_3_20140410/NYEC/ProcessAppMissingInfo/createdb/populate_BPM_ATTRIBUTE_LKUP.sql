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
  where ba.BEM_ID = 4
  order by bal.BAL_ID asc;
  */
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(40,1,'Application ID','Unique identifier for the application in the source system.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(201,1,'MI Item ID','The MI Item ID is the unique ID associated to the specific piece of information that is being requested.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(202,2,'MI Item Level','The MI Item Level indicates whether the item is an application-level item or client-level item that is being requested.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(203,2,'MI Item Type','The MI Item Type indicates whether the item is missing data (information that can be satisfied over the phone, or without proof), or missing documentation (information that must be submitted through mail or fax).');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(204,3,'MI Item Create Date','The MI Item Create date is the date that the MI Item was identified and saved in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(205,2,'MI Item Requested By','The MI Item Requested By is the performer who saved the MI Item record to the application. This could be a staff member, a MAXe batch job, or HEART.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(206,2,'MI Letter Required Status','The MI Letter Required status indicates whether the MI item requires a letter to be sent to a client.  See Appendix B "MI Letter","KPR Rules for when to set this status to Required."');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(207,1,'MI Letter ID','The MI Letter ID is the unique identifier of the letter mailed to the case HOH requesting the missing information.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(208,2,'RFE Status','This is the status of the client who is associated to the missing information item.  It should be in synch with the MI Item status.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(209,3,'RFE Status Date','RFE status date.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(210,2,'MI Item Status','The MI Item status indicates whether the missing information has been returned and is valid, has not been returned, or was removed from the application.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(211,3,'MI Item Status Date','The MI Item Status Date is the date that the most recent status was set. The initial status date is the date that the MI Item was created.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(212,2,'MI Item Status Performer','This is the name of the worker or system performer who updated the MI to be satisfied or removed.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(214,3,'MI Letter Cycle Start Date','This is the date that the missing information is identified and validated, and the letter should be requested.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(215,3,'MI Letter Cycle End Date','This is the date the the missing information letter is sent.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(216,2,'MI Item Create Task Type','This is the name of the task group that was in process when the MI Item was added.  See Appendix B MI Letter KPR Rules for how to set the values.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(217,2,'Refer to District Checkbox','This attribute is set to "Yes" when the Refer to District Checkbox field is checked in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(218,3,'Refer to District Checkbox Date','This is the date that the Refer to District Checkbox field is checked in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(219,2,'Undeliverable Checkbox','This attribute is set to "Yes" when the Undeliverable Checkbox field is checked in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(220,3,'Undeliverable Checkbox Date','This is the date that the Undeliverable Checkbox field is checked in MAXe.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(221,3,'MI Validated Date','This is the date that the MI is considered validated by workers as ready to be sent in a letter.');
  
  -- r2
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(346,3,'HEART MI Due Date','This is the date that is 15 calendar days from the date the MI record was created');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(347,3,'MAXe MI Due Date','This is the date that is 15 calendar days from the date the MI record was created and is synced with the HEART MI Due Date');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(348,2,'MI Type','The MI Type is the name of each MI on the application.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(349,2,'MI Letter Name','The MI Letter Name is the unique name of the MI letter sent to the client.');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(350,2,'MI Satisfied Reason','The MI Satisfied Reason is selected by the RA from the ''Satisfied Reason'' drop down on the MI sub tab to satisfy missing information in Maxe');

  commit;

end;
/