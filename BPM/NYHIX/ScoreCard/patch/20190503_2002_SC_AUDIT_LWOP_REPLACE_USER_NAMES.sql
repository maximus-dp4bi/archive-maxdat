set echo on

set verify on

-----------------------------------------------------
-- The purpose of this script is to update the
-- LWOP_CREATE_USER nad LWOP_UPDATE_USER in
-- SC_AUDIT_LWOP and SC_AUDIT_LWOP_AUD from a NAME
-- to the correct NATIONAL_ID.
-----------------------------------------------------

-- CREATE A BACKUP TABLE
CREATE TABLE DP_SCORECARD.SC_AUDIT_LWOP_20190503_BAK
AS SELECT * FROM SC_AUDIT_LWOP;

Grant select on DP_SCORECARD.SC_AUDIT_LWOP_20190503_BAK tp dp_scorecard_read_only;
Grant select on DP_SCORECARD.SC_AUDIT_LWOP_20190503_BAK tp maxdat_read_only;

CREATE TABLE DP_SCORECARD.SC_AUDIT_LWOP_AUD_20190503_BAK
AS SELECT * FROM SC_AUDIT_LWOP_AUD;

Grant select on DP_SCORECARD.SC_AUDIT_LWOP_AUD_20190503_BAK tp dp_scorecard_read_only;
Grant select on DP_SCORECARD.SC_AUDIT_LWOP_AUD_20190503_BAK tp maxdat_read_only;

-----------------------------------------------------

ALTER TABLE DP_SCORECARD.SC_AUDIT_LWOP
DISABLE ALL TRIGGERS;

-----------------------------------------------------

UPDATE DP_SCORECARD.SC_AUDIT_LWOP LWOP
SET 
	LWOP_CREATE_USER = 
(	SELECT DISTINCT STAFF.NATIONAL_ID--,
          --  LAST_NAME||', '||FIRST_NAME AS STAFF_NAME
			FROM DP_SCORECARD.SC_HIERARCHY_STAFF STAFF
            JOIN DP_SCORECARD.SC_HIERARCHY_STAFF_TO_JOB JOB
            ON STAFF.STAFF_ID = JOB.STAFF_ID
            WHERE NVL(JOB_LEVEL,0) > 1
            AND STAFF.LAST_NAME||', '||FIRST_NAME = LWOP_CREATE_USER
		) 
WHERE LWOP_CREATE_USER 
IN ( 	SELECT DISTINCT 
            LAST_NAME||', '||FIRST_NAME AS STAFF_NAME
			FROM DP_SCORECARD.SC_HIERARCHY_STAFF STAFF
            JOIN DP_SCORECARD.SC_HIERARCHY_STAFF_TO_JOB JOB
            ON STAFF.STAFF_ID = JOB.STAFF_ID
            WHERE NVL(JOB_LEVEL,0) > 1
	);

COMMIT;	

UPDATE DP_SCORECARD.SC_AUDIT_LWOP LWOP
SET 
	LWOP_UPDATE_USER = 
(	SELECT DISTINCT STAFF.NATIONAL_ID--,
          --  LAST_NAME||', '||FIRST_NAME AS STAFF_NAME
			FROM DP_SCORECARD.SC_HIERARCHY_STAFF STAFF
            JOIN DP_SCORECARD.SC_HIERARCHY_STAFF_TO_JOB JOB
            ON STAFF.STAFF_ID = JOB.STAFF_ID
            WHERE NVL(JOB_LEVEL,0) > 1
            AND STAFF.LAST_NAME||', '||FIRST_NAME = LWOP_UPDATE_USER
		) 
WHERE LWOP_UPDATE_USER 
IN ( 	SELECT DISTINCT 
            LAST_NAME||', '||FIRST_NAME AS STAFF_NAME
			FROM DP_SCORECARD.SC_HIERARCHY_STAFF STAFF
            JOIN DP_SCORECARD.SC_HIERARCHY_STAFF_TO_JOB JOB
            ON STAFF.STAFF_ID = JOB.STAFF_ID
            WHERE NVL(JOB_LEVEL,0) > 1
	);
	
COMMIT;	
	
-------------------------------------------

UPDATE DP_SCORECARD.SC_AUDIT_LWOP_AUD LWOP
SET 
	LWOP_CREATE_USER = 
(	SELECT DISTINCT STAFF.NATIONAL_ID--,
          --  LAST_NAME||', '||FIRST_NAME AS STAFF_NAME
			FROM DP_SCORECARD.SC_HIERARCHY_STAFF STAFF
            JOIN DP_SCORECARD.SC_HIERARCHY_STAFF_TO_JOB JOB
            ON STAFF.STAFF_ID = JOB.STAFF_ID
            WHERE NVL(JOB_LEVEL,0) > 1
            AND STAFF.LAST_NAME||', '||FIRST_NAME = LWOP_CREATE_USER
		) 
WHERE LWOP_CREATE_USER 
IN ( 	SELECT DISTINCT 
            LAST_NAME||', '||FIRST_NAME AS STAFF_NAME
			FROM DP_SCORECARD.SC_HIERARCHY_STAFF STAFF
            JOIN DP_SCORECARD.SC_HIERARCHY_STAFF_TO_JOB JOB
            ON STAFF.STAFF_ID = JOB.STAFF_ID
            WHERE NVL(JOB_LEVEL,0) > 1
	);

COMMIT;	

UPDATE DP_SCORECARD.SC_AUDIT_LWOP_AUD LWOP
SET 
	LWOP_UPDATE_USER = 
(	SELECT DISTINCT STAFF.NATIONAL_ID--,
          --  LAST_NAME||', '||FIRST_NAME AS STAFF_NAME
			FROM DP_SCORECARD.SC_HIERARCHY_STAFF STAFF
            JOIN DP_SCORECARD.SC_HIERARCHY_STAFF_TO_JOB JOB
            ON STAFF.STAFF_ID = JOB.STAFF_ID
            WHERE NVL(JOB_LEVEL,0) > 1
            AND STAFF.LAST_NAME||', '||FIRST_NAME = LWOP_UPDATE_USER
		) 
WHERE LWOP_UPDATE_USER 
IN ( 	SELECT DISTINCT 
            LAST_NAME||', '||FIRST_NAME AS STAFF_NAME
			FROM DP_SCORECARD.SC_HIERARCHY_STAFF STAFF
            JOIN DP_SCORECARD.SC_HIERARCHY_STAFF_TO_JOB JOB
            ON STAFF.STAFF_ID = JOB.STAFF_ID
            WHERE NVL(JOB_LEVEL,0) > 1
	);
	
COMMIT;	

----------------------------------------------------------------------
----------------------------------------------------------------------
-- This second set of updates catches any lwop_create_user 
-- or lwop_update_user not done above
----------------------------------------------------------------------
----------------------------------------------------------------------

alter table sc_audit_lwop
disable all triggers;

update sc_audit_lwop lwop
set lwop_create_user = ( 
select distinct national_id
from sc_hierarchy_staff
where last_name||', '||first_name = lwop_create_user
)
where lwop_create_user 
in ( 
    select lwop_create_user from sc_audit_lwop -- Gonzalez, Hiran
    minus
    select national_id from sc_hierarchy_staff
    )
and lwop_create_user
in (
select distinct last_name||', '||first_name as staff_name 
from sc_hierarchy_staff
);

commit;

update sc_audit_lwop lwop
set lwop_update_user = ( 
select distinct national_id
from sc_hierarchy_staff
where last_name||', '||first_name = lwop_update_user
)
where lwop_update_user 
in ( 
    select lwop_update_user from sc_audit_lwop -- Gonzalez, Hiran
    minus
    select national_id from sc_hierarchy_staff
    )
and lwop_update_user
in (
select distinct last_name||', '||first_name as staff_name 
from sc_hierarchy_staff
);

commit;

-------------------------------------------------------------------------
----------------------------------------------------------------------

update sc_audit_lwop_aud lwop
set lwop_create_user = ( 
select distinct national_id
from sc_hierarchy_staff
where last_name||', '||first_name = lwop_create_user
)
where lwop_create_user 
in ( 
    select lwop_create_user from sc_audit_lwop_aud -- Gonzalez, Hiran
    minus
    select national_id from sc_hierarchy_staff
    )
and lwop_create_user
in (
select distinct last_name||', '||first_name as staff_name 
from sc_hierarchy_staff
);

commit;

update sc_audit_lwop_aud lwop
set lwop_update_user = ( 
select distinct national_id
from sc_hierarchy_staff
where last_name||', '||first_name = lwop_update_user
)
where lwop_update_user 
in ( 
    select lwop_update_user from sc_audit_lwop_aud -- Gonzalez, Hiran
    minus
    select national_id from sc_hierarchy_staff
    )
and lwop_update_user
in (
select distinct last_name||', '||first_name as staff_name 
from sc_hierarchy_staff
);

commit;

-----------------------------------------------------

update dp_scorecard.sc_audit_lwop
set lwop_create_user = 59175
where lwop_create_user = 'Bigler, Trisha';

update dp_scorecard.sc_audit_lwop
set lwop_update_user = 59175
where lwop_update_user = 'Bigler, Trisha';

update dp_scorecard.sc_audit_lwop_aud
set lwop_create_user = 59175
where lwop_create_user = 'Bigler, Trisha';

update dp_scorecard.sc_audit_lwop_aud
set lwop_update_user = 59175
where lwop_update_user = 'Bigler, Trisha';

commit;

-------------------------------------------------

ALTER TABLE DP_SCORECARD.SC_AUDIT_LWOP
ENABLE ALL TRIGGERS;



