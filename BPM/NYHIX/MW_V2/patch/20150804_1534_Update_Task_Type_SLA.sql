/*
Created on 08/04/2015 by Raj A.
Description: Updating the SLA information per NYHIX-16540
*/
update d_task_types
   set sla_jeopardy_days = 2
  where task_type_id = 3003;
update d_task_types
   set sla_days = 2
  where task_type_id = 3005;
update d_task_types
   set sla_days = 2
  where task_type_id = 32282;
update d_task_types
   set sla_jeopardy_days = 1
  where task_type_id = 2013010;
update d_task_types
   set sla_days = 5,
       sla_jeopardy_days = 2
  where task_type_id in (2013011,2013012);
update d_task_types
   set sla_days_type = 'B',
       sla_jeopardy_days = 10
  where task_type_id = 2013013;  
update d_task_types
   set sla_days = 5,
       sla_jeopardy_days = 2
  where task_type_id = 2013014;  
update d_task_types
   set sla_days = 2,
       sla_jeopardy_days = 1
  where task_type_id = 2013015;  
update d_task_types
   set sla_days = 10,
       sla_jeopardy_days = 5
  where task_type_id = 2013019;    
update d_task_types
   set sla_days = 5
  where task_type_id = 2013027;  
update d_task_types
   set sla_days = 5,
       sla_jeopardy_days = 2
  where task_type_id = 2013028;
update d_task_types
   set sla_jeopardy_days = 1
  where task_type_id = 2013029;     
update d_task_types
   set sla_days = 25,
       sla_jeopardy_days = 20
  where task_type_id = 2013050;  
update d_task_types
   set sla_days = 5,
       sla_jeopardy_days = 3
  where task_type_id = 2013051; 
update d_task_types
   set sla_jeopardy_days = 2
  where task_type_id = 2013052;
update d_task_types
   set sla_days = 10,
       sla_days_type = 'B',
       sla_jeopardy_days = 7
  where task_type_id = 2013400; 
update d_task_types
   set sla_days = 5,
       sla_jeopardy_days = 2
  where task_type_id = 2013401;
update d_task_types
   set sla_days = 20,
       sla_jeopardy_days = 14
  where task_type_id = 2013421;     
update d_task_types
   set sla_days = 2,
       sla_jeopardy_days = 1
  where task_type_id = 2015001; 
update d_task_types
   set sla_days = 5,
       sla_jeopardy_days = 3
  where task_type_id in (2015003,2015008,2015010,2015014);  
update d_task_types
   set sla_days = 30,
       sla_jeopardy_days = 25
  where task_type_id = 2015015; 
update d_task_types
   set sla_days = 15,
       sla_jeopardy_days = 10
  where task_type_id = 2015016;
update d_task_types
   set sla_days = 15,
       sla_jeopardy_days = 10
  where task_type_id in (2015021,2015022);  
update d_task_types
   set sla_days = 90,
       sla_jeopardy_days = 75
  where task_type_id = 2015023; 
update d_task_types
   set sla_days = 60,
       sla_jeopardy_days = 45
  where task_type_id = 2015024;      
update d_task_types
   set sla_days = 5,
       sla_jeopardy_days = 2
  where task_type_id = 2016155;     
update d_task_types
   set sla_days = 2,
       sla_jeopardy_days = 1
  where task_type_id = 2016234;
update d_task_types
   set sla_jeopardy_days = 2
  where task_type_id = 2016254;     
update d_task_types
   set sla_days = 3,
       sla_jeopardy_days = 1
  where task_type_id = 2016255;  
update d_task_types
   set sla_days = 5
  where task_type_id = 20137008;            
COMMIT;