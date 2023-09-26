create table IBR_PROCESS_TASKS
(  IBR_id                              NUMBER(20) not null 
 , Case_Number                         VARCHAR2(14)
 , Status                              VARCHAR2(1) DEFAULT 'N');

grant select, insert, update, delete on IBR_PROCESS_TASKS to MAXDAT_OLTP_SIUD;
grant select on IBR_PROCESS_TASKS to MAXDAT_READ_ONLY;

create index IBR_PROCESS_TASKS_INDX on IBR_PROCESS_TASKS (ibr_id)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

-- Create table
create table IBR_ASSIGNMENT
(
  assignment_id        NUMBER(19),
  ibr_id               NUMBER(19),
  assignment_date_from DATE,
  assignment_date      DATE,
  assignment_date_to   DATE,
  role_name            VARCHAR2(255),
  user_name            VARCHAR2(255),
  staff_name           VARCHAR2(255),
  email_date           DATE,
  task_type            VARCHAR2(10),
  subject_type_from    NUMBER(2),
  subject_type         NUMBER(2),
  subject_type_to      NUMBER(2),
  subject_id           NUMBER(19),
  role_id              NUMBER(19),
  is_current           NUMBER(1),
  case_number          VARCHAR2(14),
  provider_type        VARCHAR2(255)
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
-- Create/Recreate indexes 
create index IBR_ASSIGNMENT_IDINDX on IBR_ASSIGNMENT (ASSIGNMENT_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
create index IBR_ASSIGNMENT_INDXTR on IBR_ASSIGNMENT (IBR_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
-- Grant/Revoke object privileges 
grant select, insert, update, delete on IBR_ASSIGNMENT to MAXDAT_OLTP_SIUD;
grant select on IBR_ASSIGNMENT to MAXDAT_READ_ONLY;

create or replace view s_ibr_managework_sv as
Select Assignment_id , ibr_id , Start_Date ,End_Date ,Claim_Date  ,User_Name ,Staff_Name ,Task_Type ,Group_Name 
       , Case_Number, Provider_Type, Task_Age
       , Case When Task_Age <= 5  Then '0-5'
              When Task_Age Between  6 and 10 Then '6-10'
              When Task_Age Between 11 and 15 Then '11-15'
              When Task_Age Between 16 and 20 Then '16-20'
              When Task_Age Between 21 and 25 Then '21-25'
              When Task_Age Between 26 and 30 Then '26-30'
              When Task_Age Between 31 and 60 Then '31-60'
              When Task_Age Between 61 and 90 Then '61-90'
              When Task_Age > 90 Then '90+' End as Task_AgeGroup
from (select   Assignment_id , ibr_id , Start_Date ,End_Date ,Claim_Date  ,User_Name ,Staff_Name ,Task_Type ,Group_Name 
       , Case_Number, Provider_Type, NVL(trunc(End_date), trunc(sysdate)) - trunc(Start_Date) as Task_Age
  from (select  a.ibr_id ,assignment_date Claim_Date --, assignment_date_From Start_Date
      , Case when lag(Role_Name) over ( partition by a.ibr_id order by assignment_date) = 'IBR DWC Eligibility Staff' 
             then assignment_date
             else assignment_date_From end Start_Date
      , user_name ,is_current, Email_Date , Role_name, staff_name 
      , case_number , provider_type
      , case when assignment_date_To is not null then assignment_date_To
             when is_current = 0 and subject_type_to is null Then Email_Date
             Else Null 
              End End_Date
      , lag(Role_Name) over ( partition by a.ibr_id order by assignment_date) PreviousRole 
      , assignment_id 
      , 'DWC QUEUE' Group_Name   
      , case task_type when 'PPQR' then 'Pending Policy Question Response'
                       else 'Pending DWC Review' end Task_Type          
  from ibr_assignment a 
) s
Where Role_Name = 'IBR DWC Eligibility Staff')
Union
Select Assignment_id, ibr_id, Start_Date, End_Date, Claim_Date, User_Name, Staff_Name
       , Task_Type, Group_Name, case_number, provider_type, Task_Age
       , Case When Task_Age <= 5  Then '0-5'
              When Task_Age Between  6 and 10 Then '6-10'
              When Task_Age Between 11 and 15 Then '11-15'
              When Task_Age Between 16 and 20 Then '16-20'
              When Task_Age Between 21 and 25 Then '21-25'
              When Task_Age Between 26 and 30 Then '26-30'
              When Task_Age Between 31 and 60 Then '31-60'
              When Task_Age Between 61 and 90 Then '61-90'
              When Task_Age > 90 Then '90+' End as Task_AgeGroup
From (select Assignment_id
       , ibr_id 
       , assignment_date Start_Date
       , Null End_Date , Null Claim_Date  , Null User_Name , Null Staff_Name ,'Pending DWC Review' Task_Type ,'DWC QUEUE' Group_Name
       , case_number , provider_type
       , (trunc(sysdate) - trunc(assignment_date)) as Task_Age
  from ibr_assignment a
 where is_current = 1 and role_name = 'DWC Queue'
   and assignment_date_to is null)
order by Start_Date
 with read only;

GRANT SELECT ON S_IBR_MANAGEWORK_SV  TO MAXDAT_READ_ONLY;

create or replace view f_ibr_avg_days_in_queue_by_staff_sv as
select d_date, task_type, staff_name, AVG0 AVG_DAYS_IN_QUEUE 
      ,case when AVG0 > AVG1 and AVG1 > AVG2 then 1
            else 0 end incr_ind
      ,case when AVG0 < AVG1 and AVG1 < AVG2 then 1
            else 0 end decr_ind
  from ( Select d_date, task_type, staff_name, AVG0 ,AVG1, lag(AVG1) OVER (PARTITION BY Task_Type, staff_name order by d_date asc) as AVG2
           from (select d_date, task_type, staff_name, AVG0 ,lag(AVG0) OVER (PARTITION BY Task_Type, staff_name order by d_date asc) as AVG1
                   from (Select c.D_DATE , task_type, staff_name, round(avg(bus_days_between(b.Start_date,c.d_date)))  AVG0
                           from s_ibr_managework_sv b, bpm_d_dates c
                          where c.BUSINESS_DAY_FLAG = 'Y'
                            and TRUNC(c.D_DATE) between trunc(start_Date) and NVL(trunc(end_Date),'07-JUL-7777')
                          group by c.d_date, b.Task_Type, staff_name)))
 order by Task_Type, d_date, staff_name
 with read only;
 
GRANT SELECT ON F_IBR_AVG_DAYS_IN_QUEUE_BY_STAFF_SV  TO MAXDAT_READ_ONLY; 
 

create or replace view f_ibr_avg_days_in_queue_sv as
select d_date, task_type, AVG0 AVG_DAYS_IN_QUEUE 
      ,case when AVG0 > AVG1 and AVG1 > AVG2 then 1
            else 0 end incr_ind
      ,case when AVG0 < AVG1 and AVG1 < AVG2 then 1
            else 0 end decr_ind
  from ( Select d_date, task_type, AVG0 ,AVG1, lag(AVG1) OVER (PARTITION BY Task_Type order by d_date asc) as AVG2
           from (select d_date, task_type, AVG0 ,lag(AVG0) OVER (PARTITION BY Task_Type order by d_date asc) as AVG1
                   from (Select c.D_DATE , task_type, round(avg(bus_days_between(b.Start_date,c.d_date)))  AVG0
                           from s_ibr_managework_sv b, bpm_d_dates c
                          where c.BUSINESS_DAY_FLAG = 'Y'
                            and TRUNC(c.D_DATE) between trunc(start_Date) and NVL(trunc(end_Date),'07-JUL-7777')
                          group by c.d_date, b.Task_Type)))
 order by Task_Type, d_date
 with read only;

GRANT SELECT ON F_IBR_AVG_DAYS_IN_QUEUE_SV  TO MAXDAT_READ_ONLY; 


create or replace view f_ibr_queue_num_by_day_by_staff_sv as
select d_date, task_type, staff_name, ic0 INVENTORY_COUNT ,ic1, ic2, ic3
      ,case when (ic0 > ic1) and (ic1 > ic2) and (ic2 > ic3) then 1
            else 0 end incr_ind
      ,case when (ic0 < ic1) and (ic1 < ic2) and (ic2 < ic3) then 1
            else 0 end decr_ind
  from ( Select d_date, task_type, staff_name , ic0 , ic1, ic2, lag(ic2) OVER (PARTITION BY Task_Type, staff_name order by d_date asc) as ic3
           from (select d_date, task_type, staff_name, ic0 ,ic1, lag(ic1) OVER (PARTITION BY Task_Type, staff_name order by d_date asc) as ic2
                   from (Select c.D_DATE , task_type, staff_name ,count(Assignment_id) IC0
                               ,lag(count(Assignment_id)) OVER (PARTITION BY Task_Type, staff_name order by d_date asc) as ic1
                           from s_ibr_managework_sv b, bpm_d_dates c
                          where c.BUSINESS_DAY_FLAG = 'Y'
                            and TRUNC(c.D_DATE) between trunc(start_Date) and NVL(trunc(end_Date),'07-JUL-7777')
                          group by c.d_date, b.Task_Type, staff_name)))
 order by Task_Type, d_date, staff_name
 with read only;

GRANT SELECT ON F_IBR_QUEUE_NUM_BY_DAY_BY_STAFF_SV  TO MAXDAT_READ_ONLY; 


create or replace view f_ibr_queue_num_by_day_sv as
select d_date, task_type, ic0 INVENTORY_COUNT 
      ,case when ic0 > ic1 and ic1 > ic2 and ic2 > ic3 then 1
            else 0 end incr_ind
      ,case when ic0 < ic1 and ic1 < ic2 and ic2 < ic3 then 1
            else 0 end decr_ind
  from ( Select d_date, task_type, ic0 ,ic1, ic2, lag(ic2) OVER (PARTITION BY Task_Type order by d_date asc) as ic3
           from (select d_date, task_type, ic0 ,ic1, lag(ic1) OVER (PARTITION BY Task_Type order by d_date asc) as ic2
                   from (Select c.D_DATE , task_type, count(Assignment_id) IC0
                               ,lag(count(Assignment_id)) OVER (PARTITION BY Task_Type order by d_date asc) as ic1
                           from s_ibr_managework_sv b, bpm_d_dates c
                          where c.BUSINESS_DAY_FLAG = 'Y'
                            and TRUNC(c.D_DATE) between trunc(start_Date) and NVL(trunc(end_Date),'07-JUL-7777')
                          group by c.d_date, b.Task_Type)))
 order by Task_Type, d_date
 with read only;
 
GRANT SELECT ON F_IBR_QUEUE_NUM_BY_DAY_SV  TO MAXDAT_READ_ONLY;  



