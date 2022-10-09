#!/bin/bash
SHELL_FOLDER=$(cd $(dirname $0);pwd)

LOG_ERROR() {
    content=${1}
    echo -e "\033[31m[ERROR] ${content}\033[0m"
}

LOG_INFO() {
    content=${1}
    echo -e "\033[32m[INFO] ${content}\033[0m"
}

cd ${SHELL_FOLDER}/../
NODE_FOLDER=$(pwd)
fisco_bcos=${NODE_FOLDER}/../fisco-bcos
node=$(basename ${NODE_FOLDER})
node_pid=$(ps aux|grep ${fisco_bcos}|grep -v grep|awk '{print $2}')
if [ -n "${node_pid}" ];then
    echo "${node} is trying to load new groups. Check log for more information."
    DATA_FOLDER=${NODE_FOLDER}/data
    for dir in $(ls ${DATA_FOLDER})
    do
        if [[ -d "${DATA_FOLDER}/${dir}" ]] && [[ -n "$(echo ${dir} | grep -E "^group\d+$")" ]]; then
            STATUS_FILE=${DATA_FOLDER}/${dir}/.group_status
            if [ ! -f "${STATUS_FILE}" ]; then
                echo "STOPPED" > ${STATUS_FILE}
            fi
        fi
    done
    touch config.ini.append_group
    exit 0
else
    echo "${node} is not running, use start.sh to start all group directlly."
fi
