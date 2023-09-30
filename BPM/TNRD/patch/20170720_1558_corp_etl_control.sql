#! /bin/bash
# =============================================================================
# Do not edit these four SVN_* variable values.  They are populated when 
#    you commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# ============================================================================
# Script to update the corp_etl_control table to not go back to default days
#	so we can test in the UAT environment
# ============================================================================
UPDATE MAXDAT.CORP_ETL_CONTROL SET VALUE = '2017-07-19' WHERE NAME IN ('MFB_REMOTE_LAST_UPDATE_DATE','MFB_CENTRAL_LAST_UPDATE_DATE','MFB_ARS_LAST_UPDATE_DATE');

UPDATE MAXDAT.CORP_ETL_CONTROL SET VALUE = '1' WHERE NAME IN ('MFB_REMOTE_LOOKBACK_DAYS','MFB_CENTRAL_LOOKBACK_DAYS','MFB_ARS_LOOKBACK_DAYS');

COMMIT;

