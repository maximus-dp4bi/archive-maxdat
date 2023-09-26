create or replace package BPM_SEMANTIC_PROJECT as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/DataModel/BpmSemantic/createdb/BPM_SEMANTIC_PROJECT_pkg_spec.sql $'; 
  SVN_REVISION varchar2(20) := '$Revision: 3584 $'; 
  SVN_REVISION_DATE varchar2(60) := '$Date: 2013-07-02 12:20:36 -0700 (Tue, 02 Jul 2013) $'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: rk50472 $';


  procedure INSERT_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);

  procedure UPDATE_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);

end;
/
grant execute on BPM_SEMANTIC_PROJECT to MAXDAT_MIEB_PFP_E;


