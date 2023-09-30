delete from bpm_activity_attribute where bacl_id in(select bacl_id from bpm_activity_lkup where bem_id=16);
delete from bpm_activity_lkup where bacl_id in(1,2,3,4,5,6,7,8,9,10,11);

insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(1,1,'Scan Batch');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(2,2,'QC Required');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(3,1,'Perform QC');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(4,1,'Classify Document and Extract Metadata');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(5,1,'Batch Recognition (Recognition Server)');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(6,1,'Review Batch (KTM Validation Module)');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(7,1,'Create PDFs');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(8,1,'Populate Reports Data');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(9,1,'Release to DMS');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(10,3,'Release to DMS');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(11,3,'Cancelled');

insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(1,16,1,'ASSD_SCAN_BATCH','NOT NULL',1);
insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(2,16,2,'GWF_QC_REQUIRED','NOT NULL',2);
insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(3,16,3,'ASSD_PERFORM_QC','NOT NULL',3);
insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(4,16,4,'ASSD_CLASSIFICATION','NOT NULL',4);
insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(5,16,5,'ASSD_RECOGNITION','NOT NULL',5);
insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(6,16,6,'ASSD_VALIDATE_DATA','NOT NULL',6);
insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(7,16,7,'ASSD_CREATE_PDF','NOT NULL',7);
insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(8,16,8,'ASSD_POPULATE_REPORTS','NOT NULL',8);
insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(9,16,9,'ASSD_RELEASE_DMS','NOT NULL',9);
insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(10,16,10,'ASED_RELEASE_DMS','NOT NULL',10);
insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(11,16,11,'CANCEL_DT','NOT NULL',11);

commit;
