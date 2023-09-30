alter session set current_schema = cisco_enterprise_cc;
alter session set nls_date_format="dd-mon-yy hh24:mi:ss";

delete from CC_D_ACD_AGENT_TEAM 
where agent_login_id in  (
'1037699',
'1076537',
'1085739',
'1100676',
'1100934',
'1120776',
'1120780',
'1121953',
'1123301',
'1129654',
'1138788',
'1139289',
'1144125',
'1147194',
'1204347',
'1204579',
'1205100',
'1247863',
'1248580',
'1248636',
'1249537',
'1253551',
'1255446',
'1256556',
'1258827',
'1258867',
'1269201',
'1275230',
'1287313',
'1287527',
'1287530',
'1287985',
'1289972',
'1300577',
'1302605',
'1302915',
'1311987',
'1315417',
'1316676',
'1317200',
'1317817',
'1317969',
'1317970',
'1317978',
'1317997',
'1318000',
'1318058',
'1318060',
'1318061',
'1318062',
'1318063',
'1318064',
'1318065',
'1318066',
'1318067',
'1318068',
'1318072',
'1318073',
'1318074',
'1318075',
'1318076',
'1318081',
'1318083',
'1318085',
'1318086',
'1318087',
'1318088',
'1318090',
'1318092',
'1318094',
'1318095',
'1318097',
'1318098',
'1318100',
'1318103',
'1318104',
'1318106',
'1318109',
'1318113',
'1318115',
'1318120',
'1318121',
'1318123',
'1318124',
'1318125',
'1318126',
'1318127',
'1318128',
'1318130',
'1318131',
'1318132',
'1318831',
'1319149',
'1319168',
'1319192',
'1319200',
'1319458',
'1319728',
'1319765',
'1320304',
'1320306',
'1320307',
'1320310',
'1320312',
'1320313',
'1320602',
'1324711',
'1324712',
'1324717',
'1324718',
'1324719',
'1324723',
'1324725',
'1324727',
'1324728',
'1324729',
'1324732',
'1324735',
'1324742',
'1324744',
'1324746',
'1324747',
'1324751',
'1324754',
'1325124',
'1325125',
'1325126',
'1325127',
'1325129',
'1325130',
'1325131',
'1325132',
'1325133',
'1325134',
'1325135',
'1325136',
'1325137',
'1325138',
'1325139',
'1325140',
'1325676',
'1325772',
'1325775',
'1325784',
'1325785',
'1325789',
'1325877',
'1325878',
'1326160',
'1326168',
'1326518',
'1326813',
'1326814',
'1327284',
'1328124',
'1328129',
'1328134',
'1328135',
'1328140',
'1328142',
'1328144',
'1328148',
'1328149',
'1328155',
'1328161',
'1328166',
'1328167',
'1328171',
'1328174',
'1328182',
'1328184',
'1328185',
'1328190',
'1328200',
'1328212',
'1328342',
'1328343',
'1328350',
'1328355',
'1328356',
'1328359',
'1328360',
'1328361',
'1328362',
'1328367',
'1328370',
'1328373',
'1328376',
'1328383',
'1328385',
'1328388',
'1328394',
'1328397',
'1328399',
'1328405',
'1328410',
'1328418',
'1328419',
'1328832',
'1328859',
'1329024',
'1331562',
'1331563',
'1331566',
'1331567',
'1331571',
'1331574',
'1331577',
'1331578',
'1331579',
'1331586',
'1331587',
'1331590',
'1331592',
'1331593',
'1331599',
'1331602',
'1331603',
'1331604',
'1331605',
'1331606',
'1331607',
'1331608',
'1331612',
'1331618',
'1331620',
'1331623',
'1331627',
'1331629',
'1331632',
'1331637',
'1331638',
'1331639',
'1331645',
'1331646',
'1331649',
'1331650',
'1331653',
'1331659',
'1331660',
'1331663',
'1331664',
'1331668',
'1331910',
'1331917',
'1331933',
'1332107',
'1332365',
'1332406',
'1332662',
'1332694',
'1333336',
'1333338',
'1333346',
'1333350',
'1333356',
'1333363',
'1333365',
'1333367',
'1333370',
'1333373',
'1333379',
'1333380',
'1333383',
'1333384',
'1333390',
'1333393',
'1333397',
'1333403',
'1333404',
'1333408',
'1334183',
'1334185',
'1334186',
'1334187',
'1334188',
'1334192',
'1334196',
'1334198',
'1334199',
'1334201',
'1334202',
'1334205',
'1334206',
'1334207',
'1334211',
'1334212',
'1334213',
'1334215',
'1334216',
'1334217',
'1334220',
'1334221',
'1334223',
'1334226',
'1334229',
'1334231',
'1334235',
'1334236',
'1334238',
'1334240',
'1334243',
'1334244',
'1334245',
'1334246',
'1334249',
'1334252',
'1334253',
'1334255',
'1334256',
'1334260',
'1334261',
'1334262',
'1334360',
'1334658',
'1334667',
'1334775',
'1334782',
'1334790',
'1335028',
'1335029',
'1335031',
'1335033',
'1335036',
'1335039',
'1335250',
'1335254',
'1335267',
'1335275',
'1335280',
'1335289',
'1335299',
'1335303',
'1335304',
'1335306',
'1335310',
'1335380',
'1335389',
'1335556',
'1335558',
'1335559',
'1335561',
'1335562',
'1335564',
'1335565',
'1335568',
'1335569',
'1335570',
'1335571',
'1335574',
'1335584',
'1335591',
'1335594',
'1335596',
'1335605',
'1335606',
'1335607',
'1335608',
'1335609',
'1335612',
'1335613',
'1335617',
'1335618',
'1335625',
'1335626',
'1335627',
'1335629',
'1335630',
'1335634',
'1335639',
'1335642',
'1335643',
'1335644',
'1335770',
'1335772',
'1335773',
'1335775',
'1335778',
'1335780',
'1335781',
'1335785',
'1335786',
'1337749',
'1337929',
'1337933',
'1337940',
'1337947',
'1337961',
'1337980',
'1338071',
'1338211',
'1338265',
'1338315',
'1338347',
'1338350',
'1338382',
'1338591',
'1338606',
'1338759',
'1339146',
'1339501',
'1339521',
'1339531',
'1339540',
'1339545',
'1339557',
'1339561',
'1339577',
'1339588',
'1339609',
'1339635',
'1339647',
'1339657',
'1339659',
'1339668',
'1339675',
'1339685',
'1339696',
'1339697',
'1339705',
'1339707',
'1339752',
'1339927',
'1339930',
'1339932',
'1339933',
'1339935',
'1339936',
'1339938',
'1339939',
'1339943',
'1339946',
'1339949',
'1339951',
'1339954',
'1339955',
'1339958',
'1339959',
'1339960',
'1339961',
'1339977',
'1339980',
'1339982',
'1339984',
'1339985',
'1339990',
'1339992',
'1340002',
'1340003',
'1340019',
'1340029',
'1340042',
'1340049',
'1340050',
'1340076',
'1340077',
'1340085',
'1340086',
'1340092',
'1340093',
'1340099',
'1340101',
'1340108',
'1340121',
'1340122',
'1340123',
'1340132',
'1340133',
'1340136',
'1340176',
'1340183',
'1340186',
'1340194',
'1340215',
'1340218',
'1340228',
'1340234',
'1340272',
'1340284',
'1340296',
'1340302',
'1340317',
'1340318',
'1340372',
'1340527',
'1340528',
'1340529',
'1340531',
'1340532',
'1340533',
'1340534',
'1340535',
'1340536',
'1340537',
'1340539',
'1340540',
'1340541',
'1340542',
'1340543',
'1340544',
'1340545',
'1340546',
'1340547',
'1340548',
'1340549',
'1340550',
'1340551',
'1340552',
'1340553',
'1340554',
'1340555',
'1340556',
'1340557',
'1340558',
'1340559',
'1340560',
'1340561',
'1340562',
'1340563',
'1340564',
'1340565',
'1340566',
'1340567',
'1340568',
'1340569',
'1340570',
'1340571',
'1340572',
'1340573',
'1340574',
'1340575',
'1340576',
'1340577',
'1340578',
'1340579',
'1340580',
'1340581',
'1340617',
'1340632',
'1340633',
'1340639',
'1340640',
'1340641',
'1340642',
'1340643',
'1340644',
'1340645',
'1340646',
'1340647',
'1340648',
'1340649',
'1340650',
'1340651',
'1340652',
'1340653',
'1340654',
'1340655',
'1340656',
'1340657',
'1340658',
'1340659',
'1340660',
'1340661',
'1340662',
'1340663',
'1340664',
'1340665',
'1340666',
'1340667',
'1340668',
'1340669',
'1340670',
'1340671',
'1340672',
'1340673',
'1340674',
'1340675',
'1340676',
'1340677',
'1340678',
'1340679',
'1340680',
'1340681',
'1340682',
'1340684',
'1340685',
'1340686',
'1340687',
'1340690',
'1340691',
'1340692',
'1340694',
'1340695',
'1340696',
'1340697',
'1340698',
'1340699',
'1340700',
'1340701',
'1340703',
'1340704',
'1340705',
'1340707',
'1340708',
'1340709',
'1340710',
'1340711',
'1340713',
'1340714',
'1340715',
'1340716',
'1340717',
'1340718',
'1340719',
'1340720',
'1340721',
'1340722',
'1340724',
'1340725',
'1340726',
'1340727',
'1340729',
'1340730',
'1340731',
'1340732',
'1340733',
'1340734',
'1340735',
'1340736',
'1340737',
'1340738',
'1340739',
'1340757',
'1340758',
'1340763',
'1340768',
'1340770',
'1340772',
'1340773',
'1340774',
'1340776',
'1340792',
'1340810',
'1340811',
'1340816',
'1340819',
'1340820',
'1340822',
'1340823',
'1340824',
'1340825',
'1340827',
'1340830',
'1340832',
'1340834',
'1340836',
'1340842',
'1340844',
'1340847',
'1340848',
'1340849',
'1340850',
'1340851'
)
and version = 1
and record_eff_dt <= '02-jan-00 00:00:00'
and record_end_dt >= '30-dec-99 00:00:00'
 ;

update cc_c_acd_team
set team_name = 'NCRH_NCUI_Team14Everise_LEGACY'
where team_name = 'NCRH_NCUI_Team14Everise';

commit;