Alter table MAXDAT.NYHBE_ETL_PROCESS_APPEALS 
MODIFY  (APL_OUTRCH_OUTCM VARCHAR2(80 BYTE), 
	     APL_RSN_FR_WTHDRWL VARCHAR2(80 BYTE));
	
Alter table MAXDAT.NYHBE_PROCESS_APPEALS_OLTP 
MODIFY  (APL_OUTRCH_OUTCM VARCHAR2(80 BYTE), 
	     APL_RSN_FR_WTHDRWL VARCHAR2(80 BYTE));
	
Alter table MAXDAT.NYHBE_PROCESS_APPEALS_WIP_BPM 
MODIFY  (APL_OUTRCH_OUTCM VARCHAR2(80 BYTE), 
	     APL_RSN_FR_WTHDRWL VARCHAR2(80 BYTE));

Alter table MAXDAT.D_APPEALS_CURRENT 
MODIFY (APL_OUTRCH_OUTCM VARCHAR2(80 BYTE), 
	APL_RSN_FR_WTHDRWL VARCHAR2(80 BYTE));
			
ALTER TABLE MAXDAT.F_APPEALS_BY_DATE 
MODIFY (APL_OUTRCH_OUTCM VARCHAR2(80 BYTE), 
	APL_RSN_FR_WTHDRWL VARCHAR2(80 BYTE));