CREATE OR REPLACE FUNCTION get_business_date (p_start_date DATE, p_num_days NUMBER)
RETURN DATE
AS
v_business_date DATE;

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

BEGIN
  SELECT d_date
  INTO v_business_date
  FROM (
    SELECT d_date,row_number() OVER (ORDER BY d_date) rnum
    FROM (
      SELECT *
      FROM
        ( SELECT p_start_date + ROWNUM d_date
          FROM DUAL CONNECT BY ROWNUM <=  50)
          WHERE to_char(d_date,'D') not in ('1','7') 
          AND NOT EXISTS(SELECT 1 FROM holidays h WHERE h.holiday_date = d_date) ) d_dates_tab
    WHERE d_date > p_start_date
    GROUP by d_date)
  WHERE rnum = p_num_days;  
 
 RETURN v_business_date;
EXCEPTION
  WHEN OTHERS THEN
    RETURN NULL;
END;
/

grant execute on get_business_date to MAXDAT_READ_ONLY;
