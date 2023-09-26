delete from d_task_types where task_type_id in(
32260,
2002,
1108,
26,
22,
27,
110,
24,
1056,
2005,
20012,
30052,
25,
23,
28,
2001);
commit;


delete from corp_etl_list_lkup where "VALUE" in(
'Check On Provider Stats',
'Enrollment Correction Task for Special Projects',
'General Correspondence Data Entry Task',
'Letter Generation Error',
'Letter Request Creation Error',
'Letter Voided Error',
'Manual Human Task',
'Provider Load Error',
'Research Task',
'Enrollment Correction Task for State',
'SPU Denied Selection Task',
'State Complaints',
'Daily Eligible Error Task',
'ERL Extract Daily Selections Error',
'ETL Load Selection Response Error',
'Enrollment Correction Task'
);
commit;
