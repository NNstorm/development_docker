#!/usr/bin/env bash

if [[ -z "${HOST_GROUP}" ]]; then
    echo "Must provide HOST_GROUP in environment" 1>&2
    exit 1
fi

if [[ -z "${HOST_GID}" ]]; then
    echo "Must provide HOST_GID in environment" 1>&2
    exit 1
fi

if [[ -z "${HOST_USER}" ]]; then
    echo "Must provide HOST_USER in environment" 1>&2
    exit 1
fi

if [[ -z "${HOST_UID}" ]]; then
    echo "Must provide HOST_UID in environment" 1>&2
    exit 1
fi

groupadd --force ${HOST_GROUP} --gid ${HOST_GID}
useradd -u ${HOST_UID} -g ${HOST_GID} -d /home/${HOST_USER} -s /bin/bash -M ${HOST_USER}

su - ${HOST_USER} "$@"
