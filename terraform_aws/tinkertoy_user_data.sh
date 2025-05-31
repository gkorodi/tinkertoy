#!/usr/bin/env bash

touch /tmp/tinkertoy_user_data.log
echo "Running tinkertoy_user_data.sh" >> /tmp/tinkertoy_user_data.log
# This script is run by the user data script in the tinkertoy module.
# It is run as the user 'tinkertoy' and has access to the home directory of that user.
# It is run after the tinkertoy module has been created and the tinkertoy user has been created.
echo date +%Y-%m-%dT%H:%M:%S%z >> /tmp/tinkertoy_user_data.log