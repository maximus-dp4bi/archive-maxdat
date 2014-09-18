#!/bin/bash
. ~/.bash_profile
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/ContactCenter/trunk/kettle/MAXDAT/main/bin/run_log_clean_up.sh $
# $Revision: 10689 $
# $Date: 2014-07-02 14:33:13 -0400 (Wed, 02 Jul 2014) $
# $Author: jh44463 $
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

BASEDIR=$(dirname $0)
echo $BASEDIR
. $MAXDAT_ETL_PATH/ContactCenter/implementation/$STCODE/bin/set_env_vars.sh


#Dave Dillon's script:
#find $MAXDAT_ETL_LOGS \( -ctime +$LOG_LIFE_DAYS -o -size 0 \) -exec rm -f '{}' \;


find $MAXDAT_ETL_LOGS \( -ctime +$LOG_LIFE_DAYS -o -size -$MIN_LOG_SIZE \) -exec rm -f '{}' \;