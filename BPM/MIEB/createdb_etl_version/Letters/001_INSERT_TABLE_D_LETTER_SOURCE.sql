insert 
  into  D_LETTER_SOURCE     (   letter_source_code,     letter_source_name,     description,    report_label,   effective_from_date,        effective_thru_date                 )
values                      (   'AP',                   'AP',                   'AP',           'AP',           sysdate,                    to_date('7777-07-07', 'yyyy-mm-dd') );

commit;