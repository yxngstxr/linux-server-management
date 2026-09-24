#!/bin/bash
# backup.sh - creates a timestamped backup archive of a given directory

SOURCE_DIR=$1
BACKUP_DIR="/tmp/backups"

if [ -z "$SOURCE_DIR" ]; then
  echo "Usage: $0 <directory-to-backup>"
  exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Directory $SOURCE_DIR does not exist"
  exit 1
fi

#Thinking how realize the script

mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
ARCHIVE_NAME="backup_$TIMESTAMP.tar.gz"

tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" "$SOURCE_DIR"

echo "Backup created: $BACKUP_DIR/$ARCHIVE_NAME"
