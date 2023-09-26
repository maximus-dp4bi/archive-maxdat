#!/bin/bash
. ~/.bash_profile

# purge_cc_logs.sh
# ====================================================================================================================================================================
# Do not edit these four SVN_* variable values.  They are populated when
#    you commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# ====================================================================================================================================================================
# Script Name:  purge_cc_logs.sh
# Purpose:      This script removes all files from the Contact Center log file directory, $MAXDAT_ETL_LOGS/ContactCenter, that are older than 
#               a number of days specified by $LOG_LIFE_DAYS.  The variables $MAXDAT_ETL_LOGS and $LOG_LIFE_DAYS are specificed in the .set_env_vars.sh file.
#
#               This script writes the log files that will be deleted to the script's log file.  An optional parameter dictates the MODE of the script.  
#               If a value of D is passed, then the files are removed from the the log directory.  Otherwise, the files that would be deleted are written to the
#               script's log, and no files are removed from the directory. 
#
# Important:    Make sure that cron knows $MD_SETENV. 
# 
# WHO		WHEN		WHAT
# ===		====		====
# TAM		04/16/2018	Modified script to preview and delete log files.
# TAM           04/17/2018      Added code to count the number of files that will be deleted.
# TAM		04/19/2018	Added logic to default MODE based on environment, assuming it is not supplied.
# TAM		06/17/2019	Removed ContactCenter directory from ETL_LOG_PATH and SCRIPT_LOG_PATH.
# ====================================================================================================================================================================

# Set Environment Variables
. $MAXDAT_ETL_PATH/PA/scripts/ContactCenter/implementation/PAEB/bin/set_env_vars.sh

MODE="$1"
SCRIPT_LOG_TIMESTAMP=$(date +%Y%m%d_%H%M%S)
ETL_LOG_PATH=$MAXDAT_ETL_LOGS
SCRIPT_LOG_PATH=$MAXDAT_ETL_LOGS
SCRIPT_LOG_FILE_NAME=purge_cc_logs_$SCRIPT_LOG_TIMESTAMP.log
SCRIPT_LOG=$SCRIPT_LOG_PATH/$SCRIPT_LOG_FILE_NAME
SCRIPT_ENV_CODE=$ENV_CODE

# If the current environment is dev, then force the mode to preview (P), if the mode was not specified as D (delete) for the first parameter.
# If the current environment is not dev, then force the mode to delete (D), if the mode was not specified as P (preview) for the first parameter.

if [ "$SCRIPT_ENV_CODE" = "dev" ]
then
  if [ "$MODE" != "D" ]
  then
    MODE="P"  
  fi
else
  if [ "$MODE" != "P" ]
  then
    MODE="D"  
  fi
fi

function cleanLogDirectory () {

    local P_MODE="$1"
    local P_LOG_LIFE_DAYS="$2"
    local P_LOG_DIR="$3"
    local P_SCRIPT_LOG="$4"
    local P_WHICH_DATETIME="$5"

    echo "Scanning directory $P_LOG_DIR..." >> "$P_SCRIPT_LOG"

    if [ "$P_WHICH_DATETIME" = "C" ]
    then
      NUM_LOG_FILES_TO_DEL=$(find $P_LOG_DIR -type f -ctime +$P_LOG_LIFE_DAYS | wc -l)
    else
      NUM_LOG_FILES_TO_DEL=$(find $P_LOG_DIR -type f -mtime +$P_LOG_LIFE_DAYS | wc -l)
    fi

    if [ "$NUM_LOG_FILES_TO_DEL" != "0" ] 
    then

      echo "Found $NUM_LOG_FILES_TO_DEL file(s) older than $P_LOG_LIFE_DAYS day(s) old..." >> "$P_SCRIPT_LOG"

      if [ "$P_WHICH_DATETIME" = "C" ]
      then
        find $P_LOG_DIR -type f -ctime +$P_LOG_LIFE_DAYS >> "$P_SCRIPT_LOG"
      else
        find $P_LOG_DIR -type f -mtime +$P_LOG_LIFE_DAYS >> "$P_SCRIPT_LOG"
      fi

      if [ "$P_MODE" = "D" ]
      then
        echo "Started deleting files at $(date +%Y%m%d_%H%M%S)..." >> "$P_SCRIPT_LOG"

        if [ "$P_WHICH_DATETIME" = "C" ]
        then
          find $P_LOG_DIR -type f -ctime +$P_LOG_LIFE_DAYS -delete >> "$P_SCRIPT_LOG"
        else
          find $P_LOG_DIR -type f -mtime +$P_LOG_LIFE_DAYS -delete >> "$P_SCRIPT_LOG"
        fi

        echo "Finished deleting files at $(date +%Y%m%d_%H%M%S)..." >> "$P_SCRIPT_LOG"
      fi
    else
      echo "There are no files that are older than $P_LOG_LIFE_DAYS days old..." >> "$P_SCRIPT_LOG"
    fi
}

WHICH_DATETIME="C"
echo "Calling function cleanLogDirectory with parameters P_MODE=$MODE, P_LOG_LIFE_DAYS=$LOG_LIFE_DAYS, P_WHICH_DATETIME=$WHICH_DATETIME, P_LOG_DIR=$ETL_LOG_PATH, P_SCRIPT_LOG=$SCRIPT_LOG" >> "$SCRIPT_LOG"
cleanLogDirectory $MODE $LOG_LIFE_DAYS $ETL_LOG_PATH $SCRIPT_LOG $WHICH_DATETIME

WHICH_DATETIME="M"
echo "Calling function cleanLogDirectory with parameters P_MODE=$MODE, P_LOG_LIFE_DAYS=$LOG_LIFE_DAYS, P_WHICH_DATETIME=$WHICH_DATETIME, P_LOG_DIR=$ETL_LOG_PATH, P_SCRIPT_LOG=$SCRIPT_LOG" >> "$SCRIPT_LOG"
cleanLogDirectory $MODE $LOG_LIFE_DAYS $ETL_LOG_PATH $SCRIPT_LOG $WHICH_DATETIME
