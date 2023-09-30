alter table f_mfb_by_hour enable row movement;

delete from f_mfb_by_hour where mfb_bi_id in(
1303102,
1161171,
1161168,
1156676,
1160847,
1304841,
1156676
)and creation_count=0 and inventory_count=1 and completion_count=0 and bucket_end_date<'01-Jan-2077';

update f_mfb_by_hour b set bucket_end_date=
(select bucket_start_date from f_mfb_by_hour b2 where b2.mfb_bi_id=b.mfb_bi_id and b2.bucket_end_date>'01-Jan-2077')
where mfb_bi_id in(
1303102,
1161171,
1161168,
1156676,
1160847,
1304841,
1156676
) and creation_count=1;


--1330088
update f_mfb_by_hour set fmfbbh_id=11467550 where fmfbbh_id=1467550;
update f_mfb_by_hour set fmfbbh_id=1467550 where fmfbbh_id=1467564;
update f_mfb_by_hour set fmfbbh_id=1467564 where fmfbbh_id=11467550;

--1330086
update f_mfb_by_hour set fmfbbh_id=11467521 where fmfbbh_id=1467521;
update f_mfb_by_hour set fmfbbh_id=1467521 where fmfbbh_id=1467538;
update f_mfb_by_hour set fmfbbh_id=1467538 where fmfbbh_id=11467521;

--1321992
update f_mfb_by_hour set fmfbbh_id=11440530 where fmfbbh_id=1440530;
update f_mfb_by_hour set fmfbbh_id=1440530 where fmfbbh_id=1440550;
update f_mfb_by_hour set fmfbbh_id=1440550 where fmfbbh_id=11440530;

--1330086
update f_mfb_by_hour set fmfbbh_id=11467521 where fmfbbh_id=1467521;
update f_mfb_by_hour set fmfbbh_id=1467521 where fmfbbh_id=1467538;
update f_mfb_by_hour set fmfbbh_id=1467538 where fmfbbh_id=11467521;

--1330088
update f_mfb_by_hour set fmfbbh_id=11467550 where fmfbbh_id=1467550;
update f_mfb_by_hour set fmfbbh_id=1467550 where fmfbbh_id=1467564;
update f_mfb_by_hour set fmfbbh_id=1467564 where fmfbbh_id=11467550;

commit;

alter table f_mfb_by_hour disable row movement;