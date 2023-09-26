alter session set plsql_code_type = native;

-- Clear2Work
create or replace package CLEAR2WORK as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: $';
  SVN_REVISION varchar2(20) := '$Revision: $';
  SVN_REVISION_DATE varchar2(60) := '$Date: $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: $';

  procedure PROCESS_BADGE;
  
  procedure PROCESS_SURVEY;

end;
/

create or replace package body CLEAR2WORK as

  procedure PROCESS_BADGE
  as
  begin
  
  -- Remove unwanted strings.
  update CLEAR2WORK_BADGE
  set
    ACTIVITY_DATE = to_date(substr(DATE_TIME_RAW,1,instr(DATE_TIME_RAW,' ',1) - 1),'MM/DD/YY'),
    EVENT_USER = regexp_replace(EVENT_USER_RAW,' JR| Jr| SR| Sr|\\|/|-|;|,|\.| Employee Temp| #([0-9]+)| TTEC -','')
  where PROCESSED_FLAG = 'N';
  
  -- Remove duplicate rows.
  delete from CLEAR2WORK_BADGE
  where 
    rowid not in
      (select min(rowid)
       from CLEAR2WORK_BADGE
       where PROCESSED_FLAG = 'N'
       group by ACTIVITY_DATE,EVENT_USER)
    and PROCESSED_FLAG = 'N';
 
  -- Replace multiple spaces with single space.
  update CLEAR2WORK_BADGE
  set EVENT_USER = regexp_replace(EVENT_USER,'\\s+',' ')
  where PROCESSED_FLAG = 'N';
  
  update CLEAR2WORK_BADGE
  set
    FIRST_NAME = upper(substr(EVENT_USER,instr(EVENT_USER,':',1,1) + 2,(instr(EVENT_USER,' ',1,3) - instr(EVENT_USER,':',1,1)) - 2)),
    LAST_NAME = 
      case
        when instr(EVENT_USER,' De La ',1,1) != 0 then upper(substr(EVENT_USER,instr(EVENT_USER,' De La ',1,1) + 1,length(EVENT_USER) - instr(EVENT_USER,' De La ',1,1)))
        when instr(EVENT_USER,' De Los ',1,1) != 0 then upper(substr(EVENT_USER,instr(EVENT_USER,' De Los ',1,1) + 1,length(EVENT_USER) - instr(EVENT_USER,' De Los ',1,1)))
        when instr(EVENT_USER,' De  ',1,1) != 0 then upper(substr(EVENT_USER,instr(EVENT_USER,' De ',1,1) + 1,length(EVENT_USER) - instr(EVENT_USER,' De ',1,1)))
        when instr(EVENT_USER,' Van Der ',1,1) != 0 then upper(substr(EVENT_USER,instr(EVENT_USER,' Van Der ',1,1) + 1,length(EVENT_USER) - instr(EVENT_USER,' Van Der ',1,1)))
        when instr(EVENT_USER,' ',1,4) != 0 then upper(substr(EVENT_USER,instr(EVENT_USER,' ',1,3) + 1,(instr(EVENT_USER,' ',1,4) - 1) - instr(EVENT_USER,' ',1,3)))
        else upper(substr(EVENT_USER,instr(EVENT_USER,' ',1,3) + 1,length(EVENT_USER) - instr(EVENT_USER,' ',1,3)))
        end
  where PROCESSED_FLAG = 'N';
  
  update CLEAR2WORK_BADGE
  set
    EMPLOYEE_PSEUDO_KEY = substr(concat(regexp_replace(FIRST_NAME,'[^A-Z]|A|E|I|O|U| ',''),regexp_replace(LAST_NAME,'[^A-Z]|A|E|I|O|U| ','')),1,12),
    PROCESSED_FLAG = 'Y'
  where PROCESSED_FLAG = 'N';
  
  commit;
  
  end;
  
  procedure PROCESS_SURVEY
  as
  begin
  
  update CLEAR2WORK_SURVEY
  set
    SUBMISSION_DATE = to_date(substr(SUBMISSION_TIME_RAW,1,instr(SUBMISSION_TIME_RAW,' ',1,3) - 1),'Mon dd, YYYY'),
    ASSIGNEE = regexp_replace(ASSIGNEE_RAW,' JR| Jr| SR| Sr|\\|/|-|;|''|,|\.','')
  where PROCESSED_FLAG = 'N';
  
  update CLEAR2WORK_SURVEY
  set
      FIRST_NAME = upper(substr(ASSIGNEE,1,instr(ASSIGNEE,' ',1,1) - 1)),
      LAST_NAME = 
        case
          when instr(ASSIGNEE,' De La ',1,1) != 0 then upper(substr(ASSIGNEE,instr(ASSIGNEE,' De La ',1,1) + 1,(length(ASSIGNEE) - instr(ASSIGNEE,' De La ',1,1)) + 1))
          when instr(ASSIGNEE,' De Los ',1,1) != 0 then upper(substr(ASSIGNEE,instr(ASSIGNEE,' De Los ',1,1) + 1,(length(ASSIGNEE) - instr(ASSIGNEE,' De Los ',1,1)) + 1))
          when instr(ASSIGNEE,' De ',1,1) != 0 then upper(substr(ASSIGNEE,instr(ASSIGNEE,' De ',1,1) + 1,(length(ASSIGNEE) - instr(ASSIGNEE,' De ',1,1)) + 1))
          when instr(ASSIGNEE,' Van Der ',1,1) != 0 then upper(substr(ASSIGNEE,instr(ASSIGNEE,' Van Der ',1,1) + 1,(length(ASSIGNEE) - instr(ASSIGNEE,' Van Der ',1,1)) + 1))
          else upper(substr(ASSIGNEE,instr(ASSIGNEE,' ',-1) + 1,(length(ASSIGNEE) - instr(ASSIGNEE,' ',-1)) + 1))
          end
  where PROCESSED_FLAG = 'N';
  
  update CLEAR2WORK_SURVEY
  set
    ASSIGNEE_PSEUDO_KEY = substr(concat(regexp_replace(FIRST_NAME,'[^A-Z]|A|E|I|O|U',''),regexp_replace(LAST_NAME,'[^A-Z]|A|E|I|O|U| ','')),1,12),
    PROCESSED_FLAG = 'Y'
  where PROCESSED_FLAG = 'N';
  
  commit;
  
  end;

end;
/

alter session set plsql_code_type = interpreted;
