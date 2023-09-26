-- Fix create and complete dates for Kofax batch records in Semantic tables.

-- Repair fact table completions that failed dure to occurring in same batch hour as creation.

/*  Get FMFBBH_IDs for affected batch facts.
select * from F_MFB_BY_HOUR where MFB_BI_ID in (15766109,15767646,15770022,15765475,15766533,15769911,15770157);
*/

update F_MFB_BY_HOUR set D_DATE = to_date('2015-03-19 08:59:31','YYYY-MM-DD HH24:MI:SS'), COMPLETION_COUNT = 1 where FMFBBH_ID = 3900211 and MFB_BI_ID = 15766109;
update F_MFB_BY_HOUR set D_DATE = to_date('2015-03-17 10:44:23','YYYY-MM-DD HH24:MI:SS'), COMPLETION_COUNT = 1 where FMFBBH_ID = 3901648 and MFB_BI_ID = 15767646;
update F_MFB_BY_HOUR set D_DATE = to_date('2015-03-18 18:54:08','YYYY-MM-DD HH24:MI:SS'), COMPLETION_COUNT = 1 where FMFBBH_ID = 3902191 and MFB_BI_ID = 15770022;
update F_MFB_BY_HOUR set D_DATE = to_date('2015-03-17 08:59:32','YYYY-MM-DD HH24:MI:SS'), COMPLETION_COUNT = 1 where FMFBBH_ID = 3903597 and MFB_BI_ID = 15765475;
update F_MFB_BY_HOUR set D_DATE = to_date('2015-03-17 10:39:28','YYYY-MM-DD HH24:MI:SS'), COMPLETION_COUNT = 1 where FMFBBH_ID = 3903646 and MFB_BI_ID = 15766533;
update F_MFB_BY_HOUR set D_DATE = to_date('2015-03-19 13:48:23','YYYY-MM-DD HH24:MI:SS'), COMPLETION_COUNT = 1 where FMFBBH_ID = 3905397 and MFB_BI_ID = 15769911;
update F_MFB_BY_HOUR set D_DATE = to_date('2015-03-19 13:58:53','YYYY-MM-DD HH24:MI:SS'), COMPLETION_COUNT = 1 where FMFBBH_ID = 3907337 and MFB_BI_ID = 15770157;

commit;
