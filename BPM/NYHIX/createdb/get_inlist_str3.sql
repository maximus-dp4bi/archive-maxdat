create or replace function maxdat.get_inlist_str3(in_name varchar,in_list_type varchar)
/*
Description:
This function returns the CSV format of ref_ids from the Global control table, corp_etl_list_lkup.

v1 Somnath Ganguly  Unknown      Initial creation.
v2 Raj A.           05-Feb-2013  Modified for Process MI.
*/
return varchar2 is
    inlist_var   VARCHAR2(4000);
    vfirst       VARCHAR2(1) := 'Y';
BEGIN
    inlist_var := NULL;
    FOR i IN (select *
                from corp_etl_list_lkup
                where name = in_name)
    LOOP
        IF in_list_type = 'S' THEN
            IF vfirst = 'Y' THEN
                inlist_var := '''' || i.ref_id || '''';
                vfirst     := 'N';
            ELSE
                inlist_var := inlist_var || ',' || '''' || i.ref_id || '''';
            END IF;
        ELSIF in_list_type = 'N' THEN
            IF vfirst = 'Y' THEN
                inlist_var := i.ref_id;
                vfirst     := 'N';
            ELSE
                inlist_var := inlist_var || ',' || i.ref_id;
            END IF;
        ELSE
            inlist_var := 'BAD_STRING';
        END IF;
    END LOOP;
    --dbms_output.put_line(inlist_var);
    return inlist_var;
END;
/