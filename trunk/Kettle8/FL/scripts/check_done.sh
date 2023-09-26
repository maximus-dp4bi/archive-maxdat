#!/bin/bash
. ~/.bash_profile
#run_bpm.sh
PROGNAME=$(basename $0 .sh)

#set up the environment
LOG_DIR=$MAXDAT_LOG_DIR

#mail related variables
EMAIL="PhilipWSmith@maximus.com"
#EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/check_done_ERROR.txt"
EMAIL_SUBJECT="Florida MAXDAT done files are missing"

rm -f $EMAIL_MESSAGE 
if [[ ! -e $LOG_DIR/MailFaxBatch_done.txt ]] ; then
   echo "MailFaxBatch_done.txt is missing" >> $EMAIL_MESSAGE
fi
if [[ ! -e $LOG_DIR/ManageWork_done.txt ]] ; then
   echo "ManageWork_done.txt is missing" >> $EMAIL_MESSAGE
fi
if [[ ! -e $LOG_DIR/MonitorDisputes_done.txt ]] ; then
   echo "MonitorDisputes_done.txt is missing" >> $EMAIL_MESSAGE
fi
if [[ ! -e $LOG_DIR/ProcessApplications_Done.txt ]] ; then
   echo "ProcessApplications_Done.txt is missing" >> $EMAIL_MESSAGE
fi
if [[ ! -e $LOG_DIR/ProcessDocuments_V2_done.txt ]] ; then
   echo "ProcessDocuments_done.txt is missing" >> $EMAIL_MESSAGE
fi
if [[ ! -e $LOG_DIR/ProcessLetters_done.txt ]] ; then
   echo "ProcessLetters_done.txt is missing" >> $EMAIL_MESSAGE
fi
if [[ ! -e $LOG_DIR/SupportMemberInquiry_done.txt ]] ; then
   echo "SupportMemberInquiry_done.txt is missing">> $EMAIL_MESSAGE
fi
CNT=$(find $LOG_DIR/*[Dd]one* -type f | wc -l)
if [[ $CNT != 7  ]] ; then
        echo " " >> $EMAIL_MESSAGE
        echo "exited : $CNT - done files found, expected 8" >> $EMAIL_MESSAGE
        mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        cat $EMAIL_MESSAGE
    exit $cnt
fi
exit 0
