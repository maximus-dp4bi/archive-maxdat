-- drop and recreate sequences;

		DROP SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_SCORECARD_ID;

		CREATE SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_SCORECARD_ID
			START WITH 21000
			MAXVALUE 999999999999999999999999999
			MINVALUE 1
			NOCYCLE
			CACHE 20
			NOORDER
			NOKEEP
			GLOBAL;

		DROP SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_PAYROLL_ID;

		CREATE SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_PAYROLL_ID
			  START WITH 5000
			  MAXVALUE 999999999999999999999999999
			  MINVALUE 1
			  NOCYCLE
			  CACHE 20
			  NOORDER
			  NOKEEP
			  GLOBAL;


		GRANT SELECT ON DP_SCORECARD.SEQ_SC_AUDIT_PAYROLL_ID TO DP_SCORECARD_OLTP_SIU;

		GRANT SELECT ON DP_SCORECARD.SEQ_SC_AUDIT_PAYROLL_ID TO DP_SCORECARD_OLTP_SIUD;

		GRANT SELECT ON DP_SCORECARD.SEQ_SC_AUDIT_SCORECARD_ID TO DP_SCORECARD_OLTP_SIU;

		GRANT SELECT ON DP_SCORECARD.SEQ_SC_AUDIT_SCORECARD_ID TO DP_SCORECARD_OLTP_SIUD;


--	Enable the following triggers in UAT
	
		ALTER TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_PAYROLL ENABLE;

		ALTER TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_PAYROLL ENABLE;
	
		ALTER TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_SCORECARD ENABLE;

		ALTER TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_SCORECARD ENABLE;
