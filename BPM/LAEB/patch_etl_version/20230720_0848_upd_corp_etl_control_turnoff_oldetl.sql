update corp_etl_control
set value = 'N'
where name = 'EMRS_RUN_OLD_ELIGSEGMENT_DTL';

commit;