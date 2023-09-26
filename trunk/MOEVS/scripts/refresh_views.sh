# MOEVS script to refresh materialized views
#
#
export PROGNAME=$(basename $0 .sh)
export HOSTNAME=`hostname`
case $HOSTNAME in
"uorapmmapp01ceb")
export PGHOST='uvaaqmmdbo02mov1-qa-migrated-cluster.cluster-cx71qku0jlbd.us-east-1.rds.amazonaws.com'
export PGDATABASE='moevsqa'
export PGPORT='5432'
export PGUSER='maxdat_support'
export PGHOSTADDR='10.41.146.143'
/u01/app/appadmin/product/postgre_9.4/pgsql/bin/psql -q -f /u01/maximus/moevsdev/scripts/refresh_materializing_views_psql.sql password=maxsuppqa
;;
"uoraumpetl01dpm")
export PGHOST='moevsuat.cluster-cx71qku0jlbd.us-east-1.rds.amazonaws.com'
export PGDATABASE='moevsuat'
export PGPORT='5432'
export PGUSER='maxdat_support'
export PGHOSTADDR='10.41.145.186'
/u01/app/appadmin/product/postgre_9.4/pgsql/bin/psql -q -f /u01/maximus/moevs/scripts/refresh_materializing_views_psql.sql password=maxsuppuat
;;
esac
exit
