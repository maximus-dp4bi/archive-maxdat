# .bash_profile

HISTCONTROL="erasedups:ignoreboth"

export HISTCONTROL

tac $HISTFILE | awk '!a[$0]++' | tac > t; mv t $HISTFILE

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_37"
PATH="$PATH:/usr/bin"
export PATH

###############################################################################
# USER SPECIFIC CUSTOMIZATIONS (Try to incorporate into Standard Files)
###############################################################################
#ulimit -n 326994
export ENV_CODE="dev"
#export ENV_CODE="uat"
#export ENV_CODE="prd"
export MAXDAT_KETTLE_DIR="/u01/app/appadmin/product/pentaho/data-integration"


#NYEC-2478
export MAXDAT_ETL_DIR="/u01/maximus/maxbi-$ENV_CODE"
export KETTLE_NY_HOME="/home/etladmin"

#MAXDAT-400
export MAXDAT_ETL_PATH="/u01/maximus/maxdat-$ENV_CODE"
export MAXDAT_ETL_LOGS="/u01/maximus/maxdat-$ENV_CODE"
export MAXDAT_IL_LOGS="/u01/maximus/maxdat-$ENV_CODE/IL/ETL/logs"
export KETTLE_IL_HOME="/u01/maximus/maxdat-$ENV_CODE/IL/config"
export KETTLE_BOS_HOME="/u01/maximus/maxdat-$ENV_CODE/BOS/config"
export KETTLE_VT_HOME="/u01/maximus/maxdat-$ENV_CODE/VT/config"
export KETTLE_CO_HOME="/u01/maximus/maxdat-$ENV_CODE/CO/config"
export KETTLE_DMCS_HOME="/u01/maximus/maxdat-$ENV_CODE/DMCS/config"
export KETTLE_MDHIX_HOME="/u01/maximus/maxdat-$ENV_CODE/MDHIX/config"
export KETTLE_TNRD_HOME="/u01/maximus/maxdat-$ENV_CODE/TNRD/config"
export KETTLE_FOLSOM_HOME="/u01/maximus/maxdat-$ENV_CODE/FOLSOM/config"
export KETTLE_CiscoEnterprise_HOME="/u01/maximus/maxdat-$ENV_CODE/CiscoEnterprise/config"
export KETTLE_KSCH_Legacy_HOME="/u01/maximus/maxdat-$ENV_CODE/KSCH_Legacy/config"
export KETTLE_ILEBCC_HOME="/u01/maximus/maxdat-$ENV_CODE/ILEBCC/config"
export MAXDAT_ILEBCC_LOGS="/u01/maximus/maxdat-$ENV_CODE/ILEBCC/logs"
export KETTLE_LAEB_HOME="/u01/maximus/maxdat-$ENV_CODE/LAEB/config"
export MAXDAT_LAEB_LOGS="/u01/maximus/maxdat-$ENV_CODE/LAEB/logs"
export KETTLE_PA_HOME="/u01/maximus/maxdat-$ENV_CODE/PA/config"
export MAXDAT_PA_LOGS="/u01/maximus/maxdat-$ENV_CODE/PA/logs"
export KETTLE_PRODUCT_HOME="/u01/maximus/maxdat-$ENV_CODE/Product/config"
export KETTLE_CAHCO_HOME="/u01/maximus/maxdat-$ENV_CODE/CAHCO/config"
export KETTLE_DCHIX_HOME="/u01/maximus/maxdat-$ENV_CODE/DCHIX/config"


#MOTS
export MOTS_ROOT="/u01/maximus/maxdat-$ENV_CODE/mots"
export MOTS_ETL_PATH="/u01/maximus/maxdat-$ENV_CODE/mots/ETL/scripts"
export MOTS_ETL_LOGS="/u01/maximus/maxdat-$ENV_CODE/mots/logs"
export MAXDAT_DCHIX_LOGS="/u01/maximus/maxdat-$ENV_CODE/DCHIX/logs" 

#AO
export AO_ROOT="/u01/maximus/maxdat-$ENV_CODE/AO"
export AO_ETL_PATH="/u01/maximus/maxdat-$ENV_CODE/AO/ETL/main"
export AO_ETL_LOGS="/u01/maximus/maxdat-$ENV_CODE/AO/logs"

# Standard Bash Prompt
PS1='\[\e[1;34m\]PH: $(basename $PRODUCT_HOME 2> /dev/null)    \[\e[1;30m\]DB: $(/home/maxutil/scripts/db_instance_status 2> /dev/null)\n\[\e[1;34m\]$PWD\n\[\e[0;31m\]\u@\h>\[\e[0m\]'; export PS1

#export NY_SETENV=/u01/maximus/maxdat-dev/NY/ETL/scripts/.set_env
export MD_SETENV=/u01/maximus/maxdat-dev/UK/scripts/.set_env
export BOS_SETENV=/u01/maximus/maxdat-dev/BOS/scripts/.set_env
export VT_SETENV=/u01/maximus/maxdat-dev/VT/scripts/.set_env
export CO_SETENV=/u01/maximus/maxdat-dev/CO/ETL/scripts/.set_env
export DMCS_SETENV=/u01/maximus/maxdat-dev/DMCS/ETL/scripts/.set_env
export TNRD_SETENV=/u01/maximus/maxdat-dev/TNRD/scripts/.set_env
export ILEBCC_SETENV=/u01/maximus/maxdat-dev/ILEBCC/scripts/.set_env
export PA_SETENV=/u01/maximus/maxdat-dev/PA/scripts/.set_env
export LAEB_SETENV=/u01/maximus/maxdat-dev/LAEB/scripts/.set_env
export DCHIX_SETENV=/u01/maximus/maxdat-dev/DCHIX/scripts/.set_env

alias cds='cd /u01/maximus/maxdat-dev/IL/ETL/scripts'
alias cdl='cd /u01/maximus/maxdat-dev/IL/ETL/logs'

