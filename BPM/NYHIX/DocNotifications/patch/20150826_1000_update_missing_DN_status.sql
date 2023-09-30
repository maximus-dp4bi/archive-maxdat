-- Update missing MAXDAT DN Status from MAXe records NYHIX-17163

Update NYHIX_ETL_DOC_NOTIFICATIONS
set STATUS = 'Invalid Document',
 STATUS_CD = 'INVALID_DOC'
where DOC_NOTIFICATION_ID in (
1099241,
1099242,
1099253,
1099255,
1099256,
1099257,
1448553,
1464600,
1513316,
1614025,
1614061,
1614062,
1772072,
1772073,
1772092,
1772094,
1803708,
1803709,
1803733,
1803736,
1803742,
2084580,
2252830,
2265217,
2265219,
2292236,
2310513,
2310613,
2324847,
2324848,
2324849,
2324850,
2324868,
2324869,
2324870,
2324871,
2324872,
2324873,
2324874,
2324875,
2325563,
2327107,
2327109,
2327627,
2365706,
2396192,
2417719,
2429002,
2429041,
2429078,
2429657,
2440786,
2458456,
2469468,
2476130,
2491607,
2566835,
2568874,
2569211,
2597624);

Update NYHIX_ETL_DOC_NOTIFICATIONS
set STATUS = 'No Verification Required',
 STATUS_CD = 'NO_VERIF_REQUIRED'
where DOC_NOTIFICATION_ID in (
1037563,
1578689,
1633704,
1735112,
1760103,
1883971,
1907376,
1907377,
1969208,
1991486,
1997504,
1999735,
2007315,
2031763,
2032478,
2083897,
2083899,
2083921,
2133289,
2133837,
2133838,
2133850,
2133903,
2133908,
2133911,
2178400,
2243249,
2260052,
2260351,
2284936,
2284939,
2284940,
2284948,
2284962,
2284965,
2290458,
2290459,
2290460,
2290479,
2295719,
2295727,
2301319,
2337406,
2341806,
2341815,
2341902,
2354187,
2354210,
2364985,
2366542,
2369164,
2373898,
2376529,
2376536,
2396179,
2396188,
2396193,
2426560,
2432513,
2432514,
2440621,
2440648,
2440655,
2440657,
2440662,
2440665,
2440671,
2469451,
2469474,
2469477,
2476199,
2476202,
2477089,
2500847,
2555380,
2555394,
2555413,
2555422,
2555426,
2555446,
2555464,
2568477,
2568478,
2568479,
2568480,
2568481,
2568482,
2568493,
2568494,
2568495,
2568496,
2568497,
2579189,
2579509);

Update NYHIX_ETL_DOC_NOTIFICATIONS
set STATUS = 'Verificatoin Complete',
 STATUS_CD = 'VERIF_COMPLETE'
where DOC_NOTIFICATION_ID in (
1450231,
1811269,
1827868,
1828071,
1947036,
1997690,
2014597,
2023599,
2138718,
2138720,
2201659,
2262058,
2262070,
2300359,
2300382,
2315615,
2326571,
2389205,
2390971,
2390993,
2390994,
2390996,
2391014,
2391046,
2391048,
2391107,
2395201,
2395202,
2398618,
2407933,
2411186,
2411187,
2411188,
2411190,
2411192,
2411600,
2411609,
2412188,
2412189,
2426691,
2434759,
2434776,
2437820,
2439273,
2461091,
2462086,
2462087,
2464955,
2515041,
2532606,
2532632,
2544464);
