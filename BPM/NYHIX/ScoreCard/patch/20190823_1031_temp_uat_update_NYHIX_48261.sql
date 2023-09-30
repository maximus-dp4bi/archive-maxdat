-- NYHIX-52066

Alter session set current_schema=dp_scorecard;

update dp_scorecard.sc_summary_cc
set adherence=1
where staff_stAFF_ID IN ( 18760,18822,18826)
and trim(dates_month) in ('April','May','June');

update dp_scorecard.sc_summary_cc
set MONTHLY_CONFORMANCE_FLAG = 0 
where staff_stAFF_ID IN ( 18760)
and trim(dates_month) in ('April','May','June');

update dp_scorecard.sc_summary_cc
set MONTHLY_CONFORMANCE_FLAG = 1 
where staff_stAFF_ID IN ( 18822,18826)
and trim(dates_month) in ('April','May','June');


update dp_scorecard.sc_summary_cc
set adherence = .992 ,MONTHLY_CONFORMANCE_FLAG =1
where staff_stAFF_ID IN ( 18345,18585,18590 )
and trim(dates_month) in ('April','May','June');

update dp_scorecard.sc_summary_cc
set THREE_MONTH_ADHERENCE_FLAG  = 4
where staff_stAFF_ID IN ( 18345,18585,18590)
and trim(dates_month) in ('June');

update dp_scorecard.scorecard_hierarchy
set hire_date='01-Aug-2019'
where staff_staff_id in (18925	,
18925	,
18925	,
19024	,
18746	,
18805	,
18828	,
18836	,
18537	,
18556	,
18583	,
18686	
);

commit;

update dp_scorecard.scorecard_hierarchy
set hire_date='01-Aug-2019'
where staff_staff_id in (18836	,
18925	,
19024	,
19024	,
19024	,
18896	,
18896	,
18896	,
18896	,
18942	,
18950	,
18950	,
18950	,
19034	,
19034	,
19034	,
18563	,
18565	,
18565	,
18565	,
18590	
);

update dp_scorecard.sc_summary_cc
set MONTHLY_CONFORMANCE_FLAG =0
where staff_stAFF_ID IN ( 18345 )
and trim(dates_month) in ('April','May','June');

update dp_scorecard.sc_summary_cc
set THREE_MONTH_ADHERENCE_flag=5
where staff_natid in ( 252467,252694,252497)
and trim(dates_month) in ('June');

update  DP_SCORECARD.SC_SUMMARY_CC
set avg_qc_score = .935, 
tot_incidents_completed = 58 
where dates_month_num = '201904'
and staff_staff_id = 1519;



update dp_scorecard.sc_summary_bo
set metric = .964
where dates_month_num = '201904'
and staff_id = 1519
and event_name = 'Monthly Adherence';

commit; 

-- MONTHLY_CONFORMANCE_FLAG,TOT_INCIDENTS_COMPLETED,TOT_DEFECTS_COMPLETED,AVG_QC_SCORE,DATES_MONTH_NUM,STAFF_NATID
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 1,tot_incidents_completed  = 58	, 	tot_defects_completed = 2,		AVG_QC_SCORE = 0.935			where dates_month_num = 201904 and staff_natid = 59735;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 1,tot_incidents_completed  = 2738	,	tot_defects_completed = null,	AVG_QC_SCORE = 99.00041667		where dates_month_num = 201904 and staff_natid = 67486;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 1,tot_incidents_completed  = 1863	,	tot_defects_completed = 5,		AVG_QC_SCORE = 97.85954545		where dates_month_num = 201904 and staff_natid = 68409;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 1,tot_incidents_completed  = 2263	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 99.0592			where dates_month_num = 201904 and staff_natid = 59868;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 1,tot_incidents_completed  = 933	,	tot_defects_completed = 466,	AVG_QC_SCORE = 60				where dates_month_num = 201904 and staff_natid = 65207;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 1,tot_incidents_completed  = 1		,	tot_defects_completed = 1,		AVG_QC_SCORE = 98.824			where dates_month_num = 201904 and staff_natid = 66196;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 1,tot_incidents_completed  = 942	,	tot_defects_completed = 540,	AVG_QC_SCORE = 93.5			where dates_month_num = 201904 and staff_natid = 67228;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 1,tot_incidents_completed  = 1		,	tot_defects_completed = 1,		AVG_QC_SCORE = 98.5888			where dates_month_num = 201904 and staff_natid = 69629;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 1,tot_incidents_completed  = 63	,	tot_defects_completed = 2180,	AVG_QC_SCORE = 98.89931034		where dates_month_num = 201904 and staff_natid = 74966;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 1,tot_incidents_completed  = 348	,	tot_defects_completed = 2058,	AVG_QC_SCORE = 99.804			where dates_month_num = 201904 and staff_natid = 75670;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 1,tot_incidents_completed  = 1422	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 98.46608696		where dates_month_num = 201904 and staff_natid = 63312;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 1,tot_incidents_completed  = 1476	,	tot_defects_completed = 2,		AVG_QC_SCORE = 98.1184			where dates_month_num = 201904 and staff_natid = 94855;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 1,tot_incidents_completed  = 1314	,	tot_defects_completed = 15,		AVG_QC_SCORE = 99.412			where dates_month_num = 201904 and staff_natid = 65195;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1062	,	tot_defects_completed = 1,		AVG_QC_SCORE = 99.706			where dates_month_num = 201904 and staff_natid = 103838;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1501	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 99.444			where dates_month_num = 201904 and staff_natid = 105414;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1516	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 99.74727273		where dates_month_num = 201904 and staff_natid = 130361;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 2279	,	tot_defects_completed = 2,		AVG_QC_SCORE = 90				where dates_month_num = 201904 and staff_natid = 82870;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1		,	tot_defects_completed = 1,		AVG_QC_SCORE = 100				where dates_month_num = 201904 and staff_natid = 105390;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1		,	tot_defects_completed = 1,		AVG_QC_SCORE = 80				where dates_month_num = 201904 and staff_natid = 110866;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 371	,	tot_defects_completed = 2166,	AVG_QC_SCORE = 99.11366667		where dates_month_num = 201904 and staff_natid = 122527;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1		,	tot_defects_completed = 1,		AVG_QC_SCORE = 65				where dates_month_num = 201904 and staff_natid = 146674;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1451	,	tot_defects_completed = 77,		AVG_QC_SCORE = 99.2944			where dates_month_num = 201904 and staff_natid = 75898;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 0,tot_incidents_completed  = 1565	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 99.2944			where dates_month_num = 201904 and staff_natid = 102990;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 0,tot_incidents_completed  = 1880	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 99.51652174		where dates_month_num = 201904 and staff_natid = 105447;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 0,tot_incidents_completed  = 1926	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 99.7648			where dates_month_num = 201904 and staff_natid = 110889;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 0,tot_incidents_completed  = 2413	,	tot_defects_completed = 6,		AVG_QC_SCORE = 30				where dates_month_num = 201904 and staff_natid = 114605;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 0,tot_incidents_completed  = 1		, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 99.03333333		where dates_month_num = 201904 and staff_natid = 118025;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 0,tot_incidents_completed  = 1368	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 99.21272727		where dates_month_num = 201904 and staff_natid = 77663;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = null	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = NULL			where dates_month_num = 201904 and staff_natid = 93801;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 0,tot_incidents_completed  = 1709	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 40				where dates_month_num = 201904 and staff_natid = 94846;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 0,tot_incidents_completed  = 1		, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 80				where dates_month_num = 201904 and staff_natid = 114838;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 0,tot_incidents_completed  = 37	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 98.41090909		where dates_month_num = 201904 and staff_natid = 139116;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1564	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 99.2944			where dates_month_num = 201904 and staff_natid = 140750;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1271	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 99.2944			where dates_month_num = 201904 and staff_natid = 140765;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1696	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 99.51			where dates_month_num = 201904 and staff_natid = 85145;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1663	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 98.285			where dates_month_num = 201904 and staff_natid = 85162;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 2548	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 99.7648			where dates_month_num = 201904 and staff_natid = 87329;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1490	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 98.285			where dates_month_num = 201904 and staff_natid = 103368;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1896	,	tot_defects_completed = 4,		AVG_QC_SCORE = 99.755			where dates_month_num = 201904 and staff_natid = 105569;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1965	,	tot_defects_completed = 1,		AVG_QC_SCORE = 99.265			where dates_month_num = 201904 and staff_natid = 112700;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1807	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 98.98708333		where dates_month_num = 201904 and staff_natid = 112791;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1770	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 99.04666667		where dates_month_num = 201904 and staff_natid = 114089;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1849	, 	tot_defects_completed = NULL,	AVG_QC_SCORE = 97.3752			where dates_month_num = 201904 and staff_natid = 76373;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1017	,	tot_defects_completed = 1,		AVG_QC_SCORE = 98.824			where dates_month_num = 201904 and staff_natid = 76386;
update dp_scorecard.sc_summary_cc set monthly_conformance_flag = 2,tot_incidents_completed  = 1993	,	tot_defects_completed = 4,		AVG_QC_SCORE = 99.03333333		where dates_month_num = 201904 and staff_natid = 85168;

commit;

update dp_scorecard.sc_summary_bo set metric = 0.964		where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 59735);
update dp_scorecard.sc_summary_bo set metric = 0.996771833	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 67486);
update dp_scorecard.sc_summary_bo set metric = 0.976485991	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 68409);
update dp_scorecard.sc_summary_bo set metric = 0.96			where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 59868);
update dp_scorecard.sc_summary_bo set metric = 0.996423231	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 65207);
update dp_scorecard.sc_summary_bo set metric = 0.982343653	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 66196);
update dp_scorecard.sc_summary_bo set metric = 0.96			where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 67228);
update dp_scorecard.sc_summary_bo set metric = 0.96			where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 69629);
update dp_scorecard.sc_summary_bo set metric = 1.013462133	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 74966);
update dp_scorecard.sc_summary_bo set metric = 1.009477868	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 75670);
update dp_scorecard.sc_summary_bo set metric = 0.999620362	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 63312);
update dp_scorecard.sc_summary_bo set metric = 0.99294201	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 94855);
update dp_scorecard.sc_summary_bo set metric = 0.998848455	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 65195);
update dp_scorecard.sc_summary_bo set metric = 0.996014348	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 103838);
update dp_scorecard.sc_summary_bo set metric = 1.002371685	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 105414);
update dp_scorecard.sc_summary_bo set metric = 0.96			where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 130361);
update dp_scorecard.sc_summary_bo set metric = 1.015200913	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 82870);
update dp_scorecard.sc_summary_bo set metric = 0.977695687	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 105390);
update dp_scorecard.sc_summary_bo set metric = 1.006295915	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 110866);
update dp_scorecard.sc_summary_bo set metric = 0.7			where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 122527);
update dp_scorecard.sc_summary_bo set metric = 0.27			where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 146674);
update dp_scorecard.sc_summary_bo set metric = 0.995068195	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 75898);
update dp_scorecard.sc_summary_bo set metric = 0.996444924	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 102990);
update dp_scorecard.sc_summary_bo set metric = 1.000563266	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 105447);
update dp_scorecard.sc_summary_bo set metric = 0.6			where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 110889);
update dp_scorecard.sc_summary_bo set metric = 1.003707895	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 114605);
update dp_scorecard.sc_summary_bo set metric = 1.001457369	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 118025);
update dp_scorecard.sc_summary_bo set metric = 0.7	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 77663);
update dp_scorecard.sc_summary_bo set metric = 0.990196416	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 93801);
update dp_scorecard.sc_summary_bo set metric = 0.75			where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 94846);
update dp_scorecard.sc_summary_bo set metric = 0.88			where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 114838);
update dp_scorecard.sc_summary_bo set metric = 0.9			where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 139116);
update dp_scorecard.sc_summary_bo set metric = 1.002816562	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 140750);
update dp_scorecard.sc_summary_bo set metric = 0.976767006	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 140765);
update dp_scorecard.sc_summary_bo set metric = 1.004994248	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 85145);
update dp_scorecard.sc_summary_bo set metric = 0.994507164	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 85162);
update dp_scorecard.sc_summary_bo set metric = 1.000893298	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 87329);
update dp_scorecard.sc_summary_bo set metric = 0.997347502	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 103368);
update dp_scorecard.sc_summary_bo set metric = 0.998874111	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 105569);
update dp_scorecard.sc_summary_bo set metric = 0.993567853	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 112700);
update dp_scorecard.sc_summary_bo set metric = 1.000598514	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 112791);
update dp_scorecard.sc_summary_bo set metric = 0.990990879	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 114089);
update dp_scorecard.sc_summary_bo set metric = 1.000428437	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 76373);
update dp_scorecard.sc_summary_bo set metric = 0.987334272	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 76386);
update dp_scorecard.sc_summary_bo set metric = 0.998159603	where EVENT_NAME = 'Monthly Adherence' and event_subname is null and dates_month_num  = '201904' and staff_id = ( select staff_staff_id from dp_scorecard.scorecard_hierarchy where staff_natid = 85168);

commit;

COMMIT;




