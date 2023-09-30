CREATE OR REPLACE Procedure DP_SCORECARD.Insert_Back_Office_Rollup
AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/patch/20170623_PP_WFM_BACK_OFFICE_LOAD_PKG.sql $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 20489 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-07-03 14:31:06 -0500 (Mon, 03 Jul 2017) $'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';

BEGIN

    DP_SCORECARD.PP_WFM_BACK_OFFICE_LOAD_PKG.LOAD_SC_PROD_AND_SMRY();
    
    DP_SCORECARD.PP_WFM_BACK_OFFICE_LOAD_PKG.LOAD_SC_SUMMARY_BO_ROLLUP();

END;
/


grant execute on DP_SCORECARD.Insert_Back_Office_Rollup to maxdat;

grant debug on DP_SCORECARD.Insert_Back_Office_Rollup to maxdat_read_only;

