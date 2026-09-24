#!/bin/bash
# log_rotate.sh - archives log files older than N days

LOG_DIR=$1
DAYS=${2:-7}
ARCHIVE_DIR="$LOG_DIR/archive"

if [ -z "$LOG_DIR" ]; then
  echo "Usage: $0 <log-directory> [days-threshold]"
  exit 1
fi

if [ ! -d "$LOG_DIR" ]; then
  echo "Error: Directory $LOG_DIR does not exist"
  exit 1
fi

mkdir -p "$ARCHIVE_DIR"

find "$LOG_DIR" -maxdepth 1 -name "*.log" -mtime +"$DAYS" | while read -r file; do
  filename=$(basename "$file")
  gzip -c "$file" > "$ARCHIVE_DIR/${filename}.gz"
  rm "$file"
  echo "Archived: $filename"
done

echo "Log rotation complete."
