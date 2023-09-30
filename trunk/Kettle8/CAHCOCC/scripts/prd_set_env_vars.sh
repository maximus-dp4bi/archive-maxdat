#!/bin/bash

#. ~/.bash_profile

#Complete the environment - Specific to CAHCO only
#---------------------------
export PENTAHO_JAVA_HOME='/u01/app/appadmin/product/java/jdk1.8.0_192/'  

# Set the ENV_CODE to the correct environment, dev, uat or prd
export ENV_CODE=prd

export MAXDAT_KETTLE_DIR='/u01/app/appadmin/product/pentaho_8.3/data-integration'

export STCODE=CAHCO8

export MAXDAT_ETL_PATH="/u01/maximus/maxdat-$ENV_CODE/${STCODE}"

export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/logs
export MAXDAT_MOTS_FILES=$MAXDAT_ETL_PATH/mots/files
export MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH/scripts
export KETTLE_CAHCO_HOME="/u01/maximus/maxdat-$ENV_CODE/${STCODE}/config"
PATH=$KETTLE_CAHCO_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_CAHCO_HOME
#--------------------------
