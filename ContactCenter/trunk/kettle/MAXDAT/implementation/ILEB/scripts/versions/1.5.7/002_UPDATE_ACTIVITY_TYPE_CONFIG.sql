update cc_c_activity_type
set activity_type_category = 'Available'
, is_paid_flag = 1
where activity_type_name in ('Special Handling Team Spanish', 'Special Handling Team English');

update cc_c_activity_type
set activity_type_category = 'Meeting'
, is_paid_flag = 1
where activity_type_name = 'Huddle';

update cc_c_activity_type
set activity_type_category = 'Scheduled Unpaid Time Off'
where activity_type_name in ('FMLA', 'Miltary Leave ');

commit;


update cc_d_activity_type
set activity_type_category = 'Available'
, is_paid_flag = 1
where activity_type_name in ('Special Handling Team Spanish', 'Special Handling Team English');

update cc_d_activity_type
set activity_type_category = 'Meeting'
, is_paid_flag = 1
where activity_type_name = 'Huddle';

update cc_d_activity_type
set activity_type_category = 'Scheduled Unpaid Time Off'
where activity_type_name in ('FMLA', 'Miltary Leave ');

commit;

-- ILEB-4982

update cc_c_activity_type
set activity_type_category = 'Scheduled Unpaid Time Off'
where activity_type_name = 'Jury Duty ';

update cc_d_activity_type
set activity_type_category = 'Scheduled Unpaid Time Off'
where activity_type_name = 'Jury Duty ';

commit;