#!/bin/bash 
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
#
#   SVN_FILE_URL = $URL$
#   SVN_REVISION = $Revision$
#   SVN_REVISION_DATE = $Date$
#   SVN_REVISION_AUTHOR = $Author$
# ================================================================================
#Name: decr.sh
#Version: 1.0
#Author: eb45730
#Initial Version Date: 05/28/2020
#Purpose: Decrypts a Kettle-encrypted password
#Usage: bash decr.sh "Encrypted-Password" 
#Input: a Kettle-encrypted password without the prefix "Encrypted " (for example a password encrypted by Encr.sh using -kettle as the first parameter);
#Output: the decrypted password
# ================================================================================
JAVA_BIN="/u01/app/appadmin/product/java/jdk1.8.0_192/bin";
MAXDAT_KETTLE_DIR="/u01/app/appadmin/product/pentaho_8.3/data-integration/";

export PATH=$PATH:$JAVA_BIN;

export CLASSPATH=$CLASSPATH:$MAXDAT_KETTLE_DIR/lib/*:$MAXDAT_KETTLE_DIR/lib;
export CLASSPATH=$CLASSPATH:$MAXDAT_KETTLE_DIR/plugins/pdi_core-plugins/*;
export CLASSPATH=$CLASSPATH:$MAXDAT_KETTLE_DIR/plugins/ms-access-plugins/*;
export CLASSPATH=$CLASSPATH:$MAXDAT_KETTLE_DIR/libswt/linux/x86_64/*;

DECRYPTED="$(java KettleDecryptPassword $1)";

#echo $1;
echo $DECRYPTED;
