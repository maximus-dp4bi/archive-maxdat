#!/bin/ksh
. ~/.profile
#run_qcsample_load.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/run_qcsample_load.sh $
# $Revision: 4462 $
# $Date: 2018-12-14 16:34:31 -0500 (Wed, 07 Feb 2017) $
# $Author: sr18956 $
#PROGNAME=$(basename $0 .sh)

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"

QC_INPUT_DIR=$QC_FILES_DIR/files/Inbound

# email-related variables
EMAIL="18956@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_qcsample.txt"
EMAIL_SUBJECT="QCSample Input file Load"

ls -1 ${QC_INPUT_DIR}/* > /dev/null 2>&1
if [ "$?" = "0" ]; then
 	echo "Input File exists. Attempting load" >> $EMAIL_MESSAGE
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	 rm -f $EMAIL_MESSAGE
	ksh $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/run_qcsample_load.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/QCSample_load_$(date +%Y%m%d_%H%M%S).log
else
 echo "Input File not exists"
	 rm -f $EMAIL_MESSAGE
 exit 0
fi

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
