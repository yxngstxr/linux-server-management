#!/bin/bash
# healthcheck.sh - checks if a given service is running

SERVICE=$1

if [ -z "$SERVICE" ]; then
  echo "Usage: $0 <service-name>"
  exit 1
fi

if systemctl is-active --quiet "$SERVICE"; then
  echo "$SERVICE is running"
else
  echo "$SERVICE is NOT running"
  exit 1
fi
