alter table f_mfb_by_hour enable row movement;
create table f_mfb_by_hour_bak as select * from f_mfb_by_hour;

begin
delete from bpm_update_event_queue where bueq_id in(
25148242,
25143408,
25183007,
25159959,
25174026,
25166019,
25173844,
25183905,
25190162,
25197646,
25202322,
25205712,
25211139,
25216646,
25330410,
25361014,
25365261,
25391579,
25396427,
25400273,
25406229,
25143273,
25148094,
25160836,
25165715,
25173907,
25182853,
25143274,
25148095,
25160837,
25165716,
25173908,
25182854,
25173638,
25183721,
25189338,
25197193,
25201595,
25205317,
25211825,
25213900,
25329283,
25361282,
25364837,
25391966,
25395845,
25400878,
25406518,
25411081,
25420180,
25430681,
25439715,
25443245,
25467892,
25475473,
25481077,
25487958,
25508152,
25511356,
25516853,
25519671,
25536511,
25679394,
25685539,
25691292,
25693220,
25698846,
25704475,
25708962,
25714741,
25720904,
25730603,
25738060,
25750812,
25766781,
25772815,
25779203,
25794221,
25800433,
25806375,
25818417,
25825279,
25970429,
25973880,
25980926,
25984956,
25990533,
25995015,
25998103,
26006130,
26010403,
26020381,
26026352,
26036855,
26042054,
26048221,
26059758,
26069022,
26079668,
26085164,
26091512,
26096096,
26101434,
26256099,
26259116,
26265227,
26270581,
26275365,
26280141,
26285055,
26289125,
26298135,
26304197,
26308213,
26317972,
26322545,
26330345,
26333657,
26339847,
26345430,
26350309,
26355366,
26360903,
26366381,
26514115,
26522757,
26527289,
26531816,
26536705,
26544087,
26546170,
26554655,
26559803,
26562979,
26568923,
26574423,
26579330,
26584556,
26590588,
26595376,
26601614,
26606201,
26612230,
26616916,
26622165,
26726114,
26779895,
26782317,
26788701,
26796058,
26799394,
26805679,
26812451,
26818129,
26822195,
26827821,
26835137,
26839838,
26846620,
26849123,
26857965,
26865491,
26871135,
26876292,
26881286,
26887695,
26935921,
27045673,
27049753,
27055511,
27062076,
27068429,
27077846,
27087142,
27091081,
27108413,
27115281,
27130852,
27136824,
27158736,
25174596,
25183577,
25189298,
25197066,
25201468,
25204843,
25211679,
25213862,
25328815,
25361155,
25365620,
25391821,
25396800,
25400735,
25405346,
25411115,
25420118,
25431675,
25439675,
25443243,
25467890,
25475471,
25482154,
25487956,
25508150,
25511354,
25516851,
25519669,
25536509,
25679392,
25685484,
25691290,
25693218,
25698844,
25704473,
25708960,
25714739,
25720902,
25730601,
25738058,
25750810,
25766779,
25772813,
25779201,
25794219,
25800431,
25806373,
25818415,
25825277,
25970427,
25973878,
25980924,
25984954,
25990531,
25995013,
25998049,
26006128,
26010401,
26020379,
26026350,
26036853,
26042052,
26048219,
26059756,
26069020,
26079610,
26085162,
26091510,
26096094,
26101377,
26256097,
26259062,
26265225,
26270579,
26275363,
26280139,
26285053,
26289123,
26298133,
26304195,
26308155,
26317970,
26322543,
26330343,
26333655,
26339845,
26345428,
26350307,
26355309,
26360901,
26366379,
26514113,
26522755,
26527233,
26531814,
26536703,
26544085,
26546168,
26554653,
26559801,
26562977,
26568921,
26574421,
26579328,
26584554,
26590586,
26595374,
26601612,
26606199,
26612228,
26616914,
26622163,
26725969,
26779893,
26782315,
26788699,
26796056,
26799392,
26805677,
26812449,
26818127,
26822193,
26827819,
26835135,
26839782,
26846618,
26849121,
26857963,
26865489,
26871077,
26876290,
26881284,
26887693,
26935919,
27045671,
27049751,
27055509,
27062074,
27068427,
27077844,
27087140,
27091079,
27108411,
27115279,
27130850,
27136822,
27158734,
25143277,
25148098,
25160898,
25165719,
25173911,
24921624,
25143509,
25173921,
25173655,
25183782,
25173921,
25174589,
25183520,
25189291,
25197059,
25202518,
25204923,
25211618,
25213855,
25328799,
25360023,
25364562,
25390598,
25396740,
25400670,
25174259,
25183810,
25189725,
25196835,
25202344,
25205729,
25210634,
25216670,
25330455,
25361460,
25365441,
25391604,
25397019,
25401209,
25406645,
25414680
);

delete from bpm_update_event_queue where identifier='{6aaf03d4-0e52-4e44-b0de-fa7c1906c73f}';
delete from f_mfb_by_hour where fmfbbh_id=1956929;

update f_mfb_by_hour set bucket_end_date=to_date('02/11/2014 09:00:00 AM','MM/DD/YYYY HH:MI:SS AM') where fmfbbh_id=1956928;
delete from f_mfb_by_hour where fmfbbh_id=1956675;

update f_mfb_by_hour set bucket_end_date=to_date('02/11/2014 09:00:00 AM','MM/DD/YYYY HH:MI:SS AM') where fmfbbh_id=1956670;
delete from f_mfb_by_hour where fmfbbh_id=1956929;

update f_mfb_by_hour set bucket_end_date=to_date('02/11/2014 09:00:00 AM','MM/DD/YYYY HH:MI:SS AM') where fmfbbh_id=1956928;
delete from f_mfb_by_hour where fmfbbh_id in(1962052,1962055,1962058,1962059);

update f_mfb_by_hour set bucket_end_date=to_date('02/11/2014 10:00:00 AM','MM/DD/YYYY HH:MI:SS AM') where fmfbbh_id=1956834;

delete from bpm_update_event_queue where identifier in(
select batch_guid from d_mfb_current where mfb_bi_id in(
1161183,
1161182,
1162047,
1165084
));
delete from f_mfb_by_hour where mfb_bi_id=814043 and fmfbbh_id<>249593;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=814043 and fmfbbh_id=249593;
delete from f_mfb_by_hour where mfb_bi_id=814044 and fmfbbh_id<>249594;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=814044 and fmfbbh_id=249594;
delete from f_mfb_by_hour where mfb_bi_id=814045 and fmfbbh_id<>249595;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=814045 and fmfbbh_id=249595;
delete from f_mfb_by_hour where mfb_bi_id=814046 and fmfbbh_id<>249596;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=814046 and fmfbbh_id=249596;
delete from f_mfb_by_hour where mfb_bi_id=814047 and fmfbbh_id<>249597;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=814047 and fmfbbh_id=249597;
delete from f_mfb_by_hour where mfb_bi_id=814049 and fmfbbh_id<>249599;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=814049 and fmfbbh_id=249599;
delete from f_mfb_by_hour where mfb_bi_id=814050 and fmfbbh_id<>249600;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=814050 and fmfbbh_id=249600;
delete from f_mfb_by_hour where mfb_bi_id=814053 and fmfbbh_id<>249603;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=814053 and fmfbbh_id=249603;
delete from f_mfb_by_hour where mfb_bi_id=860879 and fmfbbh_id<>281588;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=860879 and fmfbbh_id=281588;
delete from f_mfb_by_hour where mfb_bi_id=1156514 and fmfbbh_id<>358924;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1156514 and fmfbbh_id=358924;
delete from f_mfb_by_hour where mfb_bi_id=1156618 and fmfbbh_id<>359235;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1156618 and fmfbbh_id=359235;
delete from f_mfb_by_hour where mfb_bi_id=1156676 and fmfbbh_id<>359310;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1156676 and fmfbbh_id=359310;
delete from f_mfb_by_hour where mfb_bi_id=1156801 and fmfbbh_id<>359191;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1156801 and fmfbbh_id=359191;
delete from f_mfb_by_hour where mfb_bi_id=1156809 and fmfbbh_id<>359207;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1156809 and fmfbbh_id=359207;
delete from f_mfb_by_hour where mfb_bi_id=1156826 and fmfbbh_id<>359234;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1156826 and fmfbbh_id=359234;
delete from f_mfb_by_hour where mfb_bi_id=1160847 and fmfbbh_id<>362050;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1160847 and fmfbbh_id=362050;
delete from f_mfb_by_hour where mfb_bi_id=1160911 and fmfbbh_id<>362114;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1160911 and fmfbbh_id=362114;
delete from f_mfb_by_hour where mfb_bi_id=1160922 and fmfbbh_id<>362125;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1160922 and fmfbbh_id=362125;
delete from f_mfb_by_hour where mfb_bi_id=1161168 and fmfbbh_id<>362353;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1161168 and fmfbbh_id=362353;
delete from f_mfb_by_hour where mfb_bi_id=1161171 and fmfbbh_id<>362355;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1161171 and fmfbbh_id=362355;
delete from f_mfb_by_hour where mfb_bi_id=1303102 and fmfbbh_id<>1337584;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1303102 and fmfbbh_id=1337584;
delete from f_mfb_by_hour where mfb_bi_id=1304841 and fmfbbh_id<>1342462;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1304841 and fmfbbh_id=1342462;
delete from f_mfb_by_hour where mfb_bi_id=1321992 and fmfbbh_id<>1440550;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1321992 and fmfbbh_id=1440550;
delete from f_mfb_by_hour where mfb_bi_id=1330086 and fmfbbh_id<>1467538;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1330086 and fmfbbh_id=1467538;
delete from f_mfb_by_hour where mfb_bi_id=1330088 and fmfbbh_id<>1467564;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1330088 and fmfbbh_id=1467564;
delete from f_mfb_by_hour where mfb_bi_id=1448845 and fmfbbh_id<>1903791;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1448845 and fmfbbh_id=1903791;
delete from f_mfb_by_hour where mfb_bi_id=1460953 and fmfbbh_id<>1913868;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1460953 and fmfbbh_id=1913868;
delete from f_mfb_by_hour where mfb_bi_id=1461520 and fmfbbh_id<>1914737;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1461520 and fmfbbh_id=1914737;
delete from f_mfb_by_hour where mfb_bi_id=1461523 and fmfbbh_id<>1914049;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1461523 and fmfbbh_id=1914049;
delete from f_mfb_by_hour where mfb_bi_id=1461525 and fmfbbh_id<>1914819;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1461525 and fmfbbh_id=1914819;
delete from f_mfb_by_hour where mfb_bi_id=1467291 and fmfbbh_id<>1917682;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1467291 and fmfbbh_id=1917682;
delete from f_mfb_by_hour where mfb_bi_id=1467833 and fmfbbh_id<>1918082;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1467833 and fmfbbh_id=1918082;
delete from f_mfb_by_hour where mfb_bi_id=1467834 and fmfbbh_id<>1918100;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1467834 and fmfbbh_id=1918100;
delete from f_mfb_by_hour where mfb_bi_id=1467836 and fmfbbh_id<>1918101;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1467836 and fmfbbh_id=1918101;
delete from f_mfb_by_hour where mfb_bi_id=1467837 and fmfbbh_id<>1918102;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1467837 and fmfbbh_id=1918102;
delete from f_mfb_by_hour where mfb_bi_id=1467839 and fmfbbh_id<>1918093;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1467839 and fmfbbh_id=1918093;
delete from f_mfb_by_hour where mfb_bi_id=1469429 and fmfbbh_id<>1923878;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1469429 and fmfbbh_id=1923878;
delete from f_mfb_by_hour where mfb_bi_id=1469430 and fmfbbh_id<>1923895;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1469430 and fmfbbh_id=1923895;
delete from f_mfb_by_hour where mfb_bi_id=1470572 and fmfbbh_id<>1923851;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1470572 and fmfbbh_id=1923851;
delete from f_mfb_by_hour where mfb_bi_id=1470581 and fmfbbh_id<>1923932;
update f_mfb_by_hour set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY') where mfb_bi_id=1470581 and fmfbbh_id=1923932;
update f_mfb_by_hour f set bucket_end_date=to_date('07/07/2077','MM/DD/YYYY')
where exists (
select 1 from f_mfb_by_hour f2 where f2.mfb_bi_id=f.mfb_bi_id and f2.creation_count=0 and inventory_count=1 and completion_count=0 and bucket_end_date=to_date('07/07/2077','MM/DD/YYYY'))
and f.creation_count=1;
delete from f_mfb_by_hour where creation_count=0 and inventory_count=1 and completion_count=0 and bucket_end_date=trunc(to_date('07/07/2077','MM/DD/YYYY'));
update BPM_UPDATE_EVENT_QUEUE set PROCESS_BUEQ_ID = null where event_date<trunc(sysdate) and bsl_id=16;
commit;
exception when others then rollback;

END;
/
alter table f_mfb_by_hour disable row movement;
