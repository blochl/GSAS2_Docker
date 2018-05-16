#!/bin/bash

cont=gsas2_${USER}_${HOSTNAME}
xauth_file="${HOME}/.docker_xauth"
xsock="/tmp/.X11-unix"

touch "${xauth_file}"
trap "rm ${xauth_file}" EXIT INT TERM
xauth nlist "$DISPLAY" | sed 's|^....|ffff|' | xauth -f "$xauth_file" nmerge -

if [ -z $(docker images -q ${cont} 2>/dev/null) ]
then
    echo "First run. Installing..."
    docker build -t "${cont}" \
        --build-arg HTTP_PROXY="${HTTP_PROXY}" \
        --build-arg http_proxy="${http_proxy}" \
        --build-arg HTTPS_PROXY="${HTTPS_PROXY}" \
        --build-arg https_proxy="${https_proxy}" \
        --build-arg NO_PROXY="${NO_PROXY}" \
        --build-arg no_proxy="${no_proxy}" \
        --build-arg user=$USER \
        --build-arg uid=$UID \
        --build-arg group=$(id -g -n ${USER}) \
        --build-arg gid=$(id -g ${USER}) \
        .
fi

docker run -it --rm -w $(pwd) \
    -e HTTP_PROXY \
    -e http_proxy \
    -e HTTPS_PROXY \
    -e https_proxy \
    -e NO_PROXY \
    -e no_proxy \
    -e DISPLAY \
    -e XAUTHORITY="$xauth_file" \
    -v "$xsock":"$xsock":ro \
    -v $xauth_file:$xauth_file:ro \
    -v $(pwd):$(pwd) \
    --name="${cont%:*}" \
    ${cont}
