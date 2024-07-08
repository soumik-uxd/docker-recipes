#!/bin/bash

# Logger
function logger {
    echo -e ""$(date '+%Y-%m-%d %H:%M:%S,%3N')" - $1"
}

##################################################################################################################################
# Check, inject or set parameters
##################################################################################################################################
if [[ -z "$ZK_HOSTS" ]]; then
    logger "[ERROR] missing mandatory config: ZK_HOSTS"
    exit 1
fi

##################################################################################################################################
# Start cmak
##################################################################################################################################
cmak -J--add-opens=java.base/sun.net.www.protocol.file=ALL-UNNAMED -J--add-exports=java.base/sun.net.www.protocol.file=ALL-UNNAMED -Dconfig.file=${CMAK_WORKDIR}/conf/application.conf -Dpidfile.path=/dev/null -Dapplication.home=/opt/cmak/
