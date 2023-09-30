ALTER table call_record_stg
ADD (caller_last_name VARCHAR2(50)
     ,caller_first_name VARCHAR2(50)
     ,caller_phone VARCHAR2(20)
     ,call_type_cd VARCHAR2(64));