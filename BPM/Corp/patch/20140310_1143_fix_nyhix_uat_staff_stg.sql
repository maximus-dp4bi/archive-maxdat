create or replace view STAFF_STG as
select * from D_STAFF;

create or replace public synonym STAFF_STG for STAFF_STG;
grant select on STAFF_STG to MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW STAFF_LKUP AS
Select Staff_id, First_Name, Last_Name, Middle_Name
       ,TRIM(LAST_NAME) || DECODE(LAST_NAME, NULL, NULL, ',') || TRIM(FIRST_NAME) || RTRIM(LPAD(SUBSTR(MIDDLE_NAME, 1, 1),2, ' ')) AS Display_Name
From
        (
        SELECT TO_CHAR(staff_id) Staff_ID, First_Name, Last_Name, Middle_Name FROM D_STAFF
         UNION
        SELECT 'IMG' Staff_ID, 'IMG' First_Name, '' Last_Name, '' Middle_Name FROM DUAL
         UNION
        SELECT '' Staff_ID, '' First_Name, '' Last_Name, '' Middle_Name FROM DUAL S6
        ) Staff_View;


create or replace public synonym STAFF_LKUP for STAFF_LKUP;
grant select on STAFF_LKUP to MAXDAT_READ_ONLY;