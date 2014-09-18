insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (201,1,'MI Item ID','The MI Item ID is the unique ID associated to the specific piece of information that is being requested.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (202,2,'MI Item Level','The MI Item Level indicates whether the item is an application-level item or client-level item that is being requested.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (203,2,'MI Item Type','The MI Item Type indicates whether the item is missing data (information that can be satisfied over the phone, or without proof), or missing documentation (information that must be submitted through mail or fax).');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (204,3,'MI Item Create Date','The MI Item Create date is the date that the MI Item was identified and saved in MAXe.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (205,2,'MI Item Requested By','The MI Item Requested By is the performer who saved the MI Item record to the application. This could be a staff member, a MAXe batch job, or HEART.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (206,2,'MI Letter Required Status','The MI Letter Required status indicates whether the MI item requires a letter to be sent to a client.  See Appendix B "MI Letter","KPR Rules for when to set this status to Required."');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (207,1,'MI Letter ID','The MI Letter ID is the unique identifier of the letter mailed to the case HOH requesting the missing information.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (208,2,'RFE Status','This is the status of the client who is associated to the missing information item.  It should be in synch with the MI Item status.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (209,3,'RFE Status Date','RFE status date.');	
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (210,2,'MI Item Status','The MI Item status indicates whether the missing information has been returned and is valid, has not been returned, or was removed from the application.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (211,3,'MI Item Status Date','The MI Item Status Date is the date that the most recent status was set. The initial status date is the date that the MI Item was created.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (212,2,'MI Item Status Performer','This is the name of the worker or system performer who updated the MI to be satisfied or removed.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (213,2,'MI Item Satisfied Channel','If the MI item is satisfied, and the MI Satisfied date is the same date as a Missing Information Data Entry task is completed, then the Channel is Mail/Fax. If the MI item is satisfied, and the status date is the same date as the Mi Reprocess Result task create date, then the channel is Reprocess Report.  If the MI satisfied date is not related to a task, then set to phone.  If the MI item is not satisfied, the channel is null.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (214,3,'MI Letter Cycle Start Date','This is the date that the missing information is identified and validated, and the letter should be requested.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (215,3,'MI Letter Cycle End Date','This is the date the the missing information letter is sent.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (216,2,'MI Item Create Task Type','This is the name of the task group that was in process when the MI Item was added.  See Appendix B MI Letter KPR Rules for how to set the values.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (217,2,'Refer to District Checkbox','This attribute is set to "Yes" when the Refer to District Checkbox field is checked in MAXe.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (218,3,'Refer to District Checkbox Date','This is the date that the Refer to District Checkbox field is checked in MAXe.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (219,2,'Undeliverable Checkbox','This attribute is set to "Yes" when the Undeliverable Checkbox field is checked in MAXe.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (220,3,'Undeliverable Checkbox Date','This is the date that the Undeliverable Checkbox field is checked in MAXe.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) 
values (221,3,'MI Validated Date','This is the date that the MI is considered validated by workers as ready to be sent in a letter.');