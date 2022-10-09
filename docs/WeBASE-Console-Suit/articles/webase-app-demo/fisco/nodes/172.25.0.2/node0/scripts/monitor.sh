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


# * * * * * bash monitor.sh -d /data/nodes/127.0.0.1/ > monitor.log 2>&1
cd $SHELL_FOLDER

alarm() {
        alert_ip=$(/sbin/ifconfig eth0 | grep inet | awk '{print $2}')
        time=$(date "+%Y-%m-%d %H:%M:%S")
        echo "[${time}] $1"
}

# restart the node
restart() {
        local nodedir=$1
        bash $nodedir/stop.sh
        sleep 5
        bash $nodedir/start.sh
}

info() {
        time=$(date "+%Y-%m-%d %H:%M:%S")
        echo "[$time] $1"
}

# check if nodeX is work well
function check_node_work_properly() {
        nodedir=$1
        # node name
        node=$(basename $nodedir)
        # fisco-bcos path
        fiscopath=${nodedir}/
        config=$1/config.ini
        # rpc url
        config_ip="127.0.0.1"
        config_port=$(cat $config | grep 'jsonrpc_listen_port' | egrep -o "[0-9]+")

        # check if process id exist
        pid=$(ps aux | grep "$fiscopath" | egrep "fisco-bcos" | grep -v "grep" | awk -F " " '{print $2}')
        [ -z "${pid}" ] && {
                alarm " ERROR! $config_ip:$config_port $node does not exist"
                restart $nodedir
                return 1
        }

        # get group_id list
        groups=$(ls ${nodedir}/conf/group*genesis | grep -o "group.*.genesis" | grep -o "group.*.genesis" | cut -d \. -f 2)
        for group in ${groups}; do
                # get blocknumber
                heightresult=$(curl --insecure -s "http://$config_ip:$config_port" -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"getBlockNumber\",\"params\":[${group}],\"id\":67}")
                echo $heightresult
                height=$(echo $heightresult | awk -F'"' '{if($2=="id" && $4=="jsonrpc" && $8=="result") {print $10}}')
                [[ -z "$height" ]] && {
                        alarm " ERROR! Cannot connect to $config_ip:$config_port $node:$group "
                        continue
                }

                height_file="$nodedir/$node_$group.height"
                prev_height=0
                [ -f $height_file ] && prev_height=$(cat $height_file)
                heightvalue=$(printf "%d\n" "$height")
                prev_heightvalue=$(printf "%d\n" "$prev_height")

                viewresult=$(curl --insecure -s "http://$config_ip:$config_port" -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"getPbftView\",\"params\":[$group],\"id\":68}")
                echo $viewresult
                view=$(echo $viewresult | awk -F'"' '{if($2=="id" && $4=="jsonrpc" && $8=="result") {print $10}}')
                [[ -z "$view" ]] && {
                        alarm " ERROR! Cannot connect to $config_ip:$config_port $node:$group "
                        continue
                }

                view_file="$nodedir/$node_$group.view"
                prev_view=0
                [ -f $view_file ] && prev_view=$(cat $view_file)
                viewvalue=$(printf "%d\n" "$view")
                prev_viewvalue=$(printf "%d\n" "$prev_view")

                # check if blocknumber of pbft view already change, if all of them is the same with before, the node may not work well.
                [ $heightvalue -eq $prev_heightvalue ] && [ $viewvalue -eq $prev_viewvalue ] && {
                        alarm " ERROR! $config_ip:$config_port $node:$group is not working properly: height $height and view $view no change"
                        continue
                }

                echo $height >$height_file
                echo $view >$view_file
                info " OK! $config_ip:$config_port $node:$group is working properly: height $height view $view"

        done

        return 0
}

# check all node of this server, if all node work well.
function check_all_node_work_properly() {
        local work_dir=$1
        for configfile in $(ls ${work_dir}/node*/config.ini); do
                check_node_work_properly $(dirname $configfile)
        done
}

function help() {
        echo "Usage:"
        echo "Optional:"
        echo "    -d  <path>          work dir(default: \/../). "
        echo "    -h                  Help."
        echo "Example:"
        echo "    bash monitor.sh -d /data/nodes/127.0.0.1 "
        exit 0
}

work_dir=${SHELL_FOLDER}/../../

while getopts "d:r:c:s:h" option; do
        case $option in
        d) work_dir=$OPTARG ;;
        h) help ;;
        esac
done

[ ! -d ${work_dir} ] && {
        LOG_ERROR "work_dir($work_dir) not exist "
        exit 0
}

check_all_node_work_properly ${work_dir}

