declare

v_str1 varchar2(200) := null;

cursor get_sql is
select
     'drop '||object_type||' '|| object_name|| DECODE(OBJECT_TYPE,'TABLE',' CASCADE CONSTRAINTS PURGE') v_str1
from user_objects
where object_type in ('TABLE','VIEW','PACKAGE','TYPE','PROCEDURE','FUNCTION','TRIGGER','SEQUENCE') 
order by object_type,object_name;

begin

open get_sql;

loop

fetch get_sql into v_str1;

          if get_sql%notfound
          then exit; 
          end if;

execute immediate v_str1;

end loop;

close get_sql;

end;
/