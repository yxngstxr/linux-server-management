#!/bin/bash
# create_user.sh - creates a new user with a specified group

USERNAME=$1
GROUPNAME=$2

if [ -z "$USERNAME" ] || [ -z "$GROUPNAME" ]; then
  echo "Usage: $0 <username> <groupname>"
  exit 1
fi

if id "$USERNAME" &>/dev/null; then
  echo "Error: User $USERNAME already exists"
  exit 1
fi

if ! getent group "$GROUPNAME" > /dev/null; then
  sudo groupadd "$GROUPNAME"
  echo "Group $GROUPNAME created"
fi

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit 1
fi

sudo useradd -m -g "$GROUPNAME" "$USERNAME"
echo "User $USERNAME created and added to group $GROUPNAME"
