CREATE OR REPLACE FORCE VIEW CC_D_DATES_SV as
SELECT
    D_DATE_ID,
    D_DATE,
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
    FISCAL_YEAR,
    FISCAL_QUARTER,
    case
        when trunc(D_DATE) = trunc(sysdate) then 'Y'
        else 'N'
        end TODAY,
      case
        when trunc(D_DATE) = trunc(sysdate - 1) then 'Y'
        else 'N'
    end YESTERDAY
    FROM CC_D_DATES;