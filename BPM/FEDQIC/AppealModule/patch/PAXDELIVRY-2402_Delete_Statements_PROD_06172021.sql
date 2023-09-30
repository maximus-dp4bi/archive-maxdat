

delete from maxdat.f_appeal_tasks_by_day where appeal_part_id in ( 1580 , 1581 ) ;

delete from maxdat.F_APPEALS_BY_DAY_BY_PART where appeal_part_id in ( 1580 , 1581 ) ;

delete from maxdat.d_appeal_parts where part_id in ( 1580,1581 );

delete  from maxdat.d_business_units where business_unit_id in ( 1580,1581 );

commit;