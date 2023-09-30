delete from coverkids_approval_stg
where cumulative_ind IN('W', 'Y')
and application_id in(select application_id from coverkids_approval_stg
where trunc(create_date) = to_date('06/12/2018', 'MM/DD/YYYY') 
and cumulative_ind = 'N'
)AND APPLICATION_ID NOT IN(879668, 894110)  --Missing members 6/12; these 2 have blank effective dates
;


delete from coverkids_approval_stg
where trunc(create_date) = to_date('06/12/2018', 'MM/DD/YYYY') 
and cumulative_ind = 'N'
AND APPLICATION_ID NOT IN(879668, 894110) --Missing members 6/12; these 2 have blank effective dates
;


commit;

select * from coverkids_approval_stg
where application_id in(888137,
889554,
893722,
880038,
879959,
868930,
868966,
325284,
899075,
872074,
871941,
871935,
888468,
888556,
898265,
886177,
265508,
107582,
900919,
872156,
902186,
872387,
903159,
1154647,
915635,
901654,
870687,
257344,
915232,
915011,
865394,
881866,
901808,
915768,
917493,
972266,
900083,
891905,
906615,
868157,
900017,
1151889,
865763,
1153588,
899933,
880957,
894988,
1153501,
1153562,
819671,
885332,
887086,
883563,
1245153,
866760,
1152456,
1244817,
873455,
878818,
1244711,
872645,
1151580,
921187,
883417,
972249,
1245199,
876508,
904559,
972112,
896461,
877716,
900966,
882894,
889451,
919985,
884465,
1154533,
872277,
1154766,
1245227,
1245226,
890895,
1154407,
972081,
908395,
885284,
906997,
1245276,
896872,
904237,
1154646,
865410,
884906,
872902,
1151490,
1152954,
1153314,
1152904,
1154746,
908677,
1151680,
1153933,
1245279,
888921,
1151750,
1154551,
870267,
912568,
873292,
921347,
870205,
905093,
871791,
906018,
680022,
891318,
896968,
874265,
897383,
882322,
1152734,
880824,
871523,
1151522,
877806,
1152792,
1151960,
865119,
894833,
1245136,
873284,
1245299,
891897,
1152091,
1152892,
1151937,
895705,
901744,
878332,
898554,
874243,
868118,
892718,
898830,
202499,
899990,
1012705,
1154089,
1151493,
1110433,
1152282,
869360,
1153976,
874023,
906958,
919802,
885920,
1154452,
902408,
907622,
917158,
1152882,
869930,
880217,
880206,
900110,
882328,
1152858,
921501,
921505,
909192,
899469,
920676,
877328,
898661,
902755,
892181,
917055,
919561,
914041,
906520,
884259,
870781,
872287,
896950,
875317,
881271,
894135,
872829,
886935,
914206,
1154696,
1151492,
1152524,
918272,
883972,
884333,
1245252,
1245141,
1245131,
894964,
895042,
898787,
1153280,
879833,
889017,
1152450,
1151370,
1153866,
1153447,
1151605,
1153671,
1154816,
893427,
884233,
914551,
895785,
915645,
871694,
872252,
893471,
884913,
871343,
915876,
915897,
915971,
894611,
894256,
883831,
883684,
911582,
882405,
882503,
915418,
915350,
915305,
895575,
895348,
895491,
887250,
888155);

commit;