FROM blochl/gsas2
ARG user
ARG uid
ARG group
ARG gid

RUN groupadd -g ${gid} ${group} \
    && useradd -m -g ${group} -s /bin/bash -u ${uid} ${user}

USER ${user}
ENTRYPOINT ["/usr/bin/python"]
CMD ["/usr/app/GSAS2/GSASII.py"]
