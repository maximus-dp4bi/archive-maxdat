
DIR="/u01/maximus/maxdat-dev/mots/ETL/scripts/ContactCenter/main/bin/"

#!Empty Directory Test
if [ "$(ls -A $DIR)" ]
then
  echo "contains files (or is a file)"
else
  echo "empty (or does not exist)"
fi