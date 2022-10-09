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

dirs=($(ls -l ${SHELL_FOLDER} | awk '/^d/ {print $NF}'))
for directory in ${dirs[*]}
do
    if [[ -f "${SHELL_FOLDER}/${directory}/config.ini" && -f "${SHELL_FOLDER}/${directory}/start.sh" ]];then
        echo "try to start ${directory}"
        bash ${SHELL_FOLDER}/${directory}/start.sh &
    fi
done
wait
