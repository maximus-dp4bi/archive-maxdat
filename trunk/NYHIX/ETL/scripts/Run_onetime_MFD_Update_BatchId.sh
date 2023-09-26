#!/bin/ksh
. ~/.bash_profile
#nyhix_run_mfd.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/NYHIX/ETL/Run_onetime_MFD_Update_BatchId.sh $
# $Revision: 13183 $
# $Date: 2014-12-12 09:43:50 -0500 (Fri, 12 Dec 2014) $
# $Author: sp57859 $
PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	rm -f $INIT_OK
	exit 1
}

export KETTLE_HOME=$KETTLE_NYHIX_HOME

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
KJB_LOG_ROWLEVEL="Rowlevel"

	$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/MailFaxDocV2/Run_onetime_MFD_update_BatchId.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/Run_onetime_MFD_update_BatchId_$(date +%Y%m%d_%H%M%S).log &
	