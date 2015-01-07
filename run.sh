#!/bin/bash

set -ex

HOSTNAME_SET=${EXT_HOSTNAME:-$(hostname)}
hostname $HOSTNAME_SET

asadmin start-domain 
if [ ! -f /.glassfish_admin_password_changed ]; then
    /change_admin_password.sh
fi
echo "=> Restarting Glassfish server"
asadmin stop-domain
echo "=> Starting and running Glassfish server"
DEBUG_MODE=${DEBUG:-false}
echo "=> Debug mode is set to: ${DEBUG_MODE}"
asadmin start-domain --debug=${DEBUG_MODE} -w
