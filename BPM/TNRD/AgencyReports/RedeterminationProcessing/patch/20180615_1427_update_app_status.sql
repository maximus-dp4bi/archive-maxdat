Update MAXDAT.TN_CI_REDETERMINATION
set MAXE_ATS_APPLICATION_STATUS='COMPLETED' 
where application_id in (
198981,
255912,
339155,
372292,
383856,
398678,
427956,
486261,
515653,
532201,
536519,
537402,
560781,
561864,
580920,
580953,
596802,
597060,
613669,
620304,
632375,
634390,
638273,
647456,
649882,
662513,
706806,
711280,
726919,
728787,
729110,
733622,
736854,
736999,
749759,
750909,
755201,
755894,
756981,
760849,
765923,
777849,
778179,
789159,
794188,
802680,
809456,
816640,
826648,
833973,
835908,
844169,
846384,
866081,
873881,
874119,
876661,
881517,
884227,
884286,
884684,
891206,
894378,
897136,
911433,
917705,
918852,
935724,
941342,
975020,
975684,
1017808,
1031979,
1036856,
1058936,
1060665,
1065490,
1072188,
1076185);

Update MAXDAT.TN_CI_REDETERMINATION
set MAXE_ATS_APPLICATION_STATUS='DISREGARDED' 
where application_id =810807;

Commit;