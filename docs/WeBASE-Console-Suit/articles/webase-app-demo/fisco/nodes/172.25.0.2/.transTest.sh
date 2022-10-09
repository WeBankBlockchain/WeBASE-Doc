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

# This script only support for block number smaller than 65535 - 256

ip_port=http://127.0.0.1:8545
trans_num=1
target_group=1
version=
if [ $# -ge 1 ];then
    trans_num=$1
fi
if [ $# -ge 2 ];then
    target_group=$2
fi

getNodeVersion()
{
    result="$(curl --insecure -X POST --data '{"jsonrpc":"2.0","method":"getClientVersion","params":[],"id":1}' ${ip_port})"
    version="$(echo ${result} | cut -c250- | cut -d \" -f3)"
}

block_limit()
{
    result=$(curl --insecure -s -X POST --data '{"jsonrpc":"2.0","method":"getBlockNumber","params":['${target_group}'],"id":83}' ${ip_port})
    if [ $(echo ${result} | grep -i failed | wc -l) -gt 0 ] || [ -z ${result} ];then
        echo "getBlockNumber error!"
        exit 1
    fi
    blockNumber=$(echo ${result}| cut -d \" -f 10)
    printf "%04x" $(($blockNumber+0x100))
}

send_a_tx()
{
    limit=$(block_limit)
    random_id="$(date +%s)$(printf "%09d" ${RANDOM})"
    if [ ${#limit} -gt 4 ];then echo "blockLimit exceed 0xffff, this scripts is unavailable!"; exit 0;fi
    if [ "${version}" == "2.0.0-rc1" ];then
        txBytes="f8f0a02ade583745343a8f9a70b40db996fbe69c63531832858${random_id}85174876e7ff8609184e729fff82${limit}94d6f1a71052366dbae2f7ab2d5d5845e77965cf0d80b86448f85bce000000000000000000000000000000000000000000000000000000000000001bf5bd8a9e7ba8b936ea704292ff4aaa5797bf671fdc8526dcd159f23c1f5a05f44e9fa862834dc7cb4541558f2b4961dc39eaaf0af7f7395028658d0e01b86a371ca0e33891be86f781ebacdafd543b9f4f98243f7b52d52bac9efa24b89e257a354da07ff477eb0ba5c519293112f1704de86bd2938369fbf0db2dff3b4d9723b9a87d"
    else
        txBytes="f8eca003eb675ec791c2d19858c91d0046821c27d815e2e9c15${random_id}0a8402faf08082${limit}948c17cf316c1063ab6c89df875e96c9f0f5b2f74480b8644ed3885e0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000a464953434f2042434f53000000000000000000000000000000000000000000000101801ba09edf7c0cb63645442aff11323916d51ec5440de979950747c0189f338afdcefda02f3473184513c6a3516e066ea98b7cfb55a79481c9db98e658dd016c37f03dcf"
    fi
    #echo $txBytes
    curl --insecure -s -X POST --data '{"jsonrpc":"2.0","method":"sendRawTransaction","params":['${target_group}', "'$txBytes'"],"id":83}' ${ip_port}
}

send_many_tx()
{
    for j in $(seq 1 $1)
    do
        echo 'Send transaction: ' $j
        send_a_tx ${ip_port}
    done
}
getNodeVersion
echo "Use version:${version}"
send_many_tx ${trans_num}

