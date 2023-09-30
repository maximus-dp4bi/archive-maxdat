# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/Kettle8/PAIEB/ETL/scripts/run_deltek_runall8.sh $
# $Revision: 25838 $
# $Date: 2018-12-31 14:01:31 -0600 (Mon, 31 Dec 2018) $
# $Author: aa24065 $
# ================================================================================
#!/bin/bash
#source $MD_SETENV
#location='/u01/maximus/maxdat-dev/product/scripts'
location='.'
source $location/.set_env8.sh

JOBS_DIR=$MAXDAT_ETL_PATH
JOB=Load_Deltek_hours
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

today=`date +%Y%m%d`
curr_dir=$(pwd)

TempFol=${MAXDAT_ETL_PATH/scripts/input}

TempFile=csv.txt

#Remove temp file if already exists 
rm -f $TempFol/$TempFile

#Change directory 
cd $TempFol

#Concate files to load
cat *.csv >> $TempFile

#If data file exists to process
if [ -s $TempFol/$TempFile ]
then
   echo "File is available to process"
   $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -log="$MAXDAT_ETL_LOGS/$JOB$(date +%Y%m%d_%H%M%S).log" -level="$KJB_LOG_LEVEL"
else
      echo "File is not available"
fi

#move files to archive folder
#for fname in *.csv
#do 
#   echo Moved file $fname to archive folder as $fname.${today}
#   mv $fname ./archive/$fname.${today}
#done

rm -f $TempFol/$TempFile

cd $curr_dir