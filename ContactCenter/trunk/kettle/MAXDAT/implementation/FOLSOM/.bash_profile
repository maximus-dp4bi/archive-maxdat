# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

HISTCONTROL="erasedups:ignoreboth"

export HISTCONTROL

tac $HISTFILE | awk '!a[$0]++' | tac > t; mv t $HISTFILE

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_45"
PATH="$PATH:/usr/bin"
export PATH

# User specific environment and startup programs

PATH="$PATH:/usr/bin"

export ENV_CODE="prd"

export MAXDAT_KETTLE_DIR="/u01/app/appadmin/product/pentaho/data-integration"

export MAXDAT_ETL_PATH="/u01/maximus/maxdat-$ENV_CODE"


#FOLSOM
export KETTLE_FOLSOM_HOME="/u01/maximus/maxdat-$ENV_CODE/FOLSOM/config"
export MAXDAT_ETL_LOGS="/u01/maximus/maxdat-$ENV_CODE/FOLSOM/logs"

