create table cc_a_ampexp_filter(
job_type varchar2(1)
, job_id number(32)
, project_name varchar2(30)
, program_name varchar2(30)
, metric_name varchar2(100)
);


grant select on cc_a_ampexp_filter to MAXDAT_READ_ONLY;
