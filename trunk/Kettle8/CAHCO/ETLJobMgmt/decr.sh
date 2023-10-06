#!/bin/bash 
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
#
#   SVN_FILE_URL = $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/Kettle8/CAHCO/ETLJobMgmt/decr.sh $
#   SVN_REVISION = $Revision: 34217 $
#   SVN_REVISION_DATE = $Date: 2023-09-18 16:34:36 -0700 (Mon, 18 Sep 2023) $
#   SVN_REVISION_AUTHOR = $Author: fm18957 $
# ================================================================================
#Name: decr.sh
#Version: 2.0
#Author: fm18957
#Initial Version Date: 05/28/2020
#Modified Version Date: 09/17/2023
#Purpose: Decrypts a Kettle-encrypted password
#Usage: bash decr.sh "Encrypted-Password" 
#Input: a Kettle-encrypted password without the prefix "Encrypted " (for example a password encrypted by Encr.sh using -kettle as the first parameter);
#Output: the decrypted password
# ================================================================================
JAVA_BIN="/u01/app/appadmin/product/java/amazon-corretto-11.0.15.9.1-linux-x64/bin";
MAXDAT_KETTLE_DIR="/u01/app/appadmin/product/pentaho_9.3/data-integration";

export PATH=$PATH:$JAVA_BIN;

export CLASSPATH=$CLASSPATH:$MAXDAT_KETTLE_DIR/lib/pentaho-encryption-support-9.3.0.0-428.jar;
export CLASSPATH=$CLASSPATH:$MAXDAT_KETTLE_DIR/lib/*:$MAXDAT_KETTLE_DIR/lib;
export CLASSPATH=$CLASSPATH:$MAXDAT_KETTLE_DIR/plugins/pdi_core-plugins/*;
export CLASSPATH=$CLASSPATH:$MAXDAT_KETTLE_DIR/plugins/ms-access-plugins/*;
export CLASSPATH=$CLASSPATH:$MAXDAT_KETTLE_DIR/libswt/linux/x86_64/*;

DECRYPTED="$(java KettleDecryptPassword "$1")";

#echo $1;
echo $DECRYPTED;
