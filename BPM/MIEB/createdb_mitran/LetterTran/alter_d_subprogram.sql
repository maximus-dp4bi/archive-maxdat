alter table d_subprogram add (tran_name varchar2(50));

update d_subprogram set tran_name = 'MIEnrolls' where subprogram_code = 'MED';
update d_subprogram set tran_name = 'MIChild' where subprogram_code = 'MC';


