--------------------------------------------------------
-- SEQUENCES --
--------------------------------------------------------
CREATE SEQUENCE  "MAXDAT"."SEQ_NYHIX_MFB_V2_SB_OLTP_ID"  
MINVALUE 1 MAXVALUE 9999999999999999999999999999 
INCREMENT BY 1 
START WITH 100 
CACHE 100 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

grant select on 	"MAXDAT"."SEQ_NYHIX_MFB_V2_SB_OLTP_ID" to maxdat_read_only;
GRANT SELECT ON "MAXDAT"."SEQ_NYHIX_MFB_V2_SB_OLTP_ID" TO "MAXDAT_OLTP_SIUD";
GRANT SELECT ON "MAXDAT"."SEQ_NYHIX_MFB_V2_SB_OLTP_ID" TO "MAXDAT_OLTP_SIU";

--------------------------------------------------------
--------------------------------------------------------
CREATE SEQUENCE  "MAXDAT"."SEQ_NYHIX_MFB_V2_SBM_OLTP_ID"  
MINVALUE 1 MAXVALUE 9999999999999999999999999999 
INCREMENT BY 1 
START WITH 100
CACHE 100 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

grant select on "MAXDAT"."SEQ_NYHIX_MFB_V2_SBM_OLTP_ID" to maxdat_read_only;
GRANT SELECT ON "MAXDAT"."SEQ_NYHIX_MFB_V2_SB_OLTP_ID" TO "MAXDAT_OLTP_SIUD";
GRANT SELECT ON "MAXDAT"."SEQ_NYHIX_MFB_V2_SBM_OLTP_ID" TO "MAXDAT_OLTP_SIUD";
GRANT SELECT ON "MAXDAT"."SEQ_NYHIX_MFB_V2_SBM_OLTP_ID" TO "MAXDAT_OLTP_SIU";

--------------------------------------------------------
--------------------------------------------------------
CREATE SEQUENCE  "MAXDAT"."SEQ_NYHIX_MFB_V2_SBML_OLTP_ID"  
MINVALUE 1 MAXVALUE 9999999999999999999999999999 
INCREMENT BY 1 
START WITH 100
CACHE 100 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

grant select on "MAXDAT"."SEQ_NYHIX_MFB_V2_SBML_OLTP_ID" to maxdat_read_only;
GRANT SELECT ON "MAXDAT"."SEQ_NYHIX_MFB_V2_SBML_OLTP_ID" TO "MAXDAT_OLTP_SIUD";
GRANT SELECT ON "MAXDAT"."SEQ_NYHIX_MFB_V2_SBML_OLTP_ID" TO "MAXDAT_OLTP_SIU";

--------------------------------------------------------
--------------------------------------------------------

CREATE SEQUENCE  "MAXDAT"."SEQ_NYHIX_MFB_V2_SFT_OLTP_ID"  
MINVALUE 1 MAXVALUE 9999999999999999999999999999 
INCREMENT BY 1 
START WITH 100 
CACHE 100 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

grant select on "MAXDAT"."SEQ_NYHIX_MFB_V2_SFT_OLTP_ID" to maxdat_read_only;
GRANT SELECT ON "MAXDAT"."SEQ_NYHIX_MFB_V2_SFT_OLTP_ID" TO "MAXDAT_OLTP_SIUD";
GRANT SELECT ON "MAXDAT"."SEQ_NYHIX_MFB_V2_SFT_OLTP_ID" TO "MAXDAT_OLTP_SIU";

