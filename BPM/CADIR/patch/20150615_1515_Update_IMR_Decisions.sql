update s_crs_imr_decisions a
set a.decision_letter_mailed_dt = to_date('06/12/2015','mm/dd/yyyy')
where a.imr_id in (select b.imr_id from s_crs_imr b where b.case_number = 'CM15-0067580');

COMMIT;


update s_crs_imr_decisions a
set a.decision_letter_mailed_dt = to_date('06/11/2015','mm/dd/yyyy')
where a.imr_id in (select b.imr_id from s_crs_imr b where b.case_number IN (
'CM13-0010058',
'CM13-0055041',
'CM14-0060357',
'CM14-0071703',
'CM14-0076171',
'CM14-0092458',
'CM14-0096489',
'CM14-0114932',
'CM14-0137998',
'CM14-0179878',
'CM14-0188743',
'CM14-0214819',
'CM14-0215501',
'CM14-0215711',
'CM15-0008160',
'CM15-0009138',
'CM15-0010448',
'CM15-0012557',
'CM15-0015833',
'CM15-0015848',
'CM15-0015930',
'CM15-0019549',
'CM15-0019846',
'CM15-0020292',
'CM15-0021606',
'CM15-0021778',
'CM15-0025193',
'CM15-0026846',
'CM15-0027258',
'CM15-0027778',
'CM15-0028435',
'CM15-0028592',
'CM15-0029994',
'CM15-0031111',
'CM15-0036675',
'CM15-0040176',
'CM15-0040576',
'CM15-0045505',
'CM15-0048520',
'CM15-0049542',
'CM15-0051029',
'CM15-0051580',
'CM15-0051673',
'CM15-0053632',
'CM15-0053698',
'CM15-0054685',
'CM15-0056273',
'CM15-0056848',
'CM15-0057169',
'CM15-0057729',
'CM15-0057893',
'CM15-0057893',
'CM15-0058090',
'CM15-0058370',
'CM15-0060574',
'CM15-0060783',
'CM15-0061178',
'CM15-0062176',
'CM15-0062285',
'CM15-0062476',
'CM15-0062728',
'CM15-0063003',
'CM15-0063080',
'CM15-0063204',
'CM15-0063225',
'CM15-0063256',
'CM15-0063280',
'CM15-0063538',
'CM15-0063778',
'CM15-0063860',
'CM15-0064033',
'CM15-0064126',
'CM15-0064370',
'CM15-0064821',
'CM15-0065028',
'CM15-0068958',
'CM14-0213682',
'CM15-0020314',
'CM15-0025046',
'CM15-0041365',
'CM15-0042025',
'CM15-0044534',
'CM15-0047111',
'CM15-0048552',
'CM15-0053503',
'CM15-0056153',
'CM15-0057905',
'CM15-0058263',
'CM15-0059096',
'CM15-0060138',
'CM15-0060655',
'CM15-0061058',
'CM15-0061878',
'CM15-0063117',
'CM15-0063217',
'CM15-0063350',
'CM15-0063531',
'CM15-0064524',
'CM15-0064561',
'CM15-0064820',
'CM15-0065100',
'CM15-0065401',
'CM15-0065626',
'CM15-0065910',
'CM15-0066041',
'CM15-0066116',
'CM15-0066256',
'CM15-0066279',
'CM15-0066557',
'CM15-0066581',
'CM15-0066614',
'CM15-0066639',
'CM15-0067501',
'CM15-0067561',
'CM15-0067587',
'CM15-0067613',
'CM15-0067688',
'CM15-0067699',
'CM15-0067700',
'CM15-0067725',
'CM15-0067788',
'CM15-0067823',
'CM15-0067837',
'CM15-0067848',
'CM15-0067870',
'CM15-0067892',
'CM15-0069868',
'CM15-0070761',
'CM15-0071525',
'CM15-0071550',
'CM15-0071589',
'CM15-0071731',
'CM15-0071738',
'CM15-0071743',
'CM15-0071749',
'CM15-0071774',
'CM15-0071778',
'CM15-0071799',
'CM15-0071830',
'CM15-0071852',
'CM15-0071876',
'CM15-0071879',
'CM15-0071886',
'CM15-0071900',
'CM15-0071913',
'CM15-0071915',
'CM15-0071922',
'CM15-0071931',
'CM15-0071938',
'CM15-0071946',
'CM15-0071954',
'CM15-0071961',
'CM15-0071970',
'CM15-0071975',
'CM15-0071978',
'CM15-0071984',
'CM15-0071990',
'CM15-0071996',
'CM15-0071999',
'CM15-0072012',
'CM15-0072028',
'CM15-0072305',
'CM15-0072320',
'CM15-0072324',
'CM15-0072352',
'CM15-0072374',
'CM15-0072378',
'CM15-0072380',
'CM15-0072393',
'CM15-0072405',
'CM15-0072426',
'CM15-0072431',
'CM15-0072453',
'CM15-0072483',
'CM15-0072532',
'CM15-0072576',
'CM15-0072587',
'CM15-0072602',
'CM15-0072611',
'CM15-0072624',
'CM15-0072633',
'CM15-0072645',
'CM15-0072663',
'CM15-0072680',
'CM15-0072698',
'CM15-0072756',
'CM15-0072812',
'CM15-0072825',
'CM15-0072850',
'CM15-0072885',
'CM15-0072890',
'CM15-0072928',
'CM15-0072955',
'CM15-0072972',
'CM15-0072984',
'CM15-0072990',
'CM15-0073020',
'CM15-0073039',
'CM15-0073052',
'CM15-0073058',
'CM15-0073076',
'CM15-0073083',
'CM15-0073099',
'CM15-0073110',
'CM15-0073127',
'CM15-0073137',
'CM15-0073163',
'CM15-0073187',
'CM15-0073206',
'CM15-0073221',
'CM15-0073258',
'CM15-0073305',
'CM15-0073316',
'CM14-0097206',
'CM14-0162114',
'CM15-0035040',
'CM15-0041249',
'CM15-0042228',
'CM15-0042805',
'CM15-0045345',
'CM15-0045345',
'CM15-0045361',
'CM15-0046856',
'CM15-0047379',
'CM15-0047388',
'CM15-0048565',
'CM15-0050379',
'CM15-0051826',
'CM15-0055014',
'CM15-0055820',
'CM15-0055830',
'CM15-0057155',
'CM15-0057712',
'CM15-0057834',
'CM15-0058603',
'CM15-0058698',
'CM15-0059112',
'CM15-0059289',
'CM15-0060626',
'CM15-0061338',
'CM15-0061423',
'CM15-0061468',
'CM15-0062344',
'CM15-0062480',
'CM15-0062698',
'CM15-0063821',
'CM15-0064032',
'CM15-0064479',
'CM15-0064751',
'CM15-0065023',
'CM15-0065178',
'CM15-0065597',
'CM15-0065984',
'CM15-0066039',
'CM15-0066059',
'CM15-0066071',
'CM15-0066090',
'CM15-0066205',
'CM15-0066436',
'CM15-0066464',
'CM15-0066590',
'CM15-0066615',
'CM15-0067041',
'CM15-0067375',
'CM15-0067468',
'CM15-0067528',
'CM15-0067649',
'CM15-0067657',
'CM15-0067751',
'CM15-0067845',
'CM15-0067904',
'CM15-0068015',
'CM15-0068165',
'CM15-0068361',
'CM15-0068382',
'CM15-0068550',
'CM15-0068662',
'CM15-0068769',
'CM15-0068840',
'CM15-0068842',
'CM15-0068865',
'CM15-0068876',
'CM15-0068894',
'CM15-0068904',
'CM15-0068919',
'CM15-0068951',
'CM15-0069040',
'CM15-0069051',
'CM15-0069081',
'CM15-0069381',
'CM15-0069495',
'CM15-0069597',
'CM15-0069734',
'CM15-0069787',
'CM15-0026980',
'CM15-0069918',
'CM15-0070008',
'CM15-0070154',
'CM15-0070227',
'CM15-0070299',
'CM15-0070342',
'CM15-0070383',
'CM15-0070417',
'CM15-0070489',
'CM15-0070508',
'CM15-0070526',
'CM15-0070654',
'CM15-0070690',
'CM15-0070713',
'CM15-0070723',
'CM15-0070780',
'CM15-0070828',
'CM15-0070862',
'CM15-0070952',
'CM15-0071037',
'CM15-0071045',
'CM15-0071079',
'CM15-0071084',
'CM15-0071090',
'CM15-0071110',
'CM15-0071121',
'CM15-0071128',
'CM15-0071207',
'CM15-0071424',
'CM15-0071453',
'CM15-0071515',
'CM15-0071558',
'CM15-0071566',
'CM15-0071586',
'CM15-0071902',
'CM15-0071910',
'CM15-0071980',
'CM15-0072064',
'CM15-0072083',
'CM15-0072088',
'CM15-0072094',
'CM15-0072102',
'CM15-0072124',
'CM15-0072170',
'CM15-0072272',
'CM15-0072317',
'CM15-0072454',
'CM15-0072575',
'CM15-0072595',
'CM15-0072634',
'CM15-0072667',
'CM15-0072705',
'CM15-0072725',
'CM15-0072810',
'CM15-0072882',
'CM15-0072895',
'CM15-0073051',
'CM15-0073112',
'CM15-0073119',
'CM15-0073132',
'CM15-0073146',
'CM15-0073147',
'CM15-0073150',
'CM15-0073152',
'CM15-0073199',
'CM15-0073200',
'CM15-0073232',
'CM15-0073239',
'CM15-0073252',
'CM15-0073287',
'CM15-0073760',
'CM15-0073776',
'CM15-0073783',
'CM15-0073788',
'CM15-0073802',
'CM15-0073808',
'CM15-0073810',
'CM15-0073813',
'CM15-0073829',
'CM15-0073845',
'CM15-0073847',
'CM15-0073856',
'CM15-0073865',
'CM15-0073868',
'CM15-0073870',
'CM15-0073876',
'CM15-0073888',
'CM15-0073892',
'CM15-0073901',
'CM15-0073904',
'CM15-0073906',
'CM15-0073908',
'CM15-0073917',
'CM15-0073930',
'CM15-0073935',
'CM15-0073945',
'CM15-0073961',
'CM15-0073987',
'CM15-0074004',
'CM15-0074017',
'CM15-0074038',
'CM15-0074047',
'CM15-0074050',
'CM15-0074076',
'CM15-0074093',
'CM15-0074099',
'CM15-0074106',
'CM15-0074132',
'CM15-0074137',
'CM15-0074149',
'CM15-0074165',
'CM15-0074195',
'CM15-0074222',
'CM15-0074224',
'CM15-0074230',
'CM15-0074239',
'CM15-0074247',
'CM15-0074259',
'CM15-0074284',
'CM15-0074289',
'CM15-0074305',
'CM15-0074317',
'CM15-0074324',
'CM15-0074345',
'CM15-0074353',
'CM15-0074370',
'CM15-0074383',
'CM15-0074398',
'CM15-0074414',
'CM15-0074427',
'CM15-0074446',
'CM15-0074477',
'CM15-0074493',
'CM15-0074511',
'CM15-0074534',
'CM15-0074555',
'CM15-0074582',
'CM15-0074612',
'CM15-0074618',
'CM15-0074646',
'CM15-0074661',
'CM15-0075846',
'CM15-0076601',
'CM15-0076885',
'CM15-0077085',
'CM15-0086772',
'CM15-0029845',
'CM14-0053847',
'CM14-0136852',
'CM14-0138435',
'CM15-0006911',
'CM15-0009671',
'CM15-0036861',
'CM15-0040031',
'CM15-0041744',
'CM15-0044032',
'CM15-0045350',
'CM15-0047783',
'CM15-0047854',
'CM15-0052072',
'CM15-0053283',
'CM15-0053336',
'CM15-0054128',
'CM15-0054714',
'CM15-0055265',
'CM15-0056410',
'CM15-0056804',
'CM15-0056937',
'CM15-0057044',
'CM15-0057070',
'CM15-0058004',
'CM15-0058041',
'CM15-0058184',
'CM15-0058215',
'CM15-0058279',
'CM15-0058297',
'CM15-0058300',
'CM15-0058587',
'CM15-0058660',
'CM15-0058839',
'CM15-0058879',
'CM15-0058907',
'CM15-0058913',
'CM15-0058954',
'CM15-0059019',
'CM15-0059069',
'CM15-0059135',
'CM15-0059159',
'CM15-0059579',
'CM15-0060383',
'CM15-0060806',
'CM15-0061128',
'CM15-0061485',
'CM15-0061649',
'CM15-0061863',
'CM15-0062314',
'CM15-0062580',
'CM15-0063141',
'CM15-0064295',
'CM15-0064565',
'CM15-0064771',
'CM15-0064983',
'CM15-0066191',
'CM15-0066219',
'CM15-0066609',
'CM15-0066648',
'CM15-0067418',
'CM15-0067754',
'CM15-0067971',
'CM15-0068194',
'CM15-0068247',
'CM15-0068658',
'CM15-0068830',
'CM15-0068879',
'CM15-0068909',
'CM15-0068930',
'CM15-0069255',
'CM15-0069575',
'CM15-0069697',
'CM15-0069703',
'CM15-0069853',
'CM15-0069940',
'CM15-0070087',
'CM15-0070210',
'CM15-0070247',
'CM15-0070248',
'CM15-0070286',
'CM15-0070300',
'CM15-0070303',
'CM15-0070358',
'CM15-0070373',
'CM15-0070824',
'CM15-0070866',
'CM15-0070927',
'CM15-0070978',
'CM15-0071078',
'CM15-0071139',
'CM15-0071335',
'CM15-0071490',
'CM15-0071785',
'CM15-0071848',
'CM15-0071862',
'CM15-0071909',
'CM15-0072044',
'CM15-0072219',
'CM15-0072242',
'CM15-0072262',
'CM15-0072294',
'CM15-0072309',
'CM15-0072371',
'CM15-0072442',
'CM15-0072590',
'CM15-0072657',
'CM15-0072730',
'CM15-0072764',
'CM15-0072873',
'CM15-0072887',
'CM15-0072906',
'CM15-0072930',
'CM15-0072937',
'CM15-0073008',
'CM15-0073021',
'CM15-0073561',
'CM15-0073614',
'CM15-0073790',
'CM15-0073925',
'CM15-0073979',
'CM15-0073985',
'CM15-0074026',
'CM15-0074043',
'CM15-0074055',
'CM15-0074078',
'CM15-0074085',
'CM15-0073919',
'CM15-0073928',
'CM15-0073933',
'CM15-0073990',
'CM15-0074007',
'CM15-0074053',
'CM15-0074102',
'CM15-0074321',
'CM15-0074888',
'CM15-0074943',
'CM15-0074977',
'CM15-0074993',
'CM15-0075018',
'CM15-0075041',
'CM15-0075060',
'CM15-0075068',
'CM15-0075197',
'CM15-0075199',
'CM15-0075294',
'CM15-0075395',
'CM15-0075496',
'CM15-0075509',
'CM15-0075600',
'CM15-0075667',
'CM15-0075668',
'CM15-0075702',
'CM15-0075789',
'CM15-0075850',
'CM15-0075865',
'CM15-0075874',
'CM15-0075888',
'CM15-0075898',
'CM15-0075905',
'CM15-0075912',
'CM15-0075917',
'CM15-0075925',
'CM15-0075952',
'CM15-0075958',
'CM15-0075968',
'CM15-0076032',
'CM15-0076058',
'CM15-0076065',
'CM15-0076076',
'CM15-0076085',
'CM15-0076089',
'CM15-0076102',
'CM15-0076115',
'CM15-0076133',
'CM15-0076146',
'CM15-0076152',
'CM15-0076165',
'CM15-0076169',
'CM15-0076176',
'CM15-0076199',
'CM15-0076206',
'CM15-0076221',
'CM15-0076228',
'CM15-0076229',
'CM15-0076248',
'CM15-0076270',
'CM15-0076271',
'CM15-0076276',
'CM15-0076281',
'CM15-0076291',
'CM15-0076293',
'CM15-0076305',
'CM15-0076317',
'CM15-0076319',
'CM15-0076328',
'CM15-0076361',
'CM15-0076528',
'CM15-0076542',
'CM15-0076572',
'CM15-0076586',
'CM15-0076590',
'CM15-0076605',
'CM15-0076615',
'CM15-0076638',
'CM15-0076660',
'CM15-0076665',
'CM15-0076690',
'CM15-0076695',
'CM15-0076697',
'CM15-0076741',
'CM15-0076751',
'CM15-0076760',
'CM15-0077357',
'CM15-0077403',
'CM13-0047556',
'CM13-0067991',
'CM14-0091165',
'CM14-0139688',
'CM15-0036335',
'CM15-0061196',
'CM15-0063281',
'CM15-0063948',
'CM15-0064546',
'CM15-0067286',
'CM15-0068756',
'CM15-0070411',
'CM15-0070748',
'CM15-0073671',
'CM15-0073976',
'CM15-0075862',
'CM15-0076509',
'CM15-0077337',
'CM15-0077706',
'CM15-0078328',
'CM15-0078883',
'CM15-0079061',
'CM15-0079463',
'CM15-0079630',
'CM15-0079920',
'CM15-0081050',
'CM15-0081075',
'CM15-0081199',
'CM15-0081504',
'CM15-0081628',
'CM15-0081734',
'CM15-0081963',
'CM15-0082357',
'CM15-0082732',
'CM15-0082815',
'CM15-0083214',
'CM15-0083317',
'CM15-0083327',
'CM15-0083471',
'CM15-0083582',
'CM15-0083658',
'CM15-0083803',
'CM15-0085424',
'CM15-0087691',
'CM15-0073353',
'CM15-0073437',
'CM15-0073487',
'CM15-0073502',
'CM15-0073506',
'CM15-0073507',
'CM15-0073511',
'CM15-0073513',
'CM15-0073516',
'CM15-0073528',
'CM15-0073528',
'CM15-0073534',
'CM15-0073538',
'CM15-0073690',
'CM15-0073698',
'CM15-0073709',
'CM15-0073715',
'CM15-0073719',
'CM15-0073731',
'CM15-0073736',
'CM15-0074097',
'CM15-0074114',
'CM15-0074119',
'CM14-0061553',
'CM14-0061904',
'CM14-0072610',
'CM14-0074629',
'CM14-0087286',
'CM14-0090647',
'CM14-0091303',
'CM15-0062992',
'CM15-0065811',
'CM15-0068232',
'CM15-0068248',
'CM15-0068261',
'CM15-0068272',
'CM15-0068981',
'CM15-0069084',
'CM15-0069905',
'CM15-0070045',
'CM15-0070253',
'CM15-0071893',
'CM15-0071964',
'CM15-0071988',
'CM15-0072015',
'CM15-0072055',
'CM15-0072069',
'CM15-0072076',
'CM15-0072077',
'CM15-0072081',
'CM15-0072100',
'CM15-0072111',
'CM15-0072155',
'CM15-0072181',
'CM15-0072195',
'CM15-0072211',
'CM15-0072329',
'CM15-0072338',
'CM15-0072530',
'CM15-0072542',
'CM15-0072564',
'CM15-0072598',
'CM15-0072599',
'CM15-0072612',
'CM15-0072726',
'CM15-0072800',
'CM15-0072830',
'CM15-0072905',
'CM15-0072914',
'CM15-0072994',
'CM15-0073104',
'CM15-0073173',
'CM15-0073174',
'CM15-0073205',
'CM15-0073222',
'CM15-0073304',
'CM15-0073881',
'CM14-0116488'
));

COMMIT;