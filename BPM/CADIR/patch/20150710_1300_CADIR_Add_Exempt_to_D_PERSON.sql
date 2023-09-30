ALTER TABLE d_person
  ADD exempt_flag varchar2(1);
  
update d_person set exempt_flag='N' where 1=1; 


create or replace view d_person_sv as
select PERSON_ID, 
FIRST_NAME,
LAST_NAME,
MIDDLE_NAME,
NAME_TITLE,
NAME_SUFFIX,
LOGIN_NAME,
EXEMPT_FLAG  
from D_PERSON;
  
  
commit;

/  
