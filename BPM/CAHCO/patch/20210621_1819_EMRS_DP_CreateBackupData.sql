alter session set current_schema = MAXDAT;

-- TAKE THE BACKUP FOR EMRS_D_ADDRESS
-- FOR FIRST 1000 ADDRESS ID's

CREATE TABLE EMRS_D_ADDRESS_BKUP_20210624
AS SELECT * FROM EMRS_D_ADDRESS
WHERE ADDRESS_ID IN (
22493456,22628764,23482046,23482047,23482053,23482054,23482055,23482056,23482098,23482099,
23482117,23482118,23482189,23482190,23482206,23482207,23482208,23482209,23482217,23482218,
23482223,23482224,23482226,23482227,23482230,23482231,23482235,23482236,23482237,23482238,
23482241,23482242,23482243,23482244,23482250,23482251,23482252,23482253,23482254,23482255,
23482258,23482259,23482267,23482268,23482269,23482270,23482271,23482272,23482320,23482321,
23482349,23482350,23482414,23482415,23482442,23482443,23482444,23482445,23482448,23482449,
23482472,23482473,23482475,23482476,23482477,23482478,23482479,23482480,23482481,23482482,
23482483,23482484,23482494,23482495,23482508,23482509,23482559,23482560,23482561,23482562,
23482563,23482564,23482565,23482566,23482567,23482568,23482573,23482574,23482580,23482581,
23482587,23482588,23482589,23482590,23482592,23482593,23482595,23482596,23482597,23482598,
23482599,23482600,23482601,23482602,23482603,23482604,23482605,23482606,23482607,23482608,
23482609,23482610,23482611,23482612,23482613,23482614,23482616,23482617,23482621,23482622,
23482623,23482624,23482625,23482626,23482627,23482628,23482629,23482630,23482631,23482632,
23482638,23482639,23482643,23482644,23482646,23482647,23482684,23482685,23482689,23482690,
23482691,23482692,23482694,23482695,23482698,23482699,23482700,23482701,23482702,23482703,
23482704,23482705,23482706,23482707,23482708,23482709,23482710,23482711,23482712,23482713,
23482715,23482716,23482717,23482718,23482721,23482722,23482724,23482725,23482727,23482728,
23482731,23482732,23482733,23482734,23482735,23482736,23482738,23482739,23482740,23482741,
23482742,23482743,23482744,23482745,23482746,23482747,23482748,23482749,23482750,23482751,
23482753,23482754,23482756,23482757,23482758,23482759,23482786,23482787,23482828,23482829,
23482833,23482834,23482845,23482846,23482862,23482863,23482875,23482876,23482883,23482884,
23482893,23482894,23482896,23482897,23482898,23482899,23482911,23482912,23482977,23482978,
23482980,23482981,23482982,23482983,23482987,23482988,23482990,23482991,23482992,23482993,
23482995,23482996,23482997,23482998,23482999,23483000,23483001,23483002,23483005,23483006,
23483013,23483014,23483015,23483016,23483017,23483018,23483019,23483020,23483032,23483033,
23483034,23483035,23483041,23483042,23483043,23483044,23483045,23483046,23483055,23483056,
23483064,23483065,23483073,23483074,23483079,23483080,23483084,23483085,23483108,23483109,
23483113,23483114,23483121,23483122,23483123,23483124,23483126,23483127,23483130,23483131,
23483132,23483133,23483135,23483136,23483138,23483139,23483140,23483141,23483142,23483143,
23483145,23483146,23483147,23483148,23483149,23483150,23483155,23483156,23483158,23483159,
23483160,23483161,23483163,23483164,23483167,23483168,23483172,23483173,23483178,23483179,
23483181,23483182,23483183,23483184,23483186,23483187,23483188,23483189,23483192,23483193,
23483195,23483196,23483199,23483200,23483201,23483202,23483203,23483204,23483205,23483206,
23483207,23483208,23483211,23483212,23483213,23483214,23483215,23483216,23483217,23483218,
23483219,23483220,23483221,23483222,23483224,23483225,23483227,23483228,23483232,23483233,
23483238,23483239,23483240,23483241,23483242,23483243,23483244,23483245,23483247,23483248,
23483250,23483251,23483256,23483257,23483259,23483260,23483262,23483263,23483264,23483265,
23483266,23483267,23483268,23483269,23483270,23483271,23483280,23483281,23483291,23483292,
23483293,23483294,23483296,23483297,23483301,23483302,23483305,23483306,23483310,23483311,
23483314,23483315,23483326,23483327,23483332,23483333,23483347,23483348,23483361,23483362,
23483368,23483369,23483377,23483378,23483379,23483380,23483383,23483384,23483389,23483390,
23483395,23483396,23483397,23483398,23483401,23483402,23483403,23483404,23483407,23483408,
23483409,23483410,23483411,23483412,23483417,23483418,23483419,23483420,23483421,23483422,
23483428,23483429,23483430,23483431,23483432,23483433,23483434,23483435,23483438,23483439,
23483440,23483441,23483442,23483443,23483445,23483446,23483454,23483455,23483456,23483457,
23483458,23483459,23483464,23483465,23483468,23483469,23483470,23483524,23483525,23483526,
23483527,23483528,23483529,23483537,23483538,23483539,23483540,23483541,23483542,23483543,
23483544,23483545,23483549,23483550,23483551,23483552,23483561,23483562,23483564,23483565,
23483567,23483568,23483569,23483570,23483571,23483572,23483573,23483574,23483575,23483576,
23483577,23483578,23483579,23483580,23483581,23483582,23483583,23483584,23483587,23483588,
23483589,23483590,23483591,23483592,23483594,23483595,23483596,23483597,23483598,23483599,
23483600,23483601,23483602,23483603,23483604,23483605,23483606,23483607,23483608,23483609,
23483610,23483611,23483612,23483613,23483614,23483615,23483616,23483617,23483618,23483619,
23483620,23483621,23483622,23483623,23483624,23483625,23483627,23483628,23483631,23483632,
23483634,23483635,23483636,23483637,23483640,23483641,23483642,23483643,23483646,23483647,
23483648,23483649,23483652,23483653,23483659,23483660,23483661,23483662,23483664,23483665,
23483666,23483667,23483668,23483669,23483670,23483671,23483672,23483673,23483674,23483675,
23483676,23483677,23483679,23483680,23483681,23483682,23483683,23483684,23483685,23483686,
23483708,23483709,23483723,23483724,23483728,23483729,23483765,23483766,23483774,23483775,
23483790,23483791,23483812,23483813,23483815,23483816,23483820,23483821,23483836,23483837,
23483848,23483849,23483857,23483858,23483884,23483885,23483911,23483912,23483950,23483951,
23483975,23483976,23483992,23483993,23484001,23484002,23484041,23484042,23484053,23484054,
23484059,23484060,23484064,23484065,23484067,23484068,23484081,23484082,23484088,23484089,
23484103,23484104,23484124,23484125,23484128,23484129,23484130,23484131,23484139,23484140,
23484141,23484142,23484143,23484144,23484154,23484155,23484156,23484157,23484158,23484159,
23484169,23484170,23484171,23484172,23484173,23484174,23484178,23484179,23484180,23484181,
23484196,23484197,23484198,23484199,23484200,23484201,23484202,23484203,23484204,23484205,
23484206,23484207,23484208,23484209,23484211,23484212,23484213,23484214,23484215,23484216,
23484217,23484218,23484219,23484220,23484221,23484222,23484223,23484224,23484225,23484226,
23484227,23484228,23484229,23484230,23484231,23484232,23484233,23484234,23484235,23484236,
23484237,23484238,23484285,23484286,23484287,23484288,23484305,23484306,23484307,23484308,
23484309,23484310,23484311,23484312,23484313,23484314,23484315,23484316,23484342,23484343,
23484344,23484345,23484351,23484352,23484436,23484437,23484529,23484530,23484531,23484532,
23484536,23484537,23484540,23484541,23484543,23484544,23484547,23484548,23484550,23484551,
23484553,23484554,23484555,23484556,23484557,23484558,23484559,23484560,23484564,23484565,
23484567,23484568,23484570,23484571,23484573,23484574,23484575,23484576,23484578,23484579,
23484581,23484582,23484586,23484587,23484597,23484598,23484599,23484600,23484601,23484602,
23484604,23484605,23484639,23484640,23484651,23484652,23484653,23484654,23484658,23484659,
23484665,23484666,23484671,23484672,23484673,23484674,23484675,23484676,23484715,23484716,
23484718,23484719,23484722,23484723,23484724,23484725,23484726,23484727,23484728,23484729,
23484730,23484731,23484732,23484733,23484734,23484735,23484736,23484737,23484738,23484739,
23484742,23484743,23484747,23484748,23484749,23484750,23484751,23484752,23484753,23484754,
23484755,23484756,23484758,23484759,23484760,23484761,23484762,23484763,23484764,23484765,
23484766,23484767,23484769,23484770,23484771,23484772,23484773,23484774,23484775,23484776,
23484777,23484778,23484779,23484780,23484783,23484784,23484785,23484786,23484787,23484788,
23484789,23484790,23484791,23484792,23484793,23484794,23484797,23484798,23484802,23484803,
23484814,23484815,23484816,23484817,23484818,23484819,23484820,23484821,23484822,23484823,
23484824,23484825,23484826,23484827,23484923,23484924,23484942,23484943,23484949,23484954,
23484956,23484977,23484999,23485089,23485093,23485095,23485106,23485121,23485123,23485125,
23485132,23485134,23485139,23485141,23485143,23485145,23485147,23485149,23485152,23485154,
23485156,23485200,23485237,23485283,23485290,23485292,23485294,23485300,23485315,23485322,
23485336,23485338,23485340,23485347,23485415,23485417,23485419,23485421,23485423,23485425,
23485427,23485429,23485431,23485433,23485435,23485437,23485439,23485441,23485446,23485452,
23485454,23485457,23485459,23485461,23485473,23485476,23485481,23485486,23485491,23485502,
23485504,23485600,23485602,23485604,23485649,23485700,23485715,23485723,23485732,23485737,
23485739,23485741,23485744,23485746,23485748,23485788,23485955,23485957,23485959,23485961,
23485964,23485972,23485975,23485979,23485985,23485989,23485993,23486001,23486003,23486011,
23486013,23486016,23486021,23486025,23486027,23486030,23486038,23486045,23486048,23486054,
23486057,23486059,23486061,23486075,23486091,23486100,23486121,23486136,23486138,23486140,
23486143,23486148,23486150,23486152,23486154,23486156,23486159,23486161,23486164,23486168);

-- TAKE THE BACKUP FOR EMRS_D_ADDRESS
-- FOR THE REMAINING ADDRESS ID's

INSERT INTO EMRS_D_ADDRESS_BKUP_20210624
SELECT * FROM EMRS_D_ADDRESS
WHERE ADDRESS_ID IN (
23486172,23486175,23486182,23486187,23486189,23486191,23486195,23486199,23486201,23486205,
23486208,23486210,23486212,23486215,23486220,23486222,23486224,23486227,23486234,23486238,
23486242,23486247,23486252,23486254,23486256,23486263,23486268,23486273,23486275,23486282,
23486284,23486286,23486290,23486295,23486300,23486304,23486308,23486314,23486317,23486319,
23486323,23486329,23486331,23486334,23486337,23486339,23486341,23486343,23486346,23486348,
23486350,23486353,23486360,23486362,23486370,23486376,23486378,23486380,23486386,23486391,
23486393,23486398,23486400,23486402,23486404,23486406,23486408,23486410,23486413,23486431,
23486434,23486437,23486441,23486443,23486447,23486454,23486465,23486469,23486477,23486491,
23486499,23486529,23486552,23486558,23486566,23486576,23486583,23486588,23486590,23486600,
23486602,23486604,23486623,23486625,23486628,23486640,23486642,23486655,23486657,23486666,
23486671,23486674,23486677,23486712,23486714,23486717,23486737,23486741,23486744,23486746,
23486750,23486752,23486754,23486780,23486783,23486785,23486787,23486791,23486793,23486795,
23486797,23486800,23486808,23486810,23486822,23486824,23486826,23486828,23486830,23486832,
23486834,23486836,23486838,23486840,23486842,23486844,23486846,23486848,23486850,23486852,
23486854,23486856,23486858,23486861,23486863,23486872,23486874,23486877,23486879,23486883,
23486885,23486887,23486890,23486892,23486894,23486896,23486899,23486901,23486903,23486905,
23486907,23486909,23486913,23486915,23486920,23486922,23486924,23486938,23486946,23486949,
23486970,23486977,23486988,23487004,23487009,23487012,23487022,23487026,23487030,23487054,
23487075,23487097,23487108,23487113,23487118,23487143,23487146,23487148,23487151,23487153,
23487158,23487165,23487172,23487187,23487189,23487199,23487206,23487208,23487211,23487222,
23487224,23487230,23487232,23487234,23487236,23487241,23487243,23487258,23487260,23487262,
23487264,23487267,23487269,23487271,23487274,23487276,23487279,23487281,23487283,23487285,
23487287,23487291,23487298,23487300,23487302,23487304,23487313,23487316,23487328,23487330,
23487370,23487373,23487409,23487411,23487420,23487441,23487478,23487480,23487493,23487525,
23487562,23487576,23487587,23487590,23487592,23487609,23487612,23487615,23487617,23487619,
23487621,23487631,23487633,23487636,23487646,23487648,23487650,23487654,23487662,23487693,
23487695,23487697,23487728,23487737,23487750,23487759,23487773,23487796,23487826,23487828,
23487835,23487866,23487873,23487879,23487881,23487883,23487885,23487887,23487890,23487894,
23487896,23487898,23487904,23487907,23487910,23487912,23487915,23487917,23487923,23487925,
23487927,23487934,23487937,23487939,23487941,23487944,23487946,23487948,23487950,23487952,
23487954,23487957,23487959,23487964,23487966,23487969,23487976,23487989,23487993,23488005,
23488017,23488019,23488021,23488023,23488100,23488156);

-- TAKE THE BACKUP FOR EMRS_D_PHONE
-- FOR FIRST 1000 PHONE ID's

CREATE TABLE EMRS_D_PHONE_BKUP_20210624
AS SELECT * FROM EMRS_D_PHONE
WHERE PHONE_ID IN (
22493456,22628764,23482046,23482047,23482053,23482054,23482055,23482056,23482098,23482099,
23482117,23482118,23482189,23482190,23482206,23482207,23482208,23482209,23482217,23482218,
23482223,23482224,23482226,23482227,23482230,23482231,23482235,23482236,23482237,23482238,
23482241,23482242,23482243,23482244,23482250,23482251,23482252,23482253,23482254,23482255,
23482258,23482259,23482267,23482268,23482269,23482270,23482271,23482272,23482320,23482321,
23482349,23482350,23482414,23482415,23482442,23482443,23482444,23482445,23482448,23482449,
23482472,23482473,23482475,23482476,23482477,23482478,23482479,23482480,23482481,23482482,
23482483,23482484,23482494,23482495,23482508,23482509,23482559,23482560,23482561,23482562,
23482563,23482564,23482565,23482566,23482567,23482568,23482573,23482574,23482580,23482581,
23482587,23482588,23482589,23482590,23482592,23482593,23482595,23482596,23482597,23482598,
23482599,23482600,23482601,23482602,23482603,23482604,23482605,23482606,23482607,23482608,
23482609,23482610,23482611,23482612,23482613,23482614,23482616,23482617,23482621,23482622,
23482623,23482624,23482625,23482626,23482627,23482628,23482629,23482630,23482631,23482632,
23482638,23482639,23482643,23482644,23482646,23482647,23482684,23482685,23482689,23482690,
23482691,23482692,23482694,23482695,23482698,23482699,23482700,23482701,23482702,23482703,
23482704,23482705,23482706,23482707,23482708,23482709,23482710,23482711,23482712,23482713,
23482715,23482716,23482717,23482718,23482721,23482722,23482724,23482725,23482727,23482728,
23482731,23482732,23482733,23482734,23482735,23482736,23482738,23482739,23482740,23482741,
23482742,23482743,23482744,23482745,23482746,23482747,23482748,23482749,23482750,23482751,
23482753,23482754,23482756,23482757,23482758,23482759,23482786,23482787,23482828,23482829,
23482833,23482834,23482845,23482846,23482862,23482863,23482875,23482876,23482883,23482884,
23482893,23482894,23482896,23482897,23482898,23482899,23482911,23482912,23482977,23482978,
23482980,23482981,23482982,23482983,23482987,23482988,23482990,23482991,23482992,23482993,
23482995,23482996,23482997,23482998,23482999,23483000,23483001,23483002,23483005,23483006,
23483013,23483014,23483015,23483016,23483017,23483018,23483019,23483020,23483032,23483033,
23483034,23483035,23483041,23483042,23483043,23483044,23483045,23483046,23483055,23483056,
23483064,23483065,23483073,23483074,23483079,23483080,23483084,23483085,23483108,23483109,
23483113,23483114,23483121,23483122,23483123,23483124,23483126,23483127,23483130,23483131,
23483132,23483133,23483135,23483136,23483138,23483139,23483140,23483141,23483142,23483143,
23483145,23483146,23483147,23483148,23483149,23483150,23483155,23483156,23483158,23483159,
23483160,23483161,23483163,23483164,23483167,23483168,23483172,23483173,23483178,23483179,
23483181,23483182,23483183,23483184,23483186,23483187,23483188,23483189,23483192,23483193,
23483195,23483196,23483199,23483200,23483201,23483202,23483203,23483204,23483205,23483206,
23483207,23483208,23483211,23483212,23483213,23483214,23483215,23483216,23483217,23483218,
23483219,23483220,23483221,23483222,23483224,23483225,23483227,23483228,23483232,23483233,
23483238,23483239,23483240,23483241,23483242,23483243,23483244,23483245,23483247,23483248,
23483250,23483251,23483256,23483257,23483259,23483260,23483262,23483263,23483264,23483265,
23483266,23483267,23483268,23483269,23483270,23483271,23483280,23483281,23483291,23483292,
23483293,23483294,23483296,23483297,23483301,23483302,23483305,23483306,23483310,23483311,
23483314,23483315,23483326,23483327,23483332,23483333,23483347,23483348,23483361,23483362,
23483368,23483369,23483377,23483378,23483379,23483380,23483383,23483384,23483389,23483390,
23483395,23483396,23483397,23483398,23483401,23483402,23483403,23483404,23483407,23483408,
23483409,23483410,23483411,23483412,23483417,23483418,23483419,23483420,23483421,23483422,
23483428,23483429,23483430,23483431,23483432,23483433,23483434,23483435,23483438,23483439,
23483440,23483441,23483442,23483443,23483445,23483446,23483454,23483455,23483456,23483457,
23483458,23483459,23483464,23483465,23483468,23483469,23483470,23483524,23483525,23483526,
23483527,23483528,23483529,23483537,23483538,23483539,23483540,23483541,23483542,23483543,
23483544,23483545,23483549,23483550,23483551,23483552,23483561,23483562,23483564,23483565,
23483567,23483568,23483569,23483570,23483571,23483572,23483573,23483574,23483575,23483576,
23483577,23483578,23483579,23483580,23483581,23483582,23483583,23483584,23483587,23483588,
23483589,23483590,23483591,23483592,23483594,23483595,23483596,23483597,23483598,23483599,
23483600,23483601,23483602,23483603,23483604,23483605,23483606,23483607,23483608,23483609,
23483610,23483611,23483612,23483613,23483614,23483615,23483616,23483617,23483618,23483619,
23483620,23483621,23483622,23483623,23483624,23483625,23483627,23483628,23483631,23483632,
23483634,23483635,23483636,23483637,23483640,23483641,23483642,23483643,23483646,23483647,
23483648,23483649,23483652,23483653,23483659,23483660,23483661,23483662,23483664,23483665,
23483666,23483667,23483668,23483669,23483670,23483671,23483672,23483673,23483674,23483675,
23483676,23483677,23483679,23483680,23483681,23483682,23483683,23483684,23483685,23483686,
23483708,23483709,23483723,23483724,23483728,23483729,23483765,23483766,23483774,23483775,
23483790,23483791,23483812,23483813,23483815,23483816,23483820,23483821,23483836,23483837,
23483848,23483849,23483857,23483858,23483884,23483885,23483911,23483912,23483950,23483951,
23483975,23483976,23483992,23483993,23484001,23484002,23484041,23484042,23484053,23484054,
23484059,23484060,23484064,23484065,23484067,23484068,23484081,23484082,23484088,23484089,
23484103,23484104,23484124,23484125,23484128,23484129,23484130,23484131,23484139,23484140,
23484141,23484142,23484143,23484144,23484154,23484155,23484156,23484157,23484158,23484159,
23484169,23484170,23484171,23484172,23484173,23484174,23484178,23484179,23484180,23484181,
23484196,23484197,23484198,23484199,23484200,23484201,23484202,23484203,23484204,23484205,
23484206,23484207,23484208,23484209,23484211,23484212,23484213,23484214,23484215,23484216,
23484217,23484218,23484219,23484220,23484221,23484222,23484223,23484224,23484225,23484226,
23484227,23484228,23484229,23484230,23484231,23484232,23484233,23484234,23484235,23484236,
23484237,23484238,23484285,23484286,23484287,23484288,23484305,23484306,23484307,23484308,
23484309,23484310,23484311,23484312,23484313,23484314,23484315,23484316,23484342,23484343,
23484344,23484345,23484351,23484352,23484436,23484437,23484529,23484530,23484531,23484532,
23484536,23484537,23484540,23484541,23484543,23484544,23484547,23484548,23484550,23484551,
23484553,23484554,23484555,23484556,23484557,23484558,23484559,23484560,23484564,23484565,
23484567,23484568,23484570,23484571,23484573,23484574,23484575,23484576,23484578,23484579,
23484581,23484582,23484586,23484587,23484597,23484598,23484599,23484600,23484601,23484602,
23484604,23484605,23484639,23484640,23484651,23484652,23484653,23484654,23484658,23484659,
23484665,23484666,23484671,23484672,23484673,23484674,23484675,23484676,23484715,23484716,
23484718,23484719,23484722,23484723,23484724,23484725,23484726,23484727,23484728,23484729,
23484730,23484731,23484732,23484733,23484734,23484735,23484736,23484737,23484738,23484739,
23484742,23484743,23484747,23484748,23484749,23484750,23484751,23484752,23484753,23484754,
23484755,23484756,23484758,23484759,23484760,23484761,23484762,23484763,23484764,23484765,
23484766,23484767,23484769,23484770,23484771,23484772,23484773,23484774,23484775,23484776,
23484777,23484778,23484779,23484780,23484783,23484784,23484785,23484786,23484787,23484788,
23484789,23484790,23484791,23484792,23484793,23484794,23484797,23484798,23484802,23484803,
23484814,23484815,23484816,23484817,23484818,23484819,23484820,23484821,23484822,23484823,
23484824,23484825,23484826,23484827,23484923,23484924,23484942,23484943,23484949,23484954,
23484956,23484977,23484999,23485089,23485093,23485095,23485106,23485121,23485123,23485125,
23485132,23485134,23485139,23485141,23485143,23485145,23485147,23485149,23485152,23485154,
23485156,23485200,23485237,23485283,23485290,23485292,23485294,23485300,23485315,23485322,
23485336,23485338,23485340,23485347,23485415,23485417,23485419,23485421,23485423,23485425,
23485427,23485429,23485431,23485433,23485435,23485437,23485439,23485441,23485446,23485452,
23485454,23485457,23485459,23485461,23485473,23485476,23485481,23485486,23485491,23485502,
23485504,23485600,23485602,23485604,23485649,23485700,23485715,23485723,23485732,23485737,
23485739,23485741,23485744,23485746,23485748,23485788,23485955,23485957,23485959,23485961,
23485964,23485972,23485975,23485979,23485985,23485989,23485993,23486001,23486003,23486011,
23486013,23486016,23486021,23486025,23486027,23486030,23486038,23486045,23486048,23486054,
23486057,23486059,23486061,23486075,23486091,23486100,23486121,23486136,23486138,23486140,
23486143,23486148,23486150,23486152,23486154,23486156,23486159,23486161,23486164,23486168);

-- TAKE THE BACKUP FOR EMRS_D_PHONE
-- FOR THE REMAINING ADDRESS ID's

INSERT INTO EMRS_D_PHONE_BKUP_20210624
SELECT * FROM EMRS_D_PHONE
WHERE PHONE_ID IN (
23486172,23486175,23486182,23486187,23486189,23486191,23486195,23486199,23486201,23486205,
23486208,23486210,23486212,23486215,23486220,23486222,23486224,23486227,23486234,23486238,
23486242,23486247,23486252,23486254,23486256,23486263,23486268,23486273,23486275,23486282,
23486284,23486286,23486290,23486295,23486300,23486304,23486308,23486314,23486317,23486319,
23486323,23486329,23486331,23486334,23486337,23486339,23486341,23486343,23486346,23486348,
23486350,23486353,23486360,23486362,23486370,23486376,23486378,23486380,23486386,23486391,
23486393,23486398,23486400,23486402,23486404,23486406,23486408,23486410,23486413,23486431,
23486434,23486437,23486441,23486443,23486447,23486454,23486465,23486469,23486477,23486491,
23486499,23486529,23486552,23486558,23486566,23486576,23486583,23486588,23486590,23486600,
23486602,23486604,23486623,23486625,23486628,23486640,23486642,23486655,23486657,23486666,
23486671,23486674,23486677,23486712,23486714,23486717,23486737,23486741,23486744,23486746,
23486750,23486752,23486754,23486780,23486783,23486785,23486787,23486791,23486793,23486795,
23486797,23486800,23486808,23486810,23486822,23486824,23486826,23486828,23486830,23486832,
23486834,23486836,23486838,23486840,23486842,23486844,23486846,23486848,23486850,23486852,
23486854,23486856,23486858,23486861,23486863,23486872,23486874,23486877,23486879,23486883,
23486885,23486887,23486890,23486892,23486894,23486896,23486899,23486901,23486903,23486905,
23486907,23486909,23486913,23486915,23486920,23486922,23486924,23486938,23486946,23486949,
23486970,23486977,23486988,23487004,23487009,23487012,23487022,23487026,23487030,23487054,
23487075,23487097,23487108,23487113,23487118,23487143,23487146,23487148,23487151,23487153,
23487158,23487165,23487172,23487187,23487189,23487199,23487206,23487208,23487211,23487222,
23487224,23487230,23487232,23487234,23487236,23487241,23487243,23487258,23487260,23487262,
23487264,23487267,23487269,23487271,23487274,23487276,23487279,23487281,23487283,23487285,
23487287,23487291,23487298,23487300,23487302,23487304,23487313,23487316,23487328,23487330,
23487370,23487373,23487409,23487411,23487420,23487441,23487478,23487480,23487493,23487525,
23487562,23487576,23487587,23487590,23487592,23487609,23487612,23487615,23487617,23487619,
23487621,23487631,23487633,23487636,23487646,23487648,23487650,23487654,23487662,23487693,
23487695,23487697,23487728,23487737,23487750,23487759,23487773,23487796,23487826,23487828,
23487835,23487866,23487873,23487879,23487881,23487883,23487885,23487887,23487890,23487894,
23487896,23487898,23487904,23487907,23487910,23487912,23487915,23487917,23487923,23487925,
23487927,23487934,23487937,23487939,23487941,23487944,23487946,23487948,23487950,23487952,
23487954,23487957,23487959,23487964,23487966,23487969,23487976,23487989,23487993,23488005,
23488017,23488019,23488021,23488023,23488100,23488156);

-- TAKE THE BACKUP FOR EMRS_D_CLIENT

CREATE TABLE EMRS_D_CLIENT_BKUP_20210624
AS SELECT * FROM EMRS_D_CLIENT
WHERE CLIENT_NUMBER IN (
23412115,23412142,23412143,23412146,23412169,23412171,23412172,23412173,23412174,23412175,
23412185,23412198,23412248,23412249,23412250,23412251,23412252,23412257,23412263,23412269,
23412270,23412272,23412274,23412275,23412276,23412277,23412278,23412279,23412280,23412281,
23412282,23412283,23412285,23412288,23412289,23412290,23412292,23412295,23412299,23412303,
23412308,23412310,23412314,23412316,23412318,23412323,23412324,23412327,23412334,23412335,
23412337,23412338,23412341,23412342,23412343,23412353,23412357,23412362,23412363,23412364,
23412372,23412373,23412379,23412380,23412381,23412384,23412386,23412390,23412396,23412398,
23412399,23412406,23412411,23412413,23412422,23412423,23412426,23412427,23412432,23412433,
23412436,23412441,23412442,23412443,23412446,23412451,23412452,23412453,23412454,23412457,
23412461,23412462,23412464,23412465,23412466,23412469,23412474,23412482,23412483,23412484,
23412486,23412487,23412488,23412489,23412492,23412493,23412496,23412497,23412499,23412501,
23412502,23412503,23412504,23412506,23412509,23412511,23412516,23412517,23412519,23412523,
23412527,23412529,23412532,23412534,23412537,23412540,23412543,23412545,23412548,23412550,
23412551,23412552,23412555,23412559,23412562,23412563,23412564,23412566,23412572,23412575,
23412583,23412584,23412585,23412586,23412589,23412597,23412599,23412601,23412603,23412605,
23412608,23412610,23412615,23412617,23412619,23412622,23412625,23412630,23412631,23412632,
23412638,23412641,23412643,23412644,23412645,23412649,23412650,23412651,23412652,23412660,
23412673,23412677,23412683,23412693,23412701,23412706,23412708,23412714,23412715,23412726,
23412731,23412732,23412737,23412740,23412747,23412767,23412772,23412788,23412789,23412790,
23412794,23412807,23412810,23412811,23412831,23412835,23412845,23412854,23412861,23412862,
23412864,23412869,23412875,23412881,23412885,23412888,23412897,23412907,23412908,23412912,
23412918,23412922,23412926,23412930,23412932,23412937,23412946,23412947,23412957,23412962,
23412966,23412971,23412973,23412980,23412981,23412982,23412992,23413004,23413010,23413015,
23413017,23413018,23413025,23413029,23413030,23413048,23413050,23413054,23413066,23413069,
23413078,23413084,23413086,23413093,23413103,23413114,23413119,23413121,23413125,23413131,
23413142,23413148,23413157,23413162,23413163,23413166,23413174,23413181,23413187,23413191,
23413196,23413203,23413215,23413225,23413230,23413233,23413234,23413237,23413239,23413255,
23413262,23413276,23413279,23413292,23413293,23413299,23413300,23413302,23413304,23413308,
23413310,23413312,23413313,23413319,23413329,23413331,23413342,23413343,23413350,23413354,
23413359,23413363,23413364,23413370,23413381,23413394,23413397,23413419,23413432,23413441,
23413444,23413458,23413462,23413464,23413476,23413492,23413499,23413514,23413517,23413541,
23413551,23413557,23413559,23413568,23413569,23413581,23413582,23413583,23413592,23413595,
23413605,23413612,23413632,23413647,23413651,23413664,23413666,23413684,23413688,23413689,
23413717,23413745,23413756,23413757,23413763,23413764,23413774,23413779,23413780,23413783,
23413791,23413793,23413798,23413816,23413824,23413832,23413833,23413838,23413869,23413871,
23413888,23413889,23413904,23413907,23413915,23413937,23413949,23413953,23413971,23413972,
23413981,23413983,23414009,23414016,23414025,23414026,23414028,23414031,23414042,23414059,
23414075,23414092,23414102,23414126,23414150,23414176,23414181,23414190,23414198,23414201,
23414232,23414266,23414272,23414284,23414291,23414293,23414300,23414313,23414319,23414331,
23414336,23414339,23414360,23414372,23414376,23414403,23414404,23414434,23414448,23414473,
23414474,23414482,23414494,23414495,23414496,23414529,23414554,23414559,23414567,23414574,
23414585,23414598,23414607,23414608,23414612,23414615,23414631,23414642,23414644,23414671,
23414677,23414688,23414704,23414712,23414715,23414724,23414744,23414756,23414757,23414786,
23414794,23414824,23414829,23414837,23414842,23414853,23414854,23414856,22423515,22558821,
23413398,23413450,23413474,23413555,23413584,23413594,23413601,23413675,23413694,23413706,
23413726,23413811,23413827,23413905,23413906,23413952,23413996,23414002,23414012,23414105,
23414128,23414195,23414310,23414324,23414347,23414348,23414414,23414429,23414465,23414469,
23414551,23414565,23414577,23414592,23414596,23414659,23414675,23414751,23414855,23414866,
23414867,23414868,23414875,23414879,23414887,23414895,23414898,23414901,23414913,23414935,
23414938,23414944,23414946,23414955,23414956,23414957,23414961,23414966,23414988,23414990,
23414995,23415001,23415008,23415018,23415020,23415028,23415033,23415045,23415048,23415058,
23415069,23415075,23415079,23415092,23415095,23415108,23415110,23415113,23415114,23415122,
23415123,23415128,23415134,23415147,23415154,23415164,23415171,23415173,23415191,23415195,
23415196,23415201,23415216,23415220,23415221,23415227,23415231,23415246,23415249,23415250,
23415255,23415260,23415261,23415266,23415279,23415280,23415287,23415288,23415292,23415293,
23415313,23415330,23415333,23415335,23415336,23415352,23415353,23415360,23415388,23415389,
23415397,23415399,23415406,23415408,23415411,23415418,23415422,23415425,23415446,23415461,
23415465,23415470,23415477,23415512,23415518,23415523,23415531,23415535,23415537,23415538,
23415540,23415541,23415543,23415546,23415548,23415550,23415563,23415567,23415568,23415571,
23415578,23415580,23415589,23415590,23415593,23415595,23415606,23415607,23415614,23415619,
23415627,23415642,23415643,23415654,23415664,23415673,23415678,23415680,23415683,23415687,
23415690,23415698,23415702,23415705,23415722,23415725,23415733,23415737,23415747,23415754,
23415765,23415766,23415767,23415778,23415780,23415784,23415789,23415795,23415803,23415810,
23415817,23415818,23415823,23415829,23415841,23415850,23415854,23415857,23415863,23415871,
23415872,23415875,23415887,23415903,23415905,23415918,23415920,23415922,23415924,23415928,
23415939,23415946,23415948,23415954,23415971,23415980,23415990,23415992,23415999,23416007,
23416020,23416023,23416024,23416025,23416027,23416033,23416034,23416039,23416045,23416047,
23416048,23416051,23416065,23416069,23416080,23416090,23416100,23416103,23416108,23416109,
23416131,23416136,23416140,23416149,23416158,23416159,23416164,23416165,23416176,23416192,
23416200,23416203,23416216,23416217,23416219,23416220,23416224,23416225,23416230,23416242,
23416245,23416248,23416256,23416261,23416264,23416267,23416275,23416277,23416294,23416304,
23416305,23416306,23416307,23416309,23416320,23416325,23416327,23416342,23416347,23416353,
23416359,23416377,23416378,23416379,23416387,23416391,23416393,23416410,23416413,23416416,
23416424,23416427,23416430,23416431,23416434,23416442,23416449,23416463,23416482,23416487,
23416489,23416494,23416502,23416503,23416508,23416514,23416518,23416520,23416529,23416557,
23416562,23416574,23416582,23416585,23416587,23416588,23416592,23416594,23416615,23416617,
23416623,23416625,23416632,23416648,23416664,23416666,23416668,23416674,23416677,23416681,
23416685,23416691,23416706,23416710,23416727,23416730,23416737,23416738,23416742,23416749,
23416761,23416764,23416767,23416771,23416773,23416797,23416802,23416811,23416816,23416827,
23416836,23416844,23416845,23416846,23416852,23416862,23416867,23416874,23416887,23416892,
23416902,23416908,23416916,23416917,23416930,23416934,23416942,23416947,23416954,23416960,
23416977,23416979,23416995,23416997,23416998,23417001,23417005,23417011,23417016,23417025,
23417027,23417032,23417035,23417039,23417040,23417042,23417048,23417049,23417053,23417054,
23417058,23417059,23417060,23417063,23417064,23417074,23417085,23417087,23417095,23417104,
23417106,23417113,23417115,23417123,23417124,23417129,23417143,23417156,23417160,23417167,
23417172,23417176,23417178,23417179,23417215,23417226,23417232,23417237,23417238,23417246,
23417249,23417252,23417254,23417257,23417259,23417261,23417268,23417274,23417277,23417285,
23417289,23417297,23417299,23417302,23417318,23417320,23417322,23417332);

COMMIT;