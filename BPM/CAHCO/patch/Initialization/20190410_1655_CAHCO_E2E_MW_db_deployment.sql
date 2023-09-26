alter session set current_schema=maxdat;

update  d_staff
   set  ext_staff_number        =   'unknown\0',
        source_reference_type   =   'unknown',
        source_reference_id     =   0
 where  staff_id                =   0;
 
update  d_staff
   set  ext_staff_number                =   'hcotraining\' || source_reference_id,
        source_reference_type           =   'hcotraining'
 where  lower(source_reference_type)    =   'hcotraining';

commit;

 

 