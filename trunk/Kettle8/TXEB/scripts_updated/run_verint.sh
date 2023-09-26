#!/bin/ksh
. /dtxe4t/ETL_Scripts/scripts8/.set_env
#ReconReport_load.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/ReconReport_load.sh $
# $Revision: 4462 $
# $Date: 2016-08-07 16:34:31 -0500 (Wed, 07 Aug 2016) $
# $Author: sr18956 $
#PROGNAME=$(basename $0 .sh)

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"

#ECHO starting the Run_onetime_Elig_load kjb now...
ksh $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/Run_verint_load.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Run_verint_load$(date +%Y%m%d_%H%M%S).log

#pan status codes
# 0 	The transformation ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during loading / running of the transformation
# 3 	Unable to prepare and initialize this transformation
# 7 	The transformation couldn't be loaded from XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 	Command line usage printing

#kitchen status codes
# 0 	The job ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during loading or running of the job
# 7 	The job couldn't be loaded from XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 	Command line usage printing
