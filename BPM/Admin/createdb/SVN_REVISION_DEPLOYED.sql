create or replace view SVN_REVISION_DEPLOYED as
select
  ao.OWNER,
  ao.OBJECT_NAME "PACKAGE_NAME",
  apos.PLSQL_CODE_TYPE,
  SVN_REVISION_KEYWORD.GET_SVN_REVISION(ao.OBJECT_NAME) "SVN_REVISION",
  SVN_REVISION_KEYWORD.GET_SVN_REVISION_DATE(ao.OBJECT_NAME) "SVN_REVISION_DATE",
  SVN_REVISION_KEYWORD.GET_SVN_REVISION_AUTHOR(ao.OBJECT_NAME) "SVN_REVISION_AUTHOR",
  SVN_REVISION_KEYWORD.GET_SVN_FILE_URL(ao.OBJECT_NAME) "SVN_FILE_URL"
from ALL_OBJECTS ao
inner join ALL_PLSQL_OBJECT_SETTINGS apos on (
  ao.OWNER = 'MAXDAT'
  and ao.OBJECT_TYPE = 'PACKAGE' 
  and ao.OBJECT_NAME not like 'BIN$%' 
  and ao.OBJECT_NAME not like 'CG$%' 
  and ao.OBJECT_NAME = apos.NAME
  and apos.OWNER = 'MAXDAT'
  and apos.TYPE = 'PACKAGE')
with read only;

-- Example usage:

/*
select
  PACKAGE_NAME,
  PLSQL_CODE_TYPE,
  SVN_REVISION,
  SVN_REVISION_DATE,
  SVN_REVISION_AUTHOR,
  SVN_FILE_URL
from SVN_REVISION_DEPLOYED
order by PACKAGE_NAME asc;
*/

grant select on SVN_REVISION_DEPLOYED to MAXDAT_READ_ONLY;