#!/bin/bash

# Current script directory
SCRIPT_DIR=$(dirname $(readlink -f $0))

# Network configuration
NETWORK_NAME="my_network"

# Create network if not exists
docker network inspect $NETWORK_NAME >/dev/null 2>&1 || docker network create $NETWORK_NAME

# Image names
MAIL_NAME="local/mail"

# Image tagging configuration
TAG=$(git log -1 --pretty=%h)
MAIL_LATEST="$MAIL_NAME:latest"
MAIL_TAGGED="$MAIL_NAME:$TAG"

# Removing old mail image
docker image rm \
  "$MAIL_LATEST" \
  "$MAIL_TAGGED" 2> /dev/null

# Build mail
docker build \
  -t "$MAIL_LATEST" \
  -t "$MAIL_TAGGED" \
  ${SCRIPT_DIR}/../docker

