CREATE OR REPLACE VIEW PUBLIC.F_PI_SEGMENTS_VW AS 
  SELECT 
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (rt.RAW:audioMuted as BOOLEAN) as audioMuted,
  cast (rt.RAW:conference as BOOLEAN) as conference,             
  cast (rt.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (rt.RAW:disconnecttype as VARCHAR(255)) as disconnectType, 
  c.errorid AS errorId,
  cast (rt.RAW:errorCode as VARCHAR(255)) as errorCode,  
  cast (rt.RAW:participantid as VARCHAR(255)) as participantId,  
  cast (rt.RAW:queueId as VARCHAR(255)) as queueId, 
  cast (rt.RAW:segmentduration as INT) as segmentDuration,
  cast (rt.RAW:segmentEndTime as DATETIME) as segmentEndTime,
  cast (rt.RAW:segmentEndTime as DATE) as segmentEndDate,            
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:segmentEndTime as DATETIME)) as projectSegmentEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:segmentEndTime as DATETIME))) as projectSegmentEndDate,             
  cast (rt.RAW:segmentStartTime as DATETIME) as segmentStartTime,
  cast (rt.RAW:segmentStartTime as DATE) as segmentStartDate,           
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:segmentStartTime as DATETIME)) as projectSegmentStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:segmentStartTime as DATETIME))) as projectSegmentStartDate,            
  cast (rt.RAW:segmenttype as VARCHAR(255)) as segmentType, 
  cast (rt.RAW:sessionId as VARCHAR(255)) as sessionId, 
  cast (rt.RAW:subject as VARCHAR(255)) as subject, 
  --cast (rt.RAW:wrapUpNote as VARCHAR(255)) as wrapUpNote, 
  cast (rt.RAW:wrapupCode as VARCHAR(255)) as wrapupCode 
  from RAW.SEGMENTS rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId
JOIN raw.C_SOURCE_ERROR_CODES C
ON rt.RAW:errorCode=c.ERRORCODE 