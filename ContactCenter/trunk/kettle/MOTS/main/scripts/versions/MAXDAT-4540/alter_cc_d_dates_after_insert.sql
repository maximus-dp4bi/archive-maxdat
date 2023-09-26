update CC_D_DATES set FISCAL_YEAR=(case when D_MONTH_NUM in ('10','11','12') then to_char(to_number(D_YEAR+1)) else D_YEAR end) where d_date  >= to_date('01/01/2018', 'mm/dd/yyyy');
update CC_D_DATES set FISCAL_QUARTER=(case when D_MONTH_NUM in ('10','11','12') then '1'
when D_MONTH_NUM in ('01','02','03') then '2'
when D_MONTH_NUM in ('04','05','06') then '3'
when D_MONTH_NUM in ('07','08','09') then '4'
else '0'
end) where d_date  >= to_date('01/01/2018', 'mm/dd/yyyy');

commit;

alter table CC_D_DATES modify FISCAL_YEAR VARCHAR2(4) NOT NULL;
alter table CC_D_DATES modify FISCAL_QUARTER VARCHAR2(1) NOT NULL;