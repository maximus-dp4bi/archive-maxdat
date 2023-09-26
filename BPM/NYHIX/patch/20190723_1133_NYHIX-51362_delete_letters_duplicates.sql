Alter session set current_schema=MAXDAT;

create table letters_dupes as 
select  letter_id AS LETTER_ID,count(*) COUNT from  letters_stg
group by LETTER_ID
having count(*)>1;

create table letter_dupes_cleaned as
select distinct * from letters_stg where letter_id in (  select distinct letter_id from letterS_dupes );

delete from letters_stg where letter_id in ( select letter_id from letters_dupes);

insert into letters_stg 
select * from letter_dupes_cleaned;


commit;

drop table letters_dupes ;

drop table letter_dupes_cleaned ;