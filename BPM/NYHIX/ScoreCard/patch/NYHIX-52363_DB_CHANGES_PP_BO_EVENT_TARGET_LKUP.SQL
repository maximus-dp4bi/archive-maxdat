update maxdat.PP_BO_EVENT_TARGET_LKUP
set WORKSUBACTIVITY_FLAG='N',EE_ADHERENCE='N'
where event_id=1174
and end_date IS NULL;

commit;

update maxdat.PP_BO_EVENT_TARGET_LKUP
set SCORECARD_GROUP='Evidence Packet Correction Task - ARU Task',
end_date='31-Dec-2019'
where event_id=1205
and end_date='20-DEC-2019';

commit;

 insert into maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1205','Evidence Packet Correction - Task','0.75','Y','01-JAN-2020',NULL,'CR 2441','17-JUL-2018','Evidence Packet Correction Task - ARU Task','N','Account Review','N','N','Y');

commit;

update maxdat.PP_BO_EVENT_TARGET_LKUP
set end_date='21-Feb-2020',create_by='CR 2395' 
where event_id=1249
and end_date IS NULL;

commit;

insert into maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1249','Batching','0','N','22-FEB-2020',NULL,'CR 2395','13-JUN-2016','UNUSED_BY_EE','N','NOT IN SCORECARD','N','N','Y');

commit;

update maxdat.PP_BO_EVENT_TARGET_LKUP
set end_date='21-Feb-2020',create_by='CR 2395' 
where event_id=1257
and end_date IS NULL;

commit;

insert into maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1257','WINR Report','0','N','22-FEB-2020',NULL,'CR 2395','13-JUN-2016','UNUSED_BY_EE','N','NOT IN SCORECARD','N','N','Y');

commit;

update maxdat.PP_BO_EVENT_TARGET_LKUP
set end_date='21-Feb-2020', create_by='CR 2395' 
where event_id=1263
and end_date IS NULL;

 insert into maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1263','Agency Conference','0','N','22-FEB-2020',NULL,'CR 2395','13-JUN-2016','UNUSED_BY_EE','N','NOT IN SCORECARD','N','N','Y');

commit;


update maxdat.PP_BO_EVENT_TARGET_LKUP
set SCORECARD_GROUP='Downstate SDE FPBP'
where event_id=1331
and end_date IS NULL;

update maxdat.PP_BO_EVENT_TARGET_LKUP
set SCORECARD_GROUP='Downstate SDE FPBP MI'
where event_id=1332
and end_date IS NULL; 

commit;


update maxdat.PP_BO_EVENT_TARGET_LKUP
set end_date='21-Feb-2020', create_by='CR 2441' 
where event_id=1422
and end_date IS NULL;

insert into maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1422','Team Lead - Desk Time','0','N','22-FEB-2020',NULL,'CR 2441','','UNUSED_BY_EE','N','NOT IN SCORECARD','N','N','N');

commit;


update maxdat.PP_BO_EVENT_TARGET_LKUP
set WORKSUBACTIVITY_FLAG='Y' 
where event_id=1485
and end_date IS NULL;

update maxdat.PP_BO_EVENT_TARGET_LKUP
set WORKSUBACTIVITY_FLAG='N' 
where event_id=1552
and end_date IS NULL;

commit;

update maxdat.PP_BO_EVENT_TARGET_LKUP
set WORKSUBACTIVITY_FLAG='N'
where event_id=1644
and end_date is null;


update maxdat.PP_BO_EVENT_TARGET_LKUP
set WORKSUBACTIVITY_FLAG='N'
where event_id=1645
and end_date is null;

insert into   maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1654','QC OPS - AOP','0','N','22-FEB-2020',NULL,'CR 2395','','QC OPS - AOP','N','Ops QC','Y','Y','Y');   
insert into   maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1655','QC OPS - ARU Evidence Packets','0','N','22-FEB-2020',NULL,'CR 2395','','QC OPS - ARU Evidence Packets','N','Ops QC','Y','Y','Y');   
insert into   maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1656','QC OPS - LDS QC Evidence Packets','0','N','22-FEB-2020',NULL,'CR 2395','','QC OPS - LDS QC Evidence Packets','N','Ops QC','Y','Y','Y');   
insert into   maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1657','QC OPS - FPBP Phones','0','N','22-FEB-2020',NULL,'CR 2395','','QC OPS - FPBP Phones','N','Ops QC','Y','Y','Y');   
insert into   maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1658','QC OPS - FPBP Research','0','N','22-FEB-2020',NULL,'CR 2395','','QC OPS - FPBP Research','N','Ops QC','Y','Y','Y');   
insert into   maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1659','QC OPS - FPBP Processing','0','N','22-FEB-2020',NULL,'CR 2395','','QC OPS - FPBP Processing','N','Ops QC','Y','Y','Y');   
insert into   maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1660','Rescans','0','N','22-FEB-2020',NULL,'CR 2395','','Rescans','N','NYEC - FPBP - Back office','N','N','Y');   
insert into   maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1661','MI Report','0','N','22-FEB-2020',NULL,'CR 2395','','MI Report','N','NYEC - FPBP - Back office','N','N','Y');   
insert into   maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1662','Mailroom Mentor / SME','0','N','22-FEB-2020',NULL,'CR 2395','','Mailroom Mentor / SME','N','NYEC - FPBP - Back office','N','N','Y');   
insert into   maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1663','DOH Report','0','N','22-FEB-2020',NULL,'CR 2395','','DOH Report','N','NYEC - FPBP - Back office','N','N','Y');   
insert into   maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1664','Desk Time - Ops QC','0','N','22-FEB-2020',NULL,'CR 2441','','Desk Time - Ops QC','N','Operations Quality Control','N','N','Y');  

commit;

update maxdat.PP_BO_EVENT_TARGET_LKUP
set end_date='21-feb-2020' 
where event_id=1556
and start_date='29-Jun-2019';

commit;


update maxdat.PP_BO_EVENT_TARGET_LKUP
set end_date='30-Nov-2019' 
where event_id=1554
and start_date='29-Jun-2019'
and end_date='20-Dec-2019';

commit;

update maxdat.PP_BO_EVENT_TARGET_LKUP
set start_date='01-DEC-2019',end_date='29-feb-2020' ,target=0,scorecard_flag='N'
where event_id=1554
and start_date='21-DEC-2019';



commit;

insert into maxdat.PP_BO_EVENT_TARGET_LKUP values (
'1554','FPBP Mail Prep - FPBP Doc Management','12','Y','01-MAR-2020',NULL,'CR 2441','','FPBP Mail Prep - FPBP Doc Management','N','FPBP- Imaging Admin','Y','N','Y');


commit;


