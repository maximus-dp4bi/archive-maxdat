-- Added 3 new columns STATECHANGEDATE,	EMPLOYEETYPE, HIREDATE to the existing view;

create or replace view D_PI_USER_DETAILS_VW(
	PROJECTID,
	PROJECTNAME,
	PROGRAMID,
	PROGRAMNAME,
	DEPARTMENT,
	DIVISIONID,
	DIVISIONNAME,
	EMAIL,
	EMPLOYEEID,
	ID,
	MANAGERID,
	MANAGERNAME,
	NAME,
	STATE,
	TITLE,
	STATECHANGEREASON,
	STATECHANGEDATE,
	EMPLOYEETYPE,
	HIREDATE
) as 
  select
  UD.projectId as projectId,
  UD.projectName as projectName,
  UD.programId as programId,
  UD.programName as programName,
  cast (UD.RAW:department as VARCHAR(255)) as department,
  cast (UD.RAW:divisionId as VARCHAR(255)) as divisionId,
  cast (UD.RAW:divisionName as VARCHAR(255)) as divisionName,
  cast (UD.RAW:email as VARCHAR(255)) as email,
  cast (UD.RAW:employeeId as VARCHAR(255)) as employeeId,
  cast (UD.RAW:id as VARCHAR(255)) as id,
  cast (UD.RAW:managerId as VARCHAR(255)) as managerId,
  cast (CO.RAW:name as VARCHAR(255)) as managerName,
  cast (UD.RAW:name as VARCHAR(255)) as name,
  cast (UD.RAW:state as VARCHAR(255)) as state,
  cast (UD.RAW:title as VARCHAR(255)) as title, 
  cast (UD.RAW:stateChangeReason as VARCHAR(255)) as stateChangeReason,
  CAST (UD.RAW:stateChangeDate as VARCHAR(255)) AS stateChangeDate,
  CAST (UD.RAW:employeeType  as VARCHAR(255)) AS employeeType,
  CAST (UD.RAW:hireDate as VARCHAR(255)) AS hireDate
 from PUREINSIGHTS_PRD.RAW.USER_DETAILS UD
 left outer join PUREINSIGHTS_PRD.RAW.CONFIGURATION_OBJECTS CO
 on UD.RAW:managerId = CO.RAW:id
 and CO.RAW:type = 'user'
 and UD.projectid = CO.projectid;