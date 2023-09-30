alter session set current_schema = maxdat_product_cc;

insert into cc_c_filter (filter_type, value)
values ('ACD_CALL_TYPE_ID_IGNORE', '-1');

commit;