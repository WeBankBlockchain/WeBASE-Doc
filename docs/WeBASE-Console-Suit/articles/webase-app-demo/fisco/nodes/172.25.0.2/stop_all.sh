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
    if [[ -d "${SHELL_FOLDER}/${directory}" && -f "${SHELL_FOLDER}/${directory}/stop.sh" ]];then
        echo "try to stop ${directory}"
        bash ${SHELL_FOLDER}/${directory}/stop.sh &
    fi
done
wait
