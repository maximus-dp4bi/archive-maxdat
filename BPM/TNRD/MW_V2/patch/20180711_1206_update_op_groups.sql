---- TNERPS-4647

update MAXDAT.D_BUSINESS_UNITS set business_unit_name = 'Document Processing'
where business_unit_name = 'Mail Room';

update MAXDAT.D_TASK_TYPES set OPERATIONS_GROUP = 'Document Processing'
where OPERATIONS_GROUP = 'Mail Room';

update MAXDAT.D_TASK_TYPES set OPERATIONS_GROUP = 'Research'
where TASK_TYPE_ID = '31050';

commit;
