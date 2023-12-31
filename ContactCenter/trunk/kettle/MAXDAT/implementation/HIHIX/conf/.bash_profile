# .bash_profile

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_45"

PATH=$PATH
export PATH

###############################################################################
# USER SPECIFIC CUSTOMIZATIONS (Try to incorporate into Standard Files)
###############################################################################
#ulimit -n 326994

#MAXDAT-400
export MAXDAT_ETL_PATH="/u01/maximus/maxdat-dev/HCCHIX/ETL/scripts"
export MAXDAT_ETL_LOG="/u01/maximus/maxdat-dev/HCCHIX/ETL/logs"

# Standard Bash Prompt
#PS1='\[\e[1;34m\]PH: $(basename $PRODUCT_HOME 2> /dev/null)    \[\e[1;30m\]DB: $(/home/maxutil/scripts/db_instance_status 2> /dev/null)\n\[\e[1;34m\]$PWD\n\[\e[0;31m\]\u@\h>\[\e[0m\]'; export PS1


