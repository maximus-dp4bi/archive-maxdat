#!/bin/ksh
#. ~/.bash_profile
# =======================================================================
# Do not edit these four SVN_* variable values.  They are populated when
#    you commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# =======================================================================
BASEDIR=$(dirname $0)
echo $BASEDIR
PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0) at $(date +%Y%m%d_%H%M%S)."

EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/PP_WFM_RUNALL7-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With Run_PP_WFM_RUNALL7.sh in $ENV"

LOG_FILE="$MAXDAT_ETL_LOGS/PP_WFM_RUNALL${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log"

echo "Starting PP_WFM_RUNALL.kjb"

$MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/PP_WFM_RUNALL.kjb $KJB_LOG_LEVEL >> $LOG_FILE
rc=$?
if [[ $rc == 0 ]] ; then
   echo "Run_PP_WFM_RUNALL7 process completed successfully at $(date +%Y%m%d_%H%M%S)."
else
   echo "Run_PP_WFM_RUNALL7 process failed with error code $rc.  See log files for details."
fi