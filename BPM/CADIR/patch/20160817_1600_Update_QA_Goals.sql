alter session set current_schema=MAXDAT_CADR;

select * from D_QA_MONTHLY_GOAL G
inner join D_QA_CHECKSHEETS C on G.checksheet_id = C.CHECKSHEET_ID
--where Start_date = '01-AUG-2016'
order by reporting_title, start_date;

select * from D_QA_Checksheets where title like '%IMR%';

update d_qa_monthly_goal set end_date = '13-JUN-2016' where MGoal_id = 4;
update d_qa_monthly_goal set end_date = '27-JUL-2016' where MGoal_id = 3;
update d_qa_monthly_goal set end_date = '27-JUL-2016' where MGoal_id = 7;
update d_qa_monthly_goal set end_date = '01-JUN-2016' where MGoal_id = 12;

update d_qa_monthly_goal set end_date = '31-JUL-2016' where MGoal_id = 5;
Insert into d_qa_monthly_Goal
--( Mgoal_id, checksheet_id, monthly_goal, start_date, end_date , created_by,  updated_by,  created_date,  updated_date)
select 15 Mgoal_id, checksheet_id, '25' monthly_goal, to_date('01-AUG-2016','DD-MON-YYYY') start_date, to_date('07-JUL-7777','DD-MON-YYYY') end_date 
       ,sysdate created_date, user created_by, sysdate updated_date ,user updated_by
  from d_qa_monthly_goal where mgoal_id = 5;

update d_qa_monthly_goal set end_date = '31-JUL-2016' where MGoal_id = 13;
Insert into d_qa_monthly_Goal
select 16 Mgoal_id, checksheet_id, '25' monthly_goal, to_date('01-AUG-2016','DD-MON-YYYY') start_date, to_date('07-JUL-7777','DD-MON-YYYY') end_date 
       ,sysdate created_date, user created_by, sysdate updated_date ,user updated_by
  from d_qa_monthly_goal where mgoal_id = 13;
  
update d_qa_monthly_goal set end_date = '31-JUL-2016' where MGoal_id = 10;
Insert into d_qa_monthly_Goal
select 17 Mgoal_id, checksheet_id, '120' monthly_goal, to_date('01-AUG-2016','DD-MON-YYYY') start_date, to_date('07-JUL-7777','DD-MON-YYYY') end_date 
       ,sysdate created_date, user created_by, sysdate updated_date ,user updated_by
  from d_qa_monthly_goal where mgoal_id = 10;  
  
update d_qa_monthly_goal set end_date = '31-JUL-2016' where MGoal_id = 6;
Insert into d_qa_monthly_Goal
select 18 Mgoal_id, checksheet_id, '300' monthly_goal, to_date('01-AUG-2016','DD-MON-YYYY') start_date, to_date('07-JUL-7777','DD-MON-YYYY') end_date 
       ,sysdate created_date, user created_by, sysdate updated_date ,user updated_by
  from d_qa_monthly_goal where mgoal_id = 6;   
  
update d_qa_monthly_goal set end_date = '31-JUL-2016' where MGoal_id = 2;
Insert into d_qa_monthly_Goal
select 19 Mgoal_id, checksheet_id, '240' monthly_goal, to_date('01-AUG-2016','DD-MON-YYYY') start_date, to_date('07-JUL-7777','DD-MON-YYYY') end_date 
       ,sysdate created_date, user created_by, sysdate updated_date ,user updated_by
  from d_qa_monthly_goal where mgoal_id = 2;  
  
update d_qa_monthly_goal set end_date = '31-JUL-2016' where MGoal_id = 1;
Insert into d_qa_monthly_Goal
select 20 Mgoal_id, checksheet_id, '384' monthly_goal, to_date('01-AUG-2016','DD-MON-YYYY') start_date, to_date('07-JUL-7777','DD-MON-YYYY') end_date 
       ,sysdate created_date, user created_by, sysdate updated_date ,user updated_by
  from d_qa_monthly_goal where mgoal_id = 1;  
  
update d_qa_monthly_goal set end_date = '31-JUL-2016' where MGoal_id = 8;
Insert into d_qa_monthly_Goal
select 21 Mgoal_id, checksheet_id, '396' monthly_goal, to_date('01-AUG-2016','DD-MON-YYYY') start_date, to_date('07-JUL-7777','DD-MON-YYYY') end_date 
       ,sysdate created_date, user created_by, sysdate updated_date ,user updated_by
  from d_qa_monthly_goal where mgoal_id = 8;  
  
update d_qa_monthly_goal set end_date = '31-JUL-2016' where MGoal_id = 9;
Insert into d_qa_monthly_Goal
select 22 Mgoal_id, checksheet_id, '78' monthly_goal, to_date('01-AUG-2016','DD-MON-YYYY') start_date, to_date('07-JUL-7777','DD-MON-YYYY') end_date 
       ,sysdate created_date, user created_by, sysdate updated_date ,user updated_by
  from d_qa_monthly_goal where mgoal_id = 9;  
  
update d_qa_monthly_goal set end_date = '31-JUL-2016' where MGoal_id = 14;
Insert into d_qa_monthly_Goal
select 23 Mgoal_id, checksheet_id, '24' monthly_goal, to_date('01-AUG-2016','DD-MON-YYYY') start_date, to_date('07-JUL-7777','DD-MON-YYYY') end_date 
       ,sysdate created_date, user created_by, sysdate updated_date ,user updated_by
  from d_qa_monthly_goal where mgoal_id = 14;   
  
update d_qa_monthly_goal set end_date = '31-JUL-2016' where MGoal_id = 11;
Insert into d_qa_monthly_Goal
select 24 Mgoal_id, checksheet_id, '8' monthly_goal, to_date('01-AUG-2016','DD-MON-YYYY') start_date, to_date('07-JUL-7777','DD-MON-YYYY') end_date 
       ,sysdate created_date, user created_by, sysdate updated_date ,user updated_by
  from d_qa_monthly_goal where mgoal_id = 11;   
  
Insert into d_qa_monthly_Goal
select 25 Mgoal_id, 1 checksheet_id, '96' monthly_goal, to_date('01-AUG-2016','DD-MON-YYYY') start_date, to_date('07-JUL-7777','DD-MON-YYYY') end_date 
       ,sysdate created_date, user created_by, sysdate updated_date ,user updated_by
  from d_qa_monthly_goal where mgoal_id = 11;   
  
Insert into d_qa_monthly_Goal
select 26 Mgoal_id, 10000 checksheet_id, '96' monthly_goal, to_date('01-AUG-2016','DD-MON-YYYY') start_date, to_date('07-JUL-7777','DD-MON-YYYY') end_date 
       ,sysdate created_date, user created_by, sysdate updated_date ,user updated_by
  from d_qa_monthly_goal where mgoal_id = 11;  
