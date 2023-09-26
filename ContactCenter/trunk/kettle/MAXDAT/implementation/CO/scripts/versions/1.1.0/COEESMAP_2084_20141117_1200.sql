     


--1. UPDATE CC_C_UNIT_OF_WORK:
-- end unit of work name 'COEEMAP Inbound' - set end date to '07/31-2014'
-- create new unit of work name = 'Primary Queues' ; unit of work category = INBOUND_CALL
-- create new unit of work name = 'Specialty Queues' ; unit of work category = INBOUND_CALL

update maxdat.cc_c_unit_of_work
   set record_end_dt = to_date('07/31/2014','mm/dd/yyyy')
 where unit_of_work_name = 'COEEMAP Inbound';

insert into maxdat.cc_c_unit_of_work
  (unit_of_work_id, unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt)
values
  (seq_cc_c_unit_of_work.nextval, 'Primary Queues', 'INBOUND_CALL', to_date('07/31/2014','mm/dd/yyyy'), to_date('12/31/2199','mm/dd/yyyy'));

insert into maxdat.cc_c_unit_of_work
  (unit_of_work_id, unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt)
values
  (seq_cc_c_unit_of_work.nextval, 'Specialty Queues', 'INBOUND_CALL', to_date('07/31/2014','mm/dd/yyyy'), to_date('12/31/2199','mm/dd/yyyy'));


--2. UPDATE CC_D_UNIT_OF_WORK;
-- insert new dimension row -- unit of work name = 'Primary Queues'
                            -- unit of work category = INBOUND_CALL
                            -- prod plan id = 0
                            -- hourly flag = N
                            -- handle time unit = Seconds
-- insert new dimension row -- unit of work name = 'Specialty Queues'
                            -- unit of work category = INBOUND_CALL
                            -- prod plan id = 0
                            -- hourly flag = N
                            -- handle time unit = Seconds
                            
insert into maxdat.cc_d_unit_of_work
  (uow_id, unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit)
values
  (seq_cc_d_unit_of_work.nextval, 'Primary Queues', 'INBOUND_CALL', 0, 'N', 'Seconds');
  
insert into maxdat.cc_d_unit_of_work
  (uow_id, unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit)
values
  (seq_cc_d_unit_of_work.nextval, 'Specialty Queues', 'INBOUND_CALL', 0, 'N', 'Seconds');  

                            
--3. UPDATE CC_C_CONTACT_QUEUE;
-- update the unit_of_work_name for the following queues from 'COEEMAP Inbound' to 'Primary Queues': ('CS_Eng_annc_s','CS_Spn_annc_s','other_language_s')

-- update the unit_of_work_name for the following queues from 'COEEMAP Inbound' to 'Specialty Queues':
   -- ('Peak_Eng_s','Peak_Spn_s','Prov_Eng_s','Prov_Spn_s','IEVS_Eng_s','IEVS_Spn_s','AWDCW_Eng_s','AWDCW_Spn_s','BIWAD_EN_s','AWDC_EN_s','BIWC_EN_s','BIWAD_SP_s',
   -- 'AWDC_SP_s','BIWC_SP_s','CBWD_Eng_s','CBWD_Spn_s','AAB_EN_s','PAC_Eng_s','PAC_Spn_s')


update CC_C_CONTACT_QUEUE set unit_of_work_name='Primary Queues' where queue_name in ('CS_Eng_annc_s','CS_Spn_annc_s','other_language_s');

update CC_C_CONTACT_QUEUE set unit_of_work_name='Specialty Queues' where queue_name in ('Peak_Eng_s','Peak_Spn_s','Prov_Eng_s','Prov_Spn_s','IEVS_Eng_s','IEVS_Spn_s','AWDCW_Eng_s','AWDCW_Spn_s','BIWAD_EN_s','AWDC_EN_s','BIWC_EN_s','BIWAD_SP_s',
    'AWDC_SP_s','BIWC_SP_s','CBWD_Eng_s','CBWD_Spn_s','AAB_EN_s','PAC_Eng_s','PAC_Spn_s');



--4. UPDATE CC_F_ACTUALS_QUEUE_INTERVAL;
-- update d_unit_of_work_id for all existing fact rows as appropriate per the new unit of work configurations


update CC_F_ACTUALS_QUEUE_INTERVAL set d_unit_of_work_id=(select uow_id from CC_D_UNIT_OF_WORK where unit_of_work_name='Primary Queues')
where D_CONTACT_QUEUE_ID in (select D_CONTACT_QUEUE_ID from CC_D_CONTACT_QUEUE where queue_name in ('CS_Eng_annc_s','CS_Spn_annc_s','other_language_s'));

update CC_F_ACTUALS_QUEUE_INTERVAL set d_unit_of_work_id=(select uow_id from CC_D_UNIT_OF_WORK where unit_of_work_name='Specialty Queues')
where D_CONTACT_QUEUE_ID in (select D_CONTACT_QUEUE_ID from CC_D_CONTACT_QUEUE where queue_name in ('Peak_Eng_s','Peak_Spn_s','Prov_Eng_s','Prov_Spn_s','IEVS_Eng_s','IEVS_Spn_s','AWDCW_Eng_s','AWDCW_Spn_s','BIWAD_EN_s','AWDC_EN_s','BIWC_EN_s','BIWAD_SP_s',
    'AWDC_SP_s','BIWC_SP_s','CBWD_Eng_s','CBWD_Spn_s','AAB_EN_s','PAC_Eng_s','PAC_Spn_s'));
    
commit;

/  
