#!/bin/sh

PROJECT_DIR="$1"
PROJECT_NAME="$(basename "$PROJECT_DIR")"

if [ -z "$SSH_AUTH_SOCK" ]; then
	echo "No ssh-agent socket available. You probably won't be able to push to the ROS bootstrap repository."
fi

docker run -ti -eSSH_AUTH_SOCK="$SSH_AUTH_SOCK" \
	-v"${SSH_AUTH_SOCK}:${SSH_AUTH_SOCK}" \
	-v"${PROJECT_DIR}:/projects/${PROJECT_NAME}" \
	-v"${HOME}/.pypirc:/root/.pypirc" \
	rrp
