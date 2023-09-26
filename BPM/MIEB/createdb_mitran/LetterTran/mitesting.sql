create or replace procedure mitran_testing(
testing varchar2
, testdate date
)
as
begin
  insert into miTesting(comments,cdate) values(testing,testdate);
--raise_application_Error(-20101,'Testing call successful');
end;

grant execute on mitran_testing to MAXDAT_MITRAN_PFP_E;
grant execute on mitran_testing to MAXDAT_MITRAN_READ_ONLY;
grant execute on mitran_testing to MAXDAT_REPORTS;

drop table mitesting;

create table miTesting(
comments varchar2(100),
cdate date
);

grant insert,update on mitesting to maxdat_reports;

  insert into miTesting(comments) values('blah');

select * from miTesting;
