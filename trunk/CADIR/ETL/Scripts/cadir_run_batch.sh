#!/bin/bash
export MD_SETENV=/u01/maximus/maxdat-prd/CADIR/scripts/.set_env
. $MD_SETENV
# CADIR_run_batch.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# =================================================================================
# This shell calls the batch kettle job to run daily stuff outside BPM
# =================================================================================
# ----------------------------------------------------------------
# Function for exit due to fatal program error
#    Accepts 1 argument: string containing descriptive error message
# ----------------------------------------------------------------
PROGNAME=$(basename $0 .sh)
# Run the Init Check to see if resources are available
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  > $MAXDAT_ETL_LOGS/${STCODE}_batch_init_check_$(date +%Y%m%d_%H%M%S).log
#
# Check the return value from Init Check - if it's not good (not 0), email error
rc=$?
if [[ $rc != 0 ]] ; then
   echo "exited with status: $rc - ${STCODE}_BPM_Init_check.kjb in ${ENV_CODE}, aborting run" >> $EMAIL_MESSAGE
   mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
   cat $EMAIL_MESSAGE
   exit $rc
else
      $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/Daily_Batch_Jobs.kjb  $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/Daily_Batch_Jobs_$(date +%Y%m%d_%H%M%S).log &
fi

#End