#!/bin/bash
. ~/.bash_profile
###
# MO EVS script to refresh materialized views
#
export PROGNAME=$(basename $0 .sh)
export PGHOST='moevsuat.cluster-cx71qku0jlbd.us-east-1.rds.amazonaws.com' 
export PGDATABASE='moevsuat'
export PGPORT='5432'
export PGUSER='maxdat_support'
export PGHOSTADDR='10.41.145.186'
psql -q -f refresh_materializing_views_psql.sql password=maxsuppuat
exit
