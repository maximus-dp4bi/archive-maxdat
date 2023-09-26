TRUNCATE TABLE DP_SCORECARD.SC_AUDIT_LWOP;
COMMIT;
----------------------------------------------------
ALTER TABLE DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
ADD LWOP_FLAG  VARCHAR2(5) DEFAULT 'N/A';
COMMIT;
----------
UPDATE DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
SET LWOP_FLAG = 'START'
WHERE SC_ALL_ID 
	IN 	(  -- LEAVE START
		SELECT SC_ALL_ID FROM DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP 
		where absence_type = 'Extended Leave (0)'
		union select SC_ALL_ID from dp_scorecard.SC_ATTENDANCE_ABSENCE_LKUP 
		where absence_type = 'FMLA Continuous (0)'
		union select SC_ALL_ID from dp_scorecard.SC_ATTENDANCE_ABSENCE_LKUP 
		where absence_type = 'LWA Continuous (0)'
		union select SC_ALL_ID from dp_scorecard.SC_ATTENDANCE_ABSENCE_LKUP 
		where absence_type = 'Military leave | Management Approved - Documentation Confirmed (0)'
		union select SC_ALL_ID from dp_scorecard.SC_ATTENDANCE_ABSENCE_LKUP 
		where absence_type = 'PFL Continuous (0)'	
		union select SC_ALL_ID from dp_scorecard.SC_ATTENDANCE_ABSENCE_LKUP 
		where absence_type = 'PLOA (0)'
		);
COMMIT;

UPDATE DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
SET LWOP_FLAG = 'END'
WHERE SC_ALL_ID 
	IN  (  -- LEAVE_END 
		select SC_ALL_ID FROM DP_Scorecard.SC_ATTENDANCE_ABSENCE_LKUP 
		where absence_type = 'Return from Continuous Leave (FMLA/PLOA/LWA/PFL) (0)'
		union 
		select SC_ALL_ID from dp_scorecard.SC_ATTENDANCE_ABSENCE_LKUP 
		where absence_type = 'Return from Extended Leave (0)'
		);	

COMMIT;
