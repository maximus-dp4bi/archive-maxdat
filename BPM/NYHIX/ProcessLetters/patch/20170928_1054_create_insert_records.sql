create global temporary table temp_corp_pl
on commit preserve rows
as
select * from maxdat.corp_etl_proc_letters
where cepn_id in (845691,
845692,
845693,
845694,
845695,
845696,
845697,
845698,
845699,
845700,
845701,
845702,
845703,
845704,
845705,
845706,
845707,
845708,
845709,
845710);

commit;

delete from maxdat.corp_etl_proc_letters
where cepn_id in (845691,
845692,
845693,
845694,
845695,
845696,
845697,
845698,
845699,
845700,
845701,
845702,
845703,
845704,
845705,
845706,
845707,
845708,
845709,
845710);

commit;

Insert into maxdat.corp_etl_proc_letters
select * from temp_corp_pl;

commit;

truncate table maxdat.temp_corp_pl;

drop table maxdat.temp_corp_pl;

