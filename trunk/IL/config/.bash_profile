# .bash_profile

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
PATH=$PATH
export PATH

###############################################################################
# USER SPECIFIC CUSTOMIZATIONS (Try to incorporate into Standard Files)
###############################################################################
#ulimit -n 326994
#export ENV_CODE="dev"
export ENV_CODE="uat"
#export ENV_CODE="prd"
export MAXDAT_KETTLE_DIR="/u01/app/appadmin/product/pentaho/data-integration"


#NYEC-2478
export MAXDAT_ETL_DIR="/u01/maximus/maxbi-$ENV_CODE"
export KETTLE_NY_HOME="/home/etladmin"

#MAXDAT-400
export MAXDAT_ETL_PATH="/u01/maximus/maxdat-$ENV_CODE"
export KETTLE_IL_HOME="/u01/maximus/maxdat-$ENV_CODE/IL/config"

# Standard Bash Prompt
PS1='\[\e[1;34m\]PH: $(basename $PRODUCT_HOME 2> /dev/null)    \[\e[1;30m\]DB: $(/home/maxutil/scripts/db_instance_status 2> /dev/null)\n\[\e[1;34m\]$PWD\n\[\e[0;31m\]\u@\h>\[\e[0m\]'; export PS1

