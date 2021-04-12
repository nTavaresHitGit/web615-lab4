readonly VERSION="1.0.0"

set +e
echo "=~=~=~=~= Attempting to migrate the DB =~=~=~=~="
bin/rails db:migrate 2>/dev/null
RET=$?
set -e
if [ $RET -gt 0 ]; then
  echo "=~=~=~=~= Migration failed; creating the database =~=~=~=~= "
  bin/rails db:create
  echo "=~=~=~=~= Migrating the database =~=~=~=~= "
  bin/rails db:migrate
  bin/rails db:test:prepare
  echo "=~=~=~=~= Seeding the Database =~=~=~=~= "
  bin/rails db:seed
fi
echo "=~=~=~=~= Removing the old server PID =~=~=~=~= "
rm -f tmp/pids/server.pid
echo "=~=~=~=~= Starting the webserver =~=~=~=~= "
bin/rails server -p 3000 -b '0.0.0.0'
