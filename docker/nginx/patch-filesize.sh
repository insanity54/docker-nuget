#!/usr/bin/env bash

DEFAULT_SIZE=20M

if [ -z ${UPLOAD_MAX_FILESIZE+false} ]
then
    echo "Using default max upload size: ${DEFAULT_SIZE}"
else
    echo "Using max upload size: ${UPLOAD_MAX_FILESIZE}"
    
    # Set filesize to the user's env specification
    perl -pi -e "s/client_max_body_size(\s*)${DEFAULT_SIZE};/client_max_body_size\${1}${UPLOAD_MAX_FILESIZE};/" /etc/nginx/conf.d/nuget.conf
fi
