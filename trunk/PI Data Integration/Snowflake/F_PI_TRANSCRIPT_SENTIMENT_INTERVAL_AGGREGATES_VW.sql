-- PUREINSIGHTS_UAT."PUBLIC".F_PI_TRANSCRIPT_SENTIMENT_INTERVAL_AGGREGATES_VW source

CREATE OR REPLACE VIEW F_PI_TRANSCRIPT_SENTIMENT_INTERVAL_AGGREGATES_VW AS
  SELECT  cast (cd.PROJECTID as varchar(255)) as projectid,
  cast (cd.PROJECTNAME as varchar(255)) as projectname,
  cast (cd.PROGRAMID as varchar(255)) as programid,
  cast (cd.PROGRAMNAME as varchar(255)) as programname,
  cast (intervalStart as datetime) as intervalStart,
    cast (intervalStart as date) as intervalStartDate,             
    convert_timezone('UTC',pr.projectTimezone,cast (cd.intervalStart as DATETIME)) as projectintervalStart,
    to_date(convert_timezone('UTC',pr.projectTimezone,cast (cd.intervalStart as DATETIME))) as projectintervalStartDate, 
  cast (queuename as varchar(255)) as queuename,
  cast (direction as varchar(255)) as direction,  
  cast (mediaType as varchar(255)) as mediaType,  
  CAST(CUSTOMERSENTIMENTCOUNT AS INT) AS CUSTOMERSENTIMENTCOUNT, 
  CAST(CUSTOMERSENTIMENTMIN  AS INT) AS CUSTOMERSENTIMENTMIN, 
  CAST(CUSTOMERSENTIMENTMAX  AS INT) AS CUSTOMERSENTIMENTMAX, 
  CAST(CUSTOMERSENTIMENTSUM  AS INT) AS CUSTOMERSENTIMENTSUM, 
  CAST(CUSTOMERSENTIMENTCOUNTNEGATIVE AS INT) AS CUSTOMERSENTIMENTCOUNTNEGATIVE, 
  CAST(CUSTOMERSENTIMENTCOUNTPOSITIVE  AS INT) AS CUSTOMERSENTIMENTCOUNTPOSITIVE
  FROM RAW.TRANSCRIPT_SENTIMENT_INTERVAL_AGGREGATES cd
  join PUBLIC.D_PI_PROJECTS pr
  on cd.projectId = pr.projectId;