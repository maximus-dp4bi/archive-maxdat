#!/bin/bash
#. ~/.bash_profile
# CAHCO_rm_checkfiles.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL$
# $Revision$
# $Date$
# $Author$
# ================================================================================
# This is to remove check files 
# ================================================================================
cd "/tmp"
if [[ `pwd` = "/tmp" ]] ; then
  echo "Present directory temp"
  rm -rf -- -CAHCO8-ERROR-LOG.txt
  rm `ls -f | grep CAHCO` -rf
fi
