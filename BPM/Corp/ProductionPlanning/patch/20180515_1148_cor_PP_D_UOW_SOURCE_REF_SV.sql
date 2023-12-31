CREATE OR REPLACE VIEW PP_D_UOW_SOURCE_REF_SV AS
SELECT USR_ID, 
     UOW_ID, 
     SOURCE_REF_TYPE_ID, 
     SOURCE_REF_VALUE, 
     SOURCE_REF_DETAIL_IDENTIFIER, 
     EFFECTIVE_DATE, 
     END_DATE,
     SOURCE_REF_ID
	 FROM PP_D_UOW_SOURCE_REF
WITH READ ONLY;

grant select on PP_D_UOW_SOURCE_REF_SV to MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW PP_D_UOW_MW_SV AS
   SELECT USR.UOW_ID, USR.SOURCE_REF_VALUE AS TASK_TYPE, TT.TASK_TYPE_ID
   FROM PP_D_SOURCE_REF_TYPE SRT
   INNER JOIN PP_D_SOURCE S ON SRT.SOURCE_ID = S.SOURCE_ID
   INNER JOIN PP_D_UOW_SOURCE_REF USR ON SRT.SOURCE_REF_TYPE_ID = USR.SOURCE_REF_TYPE_ID
   INNER JOIN D_TASK_TYPES TT ON USR.SOURCE_REF_ID=TT.TASK_TYPE_ID
   WHERE S.SOURCE_NAME = 'MANAGE WORK STG'
   AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE';
   
grant select on PP_D_UOW_MW_SV to MAXDAT_READ_ONLY;
