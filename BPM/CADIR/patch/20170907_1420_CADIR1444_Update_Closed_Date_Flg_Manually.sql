update s_crs_imr
set imr_closed_dt_flg = 'Y'
where case_number in ('CM17-0110455',
'CM17-0115624',
'CM17-0119888',
'CM17-0125144',
'CM17-0125607',
'CM17-0126871',
'CM17-0128835',
'CM17-0129046',
'CM17-0129776',
'CM17-0129856',
'CM17-0129959',
'CM17-0130061',
'CM17-0130853',
'CM17-0131559',
'CM17-0131992',
'CM17-0132292',
'CM17-0132294',
'CM17-0132696',
'CM17-0133024',
'CM17-0133119',
'CM17-0133391',
'CM17-0133501',
'CM17-0133743',
'CM17-0133751',
'CM17-0133861',
'CM17-0133928',
'CM17-0133961',
'CM17-0134100',
'CM17-0134202',
'CM17-0134360',
'CM17-0134584',
'CM17-0134772',
'CM17-0134973',
'CM17-0134980',
'CM17-0135043',
'CM17-0135078',
'CM17-0135148',
'CM17-0135168',
'CM17-0135191',
'CM17-0135398',
'CM17-0135414',
'CM17-0135445',
'CM17-0135466',
'CM17-0135537',
'CM17-0135557',
'CM17-0135614',
'CM17-0135702',
'CM17-0135749',
'CM17-0135816',
'CM17-0135851',
'CM17-0135890',
'CM17-0135893',
'CM17-0136138',
'CM17-0136500',
'CM17-0136757',
'CM17-0136807',
'CM17-0136969',
'CM17-0137001',
'CM17-0137007',
'CM17-0137197',
'CM17-0137441',
'CM17-0137542',
'CM17-0137640',
'CM17-0137978',
'CM17-0138094',
'CM17-0138100',
'CM17-0138143',
'CM17-0138235',
'CM17-0138265',
'CM17-0138514',
'CM17-0138569',
'CM17-0138692',
'CM17-0138764',
'CM17-0138802',
'CM17-0138852',
'CM17-0139123',
'CM17-0139128',
'CM17-0139138',
'CM17-0139143',
'CM17-0139244',
'CM17-0139272',
'CM17-0139589',
'CM17-0139661',
'CM17-0139803',
'CM17-0139839',
'CM17-0139878',
'CM17-0139950',
'CM17-0139976',
'CM17-0140026',
'CM17-0140091',
'CM17-0140118',
'CM17-0140154',
'CM17-0140221',
'CM17-0140233',
'CM17-0140249',
'CM17-0140318',
'CM17-0140394',
'CM17-0140408',
'CM17-0140424',
'CM17-0140432',
'CM17-0140441',
'CM17-0140447',
'CM17-0140448',
'CM17-0140461',
'CM17-0140513',
'CM17-0140533',
'CM17-0140555',
'CM17-0140616',
'CM17-0140623',
'CM17-0140754',
'CM17-0140763',
'CM17-0140772',
'CM17-0140807',
'CM17-0140823',
'CM17-0140833',
'CM17-0140843',
'CM17-0140864',
'CM17-0140882',
'CM17-0140889',
'CM17-0140915',
'CM17-0140939',
'CM17-0140949',
'CM17-0140952',
'CM17-0140954',
'CM17-0141013',
'CM17-0141018',
'CM17-0141029',
'CM17-0141126',
'CM17-0141235',
'CM17-0141237',
'CM17-0141283',
'CM17-0141284',
'CM17-0141294',
'CM17-0141322',
'CM17-0141348',
'CM17-0141382',
'CM17-0141407',
'CM17-0141409',
'CM17-0141467',
'CM17-0141497',
'CM17-0141509',
'CM17-0141510',
'CM17-0141513',
'CM17-0141530',
'CM17-0141577',
'CM17-0141597',
'CM17-0141600',
'CM17-0141638',
'CM17-0141642',
'CM17-0141646',
'CM17-0141666',
'CM17-0141691',
'CM17-0141740',
'CM17-0141754',
'CM17-0141764',
'CM17-0141781',
'CM17-0141782',
'CM17-0141786',
'CM17-0141787',
'CM17-0141808',
'CM17-0141832',
'CM17-0141859',
'CM17-0141867',
'CM17-0141901',
'CM17-0141937',
'CM17-0141938',
'CM17-0141948',
'CM17-0141975',
'CM17-0141986',
'CM17-0141990',
'CM17-0142016',
'CM17-0142045',
'CM17-0142048',
'CM17-0142201',
'CM17-0142284',
'CM17-0142286',
'CM17-0142294',
'CM17-0142399',
'CM17-0142428',
'CM17-0142458',
'CM17-0142547',
'CM17-0142562',
'CM17-0142592',
'CM17-0142603',
'CM17-0142640',
'CM17-0142695',
'CM17-0142712',
'CM17-0142810',
'CM17-0142828',
'CM17-0142901',
'CM17-0142989',
'CM17-0143041',
'CM17-0143068',
'CM17-0143083',
'CM17-0143105',
'CM17-0143237',
'CM17-0143391',
'CM17-0143425',
'CM17-0143451',
'CM17-0143495',
'CM17-0143650',
'CM17-0143682',
'CM17-0143960',
'CM17-0144047',
'CM17-0144264',
'CM17-0144367',
'CM17-0144371',
'CM17-0144380',
'CM17-0144406',
'CM17-0144453',
'CM17-0144465',
'CM17-0144467',
'CM17-0144544',
'CM17-0144715',
'CM17-0144834',
'CM17-0144985',
'CM17-0145008',
'CM17-0145049',
'CM17-0145085',
'CM17-0145187',
'CM17-0145192',
'CM17-0145218',
'CM17-0145278',
'CM17-0145316',
'CM17-0145477',
'CM17-0145495',
'CM17-0145543',
'CM17-0145546',
'CM17-0145563',
'CM17-0145573',
'CM17-0145640',
'CM17-0145723',
'CM17-0145784',
'CM17-0145833',
'CM17-0145840',
'CM17-0145857',
'CM17-0145931',
'CM17-0145939',
'CM17-0145968',
'CM17-0145980',
'CM17-0145995',
'CM17-0146027',
'CM17-0146088',
'CM17-0146100',
'CM17-0146196',
'CM17-0146249',
'CM17-0146279',
'CM17-0146328',
'CM17-0146348',
'CM17-0146363',
'CM17-0146391',
'CM17-0146461',
'CM17-0146502',
'CM17-0146513',
'CM17-0146543',
'CM17-0146582',
'CM17-0146588',
'CM17-0146589',
'CM17-0146590',
'CM17-0146592',
'CM17-0146600',
'CM17-0146602',
'CM17-0146613',
'CM17-0146654',
'CM17-0146682',
'CM17-0146692',
'CM17-0146700',
'CM17-0146708',
'CM17-0146715',
'CM17-0146722',
'CM17-0146725',
'CM17-0146727',
'CM17-0146733',
'CM17-0146734',
'CM17-0146736',
'CM17-0146737',
'CM17-0146740',
'CM17-0146744',
'CM17-0146747',
'CM17-0146748',
'CM17-0146749',
'CM17-0146755',
'CM17-0146758',
'CM17-0146761',
'CM17-0146764',
'CM17-0146775',
'CM17-0146777',
'CM17-0146779',
'CM17-0146782',
'CM17-0146816',
'CM17-0146831',
'CM17-0146861',
'CM17-0146870',
'CM17-0146880',
'CM17-0146882',
'CM17-0146884',
'CM17-0146891',
'CM17-0146892',
'CM17-0146895',
'CM17-0146906',
'CM17-0146910',
'CM17-0146912',
'CM17-0146914',
'CM17-0146923',
'CM17-0146933',
'CM17-0146936',
'CM17-0146938',
'CM17-0146949',
'CM17-0146956',
'CM17-0146958',
'CM17-0146962',
'CM17-0146963',
'CM17-0146966',
'CM17-0146984',
'CM17-0146988',
'CM17-0146997',
'CM17-0147000',
'CM17-0147010',
'CM17-0147029',
'CM17-0147032',
'CM17-0147036',
'CM17-0147051',
'CM17-0147053',
'CM17-0147056',
'CM17-0147059',
'CM17-0147066',
'CM17-0147077',
'CM17-0147082',
'CM17-0147093',
'CM17-0147095',
'CM17-0147096',
'CM17-0147097',
'CM17-0147133',
'CM17-0147134',
'CM17-0147152',
'CM17-0147185',
'CM17-0147187',
'CM17-0147192',
'CM17-0147196',
'CM17-0147208',
'CM17-0147214',
'CM17-0147223',
'CM17-0147232',
'CM17-0147235',
'CM17-0147238',
'CM17-0147249',
'CM17-0147265',
'CM17-0147267',
'CM17-0147273',
'CM17-0147279',
'CM17-0147283',
'CM17-0147293',
'CM17-0147295',
'CM17-0147297',
'CM17-0147307',
'CM17-0147313',
'CM17-0147314',
'CM17-0147315',
'CM17-0147317',
'CM17-0147318',
'CM17-0147325',
'CM17-0147333',
'CM17-0147362',
'CM17-0147368',
'CM17-0147369',
'CM17-0147373',
'CM17-0147379',
'CM17-0147384',
'CM17-0147392',
'CM17-0147393',
'CM17-0147398',
'CM17-0147416',
'CM17-0147425',
'CM17-0147435',
'CM17-0147442',
'CM17-0147451',
'CM17-0147463',
'CM17-0147483',
'CM17-0147485',
'CM17-0147490',
'CM17-0147497',
'CM17-0147503',
'CM17-0147541',
'CM17-0147543',
'CM17-0147563',
'CM17-0147611',
'CM17-0147635',
'CM17-0147659',
'CM17-0147707',
'CM17-0147815',
'CM17-0147909',
'CM17-0147934',
'CM17-0147973',
'CM17-0148038',
'CM17-0148200',
'CM17-0148250',
'CM17-0148339',
'CM17-0148601',
'CM17-0148627',
'CM17-0148632',
'CM17-0148687',
'CM17-0148736',
'CM17-0148744',
'CM17-0148753',
'CM17-0148757',
'CM17-0148884',
'CM17-0148912',
'CM17-0148952',
'CM17-0149031',
'CM17-0149070',
'CM17-0149125',
'CM17-0149212',
'CM17-0149224',
'CM17-0149556',
'CM17-0149595',
'CM17-0149596',
'CM17-0149760',
'CM17-0149931',
'CM17-0149968',
'CM17-0149976',
'CM17-0149996',
'CM17-0149999',
'CM17-0150004',
'CM17-0150016',
'CM17-0150040',
'CM17-0150076',
'CM17-0150465',
'CM17-0150493',
'CM17-0150513',
'CM17-0150520',
'CM17-0150647',
'CM17-0150690',
'CM17-0151027',
'CM17-0151425',
'CM17-0151431',
'CM17-0151496',
'CM17-0151516',
'CM17-0151538',
'CM17-0151579',
'CM17-0152292',
'CM17-0152458',
'CM17-0152669',
'CM17-0152675',
'CM17-0152678',
'CM17-0152686',
'CM17-0152693',
'CM17-0152696',
'CM17-0152697',
'CM17-0152700',
'CM17-0152711',
'CM17-0152712',
'CM17-0152713',
'CM17-0152716',
'CM17-0152725',
'CM17-0152731',
'CM17-0152756',
'CM17-0152762',
'CM17-0152773',
'CM17-0152850',
'CM17-0152859',
'CM17-0152876',
'CM17-0152979',
'CM17-0153038',
'CM17-0153060',
'CM17-0153089',
'CM17-0153504',
'CM17-0153528',
'CM17-0153541',
'CM17-0153557',
'CM17-0153590',
'CM17-0153644',
'CM17-0153666',
'CM17-0153681',
'CM17-0153712',
'CM17-0153810',
'CM17-0153813'
);

COMMIT;