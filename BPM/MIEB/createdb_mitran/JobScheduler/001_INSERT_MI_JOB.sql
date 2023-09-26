insert
  into  mi_job  (   job_name,                   job_description,                    enabled )
values          (   'LOAD_ETL_INIT_MIHC_CON',   'Load the table ETL_INIT_MIHC_CON', 'Y'     );

insert
  into  mi_job  (   job_name,                       job_description,                    enabled )
values          (   'LOAD_LETTER_DEFINITION_DATA',  'Load letter definition data',      'Y'     );

commit;