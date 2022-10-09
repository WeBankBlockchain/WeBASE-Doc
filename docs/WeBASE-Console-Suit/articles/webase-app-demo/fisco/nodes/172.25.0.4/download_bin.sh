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

#!/bin/bash

project=FISCO-BCOS/FISCO-BCOS
cdn_link_header="https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/FISCO-BCOS"
download_branch=
output_dir=bin/
download_mini=
download_version=
latest_version=
download_timeout=240

help() {
    echo "
Usage:
    -v <Version>           Download binary of spectfic version, default latest
    -b <Branch>            Download binary of spectfic branch
    -o <Output Dir>        Default ./bin
    -l                     List released FISCO-BCOS versions
    -m                     Download mini binary, only works with -b option
    -h Help
e.g
    $0 -v 2.9.0
"
exit 0
}

parse_params(){
while getopts "b:o:v:hml" option;do
    case $option in
    o) output_dir=$OPTARG;;
    b) download_branch="$OPTARG";;
    v) download_version="${OPTARG//[vV]/}";;
    m) download_mini="true";;
    l) LOG_INFO "Show the history releases of FISCO-BCOS " && curl --insecure -sS https://gitee.com/api/v5/repos/${project}/tags | grep -oe "\"name\":\"v[2-9]*\.[0-9]*\.[0-9]*\"" | cut -d \" -f 4 | sort -V && exit 0;;
    h) help;;
    *) help;;
    esac
done
}

download_artifact_linux(){
    local branch="$1"
    build_num=$(curl --insecure https://circleci.com/api/v1.1/project/github/${project}/tree/${branch}\?circle-token\=\&limit\=1\&offset\=0\&filter\=successful 2>/dev/null| grep build_num | sed "s/ //g"| cut -d ":" -f 2| sed "s/,//g" | sort -u | tail -n1)

    local response="$(curl --insecure https://circleci.com/api/v1.1/project/github/${project}/${build_num}/artifacts?circle-token= 2>/dev/null)"
    if [ -z "${download_mini}" ];then
        link="$(echo ${response}| grep -o 'https://[^"]*' | grep -v mini)"
    else
        link="$(echo ${response}| grep -o 'https://[^"]*' | grep mini)"
    fi
    if [ -z "${link}" ];then
        build_num=$(( build_num - 1 ))
        response="$(curl --insecure https://circleci.com/api/v1.1/project/github/${project}/${build_num}/artifacts?circle-token= 2>/dev/null)"
        if [ -z "${download_mini}" ];then
            link="$(echo ${response}| grep -o 'https://[^"]*' | grep -v mini| tail -n 1)"
        else
            link="$(echo ${response}| grep -o 'https://[^"]*' | grep mini| tail -n 1)"
        fi
    fi
    if [ -z "${link}" ];then
        echo "CircleCI build_num:${build_num} can't find artifacts."
        exit 1
    fi
    LOG_INFO "Downloading binary from ${link} "
    curl --insecure -#LO ${link} && tar -zxf fisco*.tar.gz && rm fisco*.tar.gz
    result=$?
    if [[ "${result}" != "0" ]];then LOG_ERROR "Download failed, please try again" && exit 1;fi

}

download_artifact_macOS(){
    echo "unsupported for now."
    exit 1
    local branch="$1"
    # TODO: https://developer.github.com/v3/actions/artifacts/#download-an-artifact
    local workflow_artifacts_url="$(curl --insecure https://api.github.com/repos/${project}/actions/runs\?branch\=${branch}\&status\=success\&event\=push | grep artifacts_url | head -n 1 | cut -d \" -f 4)"
    local archive_download_url="$(curl --insecure ${workflow_artifacts_url} | grep archive_download_url | cut -d \" -f 4)"
    if [ -z "${archive_download_url}" ];then
        echo "GitHub action ${workflow_artifacts_url} can't find artifact."
        exit 1
    fi
    LOG_INFO "Downloading macOS binary from ${archive_download_url} "
    # FIXME: https://ghproxy.com/https://github.com/actions/upload-artifact/issues/51
    curl --insecure -#LO "${archive_download_url}" && tar -zxf fisco-bcos-macOS.tar.gz && rm fisco-bcos-macOS.tar.gz
}

download_branch_artifact(){
    local branch="$1"
    if [ "$(uname)" == "Darwin" ];then
        LOG_INFO "Downloading binary of ${branch} on macOS "
        download_artifact_macOS "${branch}"
    else
        LOG_INFO "Downloading binary of ${branch} on Linux "
        download_artifact_linux "${branch}"
    fi
}

download_released_artifact(){
    local version="$1"
    local package_name="fisco-bcos.tar.gz"
    if [ "$(uname)" == "Darwin" ];then
        package_name="fisco-bcos-macOS.tar.gz"
    fi
    local download_link="https://ghproxy.com/https://github.com/FISCO-BCOS/FISCO-BCOS/releases/download/${version}/${package_name}"
    local cdn_download_link="${cdn_link_header}/FISCO-BCOS/releases/${version}/${package_name}"
    LOG_INFO "Downloading binary of ${version}, from ${download_link}"
    if [ $(curl --insecure -IL -o /dev/null -s -w %{http_code} ${cdn_download_link}) == 200 ];then
        curl --insecure -#LO ${download_link} --speed-time 20 --speed-limit 102400 -m ${download_timeout} || {
            echo "Download speed is too low, try ${cdn_download_link}"
            curl --insecure -#LO "${cdn_download_link}"
        }
    else
        curl --insecure -#LO ${download_link}
    fi
    tar -zxf "${package_name}" && rm "${package_name}"
}

main() {
    [ -f "${output_dir}/fisco-bcos" ] && mv "${output_dir}/fisco-bcos" "${output_dir}/fisco-bcos.bak"
    mkdir -p "${output_dir}" && cd "${output_dir}"
    latest_version=$(curl --insecure -sS https://gitee.com/api/v5/repos/${project}/tags | grep -oe "\"name\":\"v[2-9]*\.[0-9]*\.[0-9]*\"" | cut -d \" -f 4 | sort -V | tail -n 1)
    if [ -n "${download_version}" ];then
        download_released_artifact "v${download_version}"
    elif [ -n "${download_branch}" ];then
        download_branch_artifact "${download_branch}"
    else
        download_released_artifact "${latest_version}"
    fi
    LOG_INFO "Finished. Please check ${output_dir}"
}

parse_params "$@"
main

