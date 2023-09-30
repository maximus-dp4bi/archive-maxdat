INSERT INTO DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP (
   SC_ALL_ID, ABSENCE_TYPE, POINT_VALUE, 
   END_DATE, CREATE_BY, CREATE_DATETIME, 
   INCENTIVE_FLAG, PERFECT_ATTENDANCE_FLAG) 
VALUES ( 
 SEQ_SCAL_ID.Nextval /* SC_ALL_ID */,
'Flex Time (0)' /* ABSENCE_TYPE */,
0 /* POINT_VALUE */,
to_date('7/7/2077','dd/mm/yyyy') /* END_DATE */,
'NYHIX-35068' /* CREATE_BY */,
sysdate /* CREATE_DATETIME */,
null /* INCENTIVE_FLAG */,
null /* PERFECT_ATTENDANCE_FLAG */ );
 

INSERT INTO DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP (
   SC_ALL_ID, ABSENCE_TYPE, POINT_VALUE, 
   END_DATE, CREATE_BY, CREATE_DATETIME, 
   INCENTIVE_FLAG, PERFECT_ATTENDANCE_FLAG) 
VALUES ( 
SEQ_SCAL_ID.Nextval /* SC_ALL_ID */,
'Kudos Points (4)' /* ABSENCE_TYPE */,
4 /* POINT_VALUE */,
to_date('7/7/2077','dd/mm/yyyy') /* END_DATE */,
'NYHIX-35068' /* CREATE_BY */,
sysdate /* CREATE_DATETIME */,
null /* INCENTIVE_FLAG */,
'Y' /* PERFECT_ATTENDANCE_FLAG */ );
 

commit; 
 