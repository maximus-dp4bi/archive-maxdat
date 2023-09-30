CREATE OR REPLACE VIEW PP_D_DATES_SV
AS SELECT D_DATE,
    D_MONTH,
    D_MONTH_NAME,
    D_DAY,
    D_DAY_NAME,
    D_DAY_OF_WEEK,
    D_DAY_OF_MONTH,
    D_DAY_OF_YEAR,
    D_YEAR,
    D_MONTH_NUM,
    D_WEEK_OF_YEAR,
    D_WEEK_OF_MONTH,
    WEEKEND_FLAG,
    TRUNC(D_DATE) as TRUNC_D_DATE,
    case
    when D_DAY_OF_WEEK in ('1','7') then 'N' 
    when D_DATE in (select holiday_date from holidays) then 'N'
    else 'Y'
    end BUSINESS_DAY_FLAG    
  FROM PP_D_DATES WITH READ ONLY;