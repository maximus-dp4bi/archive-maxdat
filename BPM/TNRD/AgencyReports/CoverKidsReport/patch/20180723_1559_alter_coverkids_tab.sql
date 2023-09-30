ALTER TABLE coverkids_approval_stg
ADD(home_phone_number VARCHAR2(20)
    ,home_phone_type_cd VARCHAR2(2)
    ,st_reported_phone VARCHAR2(20)
    ,st_phone_type_cd VARCHAR2(2)
    ,other_phone_number VARCHAR2(20)
    ,other_phone_type VARCHAR2(2)
    ,pregnancy VARCHAR2(1)
    ,income_amount NUMBER
    ,income_frequency VARCHAR2(15)
    ,household_size NUMBER);
   