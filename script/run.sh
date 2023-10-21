#!/bin/bash

# Current script directory
SCRIPT_DIR=$(dirname $(readlink -f $0))

# Mail configuration
MAIL_IMAGE_NAME="local/mail"
MAIL_LATEST="$MAIL_IMAGE_NAME:latest"
MAIL_CONTAINER_NAME="mail.local"

# Stopping any running containers
docker stop "$MAIL_CONTAINER_NAME" 2> /dev/null;

# Removing containers
docker rm "$MAIL_CONTAINER_NAME" 2> /dev/null;

# Network configuration
NETWORK_NAME="my_network"

# Running Mail container
docker run -d \
  --name "$MAIL_CONTAINER_NAME" \
  --network $NETWORK_NAME \
  --restart=always \
  -t "$MAIL_LATEST" \
  -p 25:25 \
  -p 143:143 \
  -p 587:587 \
  -p 993:993 \
  -p 995:995

