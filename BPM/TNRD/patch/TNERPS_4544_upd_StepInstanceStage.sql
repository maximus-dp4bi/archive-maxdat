alter session set current_schema = "MAXDAT";

--Priority 1

UPDATE MAXDAT.STEP_INSTANCE_STG SET step_instance_id=1
WHERE STEP_INSTANCE_ID IN (
5325882,
7355971,
7480436,
7493128,
7826791,
8503856,
8665607,
8869144,
9003938,
9089498,
9407781,
9899374,
10186478,
11303953,
11496143,
11695634,
11712024,
11866146,
12108535,
12396141,
12421027,
12586134,
12645810,
12689928,
12770970,
12872120,
12936277,
12949558,
13055612,
13057181,
13076001,
13551014,
13563819,
13712562,
13718487,
13736228,
13786865,
13794041,
13797286,
13802462,
13877279,
13884798,
13896540,
13901059,
13901282,
13912502,
13920506,
13922649,
13939923,
13946838,
13948171,
13978800,
13979335,
13990977,
14037975,
14099221,
14100091,
14109074,
14178261,
14219148,
14219690,
14262528,
14277180,
14279505,
14285436,
14290358,
14298994,
14300073,
14301821,
14305230,
14305255,
14305306,
14334911,
14338606,
14356520,
14379024,
14379170,
14396179,
14396243,
14430540,
14474501,
14481711,
14502894,
14503235,
14504408,
14504500,
14504518,
14524710,
14537386,
14541451,
14567526,
14577991,
14585038,
14595043,
14603075,
14605310,
14608924,
14630465,
14661317,
14680510,
14685290,
14705554,
14714154,
14714744,
14715547,
14717981,
14741804,
14786231,
14793394,
14869561,
14870170,
14870438,
15020523,
15055551,
15065132,
15083006,
15101548,
15102739,
15104272,
15105366,
15119724,
15123114,
15125676,
15138796,
15142239,
15149842,
15154142,
15166217,
15167925,
15180443,
15180615,
15185922,
15186353,
15187092,
15193833,
15195712,
15203675,
15210358,
15211252,
15212713,
15214933,
15214946,
15214953,
15214970,
15219094,
15256878,
15257510,
15263794,
15286154,
15289336,
15289910,
15289938,
15290091,
15304714,
15337143,
15337182,
15341787,
15343060,
15362744,
15365178,
15367095,
15371764,
15371913,
15387516,
15401031,
15401504,
15406618,
15409231,
15411606,
15432664,
15435691,
15440397,
15461560,
15463148,
15463200,
15465211,
15479027,
15494631,
15496255,
15496548,
15501186,
15505012,
15508601,
15511077,
15521221,
15525142,
15537546,
15540343,
15540610,
15544572,
15545494,
15545691,
15550053,
15551358,
15551740,
15555549,
15557056,
15557193,
15557440,
15559130,
15559640,
15560152,
15571735,
15573307,
15577115,
15580807,
15592007,
15592600,
15597705,
15598175,
15598521,
15598554,
15599730,
15600370,
15600495,
15601694,
15603159,
15604019,
15604455,
15606275,
15609888,
15613423,
15614704,
15614762,
15617645,
15621557,
15627152,
15651624,
15701751,
15703123,
15703971,
15711713,
15714327,
15714615,
15716172,
15716379,
15716554,
15716595,
15716870,
15717991,
15718560,
15719492,
15721095,
15721360,
15721549,
15722652,
15727805,
15736267,
15737790,
15739983,
15750753,
15751820,
15762241,
15763107,
15786409,
15786566,
15787276,
15788268,
15788660,
15806545,
15807044,
15807580,
15808061,
15814082,
15814533,
15814779,
15815117,
15815169,
15819707,
15820893,
15825069,
15825161,
15847876,
15859489,
15882127,
15882631,
15883900,
15891150,
15891441,
15923670,
15926621,
15929085,
15931381,
15932380,
15932582,
15932917,
15936042,
15941635,
15949253,
15953585,
15963517,
16000089,
16006544,
16007319,
16008493,
16009709,
16011071,
16011824,
16012571,
16017707,
16030847,
16035712,
16039321,
16045999,
16046996,
16066029,
16066683,
16072054,
16080787,
16088377,
16091181,
16094418,
16095548,
16097405,
16104033,
16104344,
16105780,
16111087,
16111415,
16112229,
16113765,
16115534,
16118581,
16135780,
16138025,
16138855,
16140397,
16144782,
16146009,
16146359,
16146656,
16154090,
16155741,
16161541,
16162345,
16162717,
16165730,
16168573,
16170209,
16170559,
16170891,
16170912,
16171141,
16176488,
16176723,
16176921,
16178197,
16186207,
16186915,
16187315,
16188203,
16190865,
16191927,
16192840,
16194724,
16195922,
16196810,
16197528,
16198328,
16202787,
16203166,
16203403,
16204482,
16205981,
16208648,
16209229,
16214579,
16216232,
16216526,
16216865,
16218383,
16221172,
16223229,
16224777,
16226023,
16227875,
16228502,
16231767,
16232082,
16232188,
16237263,
16237709,
16241086,
16242061,
16246844,
16249336,
16261345,
16264779,
16266258,
16279992,
16280349,
16282255,
16283453,
16284273,
16287899,
16289931,
16292324,
16292747,
16298306,
16305725,
16314763,
16316977,
16320637,
16320708,
16328341,
16333491,
16334118,
16336568,
16336900,
16346661,
16347832,
16348085,
16348087,
16348208,
16348448,
16351463,
16354939,
16356548,
16358139,
16358935,
16361620,
16374949,
16375713,
16378912,
16378979,
16379118,
16379273,
16387844,
16392212,
16392715,
16400867,
16407153,
16407290,
16408469,
16408988,
16409576,
16410405,
16411350,
16411997,
16412325,
16412898,
16413970,
16414394,
16415791,
16417955,
16418022,
16419999,
16440171,
16443309,
16446039,
16446999,
16447517,
16448967,
16450191,
16451285,
16451711,
16452152,
16454929,
16455132,
16464573,
16478929,
16479493,
16479915,
16480904,
16480907,
16481226,
16481242,
16481261);

--Priority 3

UPDATE MAXDAT.STEP_INSTANCE_STG SET step_instance_id=3
WHERE STEP_INSTANCE_ID IN (7116519,
7381805,
7383885,
11344593,
11453619,
11908138,
12147492,
12219249,
12269703,
12492749,
12737692,
12946948,
13398946,
13517056,
14315898,
14477310,
14536301,
14537074,
14569511,
15114155,
15532499,
15534834,
15535182,
15610608,
15627611,
15637738,
15639521,
15674094,
15694296,
15699947,
15729364,
15738297,
15751169,
15764499,
15791695,
15796117,
15800321,
15821702,
15866607,
15875476,
15875934,
15876363,
15879576,
15887053,
15902325,
15939315,
15959807,
15960082,
15964712,
15979747,
16071026,
16071198,
16072555,
16074266,
16075887,
16080306,
16087871,
16088448,
16095537,
16095588,
16096611,
16103252,
16103503,
16103538,
16103688,
16103770,
16103979,
16105568,
16105782,
16105942,
16106764,
16107167,
16107437,
16108272,
16108974,
16109010,
16109081,
16109192,
16109291,
16110548,
16111732,
16111907,
16111983,
16112105,
16112546,
16114424,
16114896,
16116922,
16118298,
16118311,
16118829,
16119022,
16126529,
16129499,
16129958,
16130814,
16131334,
16135600,
16138088,
16138772,
16143036,
16145382,
16148218,
16151485,
16153698,
16156407,
16159711,
16162347,
16164984,
16167071,
16167267,
16167809,
16168388,
16168606,
16168917,
16170919,
16173055,
16174631,
16180581,
16182600,
16186396,
16189035,
16189878,
16190844,
16191442,
16193427,
16197428,
16200094,
16200324,
16201709,
16201712,
16202572,
16203164,
16204573,
16206181,
16210656,
16211149,
16212621,
16213431,
16214847,
16215118,
16218757,
16218927,
16219645,
16220414,
16222888,
16225481,
16227083,
16228335,
16229257,
16229645,
16232694,
16236883,
16236902,
16237695,
16237939,
16238401,
16239517,
16242109,
16243334,
16243571,
16244745,
16246021,
16247004,
16247065,
16247355,
16247645,
16253295,
16253776,
16255701,
16255917,
16264188,
16269609,
16276254,
16283852,
16286130,
16291686,
16294882,
16294967,
16295659,
16297855,
16298247,
16300118,
16302059,
16309748,
16311403,
16312155,
16313973,
16315528,
16320357,
16325869,
16325960,
16326505,
16327630,
16329754,
16332409,
16332999,
16336566,
16337043,
16338094,
16340690,
16342549,
16342798,
16343039,
16343286,
16346183,
16348924,
16351282,
16352509,
16356984,
16359543,
16359776,
16361395,
16363164,
16363558,
16365293,
16365332,
16371087,
16371705,
16374320,
16374581,
16377342,
16379632,
16380695,
16381402,
16383019,
16383289,
16384740,
16386032,
16391612,
16400530,
16400917,
16401721,
16402448,
16403195,
16403652,
16404599,
16406098,
16406398,
16407458,
16408380,
16408830,
16408945,
16409441,
16409830,
16411982,
16412619,
16412735,
16412808,
16413163,
16413228,
16414811,
16416047,
16417347,
16417605,
16418291,
16418964,
16419289,
16420199,
16420715,
16420961,
16421395,
16421443,
16422292,
16439563,
16442148,
16444423,
16450113,
16450919,
16452526,
16453268,
16454691,
16459659,
16461047,
16465560,
16469562,
16480401,
16481676,
16482044,
16509952);

COMMIT;