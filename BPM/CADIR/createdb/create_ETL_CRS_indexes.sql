create index CADIR_MAXDAT_STG_INDXCN on CADIR_MAXDAT_STG 
(
	C_CASE_NUMBER
)
TABLESPACE MAXDAT_INDX LOGGING;

create index CADIR_ROLE_STG_INDXRI on CADIR_ROLE_STG 
(
	ROLE_ID
)
TABLESPACE MAXDAT_INDX LOGGING;
