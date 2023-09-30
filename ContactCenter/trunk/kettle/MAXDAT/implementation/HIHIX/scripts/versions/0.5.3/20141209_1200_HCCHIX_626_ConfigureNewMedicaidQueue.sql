--1. Create new unit of work in cc_c_unit_of_work:
      -- insert unit of work row where
         -- unit_of_work_name = 'Medicaid'
         -- unit_of_work_category = 'INBOUND_CALL'    
         
insert into cc_c_unit_of_work
  (UNIT_OF_WORK_ID,
   UNIT_OF_WORK_NAME,
   RECORD_EFF_DT,
   RECORD_END_DT,
   Unit_Of_Work_Category)
values
  (SEQ_CC_C_UNIT_OF_WORK.Nextval,
   'Medicaid',
   to_date('01-01-1900', 'dd-mm-yyyy'),
   to_date('31-12-2999', 'dd-mm-yyyy'),
   'INBOUND_CALL');
         

--2. Create new unit of work in cc_d_unit_of_work:
      -- insert unit of work where
         -- unit_of_work_name = 'Medicaid'
         -- production_plan_id = 0
         -- hourly_flag = 'N'
         -- handled_time_unit = 'Seconds'
         -- unit_of_work_category = 'INBOUND_CALL'            

insert into cc_d_unit_of_work
  (uow_id,
   unit_of_work_name,
   production_plan_id,
   hourly_flag,
   handle_time_unit,
   Unit_Of_Work_Category)
values
  (SEQ_CC_D_UNIT_OF_WORK.Nextval,
   'Medicaid',
   0,
   'N',
   'Seconds',
   'INBOUND_CALL');

  
--3. Update the existing row for the new queue in cc_c_contact_queue;
     -- update where queue_name = 'MAXHIHIX_Medicaid_vcall'
         -- set queue_type = 'Inbound'
         -- set unit_of_work_name = 'Medicaid'

update cc_c_contact_queue
   set unit_of_work_name = 'Medicaid', queue_type = 'Inbound'
 where queue_name = 'MAXHIHIX_Medicaid_vcall'
   AND unit_of_work_name = 'Unknown';

--4. Update the existing row for the new queue cc_d_contact_queue;
     -- update where queue_name = 'MAXHIHIX_Medicaid_vcall'
         -- set queue_type = 'Inbound'

UPDATE cc_d_contact_queue
   SET queue_type = 'Inbound'
 WHERE queue_name = 'MAXHIHIX_Medicaid_vcall';


--5. Update unit of work id on the fact table for all existing rows for this new queue
     -- update cc_f_actuals_queue_interval f where f.d_contact_queue_id = q.d_contact_queue_id and q.queue_name = 'MAXHIHIX_Medicaid_vcall'
        -- set f.d_unit_of_work_id = to the new Medicaid unit of work created in requirement 2 
        
UPDATE cc_f_actuals_queue_interval
   SET D_UNIT_OF_WORK_ID =
       (select UOW_ID
          from cc_d_unit_of_work
         WHERE unit_of_work_name = 'Medicaid'
           AND Unit_Of_Work_Category = 'INBOUND_CALL')
 WHERE D_CONTACT_QUEUE_ID =
       (select D_CONTACT_QUEUE_ID
          from cc_d_contact_queue
         where queue_name = 'MAXHIHIX_Medicaid_vcall');

COMMIT;

/
