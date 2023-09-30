

alter session set current_schema = MAXDAT;

CREATE TABLE COVERKIDS_cumulative_stg(
            household_id VARCHAR2(30)
            ,home_phone_number VARCHAR2(20)
            ,home_phone_type_cd VARCHAR2(2)
            ,st_reported_phone VARCHAR2(20)
            ,st_phone_type_cd VARCHAR2(2)
            ,other_phone_number VARCHAR2(20)
            ,other_phone_type VARCHAR2(2)
            ,pregnancy VARCHAR2(1)
            ,income_amount NUMBER
            ,income_frequency VARCHAR2(15)
            ,household_size NUMBER
            ) TABLESPACE MAXDAT_DATA;


--once table is populated, run the script below
DECLARE  
  CURSOR temp_cur IS 
    select distinct cs.client_id,ck.application_id,s.* 
    from coverkids_cumulative_stg s
     join (select client_id
             ,case when supplemental_nbr is not null then supplemental_nbr else clnt_cin end household_id
       from client_stg) cs on s.household_id = cs.household_id
     join coverkids_approval_stg ck on cs.client_id = ck.client_id;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE coverkids_approval_stg
         SET 		pregnancy	=	temp_tab(indx).pregnancy
                ,income_amount = temp_tab(indx).income_amount
                ,income_frequency = temp_tab(indx).income_frequency
                ,household_size = temp_tab(indx).household_size
                ,home_phone_type_cd = temp_tab(indx).home_phone_type_cd
                ,home_phone_number = temp_tab(indx).home_phone_number
                ,st_phone_type_cd = temp_tab(indx).st_phone_type_cd
                ,st_reported_phone = temp_tab(indx).st_reported_phone
                ,other_phone_type = temp_tab(indx).other_phone_type
                ,other_phone_number = temp_tab(indx).other_phone_number
         WHERE application_id = temp_tab(indx).application_id
         AND client_id = temp_tab(indx).client_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

--drop temp table
drop table COVERKIDS_cumulative_stg;