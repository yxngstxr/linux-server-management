# Auto-cleanup old temporary files to free up disk space
cleanup_temp_files() {
  rm -rf /tmp/*
}

cleanup_temp_files
