ALTER TABLE TS_AUDIT
  ADD (AUDIT_CALL_DURATION_SS         number(2),
	   AUDIT_CALL_DURATION_MM         number(2),
	   AUDIT_CALL_DURATION_HH         number(2));
	   
ALTER TABLE AIU_TS_AUDIT
  ADD (AUDIT_CALL_DURATION_SS         number(2),
	   AUDIT_CALL_DURATION_MM         number(2),
	   AUDIT_CALL_DURATION_HH         number(2));