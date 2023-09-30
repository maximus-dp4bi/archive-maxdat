--
-- Generated for Oracle 10g on Fri Jun 01  08:58:02 2012 by Server Generator 9.0.2.95.9
 

PROMPT Creating View 'STAFF_LKUP'
CREATE OR REPLACE VIEW MAXDAT.STAFF_LKUP AS
Select Staff_id, First_Name, Last_Name, Middle_Name
       ,TRIM(LAST_NAME) || DECODE(LAST_NAME, NULL, NULL, ',') || TRIM(FIRST_NAME) || RTRIM(LPAD(SUBSTR(MIDDLE_NAME, 1, 1),2, ' ')) AS Display_Name
From
        (
        SELECT TO_CHAR(staff_id) Staff_ID, First_Name, Last_Name, Middle_Name FROM STAFF_stg
         UNION
        SELECT 'IMG' Staff_ID, 'IMG' First_Name, '' Last_Name, '' Middle_Name FROM DUAL
         UNION
        SELECT '' Staff_ID, '' First_Name, '' Last_Name, '' Middle_Name FROM DUAL S6
        ) Staff_View

/