#!/bin/ksh

# This script will rename all the MAXMIMSS csv data files in the directory, "/u01/maximus/maxdat-dev/IL/IVR_TEST" 
# with a prefix ".DONE" to mark them as processed.

# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL$
# $Revision$
# $Date$
# $Author$
V_WORKING_DIR="/MAXMIMSS/PROD/ResponseFiles"
V_DONE_STATUS="DONE"

cd ${V_WORKING_DIR}
echo "The current working directory is set to ${V_WORKING_DIR}."

FILENAMES=$(ls MAXMIMSS_RESPONSE_*.csv)

rc1=$?
if [[ $rc1 != 0 ]] ; 
then
    echo "NO FILES EXIST!!!!"
fi

for FILENAME in $FILENAMES
do
  echo "Renaming $FILENAME to $FILENAME.${V_DONE_STATUS}"
  mv $FILENAME $FILENAME.${V_DONE_STATUS}
done

echo "All the CSI IVR csv data files in the current working directory '${V_WORKING_DIR}' are marked as Processed."

rc2=$?
if [[ $rc2 != 0 ]] ; then
   echo "Script errorred."
else
   echo "Script ran successfully." 
fi

exit 0