
select * from f_complaint_by_date
where cmpl_bi_id in(
55067261,
55067298,
55067290,
55067292,
55067296,
55070787
)
and bucket_end_date != to_date('7/7/2077','mm/dd/yyyy');

select * from f_complaint_by_date
where cmpl_bi_id in(
55067261,
55067298,
55067290,
55067292,
55067296,
55070787
)
and bucket_end_date = to_date('7/7/2077','mm/dd/yyyy');

UPDATE F_COMPLAINT_BY_DATE
SET  bucket_end_date = to_date('7/7/2077','mm/dd/yyyy')       
WHERE FCMPLBD_ID IN(8925359,
8927906,
8924468,
8924476,
8927926,
8924682);

DELETE  F_COMPLAINT_BY_DATE
WHERE FCMPLBD_ID IN(8938069,
8938098,
8938101,
8938105,
8938108,
8938127);

execute MAXDAT_ADMIN.RESET_BPM_QUEUE_ROWS_BY_BSL_ID(22);

commit;

select * from f_complaint_by_date
where cmpl_bi_id in(
55067261,
55067298,
55067290,
55067292,
55067296,
55070787
)
and bucket_end_date != to_date('7/7/2077','mm/dd/yyyy');

select * from f_complaint_by_date
where cmpl_bi_id in(
55067261,
55067298,
55067290,
55067292,
55067296,
55070787
)
and bucket_end_date = to_date('7/7/2077','mm/dd/yyyy');