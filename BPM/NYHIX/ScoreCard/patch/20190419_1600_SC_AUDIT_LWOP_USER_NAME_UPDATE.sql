-- CREATE A BACKUP TABLE
CREATE TABLE DP_SCORECARD.SC_AUDIT_LWOP_20190419_BAK
AS SELECT * FROM SC_AUDIT_LWOP;

CREATE TABLE DP_SCORECARD.SC_AUDIT_LWOP_AUD_20190419_BAK
AS SELECT * FROM SC_AUDIT_LWOP_AUD;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_LWOP_20190419_BAK TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_LWOP_AUD_20190419_BAK TO DP_SCORECARD_READ_ONLY;


ALTER TABLE DP_SCORECARD.SC_AUDIT_LWOP
DISABLE ALL TRIGGERS;

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
-- this set of updates catches any lwop_create_user or lwop_update_user
-- not done above
----------------------------------------------------------------------

alter table sc_audit_lwop
disable all triggers;

update sc_audit_lwop lwop
set lwop_create_user = ( 
select distinct national_id
--select distinct national_id, last_name||', '||first_name as staff_name 
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
--select distinct national_id, last_name||', '||first_name as staff_name 
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

update sc_audit_lwop_aud lwop
set lwop_create_user = ( 
select distinct national_id
--select distinct national_id, last_name||', '||first_name as staff_name 
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
--select distinct national_id, last_name||', '||first_name as staff_name 
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




ALTER TABLE DP_SCORECARD.SC_AUDIT_LWOP
ENABLE ALL TRIGGERS;



