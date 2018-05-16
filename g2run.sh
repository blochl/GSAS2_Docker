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
        --build-arg user=$USER \
        --build-arg uid=$UID \
        --build-arg group=$(id -g -n ${USER}) \
        --build-arg gid=$(id -g ${USER}) \
        .
fi

docker run -it --rm -w $(pwd) \
    -e DISPLAY \
    -e XAUTHORITY="$xauth_file" \
    -v "$xsock":"$xsock":ro \
    -v $xauth_file:$xauth_file:ro \
    -v $(pwd):$(pwd) \
    --name="${cont%:*}" \
    ${cont}
